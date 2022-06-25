MAGDSTA8 ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Sep 18, 2020@14:34:24
 ;;3.0;IMAGING;**231**;MAR 19, 2002;Build 9
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;
 ; Supported IA #2056 reference $$GET1^DIQ function call
 ; Controlled IA #4171 to read REQUEST SERVICES file (#123.5)
 ; Controlled IA #7095 to read GMRC PROCEDURE file (#123.3)
 ; Controlled IA #4110 to read REQUEST/CONSULTATION file (#123)
 ;
 Q
 ;
LEGACY(GROUPIEN,SERIESCOUNT,IMAGECOUNT) ; get all the UIDs for the imaging group
 N I,IMAGEIEN,VISTASTUDYUID,SERIESUID,SOPUID,X,Y,Z
 S (SERIESCOUNT,IMAGECOUNT)=0 ; want series/image counts for this group ien
 S X=$G(^MAG(2005,GROUPIEN,"PACS"))
 S VISTASTUDYUID=$P(X,"^",1)
 I VISTASTUDYUID="" Q  ; invoked for a group without a study uid
 ; there may be multiple study instance uids
 I '$D(^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID)) D
 . ; increment study uid count for PACS lookup, if needed
 . S ^(0)=($G(^TMP("MAG",$J,"UIDS","VISTA",0))+1)_" ; legacy study count"
 . Q
 S I=0 ; skip zero-node of group multiple
 F  S I=$O(^MAG(2005,GROUPIEN,1,I)) Q:'I  D
 . S Y=$G(^MAG(2005,GROUPIEN,1,I,0))
 . S IMAGEIEN=$P(Y,"^",1)
 . S Z=$G(^MAG(2005,IMAGEIEN,"PACS")),SERIESUID=$G(^("SERIESUID"))
 . S SOPUID=$P(Z,"^",1)
 . ; require both series instance uid and sop instance uid
 . Q:SERIESUID=""  Q:SOPUID=""  ; can't do PACS lookup
 . D SERIES(VISTASTUDYUID,SERIESUID,.SERIESCOUNT)
 . D IMAGE(VISTASTUDYUID,SERIESUID,SOPUID,.IMAGECOUNT)
 . Q
 Q
 ;
NEWSOPDB(ACNUMB,SERIESCOUNT,IMAGECOUNT) ; look for UIDs in the P34 database for the new SOP Classes
 ; Rules:
 ; 1) the Attribute On File field is not checked at all.
 ; 2) for the Procedure Reference file (#2005.61), there has to be a pointer to the Patient
 ;    Reference file (#2005.6) and the patient id type in file #2005.6 needs to be "DFN".
 ; 3) for the Image Study file (#2005.62), the study must be "accessible"
 ; 4) for the Image Series file (#2006.63), the series must be  "accessible"
 ; 5) for the SOP Instance file ("2006.64), the SOP instance must be "accessible"
 ;
 ; Rules 1, 2, and 3 are from the logic in ADD1STD^MAGDQR74
 ; Rules 4 and 5 are from the logic in STYSERKT^MAGVD010
 ;  
 N I,INACCESSIBLE,PATREFDATA,PATREFIX,PROCIX,MAGD0,RETURN
 N STATUS,STUDYIX,VISTASTUDYUID,SERIESIX,SERIESUID,SOPIX,SOPUID,X
 S (SERIESCOUNT,IMAGECOUNT)=0 ; want series/image counts for this accession number
 I $G(ACNUMB)="" Q  ; invoked without an accession number
 S PROCIX="" ; procedure level indexed by accession number
 F  S PROCIX=$O(^MAGV(2005.61,"B",ACNUMB,PROCIX)) Q:'PROCIX  D
 . ; see ADD1STD^MAGDQR74 for logic
 . S X=$G(^MAGV(2005.61,PROCIX,6))
 . S PATREFIX=$P(X,"^",1)
 . I 'PATREFIX Q  ; Quit if there is no Patient Reference
 . S PATREFDATA=$G(^MAGV(2005.6,PATREFIX,0))
 . I $P(PATREFDATA,"^",3)'="D" Q  ; Quit if Patient ID Type is not DFN
 . S MAGD0=$P(PATREFDATA,"^",1) ; DFN
 . I MAGD0="" Q  ; no DFN
 . S STUDYIX="" ; study level
 . F  S STUDYIX=$O(^MAGV(2005.62,"C",PROCIX,STUDYIX)) Q:'STUDYIX  D
 . . S X=$G(^MAGV(2005.62,STUDYIX,5)) ; see ADD1STD^MAGDQR74 for logic
 . . S INACCESSIBLE=$P(X,"^",2) I INACCESSIBLE="I" Q  ; study marked inaccessible 
 . . S VISTASTUDYUID=$P(^MAGV(2005.62,STUDYIX,0),"^",1)
 . . S ^(0)=($G(^TMP("MAG",$J,"UIDS","VISTA",0))+1)_" ; new sop class db study count" ; increment study count
 . . ; see STYSERKT^MAGVD010 for logic
 . . S SERIESIX="" ; series level
 . . F  S SERIESIX=$O(^MAGV(2005.63,"C",STUDYIX,SERIESIX)) Q:'SERIESIX  D
 . . . ; If the Series has been deleted don't count - quit
 . . . S STATUS=$G(^MAGV(2005.63,SERIESIX,9))
 . . . I STATUS'="A" Q  ; series not accessible, probably deleted - quit
 . . . S SERIESUID=$P(^MAGV(2005.63,SERIESIX,0),"^",1)
 . . . D SERIES(VISTASTUDYUID,SERIESUID,.SERIESCOUNT)
 . . . S SOPIX="" ; sop instance level
 . . . F  S SOPIX=$O(^MAGV(2005.64,"C",SERIESIX,SOPIX)) Q:'SOPIX  D
 . . . . ; If the SOP Instance has been deleted don't count - quit
 . . . . S STATUS=$G(^MAGV(2005.64,SOPIX,11))
 . . . . I STATUS'="A" Q  ; SOP instance not accessible, probably deleted - quit
 . . . . S SOPUID=$P(^MAGV(2005.64,SOPIX,0),"^",1)
 . . . . D IMAGE(VISTASTUDYUID,SERIESUID,SOPUID,.IMAGECOUNT)
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
 ;
SERIES(VISTASTUDYUID,SERIESUID,SERIESCOUNT) ; increment series counters
 I '$D(^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID,SERIESUID)) D
 . S ^(0)=($G(^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID,0))+1)_" ; series count" ; increment series count
 . ; don't count a series uid if it was under a previous study uid
 . I '$D(^TMP("MAG",$J,"UIDS","VISTA SERIES UID",SERIESUID)) D  ; new series uid, count it
 . . S SERIESCOUNT=SERIESCOUNT+1 ; count of series instance uids, for all study uids
 . . Q
 . Q
 S ^TMP("MAG",$J,"UIDS","VISTA SERIES UID",SERIESUID,"STUDY UID",VISTASTUDYUID)=""
 Q
 ;
IMAGE(VISTASTUDYUID,SERIESUID,SOPUID,IMAGECOUNNT) ; increment image counters
 I '$D(^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID,SERIESUID,SOPUID)) D
 . ; increment image count and save image in ^TMP
 . S ^(0)=($G(^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID,SERIESUID,0))+1)_" ; image count" ; increment image count
 . S IMAGECOUNT=IMAGECOUNT+1 ; count of sop instance uids, for all study & series uids
 . S ^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID,SERIESUID,SOPUID)=""
 . Q
 Q
 ;
 ;
