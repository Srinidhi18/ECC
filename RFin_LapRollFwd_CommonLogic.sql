/*  
use misdb_trg                                        
Author: Santhosh Kumar S                                        
  
  
EXEC RFin_LapRollFwd_CommonLogic 'TEST','Ramcouser','ECC','CEM','%',null,'','CHOCAP/000551/2020'                            
  
  
--Common Logic for Lapsing Report and RollForward Report                            
Used in RFin_Fixed_lapsing_report,RFin_Fixed_RollForward_report sp's  
  
*/  
  
  
CREATE Procedure RFin_LapRollFwd_CommonLogic   
@guid varchar(100)                        
 ,@userid varchar(100)                        
 ,@company   varchar(20)                              
 ,@bu     varchar(20)         = null                        
 ,@Ou     varchar(20)    = null                        
 ,@fb     varchar(20)         = null                        
 ,@fin_yr    varchar(20)      = null                        
 ,@fin_period   varchar(25)   = null                    
 ,@Option  varchar(20)= null                    
 ,@asset_class   varchar(25)  = null                        
 ,@proposal_no   Varchar(30)  = null                        
As                                            
Begin                                            
                                
Set NoCount On                            
--Select TOp(1) * From MISTEMP                          
--return                          
Drop table if exists #CWIP_Tran                          
Drop table if exists #CWIP                          
Drop table if exists #CAP                          
Drop table if exists  #repsfam_assetclass_dtl_ritsl                        
  
              
 --Declare @asset_class   varchar(25)  = null                            
 --Declare @proposal_no   Varchar(30)  = null                 
              
Declare @m_errorid   int                                            
Declare @currency_code  Nvarchar(10)                                            
Declare @ctxt_user   Nvarchar(30)                         
Declare @ctxt_ouinstance int                        
Declare @From_date date                           
Declare @To_date date                         
                        
IF @asset_class='' OR @asset_class='%'                            
SELECT @asset_class=NULL                            
                            
IF @proposal_no='' OR @proposal_no='%'                            
SELECT @proposal_no=NULL                            
                          
IF @fin_period='' OR @fin_period='%'                            
SELECT @fin_period=NULL                         
                        
IF @fin_yr='' OR @fin_yr='%'                            
SELECT @fin_yr=NULL                        
                        
IF @fb='' OR @fb='%'   or @fb = 'ALL'                          
SELECT @fb=NULL                
            
IF @Ou='' OR @Ou='%'   or @Ou = 'ALL'   or @Ou = '%%'           
SELECT @Ou=null           
            
                        
If @fin_yr is null                        
Begin                
 Declare @FAinstallDate date                                    
                         
 Select @FAinstallDate = parameter_value                        
 From scmdb..ips_processparam_vw A  (nolock)                          
 where parameter_code = 'FAINSTALLDATE'                        
 and company_code = @company                        
                         
 select  @From_date = min(finprd_startdt)                                         
 from scmdb..as_finperiod_dtl (nolock)            
 where legacy_date = 'NO'                                
 and @FAinstallDate  <=Convert(date,finprd_startdt)                        
                         
 Select @To_date = convert(date,getdate())                        
End                        
Else if @fin_period is null                          
Begin                          
 Select  @From_date = finyr_startdt       
 ,@To_date   = finyr_enddt                          
 From scmdb..as_finyear_hdr(nolock)                          
 Where   finyr_code = @fin_yr                                            
  if @To_date > getdate()                    
  Select @To_date = convert(date,getdate())                     
                    
End                          
Else                          
Begin                        
 Select  @From_date = finprd_startdt                          
 ,@To_date   = finprd_enddt                          
 From scmdb..as_finperiod_dtl(nolock)                          
 Where   finyr_code = @fin_yr                          
 and finprd_code = @fin_period                        
                     
 if @To_date > getdate()                    
  Select @To_date = convert(date,getdate())                     
End                          
                     
If @Option = 'MTD' and @fin_period is not null                    
Begin                    
 Select  @From_date = finprd_startdt                          
 From scmdb..as_finperiod_dtl(nolock)                          
 Where   finyr_code = @fin_yr                          
 and finprd_code = @fin_period                          
                    
End                    
Else IF @Option = 'YTD' and @fin_yr is not null                    
Begin                    
 Select  @From_date = finyr_startdt                          
 From scmdb..as_finyear_hdr(nolock)                          
 Where   finyr_code = @fin_yr                          
End                    
Else                    
Begin                    
Select @From_date = @From_date                    
End                    
--Select @From_date,@To_date                    
                    
Select @ctxt_user = @userid                                          
SELECT @ctxt_ouinstance = isnull(@Ou,'101')                      
                        
  select @currency_code  = isnull(currency_code,'php')                                                          
  from  scmdb..emod_company_currency_map (nolock)                                                       
  where company_code = @company                                                       
  and currency_flag = 'B'                           
                  
select                         
convert(varchar(40),null)  'proposal_no'                        
,convert(varchar(40),'##')  'asset_class'                        
,convert(varchar(40),'##')  'asset_number'                        
,convert(varchar(1000),'##')  'asset_desc'                        
,convert(varchar(40),'##')  'tag_number'                        
,convert(varchar(1000),'##')  'tag_desc'                        
,convert(varchar(1000),'##')  'Asset_location'                        
,convert(varchar(1000),'##')  'Asset_Status'                        
,convert(varchar(40),null)  'account_type'                        
,Case When A.drcr_flag = 'DR' then 'Addition' else  'Subtraction' end 'Flag'                        
,A.document_no                         
,A.tran_ou                         
,A.fb_id                        
,A.account_code                         
,A.drcr_flag                          
,A.tran_type                        
,A.tran_date                        
,A.posting_date                        
,A.currency_code                        
,A.base_amount                        
,A.company_code                        
,A.bu_id               
,A.cost_center                        
,isnull(modifieddate,createddate) 'modifieddate'                        
,Convert(int,2) 'SortOrder'                        
,convert(numeric(28,2),null) 'Opening_Balance'                        
,convert(numeric(28,2),null) 'CPIP_Addition'                        
,convert(numeric(28,2),null) 'CPIP_settlement'                         
,convert(numeric(28,2),null) 'Cap_value'     
,convert(numeric(28,2),null) 'Dispose_transfer'                         
,convert(numeric(28,2),null) 'Net_Asset_Cost'                        
--,convert(numeric(28,8),null) 'Opening_DEP'                        
--,convert(numeric(28,8),null) 'Period_Dep'                         
--,convert(numeric(28,8),null) 'Closing_Dep'                        
Into #CWIP_Tran                        
from scmdb.dbo.fbp_posted_trn_dtl (nolock) A                        
Where A.account_code  in (Select distinct account_code From Scmdb..ard_asset_account_mst mst with(nolock)                        
Where mst.company_code = @company                        
and mst.fb_id = isnull(@fb,mst.fb_id)                        
and mst.asset_usage in ('CWIP'))                        
ANd  A.company_code = @company                        
and A.bu_id    = @bu                        
                        
                        
                        
