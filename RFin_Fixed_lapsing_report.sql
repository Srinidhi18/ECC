Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                                  
use misdb_trg                                        
Author: Santhosh Kumar S                                        
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM','301','AKLFB','FY2022','OCT2022','',''                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2022','MAY2022','','CHOCAP/000787/2020'                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2022','JUN2022','','CHOCAP/000787/2020'                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2022','JUL2022','','CHOCAP/000787/2020'                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2022',null,'OFFX_OPEX',''                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2022',null,'PMAE_MANEX',''                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2022',null,'PMAE_MANEX','CHOCAP/000532/2020'                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2022',null,'PMAE_MANEX','CHOCAP/000726/2020'                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',201,null,'FY2021',null,'BLDG_OPEX',null                     
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',201,null,'FY2022',null,'BLDG_OPEX',null                     
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'',null,'','CHOCAP/000086/2020'                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',201,null,'FY2022',null,'OFEQ_OPEX','CHOCAP/000140/2020'                     
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2021',null,'','CHOCAP/000492/2020'                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2022',null,'','CHOCAP/000492/2020'                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2021',JUN2021,'','CHOCAP/000492/2020'                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2021',AUG2021,'','CHOCAP/000492/2020'                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2021','','MTD','TREQ_OPEX','CHOCAP/000007/2020'                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2021','','YTD','TREQ_OPEX','CHOCAP/000007/2020'                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2021','OCT2021','MTD','','CHOCAP/000086/2020'                       
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2021','OCT2021','YTD','','CHOCAP/000086/2020'                       
                    
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2021','Jul2021','MTD','','CHOCAP/000578/2020'                
EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',null,null,'FY2021','Jul2021','YTD','','CHOCAP/000578/2020'

EXEC RFin_Fixed_lapsing_report 'Ramcouser','ECC','CEM',AKL,AKLFB,'FY2022',NULL,'MTD','','' 
                
*/                                 
                        
CREATE Procedure RFin_Fixed_lapsing_report                     
 @userid varchar(100)                    
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
  
  
Declare @guid varchar(100) = newid()  
  
Exec RFin_LapRollFwd_CommonLogic  
 @guid   = @guid  
,@userid  = @userid  
,@company  = @company  
,@bu   = @bu  
,@Ou   = @Ou  
,@fb   = @fb  
,@fin_yr  = @fin_yr  
,@fin_period = @fin_period  
,@Option  = @Option  
,@asset_class = @asset_class  
,@proposal_no = @proposal_no  
  
  
  
Select   
ou_id  
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
,Date_of_Purchase  
,AssetLocation  
,Legacy_Asset_Number  
,Tag_Status  
,Cost_Center  
,tag_cost  
,RatePerUseful_Life  
,Depr_category  
,account_code  
,Net_Opening  
,CPIP_Addition  
,CPIP_settlement  
,Opening_Cost  
,Opening_Depr  
,Period_Cost  
,Period_Depr  
--,Period_Debit_Cost  
--,Period_Credit_Cost  
--,Period_Credit_Depr  
--,Period_Debit_Depr  
,Closing_Cost  
,Closing_Depr  
,Net_Closing  
,DisposalValue  
,SortOrder  
,Retirement_Date  
,sale_value  
,gain_loss  
,invoice_number  
--,SubTitle1  
--,SubTitle2  
From Zrit_Lapsing_temp_table  
Where guid = @guid  
order by proposal_number,SortOrder,asset_class,asset_number,tag_number,Date_of_Purchase  
  
Delete  
From Zrit_Lapsing_temp_table  
Where guid = @guid  
  
Set Nocount OFF                                  
End

