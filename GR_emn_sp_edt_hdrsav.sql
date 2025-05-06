/*$File_version=ms4.3.0.27$*/
/***************************************************************************************
 file name         : gr_emn_sp_edt_hdrsav.sql                             
 version           : 1.2                                                        
****************************************************************************************
 procedure name    : gr_emn_sp_edt_hdrsav                                  
 purpose           : 
 author            :                                          
 date              : 26-oct-2002                             
 component name    : gr                                 
 method name-id    : gr_emn_met_edt_hdrsav-2095                                          
 object referred   :
 object name                    object type             operation                         
****************************************************************************************
 Modification details :
	Modified by						Date			Remarks					Version
	Mahalakshmi.S					23/07/2005		GRBASEFIXES_000103 		1.1
	 Priya R	       				11/01/2006		RGTD_GR_BASEFIXES_000736 
	Tool User						1/12/2006		OTSTEST001
	U Ganapathi Subramanian			12/09/06		GRDms412at_000389
	CML Conversion Tool Version:1.1.0.0  5/4/2006 8:56:51 PM
	U Ganapathi Subramanian 		02/01/2007		GRDMS412AT_000535
	U Ganapathi Subramanian 		05/02/2007		GRDMS412AT_000574
	U Ganapathi Subramanian 		14/02/2007		GRDMS412AT_000589
	Ananth P.						17/05/2007		GRDMS412AT_000640
	Ramya.R							17/06/2008		MCL_GR_BASEFIXES_000044
	Ananth P.						12/01/2009		ES_GR_00088
	Harisankar K.R					04 Feb 2009		ES_BNKDEF_00013
	Harisankar K.R					25 Feb 2009		8H123-3_GR_00002
	Damodharan. R					14 May 2009		ES_GR_00177
	Chockalingam.S					10/Nov/2009		ES_GR_00353
	Jagadeesan RS					20/01/2010		ES_GR_00417
    AnandhaMurugan T				02/02/2012      ES_GR_00870
	Prakash V						15/06/2012      ES_GR_02564
	Bharath A						07/03/2017		14H109_INV_MOBILE_00050 
	Damodharan. R				21/06/2017					EPE-747
	Kavitha R					21/06/2017		EPE-747    
	Srividya.N						26/03/2017		PB-4898	
	Damodharan. R					27/06/2017		EPE-1618
	Dinesh S						21/05/2018		EBS-1360	
	Bharath A						08_02_2019		EBS-2378
	Abinaya G						10/05/2019		JAI-533	
/*  Balasubramaniyam P			    09/08/2019		EBS-3331	*/
/*  Lavanya N                       07/04/2021      EPE-31872   */
/*  Sejal N Khimani					24 May 2021		EPE-32585	*/
/*	Abinaya G						21/04/2022		EPE-45646	*/
/*  Akash V							01/10/2022		ERPSM-4340*/
/*  Sathishkumar S                  31/01/2022      EPE-58138  */
/*  Vijay Shree S					22/04/2023		PEPS-2454 */ 
/*	Vijay Shree S					12/03/2025		RNCC-389  */
***************************************************************************************/
Create PROCEDURE gr_emn_sp_edt_hdrsav
	@amend_no                      udd_documentno,
	@autoinvoicing1                udd_analysiscode,
	@bscotype                      udd_type,
	/*Code modified by Damodharan. R on 14 May 2009 for Defect ID ES_GR_00177 starts here*/
	--@carriername                 udd_carriername,
	@carriername                   udd_desc40,
	/*Code modified by Damodharan. R on 14 May 2009 for Defect ID ES_GR_00177 ends here*/
	@contactperson                 udd_contactperson,
	@created_at                    udd_ou,
	@createdby                     udd_login,
	@createddate                   udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */
	@ctxt_language                 udd_ctxt_language,
	@ctxt_ouinstance               udd_ctxt_ouinstance,
	@ctxt_service                  udd_ctxt_service,
	@ctxt_user                     udd_ctxt_user,
	@date                          udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */
	@delynotedate                  udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */
	@delynoteno                    udd_documentno,
	@empcode                       udd_employeecode,
	@ename                         udd_name,
	@entryno                       udd_documentno,
	@frdate                        udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */
	@frlevelenu1    udd_flag10,/*datatype mismatch = > parameter data type:nchar       bt data type :enumerated*/
	@gatepassdate                  udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */
	@gatepassno                    udd_documentno,
	@guid                          udd_guid,
	@invbeforegrhr                 udd_desc5,--udd_modeflag,   -- Code has been modified for GRDms412at_000389
	@lastmodby                     udd_loginid,
	@linestatus      udd_status,
	@lmodate                       udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */
	@noofpackages                  udd_volume,
	@poremark                      udd_remarks,
	@receiptdate                   udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */
	@receiptfolder                 udd_folder,
	@receiptno                     udd_documentno,
	@refdoc_datemlt                udd_date,/*datatype mismatch = > parameter data type:nchar       bt data type :date      */
	@refdoc_mlt                    udd_documentno,
	@refdocfolderhr                udd_folder,
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
	@totalvalue                    udd_amount,
	/* Code added for GRDMS412AT_000535 ends */
	/* Code added for DTS Id. : ES_BNKDEF_00013 Begins */
	@egrlcno             		   udd_lcno,
	@egrrefid            		   udd_ref_id,
	@egrlcexpirydate     		   udd_date,
	/* Code added for DTS Id. : ES_BNKDEF_00013 Ends */
   /* Code added for DTS Id. : ES_GR_00870 Begins */
	@grlrno              		udd_shortdesc, --Input 
	@grlrdate            		udd_date, --Input 
	/* Code added for DTS Id. : ES_GR_00870 Ends */
	/*Code added by Damodharan. R for Defect ID EPE-747 starts here*/
	@supp_inv_no				udd_desc100,
	@supp_inv_date				udd_date,	
	/*Code added by Damodharan. R for Defect ID EPE-747 ends here*/
	/*Code added for defect id:EBS-1360 begins*/
	@owntaxregion        		udd_tcdcode, 
	@suppliertaxregion   		udd_tcdcode, 
	@taxregnno           		udd_desc40, 
	/*Code added for defect id:EBS-1360 ends*/
	/*Code Added for EBS-2378 begin */
	@addln_info_edt			udd_desc1000,
	@pay_term_cntrl			udd_Paytermcode,
	@pay_term_desc			udd_text255,
	@vessel_flght_code		udd_desc70,
	@vessel_flght_name		udd_text255,
	@voyage_flght_id		udd_desc70,
	/*Code Added for EBS-2378 end */
	/* Code added for the defect id : EBS-3331 starts here */	
	@clsfy_gr            	udd_desc20, --Input 
	@subclsfy_gr         	udd_desc20, --Input 
	@clsfy_desc_gr       	udd_desc255, --Input 
	@subclsfy_desc_gr    	udd_desc255, --Input 
	/* Code added for the defect id : EBS-3331 ends here */	
	--@reason_for_return      udd_txt150, --code added for EPE-45646  -- code commented for ERPSM-4340
 @m_errorid                     udd_int OUTPUT --int   output  
  /*Code Added for 14H109_INV_MOBILE_00050 begin */  
 ,@fin_error_tmp      udd_int = null output,    
  @calling_service     udd_ctxt_service = null  , 
  /*Code Added for 14H109_INV_MOBILE_00050 end*/  
   @reason_for_return      udd_txt150 = null --code added for ERPSM-4340
