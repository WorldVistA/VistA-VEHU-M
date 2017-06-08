DSIFPAY5 ;DSS/RED,DLF - RPC FOR FEE BASIS PAYMENTS ;2/1/2007 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,4,10,8,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ; 10005  DT^DICRW
 ; 10018  ^DIE
 ;  5085  LOADADJ^FBAAFA
 ;  5106  PAT^FBAAUTL2,POV^FBAAUTL2
 ;   287  $$HDR^FBAAUTL3
 ;  5091  $$CPT^FBAAUTL4,$$MODL^FBAAUTL4,MODDATA^FBAAUTL4
 ;  5092  $$SUB^FBAAUTL5
 ;  5093  NEWMSG^FBAAV01,STORE^FBAAV01,STRING^FBAAV01,XMIT^FBAAV01
 ;  5108  ^FBAAV1,KILL^FBAAV1
 ;  5217  DETP^FBAAV2,$$HL7NAME^FBAAV2
 ;  5109  $$AUSAMT^FBAAV3,$$AUSDT^FBAAV3,DETT^FBAAV3
 ;  5110  ^FBAAV4,$$HL7NAME^FBAAV4
 ;  5111  ^FBAAV5,$$PSA^FBAAV5
 ;  5098  $$ICD9^FBCSV1
 ;  5120  $$ADJL^FBUTL2
 ; 10061  ADD^VADPT
 ; 10104  $$LJ^XLFSTR,$$RJ^XLFSTR
 ;  5273  ^FBAA(161.7
 ;  5398  ^FBAA(161.25
 ;  5399  ^FBAA(161.26 
 ;  5394  ^FBAA(161.82
 ;  5443  $$EN^FBNPILK
 ;  2056  $$GET1^DIQ
 ;
 Q  ;No direct access  
TRANSMIT(DSIFOUT) ;  RPC: DSIF TRANSMIT TO AUSTIN
 ; compute total amount suspended and determine most significant reason
 ; loop thru reasons  (FBAAV0)
 N DA,DIC,DR,FB,FBAAAP,FBAABN,FBAABT,FBAACP,FBAAON,FBAASN,FBAP,FBATCH,FBCHB,FBCPT,FBCTY,FBDIN,FBDOB,FBEXPMT,DIE,FBEXMPT
 N HBHCFA,FBHD,FBINVN,FBPATT,FBPAYT,FBPD,FBPOS,FBPSA,FBST,FBSTAT,FBSTR,FBTD,FBTT,FBVID,FBTXT,FBVID,FBVTOS,FBZIP,FBAACD
 N J,K,L,M,N,PAD,POV,TOTSTR,VAPA,VATERR,X,FBHCFA,FBPOV,FBSUSP,VATERR,DSIFBN,FBSITE,FBCHB,FBCNTRN,FBCSID,FBEDIF,FBERR
 K ^TMP($J,"FBVADAT") S DSIFOUT=$NA(^TMP("DSIFPAY5",$J)),FBERR=0 K @DSIFOUT
 D DT^DICRW
 I '$D(^FBAA(161.7,"AC","S")),'$D(^FBAA(161.7,"AC","R")),'$D(^FBAA(161.25,"AE")),$S('$D(^FBAA(161.26,"AC","P")):1,$O(^FBAA(161.26,"AC","P",0))'>0:1,1:0) S @DSIFOUT@(0)="-1^There are no transactions requiring transmission" Q
 ; added Global lock correction, lock was not compliant with SAC standards - DSIF*3.2*8
 L +^FBAA(161.7,"AC"):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S @DSIFOUT@(0)="-1^Queueing has been initiated by another user and is now in progress!" Q
 F FBSTAT="S","R" F J=0:0 S J=$O(^FBAA(161.7,"AC",FBSTAT,J)) Q:J'>0  S FBATCH=$G(^FBAA(161.7,J,0)) D
 .Q:'+FBATCH
 .I (FBSTAT="S"&($P(FBATCH,U,15)="Y"))!(+$P(FBATCH,U,9)) S @DSIFOUT@(J)="1^"_J_";"_+FBATCH_U
 I $D(^TMP("DSIFPAY5",$J)) S @DSIFOUT@(0)="1^Batches queued to be transmitted "
 I '$D(^TMP("DSIFPAY5",$J)) S @DSIFOUT@(0)="-1^No batches ready to be transmitted" L -^FBAA(161.7,"AC") Q
 ;
RTRAN ;
 ;Split the follwoing lines and add error checking DSIF*3.2*8 (duplicate/bad header issue)
 F J=0:0 S J=$O(@DSIFOUT@(J)) Q:J'>0  I $D(^FBAA(161.7,J,0)),$P(@DSIFOUT@(J),U)=1 D
 . S Y(0)=^FBAA(161.7,J,0),FBCHB=$P($G(Y(0)),"^",15),DSIFBN=$P(@DSIFOUT@(J),U,2)
 . I Y(0)="" S @FBOUT@(J)="-1^Batch number: "_+$G(^FBAA(161.7,J,0))_" cannot be processed at this time, please check the batch." Q
 . D CKB3V^DSIFPAY7
 D ADDRESS^DSIFPAY7 G END:VATERR K VAT
 D STATION^DSIFPAY7,HD ;I $D(FB("ERROR")) G END   ;Remove FBERR DSIF*3.2*10
 S TOTSTR=0,$P(PAD," ",200)=" "
 D ^FBAAV1:$D(^FBAA(161.25,"AE"))
 D ^FBAAV4:$D(^FBAA(161.26,"AC","P"))
 F J=0:0 S J=$O(@DSIFOUT@(J)) Q:J'>0  I $D(^FBAA(161.7,J,0)),+@DSIFOUT@(J)>0 S Y(0)=^FBAA(161.7,J,0),DSIFBN=$P(@DSIFOUT@(J),U,2) D SET1,DET:$G(FBAABT)="B3",DETP^FBAAV2:$G(FBAABT)="B5",DETT^FBAAV3:$G(FBAABT)="B2",CKB9V^DSIFPAY7:$G(FBAABT)="B9"
END L -^FBAA(161.7,"AC") D KILL^FBAAV1 Q
 ;
SET1 ; build the payment batch header string (used by all four formats)
 Q:+@DSIFOUT@(J)<0
 S FBAABN=$P(Y(0),"^",1),FBAABN=$E("00000",$L(FBAABN)+1,5)_FBAABN
 S FBAAON=$E($P(Y(0),"^",2),3,6),FBAACD=$$AUSDT^FBAAV3(DT),FBAACP=$E($P(Y(0),"^",2),1,2)
 S FBAABT=$P(Y(0),"^",3),FBAAAP=$$AUSAMT^FBAAV3($P(Y(0),"^",9),11) ;changed from ,10 to ,11 to match FBAAV0 DSIF*3.2*2
 S FBSTAT=$P(^FBAA(161.7,J,"ST"),"^")
 S FBCHB=$P(Y(0),"^",15),FBEXMPT=$P(Y(0),"^",18),X=$$SUB^FBAAUTL5(+$P(Y(0),U,8)_"-"_$P(Y(0),U,2))
 S FBAASN=$$LJ^XLFSTR($S(X]"":X,1:FBAASN),6," ")
 I FBSTAT="R"!(FBSTAT="S"&(FBCHB'["Y"))!(FBSTAT="S"&($G(FBEXMPT)="Y")) S FBSTR=FBHD_$S(FBAABT="B2":"BT",1:FBAABT)_FBAACD_FBAASN_FBAABN_" "_FBAAAP_FBAACP_" $"
 Q
DET ;entry point to process B3 (outpatient/ancillary) batch
 ; input (partial list)
 ;   J      - Batch IEN in file 161.7
 ;   FBAAON - last 4 of obligation number
 ;   FBAASN - station number (formatted)
 Q:+@DSIFOUT@(J)<0   ;DSIF*3.2*8
 S FBTXT=0
 D CKB3V^FBAAV01 I $G(FBERR) K FBERR Q           ;Added to match FBAAV0 DSIF*3.2*2
 ;  DSIF*3.2*10 - HIPAA 5010 - line items that have 0.00 amount paid are now required to go to Central Fee
 F K=0:0 S K=$O(^FBAAC("AC",J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AC",J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AC",J,K,L,M)) Q:M'>0  F N=0:0 S N=$O(^FBAAC("AC",J,K,L,M,N)) Q:N'>0  S Y(0)=$G(^FBAAC(K,1,L,1,M,1,N,0)) I Y(0)]"" D
 .N FBDTSR1,FBPICN
 . ; Line below added to DSIF*3.2*1
 .S FBCSID=$P($G(^FBAAC(K,1,L,1,M,1,N,2)),U,16),FBCNTRN=$P($G(^FBAAC(K,1,L,1,M,1,N,2)),U,17),FBEDIF=$S($P($G(^FBAAC(K,1,L,1,M,1,N,3)),"^")]"":"Y",1:" ")
 .S FBDTSR1=+$G(^FBAAC(K,1,L,1,M,0)),FBPICN=K_U_L_U_M_U_N,FBY=$G(^FBAAC(K,1,L,1,M,1,N,2))
 .I 'FBTXT S FBTXT=1 D NEWMSG^FBAAV01,STORE^FBAAV01,UPD
 .D GOT
 D:FBTXT XMIT^FBAAV01
 Q
 ;
GOT ; process a B3 line item
 N DFN,FBADJ,FBADJA1,FBADJA2,FBADJR1,FBADJR2,FBADMIT,FBAUTHF,FBIENS
 N FBMOD1,FBMOD2,FBMOD3,FBMOD4,FBPNAMX,FBUNITS,FBX,PAD,FBNPI
 N FBCSID,FBEDIF,FBCNTRN  ;DSIF*3.2*2 
 S FBIENS=N_","_M_","_L_","_K_","
 ;
 S FBEDIF=$S($P($G(^FBAAC(K,1,L,1,M,1,N,3)),"^")]"":"Y",1:" ") ;EDI flag DSIF*3.2*2
 ;
 ; get CPT modifiers
 S:$G(PAD)="" $P(PAD," ",200)=" "
 D
 . N FBMODA,FBMODL
 . D MODDATA^FBAAUTL4(K,L,M,N)
 . S FBMODL=$$MODL^FBAAUTL4("FBMODA","E")
 . S FBMOD1=$$RJ^XLFSTR($P(FBMODL,",",1),5," ")
 . S FBMOD2=$$RJ^XLFSTR($P(FBMODL,",",2),5," ")
 . S FBMOD3=$$RJ^XLFSTR($P(FBMODL,",",3),5," ")
 . S FBMOD4=$$RJ^XLFSTR($P(FBMODL,",",4),5," ")
 S FBPAYT=$P(Y(0),"^",20),FBPAYT=$S(FBPAYT]"":FBPAYT,1:"V")
 S FBVID=$P($G(^FBAAV(L,0)),U,2),FBVID=FBVID_$E(PAD,$L(FBVID)+1,11)
 S:FBPAYT="R" FBVID=$E(PAD,1,11)
 ; Changed as per patch FB*5.3*98
 S FBNPI=$$EN^FBNPILK(L)
 D POV^FBAAUTL2
 S POV=$S(POV']"":"",POV="A":6,POV="B":7,POV="C":8,POV="D":9,POV="E":10,1:POV)
 S POV=$S(POV']"":99,$D(^FBAA(161.82,POV,0)):$P(^(0),"^",3),1:99)
 S FBPOV=POV,FBTT=$S(FBTT]"":FBTT,1:1),FBCPT=$$CPT^FBAAUTL4($P(Y(0),"^")),FBCPT=$S($L(FBCPT)=5:FBCPT,1:"     ")
 S FBPSA=$$PSA^FBAAV5(+$P(Y(0),U,12),+FBAASN) I $L(+FBPSA)'=3 S FBPSA=999
 S FBPATT=$P(Y(0),"^",17),FBPATT=$S(FBPATT]"":FBPATT,1:10)
 S FBTD=$$AUSDT^FBAAV3(FBDTSR1) ; formatted treatment date
 S FBSUSP=$P(Y(0),"^",5),FBSUSP=$S(FBSUSP]"":FBSUSP,1:" "),FBSUSP=$S(FBSUSP=" ":" ",$D(^FBAA(161.27,+FBSUSP,0)):$P(^(0),"^"),1:" ")
 S FBAP=$$AUSAMT^FBAAV3($P(Y(0),"^",3),8) ; amount paid
 S FBPOS=+$P(Y(0),"^",25),FBPOS=$S(FBPOS:$P(^IBE(353.1,FBPOS,0),"^"),1:"  "),FBHCFA=+$P(Y(0),"^",26),FBHCFA=$S(FBHCFA:$P(^IBE(353.2,FBHCFA,0),"^"),1:"")
 S FBHCFA=$E(PAD,$L(FBHCFA)+1,2)_FBHCFA,FBVTOS=+$P(Y(0),"^",24),FBVTOS=$S(FBVTOS:$P(^FBAA(163.85,FBVTOS,0),"^",2),1:"  ")
 S FBPD=+$P(Y(0),"^",23),FBPD=$S(FBPD:$$ICD9^FBCSV1(FBPD,$G(FBDTSR1)),1:""),FBPD=$E(PAD,$L(FBPD)+1,7)_FBPD
 S FBINVN=$P(Y(0),"^",16),FBINVN=$E("000000000",$L(FBINVN)+1,9)_FBINVN
 S FBAUTHF=$S($P(Y(0),U,13)["FB583":"U",1:"A") ; auth/unauth flag
 S FBDIN=$$AUSDT^FBAAV3($P(Y(0),"^",15)) ; invoice date rec'd
 S FBADMIT=$$AUSDT^FBAAV3($$B3ADMIT(FBIENS)) ; formatted admission date
 S VAPA("P")="",DFN=K
 ; Note - before this point Y(0) was the 0 node of subfile #162.03
 ;      - after this point Y(0) will be the 0 node of file #2
 S Y(0)=$G(^DPT(+K,0)) Q:Y(0)']""
 D PAT^FBAAUTL2
 ; obtain date of birth, must follow call to PAT^FBAAUTL2 to overwrite
 ; the value returned from it
 S FBDOB=$$AUSDT^FBAAV3($P(Y(0),"^",3)) ; date of birth
 D ADD^VADPT
 S FBPNAMX=$$HL7NAME^FBAAV2(DFN) ; patient name
 S FBUNITS=$P(FBY,U,14) S:FBUNITS<1 FBUNITS=1
 S FBUNITS=$$RJ^XLFSTR(FBUNITS,5,0) ; volume indicator (units paid)
 S FBCSID=$$LJ^XLFSTR($P(FBY,"^",16),20," ") ; patient acct # - added line with DSIF*3.2*10
 D          ;contract logic added for DSIF*3.2*2
 . N FBCNTRP
 . S FBCNTRP=$P(FBY,"^",17)
 . S FBCNTRN=$S(FBCNTRP:$P($G(^FBAA(161.43,FBCNTRP,0)),"^"),1:"")
 . S FBCNTRN=$$LJ^XLFSTR(FBCNTRN,20," ") ; contract number
 ;
 ; get and format adjustment reason codes and amounts (if any)
 D LOADADJ^FBAAFA(FBIENS,.FBADJ)
 S FBX=$$ADJL^FBUTL2(.FBADJ),FBADJR1=$$RJ^XLFSTR($P(FBX,U,1),5," ")
 S FBADJA1=$$AUSAMT^FBAAV3($P(FBX,U,3),9,1)
 S FBADJR2=$$RJ^XLFSTR($P(FBX,U,4),5," ")
 S FBADJA2=$$AUSAMT^FBAAV3($P(FBX,U,6),9,1)
 K FBADJ,FBX
 S FBST=$S($P(VAPA(5),"^")="":"  ",$D(^DIC(5,$P(VAPA(5),"^"),0)):$P(^(0),"^",2),1:"  ")
 S:$L(FBST)'=2 FBST=$E(PAD,$L(FBST)+1,2)_FBST
 S FBCTY=$S($P(VAPA(7),"^",1)="":"   ",FBST="  ":"   ",$D(^DIC(5,$P(VAPA(5),"^"),1,$P(VAPA(7),"^"),0)):$P(^(0),"^",3),1:"   ")
 I $L(FBCTY)'=3 S FBCTY=$E("000",$L(FBCTY)+1,3)_FBCTY
 S FBZIP=$S('+$G(VAPA(11)):VAPA(6),+VAPA(11):$P(VAPA(11),U),1:VAPA(6)),FBZIP=$TR(FBZIP,"-","")_$E("000000000",$L(FBZIP)+1,9)
 S $P(PAD," ",200)=" " D STRING^FBAAV01
 Q
 ;
UPD ; update the batch file
 N Y
 S DA=J,(DIC,DIE)="^FBAA(161.7,",DR="11///^S X=""T"";12///^S X=DT"
 D ^DIE
 Q
 ;
STORE D STORE^FBAAV01 Q
 ;
B3ADMIT(FBIENS) ; Determine Admission Date for a B3 payment line item
 ; input
 ;   FBIENS - IENS (FileMan format) for subfile 162.03 entry
 ; returns admission date in internal FileMan format or null value
 N FB7078,FBRET
 S FBRET="",FB7078=$$GET1^DIQ(162.03,FBIENS,27,"I") ; associated 7078/583
 ; (the unauthorized ancillary claims will have the treatment date
 ;  instead of the inpatient admission date so nothing is sent to
 ;  Austin for them)
 ; if line items points to a 7078 authorization then return a date
 I $P(FB7078,";",2)="FB7078(" D
 . N FBY
 . S FBY=$G(^FB7078(+FB7078,0))
 . ; if fee program is civil hospital then return 7078 date of admission
 . I $P(FBY,U,11)=6 S FBRET=$P(FBY,U,15)
 . ; if fee program is CNH then return 7078 authorized from date
 . I $P(FBY,U,11)=7 S FBRET=$P(FBY,U,4)
 Q FBRET
 ; 
RETRMRA(FBOUT,FBAATD) ;  RPC:  DSIF RETRANSMIT MRA
 ;Input:  FBAATD=Date to retransmit (FM format)
 ;Output: Message of success or failure
 I $L(FBAATD)'=7 S FBOUT="-1^Invalid date format" Q
 I '$D(^FBAA(161.25,"AD",FBAATD)),'$D(^FBAA(161.26,"AD",FBAATD)) S FBOUT="-1^No MRA's were transmitted on that date!" Q
 D VEND:$D(^FBAA(161.25,"AD",FBAATD)),VET:$D(^FBAA(161.26,"AD",FBAATD))
 D RTRAN
 K D0,FBAATD,OCTD,J,K,XCNP,VAT Q
VEND F J="O","P" F K=0:0 S K=$O(^FBAA(161.25,"AD",FBAATD,J,K)) Q:K'>0  I $D(^FBAA(161.25,K)) S $P(^(K,0),"^",5)="",^FBAA(161.25,"AE",J,K)="" K ^FBAA(161.25,"AD",FBAATD,J,K)
 Q
VET S FBOUT="1^Re-Transmitting" F K=0:0 S K=$O(^FBAA(161.26,"AD",FBAATD,K)) Q:K'>0  I $D(^FBAA(161.26,K)) S $P(^(K,0),"^",5)="",$P(^(0),"^",2)="P",^FBAA(161.26,"AC","P",K)="" K ^FBAA(161.26,"AD",FBAATD,K),^FBAA(161.26,"AC","T",K)
 Q
HD ;set transmission header
 I '$D(FBSITE(1)) S FBSITE(1)=$G(^FBAA(161.4,1,1))
 S FBHD=$$HDR^FBAAUTL3() I FBHD']"" S FB("ERROR")=1 S @DSIFOUT@(0)="-1^Transmission header must exist in FEE BASIS SITE PARAMETER file before you can proceed."
 Q
