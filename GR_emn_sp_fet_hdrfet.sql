/*$File_version=ms4.3.0.43$*/    
/***************************************************************************************    
 file name         : gr_emn_sp_fet_hdrfet.sql                                  
 version           : 1.1                                                           
****************************************************************************************    
 procedure name    : gr_emn_sp_fet_hdrfet                                      
 purpose           :     
 author            :                                              
 date              : 17/oct/2002                                 
 component name    : gr                                     
 method name-id    : gr_emn_met_fet_hdrfet-2100                                              
 object referred   :    
 object name                    object type             operation                             
****************************************************************************************    
 Modification details :    
 Modified by     Modified on   Remarks       Version    
 Lavanya      5/12/04    Views split,GRDMS41UTST_000017     
 Lavanya      5/15/04    GRDMS41UTST_000017         
 U Ganapathi Subramanian  12/09/06   GRDms412at_000389    
 U Ganapathi Subramanian  02/01/2007   GRDMS412AT_000535    
 Mahalakshmi.S    23/07/2005   GRBASEFIXES_000103     1.1     
 U Ganapathi Subramanian  05/02/2007   GRDMS412AT_000574    
 Ramya R      18 Jun 2007   GRDMS412AT_000656      
 Veangadakrishnan R   19/05/2008   DLF_GR_BASEFIXES_001125                 
 Ananth P.     12/01/2009   ES_GR_00088    
 Harisankar K.R    04 Feb 2009   ES_BNKDEF_00013    
 Damodharan. R    14 May 2009   ES_GR_00177    
 Vishnu S     29/07/2009   ES_GR_00283    
 Nagarajan J     24112011   11H103_GR_00008,11H103_GR_00010    
    AnandhaMurugan T   02/02/2012   ES_GR_00870    
 Sejal N Khimani    28 June 2013  13H120_PRJEXEC_00017:ES_PRJEXEC_00125:13H120_GR_00007    
 Vasantha a     17/08/2015   ES_GR_02209    
 Saravanan        12/10/2015   ES_ABB_00858    
 Vasantha a     12/07/2016   ES_ABB_03616    
 Damodharan. R    21/06/2017   EPE-747    
 Nagarajan J     20/06/2018   EPE-6876    
 Dinesh S     23/05/2018   EBS-1360    
 Bharath A     08_02_2019   EBS-2378    
 Sivasankari.S               26/3/2019           EBS-2733    
 Sivasankari.S               29/4/2019           EBS-2911    
 /*Balasubramaniyam P 09/08/2019  EBS-3331  */    
 /*Balasubramaniyam P 09/08/2019  EBS-3225  */    
  /*Balasubramaniyam P 31/10/2019  AFL-250   */    
  /*Shobanadevi R  27/11/2019  EBS-3666  */     
  /*Prakash V   20/12/2019  MAT-1452  */     
  /*Vasudevan K   23 April 2020 EBS-4168  */    
  /*Abinaya G   05/08/2020  ECX-301   */    
  /*Vasantha  a   05/09/2020  FILU-351  */    
  /* Basil LD   15/09/2020  BMIE-181  */    
  /*Vasanthi   12/11/2020  EBS-5148  */    
  Abinaya G    28/04/2021  NTCPSS-523    
  Sejal N Khimani  18 May 2021  EPE-32585    
  Abinaya G    20/01/2022  ECX-541
  Abinaya G   21/04/2022   EPE-45646
  Abinaya G    01/07/2022  MHI-77  
  /*mugesh s       09-08-2022       TIS-303*/
  /* Sathishkumar S            27/03/2023          EPE-61891                         */
  /*Vasantha a		17/05/2023		TC-1489	*/
/*Ancy Peter        17-08-2023      TC-1904 */
/* Banurekha B      1/2/2024        SSIU-263*/
/* Mabel Rita L     27/03/2024      RCEPL-656*/
/* Vijay Shree S	12/03/2025		RNCC-389 */
***************************************************************************************/    
    
CREATE PROCEDURE gr_emn_sp_fet_hdrfet    
 @ctxt_language                 udd_ctxt_language,    
 @ctxt_ouinstance               udd_ctxt_ouinstance,    
 @ctxt_service                  udd_ctxt_service,    
 @ctxt_user                     udd_ctxt_user,    
 @amend_no                      udd_documentno,    
 @autoinvoicing1                udd_analysiscode,    
 @bscotype                      udd_type,    
 /*Code modified by Damodharan. R on 14 May 2009 for Defect ID ES_GR_00177 starts here*/  
 --@carriername                 udd_carriername,    
 @carriername                   udd_desc40,    
 /*Code modified by Damodharan. R on 14 May 2009 for Defect ID ES_GR_00177 ends here*/    
 @contactperson                 udd_contactperson,    
 @created_at                    udd_ou,    
 @created_atfil                 udd_ou,    
 @createdby                     udd_login,    
 @createddate                   udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 @date                          udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 @delynotedate                  udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 @delynoteno            udd_documentno,    
 @empcode                     udd_employeecode,    
 @ename                         udd_name,    
 @entryno                       udd_documentno,    
 @frdate                        udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 @frlevelenu1                   udd_flag10,/*datatype mismatch = > parameter data type:nchar       bt data type :enumerated*/    
 @gatepassdate                  udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 @gatepassno                    udd_documentno,    
 @guid                          udd_guid,    
 @invbeforegrhr                 udd_desc5,--udd_modeflag,   -- Code has been modified for GRDms412at_000389    
 @lastmodby                     udd_loginid,    
 @linestatus                 udd_status,    
 @lmodate                       udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 @noofpackages                  udd_volume,    
 @poremark                      udd_remarks,    
 @receiptdate                   udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 @receiptfolder                 udd_folder,    
 @receiptno                     udd_documentno,    
 @recno                         udd_documentno,    
 @refdoc_datemlt                udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 @refdoc_mlt                    udd_documentno,    
 @refdocfolderhr                udd_folder,    
 @referencedoc1                 udd_document,    
 @referencedochr                udd_document,    
 @referreddochdr                udd_document,    
 @referreddoclinenohr           udd_lineno,    
 @referreddocnohr               udd_documentno,    
 @shippedfromhr                 udd_ou,    
 @status                        udd_status,    
 @statuscode                    udd_statuscode,    
 @suppcusthdr                   udd_customer_id,    
 @timestamp                     udd_timestamp,    
 @totalconsignwt                udd_weight,/*datatype mismatch = > parameter data type:float      bt data type :numeric   */    
 @transmode                     udd_transportationmode,    
 @unitofmeasure                 udd_uom,    
 @unloadingdocno                udd_documentno,    
 @vehicle_noml                  udd_trackingnumber,    
 /* Code added for GRDMS412AT_000535 begins */    
 @Gross_wt                      udd_weight,    
 @tareweight                    udd_weight,    
 @totalvalue                    udd_amount,  --Input     
 /* Code added for GRDMS412AT_000535 ends */    
 @transactiontype  udd_transactiontype, /* For OTS id : GRDMS412AT_000656 */    
 /* Code added for DTS Id. : ES_BNKDEF_00013 Begins */    
 @egrlcno                  udd_lcno,    
 @egrrefid                 udd_ref_id,    
 @egrlcexpirydate          udd_date,    
 /* Code added for DTS Id. : ES_BNKDEF_00013 Ends */    
 @carriernm                   udd_description, --Input/Output --added for ES_GR_00283    
   
 --Code added for 11H103_GR_00008 begins   
 @projectcode          udd_unitcode, --Input/Output    
 @projectdescription   udd_txt150, --Input/Output    
 @projectou            udd_desc16, --Input/Output    
 @hdnrt_stcontrol      udd_ctxt_state_name, --Input/Output    
 --Code added for 11H103_GR_00008 ends    
 /*Code added for defect id:EBS-1360 begins*/    
 @owntaxregion           udd_tcdcode,     
 @suppliertaxregion      udd_tcdcode,     
 @taxregnno              udd_desc40,     
 /*Code added for defect id:EBS-1360 ends*/    
 /*Code Added for EBS-2378 begin */    
 @addln_info_edt   udd_desc1000,    
 @pay_term_cntrl   udd_Paytermcode,    
 @pay_term_desc   udd_text255,    
 @vessel_flght_code  udd_desc70,    
 @vessel_flght_name  udd_text255,    
 @voyage_flght_id  udd_desc70,    
 /*Code Added for EBS-2378 end */    
 /* Code added for the defect id : EBS-3331 starts here */     
 @clsfy_gr             udd_desc20, --Input/Output    
 @subclsfy_gr          udd_desc20, --Input/Output    
 @clsfy_desc_gr        udd_desc255, --Input/Output    
 @subclsfy_desc_gr     udd_desc255, --Input/Output    
 /* Code added for the defect id : EBS-3331 ends here */     
 @wfdockey      udd_desc255 = null, --code added for ECX-541 
  @reason_for_return    udd_txt150,       --code added for EPE-45646
 @m_errorid                     udd_int   output --ES_GR_00177-SP analyser exception    