Update A                        
Set                        
asset_class = B.asset_class                        
,asset_number = B.asset_number                        
,proposal_no = B.proposal_no                        
,account_type = B.account_type                        
From #CWIP_Tran A                        
inner Join (Select A.component_id,A.company_code,A.asset_class,A.fb_id                        
  ,A.asset_number,A.tran_type,A.proposal_no                        
  ,A.account_code,A.account_type,A.drcr_flag,A.currency,A.tran_number 'TransNO',A.tran_ou 'TransOU'                        
  From Scmdb..ainq_cwip_accounting_info (nolock) A                        
  group by A.component_id,A.company_code,A.asset_class,A.fb_id                        
  ,A.asset_number,A.tran_type,A.proposal_no                        
  ,A.account_code,A.account_type,A.drcr_flag,A.currency,A.tran_number,A.tran_ou) B                        
on  B.TransNO  = A.document_no                         
and B.TransOU  = A.tran_ou                          
and B.account_code = A.account_code                         
and B.drcr_flag  = A.drcr_flag                        
and B.fb_id   = A.fb_id                        
and B.company_code = A.company_code                        
                        
Update A                        
Set proposal_no = B.gr_lin_proposalid                        
From #CWIP_Tran A                        
inner Join (Select gr_hdr_ouinstid,gr_hdr_grno,gr_hdr_grdate,gr_hdr_orderno,gr_hdr_grstatus                        
   ,gr_hdr_orderou,gr_hdr_orderdoc,gr_lin_orderlineno                        
   ,gr_lin_grlineno,gr_lin_proposalid                        
   From Scmdb..gr_hdr_grmain A(Nolock)                        
   inner join Scmdb..gr_lin_details B(Nolock)                        
   on  A.gr_hdr_ouinstid = B.gr_lin_ouinstid                        
   and A.gr_hdr_grno  = B.gr_lin_grno                        
   and A.gr_hdr_grstatus not in ('DL','RE')                        
   and A.gr_hdr_orderdoc = 'PO'                        
   and B.gr_lin_proposalid is not null) B                        
on  B.gr_hdr_grno   = A.document_no                         
and B.gr_hdr_ouinstid  = A.tran_ou                      
Where A.proposal_no is null                      
                
Update A                        
Set proposal_no = B.proposal_no                        
From #CWIP_Tran A                        
inner Join (Select  A.ou_id,A.voucher_number,B.proposal_no                
   from scmdb..acap_journal_hdr(nolocK) A                
   Inner join scmdb..acap_journal_dtl(nolock) B                
   on  A.ou_id    = B.ou_id               and A.voucher_number = B.voucher_number                
   Where A.journal_status = 'AC'                
   and account_code in (Select distinct account_code From Scmdb..ard_asset_account_mst mst with(nolock)                        
   Where mst.company_code = @company      
   and mst.fb_id = isnull(@fb,mst.fb_id)                        
   and mst.asset_usage in ('CWIP'))                
   group by A.ou_id,A.voucher_number,B.proposal_no) B                        
on  B.voucher_number   = A.document_no                         
and B.ou_id  = A.tran_ou                      
Where A.proposal_no is null                    
                        
Update A                        
Set proposal_no = isnull(proposal_no,'Proposal_NA')                        
,asset_class = isnull(asset_class,'##')                        
,asset_number = isnull(asset_number,'##')                        
,account_type = isnull(account_type,'##')                        
,tag_number = isnull(tag_number,'##')                        
From #CWIP_Tran A                        
                        
/*                        
Update A                        
Set                        
proposal_no = B.proposal_number                        
From #CWIP_Tran A                        
inner Join (Select                         
    A.ou_id                        
   ,A.voucher_no                        
   ,APLAN.proposal_number                        
   from jv_voucher_trn_dtl  A(nolock)                        
   inner join jv_voucher_trn_hdr B(nolock)                        
   on  A.ou_id   = B.ou_id                        
   and A.voucher_no = B.voucher_no                        
   inner join (Select proposal_number From aplan_acq_proposal_hdr APLAN(nolock)) APLAN                        
   on B.remarks like '%'+APLAN.proposal_number+'%'                        
   Where A.account_code = '160090-000'                        
   and B.voucher_status = 'AUT'                        
) B                        
on  B.voucher_no = A.document_no                         
and B.ou_id  = A.tran_ou                         
Where A.proposal_no is null                 
*/                        
/*                        
Select distinct tran_type from #CWIP_Tran                        
Where proposal_no is null                        
and tran_type <> 'BK_JV'                        
                        
Select * from #CWIP_Tran                        
Where proposal_no is null                        
and tran_type <> 'BK_JV'                        
                        
*/                        
                        