AS
BEGIN
	SET NOCOUNT ON
	
	--following should be the field names in the result set
	--declare   @fprowno                       udd_rowno
	
	-- br logic
	/*
	documentation for the method gr_emn_met_edt_hdrsav
	
	parameter description : 
	param name , business term , flow 
	
	ctxt_ouinstance ctxt_ouinstance  , input 
	ctxt_user ctxt_user  , input 
	ctxt_language ctxt_language  , input 
	ctxt_service ctxt_service  , input 
	amend_no documentno  , input 
	autoinvoicing1 analysiscode  , input 
	bscotype type  , input 
	carriername carriername  , input 
	contactperson contactperson  , input 
	created_at ou  , input 
	createdby login  , input 
	createddate date  , input 
	date date  , input 
	delynotedate date  , input 
	delynoteno documentno  , input 
	empcode employeecode  , input 
	ename name  , input 
	entryno documentno  , input 
	frdate date  , input 
	frlevelenu1 flag10  , input 
	gatepassdate date  , input 
	gatepassno documentno  , input 
	guid guid  , input 
	invbeforegrhr modeflag  , input 
	lastmodby loginid  , input 
	linestatus status  , input 
	lmodate date  , input 
	noofpackages volume  , input 
	poremark remarks  , input 
	receiptdate date  , input 
	receiptfolder folder  , input 
	receiptno documentno  , input 
	refdoc_datemlt date  , input 
	refdoc_mlt documentno  , input 
	refdocfolderhr folder  , input 
	referencedochr document  , input 
	referreddochdr document  , input 
	referreddoclinenohr lineno  , input 
	referreddocnohr documentno  , input 
	shippedfromhr ou  , input 
	status status  , input 
	statuscode statuscode  , input 
	suppcusthdr customer_id  , input 
	timestamp timestamp  , input 
	totalconsignwt weight  , input 
	transmode transportationmode  , input 
	unitofmeasure uom  , input 
	unloadingdocno documentno  , input 
	vehicle_noml trackingnumber  , input 
	fprowno rowno  , output 
	*/
	
	-- declaration of temporary variables 
	DECLARE @amend_no_tmp             udd_documentno
	DECLARE @autoinvoicing1_tmp       udd_analysiscode
	DECLARE @bscotype_tmp             udd_type
	/*Code modified by Damodharan. R on 14 May 2009 for Defect ID ES_GR_00177 starts here*/
	--declare      @carriername_tmp                   udd_carriername
	DECLARE @carriername_tmp          udd_desc40
	/*Code modified by Damodharan. R on 14 May 2009 for Defect ID ES_GR_00177 ends here*/
	DECLARE @contactperson_tmp        udd_contactperson
	DECLARE @created_at_tmp           udd_ou
	DECLARE @createdby_tmp            udd_login
	DECLARE @createddate_tmp          udd_date
	DECLARE @ctxt_language_tmp        udd_ctxt_language
	DECLARE @ctxt_ouinstance_tmp      udd_ctxt_ouinstance
	DECLARE @ctxt_service_tmp         udd_ctxt_service
	DECLARE @ctxt_user_tmp            udd_ctxt_user
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
	DECLARE @linestatus_tmp           udd_status
	DECLARE @lmodate_tmp              udd_date
	DECLARE @noofpackages_tmp         udd_volume
	DECLARE @poremark_tmp             udd_remarks
	DECLARE @receiptdate_tmp          udd_date
	DECLARE @receiptfolder_tmp        udd_folder
	DECLARE @receiptno_tmp            udd_documentno
	DECLARE @refdoc_datemlt_tmp       udd_date
	DECLARE @refdoc_mlt_tmp           udd_documentno
	DECLARE @refdocfolderhr_tmp       udd_folder
	DECLARE @referencedochr_tmp       udd_document
	DECLARE @referreddochdr_tmp       udd_document
	DECLARE @referreddoclinenohr_tmp  udd_lineno
	DECLARE @referreddocnohr_tmp      udd_documentno
	DECLARE @shippedfromhr_tmp        udd_ou
	DECLARE @status_tmp               udd_status
	DECLARE @statuscode_tmp   udd_statuscode
	DECLARE @suppcusthdr_tmp          udd_customer_id
	DECLARE @timestamp_tmp            udd_timestamp
	DECLARE @totalconsignwt_tmp       udd_weight
	DECLARE @transmode_tmp            udd_transportationmode
	DECLARE @unitofmeasure_tmp        udd_uom
	DECLARE @unloadingdocno_tmp       udd_documentno
	DECLARE @vehicle_noml_tmp         udd_trackingnumber
	DECLARE @Gross_wt_tmp             udd_weight 
	/* Code added for GRDMS412AT_000535 begins */
	DECLARE @tareweight_tmp           udd_weight    
	DECLARE @totalvalue_tmp           udd_amount --Input 
	/* Code added for GRDMS412AT_000535 ends */
	DECLARE @authdate                 udd_date /* Code added by Ramya.R for MCL_GR_BASEFIXES_000044 */
	--ES_GR_02564 Starts
	DECLARE @tmpcreatedou   udd_ctxt_ouinstance  
	DECLARE @exchgrate       udd_amount 
	DECLARE @currency        fin_currency  --udd_currencycode --code modified for PEPS-2454
	--ES_GR_02564 Ends

	--EPE-747	
	declare @companycode	fin_companycode
	declare @errormsg		fin_desc255
	declare @exec_flag		fin_flag
	--EPE-747
	--Code added for PB-4898 starts
	DECLARE @pps_tmp		udd_desc20
	--Code added for PB-4898 ends
	/*code added for EBS-2378 begin*/
	DECLARE @pps_gr_chng_cement_indus		 udd_yesnoflag 
	DECLARE @vessel_status					 udd_statuscode
	DECLARE @voyage_id						 lgt_voyage
	/*code added for EBS-2378 begin*/

	-- temporary and formal parameters mapping
	SELECT @amend_no_tmp = LTRIM(RTRIM(@amend_no))
	SELECT @autoinvoicing1_tmp = LTRIM(RTRIM(@autoinvoicing1))
	SELECT @bscotype_tmp = LTRIM(RTRIM(@bscotype))
	SELECT @carriername_tmp = LTRIM(RTRIM(@carriername))
	SELECT @contactperson_tmp = LTRIM(RTRIM(@contactperson))
	SELECT @created_at_tmp = LTRIM(RTRIM(@created_at))
	SELECT @createdby_tmp = LTRIM(RTRIM(@createdby))
	SELECT @createddate_tmp = LTRIM(RTRIM(@createddate))
	SELECT @ctxt_language_tmp = @ctxt_language
	SELECT @ctxt_ouinstance_tmp = @ctxt_ouinstance
	SELECT @ctxt_service_tmp = LTRIM(RTRIM(@ctxt_service))
	SELECT @ctxt_user_tmp = LTRIM(RTRIM(@ctxt_user))
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
	SELECT @refdoc_datemlt_tmp = LTRIM(RTRIM(@refdoc_datemlt))
	SELECT @refdoc_mlt_tmp = LTRIM(RTRIM(@refdoc_mlt))
	SELECT @refdocfolderhr_tmp = LTRIM(RTRIM(@refdocfolderhr))
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
	/* Code added for DTS Id. : ES_BNKDEF_00013 Begins */
	SELECT @egrlcno = LTRIM(RTRIM(@egrlcno))
	SELECT @egrrefid = LTRIM(RTRIM(@egrrefid))
	/* Code added for DTS Id. : ES_BNKDEF_00013 Ends */
    /* Code added for DTS Id. : ES_GR_00870 Begins */
	SELECT @grlrno               = ltrim(rtrim(@grlrno))
	/* Code added for DTS Id. : ES_GR_00870 Ends */
	/*Code added by Damodharan. R for Defect ID EPE-747 starts here*/
	SELECT @supp_inv_no	=	ltrim(rtrim(@supp_inv_no))
	/*Code added by Damodharan. R for Defect ID EPE-747 ends here*/
	/*Code added for defect id:EBS-1360 begins*/
	SELECT @suppliertaxregion		 = ltrim(rtrim(@suppliertaxregion))
	SELECT @owntaxregion			 = ltrim(rtrim(@owntaxregion))
	SELECT @taxregnno				 = ltrim(rtrim(@taxregnno))
	/*Code added for defect id:EBS-1360 end*/	
	/*Code Added for EBS-2378 begin */
	select @addln_info_edt		 = ltrim(rtrim(@addln_info_edt))
	select @pay_term_cntrl		 = ltrim(rtrim(@pay_term_cntrl))
	select @pay_term_desc		 = ltrim(rtrim(@pay_term_desc))
	select @vessel_flght_code	 = ltrim(rtrim(@vessel_flght_code))
	select @vessel_flght_name	 = ltrim(rtrim(@vessel_flght_name))
	select @voyage_flght_id		 = ltrim(rtrim(@voyage_flght_id))
	 
	/*Code Added for EBS-2378 end */
	/* Code added for the defect id : EBS-3331 starts here */		
	select @clsfy_gr             = ltrim(rtrim(@clsfy_gr))
	select @subclsfy_gr          = ltrim(rtrim(@subclsfy_gr))
	select @clsfy_desc_gr        = ltrim(rtrim(@clsfy_desc_gr))
	select @subclsfy_desc_gr     = ltrim(rtrim(@subclsfy_desc_gr))		
	/* Code added for the defect id : EBS-3331 ends here */	
	select @reason_for_return    = ltrim(rtrim(@reason_for_return)) --code added for EPE-45646

	-- null checking 
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
	
	IF @createdby_tmp = '~#~'
	    SELECT @createdby_tmp = NULL
	
	IF @createddate_tmp = '01/01/1900'
	    SELECT @createddate_tmp = NULL
	
	IF @ctxt_language_tmp = -915
	    SELECT @ctxt_language_tmp = NULL
	
	IF @ctxt_ouinstance_tmp = -915
	    SELECT @ctxt_ouinstance_tmp = NULL
	
	IF @ctxt_service_tmp = '~#~'
	    SELECT @ctxt_service_tmp = NULL
	
	IF @ctxt_user_tmp = '~#~'
	    SELECT @ctxt_user_tmp = NULL
	
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
	
	IF @refdoc_datemlt_tmp = '01/01/1900'
	    SELECT @refdoc_datemlt_tmp = NULL
	
	IF @refdoc_mlt_tmp = '~#~'
	    SELECT @refdoc_mlt_tmp = NULL
	
	IF @refdocfolderhr_tmp = '~#~'
	    SELECT @refdocfolderhr_tmp = NULL
	
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
	/* Code added for DTS Id. : ES_BNKDEF_00013 Begins */
	IF @egrlcno = '~#~'
	    SELECT @egrlcno = NULL  
	
	IF @egrrefid = '~#~'
	    SELECT @egrrefid = NULL  
	
	IF @egrlcexpirydate = '01/01/1900'
	    SELECT @egrlcexpirydate = NULL 
	/* Code added for DTS Id. : ES_BNKDEF_00013 Ends */

	/* Code added for DTS Id. : ES_GR_00870 Starts */
	
	IF @grlrno = '~#~' 
		Select @grlrno = null  

	IF @grlrdate = '01/01/1900' 
		Select @grlrdate = null 

	/* Code added for DTS Id. : ES_GR_00870 Ends */
