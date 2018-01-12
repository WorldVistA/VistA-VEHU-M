DENTV063 ;DSS/AJ - Post init DENTAL Patch 63;11/8/2011 2:37
 ;;1.2;DENTAL;**63**;Aug 10, 2001;Build 19
 ;Copyright 1995-2013, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  ICR#  SUPPORTED  Description
 ;  -----  ---------  --------------------------------------
 ; 2053       x       ^DIE
 ; 5323       x       MES^DSICXPDU 
 ; 10070      x       ^XMD
 ;                    EN^DIU2
 ; 10005      x       DT^DICRW
 ; 10063      x       ^%ZTLOAD
 ; 10086      x       HOME^%ZIS
 ; 10013      x       ^DIK
 Q
PRE ;correct cndDummy
 N TXN,ADA,CND,ARE,MAT S TXN=0
 D MSG("Updating condition field in 228.2")
 F  S TXN=$O(^DENT(228.2,TXN)) Q:TXN]"A"  S ADA=$P($G(^DENT(228.2,TXN,0)),U,4) D:ADA'=""
 .I $P(^DENT(228.2,TXN,0),U,9)=86 D
 ..S:$P($G(^DENT(228,ADA,1)),U,11) $P(^DENT(228.2,TXN,0),U,9)=$P($G(^DENT(228,ADA,1)),U,11) ;Condition
 ..S:$P($G(^DENT(228,ADA,1)),U,12) $P(^DENT(228.2,TXN,0),U,11)=$P($G(^DENT(228,ADA,1)),U,12) ;Area
 ..S:$P($G(^DENT(228,ADA,1)),U,13) $P(^DENT(228.2,TXN,0),U,10)=$P($G(^DENT(228,ADA,1)),U,13) ;Material
 D MSG("Correcting any perio sequence duplicates")
 D SEQCHK
 Q
SEQCHK ;Checks perio sequence numbers for duplicates
 N:'$D(DFN) DFN,TXN,CNT,X,LIST,SFLG,EXN S (CNT,SFLG)=0,DFN=$G(DFN),TXN=""
 F  S DFN=$O(^DENT(228.2,"AD",DFN)) Q:DFN=""  D  K LIST S (CNT,SFLG)=0
 .F  S TXN=$O(^DENT(228.2,"AD",DFN,2,TXN)) Q:(TXN="")!SFLG  D
 ..S EXN=^DENT(228.2,TXN,2),X=""
 ..F  S X=$O(LIST(X)) Q:SFLG!(X="")  D
 ...I $G(LIST(X))=EXN D SEQFIX(DFN) S SFLG=1
 ..S CNT=CNT+1,LIST(CNT)=EXN
 Q
SEQFIX(DFN) ;Fixes any perio sequence problems
 N TIEN,ORDER,DATE,SEQ S TIEN="",SEQ=0
 F  S TIEN=$O(^DENT(228.2,"AD",DFN,2,TIEN)) Q:TIEN=""  D
 .S DATE=$P(^DENT(228.2,TIEN,0),U,13),(ORDER(DATE),ORDER(DATE,TIEN))=""
 S (DATE,TIEN)=""
 F  S DATE=$O(ORDER(DATE)) Q:DATE=""  D
 .F  S TIEN=$O(ORDER(DATE,TIEN)) Q:TIEN=""  D
 ..S ^DENT(228.2,TIEN,2)=SEQ,SEQ=SEQ+1
 Q
POST ; Post Install Routine
 N CSRET,CSURL,DIK,DLRET,DLURL,RSRET,RSURL
 S TIEN=0
 F  S TIEN=$O(^DENT(228.2,TIEN)) Q:TIEN]"A"  D
 .S DENX=^DENT(228.2,TIEN,0)
 .I $P(DENX,U,12)=103,$P(DENX,U,23) D DIK^DENTVTPA(TIEN,228.2)
 ; Delete any existing primary/secondary x-ref and re-index
 S DIK="^DENT(220,"
 S DIK(1)=".09^AP"
 D ENALL2^DIK,ENALL^DIK
 S DIK="^DENT(220,"
 S DIK(1)=".1^AS"
 D ENALL2^DIK,ENALL^DIK
 D PARAM,MM,TASK
 Q
PS ; Taskman Post-Install
 D CODE,UDEL,UFTC,TC
 Q
