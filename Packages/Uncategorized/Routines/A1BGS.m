A1BGS ;ALB/RLW - PATIENT ADDRESS COLLECTION (SITE SIDE) ; AUG 19 1992
 ;; Version 2.0 ; PATIENT ADDRESS COLLECTION ;; 21-SEP-92
 ;
 ; Variables used:
 ;    A1BGTOT  = Checksum total
 ;    A1BGSITE = Site number
 ;    A1BGMTCH = 1 if match found, 0 otherwise
 ;    A1BGCTR  = Counter of records processed
 ;    A1BGBDMT = Counter of bad matches found
 ;    A1BGSTRT = Time extract started (NOW^%DTC)
 ;    A1BGTEXT = Local array to hold text for site e-mail notification
 ;    A1BGDATA = Lines of data to be sent
 ;
EN ; entry point
 K ^TMP("A1BGTRN",$J) D DT^DICRW S A1BGCTR=0 D NOW^%DTC S A1BGSTRT=%
 S (A1BGBDMT,A1BGLINE,A1BGTOT)=0
 S A1BGSITE=+$P($$SITE^VASITE,"^",3)
 ;
 ;read incoming message (patient names)
 X XMREC Q:XMER  I $P(XMRG,"^",1)'="$START" S ^TMP("A1BGTRN",$J,I,.01)="ERROR - FIRST LINE OF MESSAGE="_XMRG G MAIL
 F  X XMREC Q:XMER  Q:XMRG="$END"  D SSNX
 ;
 ;insert header and footer records
 D NOW^%DTC ; get end time for processing
 S ^TMP("A1BGTRN",$J,.01)="$START^"_A1BGSITE_"^"_A1BGCTR_"^"_A1BGBDMT_"^"_A1BGSTRT_"^"_%,^TMP("A1BGTRN",$J,A1BGLINE+1)="$END"
 ;
MAIL ;send address information to ISC server for processing
 ;
 N XMB ; newed because of recursive problem with mail/servers
 S XMSUB="PAC DATA FROM "_$G(^XMB("NETNAME")),XMN=0
 S XMTEXT="^TMP(""A1BGTRN"","_$J_","
 S XMDUZ=.5
 S XMY("S.A1BG-PAC-ISC-SERVER@ISC-ALBANY.VA.GOV")=""
 S XMY("G.A1BG PAC NOTIFICATION@ISC-ALBANY.VA.GOV")=""
 D ^XMD
 K XMDUZ,XMN,XMSUB,XMTEXT,XMY
 ;
 ;send status message to A1BG PAC NOTIFICATION mailgroup
 ;
 S J=$O(^XMB(3.8,"B","A1BG PAC NOTIFICATION",0)) I '$G(^XMB(3.8,+J,0))']"" G QUIT ; no mailgroup defined on system
 F I=0:0 S I=$O(^XMB(3.8,J,1,"B",I)) Q:'I  S XMY(I)="" ; get recipients
 S XMSUB="PAC DATA TRANSMITTED TO ISC-ALBANY",XMN=0
 S A1BGTEXT(1)="The Patient Address Collection software has run.  Address data for"
 S A1BGTEXT(2)=A1BGCTR_" patients was returned to the Albany ISC for processing."
 S A1BGTEXT(3)="",A1BGTEXT(4)="You will receive a confirmation message when the data has been received",A1BGTEXT(5)="by the ISC-ALBANY.VA.GOV domain."
 S Y=A1BGSTRT X ^DD("DD") S A1BGTEXT(6)="",A1BGTEXT(7)="START TIME: "_Y
 D NOW^%DTC S Y=% X ^DD("DD") S A1BGTEXT(8)="  END TIME: "_Y
 S XMDUZ=.5,XMTEXT="A1BGTEXT("
 D ^XMD
 ;
QUIT K %,A1BGBDMT,A1BGCTR,A1BGDATA,A1BGLINE,A1BGMTCH,A1BGSITE,A1BGSTRT,A1BGTEXT,A1BGTOT,DFN,I,J,X,XMDUZ,XMER,XMN,XMREC,XMRG,XMSUB,XMTEXT,XMY,Y
 D KVA^VADPT K ^TMP("A1BGTRN",$J)
 Q
 ;
SSNX ; look for SSN
 S A1BGMTCH=0
 Q:$P(XMRG,"^",2)']""  ; No SSN passed in
 S DFN=+$O(^DPT("SSN",$P(XMRG,"^",2),0)) I '$D(^DPT(DFN,0)) D EXTRACT Q  ;SSN not found
 S A1BGMTCH=1
 ;
EXTRACT ; extract DOB, address information; build ^TMP global.
 S VAPA("P")="" D 4^VADPT ;get demographic and address data
 S A1BGDATA="$PAT1^"_$P(XMRG,"$PAT^",2) D ADDLINE ; send back original data
 S A1BGDATA="$PAT2^"_$S(VADM(1)]"":VADM(1),1:"**NO MATCH FOUND**")_"^"_$P(VADM(2),"^",2)_"^"_$P(VADM(3),"^",2) S:$G(^DPT(DFN,.35)) A1BGDATA=A1BGDATA_"^**" D ADDLINE ; name^SSN^DOB^Deceased (if applicable)
 S A1BGDATA="$ADR1^"_VAPA(1)_"^"_VAPA(2)_"^"_VAPA(3) D ADDLINE ; street address lines 1, 2, and 3
 S A1BGDATA="$ADR2^"_VAPA(4)_"^"_$P(VAPA(5),"^",2)_"^"_VAPA(6)_"^"_VAPA(8) D ADDLINE ; city, state, zip, phone
 S A1BGCTR=A1BGCTR+1 I 'A1BGMTCH S A1BGBDMT=A1BGBDMT+1 ; bad matches
 Q
 ;
ADDLINE ; Add line to TMP global
 ;
 ; Input:  A1BGDATA as data to go into global
 ;         A1BGLINE as running counter of lines
 ;
 N X
 S A1BGLINE=A1BGLINE+1
 S ^TMP("A1BGTRN",$J,A1BGLINE)=A1BGDATA
 ;
 ; calculate checksum for a line
 S X=A1BGDATA
 X ^%ZOSF("LPC") S A1BGTOT=A1BGTOT+(Y+$L(X)*$L(X)) ; checksum in ()s
 Q