/*Code added by Damodharan. R for Defect ID EPE-747 starts here*/
	IF @supp_inv_date = '01/01/1900'   
		Select @supp_inv_date = null   
		
	IF @supp_inv_no = '~#~'   
		Select @supp_inv_no = null    
 /*Code added by Damodharan. R for Defect ID EPE-747 ends here*/
   	/*Code added for defect id:EBS-1360 begins*/	
	IF @suppliertaxregion = '~#~' 
	   Select @suppliertaxregion = null  

	IF @owntaxregion = '~#~' 
		Select @owntaxregion = null  

	IF @taxregnno = '~#~' 
		Select @taxregnno = null 
	/*Code added for defect id:EBS-1360 ends*/
	
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

	--code added for EPE-45646 begins
	if @reason_for_return = '~#~'
		select	@reason_for_return	=	null
	--code added for EPE-45646 ends

	/*code added for RGTD_GR_BASEFIXES_000736 begins*/
	DECLARE @getdate udd_date
	SELECT @getdate = CONVERT(NVARCHAR(10), dbo.RES_Getdate(@ctxt_ouinstance), 120)

	--code added for EPE-31872 begins
	declare @errorid1 udd_int
	--if @calling_service != 'pex_dpr_ser_mnt_sr'
	if isnull(@calling_service,'') != 'pex_dpr_ser_mnt_sr'
	begin
   	      exec gr_pp_cmn_validation_sp	     
	      	 @ctxt_ouinstance,
	      	 @ctxt_user	,	
	      	 @ctxt_language,	
	      	 @ctxt_service,
	      	 @guid,			
	      	 'PUR_GR',		
	      	 'EDTMP_EDT',			
	      	 @receiptno_tmp,
	      	 null,			
	      	 @errorid1 output
	      	 
	      	 if @errorid1 <> 0
	      	 begin
	      	 return
	      	 end 
	end
	--code added for EPE-31872 ends

	/*code added for EBS-2378 begin*/
	select	@pps_gr_chng_cement_indus	=	FLAG_YES_NO 
	from	PPS_FEATURE_LIST(nolock)
	where	FEATURE_ID					=	'PPS_GR_CHNG_CEMENT_INDUS'
	and		COMPONENT_NAME				=	'GR'

	select	@vessel_status		= vsl_status 
	from	lgtmst_vessel_master (nolock)
	where	vsl_vessel_code		= @vessel_flght_code
	and		vsl_ou				= @ctxt_ouinstance_tmp
	
	select	@voyage_id		=	sch_voyage_no
	from	lgtmst_sailing_schedule(nolock)
	where	sch_voyage_no	=	@voyage_flght_id	
	and		sch_ou			=	@ctxt_ouinstance_tmp
					   
	/*code added for EBS-2378 end*/
	
	IF @frdate_tmp > @getdate
	BEGIN
	    --Code commented & added for ots id :GRDMS412AT_000212 starts here
	    --raiserror('Freeze date cannot be greater than current date',16,1)
	    SELECT @m_errorid = 1040207
	    --Code commented & added for ots id :GRDMS412AT_000212 ends here
	    RETURN
	END
	
	/*code added for RGTD_GR_BASEFIXES_000736 ends*/

	--code added for JAI-533 begins
	 IF @supp_inv_date is not null and (@supp_inv_date > @receiptdate_tmp )
	 BEGIN  
		 --raiserror('Supplier invoice date cannot be earlier than GR Date',16,1) 
		 exec fin_german_raiserror_sp 'GR',@ctxt_language,900027727 
		 RETURN  
	 END
	--code added for JAI-533 ends

	--Code added for PB-4898 starts
	 Select	@pps_tmp		= FLAG_YES_NO	
	 From	pps_feature_list (nolock)
	 Where	feature_id		= 'PPS_GR_LRWBBL_DATE'
	 and	component_name	= 'GR'
	 
	 IF	@pps_tmp	=	'YES'
	 Begin
		IF	@grlrdate is null
		Begin
			--Raiserror('LR\WB\BL Date cannot be blank.',16,1)
			exec fin_german_raiserror_sp 'PUR_REQ',@ctxt_language,1302  
			RETURN  
		End
	 End
	 --Code added for PB-4898 ends

	/*Code Added for the DTS ID:ES_GR_00870 Starts */
	
	IF @grlrdate > @getdate
	BEGIN
	    --raiserror('LR date cannot be greater than current date',16,1)
	    exec fin_german_raiserror_sp 'GR',@ctxt_language,1558
        select	@fin_error_tmp	=	1		--14H109_INV_MOBILE_00050	    
	    RETURN
	END
	/*Code Added for the DTS ID:ES_GR_00870 Ends */

	IF EXISTS (
	       SELECT 'DATA IS NOT MODIFIED'
	       FROM   gr_hdr_grmain(NOLOCK)
	       WHERE  gr_hdr_ouinstid = @ctxt_ouinstance_tmp
	       AND    gr_hdr_grno = @receiptno_tmp
	       AND    gr_hdr_timestamp = @timestamp_tmp
	   )
	BEGIN
	    UPDATE gr_hdr_grmain
	    SET    gr_hdr_timestamp = gr_hdr_timestamp + 1,
	           gr_hdr_modifiedby = @ctxt_user_tmp,
	           gr_hdr_modifieddate = dbo.RES_Getdate(@ctxt_ouinstance)
	    WHERE  gr_hdr_ouinstid = @ctxt_ouinstance_tmp
	    AND    gr_hdr_grno = @receiptno_tmp
	END
	ELSE
	BEGIN
	    --data modified by another user . refresh the page
	    --method error id =1400807
	    SELECT @m_errorid = 1400583 
	    RETURN
	END

	-- check the status of the document
	SELECT @statuscode = gr_hdr_grstatus,
	       @authdate = gr_hdr_orderapprdate /* Code added by Ramya.R for MCL_GR_BASEFIXES_000044 */
	FROM   gr_hdr_grmain(NOLOCK)
	WHERE  gr_hdr_ouinstid = @ctxt_ouinstance_tmp
	AND    gr_hdr_grno = @receiptno_tmp
	
	IF @statuscode = 'DL'
	BEGIN
	    /*receipt doc is not in valid status */
	    SELECT @m_errorid = 1407000
	    RETURN
	END
	/*Code modified for ES_GR_00417 begins here*/
	--IF @statuscode NOT IN ('DR', 'FR', 'PF', 'VF')
	/* Code commented and added for EPE-32585 Begins */
	--IF @statuscode NOT IN ('DR', 'FR', 'PF', 'VF', 'PM')
	IF @statuscode NOT IN ('DR', 'FR', 'PF', 'VF', 'PM','QR')
	/* Code commented and added for EPE-32585 Ends */
	   /*Code modified for ES_GR_00417 ends here*/
	BEGIN
	    /*receipt doc is already freezed */
	    SELECT @m_errorid = 1403299 
	    RETURN
	END 
	
	/* Code added by Ramya.R for MCL_GR_BASEFIXES_000044 begins */
	IF CONVERT(NVARCHAR(10), @gatepassdate_tmp, 120) > @getdate
	BEGIN
	    EXEC fin_german_raiserror_sp 'GR',
	         @ctxt_language_tmp,
	         90
        select	@fin_error_tmp	=	1		--14H109_INV_MOBILE_00050	    
	    
	    RETURN
	END
	IF CONVERT(NVARCHAR(10), @gatepassdate_tmp, 120) < CONVERT(NVARCHAR(10), @authdate, 120)
	BEGIN
	    EXEC fin_german_raiserror_sp 'GR',
	         @ctxt_language_tmp,
	         91
        select	@fin_error_tmp	=	1		--14H109_INV_MOBILE_00050	    
	    
	    RETURN
	END

	IF CONVERT(NVARCHAR(10), @delynotedate_tmp, 120) > @getdate
	BEGIN
	    EXEC fin_german_raiserror_sp 'GR',
	         @ctxt_language_tmp,
	         92
        select	@fin_error_tmp	=	1		--14H109_INV_MOBILE_00050	    
	    
	    RETURN
	END
	
	IF CONVERT(NVARCHAR(10), @delynotedate_tmp, 120) < CONVERT(NVARCHAR(10), @authdate, 120)
	BEGIN
	    EXEC fin_german_raiserror_sp 'GR',
	         @ctxt_language_tmp,
	         93
        select	@fin_error_tmp	=	1		--14H109_INV_MOBILE_00050	    
	    
	    RETURN
	END
	/* Code added by Ramya.R for MCL_GR_BASEFIXES_000044 ends */
	
	-- fetch lo
	DECLARE @lo_id       udd_loid
	DECLARE @bu_id       udd_buid	
	DECLARE @return_val  udd_int --int
	DECLARE @errmsg      udd_desc255
	
	SELECT @lo_id = lo_id,
	       @bu_id = bu_id,
	       @companycode	= company_code--EPE-747
	FROM   emod_lo_bu_ou_vw(NOLOCK)
	WHERE  ou_id = @ctxt_ouinstance
	AND    @receiptdate_tmp BETWEEN ISNULL(effective_from, '01-01-1900') 
	       AND ISNULL(effective_to, '01-01-9999') 
	
	-- call date validation sp
	
	DECLARE @errid     udd_int --int
	DECLARE @execflag  udd_execflag
	
	EXEC gr_com_valrcpdate_sp
	     @ctxt_language_tmp,
	     @ctxt_ouinstance_tmp,
	     @ctxt_service_tmp,
	     @ctxt_user_tmp,
	     @receiptno_tmp,
	     NULL,
	     @receiptdate_tmp,
	     @referencedochr_tmp,	--NULL, /*Code modified for ES_GR_00353*/
	     @created_at_tmp,	--NULL, /*Code modified for ES_GR_00353*/
	     @refdoc_mlt_tmp,	--NULL, /*Code modified for ES_GR_00353*/
	     @amend_no_tmp,	--NULL, /*Code modified for ES_GR_00353*/
	     NULL,
	     NULL,
	     'EH',
	     @errid OUT
	
	IF @errid <> 0
	BEGIN
	    SELECT @m_errorid = @errid
	    RETURN
	END 
	
	-- validate consignment weight
	
	DECLARE @uomou_tmp udd_ctxt_ouinstance
	
	IF @totalconsignwt_tmp IS NOT NULL
	BEGIN
	    SELECT @uomou_tmp = destinationouinstid
	    FROM   depdb..fw_admin_view_comp_intxn_model(NOLOCK)
	    WHERE  sourcecomponentname = 'GR'
	    AND    sourceouinstid = @ctxt_ouinstance_tmp
	    AND    destinationcomponentname = 'UOMADMIN'
	    
	    IF EXISTS (
	           SELECT 'FRACTIONS NOT ALLOWED'
	           FROM   uom_master_vw(NOLOCK)
	           WHERE  uom_ou = @uomou_tmp
	           AND    uom_code = @unitofmeasure_tmp
	           AND    uom_fraction_allowed = 0
	       )
	    AND @totalconsignwt_tmp <> CEILING(@totalconsignwt_tmp)
	    BEGIN
	        SELECT @m_errorid = 1404444
	        RETURN
	    END
	END
	
	-- check whether receipt can be made for suspended supplier
	
	DECLARE @flag        udd_metadata_code
	DECLARE @suppou_tmp  udd_ctxt_ouinstance
	
	--cml BEGIN
	SELECT @flag = parameter_value
	FROM   ops_processparam_vw(NOLOCK)
	WHERE  ou_id = @ctxt_ouinstance_tmp
	AND    parameter_code = 'GRFORSUSPSUP'
	--cml END
	DECLARE @tmprefdoc udd_metadata_code
	
	SELECT @tmprefdoc = paramcode
	FROM   component_metadata_table(NOLOCK)
	WHERE  componentname = 'GR'
	       /* Code has been modified for GRDMS412AT_000589 begins */
	       -- 	and	paramcategory	=	'META'
	AND    paramcategory = 'CSENUM'
	       /* Code has been modified for GRDMS412AT_000589 ends */
	AND    paramtype = 'REF_DOC'
	AND    paramdesc = @referencedochr_tmp
	AND    langid = @ctxt_language_tmp

	/* Code added for EPE-58138 begins */
	Declare @pps_flag_ordacc  udd_flag,
			@accepdate        udd_date,
	        @accstatus        udd_status

	if exists (	Select 'X'
				from	cmn_addl_fn_param_metadata_ou with(nolock)
				where	cmn_addl_id			= 'PPS_blockGR_afteracceptdate_rejectline'
				and		cmn_addl_comp_name	= 'GR'
				and 	cmn_addl_ou			= @ctxt_ouinstance
			)
	Begin
		Select @pps_flag_ordacc		= cmn_addl_flag
		from   cmn_addl_fn_param_metadata_ou with (nolock)
		where  cmn_addl_ou			= @ctxt_ouinstance
		and    cmn_addl_id          = 'PPS_blockGR_afteracceptdate_rejectline'
		and    cmn_addl_comp_name   = 'GR'
	End
	Else
	Begin
		select	@pps_flag_ordacc	= cmn_addl_flag
		from 	cmn_addl_fn_param_metadata (nolock)
		where 	cmn_addl_id			= 'PPS_blockGR_afteracceptdate_rejectline'
		and		cmn_addl_comp_name	= 'GR'
	End
    
	if  isnull(@pps_flag_ordacc,'') = 'YES'
	begin 
	    if exists ( Select 'X'
				    from	oacp_orderaccp_dtl with (nolock)
					where	oacp_ou			=	@ctxt_ouinstance
					and		oacp_refdoctype	=	@referencedochr_tmp
					and		oacp_refdocno   =	@refdoc_mlt_tmp
					and		oacp_amendno    =	@amend_no_tmp
				  )
	    begin 
			Select @accepdate		= oacp_oadate, 
			       @accstatus		= oacp_status
			from   oacp_orderaccp_dtl with (nolock)
			where  oacp_ou			= @ctxt_ouinstance
			and    oacp_refdoctype	= @referencedochr_tmp
			and    oacp_refdocno    = @refdoc_mlt_tmp
			and    oacp_amendno     = @amend_no

			if isnull(@receiptdate_tmp,'') <  isnull(@accepdate,'') 
			begin
				--raiserror('GR cannot be allowed less than Acceptance Date',16,1)
				exec fin_german_raiserror_sp 'GR',@ctxt_language,900028033
				return
			end
			if @accstatus in ('N')
			begin
				--raiserror('GR modification should not be allowed for Rejected order %s.',16,1)
				exec fin_german_raiserror_sp 'GR',@ctxt_language,900028040,@refdoc_mlt_tmp
				return
			end
		end
		else
		begin
			if exists ( Select 'X'
					    from	supprt_ord_Acc_Rej_dtl with (nolock)
						where	supprt_ordou		=	@ctxt_ouinstance
						and		supprt_refdoctype	=	@referencedochr_tmp
						and		supprt_orddocno		=	@refdoc_mlt_tmp
						and		supprt_amdno		=	@amend_no)
			begin	
				Select @ctxt_ouinstance = @ctxt_ouinstance
			end
			else
			begin
				--raiserror('Order level Acceptance details has not been recorded',16,1)
				exec fin_german_raiserror_sp 'GR',@ctxt_language,900028035
				return
			end
		end
	end
	/* Code added for EPE-58138 ends */
	
	IF @flag = 'N'
	AND @tmprefdoc <> 'SO'
	BEGIN
	    -- fetch supplier interaction ou
	    
	    SELECT @suppou_tmp = destinationouinstid
	    FROM   depdb..fw_admin_view_comp_intxn_model(NOLOCK)
	    WHERE  sourcecomponentname = 'GR'
	    AND    sourceouinstid = @ctxt_ouinstance_tmp
	    AND    destinationcomponentname = 'SUPP'
	    
	    EXEC sup_sp_existactstat_chk
	         @ctxt_language_tmp,
	         @suppou_tmp,
	         @ctxt_service_tmp,
	         @ctxt_user_tmp,
	         'GR',
	         @lo_id,
	         @suppcusthdr_tmp,
	         @execflag OUT,
	         @errmsg OUT,
	         @return_val OUT 
	    
	    IF @execflag <> 0
	    BEGIN
	        SELECT @m_errorid = @return_val
	        RETURN
	    END
	END 
	
	/* Code added for GRDMS412AT_000535 begins */
	
	IF (
	       @tareweight_tmp IS NOT NULL
	   AND @totalconsignwt_tmp IS NOT NULL
	   AND @Gross_wt_tmp IS NOT NULL
	 )
	BEGIN
	    IF (@Gross_wt_tmp <> (@totalconsignwt_tmp + @tareweight_tmp))
	    BEGIN
	        --  			raiserror('The Gross weight should be equal to the sum of net weight of and tareweight.',16,1)
	        SELECT @m_errorid = 900027469
	        RETURN
	    END
	END
	
	IF (
	       @totalconsignwt_tmp IS NOT NULL
	   AND @Gross_wt_tmp IS NOT NULL
	   )
	BEGIN
	    IF (@Gross_wt_tmp < @totalconsignwt_tmp)
	    BEGIN
	        --  			raiserror('The Gross weight Cannot be less that net weight.',16,1)
	        SELECT @m_errorid = 900027470
	        RETURN
	    END
	END
	
	IF (@tareweight_tmp IS NOT NULL AND @Gross_wt_tmp IS NOT NULL)
	BEGIN
	    IF (@Gross_wt_tmp < @tareweight_tmp)
	    BEGIN
	        --  			raiserror('The Gross weight Cannot be less than tareweight.',16,1)
	        SELECT @m_errorid = 900027471
	        RETURN
	    END
	END
	
	
	IF @tareweight_tmp IS NOT NULL
	AND @unitofmeasure_tmp IS NULL
	BEGIN
	    SELECT @m_errorid = 11400013 
	    RETURN
	END     
	
	IF @totalconsignwt_tmp IS NOT NULL
	AND @unitofmeasure_tmp IS NULL
	BEGIN
	    SELECT @m_errorid = 11400015--11400014  /*Code Modifed for GRDMS412AT_000535 */     
	    RETURN
	END     
	
	IF @Gross_wt_tmp IS NOT NULL
	AND @unitofmeasure_tmp IS NULL
	BEGIN
	    SELECT @m_errorid = 11400014--11400015 /*Code Modifed for GRDMS412AT_000535 */   
	    RETURN
	END     
	
	IF @unitofmeasure_tmp IS NOT NULL
	    IF @tareweight_tmp IS NULL
	    AND @totalconsignwt_tmp IS NULL
	    AND @Gross_wt_tmp IS NULL
	    BEGIN
	        SELECT @m_errorid = 11400016 
	        RETURN
	    END 
	
	/* Code  modified for weight check on 12/01 GRDMS412AT_000535 begins */
	IF @totalconsignwt_tmp < 0
	OR @Gross_wt_tmp < 0
	OR @tareweight_tmp < 0
	BEGIN
	    SELECT @m_errorid = 900027481
	    RETURN
	END
	
	IF @totalconsignwt_tmp IS NOT NULL
	AND (@Gross_wt_tmp IS NULL AND @tareweight_tmp IS NULL)
	BEGIN
	    SELECT @m_errorid = 900027482
	    RETURN
	END
	
	
	IF @Gross_wt_tmp IS NOT NULL
	AND (@totalconsignwt_tmp IS NULL AND @tareweight_tmp IS NULL)
	BEGIN
	    SELECT @m_errorid = 900027482
	    RETURN
	END
	
	
	IF @tareweight_tmp IS NOT NULL
	AND (@Gross_wt_tmp IS NULL AND @totalconsignwt_tmp IS NULL)
	BEGIN
	    SELECT @m_errorid = 900027482
	    RETURN
	END
	
	IF @totalconsignwt_tmp IS NULL
	AND (@Gross_wt_tmp IS NOT NULL AND @tareweight_tmp IS NOT NULL)
	BEGIN
	    SELECT @totalconsignwt_tmp = @Gross_wt_tmp + @tareweight_tmp
	END
	
	IF @Gross_wt_tmp IS NULL
	AND (
	        @totalconsignwt_tmp IS NOT NULL
	    AND @tareweight_tmp IS NOT NULL
	    )
	BEGIN
	    SELECT @Gross_wt_tmp = @totalconsignwt_tmp - @tareweight_tmp
	END
	
	IF @tareweight_tmp IS NULL
	AND (
	        @Gross_wt_tmp IS NOT NULL
	    AND @totalconsignwt_tmp IS NOT NULL
	    )
	BEGIN
	    /*Code Commented and Added by Ananth P. against : GRDMS412AT_000640 Begins */
	    --select	@tareweight_tmp = @totalconsignwt_tmp - @Gross_wt_tmp
	    SELECT @tareweight_tmp = @Gross_wt_tmp - @totalconsignwt_tmp
	           /*Code Commented and Added by Ananth P. against : GRDMS412AT_000640 Ends */
	END
	
	/* Code modified for weight check on  12/01 GRDMS412AT_000535 ends */
	
	/* Code added for GRDMS412AT_000535 ends */

