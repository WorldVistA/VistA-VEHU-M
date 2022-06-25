SDESGETUD ;ALB/ANU - VISTA SCHEDULING RPCS GET USER KEYS AND OPTIONS ; Nov 09, 2021@16:32
 ;;5.3;Scheduling;**801**;Aug 13, 1993;Build 13
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;Global References    Supported by ICR#     Type
 ;-----------------    -----------------     ----------
 ; ^TMP($J             SACC 2.3.2.5.1
 ;
 ;External References
 ;-------------------
 ;Reference to $$GETS^DIQ,$$GETS1^DIQ in ICR #2056
 ;Reference to $$SITE^VASITE in ICR #10112
 ;Reference to ^%DT in ICR #10003
 ;Reference to $$FIND1^DIC in ICR #2051
 ;
 Q  ;No Direct Call
 ;
GETUSRDTL(SDUSRJSON,SDUSRVPID) ;Called from RPC: SDES GET USER PROFILE
 ; This RPC gets User name, Keys and Scheduling Options for a given User.
 ; Input:
 ;   SDCLNJSON   [required] -  Successs or Error message
 ;   SDUSRIEN    [required] -  The Internal Entry Number (IEN) from the NEW PERSON File #200
 ;
 N ERRPOP,ERR,ERRMSG,SDECI,SDUSRSREC,SDUSRIEN
 D INIT
 D VALIDATE
 I ERRPOP D BLDJSON Q
 D GETUSRINF
 D BLDJSON
 Q
 ;
INIT ; initialize values needed
 S SDECI=0
 S SDECI=$G(SDECI,0),ERR=""
 S ERRPOP=0,ERRMSG=""
 Q
 ;
VALIDATE ; validate incoming parameters
 I SDUSRVPID="" D ERRLOG^SDESJSON(.SDUSRSREC,130) S ERRPOP=1 Q
 S SDUSRIEN=$$IEN^XUPS(SDUSRVPID)
 I SDUSRIEN="" D ERRLOG^SDESJSON(.SDUSRSREC,44) S ERRPOP=1 Q
 I '$D(^VA(200,SDUSRIEN,0)) D ERRLOG^SDESJSON(.SDUSRSREC,127) S ERRPOP=1 Q
 ;
 Q
 ;
BLDJSON ; Build JSON format
 D ENCODE^SDESJSON(.SDUSRSREC,.SDUSRJSON,.ERR)
 K SDUSRSREC
 Q
 ;
GETUSRINF ; Get User Keys and Scheduling Options
 N SDFIELDS,SDDATA,SDMSG,SDX,SDC,SDOPT,SDKEY
 S SDFIELDS=".01;201"
 D GETS^DIQ(200,SDUSRIEN_",",SDFIELDS,"IE","SDDATA","SDMSG")
 S SDECI=SDECI+1
 S SDUSRSREC("User","Name")=$G(SDDATA(200,SDUSRIEN_",",.01,"E")) ;User Name
 S SDUSRSREC("User","IEN")=SDUSRIEN
 S SDUSRSREC("User","Station ID")=$P($$SITE^VASITE(),"^",3)
 S SDOPT=$G(SDDATA(200,SDUSRIEN_",",201,"E"))
 I $E(SDOPT,1,2)="SD"!$E(SDOPT,1,2)="SC" S SDUSRSREC("User","Primary Menu Option")=SDOPT ;Primary Menu Option
 ; Secondary Options Multiple
 S SDX="",SDC=0
 S SDFIELDS="203*"
 K SDDATA,SDMSG
 D GETS^DIQ(200,SDUSRIEN_",",SDFIELDS,"E","SDDATA","SDMSG")
 F  S SDX=$O(SDDATA(200.03,SDX)) Q:SDX=""  D
 . S SDOPT=$G(SDDATA(200.03,SDX,.01,"E"))
 . I (($E(SDOPT,1,2)="SD")!($E(SDOPT,1,2)))="SC" S SDC=SDC+1 S SDUSRSREC("User","Secondary Menu",SDC,"Option")=SDOPT
 ; Security Keys Multiple
 S SDX="",SDC=0
 S SDFIELDS="51*"
 K SDDATA,SDMSG
 D GETS^DIQ(200,SDUSRIEN_",",SDFIELDS,"E","SDDATA","SDMSG")
 F  S SDX=$O(SDDATA(200.051,SDX)) Q:SDX=""  D
 . S SDKEY=$G(SDDATA(200.051,SDX,.01,"E"))
 . I (($E(SDKEY,1,2)="SD")!($E(SDKEY,1,2)="SC")) S SDC=SDC+1 S SDUSRSREC("User","Security Key",SDC,"Name")=SDKEY
 I '$D(SDUSRSREC("User")) S SDUSRSREC("User")=""
 Q