--Select *                         
--from #CWIP_Tran                        
--Where proposal_no = 'CHOCAP/000506/2020'                        
--order by proposal_no,posting_date,modifieddate                        
--return                        
                        
                        
Select * into #CWIP From #CWIP_Tran Where 1<>1                        
                        
                        
Insert into #CWIP(proposal_no,asset_class,asset_number,asset_desc,tag_number                        
,tag_desc,Asset_location,Asset_Status,account_type,Flag                        
,document_no,tran_ou,fb_id,account_code,drcr_flag,tran_type,tran_date,posting_date                        
,currency_code,base_amount,company_code,bu_id,cost_center,modifieddate,SortOrder                        
,Opening_Balance)                        
Select proposal_no,'##','##','##','##','##','##','##','##','Consolidate'                        
,proposal_no,tran_ou,fb_id,account_code,'DR','Asset Proposal',dateadd(dd,-1,@From_date),dateadd(dd,-1,@From_date)                        
,min(currency_code)                        
,0                        
,company_code                        
,bu_id                        
,'##'                        
,min(modifieddate)                        
,1                        
,0 'Opening_Balance'                        
from #CWIP_Tran                        
group by proposal_no,account_code,tran_ou,fb_id,company_code,bu_id                        
                        
Insert into #CWIP                      
Select *                        
from #CWIP_Tran                        
Where posting_date between  @From_date and @To_date                        
--and Flag <>'Addition'              
--and Flag not in ('Addition'  ,'Subtraction')                      
                        
Update A                        
Set Opening_Balance = isnull(B.Opening_Balance,0)                        
,base_amount = isnull(B.Opening_Balance,0)                        
From #CWIP A                        
,(Select proposal_no,account_code,tran_ou                        
,Sum(case When drcr_flag = 'DR' then base_amount else -1*base_amount end) 'Opening_Balance'                        
From #CWIP_Tran             
Where posting_date < @From_date                         
Group by proposal_no,account_code,tran_ou) B                        
Where   A.proposal_no = B.proposal_no                        
and  A.account_code = B.account_code                        
and  A.tran_ou  = B.tran_ou               
and  A.Flag = 'Consolidate'                        
                        
Update A                        
Set CPIP_Addition = isnull(B.CPIP_Addition,0)                        
,CPIP_settlement  = isnull(B.CPIP_settlement,0)                        
From #CWIP A                        
,(Select proposal_no,account_code,tran_ou                        
,Sum(case When drcr_flag = 'DR' and tran_type <> 'FA_RACAP' then 1*base_amount                    
     Else 0 end) 'CPIP_Addition'                        
,Sum(case When drcr_flag = 'DR' and tran_type = 'FA_RACAP' then 1*base_amount                    
    When drcr_flag = 'CR' then -1*base_amount Else 0 end) 'CPIP_settlement'                        
From #CWIP_Tran                        
Where posting_date between  @From_date and @To_date                        
Group by proposal_no,account_code,tran_ou) B                        
Where   A.proposal_no = B.proposal_no                        
and  A.account_code = B.account_code                        
and  A.tran_ou  = B.tran_ou                        
and  A.Flag = 'Consolidate'                        
                        
Update A                        
Set Net_Asset_Cost   = isnull(A.Opening_Balance,0)+isnull(A.CPIP_Addition,0)+isnull(A.CPIP_settlement,0)                        
,CPIP_Addition  = isnull(A.CPIP_Addition,0)                        
,CPIP_settlement = isnull(A.CPIP_settlement,0)                        
From #CWIP A                        
Where A.Flag = 'Consolidate'                        
                        