AS    
BEGIN    
 SET NOCOUNT ON    
     
 --following should be the field names in the result set    
 --declare   @amend_no                      udd_documentno    
 --declare   @autoinvoicing1                udd_analysiscode    
 --declare   @bscotype                      udd_type    
 --declare   @carriername                   udd_carriername    
 --declare   @contactperson                 udd_contactperson    
 --declare   @created_at                    udd_ou    
 --declare   @created_atfil                 udd_ou    
 --declare   @createdby                     udd_login    
 --declare   @createddate                   udd_date/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 --declare   @date                          udd_date/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 --declare   @delynotedate                  udd_date/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 --declare   @delynoteno                    udd_documentno    
 --declare   @empcode                       udd_employeecode    
 --declare   @ename                         udd_name    
 --declare   @entryno                       udd_documentno    
 --declare   @frdate                        udd_date/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 --declare   @frlevelenu1                   udd_flag10/*datatype mismatch = > parameter data type:nchar       bt data type :enumerated*/    
 --declare   @gatepassdate                  udd_date/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 --declare   @gatepassno                    udd_documentno    
 --declare   @guid                          udd_guid    
 --declare   @invbeforegrhr                 udd_modeflag    
 --declare   @lastmodby                     udd_loginid    
 --declare   @linestatus                    udd_status    
 --declare   @lmodate                       udd_date/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 --declare   @noofpackages                  udd_volume    
 --declare   @poremark                      udd_remarks    
 --declare   @receiptdate   udd_date/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 --declare   @receiptfolder                 udd_folder    
 --declare   @receiptno                     udd_documentno    
 --declare   @recno                         udd_documentno    
 --declare   @refdoc_datemlt        udd_date/*datatype mismatch = > parameter data type:nchar       bt data type :date      */    
 --declare   @refdoc_mlt                    udd_documentno    
 --declare   @refdocfolderhr                udd_folder    
 --declare   @referencedoc1                 udd_document    
 --declare   @referencedochr                udd_document    
 --declare   @referreddochdr                udd_document    
 --declare   @referreddoclinenohr           udd_lineno    
 --declare   @referreddocnohr               udd_documentno    
 --declare   @shippedfromhr                 udd_ou    
 --declare   @status                        udd_status    
 --declare   @statuscode                    udd_statuscode    
 --declare   @suppcusthdr                   udd_customer_id    
 --declare   @timestamp                     udd_timestamp    
 --declare   @totalconsignwt                udd_weight/*datatype mismatch = > parameter data type:float      bt data type :numeric   */    
 --declare   @transmode                     udd_transportationmode    
 --declare   @unitofmeasure                 udd_uom    
 --declare   @unloadingdocno                udd_documentno    
 --declare   @vehicle_noml                  udd_trackingnumber    
      
 -- declaration of temporary variables     
 DECLARE @ctxt_language_tmp        udd_ctxt_language    
 DECLARE @ctxt_ouinstance_tmp      udd_ctxt_ouinstance    
 DECLARE @ctxt_service_tmp         udd_ctxt_service    
 DECLARE @ctxt_user_tmp            udd_ctxt_user    
 DECLARE @amend_no_tmp             udd_documentno    
 DECLARE @autoinvoicing1_tmp       udd_analysiscode    
 DECLARE @bscotype_tmp             udd_type    
 /*Code modified by Damodharan. R on 14 May 2009 for Defect ID ES_GR_00177 starts here*/    
 --declare      @carriername_tmp                   udd_carriername    
 DECLARE @carriername_tmp          udd_desc40    
 /*Code modified by Damodharan. R on 14 May 2009 for Defect ID ES_GR_00177 ends here*/    
 DECLARE @contactperson_tmp        udd_contactperson    
 DECLARE @created_at_tmp           udd_ou    
 DECLARE @created_atfil_tmp        udd_ou    
 DECLARE @createdby_tmp            udd_login    
 DECLARE @createddate_tmp          udd_date    
 DECLARE @date_tmp                 udd_date    
 DECLARE @delynotedate_tmp         udd_date    
 DECLARE @delynoteno_tmp           udd_documentno    
 DECLARE @empcode_tmp              udd_employeecode    
 DECLARE @ename_tmp                udd_name    
 DECLARE @entryno_tmp              udd_documentno    
 DECLARE @frdate_tmp               udd_date    
 DECLARE @frlevelenu1_tmp          udd_flag10    
 DECLARE @gatepassdate_tmp         udd_date    
 DECLARE @gatepassno_tmp           udd_documentno    
 DECLARE @guid_tmp                 udd_guid    
 DECLARE @invbeforegrhr_tmp        udd_desc5--udd_modeflag   -- Code has been modified for GRDms412at_000389    
 DECLARE @lastmodby_tmp            udd_loginid    
 DECLARE @linestatus_tmp    udd_status    
 DECLARE @lmodate_tmp              udd_date    
 DECLARE @noofpackages_tmp         udd_volume    
 DECLARE @poremark_tmp             udd_remarks    
 DECLARE @receiptdate_tmp          udd_date    
 DECLARE @receiptfolder_tmp        udd_folder    
 DECLARE @receiptno_tmp       udd_documentno    
 DECLARE @recno_tmp                udd_documentno    
 DECLARE @refdoc_datemlt_tmp       udd_date    
 DECLARE @refdoc_mlt_tmp           udd_documentno    
 DECLARE @refdocfolderhr_tmp       udd_folder    
 DECLARE @referencedoc1_tmp        udd_document    
 DECLARE @referencedochr_tmp       udd_document    
 DECLARE @referreddochdr_tmp       udd_document    
 DECLARE @referreddoclinenohr_tmp  udd_lineno    
 DECLARE @referreddocnohr_tmp      udd_documentno    
 DECLARE @shippedfromhr_tmp        udd_ou    
 /* Code commented and added for EPE-61891 begins */
 --DECLARE @status_tmp   udd_status    
 DECLARE @status_tmp   udd_desc255 
 /* Code commented and added for EPE-61891 ends */   
 DECLARE @statuscode_tmp           udd_statuscode    
 DECLARE @suppcusthdr_tmp          udd_customer_id    
 DECLARE @timestamp_tmp            udd_timestamp    
 DECLARE @totalconsignwt_tmp       udd_weight    
 DECLARE @transmode_tmp            udd_transportationmode    
 DECLARE @unitofmeasure_tmp        udd_uom    
 DECLARE @unloadingdocno_tmp       udd_documentno    
 DECLARE @vehicle_noml_tmp         udd_trackingnumber    
 /* Code added for GRDMS412AT_000535 begins */    
 DECLARE @Gross_wt_tmp             udd_weight      
 DECLARE @tareweight_tmp           udd_weight      
 DECLARE @totalvalue_tmp           udd_amount    
 /* Code added for GRDMS412AT_000535 ends */    
 DECLARE @transactiontype_tmp      udd_transactiontype /* For OTS id : GRDMS412AT_000656 */    
 DECLARE @status_code              udd_metadata_code --Added for DTS ID:DLF_GR_BASEFIXES_001125    
 Declare @carriernm_tmp     udd_description--added for ES_GR_00283    
    
 --Code added for 11H103_GR_00008 begins    
 Declare @projectcode_tmp          udd_unitcode    
 Declare @projectdescription_tmp   udd_txt150    
 Declare @projectou_tmp            udd_desc16    
 Declare @hdnrt_stcontrol_tmp      udd_ctxt_state_name    
 --Code added for 11H103_GR_00008 ends   
 
 --code added by vasantha a for TC-1489 begins
	declare		@base_currency		fin_currency,
				@tcd_b_cur_value	udd_amount
	DECLARE		@ipsStatus			udd_desc40    
	DECLARE		@bu_id				udd_buid    
	DECLARE		@company_code		udd_companycode     
	DECLARE		@projcode			udd_unitcode    
	DECLARE		@projdesc			udd_txt150    
	DECLARE		@createdou			udd_desc16    
	DECLARE		@Count				udd_int    
   --code added by vasantha a for TC-1489 ends
   declare	@addid_lstedt_flag		udd_metadata_code --SSIU-263
     
    
 /* Code added for DTS Id. : ES_GR_00870 Begins */    
 Declare @grlrno                udd_shortdesc    
 Declare @grlrdate              udd_date    
 /* Code added for DTS Id. : ES_GR_00870 Ends */    
 --declare @fr_flag     udd_desc20   --code added for ES_ABB_00858    
   /*Code added by Damodharan. R for Defect ID EPE-747 starts here*/    
   declare @supp_inv_no   udd_desc100,    
   @supp_inv_date   udd_date    
   /*Code added by Damodharan. R for Defect ID EPE-747 ends here*/    
     
 /* Code added for EPE-32585 Begins */    
 declare @workflow_app  udd_metadata_code,    
   @two_stage_enabled udd_metadata_code,    
   @workflow_status udd_desc255,    
   @workflow_status_cd udd_desc255    
    
 select @workflow_app = dbo.workflowapp_fet_fn(@ctxt_user,@ctxt_ouinstance,'GR','GPS','GRQFWF' )    
    
 select @workflow_app = isnull(@workflow_app,'N')    
     
 if @workflow_app = 'Y'    
 begin    
  select @two_stage_enabled = parameter_code    
  from ops_processparam_sys with (nolock)    
  where ou_id    = @ctxt_ouinstance    
  and  parameter_type  = 'PURSYS'    
  and  parameter_category = 'STGFRZRPT'    
    
  select @two_stage_enabled = isnull(@two_stage_enabled,'ONE')    
    
  if @two_stage_enabled <> 'TWO'    
  begin    
   --Setting workflow applicability as No, if the No. of freeze receipt stage is set other than Two.    
   select @workflow_app = 'N'    
  end    
 end    
 /* Code added for EPE-32585 Ends */    
 -- temporary and formal parameters mapping    
 SELECT @ctxt_language_tmp = @ctxt_language    
 SELECT @ctxt_ouinstance_tmp = @ctxt_ouinstance    
 SELECT @ctxt_service_tmp = LTRIM(RTRIM(@ctxt_service))    
 SELECT @ctxt_user_tmp = LTRIM(RTRIM(@ctxt_user))    
 SELECT @amend_no_tmp = LTRIM(RTRIM(@amend_no))    
 SELECT @autoinvoicing1_tmp = LTRIM(RTRIM(@autoinvoicing1))    
 SELECT @bscotype_tmp = LTRIM(RTRIM(@bscotype))    
 SELECT @carriername_tmp = LTRIM(RTRIM(@carriername))    
 SELECT @contactperson_tmp = LTRIM(RTRIM(@contactperson))    
 SELECT @created_at_tmp = LTRIM(RTRIM(@created_at))    
 SELECT @created_atfil_tmp = LTRIM(RTRIM(@created_atfil))    
 SELECT @createdby_tmp = LTRIM(RTRIM(@createdby))    
 SELECT @createddate_tmp = LTRIM(RTRIM(@createddate))    
 SELECT @date_tmp = LTRIM(RTRIM(@date))    
 SELECT @delynotedate_tmp = LTRIM(RTRIM(@delynotedate))    
 SELECT @delynoteno_tmp = LTRIM(RTRIM(@delynoteno))    
 SELECT @empcode_tmp = LTRIM(RTRIM(@empcode))    
 SELECT @ename_tmp = LTRIM(RTRIM(@ename))    
 SELECT @entryno_tmp = LTRIM(RTRIM(@entryno))    
 SELECT @frdate_tmp = LTRIM(RTRIM(@frdate))    
 SELECT @frlevelenu1_tmp = LTRIM(RTRIM(@frlevelenu1))    
 SELECT @gatepassdate_tmp = LTRIM(RTRIM(@gatepassdate))    
 SELECT @gatepassno_tmp = LTRIM(RTRIM(@gatepassno))    
 SELECT @guid_tmp = LTRIM(RTRIM(@guid))    
 SELECT @invbeforegrhr_tmp = LTRIM(RTRIM(@invbeforegrhr))    
 SELECT @lastmodby_tmp = LTRIM(RTRIM(@lastmodby))    
 SELECT @linestatus_tmp = LTRIM(RTRIM(@linestatus))    
 SELECT @lmodate_tmp = LTRIM(RTRIM(@lmodate))    
 SELECT @noofpackages_tmp = @noofpackages    
 SELECT @poremark_tmp = LTRIM(RTRIM(@poremark))    
 SELECT @receiptdate_tmp = LTRIM(RTRIM(@receiptdate))    
 SELECT @receiptfolder_tmp = LTRIM(RTRIM(@receiptfolder))    
 SELECT @receiptno_tmp = LTRIM(RTRIM(@receiptno))    
 SELECT @recno_tmp = LTRIM(RTRIM(@recno))    
 SELECT @refdoc_datemlt_tmp = LTRIM(RTRIM(@refdoc_datemlt))    
 SELECT @refdoc_mlt_tmp = LTRIM(RTRIM(@refdoc_mlt))    
 SELECT @refdocfolderhr_tmp = LTRIM(RTRIM(@refdocfolderhr))    
 SELECT @referencedoc1_tmp = LTRIM(RTRIM(@referencedoc1))    
 SELECT @referencedochr_tmp = LTRIM(RTRIM(@referencedochr))    
 SELECT @referreddochdr_tmp = LTRIM(RTRIM(@referreddochdr))    
 SELECT @referreddoclinenohr_tmp = @referreddoclinenohr    
 SELECT @referreddocnohr_tmp = LTRIM(RTRIM(@referreddocnohr))    
 SELECT @shippedfromhr_tmp = LTRIM(RTRIM(@shippedfromhr))    
 SELECT @status_tmp = LTRIM(RTRIM(@status))    
 SELECT @statuscode_tmp = LTRIM(RTRIM(@statuscode))    
 SELECT @suppcusthdr_tmp = LTRIM(RTRIM(@suppcusthdr))    
 SELECT @timestamp_tmp = @timestamp    
 SELECT @totalconsignwt_tmp = @totalconsignwt    
 SELECT @transmode_tmp = LTRIM(RTRIM(@transmode))    
 SELECT @unitofmeasure_tmp = LTRIM(RTRIM(@unitofmeasure))    
 SELECT @unloadingdocno_tmp = LTRIM(RTRIM(@unloadingdocno))    
 SELECT @vehicle_noml_tmp = LTRIM(RTRIM(@vehicle_noml))    
 /* Code added for GRDMS412AT_000535 begins */    
 SELECT @Gross_wt_tmp = @Gross_wt      
 SELECT @tareweight_tmp = @tareweight     
 SELECT @totalvalue_tmp = @totalvalue     
 /* Code added for GRDMS412AT_000535 ends */    
 SELECT @transactiontype_tmp = LTRIM(RTRIM(@transactiontype)) /* For OTS id : GRDMS412AT_000656 */    
 /* Code added for DTS Id. : ES_BNKDEF_00013 Begins */    
 SELECT @egrlcno = LTRIM(RTRIM(@egrlcno))    
 SELECT @egrrefid = LTRIM(RTRIM(@egrrefid))    
 /* Code added for DTS Id. : ES_BNKDEF_00013 Ends */    
 select @carriernm_tmp  = ltrim(rtrim(@carriernm))--added for ES_GR_00283    
     
 --Code added for 11H103_GR_00008 begins    
 SELECT @projectcode_tmp          = ltrim(rtrim(@projectcode))    
 SELECT @projectdescription_tmp   = ltrim(rtrim(@projectdescription))    
 SELECT @projectou_tmp            = ltrim(rtrim(@projectou))    
 SELECT @hdnrt_stcontrol_tmp      = ltrim(rtrim(@hdnrt_stcontrol))    
 --Code added for 11H103_GR_00008 ends    
 /*Code added for defect id:EBS-1360 begins*/    
 SELECT @owntaxregion    = ltrim(rtrim(@owntaxregion))    
 SELECT @suppliertaxregion   = ltrim(rtrim(@suppliertaxregion))    
 SELECT @taxregnno     = ltrim(rtrim(@taxregnno))    
 /*Code added for defect id:EBS-1360 ends*/    
 /*Code Added for EBS-2378 begin */    
 select @addln_info_edt   = ltrim(rtrim(@addln_info_edt))    
 select @pay_term_cntrl   = ltrim(rtrim(@pay_term_cntrl))    
 select @pay_term_desc   = ltrim(rtrim(@pay_term_desc))    
 select @vessel_flght_code  = ltrim(rtrim(@vessel_flght_code))    
 select @vessel_flght_name  = ltrim(rtrim(@vessel_flght_name))    
 select @voyage_flght_id   = ltrim(rtrim(@voyage_flght_id))    
      
 /*Code Added for EBS-2378 end */    
 /* Code added for the defect id : EBS-3331 starts here */     
 select @clsfy_gr             = ltrim(rtrim(@clsfy_gr))    
 select @subclsfy_gr          = ltrim(rtrim(@subclsfy_gr))    
 select @clsfy_desc_gr        = ltrim(rtrim(@clsfy_desc_gr))    
 select @subclsfy_desc_gr     = ltrim(rtrim(@subclsfy_desc_gr))    
 /* Code added for the defect id : EBS-3331 ends here */     
 -- errors mapped     
 select @reason_for_return   = ltrim(rtrim(@reason_for_return)) --code added for EPE-45646
  
     
 -- null checking     
 IF @ctxt_language_tmp = -915    
     SELECT @ctxt_language_tmp = NULL    
     
 IF @ctxt_ouinstance_tmp = -915    
     SELECT @ctxt_ouinstance_tmp = NULL    
     
 IF @ctxt_service_tmp = '~#~'    
     SELECT @ctxt_service_tmp = NULL    
     
 IF @ctxt_user_tmp = '~#~'    
     SELECT @ctxt_user_tmp = NULL    
     
 IF @amend_no_tmp = '~#~'    
     SELECT @amend_no_tmp = NULL    
     
 IF @autoinvoicing1_tmp = '~#~'    
     SELECT @autoinvoicing1_tmp = NULL    
     
 IF @bscotype_tmp = '~#~'    
     SELECT @bscotype_tmp = NULL    
     
 IF @carriername_tmp = '~#~'    
     SELECT @carriername_tmp = NULL    
     
 IF @contactperson_tmp = '~#~'    
     SELECT @contactperson_tmp = NULL    
     
 IF @created_at_tmp = '~#~'    
     SELECT @created_at_tmp = NULL    
     
 IF @created_atfil_tmp = '~#~'    
     SELECT @created_atfil_tmp = NULL    
     
 IF @createdby_tmp = '~#~'    
     SELECT @createdby_tmp = NULL    
     
 IF @createddate_tmp = '01/01/1900'    
     SELECT @createddate_tmp = NULL    
     
 IF @date_tmp = '01/01/1900'    
     SELECT @date_tmp = NULL    
     
 IF @delynotedate_tmp = '01/01/1900'    
     SELECT @delynotedate_tmp = NULL    
     
 IF @delynoteno_tmp = '~#~'    
     SELECT @delynoteno_tmp = NULL    
     
 IF @empcode_tmp = '~#~'    
     SELECT @empcode_tmp = NULL    
     
 IF @ename_tmp = '~#~'    
     SELECT @ename_tmp = NULL    
     
 IF @entryno_tmp = '~#~'    
     SELECT @entryno_tmp = NULL    
     
 IF @frdate_tmp = '01/01/1900'    
     SELECT @frdate_tmp = NULL    
     
 IF @gatepassdate_tmp = '01/01/1900'    
     SELECT @gatepassdate_tmp = NULL    
     
 IF @gatepassno_tmp = '~#~'    
     SELECT @gatepassno_tmp = NULL    
     
 IF @guid_tmp = '~#~'    
     SELECT @guid_tmp = NULL    
     
 IF @invbeforegrhr_tmp = '~#~'    
     SELECT @invbeforegrhr_tmp = NULL    
     
 IF @lastmodby_tmp = '~#~'    
     SELECT @lastmodby_tmp = NULL    
     
 IF @linestatus_tmp = '~#~'    
     SELECT @linestatus_tmp = NULL    
     
 IF @lmodate_tmp = '01/01/1900'    
     SELECT @lmodate_tmp = NULL    
     
 IF @noofpackages_tmp = -915    
     SELECT @noofpackages_tmp = NULL    
     
 IF @poremark_tmp = '~#~'    
     SELECT @poremark_tmp = NULL    
     
 IF @receiptdate_tmp = '01/01/1900'    
     SELECT @receiptdate_tmp = NULL    
     
 IF @receiptfolder_tmp = '~#~'    
     SELECT @receiptfolder_tmp = NULL    
     
 IF @receiptno_tmp = '~#~'    
     SELECT @receiptno_tmp = NULL    
     
 IF @recno_tmp = '~#~'    
     SELECT @recno_tmp = NULL    
     
 IF @refdoc_datemlt_tmp = '01/01/1900'    
     SELECT @refdoc_datemlt_tmp = NULL    
     
 IF @refdoc_mlt_tmp = '~#~'    
     SELECT @refdoc_mlt_tmp = NULL    
     
 IF @refdocfolderhr_tmp = '~#~'    
     SELECT @refdocfolderhr_tmp = NULL    
     
 IF @referencedoc1_tmp = '~#~'    
     SELECT @referencedoc1_tmp = NULL    
     
 IF @referencedochr_tmp = '~#~'    
     SELECT @referencedochr_tmp = NULL    
     
 IF @referreddochdr_tmp = '~#~'    
     SELECT @referreddochdr_tmp = NULL    
     
 IF @referreddoclinenohr_tmp = -915    
     SELECT @referreddoclinenohr_tmp = NULL    
     
 IF @referreddocnohr_tmp = '~#~'  
     SELECT @referreddocnohr_tmp = NULL    
     
 IF @shippedfromhr_tmp = '~#~'    
     SELECT @shippedfromhr_tmp = NULL    
     
 IF @status_tmp = '~#~'    
     SELECT @status_tmp = NULL    
     
 IF @statuscode_tmp = '~#~'    
     SELECT @statuscode_tmp = NULL    
     
 IF @suppcusthdr_tmp = '~#~'    
     SELECT @suppcusthdr_tmp = NULL    
     
 IF @timestamp_tmp = -915    
     SELECT @timestamp_tmp = NULL    
     
 IF @totalconsignwt_tmp = -915    
     SELECT @totalconsignwt_tmp = NULL    
     
 IF @transmode_tmp = '~#~'    
     SELECT @transmode_tmp = NULL    
     
 IF @unitofmeasure_tmp = '~#~'    
     SELECT @unitofmeasure_tmp = NULL    
     
 IF @unloadingdocno_tmp = '~#~'    
     SELECT @unloadingdocno_tmp = NULL    
     
 IF @vehicle_noml_tmp = '~#~'    
     SELECT @vehicle_noml_tmp = NULL    
 /* Code added for GRDMS412AT_000535 begins */    
 IF @Gross_wt_tmp = -915    
     SELECT @Gross_wt_tmp = NULL      
     
 IF @tareweight_tmp = -915    
     SELECT @tareweight_tmp = NULL      
     
 IF @totalvalue_tmp = -915    
   SELECT @totalvalue_tmp = NULL    
 /* Code added for GRDMS412AT_000535 ends */    
     
 /* Code added For OTS id : GRDMS412AT_000656 begins */    
 IF @transactiontype_tmp = '~#~'    
     SELECT @transactiontype_tmp = NULL    
 /* Code added For OTS id : GRDMS412AT_000656 ends */    
 /* Code added for DTS Id. : ES_BNKDEF_00013 Begins */    
 IF @egrlcno = '~#~'    
     SELECT @egrlcno = NULL      
     
 IF @egrrefid = '~#~'    
     SELECT @egrrefid = NULL      
    
 IF @carriernm = '~#~'     
  Select @carriernm_tmp = null--added for ES_GR_00283    
     
 IF @egrlcexpirydate = '01/01/1900'    
     SELECT @egrlcexpirydate = NULL     
 /* Code added for DTS Id. : ES_BNKDEF_00013 Ends */    
     
 /*Code added for defect id:EBS-1360 begins*/    
 IF @owntaxregion = '~#~'     
  Select @owntaxregion = null      
    
 IF @suppliertaxregion = '~#~'     
    Select @suppliertaxregion = null     
    
 IF @taxregnno = '~#~'     
  Select @taxregnno = null     
 /*Code added for defect id:EBS-1360 ends*/    
    
 --code added for ECX-541 begins    
 if @wfdockey = '~#~'    
  select @wfdockey = null    
 --code added for ECX-541 ends  
 --code added for EPE-45646 begins
             if @reason_for_return = '~#~'
                    select    @reason_for_return = null
    --code added for EPE-45646 ends
    
 /*** validations ****/    
    
 SELECT @date_tmp = dbo.RES_Getdate(@ctxt_ouinstance)--added for ES_GR_00283    
    
 --code added for ECX-541 begins    
   if @wfdockey is not null    
 begin    
  select @receiptno_tmp  = doc_unique_id    
  from wf_mypage_todo_vw with(nolock)    
  where doc_key    = @wfdockey    
 end--if @wfdockey is not null    
   --code added for ECX-541 ends    
     
 IF @receiptno_tmp IS NULL    
 AND @recno_tmp IS NULL    
 BEGIN    
     /* Receipt No. Should Not Be Blank */    
     SELECT @m_errorid = 1400563    
     RETURN    
 END     
     
 IF @receiptno_tmp IS NOT NULL    
 AND @recno_tmp IS NOT NULL    
 AND @receiptno_tmp <> @recno_tmp    
 BEGIN    
     /* Either Enter Receipt No. Or Select From Multiline */    
     SELECT @m_errorid = 1400564    
     RETURN    
 END    
     
 IF @receiptno_tmp IS NULL    
     SELECT @receiptno_tmp = @recno_tmp     
     
 --Code added for 11H103_GR_00008 begins    
 IF @projectcode_tmp = '~#~'     
  Select @projectcode_tmp = null      
    
 IF @projectdescription_tmp = '~#~'     
  Select @projectdescription_tmp = null      
    
 IF @projectou_tmp = '~#~'     
  Select @projectou_tmp = null      
    
 IF @hdnrt_stcontrol_tmp = '~#~'     
  Select @hdnrt_stcontrol_tmp = null     
