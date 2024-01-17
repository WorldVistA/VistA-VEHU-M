TIUASCU1 ; NA/AJB - ADDITIONAL SIGNER CLEANUP 2.0;11/02/23  11:17
 ;;1.0;TEXT INTEGRATION UTILITIES;**357**;Jun 20, 1997;Build 5
 ;
 ; Reference to $$GET1^DID supported by ICR #2052
 ; Reference to $$GET1^DIQ supported by ICR #2056
 ; Reference to $$DIV^XUSER supported by ICR #2533
 ; Reference to HOME^%ZIS supported by ICR #10086
 ; Reference to *^XGF supported by ICR #3173
 ; Reference to *^XLFDT supported by ICR #10103
 ; Reference to *^XLFSTR supported by ICR #10104
 ; Reference to ^%ZTLOAD supported by ICR #10063
 ; Reference to ^DIC supported by ICR #10006
 ; Reference to ^DIK supported by ICR #10013
 ; Reference to ^DIR supported by ICR #10026
 ; Reference to ^XMD supported by ICR #10070
 ; Reference to File ^DIC(49 supported by ICR #4330
 ; Reference to File ^DPT supported by ICR #10035
 ; Reference to File ^VA supported by ICR #10060
 ; Reference to EN^XUTMDEVQ supported by ICR #1519
 ; Reference to HASH^XUSHSHP supported by ICR #10045
 ; Reference to ^%ZOSF(*) supported by ICR #10096
 ; Reference to *^XGF supported by ICR #3173
 ;
 Q
SETUP(SCR,DATE) ; ask user for type of search
LIST ;Date Range:DT^Additional Signer:200^Service/Section:49^^Division:4^Document Status:8925.6^DISUSER'D:DIS^^Terminated:TERM
 N DIR,EXIT,I,J,LIST,SEL,VAL,X,Y
 S DIR("A",1)="Select SEARCH CRITERIA:",DIR("A",2)="",EXIT=0
 S (I,J)=0,LIST=$P($T(LIST),";",2),X=$O(DIR("A",""),-1)+1 F Y=1:1:$L(LIST,U) D
 . I $P(LIST,U,Y)="" S I=0,X=X+1 Q
 . S I=I+1,J=J+1 S DIR("A",X)=$$SETSTR(" "_J_" "_$P($P(LIST,U,Y),":"),$S('$D(DIR("A",X)):"",1:DIR("A",X)),$S(I=1:0,1:((I-1)*25)),$L($P(LIST,U,Y))+3)
 . S LIST(J)=$P($P(LIST,U,Y),":",2)
 S DIR("A",X+1)="",DIR("A")="Enter SELECTION: ",DIR("B")=1,DIR(0)="LAO^1:"_J S SEL=$$DIR(.DIR) Q:'SEL 0
 F X=1:1:$L(SEL,",")-1 D  Q:EXIT
 . N DIC S Y=$P(SEL,",",X) I LIST(Y)="DT" D DATE(.DATE,.SCR) S:'SCR("Start")!('SCR("End")) EXIT=1 Q
 . I LIST(Y)="TERM"!(LIST(Y)="DIS") S SCR($S(LIST(Y)="TERM":"Terminated",1:"DISUSER'd"))="1^YES" Q
 . S DIC=LIST(Y),DIC("A")=$S(DIC=200:"Enter ADDITIONAL SIGNER: ",DIC=4:"Enter DIVISION: ",DIC=49:"Enter SERVICE/SECTION: ",DIC=8925.6:"Enter DOCUMENT STATUS: ")
 . N VAL S VAL=$$DIC(.DIC) S:VAL=U EXIT=1 Q:EXIT  S:+VAL SCR(LIST(Y))=VAL
 Q $S(EXIT:0,1:1)
DATE(DATE,SCR) ;
 S (SCR("Start"),SCR("End"))="" N X F X="Start","End" D  Q:'SCR(X)
 . N DIR S DIR(0)="DOA^"_DATE("Start")_":"_DATE("End"),DIR("?")="Enter a date from "_$$FMTE^XLFDT(DATE("Start"))_" to "_$$FMTE^XLFDT(DATE("End"))
 . S DIR("?",1)="This date is the "_$S(X="Start":"earliest",1:"latest")_" date an outstanding additional signature is due.",DIR("?",2)=""
 . S DIR("A")="Enter "_$S(X="Start":"STARTING",1:"ENDING")_" DATE: ",DIR("B")=$S(X="Start":$$FMTE^XLFDT(DATE("Start")),1:$$FMTE^XLFDT($$FMADD^XLFDT(DT,-30)))
 . S SCR(X)=$$DIR(.DIR) I $E(SCR(X),6,7)="00" S SCR(X)=SCR(X)+$S(X="Start":1,1:101) S:X="End" SCR(X)=$$FMADD^XLFDT(SCR(X),-1)
 . S $P(SCR(X),U,2)=$$FMTE^XLFDT(SCR(X)) S:+SCR(X)&(X="End") $P(SCR(X),U)=$P(SCR(X),U)+.24
 I 'SCR("Start")!('SCR("End")) S (SCR("Start"),SCR("End"))=""
 Q
DIC(DIC) ; basic lookup
 N DIRUT,DTOUT,DUOUT,X,Y S DIC=$$GET1^DID(DIC,"","","GLOBAL NAME"),DIC(0)="AE" D ^DIC
 Q $S(+Y>0:Y,X=U:U,+$G(DTOUT):U,Y'>0:0,1:Y)
DIR(DIR,PROMPT,DEFAULT,HELP,SCREEN) ; response reader
 N DIROUT,DIRUT,DTOUT,DUOUT,X,Y S:'$D(DIR(0)) DIR(0)=$G(DIR) S:'$D(DIR("A"))&($G(PROMPT)'="") DIR("A")=PROMPT S:'$D(DIR("B"))&($G(DEFAULT)'="") DIR("B")=DEFAULT
 S:'$D(DIR("S"))&($G(SCREEN)'="") DIR("S")=SCREEN S:'$D(DIR("?"))&($D(HELP)) DIR("?")=$S($G(HELP)'="":HELP,1:$G(HELP("?"))) M DIR=HELP D ^DIR
 Q $S(X[U:U,+Y:Y,1:"")
MAIL(LOC) ;
 N COL,DATA,X,XMDUN,XMDUZ,XMSUB,XMTEXT,XMY,XMZ S COL=24,XMTEXT($O(XMTEXT(""),-1)+1)="Task is complete.  The completed report is available via the option.",XMTEXT($O(XMTEXT(""),-1)+1)=""
 S DATA="User:  ",DATA=$$SETSTR(DATA,"",COL-$L(DATA),$L(DATA))_$P(@LOC@("User"),U),XMTEXT($O(XMTEXT(""),-1)+1)=DATA
 S DATA="Mode:  ",DATA=$$SETSTR(DATA,"",COL-$L(DATA),$L(DATA))_@LOC@("Action"),XMTEXT($O(XMTEXT(""),-1)+1)=DATA
 S DATA="Duration:  ",DATA=$$SETSTR(DATA,"",COL-$L(DATA),$L(DATA))_@LOC@("Elapsed"),XMTEXT($O(XMTEXT(""),-1)+1)=DATA
 S DATA="# Signatures:  ",DATA=$$SETSTR(DATA,"",COL-$L(DATA),$L(DATA))_@LOC@("Total"),XMTEXT($O(XMTEXT(""),-1)+1)=DATA
 S XMTEXT($O(XMTEXT(""),-1)+1)="",DATA="Search Criteria:  ",DATA=$$SETSTR(DATA,"",COL-$L(DATA),$L(DATA)),XMTEXT($O(XMTEXT(""),-1)+1)=DATA,XMTEXT($O(XMTEXT(""),-1)+1)=""
 S DATA="[Date Range]  ",DATA=$$SETSTR(DATA,"",COL-$L(DATA),$L(DATA))_@LOC@("Start Date")_" to "_@LOC@("Stop Date"),XMTEXT($O(XMTEXT(""),-1)+1)=DATA
 F X="DISUSER'd","Terminated",200,49,4,8925.6 D:+@LOC@(X)
 . S DATA=$S(X=200:"[Additional Signer]",X=49:"[Service/Section]",X=4:"[Division]",X=8925.6:"[Status]",1:"["_X_"]")_"  "
 . S DATA=$$SETSTR(DATA,"",COL-$L(DATA),$L(DATA))_$P(@LOC@(X),U,2),XMTEXT($O(XMTEXT(""),-1)+1)=DATA
 S XMDUZ=.5,XMSUB="Additional Signer Report Complete",XMTEXT="XMTEXT("
 S XMY($P(@LOC@("User"),U))=""
 D ^XMD
 Q
SETSTR(S,V,X,L) ; insert text(S) into variable(V) at position (X) with length of (L)
 Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
R X ^%ZOSF("EOFF") R X:60 X ^%ZOSF("EON") S:'$T X="^" Q  ; read input for signature code
SIG(ROW,COL) ; -1=no DUZ/signature code 0=verification failed 1=verified
 S ROW=$G(ROW,0),COL=$G(COL,0)
 N I,K,X,X1 S K=0,X1=$P($G(^VA(200,+$G(DUZ),20)),U,4) I X1="" D  Q -1
 . D SAY^XGF(ROW,COL,"No Electronic Signature Code to verify.")
S1 D SAY^XGF(ROW,COL,"Enter your current Signature Code:  ")
 D SAY^XGF(ROW+2,COL,"Please enter your Electronic Signature Code to acknowledge")
 D SAY^XGF(ROW+3,COL,"data deletion from File #8925.7.")
 D IOXY^XGF(ROW,47),R G:X=""!(X="^") EXIT
 I X?1.2"?" G S1 D
 . ;D SAY^XGF(ROW+2,COL,"Please enter your Electronic Signature Code to acknowledge")
 . ;D SAY^XGF(ROW+3,COL,"potential data deletion from TIU MULTIPLE SIGNATURE File.")
 S K=K+1 D HASH^XUSHSHP I X1'=X D SAY^XGF(,47,"??") H 1 D SAY^XGF(,47,"  ") S X="" G S1:K<3
EXIT D SAY^XGF(ROW,47,$S(X1=X:"SIGNATURE VERIFIED",1:"SIGNATURE NOT VERIFIED"))
 N Y F Y=2,3 D SAY^XGF(ROW+Y,COL,"                                                           ")
 Q $S(X1=X:1,1:0)
INTRO F X=1:1 S Y=$P($T(INTRO+X),";;",2) Q:Y="EOM"  W @Y,!,IOCUON
 ;;"VHA HANDBOOK 1907.01 defines the additional signer role as follows:"
 ;;""
 ;;"""Additional signer"" is a communication tool used to alert a clinician about"
 ;;"information pertaining to the patient.  This functionality is designed to"
 ;;"allow clinicians to call attention to specific documents and the recipient to"
 ;;"acknowledge receipt of the information.  Being identified as an additional"
 ;;"signer does not constitute a co-signature.  This nomenclature in no way implies"
 ;;"responsibility for the content of, or concurrence with, the note."""
 ;;""
 ;;""
 ;;"This utility provides options to report and/or remove outstanding additional"
 ;;"signers and the associated alerts by either date range or additional signer."
 ;;""
 ;;$$CJ^XLFSTR("** WARNING **",IOM)
 ;;""
 ;;IOBON_IORVON_"Removing additional signers from a document is PERMANENT and cannot be undone."_IORVOFF_IOBOFF
 ;;""
 ;;$$CJ^XLFSTR("** WARNING **",IOM)
 ;;""
 ;;EOM