/*                       
Select A.*                         
,B.tag_number 'CAP_tag_number'                        
,B.account_code 'CAP_account_code'                        
,B.drcr_flag 'CAP_drcr_flag'                        
,B.posting_date 'CAP_posting_date'                        
,B.fb_id  'CAP_fb_id'                        
,B.base_amount 'CAP_base_amount'                        
Into #CAP                        
from #CWIP A                        
Left Join (Select tran_number,ou_id,asset_number,drcr_flag,tag_number,account_code,posting_date,fb_id                        
,sum(base_amount) 'base_amount'                        
From Scmdb..acap_accounting_info_dtl(NOLOCK)                        
group by tran_number,ou_id,asset_number,drcr_flag,tag_number,account_code,posting_date,fb_id)B                        
on  A.document_no = B.tran_number                        
and A.tran_ou  = B.ou_id                        
and A.asset_number = B.asset_number                        
and A.fb_id = B.fb_id                        
and B.drcr_flag = 'DR'       
                        
Update A                        
Set Cap_value = CAP_base_amount                        
,account_code = CAP_account_code                        
,drcr_flag = CAP_drcr_flag                        
,posting_date = CAP_posting_date  
,tag_number =CAP_tag_number                        
From #CAP A                        
Where posting_date between  @From_date and @To_date                        
and CAP_account_code is not null                        
                        
Update A                        
Set proposal_no = isnull(proposal_no,'Proposal_NA')                        
,asset_class = isnull(asset_class,'##')                        
,asset_number = isnull(asset_number,'##')                        
,account_type = isnull(account_type,'##')                        
,tag_number = isnull(tag_number,'##')                        
From #CAP A                   
                        
                        
update A                        
Set asset_class = asset_class_code                        
From #CAP A                        
inner join Scmdb..aplan_acq_proposal_hdr B(nolock)                        
on A.proposal_no  = B.proposal_number                        
and A.fb_id = B.fb_id                        
                        
                        
update A                        
Set account_type = ctrl_acctype                        
From #CAP A                        
inner join Scmdb..as_opaccount_dtl(nolock) B                        
on A.account_code = B.account_code                        
inner join Scmdb..as_opcoaid_hdr(nolock) C                        
on B.opcoa_id = C.opcoa_id                        
and A.company_code = C.rescomp_code                        
Where B.account_status = 'A'                        
and isnull(A.account_type,'##') = '##'                        
                        
update A                  
Set asset_desc  = B.asset_desc                        
,tag_desc   = B.tag_desc                        
,Asset_location  = B.asset_location                        
,Asset_Status  = B.tag_status                        
,cost_center  = B.cost_center                        
From #CAP A                        
inner join Scmdb..acap_asset_tag_dtl(nolock) B                        
on  B.cap_number = A.document_no                        
and B.asset_number = A.asset_number                        
and B.tag_number = A.tag_number                        
and B.fb_id   = A.fb_id                        
and B.ou_id   = A.tran_ou                        
Where A.asset_number is not null                        
and A.tag_number <> '##'                        
                        
                        
Select bu_id,company_code,ou_id,fb_id,asset_number,tag_number,posting_date                        
,account_code,drcr_flag,currency,cost_center,account_type                        
,depr_book,sum(base_amount) 'base_amount'                        
,convert(numeric(28,8),null) 'Opening_DEP'                        
,convert(numeric(28,8),null) 'Period_Dep'                        
,convert(numeric(28,8),null) 'Closing_Dep'                         
into #DEPTran                        
From Scmdb..adepp_accounting_info_dtl(NOLOCK)                        
Where account_type ='DEPACCOUNT'                        
group by bu_id,company_code,ou_id,fb_id,asset_number,tag_number,posting_date                        
,account_code,drcr_flag,currency,fb_id,cost_center,account_type                        
,depr_book                        
                        
Select * into #DEP From #DEPTran Where 1<>1                        
                        
Insert into #DEP(bu_id,company_code,ou_id,fb_id,asset_number,tag_number,posting_date                        
,account_code,drcr_flag,currency,cost_center,account_type                        
,depr_book,base_amount,Opening_DEP,Period_Dep,Closing_Dep)                        
Select bu_id,company_code,ou_id,fb_id,asset_number,tag_number,dateadd(dd,-1,@From_date)                        
,account_code,'DR',currency,'##',account_type                        
,depr_book,0,0,null,0                        
from #DEPTran A         
Where  A.company_code = @company                        
and A.bu_id    = @bu                        
group by bu_id,company_code,ou_id,fb_id,asset_number,tag_number                        
,account_code,currency,fb_id,account_type,depr_book                        
                        
                        
Update A                        
Set Opening_DEP = isnull(B.Opening_DEP,0)                        
From #DEP A                        
,(Select bu_id,company_code,ou_id,fb_id,asset_number,tag_number,account_code                        
,Sum(case When drcr_flag = 'DR' then base_amount else -1*base_amount end) 'Opening_DEP'                        
From #DEPTran                        
Where posting_date < @From_date                         
Group by bu_id,company_code,ou_id,fb_id,asset_number,tag_number,account_code) B                        
Where       
    A.asset_number = A.asset_number                         
and A.tag_number = A.tag_number                        
and A.ou_id   = A.ou_id                        
and A.fb_id   = A.fb_id                        
and A.account_code = A.account_code                        
and A.bu_id = B.bu_id                        
and A.company_code = B.company_code                        
                        
                        
Update A                        
Set Period_Dep = isnull(B.Period_Dep,0)                        
From #DEP A                        
,(Select bu_id,company_code,ou_id,fb_id,asset_number,tag_number,account_code                        
,Sum(case When drcr_flag = 'DR' then base_amount else -1*base_amount end) 'Period_Dep'                        
From #DEPTran                        
Where posting_date between @From_date  and @To_date                        
Group by bu_id,company_code,ou_id,fb_id,asset_number,tag_number,account_code) B                        
Where                         
    A.asset_number = B.asset_number                         
and A.tag_number = B.tag_number                        
and A.ou_id   = B.ou_id                        
and A.fb_id   = B.fb_id                        
and A.account_code = B.account_code                        
and A.bu_id = B.bu_id                  
and A.company_code = B.company_code                        
              
Update A                        
Set Closing_Dep = isnull(A.Opening_DEP,0)+isnull(A.Period_Dep,0)                        
From #DEP A                        
                        
Update A                        
Set Opening_DEP  = B.Opening_DEP                        
,Period_Dep  = B.Period_Dep                        
,Closing_Dep = B.Closing_Dep                        
From #CAP A                        
inner join  #DEP B                        
on    A.asset_number = B.asset_number                         
and A.tag_number = B.tag_number                        
and A.tran_ou   = B.ou_id                        
and A.fb_id   = B.fb_id                        
and A.bu_id = B.bu_id                        
and A.company_code = B.company_code                        
Where A.asset_number is not null                        
and A.tag_number <> '##'                        
--Where A.proposal_no = 'CHOCAP/000064/2020'                        
                        
                        
                        
Select proposal_no,asset_class,asset_number,asset_desc,tag_number,tag_desc,account_type                        
,asset_location,Asset_Status,Flag                        
,document_no,tran_ou,fb_id,cost_center,account_code,drcr_flag,tran_type                        
,tran_date,posting_date                        
,currency_code,base_amount,company_code,bu_id,modifieddate,SortOrder                        
,Opening_Balance,CPIP_Addition,CPIP_settlement,Cap_value                        
,Dispose_transfer,Net_Asset_Cost,isnull(Opening_DEP,0) 'Opening_DEP'                        
,isnull(Period_Dep,0) 'Period_Dep'                        
,isnull(Closing_Dep,0) 'Closing_Dep'                        
From #CAP A                        
Where 1=1                        
and A.company_code = @company                        
and A.bu_id   = @bu                        
and A.tran_ou  = isnull(@ou,A.tran_ou)                        
and A.proposal_no = isnull(@proposal_no,A.proposal_no)                        
and A.fb_id   = isnull(@fb,A.fb_id)                         
and A.asset_class = isnull(@asset_class,A.asset_class)                          
order by A.proposal_no,A.posting_date,A.modifieddate,A.SortOrder,A.CAP_tag_number                        
 */                       
