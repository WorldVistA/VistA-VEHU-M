DVBCP238 ;ALB/FSB - PATCH DVBA*2.7*238 POST-INSTALL ROUTINE; MAR 29, 2022@17:00
 ;;2.7;AMIE;**238**;Apr 10, 1995;Build 16
 ;
 ; Reference to XUS KEY CHECK in ICR #6286
 ; Reference to XUS ALLKEYS in ICR #6287
 ;
 Q
SECKEY ;
 ;
 N DVBKEYNO,DVBIEN,DVBMNU,DVBSTOP1,DVBNAME,DVBOPIEN,DVBPRDUZ,DVBMSG,DVBERR,DVBKYIEN,DVBPER,DVBTODAY,X,DVBZZ
 ;
 S DVBZZ="" D OWNSKEY^XUSRB(.DVBZZ,"XUMGR",DUZ)
 I $G(DVBZZ(0))'=1 D  Q
 . D BMES^XPDUTL("NOTE: THE NEW SECURITY KEY 'DVBA CAPRI CLIN DOC-EFOLDER' DID NOT SUCCESSFULLY UPDATE WITH THE REQUIRED HOLDERS.")
 . D BMES^XPDUTL("THE USER RUNNING THIS POST INSTALL ROUTINE DOES NOT HAVE XUMGR KEY ASSIGNED TO THEM.")
 . D BMES^XPDUTL("PLEASE RUN SECKEY^DVBCP238 AGAIN WITH USER WHO IS A HOLDER OF THE 'XUMGR' SECURITY KEY.")
 ;
 K ^TMP($J,"DVBCP238")
 ;
 D NOW^%DTC S DVBTODAY=X ;X STILL DOESN'T HAVE A VALUE AFTER RUNNING API
 ;
 ;FIND DVBA CAPRI GUI IN OPTION FILE (SHOULD ALWAYS BE 9510) BUT CHECKING JUST THE SAME
 S DVBSTOP1=0,DVBOPIEN=""
 S DVBIEN=0 F  S DVBIEN=$O(^DIC(19,DVBIEN)) Q:DVBIEN=""!('DVBIEN)!(DVBSTOP1=1)  D
 . S DVBNAME=$G(^DIC(19,DVBIEN,0))
 . S DVBNAME=$P(DVBNAME,"^",1) ;ASSIGNING THE NAME
 . I DVBNAME="DVBA CAPRI GUI" S DVBSTOP1=1,DVBOPIEN=DVBIEN
 I DVBOPIEN="" D BMES^XPDUTL("'DVBA CAPRI GUI' OPTION NOT FOUND IN OPTION FILE. USERS OF DVBA CAPRI CLIN DOC-EFOLDER COULD NOT BE SETUP") Q
 ;
 ;FIND PERSONS WITH DVBA CAPRI GUI OPTION
 I DVBOPIEN'="" D
 . S DVBPRDUZ=0 F  S DVBPRDUZ=$O(^VA(200,DVBPRDUZ)) Q:DVBPRDUZ=""!('DVBPRDUZ)  D
 .. K DVBMSG,DVBERR
 .. D GETS^DIQ(200,DVBPRDUZ_",","9.2","I","DVBMSG","DVBERR")
 .. I $G(DVBMSG(200,DVBPRDUZ_",",9.2,"I"))'="",($G(DVBMSG(200,DVBPRDUZ_",",9.2,"I"))<=DVBTODAY) D  Q
 ... S ^TMP($J,"DVBCP238",DVBPRDUZ,"TERMEDPERSON")=""
 .. ;
 .. I $G(^VA(200,DVBPRDUZ,201)) I $P(^VA(200,DVBPRDUZ,201),"^",1)=DVBOPIEN S ^TMP($J,"DVBCP238",DVBPRDUZ,"USERSWITHOPTION")="" Q
 .. Q:'$D(^VA(200,DVBPRDUZ,203))
 .. S DVBSTOP1=0
 .. S DVBMNU=0 F  S DVBMNU=$O(^VA(200,DVBPRDUZ,203,DVBMNU)) Q:DVBMNU=""!('DVBMNU)!(DVBSTOP1=1)  D
 ... I $G(^VA(200,DVBPRDUZ,203,DVBMNU,0)) I $P(^VA(200,DVBPRDUZ,203,DVBMNU,0),"^",1)=DVBOPIEN S DVBSTOP1=1,^TMP($J,"DVBCP238",DVBPRDUZ,"USERSWITHOPTION")=""
 ;
 ;DOES THE USER HAVE ACCESS TO THE CURRENT KEY
 S DVBKEYNO=$$LKUP^XPDKEY("DVBA CAPRI CLIN DOC-EFOLDER")
 I $G(DVBKEYNO)="" D BMES^XPDUTL("'DVBA CAPRI CLIN DOC-EFOLDER' SECURITY KEY HAS NOT BEEN ADDED. SECKEY^DVBCP238 CAN NOT CONTINUE") Q
 S DVBPRDUZ=0 F  S DVBPRDUZ=$O(^VA(200,DVBPRDUZ)) Q:DVBPRDUZ=""!('DVBPRDUZ)  D
 . I $D(^VA(200,DVBPRDUZ,51,DVBKEYNO)) D  Q
 .. S ^TMP($J,"DVBCP238",DVBPRDUZ,"DVBA CAPRI CLIN DOC-EFOLDER")=""
 .. I $D(^TMP($J,"DVBCP238",DVBPRDUZ,"USERSWITHOPTION")) S ^TMP($J,"DVBCP238",DVBPRDUZ,"USERSWITHOPTION")="DVBA CAPRI CLIN DOC-EFOLDER"
 ;
 ;ADD NEW SECURITY KEY TO ALL NON-TERMED PERSONS WHO DON'T HAVE OLD KEY
 S DVBPRDUZ=0 F  S DVBPRDUZ=$O(^TMP($J,"DVBCP238",DVBPRDUZ)) Q:DVBPRDUZ=""!('DVBPRDUZ)  D
 .;DO NOT INCLUDE USERS WHO ARE VISITORS
 . Q:$D(^VA(200,DVBPRDUZ,3,"B","VISITOR"))=10
 . Q:'$D(^TMP($J,"DVBCP238",DVBPRDUZ,"USERSWITHOPTION"))
 . Q:$D(^TMP($J,"DVBCP238",DVBPRDUZ,"TERMEDPERSON"))
 . Q:$D(^TMP($J,"DVBCP238",DVBPRDUZ,"DVBA CAPRI CLIN DOC-EFOLDER"))
 . ;IF AFTER FIRST RUN THIS ROUTINE IS RUN AGAIN EXCLUDE DVBPER WITH KEY FROM FIRST RUN
 . Q:$D(^XUSEC("DVBA CAPRI CLIN DOC-EFOLDER",DVBPRDUZ))
 . K DVBFDA,DVBERR,DIERR,DVBKYIEN
 . S DVBFDA(200.051,"+1,"_DVBPRDUZ_",",.01)=DVBKEYNO
 . S DVBFDA(200.051,"+1,"_DVBPRDUZ_",",1)=DUZ
 . S DVBFDA(200.051,"+1,"_DVBPRDUZ_",",2)=DVBTODAY
 . S DVBKYIEN(1)=DVBKEYNO
 . D UPDATE^DIE("","DVBFDA","DVBKYIEN","DVBERR")
 . S DVBPER=$P(^VA(200,DVBPRDUZ,0),"^",1)
 . I $D(DIERR) D BMES^XPDUTL(""_DVBPRDUZ_" ("_DVBPER_") SHOULD BE ASSIGNED THE SECURITY KEY 'DVBA CAPRI CLIN DOC-EFOLDER'. PLEASE SET THIS PERSON MANUALLY") Q
 ;
 K ^TMP($J,"DVBCP238")
 D BMES^XPDUTL("SECURITY KEY UPDATE IS COMPLETE")
 Q
