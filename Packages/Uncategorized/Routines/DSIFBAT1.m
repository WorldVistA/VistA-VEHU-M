DSIFBAT1 ;DSS/RED - RPC FOR FEE BASIS PAYMENTS ;09/13/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,10,8,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;             Integration Agreements
 ; 10018  ^DIE                          5275    ^FBAA(161.4
 ;  2053  UPDATE^DIE                5273    ^FBAA(161.7
 ; 10013  ^DIK                          5409    ^FBAA(162.1
 ;  2056  GETS^DIQ                   5107    ^FBAAC(
 ;  5082  SITE^FBAACO              5277    ^FBAAI(
 ;  5088  CNTTOT^FBAARB          5301    ^PRC(420
 ;  5091  $$CHKBI^FBAAUTL4     5274    ^PRC(442
 ;  315   EN3^PRCS58               10060   ^VA(200    
 ; 10103  $$FMTE^XLFDT          10076   ^XUSEC("FBAASUPERVISOR"
 ;  2171 - $$STA^XUAF4
 ; 
 Q
NEWBAT(FBOUT,FBOBL,TYPE,FBCP,DSIFEX)  ; RPC: DSIF BATCH CREATE  ; (create a new batch number)
 ; Input: FBOBL = Obligation number, format Statnum-Obligation number
 ;          Type = Batch type "B3","B9" etc.;   FBCP = Fund control point, 
 ;              DSIFEX - Batch exempt (Y/N) [added DSIF*3.2*10]
 ; FBOUT = Normal return or error message = Batch number^IEN^Purge message for IRM staff (if applicable) 
 ;              or -1^Unable to create a batch, quitting^Purge message for IRM staff (if applicable)
 N FBBN,PURGE,IENROOT,FBIENS,FDA,FDA,MSG,STANUM,FBSITE,PRCS,PRC K FBOUT
 I $G(FBOBL)=""!($G(TYPE)="")!($G(DUZ)="")!(FBCP="") S FBOUT="-1^Invalid or missing input parameters" Q
 I TYPE="B9",$G(DSIFEX)=""!("YN"'[DSIFEX) S FBOUT="-1^Batch exempt Y/N value is required" Q  ;Added with DSIF*3.2*10
 I '$$SITEP^DSIFPAYR S FBOUT="-1^Site parameters not set properly" Q 
 I $G(DUZ)="" S FBOUT="-1^Undefined User" Q
 K PRCS("X") S PRCS("TYPE")="FB",PURGE="" S:FBOBL["-" FBOBL=$P(FBOBL,"-",2)  ;DSIF*3.2*8 - Purge variable undefined
 S STANUM=$$STA^XUAF4($P($G(FBSITE(1)),U,3))  ; Set station number
 S PRCS("X")=STANUM_"-"_FBOBL,PRCS("TYPE")="FB" D EN3^PRCS58 I Y=-1 S FBOUT="-1^1358/Obligation not available for posting!"
 S FBCP=+FBCP I '$D(^PRC(420,"A",DUZ,STANUM,FBCP)) S FBOUT="-1^Not an authorized user" Q
GETNXB L +^FBAA(161.4,1,"FBNUM"):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S FBOUT="-1^Unable to lock file 161.4, try again later" D UL Q
 I '$D(^FBAA(161.4,1,"FBNUM")) S ^FBAA(161.4,1,"FBNUM")="1^1"
 I '$P($G(^FBAA(161.4,1,"FBNUM")),"^") S $P(^("FBNUM"),"^")=1
 S FBBN=$P(^FBAA(161.4,1,"FBNUM"),"^")
 ; Changed purge batches message (for IRM) logic in DSIF*3.2*8 - as per FB*3.5*114
 I $P(^FBAA(161.7,0),U,4)>99899 S PURGE="There are "_(99899-FBBN)_" batches left before the BATCH PURGE routine needs to be run. Contact your IRM Service!"
 ; DSIF*3.2*8 if next batch number is unavailable then try again as per logic in FBAAUTL
 S $P(^FBAA(161.4,1,"FBNUM"),"^",1)=$S(FBBN+1>99899:1,1:FBBN+1) I '$$CHKBI^FBAAUTL4(FBBN,1) D UL G GETNXB
 S FBIENS="+1,",PRC("SITE")=$$STA^XUAF4($P($G(FBSITE(1)),U,3))
 S FDA(161.7,FBIENS,.01)=FBBN,FDA(161.7,FBIENS,1)=FBOBL,FDA(161.7,FBIENS,2)=TYPE,FDA(161.7,FBIENS,3)=DT,FDA(161.7,FBIENS,4)=DUZ,FDA(161.7,FBIENS,11)="O",FDA(161.7,FBIENS,16)=PRC("SITE")
 I TYPE="B9" S FDA(161.7,FBIENS,17)="Y",FDA(161.7,FBIENS,18)=DSIFEX
 S IENROOT="" D UPDATE^DIE("","FDA","IENROOT","MSG") I $D(MSG) S FBOUT="-1^error in update, unable to continue" D UL Q
 D UL S FBOUT=1_U_IENROOT(1)_";"_FBBN_U_$G(PURGE)
 Q
DISOPENB(FBOUT,FBTYPE) ; RPC: DSIF BATCH DISP OPEN
 ; Input:  FBTYPE (optional) B3, B5, B2 or B9  (logic from routine FBAADOB)
 ; FBOUT(0)=1 (Successful) or 0 (No open batches) or -1 (error)
 ; FBOUT(1...n)="Batch"^IEN;Batch #^Type^Date Open^Clerk who opened^Obligation #^FCP
 N B,Z,B1,B2,BT,B3,B4,CNT,Y,FBOBL,FCP,FBSUP,FBSITE
 S FBSUP=0 I $D(^XUSEC("FBAASUPERVISOR",DUZ)) S FBSUP=1
 K FBOUT S Y=0,CNT=1 D SITE^FBAACO
 I $G(FBTYPE)'="",FBTYPE'?1"B"1N S FBOUT="-1^Invalid Type entered" Q
 I '$D(^FBAA(161.7,"AC","O")) S FBOUT(0)=0 Q
 F B=0:0 S B=$O(^FBAA(161.7,"AC","O",B)) Q:B'>0  I $D(^FBAA(161.7,B,0)) S Z=^(0) D
 . I $P(Z,U,5)'=DUZ&'FBSUP Q
 . S B1=$P(Z,"^",1),B4=$$STA^XUAF4($P($G(FBSITE(1)),U,3))_"-"_$P(Z,"^",2),FCP=$P($P(^PRC(442,$O(^PRC(442,"B",B4,0)),0),U,3)," ",1)
 . S B2=$P(Z,"^",4)_";"_$$FMTE^XLFDT($P(Z,"^",4),5),BT=$P(Z,"^",3)
 . I $G(FBTYPE)'="",BT'[FBTYPE Q
 . S BT=$S(BT="B3":"Medical",BT="B5":"Pharmacy",BT="B2":"Travel",BT="B9":"CH/CNH",1:"Unknown")
 . S BT=$S($P($G(Z),U,19):BT_"-STAT",1:BT)
 . S B3=$S($P(Z,"^",5)]"":$P(Z,"^",5),1:""),B3=$S(B3="":"",$D(^VA(200,B3,0)):B3_";"_$P(^VA(200,B3,0),"^",1),1:"")
 . S FBOUT(CNT)="Batch"_U_B_";"_B1_U_BT_U_B2_U_B3_U_B4_U_FCP,CNT=CNT+1
 I $D(FBOUT(1)) S FBOUT(0)=1_U_(CNT-1)
 Q
DELBATCH(FBOUT,FBBAT) ;  RPC: DSIF BATCH DELETE
 ; Delete a batch - Mimics logic from FBAABDL; FBBAT = batch number, IEN if passed in as "nnn;"
 K FBOUT N IEN,CNT,X,Y,DIC,FBNO,N,FBTYPE,FLAG S FLAG=0
 D START(FBBAT) S:FBERR FBOUT=FBERR Q:FLAG  I $P(Y(0),U,5)=DUZ
 ;DSIF*3.2*2 (moved the flag check up one line)
 S FBNO=1 I $G(IEN) N FBTOTAL,FBLCNT D
 .D CNTTOT^FBAARB(IEN) S DA=IEN,DIE="^FBAA(161.7,",DR="10///^S X=FBLCNT;8///^S X=FBTOTAL;S:FBLCNT!(FBTOTAL) Y="""";9///@" D ^DIE K DIE,DR,DA D
 ..S:FBTOTAL=0 $P(^FBAA(161.7,+IEN,0),U,9)="" S:FBLCNT=0 $P(^FBAA(161.7,+IEN,0),U,11)=""
 .S FBBAT(0)=^FBAA(161.7,+IEN,0)
 F I=9,10,11 I $P(FBBAT(0),U,I)>0 S TEST(I)=$P($T(NOGO+(I-8)),";;",2) S FBNO=0
 S FBTYPE=$P(^FBAA(161.7,IEN,0),"^",3) I $S(FBTYPE="B3":$D(^FBAAC("AC",IEN)),FBTYPE="B5":$D(^FBAA(162.1,"AE",IEN)),FBTYPE="B9":$D(^FBAAI("AC",IEN)),FBTYPE="B2":$D(^FBAAC("AD",IEN)),1:0) D 
 .S FBOUT="-1^"_$P($T(NOGO+5),";;",2)
 I $P(FBBAT(0),U,17)="Y" S FBOUT="-1^"_$P($T(NOGO+4),";;",2) S FBNO=0 Q
 I $G(FBNO) S DA=IEN,DIK="^FBAA(161.7," D ^DIK K DIK S FBOUT=1_U_FBBAT_U_" Batch Deleted."
 Q
NOGO ;reasons why batch cannot be deleted
 ;;Total dollars>0
 ;;Invoice count>0
 ;;Payment lien count>0
 ;;Rejects pending flag is 'YES'
 ;;Batch has existing invoices
 ;
START(FBBAT) ; Set initial variables  (As per DSIF*3.2*1, if FBBAT formatted as "nnn;" it is an IEN for file 161.7)
 S FBERR=""
 I FBBAT[";",$P(FBBAT,";",1)="" S FBERR="-1^Not a valid batch number",FLAG=1 Q
 S IEN=$S(FBBAT'[";":$O(^FBAA(161.7,"B",FBBAT,"")),1:+FBBAT) I IEN="" S FBERR="-1^Not a valid batch number",FLAG=1 Q
 I FBBAT[";" S FBBAT=$P($G(^FBAA(161.7,IEN,0)),U)   ; DSIF*3.2*1 removed line of code above
 I '$D(^FBAA(161.7,IEN,0)) S FBERR="-1^Not a valid batch selection, quitting",FLAG=1 Q
 S DIC="^FBAA(161.7,",DIC(0)="AEQZ",DIC("S")=$S($D(^XUSEC("FBAASUPERVISOR",DUZ)):"",1:"I $P(^(0),U,5)=DUZ")
 S Y(0)=^FBAA(161.7,IEN,0),X=$P(Y(0),U),Y=IEN_U_FBBAT
 I FBBAT="" S FBERR="-1^Batch IEN of :"_IEN_" has invalid data, please contact IRM",FLAG=1
 S FLAG=0,SUP=1 I '$D(^XUSEC("FBAASUPERVISOR",DUZ)),$P($G(Y(0)),U,5)'=DUZ  S FBERR="-1^User does not hold the Supervisor Key and not the opening user, quitting",FLAG=1
 Q
CLOSEBAT(FBOUT,FBBAT) ;  RPC:  DSIF BATCH CLOSE
 ;Input: Batch IEN if passed as "nnn;" DSIF*3.2*1
 ;Output:  FBOUT=1 (successful) or -1 (error) and error Message^Batch #^Obligation #^Type^Date opened(Int;ext)^Clerk who opened(DUZ:name)^Station number^Total dollars^Payment line count^Status
 K FBOUT,TEST N IEN,TEST,CNT,X,Y,FBNO,N,FBTYPE,SUP,FLAG,LIST,FBDAT,A,C,FZ,IENS,I,J,K,L,M,T,FBIN,MSG,FBARY,DSIFZERO
 S FBOUT=$NA(^TMP("DSIFBAT1",$J)) K @FBOUT   ;Changed to global array return in DSIF*3.2*10
 S @FBOUT@(0)="-1"
 D START(FBBAT) I FLAG S @FBOUT@(0)=FBERR Q
 S B=+Y,FZ=^FBAA(161.7,B,0),FBTYPE=$P(FZ,"^",3)
 ; DSIF*3.2*1 Add check to see if the batch has a status of "Open"
 I $D(^FBAA(161.7,"AC","T",B))!($G(^FBAA(161.7,B,"ST"))'="O") S @FBOUT@(0)="-1^Status must be Open to Close it" Q
 I FBTYPE="B3",'$D(^FBAAC("AC",B)) S @FBOUT@(0)="-1^No payments in Batch yet!" Q
 I FBTYPE="B2",'$D(^FBAAC("AD",B)) S @FBOUT@(0)="-1^No Payments in Batch yet!" Q
 I FBTYPE="B5",'$D(^FBAA(162.1,"AE",B)) S @FBOUT@(0)="-1^No Payments in Batch yet!" Q
 I FBTYPE="B9",'$D(^FBAAI("AC",B)) S @FBOUT@(0)="-1^No Payments in Batch yet!" Q
 S C=0,T=0 G PHARM:FBTYPE="B5",TRAV:FBTYPE="B2"
 I FBTYPE="B9" S DSIFZERO=0 D CHNH   ;Q:DSIFZERO  ;Logic from FBAACCB1 added with DSIF*3.2*10
 I FBTYPE'="B9" F J=0:0 S J=$O(^FBAAC("AC",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AC",B,J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AC",B,J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AC",B,J,K,L,M)) Q:M'>0  D GOT
FIN ;
 D CHECK(.FBARY)
 I $D(FBARY) D  Q
 . S DSIFZERO=1,@FBOUT@(0)="-1^Batch cannot be closed. Listed invoices are zero dollar and must be corrected or removed from the batch."
 S $P(FZ,"^",9)=T,$P(FZ,"^",11)=C
 S $P(FZ,"^",13)=DT,^FBAA(161.7,B,0)=FZ,^FBAA(161.7,B,"ST")="C",^FBAA(161.7,"AC","C",B)=""
 K ^FBAA(161.7,"AC","O",B),^FBAA(161.7,"AB","O",$P(^FBAA(161.7,B,0),"^",5),B),MSG
 S IENS=B_"," D GETS^DIQ(161.7,IENS,"**","IE","LIST","MSG") S FBDAT=$NA(LIST(161.7,IENS)) I $D(MSG) S @FBOUT@(0)="-1^Error in Batch #: "_B_";"_FBBAT_" is invalid" Q
 S @FBOUT@(0)=1,@FBOUT@(1)=1_U_@FBDAT@(.01,"E")_U_@FBDAT@(1,"E")_U_@FBDAT@(2,"E")_U_@FBDAT@(3,"I")_";"_@FBDAT@(3,"E")_U_@FBDAT@(4,"I")_U_@FBDAT@(4,"E")_U_@FBDAT@(16,"E")_U_@FBDAT@(8,"E")_U_@FBDAT@(10,"E")_U_@FBDAT@(11,"E")
 Q 
GOT S Y(0)=$G(^FBAAC(J,1,K,1,L,1,M,0)),FBIN=$P(Y(0),"^",16)
 S T=T+$P(Y(0),"^",3),C=C+1
 ; DSIF*3.2*10 - HIPAA 5010 - count line items that have 0.00 amount paid
 S FBARY(FBIN)=$G(FBARY(FBIN))+$P(Y(0),"^",3)
 Q
TRAV ;ENTRY FOR TRAVEL BATCH CALCULATE TOTAL DOLLARS AND LINE COUNT
 ; DSIF*3.2*10 - HIPAA 5010 - count line items that have 0.00 amount paid
 F J=0:0 S J=$O(^FBAAC("AD",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AD",B,J,K)) Q:K'>0  I $D(^FBAAC(J,3,K,0)) S Z(0)=^(0),T=T+$P(Z(0),"^",3),C=C+1
 G FIN
PHARM ;ENTRY FOR PHARMACY BATCH CALCULATE TOTAL DOLLARS AND LINE COUNT
 ; DSIF*3.2*10 - HIPAA 5010 - count line items that have 0.00 amount paid
 F A=0:0 S A=$O(^FBAA(162.1,"AE",B,A)) Q:A'>0  F B2=0:0 S B2=$O(^FBAA(162.1,"AE",B,A,B2)) Q:B2'>0  I $D(^FBAA(162.1,A,"RX",B2,0)) S Z(0)=^(0),T=T+$P(Z(0),"^",4),C=C+1
 G FIN
REOPENB(FBOUT,FBBAT) ; RPC: DSIF BATCH REOPEN
 ; Input:  Batch number [Batch IEN if passed as "nnn;" DSIF*3.2*1] 
 ; Output: "1^Batch re-opened" or -1^error message
 K FBOUT,TEST N A,B,I,J,K,DIC,FBNO,N,FBTYPE,FLAG,FBLCNT,FBTOTAL
 D START(.FBBAT) I FLAG S FBOUT=FBERR Q
 S FBTYPE=$P(Y(0),U,3),B=+Y
 S (FBLCNT,FBTOTAL)=0
 I '$G(B) S FBOUT="-1^Invalid batch number" Q
 I '$D(^FBAA(161.7,+B,0)) S FBOUT="-1^Invalid batch number" Q
 I $G(^FBAA(161.7,+Y,"ST"))="R"!($G(^FBAA(161.7,+Y,"ST"))="S")!($G(^FBAA(161.7,+Y,"ST"))="T") S FBOUT="-2^Batch cannot be reopened" Q 
 I $G(^FBAA(161.7,+Y,"ST"))="O" S FBOUT="-1^Batch is already open" Q
 I $G(FBTYPE)']"" S FBOUT="-1^Invalid batch type, please check batch: "_$P(Y,U,2) Q
 I FBTYPE="B2"!(FBTYPE="B5") S FBOUT="-1^This batch type: "_FBTYPE_" are not supported at this time" Q
 D @FBTYPE I FLAG S FBOUT="-1^Unable to reopen batch at this time" Q   ;DSIF*3.2*8
 S DA=+Y,DIE="^FBAA(161.7,",DR="4///^S X=DUZ;4.5///@;10///^S X=FBLCNT;8////^S X=FBTOTAL;11///^S X=""O"";S:$G(FBTYPE)'=""B9"" Y="""";9///^S X=FBLCNT" D ^DIE K DIE,DR
 ; add line to check to see if the ^DIE call was successful...  DSIF*3.2*8
 S FBOUT="1^Batch "_$G(X)_" re-opened" Q
B2 ;travel batch use ^FBAAC("AD"
 N I,J S (I,J)=0 F  S I=$O(^FBAAC("AD",B,I)) Q:'I  F  S J=$O(^FBAAC("AD",B,I,J)) Q:'J  I $D(^FBAAC(I,3,J,0)) S FBLCNT=FBLCNT+1,FBTOTAL=FBTOTAL+$P(^(0),U,3)
 Q
B3 ;outpatient batch use ^FBAAC("AC"     ;; Use of FLAG to check payments added with DSIF*3.2*8
 N I,J,K,L S (I,J,K,L)=0,FLAG=1 F  S I=$O(^FBAAC("AC",B,I)) Q:'I  F  S J=$O(^FBAAC("AC",B,I,J)) Q:'J  F  S K=$O(^FBAAC("AC",B,I,J,K)) Q:'K  F  S L=$O(^FBAAC("AC",B,I,J,K,L)) Q:'L  I $D(^FBAAC(I,1,J,1,K,1,L,0)) D
 . S FBLCNT=FBLCNT+1,FBTOTAL=FBTOTAL+$P(^FBAAC(I,1,J,1,K,1,L,0),U,3),FLAG=0
 Q
B5 ;pharmacy batch use ^FBAA(162.1,"AE"
 N I,J S (I,J)=0,FLAG=1 F  S I=$O(^FBAA(162.1,"AE",B,I)) Q:'I  F  S J=$O(^FBAA(162.1,"AE",B,I,J)) Q:'J  I $D(^FBAA(162.1,I,"RX",J,0)) D
 . S FBLCNT=FBLCNT+1,FBTOTAL=FBTOTAL+$P(^FBAA(162.1,I,"RX",J,0),U,16),FLAG=0
 Q
B9 ;inpatient batch use ^FBAAI("AC"  ;; Use of FLAG to check invoices added with DSIF*3.2*8
 N I S I=0,FLAG=1 F  S I=$O(^FBAAI("AC",B,I)) Q:'I  I $D(^FBAAI(I,0)) D
 . S FBLCNT=FBLCNT+1,FBTOTAL=FBTOTAL+$P(^FBAAI(I,0),U,9),FLAG=0
 Q
UL ;
 L -^FBAA(161.4,1,"FBNUM") Q
 Q
CHNH ; DSIF*3.2*10  to address FB*3.5*116
 S (J,FZ("CNT"))=0 F  S J=$O(^FBAAI("AC",B,J)) Q:J'>0  I $D(^FBAAI(J,0)) S Z(0)=^(0) D MORECH D:$P(FZ,U,15)'="Y" INVCNT
 S:$G(FZ("CNT")) $P(FZ,U,10)=FZ("CNT") K FZ("CNT")  ; CNH batch
 G FIN
MORECH ; HIPAA 5010 - count line items that have 0.00 amount paid
 S T=T+$P(^FBAAI(J,0),"^",9),C=C+1
 ; FB*3.5*116/DSIF*3.2*10 - do not build array for contract hospital batches that are not exempt from the pricer
 Q:($P(FZ,"^",18)'="Y")&($P(FZ,"^",15)="Y")
 S FBARY($P(^FBAAI(J,0),"^"))=+$P(^FBAAI(J,0),"^",9),FBAAIN=J
 Q
 ;
INVCNT ;set invoice count for cnh batch
 S FZ("CNT")=FZ("CNT")+1
 Q
CHECK(FBINV) ; order thru array and save zero dollar invoices; report any zero dollar invoices
 ; FBINV = array of invoices
 N FBAAIN
 S FBAAIN=0 F  S FBAAIN=$O(FBINV(FBAAIN)) Q:'FBAAIN  D
 . I FBINV(FBAAIN)'>0 S @FBOUT@(FBAAIN)="-1^Invoice #: "_FBAAIN_" totals $0.00"
 . E  K FBINV(FBAAIN) ; remove array elements that represent non-zero dollar invoices
 Q
