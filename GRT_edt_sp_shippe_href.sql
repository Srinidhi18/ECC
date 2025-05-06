/*$File_version=ms4.3.0.04$*/
/******************************************************************************/
/* Procedure					: GRT_edt_sp_shippe_href					  */
/* Description					: 											  */
/******************************************************************************/
/* Project						: 											  */
/* EcrNo						: 											  */
/* Version						: 											  */
/******************************************************************************/
/* Referenced					: 											  */
/* Tables						: 											  */
/******************************************************************************/
/* Development history			: 											  */
/******************************************************************************/
/* Author						: Vasanthi									  */
/* Date							: Nov 12 2020  1:51PM						  */
/******************************************************************************/
/* Modification History			: 											  */
/******************************************************************************/
/* Modified By					: 											  */
/* Date							: 											  */
/* Description					: 											  */
/* Banurekha B                31/1/2024                            SSIU-261   */
/* Banurekha B                1/2/2024                             SSIU-263   */
/******************************************************************************/

create Procedure GRT_edt_sp_shippe_href
	@ctxt_ouinstance  	udd_ctxt_ouinstance, --Input 
	@ctxt_user        	udd_ctxt_user, --Input 
	@ctxt_language    	udd_ctxt_language, --Input 
	@ctxt_service     	udd_ctxt_service, --Input 
	@addressdet_edtgr 	udd_desc255, --Input/Output
	@guid             	udd_guid, --Input/Output
	@receiptno        	udd_documentno, --Input/Output
	@recno            	udd_documentno, --Input/Output
	@refdoc_mlt       	udd_documentno, --Input/Output
	@shipfromid_edtgr 	udd_ou, --Input/Output
	@shippedfromhr    	udd_ou, --Input/Output
	@suppcusthdr      	udd_customer_id, --Input/Output
	@m_errorid        	udd_int output --To Return Execution Status
as
Begin
	-- nocount should be switched on to prevent phantom rows
	Set nocount on
	-- @m_errorid should be 0 to Indicate Success
	Set @m_errorid = 0

	--declaration of temporary variables


	--temporary and formal parameters mapping

	Select @ctxt_user         = ltrim(rtrim(@ctxt_user))
	Select @ctxt_service      = ltrim(rtrim(@ctxt_service))
	Select @addressdet_edtgr  = ltrim(rtrim(@addressdet_edtgr))
	Select @guid              = ltrim(rtrim(@guid))
	Select @receiptno         = ltrim(rtrim(@receiptno))
	Select @recno             = ltrim(rtrim(@recno))
	Select @refdoc_mlt        = ltrim(rtrim(@refdoc_mlt))
	Select @shipfromid_edtgr  = ltrim(rtrim(@shipfromid_edtgr))
	Select @shippedfromhr     = ltrim(rtrim(@shippedfromhr))
	Select @suppcusthdr       = ltrim(rtrim(@suppcusthdr))

	--null checking

	IF @ctxt_ouinstance = -915
		Select @ctxt_ouinstance = null  

	IF @ctxt_user = '~#~' 
		Select @ctxt_user = null  

	IF @ctxt_language = -915
		Select @ctxt_language = null  

	IF @ctxt_service = '~#~' 
		Select @ctxt_service = null  

	IF @addressdet_edtgr = '~#~' 
		Select @addressdet_edtgr = null  

	IF @guid = '~#~' 
		Select @guid = null  

	IF @receiptno = '~#~' 
		Select @receiptno = null  

	IF @recno = '~#~' 
		Select @recno = null  

	IF @refdoc_mlt = '~#~' 
		Select @refdoc_mlt = null  

	IF @shipfromid_edtgr = '~#~' 
		Select @shipfromid_edtgr = null  

	IF @shippedfromhr = '~#~' 
		Select @shippedfromhr = null  

	IF @suppcusthdr = '~#~' 
		Select @suppcusthdr = null  

		 declare  @tran_date    udd_date    
  declare  @lo_id        udd_loid    
  declare  @bu_id        udd_loid    
  declare  @supplier     udd_desc20  
  select  @tran_date =    dbo.RES_Getdate(@ctxt_ouinstance)    
      
  exec  scm_get_emod_details    
    @ctxt_ouinstance ,        
    @tran_date  ,    
    @lo_id out,        
    @bu_id out,        
    @m_errorid  out    
      
  if @m_errorid <>   0    
  begin      
  return    
   end   
   
 --SSIU-261
 declare    @shipfromid_add udd_desc255              
       
 Select @shipfromid_add = isnull(supp_addr_addid,'')+Space(3)+isnull(supp_addr_address1,'')+Space(3)+isnull(supp_addr_address2,'')+Space(3)+      
 isnull(supp_addr_address3,'')+Space(3)+isnull(supp_addr_city,'')+Space(3)+isnull(supp_addr_state,'')+Space(3)+isnull(supp_addr_zip,'')+Space(3)+isnull(supp_addr_phone,'')         
 from     supp_addr_address(nolock)             
 where  supp_addr_loid    = @lo_id                  
 AND   supp_addr_supcode   = @suppcusthdr           
 and   supp_addr_addid    = ISNULL(@shippedfromhr,supp_addr_addid) 
 --SSIU-261
   
   Select  
			@guid				'guid',   
			@refdoc_mlt			'refdoc_mlt',   
			--@ref_doc_hdn		'ref_doc_hdn',   
			/*code reverted against the id SSIU-263 starts here */
			/*code commented and added against the id SSIU-261 starts here */
			isnull(supp_addr_addid,'')+Space(3)+isnull(supp_addr_address1,'')+Space(3)+isnull(supp_addr_address2,'')+Space(3)+isnull(supp_addr_address3,'')+Space(3)+isnull(supp_addr_city,'')+Space(3)+isnull(supp_addr_state,'')+Space(3)+isnull(supp_addr_zip,'')+Space(3)+isnull(supp_addr_phone,'') 
			--/*@shipfromid_add*/ 'shipfromiddetails_grcrt', 
			 'shipfromiddetails_grcrt', 
			/*code commented and added against the id SSIU-261 ends here */
            /*code reverted against the id SSIU-263 starts here */

			/*code commented and added for the id SSIU-263 starts here */
			/* ISNULL(@shippedfromhr,supp_addr_addid)'addressdet_edtgr',*/
			 @shipfromid_add  'addressdet_edtgr',
			 /*code commented and added for the id SSIU-263 ends here */
			 @shippedfromhr								'shippedfromhr',   
			@suppcusthdr		'suppcusthdr'
			,@receiptno 'receiptno' --SSIU-261
			,@shippedfromhr 'ShipFromID_EdtGr'--SSIU-261
			from   supp_addr_address(nolock)   
			where  supp_addr_loid    = @lo_id       
			AND   supp_addr_supcode   = @suppcusthdr  
			and   supp_addr_addid    = ISNULL(@shippedfromhr,supp_addr_addid)
 

	/* 
	--OutputList
		Select
		null 'addressdet_edtgr', 
		null 'guid', 
		null 'receiptno', 
		null 'recno', 
		null 'refdoc_mlt', 
		null 'shipfromid_edtgr', 
		null 'shippedfromhr', 
		null 'suppcusthdr', 
	*/
	
Set nocount off

End