SERVICES(CONSULTSERVICES,GETQRSCP) ; get services to query
 N ALPHA,DONE,I,IBEGIN,IEND,INCRMENT,ISCREEN,KEEPSCREEN
 N LIST,NPICK,NSCREENS,PROCNAME,QUIT,SERVICE,SERVICENAME,RETURN,X
 S GETQRSCP=$G(GETQRSCP,"NO")
 I GETQRSCP'="NO",GETQRSCP'="YES" D  Q -1
 . W !,"SERVICES^",$T(+0)," invoked with unrecognized GETQRSCP parameter: """,GETQRSCP,"""",!
 . Q
 K CONSULTSERVICES
 S SERVICE="" ; alpha sort services
 F I=1:1 S SERVICE=$O(^MAG(2006.5831,"B",SERVICE)) Q:'SERVICE  D
 . S SERVICENAME=$$GET1^DIQ(123.5,SERVICE,.01,"E")
 . S ALPHA(SERVICENAME)=SERVICE
 . Q
 S SERVICENAME="" ; put sorted services into LIST
 F I=1:1 S SERVICENAME=$O(ALPHA(SERVICENAME)) Q:SERVICENAME=""  D
 . S SERVICE=ALPHA(SERVICENAME)
 . S LIST(I)=SERVICENAME_"^"_SERVICE
 . I $D(^TMP("MAG",$J,"BATCH Q/R","CONSULT SERVICES",SERVICE)) S PICK(I)=1
 . Q
 ;
 S N=I-1,(QUIT,RETURN)=0
 ;
 I $D(PICK) D  Q:QUIT -1 W !
 . W !!,"CPRS Consult/Procedure Service(s) from Previous Run"
 . W !,"---------------------------------------------------"
 . S INCREMENT=IOSL-5
 . S NSCREENS=((N-1)\INCREMENT)+1
 . F ISCREEN=1:1:NSCREENS D
 . . S IBEGIN=1+((ISCREEN-1)*INCREMENT)
 . . S IEND=INCREMENT*ISCREEN
 . . S IEND=$S(IEND>N:N,1:IEND)
 . . W @IOF,"CPRS Consult/Procedure Service(s) from Previous Run"
 . . W !,"---------------------------------------------------"
 . . F I=IBEGIN:1:IEND D
 . . . W !?5
 . . . D SERVICE3
 . . . Q
 . . I ISCREEN<NSCREENS D CONTINUE^MAGDSTQ
 . . Q
 . I $$YESNO^MAGDSTQ("Do you wish to change this?","n",.X)<0 S QUIT=1 Q
 . I X="YES" D SERVICE1
 . Q
 E  D 
 . D SERVICE1
 . Q
 ;
 I RETURN'<0 D  ; build list of selected services, by ien
 . D SERVICE4(.CONSULTSERVICES,GETQRSCP,.LIST,.PICK)
 . Q
 I '$D(CONSULTSERVICES) D
 . W !!,"*** No consult/procedure service was selected ***"
 . D CONTINUE^MAGDSTQ
 . S RETURN=-2
 . Q
 Q RETURN
 ;
SERVICE1 ; present selection screen(s)
 S INCREMENT=IOSL-7,DONE=0
 S NSCREENS=((N-1)\INCREMENT)+1
 F ISCREEN=1:1:NSCREENS D  Q:DONE
 . S IBEGIN=1+((ISCREEN-1)*INCREMENT)
 . S IEND=INCREMENT*ISCREEN
 . S IEND=$S(IEND>N:N,1:IEND)
 . D SERVICE2
 . Q
 I 'DONE G SERVICE1 ; go back to first screen and repeat
 Q
 ;
SERVICE2 ; select the service from a screen full  
 S KEEPSCREEN=0
 W @IOF,"Select CPRS Consult/Procedure Service(s) with DICOM Imaging Capabilities"
 W !,"------------------------------------------------------------------------",!
 ; instructions
 W "There are ",N," services.  Enter a number to select or deselect each service,"
 W !,"enter ""A"" for all, and enter ""D"" when done with the selection.",!
 F I=IBEGIN:1:IEND D  Q:DONE
 . W !,$J(I,3),") "
 . D SERVICE3
 . Q
 ;
 ; process user selection(s)
 W !!,"Please enter ",IBEGIN,"-",IEND," to select/deselect a service (and ""D"" when done): "
 R X:DTIME E  S X="^"
 I "?"[$E(X) S X="?" ; <null> or "?..." becomes "?"
 I "^"[$E(X) S RETURN=-1,DONE=1 Q
 I "Dd"[$E(X) S DONE=1 Q
 I "Aa"[$E(X) D  Q
 . F I=1:1:N S PICK(I)=1
 . Q
 I X?1N.N,X>0,X'<IBEGIN,X'>IEND D
 . I $G(PICK(X)) S PICK(X)=0 ; deselect PICK(I)
 . E  S PICK(X)=1 ; select PICK(I)
 . S KEEPSCREEN=1
 . Q
 E  D
 . I X'="?" W " ???" R X:DTIME S KEEPSCREEN=1
 . Q
 ;
 I KEEPSCREEN=1 G SERVICE2 ; keep the same screen, don't go to next one
 Q
 ;
SERVICE3 ; output one service
 W $S($G(PICK(I)):"-->",1:"   "),$P(LIST(I),"^",1)
 Q
 ;
SERVICE4(CONSULTSERVICES,GETQRSCP,LIST,PICK) ; build list of selected services, by ien
 N I,IEN,MAGIEN0,N,PROCEDURE,QRPROVIDER,SERVICE,SVCNAME
 S N=$O(LIST(""),-1)
 F I=1:1:N I $G(PICK(I)) D
 . S SVCNAME=$P(LIST(I),"^",1),SERVICE=$P(LIST(I),"^",2)
 . S CONSULTSERVICES(SERVICE)=SVCNAME
 . I GETQRSCP="NO" Q  ; ignore Q/R Provider 
 . ; check each service for QUERY/RETRIEVE PROVIDER value
 . S IEN="" F  S IEN=$O(^MAG(2006.5831,"B",SERVICE,IEN)) Q:'IEN  D
 . . S MAGIEN0=$G(^MAG(2006.5831,IEN,0))
 . . S PROCEDURE=+$P(MAGIEN0,"^",2) ; null becomes 0
 . . ; check for a special Q/R provider
 . . S QRPROVIDER=$P(MAGIEN0,"^",8)
 . . I QRPROVIDER'="" D
 . . . S PROCNAME=$S(PROCEDURE:$$GET1^DIQ(123.3,PROCEDURE,.01,"E"),1:"CONSULT")
 . . . S CONSULTSERVICES(SERVICE,PROCEDURE)=PROCNAME_"^"_QRPROVIDER
 . . . Q
 . . Q
 . Q
 Q
 ;
QRSCP() ; get the q/r scp for the consult
 N MAG5831,QRSCP,TOSERVICE,X
 ;
 S QRSCP=^TMP("MAG",$J,"BATCH Q/R","PACS Q/R RETRIEVE SCP")
 ;
 ; does the consult modality worklist have a designated q/r scp?
 I IMAGINGSERVICE="CONSULTS" D
 . S TOSERVICE=$$GET1^DIQ(123,GMRCIEN,1,"I")
 . S MAG5831=$$MWLFIND^MAGDHOW1(TOSERVICE,GMRCIEN)
 . I MAG5831 D  ; get designated q/r scp for the worklist
 . . S X=$$GET1^DIQ(2006.5831,MAG5831,8,"E")
 . . I X'="" S QRSCP=X W !?20,"<<< Q/R SCP: ",QRSCP," >>>"
 . . Q
 . Q
 ;
 Q QRSCP