--Code added for 11H103_GR_00008 ends    
     
 /*Code Added for EBS-2378 begin */    
   IF @addln_info_edt = '~#~'     
  Select @addln_info_edt = null     
      
   IF @pay_term_cntrl = '~#~'     
  Select @pay_term_cntrl = null     
      
   IF @pay_term_desc = '~#~'     
  Select @pay_term_desc = null     
 
   IF @vessel_flght_code = '~#~'     
  Select @vessel_flght_code = null     
      
   IF @vessel_flght_name = '~#~'     
  Select @vessel_flght_name = null     
      
   IF @voyage_flght_id = '~#~'     
  Select @voyage_flght_id = null     
      
 /*Code Added for EBS-2378 end */    
 /* Code added for the defect id : EBS-3331 starts here */    
 IF @clsfy_gr = '~#~'     
  Select @clsfy_gr = null      
    
 IF @subclsfy_gr = '~#~'     
  Select @subclsfy_gr = null      
    
 IF @clsfy_desc_gr = '~#~'     
  Select @clsfy_desc_gr = null      
    
 IF @subclsfy_desc_gr = '~#~'     
  Select @subclsfy_desc_gr = null      
 /* Code added for the defect id : EBS-3331 ends here */     
 /* fetch gr header details */    
     
 DECLARE @orderou  udd_ctxt_ouinstance    
 DECLARE @lo_id    udd_loid    
    
 /*Code Added for EBS-2378 begin */    
   ,@pps_gr_chng_cement_indus udd_metadata_code    
   ,@paytrm_versionno udd_int    
       
 select @pps_gr_chng_cement_indus = FLAG_YES_NO    
 from PPS_FEATURE_LIST(nolock)    
 where FEATURE_ID  = 'PPS_GR_CHNG_CEMENT_INDUS'    
 and  COMPONENT_NAME = 'GR'    
    
 /*Code Added for EBS-2378 end */    
    
 --code added by vasantha a for FILU-351 begins    
 select @suppcusthdr_tmp  = gr_hdr_suppcode    
 from gr_hdr_grmain(nolock)    
 where gr_hdr_ouinstid   = @ctxt_ouinstance_tmp    
 and  gr_hdr_grno    = @receiptno_tmp    
 --code added by vasantha a for FILU-351 ends 
 
 --code added by vasantha a for TC-1489 begins
   SELECT @date_tmp = dbo.RES_Getdate(@ctxt_ouinstance)   

	SELECT	@bu_id  = bu_id,    
			@company_code = company_code    
	FROM	emod_lo_bu_ou_vw(NOLOCK)    
	WHERE	ou_id = @ctxt_ouinstance    
	AND		@date_tmp BETWEEN ISNULL(effective_from, '01-01-1900') AND ISNULL(effective_to, '01-01-9999')
  

	select	@base_currency	=	currency_code
	FROM	emod_basecurr_vw(NOLOCK)
	WHERE	company_code	=	@company_code
	AND  	flag	=	'B'
	AND  	@date_tmp BETWEEN ISNULL(effective_from, '01-01-1900') AND ISNULL(effective_to, '01-01-9999')
   

	select	@tcd_b_cur_value =sum( case gr_dtcd_tcdtype     
								  when 'D' 
								  then -abs(gr_dtcd_amount)
								  else gr_dtcd_amount
								  end )
	from	gr_dtcd_doctcd (nolock)    
	where	gr_dtcd_ouinstid	= @ctxt_ouinstance_tmp    
	and		gr_dtcd_grno		= @receiptno_tmp    
	and		gr_dtcd_accrule		= 'IN'    
	and		gr_dtcd_suppcode	<> @suppcusthdr_tmp    
	and		gr_dtcd_currency	= @base_currency

	select @tcd_b_cur_value		=	isnull(@tcd_b_cur_value,0)+
									isnull((case gr_itcd_tcdtype     
											when 'D'  
											then -abs(gr_itcd_amount) 
											else  gr_itcd_amount end ),0)
	from gr_itcd_itmtcd (nolock)    
	where gr_itcd_ouinstid		= @ctxt_ouinstance_tmp    
	and  gr_itcd_grno			= @receiptno_tmp    
	and  gr_itcd_accrule		= 'IN'    
	and  gr_itcd_suppcode		<> @suppcusthdr_tmp   
	and  gr_itcd_currency		= @base_currency
   --code added by vasantha a for TC-1489 ends 
     
 /* code added for defect id : AFL-250 starts here*/    
 declare @pur_recp_val  udd_amount    
    
 ;     
 with doctcd     
 as    
 ( select gr_dtcd_ouinstid,gr_dtcd_grno,    
    sum( dbo.scm_get_round_amt_fn    
      (    
      @ctxt_ouinstance_tmp,    
      'GR',    
      gr_dtcd_currency,    
      @receiptdate_tmp,     
           
      case gr_dtcd_tcdtype     
      when 'D'     
      --then -gr_dtcd_amount*gr_dtcd_exchrate  --code commented for MHI-77    
      then -abs(gr_dtcd_amount)*gr_dtcd_exchrate --code added for MHI-77     
      else gr_dtcd_amount*gr_dtcd_exchrate     
      end,    
      'UDD_AMOUNT'    
      )     
     )    'DOCTCD_amt'    
  from gr_dtcd_doctcd (nolock)    
  where gr_dtcd_ouinstid = @ctxt_ouinstance_tmp    
  and  gr_dtcd_grno  = @receiptno_tmp    
  and  gr_dtcd_accrule  = 'IN' 
  and  gr_dtcd_suppcode <> @suppcusthdr_tmp    
  and  gr_dtcd_currency <> @base_currency--code added for TC-1489
  group by  gr_dtcd_ouinstid,gr_dtcd_grno    
 )    
 ,    
  itmtcd     
 as    
 ( select gr_itcd_ouinstid,gr_itcd_grno,    
    sum( dbo.scm_get_round_amt_fn    
      (    
      @ctxt_ouinstance_tmp,    
      'GR',    
      gr_itcd_currency,    
      @receiptdate_tmp,    
      case gr_itcd_tcdtype     
      when 'D'    
      --then -gr_itcd_amount*gr_itcd_exchrate   --code commented for MHI-77    
      then -abs(gr_itcd_amount)*gr_itcd_exchrate --code added for MHI-77     
      else gr_itcd_amount*gr_itcd_exchrate     
      end,    
      'UDD_AMOUNT'    
      )     
     )    'itmTCD_amt'    
  from gr_itcd_itmtcd (nolock)    
  where gr_itcd_ouinstid = @ctxt_ouinstance_tmp    
  and  gr_itcd_grno  = @receiptno_tmp    
  and  gr_itcd_accrule  = 'IN'    
  and  gr_itcd_suppcode <> @suppcusthdr_tmp   
  and  gr_itcd_currency <> @base_currency--code added for TC-1489
  group by  gr_itcd_ouinstid,gr_itcd_grno    
 )    
       
 select @pur_recp_val = dbo.scm_get_round_amt_fn    
        (    
        gr_hdr_ouinstid,    
        'GR',    
        gr_hdr_currency,    
        @receiptdate_tmp,    
       ( (gr_hdr_docvalue+ isnull(DOCTCD_amt,0)+isnull(itmTCD_amt,0)+isnull(gr_hdr_total_tcal_amount,0))    
          * gr_hdr_exchrate)+@tcd_b_cur_value ,    --code added for TC-1489 
        'UDD_AMOUNT'    
        )     
             
 from gr_hdr_grmain(nolock)    
   left outer join    
   doctcd    
   on     
   ( gr_dtcd_ouinstid = gr_hdr_ouinstid    
   and gr_dtcd_grno  = gr_hdr_grno    
   )    
   left outer join    
   itmtcd    
   on    
   (    
    gr_itcd_ouinstid = gr_hdr_ouinstid    
   and gr_itcd_grno  = gr_hdr_grno    
   )    
 where gr_hdr_ouinstid   = @ctxt_ouinstance_tmp    
 and  gr_hdr_grno    = @receiptno_tmp    
 /* code added for defect id : AFL-250 ends here*/     
    
 SELECT @amend_no_tmp = gr_hdr_orderamendno,    
        @bscotype_tmp = gr_hdr_grtype,    
        @carriername_tmp = gr_hdr_carriername,    
        @orderou = gr_hdr_orderou,    
        @createdby_tmp = gr_hdr_createdby,    
        @createddate_tmp = gr_hdr_createdate,    
        @delynotedate_tmp = gr_hdr_delynotedate,    
        @delynoteno_tmp = gr_hdr_delynoteno,    
        @gatepassdate_tmp = gr_hdr_gatepassdate,    
        @gatepassno_tmp = gr_hdr_gatepassno,    
        @noofpackages_tmp = gr_hdr_noofitems,    
        @receiptdate_tmp = gr_hdr_grdate,    
        @receiptfolder_tmp = gr_hdr_grfolder,    
        @refdoc_mlt_tmp = gr_hdr_orderno,    
        @refdoc_datemlt_tmp = gr_hdr_orderdate,    
        @refdocfolderhr_tmp = gr_hdr_orderfolder,    
        @shippedfromhr_tmp = gr_hdr_shipfromid,    
        @suppcusthdr_tmp = gr_hdr_suppcode,    
      --   @totalconsignwt_tmp = gr_hdr_consweight , -- Code has been modified for GRDMS412AT_000574    
        @unitofmeasure_tmp = gr_hdr_consuom,    
        @vehicle_noml_tmp = gr_hdr_vehicleno,    
        @status_tmp = gr_hdr_grstatus,    
        @referencedochr_tmp = gr_hdr_orderdoc,    
        @timestamp_tmp = gr_hdr_timestamp,    
        @autoinvoicing1_tmp = gr_hdr_autoinvoice,    
        @lastmodby_tmp = gr_hdr_modifiedby,    
        @lmodate_tmp = gr_hdr_modifieddate,    
        @contactperson_tmp = gr_hdr_contperson,    
        @empcode_tmp = gr_hdr_empcode,    
        @invbeforegrhr_tmp = gr_hdr_invbeforegr,    
        @referreddochdr_tmp = gr_hdr_refdoc,    
        @referreddocnohr_tmp = gr_hdr_refdocno,    
        @referreddoclinenohr_tmp = gr_hdr_refdoclineno,    
        @shippedfromhr_tmp = gr_hdr_shipfromid,    
        @transmode_tmp = gr_hdr_transmode,    
        @frdate_tmp = gr_hdr_frdate,    
        /* code added by Mahalakshmi S for bug id GRBASEFIXES_000103  starts here */    
        @poremark_tmp = gr_hdr_remarks,    
        /* code added by Mahalakshmi S for bug id GRBASEFIXES_000103  ends here */    
      /* Code has been modified for GRDMS412AT_000574 begins */    
        /* Code added for GRDMS412AT_000535 begins */    
        --   @Gross_wt_tmp   =  gr_hdr_weight ,    
        --   @tareweight_tmp   =  gr_hdr_tareweight  ,    
         --code modified by vasantha A for ES_ABB_03616 begins     
        --@totalvalue_tmp = gr_hdr_totalvalue,
		--code added and commented for TIS-303
		 @totalvalue_tmp = dbo.scm_get_round_amt_fn(
	                           @ctxt_ouinstance,
	                           'GR',
	                           null,
	                           dbo.RES_Getdate(@ctxt_ouinstance),
	                           gr_hdr_totalvalue * (gr_hdr_exchrate),
	                           'UDD_AMOUNT'),
       -- @totalvalue_tmp = gr_hdr_totalvalue*isnull(gr_hdr_exchrate,1), 
	   --code added and commented for TIS-303
        --code modified by vasantha A for ES_ABB_03616 ends    
        /* Code added for GRDMS412AT_000535 ends */    
        @Gross_wt_tmp = gr_hdr_grossweight,    
        @tareweight_tmp = gr_hdr_tareweight,    
        @totalconsignwt_tmp = gr_hdr_weight,    
        /* Code has been modified for GRDMS412AT_000574 begins */    
        @entryno_tmp = gr_hdr_entryno ,/*Code added by Ananth P. against: ES_GR_00088*/    
    /*Code Added for the DTS ID:ES_GR_00870 Starts*/    
     @grlrno  = gr_hdr_lr_no ,    
     @grlrdate = gr_hdr_lr_date    
    /*Code Added for the DTS ID:ES_GR_00870 Ends*/    
        /*Code added by Damodharan. R for Defect ID EPE-747 starts here*/    
        ,@supp_inv_no = gr_hdr_suppinvno,    
        @supp_inv_date = gr_hdr_suppinvdate    
        /*Code added by Damodharan. R for Defect ID EPE-747 ends here*/    
     /*code added for defect id:EBS-1360 begins */    
     ,@suppliertaxregion = gr_hdr_party_tax_region     
     ,@taxregnno   = gr_hdr_party_regd_no     
     ,@owntaxregion  = gr_hdr_own_tax_region     
     /*code added for defect id:EBS-1360 ends */    
     /*code added for EBS-2378 begin*/    
   ,@vessel_flght_code  = gr_hdr_vessel_code    
   ,@vessel_flght_name  = gr_hdr_vessel_name    
   ,@voyage_flght_id  = gr_hdr_voyage_ID    
   ,@addln_info_edt  = gr_hdr_additional_info     
   /*code added for EBS-2378 end*/    
   /* Code added for EPE-32585 Begins */    
   ,@workflow_status  = dbo.wf_metadesc_fet_fn('GR_QTY',gr_hdr_qf_wf_status)    
   ,@workflow_status_cd = gr_hdr_qf_wf_status    
   /* Code added for EPE-32585 Ends */ 
   --code added for EPE-45646 begins
   ,@reason_for_return = case when gr_hdr_grstatus = 'QR' then gr_hdr_qf_return_reason  
                                                                                                                                                                                 when gr_hdr_grstatus = 'VR' then gr_hdr_vf_return_reason 
                                                                                                                                                                                 else null end 
      --code added for EPE-45646 ends
 FROM   gr_hdr_grmain(NOLOCK)    
 WHERE  gr_hdr_ouinstid = @ctxt_ouinstance_tmp    
 AND    gr_hdr_grno = @receiptno_tmp    
     
 /* validate receipt no */    
 SELECT @status_code = @status_tmp --Added for DTS ID:DLF_GR_BASEFIXES_001125    
     
 /* Code added for ITS ID : 13H120_PRJEXEC_00017:ES_PRJEXEC_00125:13H120_GR_00007 Begins */    
 if exists (  select 'X'    
     from prjexec_genbill_dtl(nolock),    
      prjexec_genbill_hdr(nolock)     
     where  genbilld_billno  = genbillh_billno    
     and genbilld_billou  = genbillh_billou    
     and genbillh_status not IN ('DL','CA')    
     and genbilld_billou  = @ctxt_ouinstance     
     and genbilld_grno  = @receiptno_tmp    
    )    
 begin    
  --GR cannot be edited here as "%s" is being processed for Billing at Project Execution.    
  exec fin_german_raiserror_sp 'PRJEXEC',@ctxt_language,1313,@receiptno_tmp    
  return    
 end    
 /* Code added for ITS ID : 13H120_PRJEXEC_00017:ES_PRJEXEC_00125:13H120_GR_00007 Ends */    
 IF @status_tmp IS NULL    
 BEGIN    
     /* Receipt No. Is Invalid */     
     SELECT @m_errorid = 1402602    
     RETURN    
 END     
    
 /* Code added for EPE-32585 Begins */    
     
 select @workflow_app = dbo.workflowapp_fet_fn(@ctxt_user,@ctxt_ouinstance,'GR','GPS','GRQFWF' )    
    
 select @workflow_app = isnull(@workflow_app,'N')    
     
 if @workflow_app = 'Y'    
 begin    
  select @two_stage_enabled = parameter_code    
  from ops_processparam_sys with (nolock)    
  where ou_id    = @ctxt_ouinstance    
  and  parameter_type  = 'PURSYS'    
  and  parameter_category = 'STGFRZRPT'    
    
  select @two_stage_enabled = isnull(@two_stage_enabled,'ONE')    
    
  if @two_stage_enabled <> 'TWO'    
  begin    
   --Setting workflow applicability as No, if the No. of freeze receipt stage is set other than Two.    
   select @workflow_app = 'N'    
  end    
 end    
    
 if @workflow_app = 'Y'    
 begin    
  if not exists ( select 'x'    
      from  gr_hdr_grmain with (NOLOCK)    
      left outer join     
      wf_mypage_todo_vw wf with (NOLOCK)    
      on ( wf.doc_unique_id  = gr_hdr_grno    
       and wf.ou_code    = @ctxt_ouinstance_tmp    
       and wf.area_code   = 'GR_QTY'    
       and wf.component_name  = 'GR'    
       and wf.wf_instance_status = 'P'    
       and (wf.user_closed = 'P' or wf.doc_status = 'FRESH')    
       and ( (  wf.my_name  = @ctxt_user_tmp    
         and wf.ou_code  = @ctxt_ouinstance_tmp )    
         or    
         (  wf.proxy_user = @ctxt_user_tmp    
         and wf.ou_code  = @ctxt_ouinstance_tmp )   
         or    
         (  wf.my_name  = 'ALL'    
         and wf.ou_code  = @ctxt_ouinstance_tmp ) ) )    
      where gr_hdr_ouinstid   = @ctxt_ouinstance_tmp    
      and  gr_hdr_grno    = @receiptno_tmp    
      and  ( ( gr_hdr_qf_wf_status is not null and wf.doc_unique_id is not null )    
        or gr_hdr_qf_wf_status is null)    
     )    
  begin    
   --Logged In User does not have rights for GR No. ''%s''.    
   exec fin_german_raiserror_sp 'GR',@ctxt_language,900027900,@receiptno_tmp    
   return    
  end    
 end--if @workflow_app = 'Y'    
    
 /* Code added for EPE-32585 Ends */    
    
 --NTCPSS-523 begins    
 IF @status_tmp in ('DL')    
 begin    
  /* Receipt Document is not in valid status */    
     SELECT @m_errorid = 1402283    
     RETURN    
 end    
 --NTCPSS-523 ends    
     
 IF @status_tmp NOT IN ('DR', 'FR', 'PF', 'VF','QF')--'QF' addded by vasantha a for ES_GR_02209    
 BEGIN    
     /*code added for DTS ID: DLF_GR_BASEFIXES_001125 starts here*/    
     IF NOT EXISTS (    
            SELECT 'X'    
            FROM   gr_lin_details(NOLOCK)    
            WHERE  gr_lin_grno = @receiptno_tmp    
            AND    gr_lin_ouinstid = @ctxt_ouinstance    
      /* Code commented and added for EPE-32585 Begins */    
            --AND    gr_lin_linestatus IN ('FR', 'DR')    
      AND    gr_lin_linestatus IN ('FR', 'DR','QR')    
      /* Code commented and added for EPE-32585 Ends */    
        )    
     BEGIN    
         /*code added for DTS ID: DLF_GR_BASEFIXES_001125 ends here*/    
         /* Receipt Document is not in valid status */    
         SELECT @m_errorid = 1402283    
         RETURN    
     END--Added for DTS ID:DLF_GR_BASEFIXES_001125    
 END    
     
 /* fetch loid */    
     
 SELECT @lo_id = lo_id    
 FROM   emod_lo_bu_ou_vw(NOLOCK)    
 WHERE  ou_id = @ctxt_ouinstance_tmp    
 AND    @receiptdate_tmp BETWEEN ISNULL(effective_from, '01-01-1900')     
        AND ISNULL(effective_to, '01-01-9999')    
     
 /* fetch supplier / customer name */    

  /*Code Added for EBS-2378 begin */    
       
  if @referencedochr_tmp = 'PO'    
  begin    
        
   select @pay_term_cntrl = payterm    
   from gr_po_hdr_vw (nolock)     
   where   docno  = @refdoc_mlt_tmp    
   and  amendno  = @amend_no_tmp    
   and  ouinstid    =   @ctxt_ouinstance              
       
   select @paytrm_versionno = max(pt_version_no)    
   from pt_payterm_master(nolock)    
   where pt_paytermcode = @pay_term_cntrl    
   and  pt_lo_id   = @lo_id    
    
   select @pay_term_desc = cml.pt_description    
   from pt_payterm_master  pt (nolock)    
   join pt_payterm_multilanguage cml (nolock)    
   on  pt.pt_lo_id   = cml.pt_lo_id    
   and  pt.pt_paytermcode = cml.pt_paytermcode    
   and  pt.pt_version_no = cml.pt_version_no    
   where pt.pt_paytermcode = @pay_term_cntrl    
   and  pt.pt_version_no = @paytrm_versionno    
   and  pt.pt_lo_id   = @lo_id    
   and  cml.pt_langid  = @ctxt_language    
    
  end    
    
    