--Select * from #CWIP                        
                        
                      
--Fixed Asset register Logic                                            
create table #repsfam_assetclass_dtl_ritsl                                            
 (                                            
 tran_number     nvarchar(18),                                    
 tran_type     nvarchar(40),                                            
 asset_number    nvarchar(18),                                            
 tag_number     int,                                            
 account_code    nvarchar(32),                                            
 drcr_flag     nvarchar(6),                                            
 ou_id      int,                                            
 tran_date     datetime,                                       
 posting_date    datetime,                                            
 currency     nvarchar(5),                                            
 tran_amount     numeric(28,8),                                            
 fb_id      nvarchar(20),                                            
 cap_date     datetime,                                            
 company_code    nvarchar(10) ,                                            
 account_type    nvarchar(40),                                            
 depr_book     nvarchar(20),                                            
 finyr_code      nvarchar(10),                                             
 finprd_code     nvarchar(15),                                            
 asset_class     nvarchar(20) ,                                
 asset_group     nvarchar(25) ,                                            
 --asset_group_desc  nvarchar(25) ,                              
 asset_group_desc   nvarchar(40) ,                                            
 asset_desc     nvarchar(40),                                            
 tag_desc     nvarchar(40),                                            
 asset_class_desc   nvarchar(40),                             
 Addition_capital_cost  numeric(28,2),                                            
 Addition_Transfer_cost  numeric(28,2),                                            
 Addition_Revaluation_cost numeric(28,2),                                             
 Addition_Capital_Depr  numeric(28,2),                                            
 Addition_Transfer_Depr  numeric(28,2),                                            
 Addition_Reval_Depr   numeric(28,2),                                            
 Deletion_Capital_cost  numeric(28,2),                                            
 Deletion_Retirement_cost numeric(28,2),                                             
 Deletion_Transfer_cost  numeric(28,2),                                            
 Deletion_Revaluation_cost numeric(28,2),                                            
 Deletion_Retirement_Depr numeric(28,2),                                            
 Deletion_Transfer_Depr  numeric(28,2),                                            
 Deletion_Reval_Depr   numeric(28,2),                               
 Deletion_Capital_Depr  numeric(28,2),                                            
 open_capital_Cost    numeric(28,2),                                             
 open_reval_Cost    numeric(28,2),                                            
 open_capital_Depr    numeric(28,2),                                             
 open_reval_depr    numeric(28,2),                                            
 Addition_Capital_imp  numeric(28,2),                                            
 Addition_Transfer_imp  numeric(28,2),                                            
 Addition_Reval_imp      numeric(28,2),                                            
 Deletion_Retirement_imp  numeric(28,2),                                            
 Deletion_Transfer_imp  numeric(28,2),                                            
 Deletion_Reval_imp    numeric(28,2),                                            
 Deletion_Capital_imp    numeric(28,2),                                            
 open_capital_imp  numeric(28,2),                                             
 open_reval_imp      numeric(28,2),                                             
 cwip_amount     numeric(28,2),                                           
 createddate     datetime,                                            
 op_debit_cost     numeric(28,2),                                            
 period_debit_cost    numeric(28,2),                                            
 period_credit_cost    numeric(28,2),                                            
 op_credit_Depr     numeric(28,2),                                            
 cop_credit_Depr     numeric(28,2),                                            
 cop_debit_Depr     numeric(28,2),                                            
 op_credit_imp    numeric(28,2),                                            
 cop_credit_imp    numeric(28,2),                                            
 cop_debit_imp    numeric(28,2)                                            
 )                                            
                                            
insert into [scmtempdb].[dbo].rep_fb_id_tmp(guid,fb_id)                                             
select distinct @guid,fb_id                                            
from scmdb..emod_fbmapcompou_vw(nolock)                                            
where 1=1--sourceouinstid   = @ctxt_ouinstance                                            
and fb_type   = 'PF'                                            
--and sourcecomponentname  = 'REP'                                            
and bu_id    = isnull(null,bu_id)                                    
                        
--if @fin_period is null                          
--Begin                          
--Select  @From_date = finyr_startdt                          
--,@To_date   = finyr_enddt                          
--From scmdb..as_finyear_hdr(nolock)                          
--Where   finyr_code = @fin_yr                          
--End                          
--Else                          
--Begin                          
--Select  @From_date = finprd_startdt                          
--,@To_date   = finprd_enddt                          
--From scmdb..as_finperiod_dtl(nolock)                          
--Where   finyr_code = @fin_yr                          
--and finprd_code = @fin_period                          
--End                          
                                  
                                
                        
                                
  --@asset_class                        
insert into #repsfam_assetclass_dtl_ritsl                                            
Exec scmdb..ritsl_repsfam_assetwise_cmnsp                                            
@ctxt_user,NULL,NULL,NULL,'CORP',@company,@asset_class,@asset_class,NULL,NULL,@fb,@currency_code                                            
,@To_date,@guid,'REPSCHE',NULL,NULL,NULL,NULL,NULL,null                                            
,@From_date,@To_date,@m_errorid,@ctxt_ouinstance                                                             
                         