/*code added for EBS-2378 begin*/

	if @pps_gr_chng_cement_indus = 'Yes'
	begin
		if @vessel_flght_code is not null
		begin
			if @vessel_status is null
			begin		
					--Vessel code does not exist.
					exec fin_german_raiserror_sp 'GR',@ctxt_language,1601
					return
			end
			else if  @vessel_status <> 'AC'
			begin		
					--Vessel code is not in valid status.
					exec fin_german_raiserror_sp 'GR',@ctxt_language,1602
					return
			end
		end
		if @voyage_flght_id is not null
		begin
			if @voyage_id is null
			begin		
				--Voyage Id does not exist.
				exec fin_german_raiserror_sp 'GR',@ctxt_language,1603
				return
			end
		end
	end
	/*code added for EBS-2378 end*/ 


	--ES_GR_02564 Starts

	 SELECT @tmpcreatedou = ouinstid  
	 FROM fw_admin_view_ouinstance(NOLOCK)  
	 WHERE ouinstname = @created_at_tmp 


	DECLARE @tmpreffereddoc  udd_metadata_code  
   
	IF @referencedochr_tmp IS NOT NULL  
     SELECT @tmpreffereddoc = paramcode  
     FROM component_metadata_table(NOLOCK)  
     WHERE componentname = 'GR'  
     AND   paramcategory = 'META'  
     AND   paramtype = 'REFD_DOC'  
     AND   paramdesc = @referreddochdr_tmp  
     AND   langid = @ctxt_language_tmp
	 
	 
	 
	 IF ISNULL(@tmpreffereddoc, 'NN') <> 'PG'  
	BEGIN  
    
     IF @tmprefdoc = 'PO'  
         SELECT  @exchgrate = exchgrate,
				@currency = convert(nvarchar(10),currency)--currency  --Code modified for PEPS-2454
         FROM gr_po_hdr_vw(NOLOCK)  
         WHERE referencedoc = @tmprefdoc  
         AND   ouinstid = @tmpcreatedou  
         AND   docno = @refdoc_mlt_tmp  
         AND   amendno = @amend_no_tmp  
       
     IF @tmprefdoc = 'RS'  
         SELECT @exchgrate = exchgrate,
				@currency = convert(nvarchar(10),currency)--currency  --Code modified for PEPS-2454
         FROM gr_rs_hdr_vw(NOLOCK)  
         WHERE referencedoc = @tmprefdoc  
         AND   ouinstid = @tmpcreatedou  
         AND   docno = @refdoc_mlt_tmp  
         AND   amendno = @amend_no_tmp  
       
     IF @tmprefdoc = 'SO'  
         SELECT @exchgrate = exchgrate,
				@currency = convert(nvarchar(10),currency)--currency --Code modified for PEPS-2454
         FROM gr_so_hdr_vw(NOLOCK)  
         WHERE referencedoc = @tmprefdoc  
         AND   ouinstid = @tmpcreatedou  
         AND   docno = @refdoc_mlt_tmp  
         AND   amendno = @amend_no_tmp  
       
     IF @tmprefdoc = 'SR'  
         SELECT @exchgrate = exchgrate,
				@currency = convert(nvarchar(10),currency)--currency --Code modified for PEPS-2454
         FROM gr_sr_hdr_vw(NOLOCK)  
         WHERE referencedoc = @tmprefdoc  
         AND   ouinstid = @tmpcreatedou  
         AND   docno = @refdoc_mlt_tmp  
         AND   amendno = @amend_no_tmp  
       
     IF @tmprefdoc = 'SC'  
         SELECT @exchgrate = exchgrate,
				@currency = convert(nvarchar(10),currency)--currency  --Code modified for PEPS-2454
         FROM gr_sc_hdr_vw(NOLOCK)  
         WHERE referencedoc = @tmprefdoc  
         AND   ouinstid  = @tmpcreatedou  
		 AND    docno	 = @refdoc_mlt_tmp  
		 AND   amendno   = @amend_no_tmp  
       
     IF @tmprefdoc = 'GR'  
         SELECT  @exchgrate = grn_hdr_exchrate,
				@currency	= convert(nvarchar(10),grn_hdr_currency)--grn_hdr_currency  --Code modified for PEPS-2454
         FROM grn_hdr_grnmain(NOLOCK)  
         WHERE grn_hdr_ouinstid = @tmpcreatedou  
         AND   grn_hdr_grnno = @refdoc_mlt_tmp  
 END  
  
 IF EXISTS (  
        SELECT 'x'  
        FROM ops_processparam_vw(NOLOCK)  
        WHERE ou_id = @ctxt_ouinstance_tmp  
        AND   parameter_type = 'PURSYS'  
        AND   parameter_code = 'DEFORDEXCHGRATE'  
        AND   parameter_value = 'N'  
    )  
 BEGIN  
     DECLARE @basecurrency_tmp    udd_currencycode,  
             @exchangerate1_tmp   udd_exchangerate,  
             @maxlimit_tmp        udd_amount,  
             @minlimit_tmp        udd_amount,  
             @exratecategory_tmp  udd_text255,  
             @currencyunits_tmp   udd_rowno,  
           --  @companycode         udd_company,  
             @defparamvalue       udd_text255,  
             @error_tmp           udd_errorid     
       
     SELECT @companycode = company_code  
     FROM emod_ou_vw(NOLOCK)  
     WHERE ou_id = @ctxt_ouinstance_tmp  
     AND   @getdate BETWEEN effective_from AND ISNULL(effective_to, @getdate)  
       
     SELECT @basecurrency_tmp = currency_code  
     FROM emod_basecurr_vw(NOLOCK)  
     WHERE company_code = @companycode  
     AND   flag = 'B'  
     AND   @getdate BETWEEN effective_from AND ISNULL(effective_to, @getdate)        
       
     SELECT @defparamvalue = parameter_value  
     FROM ops_processparam_vw(NOLOCK)  
     WHERE ou_id = @ctxt_ouinstance_tmp  
     AND   parameter_type = 'PFYS'  
     AND   parameter_code = 'PURERTYPE'     
       
     EXEC @error_tmp = erate_sysact_spgetexcgrate   
          @ctxt_ouinstance_tmp,  
          @ctxt_user_tmp,  
          @ctxt_language_tmp,  
          @currency,  
          @basecurrency_tmp,  
          @receiptdate_tmp,  
          @defparamvalue, -- '~BR~',            
          @exchangerate1_tmp OUTPUT,  
          @maxlimit_tmp OUTPUT,  
          @minlimit_tmp OUTPUT,  
          @exratecategory_tmp OUTPUT,  
          @currencyunits_tmp OUTPUT,  
          'GR'        
       
     SELECT @exchgrate = @exchangerate1_tmp  
 END 
 --ES_GR_02564 Ends

	/* Code added for DTS Id. : ES_BNKDEF_00013 Begins */
	IF (@egrlcno IS NOT NULL AND @egrlcno <> '')
	OR (@egrrefid IS NOT NULL AND @egrrefid <> '')
	BEGIN
	    DECLARE @temp_po_lc_ou     udd_ctxt_ouinstance,
	            @temp_loid         udd_loid,
	            @temp_paymode      udd_metadata_code,
	            @errorid           udd_errorid,
	            /* Code added for DTS Id. : 8H123-3_GR_00002 Begins */
	            @temp_doc_type     udd_metadata_code,
	            @temp_doc_no       udd_documentno,
	            @temp_doc_amendno  udd_poamendmentno,
	            @temp_doc_ou       udd_ctxt_ouinstance
	    
	    SELECT @temp_doc_type = gr_hdr_orderdoc
	    FROM   gr_hdr_grmain(NOLOCK)
	    WHERE  gr_hdr_grno = @receiptno_tmp
	    AND    gr_hdr_ouinstid = @ctxt_ouinstance_tmp
	    
	    IF @temp_doc_type = 'CC'
	    BEGIN
	        SELECT @temp_doc_no = gr.gr_hdr_refdocno,
	               @temp_doc_amendno = cc.crgclr_hdr_refdocamend,
	               @temp_doc_ou = cc.crgclr_hdr_refdocou
	        FROM   gr_hdr_grmain gr(NOLOCK),
	               gr_crgclr_hdr cc(NOLOCK)
	        WHERE  gr.gr_hdr_grno = @receiptno_tmp
	        AND    gr.gr_hdr_ouinstid = @ctxt_ouinstance_tmp
	        AND    cc.crgclr_hdr_orderno = gr.gr_hdr_orderno
	        AND    cc.crgclr_hdr_orderou = gr.gr_hdr_orderou
	    END
	    
	    IF @temp_doc_type = 'PO'
	    BEGIN
	        SELECT @temp_doc_no = gr_hdr_orderno,
	               @temp_doc_amendno = gr_hdr_orderamendno,
	               @temp_doc_ou = gr_hdr_orderou
	        FROM   gr_hdr_grmain(NOLOCK)
	        WHERE  gr_hdr_grno = @receiptno_tmp
	        AND    gr_hdr_ouinstid = @ctxt_ouinstance_tmp
	    END
	    /* Code added for DTS Id. : 8H123-3_GR_00002 Ends */
	    
	    SELECT @temp_paymode = paytm_paymode
	    FROM   po_paytm_doclevel_detail(NOLOCK)
	           /* Code modified for DTS Id. : 8H123-3_GR_00002 Begins */
	    WHERE  paytm_pono = @temp_doc_no
	    AND    paytm_poamendmentno = @temp_doc_amendno
	    AND    paytm_poou = @temp_doc_ou
	    /* Code modified for DTS Id. : 8H123-3_GR_00002 Ends */
	    IF @temp_paymode = 'LC'
	    BEGIN
	        SELECT @temp_po_lc_ou = destinationouinstid
	        FROM   fw_admin_view_comp_intxn_model(NOLOCK)
	        WHERE  sourcecomponentname = 'PO'
	        AND    sourceouinstid = @temp_doc_ou /* Code modified for DTS Id. : 8H123-3_GR_00002 */
	        AND    destinationcomponentname = 'LC'
	        
	        SELECT @temp_loid = lo_id
	        FROM   emod_lo_bu_ou_vw(NOLOCK)
	        WHERE  ou_id = @temp_po_lc_ou
	        
	        EXEC gr_lcno_refid_cmnval_sp
	             @ctxt_service_tmp,
	             @guid_tmp,
	           @ctxt_ouinstance_tmp,
	             @receiptno_tmp,
	             @receiptdate_tmp,
	             @egrlcno OUTPUT,
	             @egrrefid OUTPUT,
	             @temp_doc_no,	/* Code modified for DTS Id. : 8H123-3_GR_00002 */
	             @ctxt_language_tmp,
	             @errorid OUTPUT
	        
	        IF @errorid <> 0
	        BEGIN
	            EXEC lc_cmnsp_error_handle_sp
	                 @errorid,
	          'LC_UI_VAL',
	                 @ctxt_language_tmp,
	                 @errorid OUTPUT
	            
	            RETURN
	        END
	        
	        SELECT @errorid = 0
	        
	        EXEC gr_ordlc_temptable_upd_sp
	             @guid_tmp,
	             @ctxt_ouinstance_tmp,
	             @receiptno_tmp,
	             @egrrefid,
	             @egrlcno,
	             @temp_loid,
	       @errorid OUTPUT
	        
	        IF @errorid <> 0
	        BEGIN
	            RETURN
	        END
	        
	        IF EXISTS (
	               SELECT 'X'
	               FROM   lc_ord_process_tmp(NOLOCK)
	               WHERE  lop_guid = @guid_tmp
	           )
	        BEGIN
	            DELETE 
	            FROM   lc_ord_process_tmp
	            WHERE  lop_guid = @guid_tmp
	        END
	    END
	    ELSE
	    BEGIN
	        --			LC No./ Ref. Id. can be specified only for the Purchase Order has Pay Mode as LC.
	        EXEC fin_german_raiserror_sp 'GR',
	             @ctxt_language_tmp,
	             204
			select	@fin_error_tmp	=	1		--14H109_INV_MOBILE_00050	    
	        
	        RETURN
	    END
	END
	/* Code added for DTS Id. : ES_BNKDEF_00013 Ends */
	-- update header table
	
	UPDATE gr_hdr_grmain
	SET    gr_hdr_grdate = @receiptdate_tmp,
	       gr_hdr_grfolder = @receiptfolder_tmp,
	       gr_hdr_gatepassno = @gatepassno_tmp,
	       gr_hdr_gatepassdate = @gatepassdate_tmp,
	       gr_hdr_transmode = @transmode_tmp,
	       gr_hdr_carriername = @carriername_tmp,
	       gr_hdr_vehicleno = @vehicle_noml_tmp,
	       gr_hdr_noofitems = @noofpackages_tmp,
	       gr_hdr_consweight = @totalconsignwt_tmp,
	       gr_hdr_consuom = @unitofmeasure_tmp,
	       gr_hdr_delynoteno = @delynoteno_tmp,
	       gr_hdr_delynotedate = @delynotedate_tmp,
	       gr_hdr_empcode = @empcode_tmp,
	       gr_hdr_shipfromid = @shippedfromhr_tmp,
	       gr_hdr_frdate = @frdate_tmp,
	       gr_hdr_modifiedby = @ctxt_user_tmp,
	  gr_hdr_modifieddate = dbo.RES_Getdate(@ctxt_ouinstance),
	       /* code added by Mahalakshmi S for bug id GRBASEFIXES_000103  starts here */
	       gr_hdr_remarks = @poremark_tmp,
	       /* code added by Mahalakshmi S for bug id GRBASEFIXES_000103  ends here */
	       /* Code has been modified for GRDMS412AT_000574 begins */
	       /* Code added for GRDMS412AT_000535 begins */
	       -- 		gr_hdr_grossweight 	= 	@tareweight ,
	       -- 		gr_hdr_weight  		= 	@Gross_wt_tmp    
	       /* Code added for GRDMS412AT_000535 ends */
	       gr_hdr_tareweight = @tareweight_tmp,
	       gr_hdr_grossweight = @Gross_wt_tmp,
	       gr_hdr_weight = @totalconsignwt_tmp,
	       /* Code has been modified for GRDMS412AT_000574 begins */
	       gr_hdr_entryno = @entryno_tmp,	/*Code added by Ananth P. against: ES_GR_00088*/
	       /* Code added for DTS Id. : ES_BNKDEF_00013 Begins */
	       gr_hdr_lc_no = @egrlcno,
	       gr_hdr_ref_id = @egrrefid,
	       /* Code added for DTS Id. : ES_BNKDEF_00013 Ends */
		  /* Code added for DTS Id. : ES_GR_00870 Starts */
		   gr_hdr_lr_no		=	@grlrno,	
		   gr_hdr_lr_date	=	@grlrdate
	  /* Code added for DTS Id. : ES_GR_00870 Ends*/
	       /*Code added by Damodharan. R for Defect ID EPE-747 starts here*/
	       ,gr_hdr_suppinvno	=	@supp_inv_no,
	       gr_hdr_suppinvdate	=	@supp_inv_date
	       /*Code added by Damodharan. R for Defect ID EPE-747 ends here*/
		   /*code added for defect id:EBS-1360 begins*/
		   ,gr_hdr_party_tax_region		=	@suppliertaxregion
		   ,gr_hdr_party_regd_no		=	@taxregnno
		   ,gr_hdr_own_tax_region		=	@owntaxregion
			/*code added for defect id:EBS-1360 ends*/
			/*code added for EBS-2378 begin*/
			,gr_hdr_vessel_code			=	@vessel_flght_code
			,gr_hdr_vessel_name			=	@vessel_flght_name
			,gr_hdr_voyage_ID			=	@voyage_flght_id
			,gr_hdr_additional_info		=	@addln_info_edt
			/*code added for EBS-2378 end*/
			,gr_hdr_exchrate = @exchgrate --Code added for RNCC-389
	WHERE  gr_hdr_ouinstid = @ctxt_ouinstance_tmp
	AND    gr_hdr_grno = @receiptno_tmp

	--EPE-747
	/*Code commented for RTrack ID EPE-1618 starts here*/
	/*
	select @errid = 0
	exec fin_cmn_sp_gstvalidate	@ctxt_ouinstance_tmp,
								@ctxt_user,
								@ctxt_language,
								@ctxt_service,
								@companycode,
								@suppcusthdr_tmp,
								@supp_inv_no,
								@supp_inv_date,
								@receiptno_tmp,
								'PUR_GR',
								@errormsg out,
								@exec_flag out,
								@errid out
								
	if @errid <> 0
	begin
		exec fin_german_raiserror_sp 'GSTRECON',@ctxt_language,'', @errormsg
		return
	end	
	*/
	/*Code commented for RTrack ID EPE-1618 starts here*/
	--EPE-747
	
	-- output fields in resultset
	
	/*Code Added for 14H109_INV_MOBILE_00050 begin*/
	if	@calling_service	is	null
	begin
	/*Code Added for 14H109_INV_MOBILE_00050 end*/
	
	SELECT 1 'FPROWNO'
	
	end	--14H109_INV_MOBILE_00050
	
	SET NOCOUNT OFF
END

--sample to execute the stored procedure--
/*
declare @p1  int 
set @p1=null
exec gr_emn_sp_edt_hdrsav amend_no,autoinvoicing1,bscotype,carriername,contactperson,created_at,createdby,createddate,ctxt_language,ctxt_ouinstance,ctxt_service,ctxt_user,date,delynotedate,delynoteno,empcode,ename,entryno,frdate,frlevelenu1,gatepassdate,





gatepassno,guid,invbeforegrhr,lastmodby,linestatus,lmodate,noofpackages,poremark,receiptdate,receiptfolder,receiptno,refdoc_datemlt,refdoc_mlt,refdocfolderhr,referencedochr,referreddochdr,referreddoclinenohr,referreddocnohr,shippedfromhr,status,statuscode





,suppcusthdr,timestamp,totalconsignwt,transmode,unitofmeasure,unloadingdocno,vehicle_noml,@p1 output
select @p1 
*/