/*Code Added for EBS-2378 end */    
    
     
 IF @referencedochr_tmp = 'SO'    
     SELECT @ename_tmp = clo_cust_name    
     FROM   cust_lo_info_vw(NOLOCK)    
     WHERE  clo_lo = @lo_id    
     AND    clo_cust_code = RTRIM(@suppcusthdr_tmp)    
 ELSE    
     SELECT @ename_tmp = supplier_name    
     FROM   supp_supdtls_vw(NOLOCK)    
     WHERE  loid = @lo_id    
     AND    supplier_code = RTRIM(@suppcusthdr_tmp)    
     
 /* fetch paramdesc */    
     
 DECLARE @docstat udd_paramdesc    
 SELECT @referencedochr_tmp = paramdesc    
 FROM   component_metadata_table(NOLOCK)    
 WHERE  componentname = 'GR'    
 AND    paramcategory = 'META'    
 AND    paramtype = 'REF_DOC'    
 AND    paramcode = RTRIM(@referencedochr_tmp)    
 AND    langid = @ctxt_language_tmp     
     
 SELECT @referreddochdr_tmp = paramdesc    
 FROM   component_metadata_table(NOLOCK)    
 WHERE  componentname = 'GR'    
 AND    paramcategory = 'META'    
 AND    paramtype = 'REFD_DOC'    
 AND    paramcode = RTRIM(@referreddochdr_tmp)    
 AND    langid = @ctxt_language_tmp     
     
 SELECT @status_tmp = paramdesc    
 FROM   component_metadata_table(NOLOCK)    
 WHERE  componentname = 'GR'    
 AND    paramcategory = 'META'    
 AND    paramtype = 'DOC_STATUS'    
 AND    paramcode = RTRIM(@status_tmp)    
 AND    langid = @ctxt_language_tmp     
     
 SELECT @bscotype_tmp = paramdesc    
 FROM   component_metadata_table(NOLOCK)    
 WHERE  componentname = 'GR'    
 AND    paramcategory = 'COMBO'    
 AND    paramtype = 'DOC_TYPE'    
 AND    paramcode = @bscotype_tmp    
 AND    langid = @ctxt_language_tmp     
     
 /* Code has been uncommented for GRDms412at_000389 begins */    
 /**/    
 SELECT @invbeforegrhr_tmp = RTRIM(paramdesc)    
 FROM   component_metadata_table(NOLOCK)    
 WHERE  componentname = 'GR'    
 AND    paramcategory = 'META'    
 AND    paramtype = 'INVBEFGR'    
 AND    paramcode = RTRIM(@invbeforegrhr_tmp)    
 AND    langid = @ctxt_language_tmp/**/--Commented becos @invbeforegrhr_tmp is mapped to udd_modeflag    
 /* Code has been uncommented for GRDms412at_000389 ends */    
     
 SELECT @autoinvoicing1_tmp = RTRIM(paramdesc)    
 FROM   component_metadata_table(NOLOCK)    
 WHERE  componentname = 'GR'    
 AND    paramcategory = 'META'    
 AND    paramtype = 'AUTOINV'    
 AND    paramcode = RTRIM(@autoinvoicing1_tmp)    
 AND    langid = @ctxt_language_tmp    
     
     
 SELECT @docstat = RTRIM(paramdesc)    
 FROM   component_metadata_table(NOLOCK)    
 WHERE  componentname = 'GR'    
 AND    paramcategory = 'META'    
 AND    paramtype = 'DOC_STATUS'    
 AND    paramcode = 'AL'    
 AND    langid = @ctxt_language    
     
     
 SELECT @created_at_tmp = ouinstname    
 FROM   depdb..fw_admin_view_ouinstance (NOLOCK)    
 WHERE  ouinstid = @orderou     
     
 /* Code added for DTS Id. : ES_BNKDEF_00013 Begins */    
 DECLARE @temp_po_lc_ou  udd_ctxt_ouinstance,    
         @temp_loid      udd_loid,    
         @temp_po_ou     udd_ctxt_ouinstance    
     
 SELECT @egrlcno = gr_hdr_lc_no,    
        @egrrefid = gr_hdr_ref_id,    
        @temp_po_ou = gr_hdr_orderou    
 FROM   gr_hdr_grmain(NOLOCK)    
 WHERE  gr_hdr_grno = @receiptno_tmp    
 AND    gr_hdr_ouinstid = @ctxt_ouinstance_tmp    
     
 IF @egrlcno IS NOT NULL    
 BEGIN    
     SELECT @temp_po_lc_ou = destinationouinstid    
     FROM  fw_admin_view_comp_intxn_model(NOLOCK)    
     WHERE  sourcecomponentname = 'PO'    
     AND    sourceouinstid = @temp_po_ou    
     AND    destinationcomponentname = 'LC'    
         
     SELECT @temp_loid = lo_id    
     FROM   emod_lo_bu_ou_vw(NOLOCK)    
     WHERE  ou_id = @temp_po_lc_ou    
         
     SELECT @egrlcexpirydate = lch_lc_exp_date    
     FROM   lc_header(NOLOCK)    
     WHERE  lch_ref_id = @egrrefid    
     AND    lch_lc_no = @egrlcno    
     AND    lch_lo = @temp_loid    
 END    
 /* Code added for DTS Id. : ES_BNKDEF_00013 Ends */    
 /* output fields in resultset */     
    
 --code added for ES_GR_00283 starts here    
 select  @carriernm_tmp = LTRIM(RTRIM(tsmstr_type_description))      
 FROM tys_typecode_vw (nolock)    
   ,fw_admin_view_comp_intxn_model (nolock) --code added for ECX-301     
 WHERE tsmstr_ou         = destinationouinstid --@ctxt_ouinstance_tmp --code modified for ECX-301    
 AND  tsmstr_class_code       = 'CARIER'    
 --code added for ECX-301 begins    
 and  sourceouinstid          = @ctxt_ouinstance    
 and  sourcecomponentname       = 'GR'    
 and  destinationcomponentname     = 'TYPE_SETUP'    
 --code added for ECX-301 ends     
 AND  tsmstr_effective_from      <= @date_tmp    
 AND  ISNULL(tsmstr_effective_to,@date_tmp)  >= @date_tmp    
 AND  tsmstr_status        = 'AC'    
 AND  tsmstr_type_code       = @carriername_tmp     
 --code added for ES_GR_00283 ends here    
     
     
 /*Code added for 11H103_GR_00008 begins here*/    
  --code commneted  for TC-1489 begins
  --DECLARE  @ipsStatus  udd_desc40    
  --DECLARE  @bu_id   udd_buid    
  --DECLARE  @company_code udd_companycode     
  --DECLARE  @projcode  udd_unitcode    
  --DECLARE  @projdesc  udd_txt150    
  --DECLARE  @createdou  udd_desc16    
  --DECLARE  @Count   udd_int     
    --code commneted  for TC-1489 ends

   
  SELECT @date_tmp = dbo.RES_Getdate(@ctxt_ouinstance)    
    
  SELECT @bu_id  = bu_id,    
        @company_code = company_code    
  FROM emod_lo_bu_ou_vw(NOLOCK)    
  WHERE ou_id = @ctxt_ouinstance    
  AND   @date_tmp BETWEEN ISNULL(effective_from, '01-01-1900') AND ISNULL(effective_to, '01-01-9999')    
     
  SELECT @ipsStatus=ISNULL(parameter_code,'')     
  FROM ips_processparam_sys (nolock)    
  WHERE company_code  =@company_code    
  AND parameter_type  ='CPSYS'     
  AND parameter_category ='PROJECTACCTFLAG'    
  AND language_id   =@ctxt_language_tmp    
    
    
  /* Code added for EPE-32585 Begins */    
    
  if @workflow_status_cd = 'RET'    
  begin    
   select @workflow_app = 'N'    
  end--if @workflow_status_cd = 'RET'    
  
     /* code added for the id SSIU-263 starts here */
 	select	@addid_lstedt_flag	=	gr_fn_enbl_listedit
	from	gr_setfn_param_hdr with (nolock)
	where	gr_fn_ou			=	@ctxt_ouinstance

	select	@addid_lstedt_flag	=	isnull(@addid_lstedt_flag,'N')

   if @addid_lstedt_flag	=	'Y'
		begin
			if	@workflow_app	=	'Y'
			begin
				if	@pps_gr_chng_cement_indus	=	'NO'
				begin 
					SELECT @hdnrt_stcontrol = 'ER_State_1_new_WFON'
				end	--if	@pps_gr_chng_cement_indus	=	'NO'
				else
				begin
					select @hdnrt_stcontrol = 'VSS_state_1_new_WFON'			
				end
			end
			else
			begin
				if	@pps_gr_chng_cement_indus	=	'NO'
				begin 
					SELECT @hdnrt_stcontrol = 'ER_State_1_new'
				end	--if	@pps_gr_chng_cement_indus	=	'NO'
				else
				begin 			
					select @hdnrt_stcontrol = 'VSS_state_1_new'			
				end
			end
		end--if @addid_lstedt_flag	=	'Y'
		else
		begin
		/* code added for the id SSIU-263 ends here */

  if @workflow_app = 'Y'    
  begin    
   if @pps_gr_chng_cement_indus = 'NO'    
   begin     
    select @hdnrt_stcontrol = 'ER_State_1_WFON'    
   end --if @pps_gr_chng_cement_indus = 'NO'    
   else    
   begin       
    select @hdnrt_stcontrol = 'VSS_state_1_WFON'       
   end    
  end    
  else    
  begin    
  /* Code added for EPE-32585 Ends */    
   /*Code Added for EBS-2378 begin */      
   if @pps_gr_chng_cement_indus = 'NO'    
   begin     
   /*Code Added for EBS-2378 end */    
    
   select @hdnrt_stcontrol = 'ER_State_1'    
   /*Code Added for EBS-2378 begin */    
   end --if @pps_gr_chng_cement_indus = 'NO'    
   else    
   begin     
       
    select @hdnrt_stcontrol = 'VSS_state_1'    
       
   end    
   /*Code Added for EBS-2378 end */    
  end --EPE-32585    
  end --SSIU-263
    
  IF @ipsStatus='Y'   
   BEGIN     
    /*Code comment for 11H103_GR_00008 begins here*/    
    --SELECT @count  = count(distinct grl.gr_lin_projectcode),    
     SELECT DISTINCT     
   /*Code comment for 11H103_GR_00008 ends here*/    
      @projcode = grl.gr_lin_projectcode,    
      @projdesc = prh.prjhdr_prjname,    
      --@createdou = dbo.getouname(grl.gr_lin_projectou)  --code commented for RCEPL-656
	  @createdou = grl.gr_lin_projectou  --code added for RCEPL-656
    FROM gr_lin_details grl(nolock)    
      join    
      prjdef_prj_hdr prh(nolock)    
      on ( grl.gr_lin_projectcode = prh.prjhdr_prjcode    
       and grl.gr_lin_projectou = prh.prjhdr_prjou --)    
       /*Code comment for 11H103_GR_00008 begins here*/    
        --AND prh.prjhdr_amendno=     
        -- (SELECT            MAX(ISNULL(prh1.prjhdr_amendno,0)) 'maxAmendno'     
        --  FROM   prjdef_prj_hdr prh1(nolock)    
        --  where    prh1.prjhdr_prjcode         = prh.prjhdr_prjcode    
        --  and     prh1.prjhdr_prjou  = prh.prjhdr_prjou))    
        AND prh.prjhdr_max_amendno_flag='Y')    
       /*Code comment for 11H103_GR_00008 ends here*/    
    WHERE grl.gr_lin_grno  = @receiptno_tmp    
    and  grl.gr_lin_ouinstid = @ctxt_ouinstance_tmp    
    and  isnull(grl.gr_lin_projectcode,'') <> ''    
     /*Code comment for 11H103_GR_00008 begins here*/    
    --GROUP BY grl.gr_lin_projectcode,prh.prjhdr_prjname,grl.gr_lin_projectou    
     /*Code comment for 11H103_GR_00008 ends here*/    
        
    /*Code added for 11H103_GR_00008 begins here*/    
    SELECT @count  = @@ROWCOUNT    
    /*Code added for 11H103_GR_00008 ends here*/    
    
    /* Code added for EPE-32585 Begins */    
    if @workflow_app = 'Y'    
    begin    
     if @pps_gr_chng_cement_indus = 'NO'    
     begin     
      if @count = 1    
      BEGIN    
       SELECT @hdnrt_stcontrol = 'ER_State_3_WFON'    
      END    
      IF @count > 1    
      BEGIN    
       SELECT @hdnrt_stcontrol = 'ER_State_2_WFON'    
      END    
     end --if @pps_gr_chng_cement_indus = 'NO'    
     else    
     begin       
      if @count = 1    
      BEGIN    
       SELECT @hdnrt_stcontrol = 'VSS_state_3_WFON'    
      END    
      IF @count > 1    
      BEGIN    
       SELECT @hdnrt_stcontrol = 'VSS_state_2_WFON'    
      END    
     end    
    end    
    else    
    begin    
    /* Code added for EPE-32585 Ends */    
    /*Code Added for EBS-2378 begin */    
     if @pps_gr_chng_cement_indus = 'NO'    
     begin     
     /*Code Added for EBS-2378 end */    
    
     if @count = 1   
      BEGIN    
       SELECT @hdnrt_stcontrol = 'ER_State_3'    
      END    
     IF @count > 1    
      BEGIN    
       SELECT @hdnrt_stcontrol = 'ER_State_2'    
      END    
     /*Code Added for EBS-2378 begin */  
     end --if @pps_gr_chng_cement_indus = 'NO'    
     else    
     begin     
       
      if @count = 1    
      BEGIN    
       SELECT @hdnrt_stcontrol = 'VSS_state_3'    
      END    
      IF @count > 1    
      BEGIN    
       SELECT @hdnrt_stcontrol = 'VSS_state_2'    
      END    
    
     end    
    end --else...if @workflow_app = 'Y' --EPE-32585    
   /*Code Added for EBS-2378 end */    
   END --IF @ipsStatus='Y'    
 /*Code added for 11H103_GR_00008 ends here*/  
 
 /* Code commented start for TC-1904  
 /* code added for ES_ABB_00858 begins */    
  select  @fr_flag = flag_yes_no    
     from pps_feature_list(nolock)    
     where  feature_id = 'PPS_TRIG_FID_002'    
      and    component_name = 'PO'
  /*code added for ES_ABB_00858 Ends */ 
  Code commented end for TC-1904*/

 --Code start for TC-1904 
   declare @pps_flag      fin_flag
   declare @frdate_GR	 fin_date

   	select @pps_flag = flag_yes_no
				from pps_feature_list with(nolock)
					where  feature_id	= 'PPS_FID_0006'

				 if exists ( select 'X'
		                      from   gr_hdr_grmain(NOLOCK)    
								where  gr_hdr_ouinstid = @ctxt_ouinstance_tmp    
								and    gr_hdr_grno     = @receiptno_tmp 
								and    gr_hdr_frdate is not null
				            )
				  begin
							select @frdate_GR  = gr_hdr_frdate
							  from gr_hdr_grmain(NOLOCK)    
								where  gr_hdr_ouinstid = @ctxt_ouinstance_tmp    
								and    gr_hdr_grno     = @receiptno_tmp 
								and    gr_hdr_frdate is not null
				  end

	if @pps_flag  = 'NO' and isnull(@frdate_GR,'') = ''
	begin
	select @frdate_GR = null
	end
	
	else if @pps_flag  = 'Yes'
	begin
	       select @frdate_GR = isnull(@frdate_tmp,dbo.RES_Getdate(@ctxt_ouinstance))
	end
	else
	begin
	select @frdate_GR = @frdate_GR
	end



 --Code end for TC-1904


    
 --Code added for BMIE-181 starts    
 exec gr_custom_sp    
   @ctxt_language,    
   @ctxt_ouinstance,    
   @ctxt_service,    
   @ctxt_user,    
   @receiptno,    
   @projcode,    
   @referencedochr_tmp,    
   @refdoc_mlt_tmp,    
   NULL,    
   @m_errorid output    
 --Code added for BMIE-181 ends    
    
 /* Code added for defect id : EBS-3225 starts here*/    
 SELECT @referencedochr_tmp = paramcode    
 FROM   component_metadata_table(NOLOCK)    
 WHERE  componentname = 'GR'    
 AND    paramcategory = 'META'    
 AND    paramtype = 'REF_DOC'    
 AND    paramdesc  = RTRIM(@referencedochr_tmp)    
 AND    langid = @ctxt_language_tmp     
    
 if @referencedochr_tmp='PO'    
 begin    
  select @clsfy_gr    = pomas_cls_code,    
    @subclsfy_gr   = pomas_scls_code,    
    @clsfy_desc_gr   = mst1.tsmstr_type_description,    
    @subclsfy_desc_gr  = mst2.tsmstr_type_description    
  from    po_pomas_pur_order_hdr (nolock)     
  left join tys_tsmstr_typsetup_mstr mst1 (nolock)     
  on  mst1.tsmstr_type_code   = pomas_cls_code    
  and  mst1.tsmstr_class_code   = 'CLS'    
  and  mst1.tsmstr_company_code  = @company_code    
  left join tys_tsmstr_typsetup_mstr mst2 (nolock)     
  on  mst2.tsmstr_type_code   = pomas_scls_code    
  and  mst2.tsmstr_class_code   = 'SCLS'    
  and  mst2.tsmstr_company_code  = @company_code    
  where   pomas_poou     =  @orderou            
  and     pomas_pono     =  @refdoc_mlt_tmp    
  and  pomas_poamendmentno   = @amend_no_tmp    
 end    
 else           
 IF @referencedochr_tmp = 'RS'     
 begin    
   select @clsfy_gr    = prs_mn_classification,    
     @subclsfy_gr   = prs_mn_SubClassification,    
     @clsfy_desc_gr   = mst1.tsmstr_type_description,    
     @subclsfy_desc_gr  = mst2.tsmstr_type_description    
      FROM gr_rs_hdr_vw(NOLOCK)    
   left join tys_tsmstr_typsetup_mstr mst1 (nolock)     
   on  mst1.tsmstr_type_code   = prs_mn_classification    
   and  mst1.tsmstr_class_code   = 'CLS'    
   and  mst1.tsmstr_company_code  = @company_code    
   left join tys_tsmstr_typsetup_mstr mst2 (nolock)     
   on  mst2.tsmstr_type_code   = prs_mn_SubClassification    
   and  mst2.tsmstr_class_code   = 'SCLS'    
   and  mst2.tsmstr_company_code  = @company_code    
      WHERE ouinstid  = @orderou    
      AND   docno   = @refdoc_mlt_tmp    
      AND   amendno   = @amend_no_tmp    
 end     
 else    
 IF @referencedochr_tmp = 'SC'    
 begin     
   select @clsfy_gr    = scohr_cls_code,    
     @subclsfy_gr   = scohr_subcls_code,    
     @clsfy_desc_gr   = mst1.tsmstr_type_description,    
     @subclsfy_desc_gr  = mst2.tsmstr_type_description    
     FROM gr_sc_hdr_vw(NOLOCK)    
     left join tys_tsmstr_typsetup_mstr mst1 (nolock)     
     on  mst1.tsmstr_type_code   = scohr_cls_code    
     and  mst1.tsmstr_class_code   = 'CLS'    
     and  mst1.tsmstr_company_code  = @company_code    
     left join tys_tsmstr_typsetup_mstr mst2 (nolock)     
     on  mst2.tsmstr_type_code   = scohr_subcls_code    
     and  mst2.tsmstr_class_code   = 'SCLS'    
     and  mst2.tsmstr_company_code  = @company_code    
     WHERE ouinstid  = @createdou    
     AND   docno   = @refdoc_mlt_tmp    
     AND   amendno   = @amend_no_tmp    
 end    
 else    
 IF @referencedochr_tmp = 'SR'    
 begin    
   select @clsfy_gr    = rsh_cls_code,    
     @subclsfy_gr   = rsh_subcls_code,    
     @clsfy_desc_gr   = mst1.tsmstr_type_description,    
     @subclsfy_desc_gr  = mst2.tsmstr_type_description    
      FROM gr_sr_hdr_vw(NOLOCK)    
   left join tys_tsmstr_typsetup_mstr mst1 (nolock)     
   on  mst1.tsmstr_type_code   = rsh_cls_code    
   and  mst1.tsmstr_class_code   = 'CLS'    
   and  mst1.tsmstr_company_code  = @company_code    
   left join tys_tsmstr_typsetup_mstr mst2 (nolock)     
   on  mst2.tsmstr_type_code   = rsh_subcls_code    
   and  mst2.tsmstr_class_code   = 'SCLS'    
   and  mst2.tsmstr_company_code  = @company_code    
      WHERE ouinstid = @createdou    
      AND   docno  = @refdoc_mlt_tmp    
      AND   amendno  = @amend_no_tmp    
 end    
 else    
 if @referencedochr_tmp = 'PG'    
 begin     
    select @clsfy_gr    = prs_mn_classification,    
      @subclsfy_gr   = prs_mn_SubClassification,    
      @clsfy_desc_gr   = mst1.tsmstr_type_description,    
      @subclsfy_desc_gr  = mst2.tsmstr_type_description    
          FROM gr_pgrs_hdr_vw(NOLOCK)    
    left join tys_tsmstr_typsetup_mstr mst1 (nolock)     
    on  mst1.tsmstr_type_code   = prs_mn_classification    
    and  mst1.tsmstr_class_code   = 'CLS'    
    and  mst1.tsmstr_company_code  = @company_code    
    left join tys_tsmstr_typsetup_mstr mst2 (nolock)     
    on  mst2.tsmstr_type_code   = prs_mn_SubClassification    
    and  mst2.tsmstr_class_code   = 'SCLS'    
    and  mst2.tsmstr_company_code  = @company_code    
          WHERE ouinstid = @createdou    
          AND   docno  = @refdoc_mlt_tmp    
          AND   amendno  = @amend_no_tmp    
 end    
 /* Code added for defect id : EBS-3225 ends here*/    
 /* code added for defect id : EBS-3666 starts here */    
 declare @tran_rights_flag  udd_desc20 
   --@cls_code_user   udd_typecode    
       
    
  select @guid_tmp = newid()       
    
  /* Code added for EBS-4168 Begins */    
  if @clsfy_gr is not null    
  begin    
  /* Code added for EBS-4168 Ends */    
   exec   classification_sp_user_acc    
       @ctxt_ouinstance,    
       @ctxt_user,    
       null,    
       @ctxt_language,    
       @guid_tmp,    
       'CW',    
       'GR',    
       @tran_rights_flag  output,    
       @m_errorid              output    
      
            if @tran_rights_flag = 'Y'  and not exists (    select 1     
                                                  from       classification_user_acc_wise_tmp(nolock)     
                                                  where      tmp_guid             =      @guid_tmp    
                                                  and        tmp_classification   =      @clsfy_gr    
                              )    
  begin     
          --raiserror('Login User does not have rights to access classification data recorded %s',16,1,@scono_tmp)    
          exec fin_german_raiserror_sp 'po',@ctxt_language,1600,@receiptno_tmp    
          return       
  end    
     
      
   delete from classification_user_acc_wise_tmp where tmp_guid= @guid_tmp -- EBS-3666    
  end--EBS-4168    
 /*Addres id list code added */---EBS-5148        
 declare    @shipfromid_edtgr udd_desc255              
       
 Select @shipfromid_edtgr=isnull(supp_addr_addid,'')+Space(3)+isnull(supp_addr_address1,'')+Space(3)+isnull(supp_addr_address2,'')+Space(3)+      
 isnull(supp_addr_address3,'')+Space(3)+isnull(supp_addr_city,'')+Space(3)+isnull(supp_addr_state,'')+Space(3)+isnull(supp_addr_zip,'')+Space(3)+isnull(supp_addr_phone,'')         
 from     supp_addr_address(nolock)             
 where  supp_addr_loid    = @lo_id                  
 AND   supp_addr_supcode   = @suppcusthdr_tmp           
 and   supp_addr_addid    = ISNULL(@shippedfromhr_tmp,supp_addr_addid)         
 /*Addres id list code added */--EBS-5148     

 /*RNCC-389 begins*/
 SELECT @referencedochr_tmp = paramdesc    
 FROM   component_metadata_table(NOLOCK)    
 WHERE  componentname = 'GR'    
 AND    paramcategory = 'META'    
 AND    paramtype = 'REF_DOC'    
 AND    paramcode = RTRIM(@referencedochr_tmp)    
 AND    langid = @ctxt_language_tmp     
 /*RNCC-389 ends*/
    
 /* code added for defect id : EBS-3666 ends here */     
    
 SELECT @amend_no_tmp         'AMEND_NO',    
        RTRIM(@autoinvoicing1_tmp)      'AUTOINVOICING1',    
    RTRIM(@bscotype_tmp)       'BSCOTYPE',    
        RTRIM(@carriername_tmp)       'CARRIERNAME',    
        RTRIM(@contactperson_tmp)      'CONTACTPERSON',    
        RTRIM(@created_at_tmp)       'CREATED_AT',    
        RTRIM(@created_at_tmp)       'CREATED_ATFIL',    
        RTRIM(@createdby_tmp)       'CREATEDBY',    
        CONVERT(nCHAR(10), @createddate_tmp, 120)  'CREATEDDATE',    
        CONVERT(nCHAR(10), @receiptdate_tmp, 120)  'DATE',    
        CONVERT(nCHAR(10), @delynotedate_tmp, 120) 'DELYNOTEDATE',    
        RTRIM(@delynoteno_tmp)       'DELYNOTENO',    
        RTRIM(@empcode_tmp)        'EMPCODE',    
        RTRIM(@ename_tmp)        'ENAME',    
        RTRIM(@entryno_tmp)        'ENTRYNO', /*Code added by Ananth P. against: ES_GR_00088*/    
        --CONVERT(nCHAR(10), ISNULL(@frdate_tmp, dbo.RES_Getdate(@ctxt_ouinstance)), 120)   'FRDATE' --code commented  for ES_ABB_00858    
		/*Code commented start for TC-1904  
        CONVERT(nCHAR(10), ISNULL(@frdate_tmp, dbo.RES_Getdate(@ctxt_ouinstance)), 120)   'FRDATE' --code commented  for ES_ABB_00858    
        case  @fr_flag when 'YES'    THEN NULL --ES_ABB_00858 added   
		Code commented end for TC-1904*/
	    --case  @fr_flag when 'No'    THEN NULL 
        --   ELSE CONVERT(nCHAR(10), ISNULL(@frdate_tmp, dbo.RES_Getdate(@ctxt_ouinstance)), 120)  END 'FRDATE',
		CONVERT(nCHAR(10), @frdate_tmp, 120)   'FRDATE',  --Code added for TC-1904 
       --'2'           'FRLEVELENU1',--MAT-1452(Defaulting Line level commented)    
    '3'            'FRLEVELENU1',--MAT-1452(Default at document level)    
        CONVERT(nCHAR(10), @gatepassdate_tmp, 120) 'GATEPASSDATE',    
        RTRIM(@gatepassno_tmp)       'GATEPASSNO',    
          --RTRIM(NEWID())        'GUID',--code commetnted for EBS-3666    
      @guid_tmp         'GUID',--code added for EBS-3666    
        RTRIM(@invbeforegrhr_tmp)      'INVBEFOREGRHR',    
        RTRIM(@lastmodby_tmp)       'LASTMODBY',    
     RTRIM(@docstat)         'LINESTATUS',    
        CONVERT(nCHAR(10), @lmodate_tmp, 120)   'LMODATE',    
        RTRIM(@noofpackages_tmp)      'NOOFPACKAGES',    
        /* code added by Mahalakshmi S for bug id GRBASEFIXES_000103  starts here */    
        RTRIM(@poremark_tmp)       'POREMARK',    
        /* code added by Mahalakshmi S for bug id GRBASEFIXES_000103  ends here */    
        CONVERT(nCHAR(10), @receiptdate_tmp, 120)  'RECEIPTDATE',    
        RTRIM(@receiptfolder_tmp)      'RECEIPTFOLDER',    
        RTRIM(@receiptno_tmp)       'RECEIPTNO',    
        NULL           'RECNO',    
        CONVERT(nCHAR(10), @refdoc_datemlt_tmp, 120) 'REFDOC_DATEMLT',    
        RTRIM(@refdoc_mlt_tmp)       'REFDOC_MLT',    
        RTRIM(@refdocfolderhr_tmp)      'REFDOCFOLDERHR',    
        RTRIM(@referencedochr_tmp)      'REFERENCEDOC1',    
        RTRIM(@referencedochr_tmp)      'REFERENCEDOCHR',    
        RTRIM(@referreddochdr_tmp)      'REFERREDDOCHDR',    
        @referreddoclinenohr_tmp      'REFERREDDOCLINENOHR',    
        RTRIM(@referreddocnohr_tmp)      'REFERREDDOCNOHR',    
        RTRIM(@shippedfromhr_tmp)      'SHIPPEDFROMHR',    
        RTRIM(@status_tmp)        'STATUS',    
        --rtrim('AL')        'STATUSCODE', --Commented for DTS ID:DLF_GR_BASEFIXES_001125    
        RTRIM(@status_tmp)        'STATUSCODE', --Added for DTS ID:DLF_GR_BASEFIXES_001125    
        RTRIM(@suppcusthdr_tmp)       'SUPPCUSTHDR',    
        @timestamp_tmp         'TIMESTAMP',    
        RTRIM(@totalconsignwt_tmp)      'TOTALCONSIGNWT',    
        RTRIM(@transmode_tmp)       'TRANSMODE',    
        RTRIM(@unitofmeasure_tmp)      'UNITOFMEASURE',    
        NULL           'UNLOADINGDOCNO',    
        RTRIM(@vehicle_noml_tmp)      'VEHICLE_NOML',    
        /* Code added for GRDMS412AT_000535 begins */    
        @Gross_wt_tmp         'GROSS_WT',    
        @tareweight_tmp         'TAREWEIGHT',    
        @totalvalue_tmp         'TOTALVALUE',    
        /* Code added for GRDMS412AT_000535 ends */    
        'PUR_GR'          'TRANSACTIONTYPE', /* For OTS id : GRDMS412AT_000656 */    
        /* Code added for DTS Id. : ES_BNKDEF_00013 Begins */    
        @egrlcno          'EGRLCNO',    
     @egrrefid          'EGRREFID',    
        @egrlcexpirydate        'EGRLCEXPIRYDATE',    
     @carriernm_tmp        'CARRIERNM' --added for ES_GR_00283    
     --Code added for 11H103_GR_00008 begins      
  ,@projcode 'projectcode',     
  @projdesc 'projectdescription',     
  /*@createdou*/dbo.getouname(@createdou) 'projectou',    --code commented and added for RCEPL-656 
  @hdnrt_stcontrol 'hdnrt_stcontrol',    
  --Code added for 11H103_GR_00008 ends    
 /* Code added for DTS Id. : ES_BNKDEF_00013 Ends */    
  /*Code added for the DTS ID:ES_GR_00870 Starts */      
  @grlrno   'GRLRNO',     
  @grlrdate  'GRLRDATE'     
  /*Code added for the DTS ID:ES_GR_00870 ends */    
       /*Code added by Damodharan. R for Defect ID EPE-747 starts here*/    
        ,@supp_inv_no   'SUPP_INV_NO',    
        @supp_inv_date   'SUPP_INV_DATE'    
       /*Code added by Damodharan. R for Defect ID EPE-747 ends here*/    
      
  --EPE-6876    
  ,'T' 'HIDDENERCP1'    
  ,'GR' 'HIDDENERCP2'     
  ,'B' 'HIDDENERCP3'     
  --EPE-6876    
  /*code added for defect id:EBS-1360 begins*/    
  ,@owntaxregion  'owntaxregion',     
  @suppliertaxregion  'suppliertaxregion',     
  @taxregnno   'taxregnno'    
 /*code added for defect id:EBS-1360 ends*/    
  /*Code Added for EBS-2378 begin */    
  ,@addln_info_edt 'addln_info_edt',    
  @pay_term_cntrl  'pay_term_cntrl',      
  @pay_term_desc  'pay_term_desc',      
  @vessel_flght_code 'vessel_flght_code',     
  @vessel_flght_name 'vessel_flght_name',     
  @voyage_flght_id 'voyage_flght_id'      
  /*Code Added for EBS-2378 end */    
  --,@ctxt_ouinstance_tmp    'csouinstance' --code added for EBS-2733    
  ,dbo.getOuId_fn(@created_at_tmp) 'csouinstance' --code added for EBS-2911    
  /* Code commented and added for defect id : EBS-3225 starts here*/    
     
  /* Code added for the defect id : EBS-3331 starts here */    
  --, null 'clsfy_gr',     
  --null 'subclsfy_gr',     
  --null 'clsfy_desc_gr',     
  --null 'subclsfy_desc_gr'    
  /* Code added for the defect id : EBS-3331 ends here */    
     
  ,@clsfy_gr   'CLSFY_GR',    
  @subclsfy_gr  'SUBCLSFY_GR',    
  @clsfy_desc_gr  'CLSFY_DESC_GR',  
  @subclsfy_desc_gr 'SUBCLSFY_DESC_GR',    
  /* Code commented and added for defect id : EBS-3225 ends here*/    
  @pur_recp_val  'PUR_RECEP_VAL' -- AFL-250     
  /*modified by EBS-5148*/          
    ,@shippedfromhr_tmp 'shipfromid_edtgr',        
  @shipfromid_edtgr 'addressdet_edtgr'        
 /*modified by EBS-5148*/        
 ,@workflow_status 'WF_status_datahyp'--EPE-32585    
 ,@wfdockey   'wfdockey' --code added for ECX-541    
 ,@reason_for_return    'reason_for_return'--code added for EPE-45646 
 SET NOCOUNT OFF    
END    
    
    
    
    
    

    
    
    