Update #repsfam_assetclass_dtl_ritsl                                            
Set Addition_capital_cost =  isnull(Addition_capital_cost,0)                                            
, Addition_Transfer_cost =  isnull(Addition_Transfer_cost,0)                                            
, Addition_Revaluation_cost =  isnull(Addition_Revaluation_cost,0)                                            
, Addition_Capital_Depr =  isnull(Addition_Capital_Depr,0)                                            
, Addition_Transfer_Depr =  isnull(Addition_Transfer_Depr,0)                                            
, Addition_Reval_Depr = isnull(Addition_Reval_Depr,0)                                            
, Deletion_Capital_cost =  isnull(Deletion_Capital_cost,0)                                            
, Deletion_Retirement_cost =  isnull(Deletion_Retirement_cost,0)                                            
, Deletion_Transfer_cost =  isnull(Deletion_Transfer_cost,0)                                            
, Deletion_Revaluation_cost =  isnull(Deletion_Revaluation_cost,0)    
, Deletion_Retirement_Depr =  isnull(Deletion_Retirement_Depr,0)                                            
, Deletion_Transfer_Depr =  isnull(Deletion_Transfer_Depr,0)                                            
, Deletion_Reval_Depr =  isnull(Deletion_Reval_Depr,0)                                            
, Deletion_Capital_Depr =  isnull(Deletion_Capital_Depr,0)                                            
, open_capital_Cost  =  isnull(open_capital_Cost ,0)                                            
, open_reval_Cost =  isnull(open_reval_Cost,0)                                            
, open_capital_Depr  =  isnull(open_capital_Depr ,0)                                            
, open_reval_depr =  isnull(open_reval_depr,0)                                            
, Addition_Capital_imp =  isnull(Addition_Capital_imp,0)                                            
, Addition_Transfer_imp =  isnull(Addition_Transfer_imp,0)                                            
, Addition_Reval_imp =  isnull(Addition_Reval_imp,0)                            
, Deletion_Retirement_imp  =  isnull(Deletion_Retirement_imp ,0)                                            
, Deletion_Transfer_imp =  isnull(Deletion_Transfer_imp,0)                                            
, Deletion_Reval_imp   =  isnull(Deletion_Reval_imp  ,0)                                            
, Deletion_Capital_imp   =  isnull(Deletion_Capital_imp  ,0)                                            
, open_capital_imp  =  isnull(open_capital_imp ,0)                                            
, open_reval_imp    =  isnull(open_reval_imp   ,0)                                            
, cwip_amount =  isnull(cwip_amount,0)                                            
, op_debit_cost =  isnull(op_debit_cost,0)                                            
, period_debit_cost =  isnull(period_debit_cost,0)                                            
, period_credit_cost =  isnull(period_credit_cost,0)                                            
, op_credit_Depr =  isnull(op_credit_Depr,0)                                            
, cop_credit_Depr =  isnull(cop_credit_Depr,0)                                            
, cop_debit_Depr =  isnull(cop_debit_Depr,0)                                            
, op_credit_imp =  isnull(op_credit_imp,0)                                            
, cop_credit_imp =  isnull(cop_credit_imp,0)                                            
, cop_debit_imp =  isnull(cop_debit_imp,0)                                            
                               
               
Select *                                             
,convert(numeric(28,2),0)'Closing_cost'                  
,convert(numeric(28,2),0)'Closing_Depr'                                            
,convert(numeric(28,2),0)'Closing_imp'                                            
,convert(numeric(28,2),0)'Net_Closing'                                            
,convert(numeric(28,2),0)'Net_Opening'                                            
,convert(date,null) 'Date_of_Purchase'                                            
,convert(nvarchar(100),null)'AssetLocation'                                            
,convert(nvarchar(36),null) 'Legacy_Asset_Number'                   
,convert(nvarchar(154),null) 'custodian'                                            
,convert(nvarchar(40),null) 'Tag_Status'                                            
,convert(nvarchar(20),null) 'Cost_Center'                                            
,convert(nvarchar(36),null) 'Proposal_Number'                                            
,convert(numeric(28,2),0) 'RatePerUseful_Life'                                            
,convert(numeric(28,2),0) 'tag_cost'                                            
,convert(numeric(28,2),0) '95PercValues'                                            
,convert(nvarchar(80),null) 'Depr_category'                                        
/*JPE-930 - Code Added by Anitha R 2021-07-26*/                                        
                                        
,convert(date,null) 'Retirement_Date'                          
,convert(numeric(28,2),0) 'sale_value'                                            
,convert(numeric(28,2),0) 'gain_loss'                                          
,convert(nvarchar(36),null) 'invoice_number'                          
,convert(nvarchar(36),null) 'finyear_code'                                        
                                        
/*JPE-930 - Code Added by Anitha R 2021-07-26*/                                        
,convert(nvarchar(36),null) 'Cap_number'                                         
into #repsfam_assetclass_dtl_ritsl_Final                                            
From #repsfam_assetclass_dtl_ritsl                                            
                                            
                                            
Update #repsfam_assetclass_dtl_ritsl_Final                                            
set                                             
 Closing_imp = (isnull(op_credit_imp,0)+isnull(cop_credit_imp,0)-isnull(cop_debit_imp,0))                                            
,Closing_Depr = (isnull(op_credit_Depr,0)+isnull(cop_credit_Depr,0)-isnull(cop_debit_Depr,0))                                            
,Closing_cost = (isnull(op_debit_cost,0)+isnull(period_debit_cost,0)-isnull(period_credit_cost,0))                                            
                                            
Update #repsfam_assetclass_dtl_ritsl_Final                                            
set Net_Opening = (isnull(op_debit_cost,0)-isnull(op_credit_Depr,0))                                             
, Net_Closing = (isnull(Closing_cost,0)-isnull(Closing_Depr,0))                                             
                                            
                                            
Update T                                              
Set  [Legacy_Asset_Number] = Hdr.[Legacy_Asset_Number]                                              
From #repsfam_assetclass_dtl_ritsl_Final   T                                              
Join Scmdb..Amig_Asset_Tag_Hdr Hdr (NoLock)                                              
On  T.Asset_Number  = Hdr.Asset_Number                                             
                                            
Update T                                              
Set  [Date_of_Purchase] = Dtl.InService_Date,                                              
[AssetLocation]  = Dtl.Asset_Location,                         
[Cost_Center]  = Dtl.cost_center,                                            
[Depr_category]  = Dtl.depr_category,              
[Proposal_Number] = Dtl.proposal_number,                          
[Cap_number]  = Dtl.cap_number--,                      
--[tag_cost]   = DTl.tag_cost                                          
From #repsfam_assetclass_dtl_ritsl_Final    T                                              
Join Scmdb..ACap_Asset_Tag_Dtl Dtl (NoLock)                                              
On  T.Asset_Number   = Dtl.Asset_Number                                              
And  T.Tag_Number   = Dtl.Tag_Number                                              
Where Dtl.Fb_Id    = (Case When @fb is null Then  Dtl.Fb_Id Else @fb End)                                             
                                            
Update T                                            
Set  [tag_cost]   = DTl.tag_cost                                          
From #repsfam_assetclass_dtl_ritsl_Final    T                                            
Join (Select Asset_Number,Tag_Number,Fb_Id,Sum(tag_cost) 'tag_cost'            
From Scmdb..ACap_Asset_Tag_Dtl Dtl (NoLock)              
group by Asset_Number,Tag_Number,Fb_Id)DTL            
On  T.Asset_Number   = Dtl.Asset_Number                                            
And  T.Tag_Number   = Dtl.Tag_Number               
Where Dtl.Fb_Id    = (Case When @fb is null Then  Dtl.Fb_Id Else @fb End)            
                                         
            
Update T1                                              
Set  T1.[AssetLocation]   = Loc.Loc_Desc                                              
From #repsfam_assetclass_dtl_ritsl_Final      T1                                               
Join Scmdb..Aloc_Location_Mst Loc (NoLock)                                              
On  T1.[AssetLocation]   = Loc.Loc_Code                                              
                                 