PARAM ; Set up new Dental parameters
 ; Setting default HL7 batch limit is no previously set
 D MSG("Adding new Dental parameters")
 D:+$$GET1^DSICXPR(,"SYS~DENTV HL7 BATCH LIMIT~~~",1)=-1 ADD^DSICXPR(,"SYS~DENTV HL7 BATCH LIMIT~1~750~~",1)
 ;
 ; Setting deault document library URL if not previously set
 S DLURL(1)="http://vaww.va.gov/DENTAL/drm_docs.asp"
 ;
 D GETWP^DSICXPR(.DLRET,"SYS~DENTV DOCUMENT LIBRARY")
 D:+$G(DLRET)=-1 ADDWP^DSICXPR(,"SYS~DENTV DOCUMENT LIBRARY~1",.DLURL)
 ;
 ; Setting deault interactive reporting services URL if not previously set
 S RSURL(1)="https://spsites.dwh.cdw.portal.va.gov/sites/CO_DENTAL/_layouts/ReportServer/RSViewerPage.aspx?rv:Relative"
 S RSURL(1)=RSURL(1)_"ReportUrl=/sites/CO_DENTAL/Coding/Dental%20Coding%20Standards%20and%20Requirements.rdl&Source=h"
 S RSURL(2)="ttps%3A%2F%2Fspsites%2Edwh%2Ecdw%2Eportal%2Eva%2Egov%2Fsites%2FCO%5FDENTAL%2FCoding%2FForms%2Fcurrent%"
 S RSURL(2)=RSURL(2)_"2Easpx&DefaultItemOpen=1&DefaultItemOpen=1"
 ;
 D GETWP^DSICXPR(.RSRET,"SYS~DENTV REPORTING SERVICES")
 D:+$G(RSRET)=-1 ADDWP^DSICXPR(,"SYS~DENTV REPORTING SERVICES~1",.RSURL)
 ;
 ; Setting deault coding standards URL if not previously set
 S CSURL(1)="https://spsites.dwh.cdw.portal.va.gov/sites/CO_DENTAL/Coding/"
 S CSURL(1)=CSURL(1)_"Dental%20Coding%20Standards%20and%20Requirements.pdf"
 ;
 D GETWP^DSICXPR(.CSRET,"SYS~DENTV CODING STANDARDS")
 D:+$G(CSRET)=-1 ADDWP^DSICXPR(,"SYS~DENTV CODING STANDARDS~1",.CSURL)
 Q
CODE ;
 N TMP,CODE S CODE=""
 F  S CODE=$O(^DENT(228,CODE)) Q:(CODE="")!($P($G(^ICPT(CODE,0)),"^",1)="D4910")
 I CODE="" G ERR
 S CODE=CODE_","
 S TMP(1)="D4910 - This code is for maintenance procedures on those patients who have "
 S TMP(2)="completed active periodontal treatment provided the previous treatment "
 S TMP(3)="consisted of scaling and root planning or surgery.  It should be coded "
 S TMP(4)="only when localized subgingival instrumentation is required on a few teeth.  "
 S TMP(5)="If this is not done and the patient is in good periodontal health, use D1110.  "
 S TMP(6)="It may be coded as performed at regular intervals (e.g., every three months).  "
 S TMP(7)="It is not synonymous with prophylaxis (D1110).  "
 S TMP(8)="Not to be coded concurrently with D1110, D4341, D4342, or D4355."
 D WP^DIE(228,CODE,4,,"TMP") K TMP
 Q
MSG(X) ;
 S X="   >>>>> "_X_" <<<<<"
 D MES^DSICXPDU(X,1)
 Q
 ;
TASK ; Task of Post-Install
 N X,Y,Z,ZTSK,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC
 I '$D(XPDNM) D  Q:'X
 .I $G(DUZ)<.5 W !!,"Please sign on properly through the Kernel" S X=0
 .E  D HOME^%ZIS,DT^DICRW S X=1
 .Q
 S ZTIO="",ZTDTH=$H,ZTRTN="PS^DENTV063",ZTDESC="DENTV PATCH 63 POST-INSTALL"
 D ^%ZTLOAD S X="Patch 63 post-install successfully queued, task# "_$G(ZTSK)
 I $G(ZTSK) D MSG(X)
 I '$G(ZTSK) D MSG("Could not queue the Post-Install!"),MSG("Enter a Dental Remedy ticket.")
 Q
 ;
UDEL ;undelete deleted txns from NON-ADMIN users
 N IDT,EDT,IEN,TXN,X0,X1,DENTV
 ;STARTING POINT: "AF" XREF IS CREATE DATE, start close to P57 release date
 S IDT=3090201,EDT=DT+.24
 F  S IDT=$O(^DENT(228.1,"AF",IDT)) Q:'IDT!(IDT>EDT)  D
 .S IEN=0 F  S IEN=$O(^DENT(228.1,"AF",IDT,IEN)) Q:'IEN  D TXNS
 .Q
 Q
