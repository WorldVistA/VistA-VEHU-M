SDESCLINICAVAIL ;ALB/RRM - VISTA SCHEDULING RPCS GET CLINIC AVAILABILITY ; Oct 07, 2021@16:32
 ;;5.3;Scheduling;**800**;Aug 13, 1993;Build 23
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;Global References    Supported by ICR#     Type
 ;-----------------    -----------------     ----------
 ; ^TMP($J             SACC 2.3.2.5.1
 ;
 ;External References
 ;-------------------
 ; ^%DT                10003                 Supported
 ; $$FIND1^DIC          2051                 Supported
 ; $$GET1^DIQ           2056                 Supported
 ;
 Q  ;No Direct Call
 ;
GETCLAVAILABLTY(RETURN,CLINICIEN,SDESSTART,SDESENDDATE) ;Called from RPC: SDES GET CLINIC AVAILABILITY
 ; This RPC returns available appointment slots within a given timeframe for a given clinic in JSON format.
 ; Input:
 ;   RETURN      [required] -  This is where the retrieve data  is stored in JSON format
 ;   CLINICIEN   [required] -  The Internal Entry Number (IEN) from the HOSPITAL LOCATION File #44
 ;   SDESSTART   [required] -  The Start Date mm/dd/yyyy in external format to search from
 ;   SDESENDDATE [required] -  The End Date  mm/dd/yyyy in external format to search to
 ;
 N SDGETCLAVL,SDCLNAME,ERROR,SDCLRESIEN,SDTMPARY
 S ERROR=0
 K RETURN,SDGETCLAVL ;always clear returned data array to ensure a new array of data are returned
 D VALINPUT ;validate input parameters
 I 'ERROR D
 . K SDTMPARY
 . S SDTMPARY=$NA(^TMP($J,"CLNCAVAIL"))
 . K @SDTMPARY
 . D GETSLOTS^SDEC57(SDTMPARY,SDCLRESIEN,SDESSTART,SDESENDDATE)
 . D BUILDDATA
 . K @SDTMPARY
 D BUILDJSON
 K SDGETCLAVL
 Q
 ;
VALINPUT   ;validate input parameters
 N SDERR,EFLAG,SFLAG
 S (SFLAG,EFLAG)=0
 ;validate CLINIC IEN
 I $G(CLINICIEN)="" D ERRLOG^SDESJSON(.SDGETCLAVL,67) S ERROR=1 ;clinic cannot be blank
 I +$G(CLINICIEN)>0 D
 . S SDCLNAME=$$GET1^DIQ(44,CLINICIEN_",",.01,"I") ;retrieve the clinic name
 . I SDCLNAME="" D ERRLOG^SDESJSON(.SDGETCLAVL,80)  S ERROR=1 Q  ;clinic IEN not found
 . S SDCLRESIEN=$$FIND1^DIC(409.831,"","MX",SDCLNAME,"","","SDERR") ;retrieve the resource IEN for the clinic
 . I $D(SDERR) D ERRLOG^SDESJSON(.SDGETCLAVL,70) S ERROR=1 ;invalid clinic resource id
 E  D ERRLOG^SDESJSON(.SDGETCLAVL,52,"Invalid Clinic IEN") S ERROR=1
 ;validate start date
 I $G(SDESSTART)=""  D ERRLOG^SDESJSON(.SDGETCLAVL,9) S ERROR=1 ;missing begin date
 I +$G(SDESSTART)>0 D
 . S SDESSTART=$$EX2INTDT($P(SDESSTART,"@",1)) ;convert external format to internal format
 . S SFLAG=1
 . I +SDESSTART<1  D ERRLOG^SDESJSON(.SDGETCLAVL,11) S ERROR=1  Q  ;invalid begin date
 . I +SDESSTART<DT D ERRLOG^SDESJSON(.SDGETCLAVL,52,"Start Date cannot be in the past") S ERROR=1  Q  ;start date cannot be in the past
 E  D ERRLOG^SDESJSON(.SDGETCLAVL,11) S ERROR=1 ;invalid begin date
 ;validate end date
 I $G(SDESENDDATE)=""  D ERRLOG^SDESJSON(.SDGETCLAVL,10) S ERROR=1 ;missing end date
 I +$G(SDESENDDATE)>0 D
 . S SDESENDDATE=$$EX2INTDT($P(SDESENDDATE,"@",1)) ;convert external format to internal format
 . S EFLAG=1
 . I +SDESENDDATE<1 D ERRLOG^SDESJSON(.SDGETCLAVL,12) S ERROR=1 Q  ;invalid end date
 . I +SDESENDDATE<+SDESSTART D ERRLOG^SDESJSON(.SDGETCLAVL,13) S ERROR=1  Q  ;end date cannot be in the past
 E  D ERRLOG^SDESJSON(.SDGETCLAVL,12) S ERROR=1 ;invalid end date
 I SFLAG,EFLAG D
 . I SDESSTART=SDESENDDATE D ERRLOG^SDESJSON(.SDGETCLAVL,52,"Start and End Date cannot be less than a day") S ERROR=1
 Q
 ;
EX2INTDT(X) ; Receives date in external format, returns internal format
 N %DT,Y
 I ($L(X," ")=2),(X?1.2N1P1.2N1P1.2N1" "1.2N.E) S X=$TR(X," ","@")
 S %DT="TSP" D ^%DT
 Q Y
  ;
BUILDDATA ;retrieve clinic availability data
 N SDP1,SDP2,SDP3,SDP4,SDSTRTDT,SDENDDT,SDSLOTS,SDSTOPTM,SDSTRTTM,SDTOTAL,II
 I $O(@SDTMPARY@(""))="" D ERRLOG^SDESJSON(.SDGETCLAVL,126) Q
 S SDTOTAL=@SDTMPARY@("CNT")
 F II=1:1:SDTOTAL D
 . S SDP1=$P(@SDTMPARY@(II),U,2) ;start date
 . S SDP2=$P(@SDTMPARY@(II),U,3) ;end date
 . S SDP3=+$P(@SDTMPARY@(II),U,4) ;open slots available
 . S SDP4=$P(@SDTMPARY@(II),U,5) ;access type  (1=available, 2=not available, 3=cancelled)
 . ;
 . S SDSTRTDT=$P(SDP1,".") ;start date - remove the time
 . S SDENDDT=$P(SDP2,".") ;end date - remove the time
 . S SDSTRTTM=$E($P(SDP1_"0000",".",2),1,4) ;start time
 . S SDSTOPTM=$E($P(SDP2_"0000",".",2),1,4) ;stop time
 . S SDSLOTS=$P(@SDTMPARY@(II),U,4)
 . S SDSLOTS=$S(SDSLOTS=" ":"",1:SDSLOTS)
 . S SDSLOTS=$S(SDP4=2:"",SDP4=3:"X",1:SDSLOTS)
 . S SDGETCLAVL($J,"SDESCLINICAVAIL",II)=SDSTRTDT_U_SDSTRTTM_U_SDSTOPTM_U_SDSLOTS
 Q
 ;
BUILDJSON ;Convert data to JSON
 N JSONERR
 S JSONERR=""
 D ENCODE^SDESJSON(.SDGETCLAVL,.RETURN,.JSONERR)
 Q