update T1                                              
set  T1.custodian     =  ainq.custodian                                             
from #repsfam_assetclass_dtl_ritsl_Final  T1                                              
inner join scmdb..ainq_asset_tag_dtl ainq(nolock)                                               
on T1.[Tag_Number] = ainq.tag_number                                             
and T1.[asset_number] = ainq.asset_number                                              
                                          
 /*                                           
update T1                                              
set  T1.custodian     =  isnull(Emp.EmpName,T1.custodian)                                       
from #repsfam_assetclass_dtl_ritsl_Final  T1         
inner join hrms40..ckpl_employee_asset_details Ass (nolock)                                                
on T1.[asset_class] = Ass.asset_type                       
and T1.[asset_number] = Ass.asset_id                                             
and T1.[Tag_Number] = isnull(try_convert(int,Ass.size),'1')                                            
and @asondate >= date_of_issue                                             
and @asondate <= isnull(date_of_return,@asondate)                                            
left join hrms40..HR_empdetails_list Emp (nolock)                                              
on Emp.Empcode=Ass.emp_code                           
*/                          
--epin_employee                                            
--employee_info_Vw                                            
--Select * From hrms40..ckpl_employee_asset_details                                            
                                    
UPDATE T1                                            
SET Tag_Status   =met.parameter_text                                            
from #repsfam_assetclass_dtl_ritsl_Final  T1                                              
inner join scmdb..ainq_asset_tag_dtl ainq(nolock)                                               
on T1.[Tag_Number] = ainq.tag_number                                             
and T1.[asset_number] = ainq.asset_number                                             
inner join  scmdb..fin_quick_code_met  met(nolock)                                            
on   ainq.Tag_Status   = met.parameter_code                                            
and  met.component_id    = 'ACAP'                                  
AND  met.parameter_type   = 'CBO'                                            
AND  met.parameter_category  = 'AS_STA'                                            
AND  met.language_id    = 1                                            
                                            
/*JPE-930 - Code Added by Anitha R 2021-07-26*/                                        
                                        
UPDATE T1                                        
SET                                        
 T1.Retirement_Date = re.retirement_date                         
 ,sale_value  = re.sale_value                         
 ,gain_loss     = re.gain_loss                            
 ,invoice_number = re.invoice_number                        
from #repsfam_assetclass_dtl_ritsl_Final  T1          
inner join scmdb..ainq_asset_tag_dtl ainq(nolock)                                               
on T1.[Tag_Number] = ainq.tag_number                                             
and T1.[asset_number] = ainq.asset_number                      
inner join  scmdb..fin_quick_code_met  met(nolock)                          
on   ainq.Tag_Status   = met.parameter_code                                            
and  met.component_id    = 'ACAP'                                            
AND  met.parameter_type   = 'CBO'                                            
AND  met.parameter_category  = 'AS_STA'                              
AND  met.language_id    = 1                                         
JOIN scmdb.dbo.[adisp_retirement_dtl] re with(nolock) ON re.asset_number = ainq.asset_number                                         
 and re.tag_number = ainq.tag_number and re.ou_id = ainq.ou_id                                         
                                        
UPDATE T1                                        
SET                                        
T1.finyear_code = (                                        
  SELECT                                        
   vw.Finyr_code                                        
  FROM scmdb..as_finyearperiod_vw vw with(nolock)                                        
  WHERE vw.Company_code = T1.Company_code                                        
   and T1.Retirement_Date Between Cast(vw.finprd_startdt as date)                                         
       and Cast(vw.finprd_enddt as date)                                        
 )                                         
from #repsfam_assetclass_dtl_ritsl_Final  T1                                              
WHERE T1.Retirement_Date IS NOT NULL                                        
                                        
DECLARE @CurrentFinYr nvarchar(36)                                        
                                        
SELECT @CurrentFinYr = vw.Finyr_code                                        
FROM scmdb..as_finyearperiod_vw vw with(nolock)                                        
WHERE Cast(@To_date as date) Between Cast(vw.finprd_startdt as date) and Cast(vw.finprd_enddt as date)                                        
                                        
DELETE FROM #repsfam_assetclass_dtl_ritsl_Final WHERE ISNULL(finyear_code,finyr_code) <> @CurrentFinYr                            
                                          
/*JPE-930 - Code Added by Anitha R 2021-07-26*/                                        
                                        
update T1                                   
Set RatePerUseful_Life = HDR.useful_asset_life                                             
From #repsfam_assetclass_dtl_ritsl_Final  T1                                              
Join Scmdb..Adep_Assign_Rules_Mst Mst (NoLock)                                            
 On  T1.Depr_category = Mst.Depr_Category                                            
 Join Scmdb..Adep_Depr_Rule_Hdr Hdr (NoLock)                                            
 On  Mst.Depr_Rule_Number = Hdr.Depr_Rule_Number                                            
                                          
/*Added by Anitha R 2021-07-07*/                                           
                                          
update T1                                            
Set                                           
 RatePerUseful_Life = round(100/rt.depr_rate,1)                                          
From #repsfam_assetclass_dtl_ritsl_Final  T1                                              
Join Scmdb..Adep_Assign_Rules_Mst Mst (NoLock)                                            
 On  T1.Depr_category = Mst.Depr_Category                                            
Join Scmdb..Adep_Depr_Rule_Hdr Hdr (NoLock)                                         
 On  Mst.Depr_Rule_Number = Hdr.Depr_Rule_Number                                           
JOIN scmdb..adep_depr_rate_dtl rt (nolock) ON rt. asset_class = hdr.asset_class and rt.depr_rate_id = Hdr.depr_rate_id                          
WHERE T1.RatePerUseful_Life IS NULL                                           
                       
/*Added by Anitha R 2021-07-07*/                                          
                                            
update T1                                            
Set [95PercValues] = tag_cost*0.95                                            
From #repsfam_assetclass_dtl_ritsl_Final T1                                            
                                            
Update T1                                            
Set Account_Code = Ard.Account_Code                                            
From #repsfam_assetclass_dtl_ritsl_Final t1                                            
inner join Scmdb..Ard_Asset_Account_Mst Ard(NoLock)                                       
on t1.Asset_Class  = Ard.Asset_Class                                            
And t1.Fb_Id   = Ard.Fb_Id                                            
And Ard.Asset_Usage  = 'CAPASS'                                             
                        
                                            
 --Code Modified By Santhosh on 13112022 for ecc  starts                                      