TXNS S TXN=0 F  S TXN=$O(^DENT(228.2,"AG",IEN,TXN)) Q:'TXN  D
 .S X0=$G(^DENT(228.2,TXN,0)),X1=$G(^(1))
 .Q:X0=""!($P(X0,U,4)="")!($P(X0,U,29)'=1)  ;bad data, no ada code, not a txn
 .I $P(X0,U,12)'=104 Q  ;only COMPLETE
 .I '$P(X1,U,3) Q  ;not DELETED (we're un-deleting remember)
 .I $$GET1^DSICXPR(,"USR.`"_$P(X1,U,4)_"~DENTV DRM ADMINISTRATOR",1)=1 Q  ;delete person is admin, don't include
 .K DENTV S DENTV(228.2,TXN_",",1.03)="@" ;undelete the transaction
 .I $$GET1^DIQ(228.2,TXN,1.18,"I")'="" S DENTV(228.2,TXN_",",1.18)="P" ;resend to Austin
 .D FILE^DIE(,"DENTV")
 .Q
 Q
 ;
UFTC ;fix the Time Counter piece in the unfiled data file (228.7)
 N X,Y,NTC,TC,NGR,GR
 S X=0
 F  S X=$O(^DENT(228.7,X)) Q:X["A"  S Y=0,PTC=990 D:'$P(^DENT(228.7,X,0),U,5)
 .F  S Y=$O(^DENT(228.7,X,1,Y)) Q:Y=""  S TC=$P(^DENT(228.7,X,1,Y,0),U,22) D:TC<PTC  S PTC=TC
 ..Q:$P(^DENT(228.7,X,1,Y,0),U)'="$$TX$$"
 ..S GR=$P(^DENT(228.7,X,1,Y,0),U,11),TC=PTC+10
 ..S $P(^DENT(228.7,X,1,Y,0),U,22)=TC
 ..I GR>0 F  S Y=$O(^DENT(228.7,X,1,Y)) Q:$P(^DENT(228.7,X,1,Y,0),U)'="$$TX$$"  D  Q:(NGR<2)
 ...S NGR=$P($G(^DENT(228.7,X,1,Y+1,0)),U,11),$P(^DENT(228.7,X,1,Y,0),U,22)=TC
 Q
TC ;fix the Time Counter field (#.14) in file 228.2
 ;this field must be unique for a txn or ranged 'set' (like bridges) of txns
 ;it was not unique if one user filed unfiled data to a patient
 ;and another filed txn data on the same day for the same patient
 ;when the first user filed the unfiled data the time counter did not increment
 ;but used the same numbers as currently existed in the file.
 ;this caused the app to delete txns incorrectly (hence the undelete above)
 N PAT,CDT
 S PAT=0 F  S PAT=$O(^DENT(228.2,"AE",PAT)) Q:'PAT  D
 .S CDT=0 F  S CDT=$O(^DENT(228.2,"AE",PAT,CDT)) Q:'CDT  D EACHD
 Q
EACHD ;each day is evaluated
 N TC,IEN,GRP,EACHD,FLAG,NEWTC,DENTV,LASTC,REDO,QUIT,FIRST,CNT
 S TC=0,FLAG=0 F  S TC=$O(^DENT(228.2,"AE",PAT,CDT,TC)) Q:'TC  D
 .S IEN=0 F  S IEN=$O(^DENT(228.2,"AE",PAT,CDT,TC,IEN)) Q:'IEN  D
 ..S GRP=$$GET1^DIQ(228.2,IEN,.22)>0
 ..I $D(EACHD(TC,0)) S FLAG=1 ;We have dup tc single or grouped txns
 ..I $D(EACHD(TC)),$O(EACHD(TC,0))'=GRP S FLAG=1 ;We have dup tc grouped txns
 ..S EACHD(TC,GRP,IEN)=""
 ..Q
 .Q
 ;quit if we're not working with dupes
 Q:'FLAG
 ;resort them ALL into transaction id order
 S TC=0 F  S TC=$O(EACHD(TC)) Q:'TC  D
 .S GRP="" F  S GRP=$O(EACHD(TC,GRP)) Q:GRP=""  D
 ..S IEN=0 F  S IEN=$O(EACHD(TC,GRP,IEN)) Q:'IEN  S REDO(IEN)=TC_U_GRP
 ..Q
 .Q
 ;loop to find out where the TC starts over
 S IEN=0,QUIT=0,TC=1000,FIRST=1,CNT=0
 F  S IEN=$O(REDO(IEN)) Q:'IEN!QUIT  D
 .S GRP=$P(REDO(IEN),U,2) I GRP S CNT=CNT+1 Q:CNT>1
 .I FIRST S FIRST=0 Q
 .I 'GRP S CNT=0
 .I +REDO(IEN)'>TC S QUIT=IEN Q
 .S TC=+REDO(IEN)
 .Q
 ;QUIT is where we stopped"
 ;now remove all IENs in EACHD that have an IEN below (<) the STOP point
 S TC=0 F  S TC=$O(EACHD(TC)) Q:'TC  D
 .S GRP="" F  S GRP=$O(EACHD(TC,GRP)) Q:GRP=""  D
 ..S IEN=0 F  S IEN=$O(EACHD(TC,GRP,IEN)) Q:'IEN  I IEN<QUIT K EACHD(TC,GRP,IEN)
 ..Q
 .Q
 ;now reset the tc for what's left
 K LASTC
 S TC=0 F  S TC=$O(EACHD(TC)) Q:'TC  D
 .S GRP="" F  S GRP=$O(EACHD(TC,GRP)) Q:GRP=""  D
 ..S IEN=0 F  S IEN=$O(EACHD(TC,GRP,IEN)) Q:'IEN  D
 ...S NEWTC=$$NEWTC(PAT,CDT,TC,IEN) Q:'TC  S EACHD(TC,GRP,IEN)=NEWTC
 ...K DENTV S DENTV(228.2,IEN_",",.14)=NEWTC D FILE^DIE(,"DENTV")
 ...Q
 ..Q
 .Q
 Q
NEWTC(PAT,CDT,TC,IEN) ;get the new timecounter value
 N LAST
 S LAST=$G(LASTC("TC",TC)) I LAST Q LAST
 S LAST=$O(^DENT(228.2,"AE",PAT,CDT,9999),-1),LAST=LAST+10 ;get last tc and add 10
 ;save in case of grouped txns and update the timecounter field with new tc
 S LASTC("TC",TC)=LAST
 Q LAST
ERR ;STOP WITH ERROR MESSAGE
 D MES^DSICXPDU("No IEN for code D4910.")
 Q
MM ;send message
 Q:'DUZ  N %,DENTVTXT,R,XMDUZ,XMSUB,XMTEXT,XMY,DIFROM,CNT,I,IEN
 S XMDUZ=DUZ,XMSUB="Dental Patch 63",I=1,CNT=0
 S (%,IEN)=0,R="DENTVTXT",XMY(XMDUZ)="",XMY("G.DENTV ADA CODE MAPPING")=""
 S %=%+1,@R@(%,0)="The D4910 Coding Standard was updated and now reads as follows:"
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="D4910 - This code is for maintenance procedures on those patients who have "
 S %=%+1,@R@(%,0)="completed active periodontal treatment provided the previous treatment "
 S %=%+1,@R@(%,0)="consisted of scaling and root planning or surgery.  It should be coded "
 S %=%+1,@R@(%,0)="only when localized subgingival instrumentation is required on a few teeth.  "
 S %=%+1,@R@(%,0)="If this is not done and the patient is in good periodontal health, use D1110.  "
 S %=%+1,@R@(%,0)="It may be coded as performed at regular intervals (e.g., every three months).  "
 S %=%+1,@R@(%,0)="It is not synonymous with prophylaxis (D1110).  "
 S %=%+1,@R@(%,0)="Not to be coded concurrently with D1110, D4341, D4342, or D4355."
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="A fix was also performed which corrected transactions with the incorrect "
 S %=%+1,@R@(%,0)="CONDITION field value of ""cmdDummy."""
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="All completed care which was deleted accidentally by non-admin users has"
 S %=%+1,@R@(%,0)="been restored."
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="A check has been performed on perio sequence numbers to check for duplicates."
 S %=%+1,@R@(%,0)="If duplicates were found, the perio for that patient was resquenced "
 S %=%+1,@R@(%,0)="based on date/time."
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="Four new paramters were added.  DENTV HL7 BATCH LIMIT sets a limit for how many"
 S %=%+1,@R@(%,0)="HL7 messages can be sent in a given batch.  The other three parameters are for"
 S %=%+1,@R@(%,0)="storing URLs to be accessed from the DRM Plus GUI.  The parameters names are"
 S %=%+1,@R@(%,0)="DENTV DOCUMENT LIBRARY, DENTV REPORTING SERVICES, and DENTV CODING STANDARDS."
 S XMTEXT="DENTVTXT("
 D ^XMD
 Q
