OCXRU008 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*96) ;JAN 30,2001 at 11:16
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**96**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^OCXRULE
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 G ^OCXRU009
 ;
 Q
 ;
DATA ;
 ;
 ;;D^  ; .....S OCXA($P(OCXX,U,7))=OCXX
 ;;R^"860.8:",100,15
 ;;D^  ; ..I '$L($G(OCXSL)) S OCXX=$$LOCL^ORQQLR1(DFN,TEST,"")
 ;;R^"860.8:",100,16
 ;;D^  ; ..Q:'$L(OCXX)
 ;;R^"860.8:",100,17
 ;;D^  ; .I $D(OCXA) S OCXR="",OCXR=$O(OCXA(OCXR),-1),OCXX=OCXA(OCXR)
 ;;R^"860.8:",100,18
 ;;D^  ; .I $L(OCXX) D
 ;;R^"860.8:",100,19
 ;;D^  ; ..S OCXY=$P(OCXX,U,2)_": "_$P(OCXX,U,3)_" "_$P(OCXX,U,4)
 ;;R^"860.8:",100,20
 ;;D^  ; ..S OCXY=OCXY_" "_$S($L($P(OCXX,U,5)):"["_$P(OCXX,U,5)_"]",1:"")
 ;;R^"860.8:",100,21
 ;;D^  ; ..I $L($P(OCXX,U,7)) S OCXY=OCXY_" "_$$FMTE^XLFDT($P(OCXX,U,7),"2P")
 ;;R^"860.8:",100,22
 ;;D^  ; .S:$L(OCXOUT) OCXOUT=OCXOUT_"   " S OCXOUT=OCXOUT_$G(OCXY)
 ;;R^"860.8:",100,23
 ;;D^  ; Q:'$L(OCXOUT) "<Results Not Found>" Q OCXOUT
 ;;R^"860.8:",100,24
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^GENERATE STRING CHECKSUM
 ;;R^"860.8:",.01,"E"
 ;;D^GENERATE STRING CHECKSUM
 ;;R^"860.8:",.02,"E"
 ;;D^CKSUM
 ;;R^"860.8:",100,1
 ;;D^  ;CKSUM(STR) ;
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; N CKSUM,PTR,ASC S CKSUM=0
 ;;R^"860.8:",100,4
 ;;D^  ; S STR=$TR(STR,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;;R^"860.8:",100,5
 ;;D^  ; F PTR=$L(STR):-1:1 S ASC=$A(STR,PTR)-42 I (ASC>0),(ASC<51) S CKSUM=CKSUM*2+ASC
 ;;R^"860.8:",100,6
 ;;D^  ; Q +CKSUM
 ;;R^"860.8:",100,7
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^GET DATA FROM THE ACTIVE DATA FILE
 ;;R^"860.8:",.01,"E"
 ;;D^GET DATA FROM THE ACTIVE DATA FILE
 ;;R^"860.8:",.02,"E"
 ;;D^GETDATA
 ;;R^"860.8:",100,1
 ;;D^  ;GETDATA(DFN,OCXL,OCXDFI) ;     This Local Extrinsic Function returns runtime data
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; N OCXE,VAL,PC S VAL=""
 ;;R^"860.8:",100,4
 ;;D^  ; F PC=1:1:$L(OCXL,U) S OCXE=$P(OCXL,U,PC) I OCXE S VAL=$G(^TMP("OCXCHK",$J,DFN,OCXE,OCXDFI)) Q:$L(VAL)
 ;;R^"860.8:",100,5
 ;;D^  ; Q VAL
 ;;R^"860.8:",100,6
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^IN LIST OPERATOR
 ;;R^"860.8:",.01,"E"
 ;;D^IN LIST OPERATOR
 ;;R^"860.8:",.02,"E"
 ;;D^LIST
 ;;R^"860.8:",100,1
 ;;D^  ;LIST(DATA,LIST) ;   IS THE DATA FIELD IN THE LIST
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^T+; W:$G(OCXTRACE) !,"%%%%",?20,"     $$LIST(""",DATA,""",""",LIST,""")"
 ;;R^"860.8:",100,4
 ;;D^  ; S:'($E(LIST,1)=",") LIST=","_LIST S:'($E(LIST,$L(LIST))=",") LIST=LIST_"," S DATA=","_DATA_","
 ;;R^"860.8:",100,5
 ;;D^  ; Q (LIST[DATA)
 ;;R^"860.8:",100,6
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^LOCAL TERM LOOKUP
 ;;R^"860.8:",.01,"E"
 ;;D^LOCAL TERM LOOKUP
 ;;R^"860.8:",.02,"E"
 ;;D^TERMLKUP
 ;;R^"860.8:",1,1
 ;;D^ 
 ;;R^"860.8:",1,2
 ;;D^  This function allows a local site to define to Order Checking
 ;;R^"860.8:",1,3
 ;;D^ a term specific to that site. (ie. Lab Test Name, Radiology
 ;;R^"860.8:",1,4
 ;;D^ procedure name, etc.)
 ;;R^"860.8:",1,5
 ;;D^ 
 ;;R^"860.8:",100,1
 ;;D^  ;TERMLKUP(OCXTERM,OCXFILE) ;
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; Q
 ;;R^"860.8:",100,4
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^NEW RULE MESSAGE
 ;;R^"860.8:",.01,"E"
 ;;D^NEW RULE MESSAGE
 ;;R^"860.8:",.02,"E"
 ;;D^NEWRULE
 ;;R^"860.8:",100,1
 ;;D^  ;NEWRULE(OCXDFN,OCXORD,OCXRUL,OCXREL,OCXNOTF,OCXMESS) ; Has this rule already been triggered for this order number
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^L+; S OCXERR=$$TIMELOG("M","NEWRULE("_(+$G(OCXDFN))_","_(+$G(OCXORD))_","_(+$G(OCXRUL))_","_(+$G(OCXREL))_","_(+$G(OCXNOTF))_","_$G(OCXMESS)_")")
 ;;R^"860.8:",100,4
 ;;D^  ; ;
 ;;R^"860.8:",100,5
 ;;D^  ; Q:'$G(OCXDFN) 0 Q:'$G(OCXRUL) 0
 ;;R^"860.8:",100,6
 ;;D^  ; Q:'$G(OCXREL) 0  Q:'$G(OCXNOTF) 0  Q:'$L($G(OCXMESS)) 0
 ;;R^"860.8:",100,7
 ;;D^  ; S OCXORD=+$G(OCXORD),OCXDFN=+OCXDFN
 ;;R^"860.8:",100,8
 ;;D^  ; ;
 ;;R^"860.8:",100,9
 ;;D^  ; N OCXNDX,OCXDATA,OCXDFI,OCXELE,OCXGR,OCXTIME,OCXCKSUM
 ;;R^"860.8:",100,10
 ;;D^  ; ;
 ;;R^"860.8:",100,11
 ;;D^  ; S OCXTIME=(+$H)
 ;;R^"860.8:",100,12
 ;;D^  ; S OCXCKSUM=$$CKSUM(OCXMESS)
 ;;R^"860.8:",100,13
 ;;D^  ; ;
 ;;R^"860.8:",100,14
 ;;D^  ; Q:$D(^OCXD(860.7,"AT",OCXTIME,OCXDFN,OCXRUL,+OCXORD,OCXCKSUM)) 0
 ;;R^"860.8:",100,15
 ;;D^  ; ;
 ;;R^"860.8:",100,16
 ;;D^  ; K OCXDATA
 ;;R^"860.8:",100,17
 ;;D^  ; S OCXDATA(OCXDFN,0)=OCXDFN
 ;;R^"860.8:",100,18
 ;;D^  ; S OCXDATA("B",OCXDFN,OCXDFN)=""
 ;;R^"860.8:",100,19
 ;;D^  ; S OCXDATA("AT",OCXTIME,OCXDFN,OCXRUL,+OCXORD,OCXCKSUM)=""
 ;;R^"860.8:",100,20
 ;;D^  ; ;
 ;;R^"860.8:",100,21
 ;;D^  ; S OCXGR="^OCXD(860.7"
 ;;R^"860.8:",100,22
 ;;D^T+; D SETAP(OCXGR_")",0,"Patient",$P($G(^DPT(OCXDFN,0)),U,1),.OCXDATA,OCXDFN)
 ;;R^"860.8:",100,23
 ;;D^T-; D SETAP(OCXGR_")",0,.OCXDATA,OCXDFN)
 ;;R^"860.8:",100,24
 ;;D^  ; ;
 ;;R^"860.8:",100,25
 ;;D^  ; K OCXDATA
 ;;R^"860.8:",100,26
 ;;D^  ; S OCXDATA(OCXRUL,0)=OCXRUL_U_(OCXTIME)_U_(+OCXORD)
 ;;R^"860.8:",100,27
 ;;D^  ; S OCXDATA(OCXRUL,"M")=OCXMESS
 ;;R^"860.8:",100,28
 ;;D^  ; S OCXDATA("B",OCXRUL,OCXRUL)=""
 ;;R^"860.8:",100,29
 ;;D^  ; S OCXGR=OCXGR_","_OCXDFN_",1"
 ;;R^"860.8:",100,30
 ;;D^T+; D SETAP(OCXGR_")","860.71P","Rule",$P($G(^OCXS(860.2,OCXRUL,0)),U,1),.OCXDATA,OCXRUL)
 ;;R^"860.8:",100,31
 ;;D^T-; D SETAP(OCXGR_")","860.71P",.OCXDATA,OCXRUL)
 ;;R^"860.8:",100,32
 ;;D^  ; ;
 ;;R^"860.8:",100,33
 ;;D^  ; K OCXDATA
 ;;R^"860.8:",100,34
 ;;D^  ; S OCXDATA(OCXREL,0)=OCXREL
 ;;R^"860.8:",100,35
 ;;D^  ; S OCXDATA("B",OCXREL,OCXREL)=""
 ;;R^"860.8:",100,36
 ;;D^  ; S OCXGR=OCXGR_","_OCXRUL_",1"
 ;;R^"860.8:",100,37
 ;;D^T+; D SETAP(OCXGR_")","860.712","Relation",OCXREL,.OCXDATA,OCXREL)
 ;;R^"860.8:",100,38
 ;;D^T-; D SETAP(OCXGR_")","860.712",.OCXDATA,OCXREL)
 ;;R^"860.8:",100,39
 ;;D^  ; ;
 ;;R^"860.8:",100,40
 ;;D^  ; S OCXELE=0 F  S OCXELE=$O(^OCXS(860.2,OCXRUL,"C","C",OCXELE)) Q:'OCXELE  D
 ;;R^"860.8:",100,41
 ;;D^  ; .;
 ;;R^"860.8:",100,42
 ;;D^  ; .N OCXGR1
 ;;R^"860.8:",100,43
 ;;D^  ; .S OCXGR1=OCXGR_","_OCXREL_",1"
 ;;R^"860.8:",100,44
 ;;D^  ; .K OCXDATA
 ;;R^"860.8:",100,45
 ;;D^  ; .S OCXDATA(OCXELE,0)=OCXELE
 ;;R^"860.8:",100,46
 ;;D^  ; .S OCXDATA(OCXELE,"TIME")=OCXTIME
 ;;R^"860.8:",100,47
 ;;D^  ; .S OCXDATA(OCXELE,"LOG")=$G(OCXOLOG)
 ;;R^"860.8:",100,48
 ;;D^  ; .S OCXDATA("B",OCXELE,OCXELE)=""
 ;;R^"860.8:",100,49
 ;;D^  ; .K ^OCXD(860.7,OCXDFN,1,OCXRUL,1,OCXREL,1,OCXELE)
 ;;R^"860.8:",100,50
 ;;D^T+; .D SETAP(OCXGR1_")","860.7122P","Element",$P($G(^OCXS(860.3,OCXELE,0)),U,1),.OCXDATA,OCXELE)
 ;;R^"860.8:",100,51
 ;;D^T-; .D SETAP(OCXGR1_")","860.7122P",.OCXDATA,OCXELE)
 ;;R^"860.8:",100,52
 ;;D^  ; .;
 ;;R^"860.8:",100,53
 ;;D^  ; .S OCXDFI=0 F  S OCXDFI=$O(^TMP("OCXCHK",$J,OCXDFN,OCXELE,OCXDFI)) Q:'OCXDFI  D
 ;;R^"860.8:",100,54
 ;;D^  ; ..N OCXGR2
 ;;R^"860.8:",100,55
 ;;D^  ; ..S OCXGR2=OCXGR1_","_OCXELE_",1"
 ;;R^"860.8:",100,56
 ;;D^  ; ..K OCXDATA
 ;;R^"860.8:",100,57
 ;;D^  ; ..S OCXDATA(OCXDFI,0)=OCXDFI
 ;;R^"860.8:",100,58
 ;;D^  ; ..S OCXDATA(OCXDFI,"VAL")=^TMP("OCXCHK",$J,OCXDFN,OCXELE,OCXDFI)
 ;;R^"860.8:",100,59
 ;;D^  ; ..S OCXDATA("B",OCXDFI,OCXDFI)=""
 ;;R^"860.8:",100,60
 ;;D^T+; ..D SETAP(OCXGR2_")","860.71223P","Data Field",$P($G(^OCXS(860.4,OCXDFI,0)),U,1),.OCXDATA,OCXDFI)
 ;1;
 ;