Select ou_id                        
,asset_class                        
,asset_class_desc                        
,proposal_number                        
,Cap_number                        
,asset_number                        
,asset_desc                        
,tag_number                        
,tag_desc                        
,currency                        
,fb_id                        
,company_code                        
,depr_book                        
,Convert(varchar(10),Date_of_Purchase,101) Date_of_Purchase                        
,AssetLocation                        
,Legacy_Asset_Number                        
,Tag_Status                        
,Cost_Center                        
,tag_cost                    
,RatePerUseful_Life                
,Depr_category                        
,account_code                        
,Net_Opening 'Net_Opening'                             
,convert(numeric(28,8),null) 'CPIP_Addition'                          
,convert(numeric(28,8),null) 'CPIP_settlement'                         
,op_debit_cost 'Opening_Cost'                        
,op_credit_Depr+op_credit_imp 'Opening_Depr'               
,period_debit_cost-period_credit_cost 'Period_Cost'                          
,cop_credit_Depr-cop_debit_Depr+cop_credit_imp-cop_debit_imp 'Period_Depr'                
,period_debit_cost  'Period_Debit_Cost'                        
,period_credit_cost  'Period_Credit_Cost'               
,cop_credit_Depr+cop_credit_imp  'Period_Credit_Depr'               
,cop_debit_Depr+cop_debit_imp   'Period_Debit_Depr'                
,Closing_cost 'Closing_Cost'                        
,Closing_Depr+Closing_imp 'Closing_Depr'                        
,Net_Closing 'Net_Closing'                        
,Deletion_Retirement_Depr+Deletion_Retirement_imp-Deletion_Retirement_cost                         
 +Addition_Transfer_cost-Deletion_Transfer_cost+Deletion_Transfer_Depr-Addition_Transfer_Depr+Deletion_Transfer_imp-Addition_Transfer_imp 'DisposalValue'                        
,Convert(int,2) 'SortOrder'                         
,Convert(varchar(10),Retirement_Date,101) 'Retirement_Date'                        
,sale_value                         
,gain_loss                            
,invoice_number               
,convert(numeric(28,2),0)        'SubTitle1'              
,convert(numeric(28,2),0)        'SubTitle2'              
into #FINAL                        
From #repsfam_assetclass_dtl_ritsl_Final  A                        
Where isnull(A.proposal_number,'') = isnull(@proposal_no,isnull(A.proposal_number,''))                          
and A.fb_id   = isnull(@fb,A.fb_id)                          
order by asset_group,asset_class,asset_number,tag_number,Date_of_Purchase                                   
Delete From [scmtempdb].[dbo].rep_fb_id_tmp WHere guid =  @guid     
  
Insert Into #Final(ou_id,account_code,currency,fb_id,proposal_number,Net_Opening                   
,CPIP_Addition,CPIP_settlement,Net_Closing,SortOrder,company_code                    
,asset_class,asset_number,tag_number                    
,asset_class_desc,tag_desc,asset_desc,Cap_number                    
,depr_book                    
,AssetLocation,Legacy_Asset_Number,Tag_Status,Cost_Center,Depr_category)                    
Select tran_ou,account_code,currency_code,fb_id,proposal_no,Opening_Balance                    
,CPIP_Addition,CPIP_settlement,Net_Asset_Cost,1,company_code                    
,'CPIP','##','0','##','##','##','##','##','##'                    
,'##','##','##','##'                    
From #CWIP A                    
Inner  join (Select Distinct proposal_number                     
   From Scmdb..aplan_acq_proposal_dtl (nolock)                     
   WHere asset_class_code = isnull(@asset_class,asset_class_code)                    
   union                     
   Select isnull(@proposal_no,'Proposal_NA')                    
   )  B                    
on A.proposal_no = B.proposal_number                    
Where A.company_code = @company                      
and A.bu_id   = @bu                      
and A.tran_ou  = isnull(@ou,A.tran_ou)                      
and A.proposal_no = isnull(@proposal_no,A.proposal_no)                      
and A.fb_id   = isnull(@fb,A.fb_id)                      
and  A.Flag = 'Consolidate'   
  
Insert into Zrit_Lapsing_temp_table  
(guid,ou_id,asset_class,asset_class_desc,proposal_number,Cap_number,asset_number  
,asset_desc,tag_number,tag_desc,currency,fb_id,company_code,depr_book,Date_of_Purchase  
,AssetLocation,Legacy_Asset_Number,Tag_Status,Cost_Center,tag_cost,RatePerUseful_Life  
,Depr_category,account_code,Net_Opening,CPIP_Addition,CPIP_settlement,Opening_Cost  
,Opening_Depr,Period_Cost,Period_Depr,Period_Debit_Cost,Period_Credit_Cost,Period_Credit_Depr  
,Period_Debit_Depr,Closing_Cost,Closing_Depr,Net_Closing,DisposalValue,SortOrder,Retirement_Date  
,sale_value,gain_loss,invoice_number,SubTitle1,SubTitle2,insertdate)  
Select   
@guid,ou_id,asset_class,asset_class_desc,proposal_number,Cap_number,asset_number  
,asset_desc,tag_number,tag_desc,currency,fb_id,company_code,depr_book,Date_of_Purchase  
,AssetLocation,Legacy_Asset_Number,Tag_Status,Cost_Center,tag_cost,RatePerUseful_Life  
,Depr_category,account_code,Net_Opening,CPIP_Addition,CPIP_settlement,Opening_Cost  
,Opening_Depr,Period_Cost,Period_Depr,Period_Debit_Cost,Period_Credit_Cost,Period_Credit_Depr  
,Period_Debit_Depr,Closing_Cost,Closing_Depr,Net_Closing,DisposalValue,SortOrder,Retirement_Date  
,sale_value,gain_loss,invoice_number,SubTitle1,SubTitle2,getdate()  
From #Final  
  
Set Nocount Off  
End  

