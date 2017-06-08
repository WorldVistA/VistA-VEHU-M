DSIFRPT2 ;DSS/AMC - LIST PAYMENT HISTORY ;8/10/2003
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;  2056  $$GET1^DIQ
 ;  5081  FBCKO^FBAACCB2
 ;  5085  $$ADJLRA^FBAAFA
 ;  5086  $$RRL^FBAAFR
 ;  5090  $$DATX^FBAAUTL,$$SSN^FBAAUTL
 ;  5091  $$APS^FBAAUTL4,$$CPT^FBAAUTL4,$$MODL^FBAAUTL4
 ;
RD ;
LIST(AXY,DFN) ;RPC - DSIF PAYMENT HISTORY
 S AXY=$NA(^TMP("DSIFRPT2",$J)) K @AXY
 I '$G(DFN) S @AXY@(0)="-1^Invalid Input!" Q
 I '$D(^FBAAC(DFN,"AB")) S @AXY@(0)="-1^No payments for this patient!" Q
 N D,D2,J,K,L,M,DIC,T,Y,Q,I,A1,A2,A3,C,DAT,DIYS,F,FBAACPTC,FBAANQ,FBAAOUT,FBBN,FBCOUNTY,FBCP,FBOB,FBDOS,FBDX,FBIN,FBTA,FBTYPE,FBVID,FBNAME,PGM,PI,V,VAL,VAR,Z,ZZ,A,A1,A2,BE,CPTDESC,FBVP,PSA,FBPHOUT,FBAUT
 N YY,XX,B1AUT,B2,FBAADOD,PTYPE,FBI,FBRR,FBPROG,FBXX,FBSSN,X1,FBAACPT,FBAADT,FBAAPD,FBIN,I,K,L,Q,Y,Z,ZS,FB,FBTRX,FBMOD,FBMODLE,FBAPS
 S FBSSN=$$SSN^FBAAUTL(DFN),XX="",YY=0
 S:'$D(FBNAME) FBNAME=$P($G(^DPT(+DFN,0)),"^")
 S FBPHOUT=1
 D ^DSIFRPD ;I FBAAOUT'=1,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR G Q:$D(DIRUT)
 K Q S $P(Q,"=",80)="="
 S FBAAOUT=0 D HED S J=DFN
 F I=0:0 S I=$O(^FBAAC(J,"AB",I)) Q:I=""!(FBAAOUT)  F K=0:0 S K=$O(^FBAAC(J,"AB",I,K)) Q:K=""!(FBAAOUT)  F L=0:0 S L=$O(^FBAAC(J,"AB",I,K,L)) Q:L=""!(FBAAOUT)  D SETTR F M=0:0 S M=$O(^FBAAC(J,1,K,1,L,1,M)) Q:'M  D SET Q:FBAAOUT
 Q:FBAAOUT!('$D(FB))  S FBTRCK=1,D=0 F  S D=$O(FB(D)) Q:'D  S FBTRX=0 F  S FBTRX=$O(FB(D,FBTRX)) Q:'FBTRX  D WRTCK Q:FBAAOUT  S:$G(FBTRCK) $E(XX,5)="TRAVEL PAYMENTS: " D  K FBTRCK
 .S $E(XX,22)=$$DATX^FBAAUTL(D),$E(XX,35)=$P(FB(D,FBTRX),"^") S:$P(FB(D,FBTRX),"^",3)]"" $E(XX,44)="Check #: "_$P(FB(D,FBTRX),U,2),$E(XX,63)="Paid: "_$$DATX^FBAAUTL($P(FB(D,FBTRX),U,3)) D LN
 D:XX]"" LN
 Q
SET ;
 N FBAARCE,FBADJLA,FBADJLR,FBCSID,FBFPPSC,FBFPPSL,FBRRMKL,FBUNITS
 N FBX,FBY2,FBY3,TAMT
 S V=$P($G(^FBAAV(K,0)),"^"),FBVID=$S(V]"":$P(^(0),"^",2),1:"")
 S Y=^FBAAC(J,1,K,1,L,1,M,0),T=$P(Y,"^",5),D2=$P(Y,"^",6),FBDOS=D2,D2=$S(D2="":"",1:$E(D2,4,5)_"/"_$E(D2,6,7)_"/"_$E(D2,2,3)),FBCP=$P(Y,"^",18),FBCP=$S(FBCP=1:"(C&P)",1:"")
 S FBAACPTC=$$CPT^FBAAUTL4(+Y)
 S FBOB=$P(Y,"^",10)
 I T]"" S T=$P($G(^FBAA(161.27,+T,0)),"^")
 S A1=$P(Y,"^",2)+.0001,A2=$P(Y,"^",3)+.0001,A1=$P(A1,".",1)_"."_$E($P(A1,".",2),1,2),A2=$P(A2,".",1)_"."_$E($P(A2,".",2),1,2)
 S FBAPS=$$APS^FBAAUTL4(J,K,L,M)
 S FBTYPE=$P(Y,"^",20),FBVP=$P(Y,"^",21),FBIN=$P(Y,"^",16),FBBN=$P(Y,"^",8),FBBN=$S(FBBN']"":"",$D(^FBAA(161.7,FBBN,0)):$P(^(0),"^"),1:""),FBBN=$S(FBBN="":"",1:$E("00000",$L(FBBN)+1,5)_FBBN)
 S FBY3=$G(^FBAAC(J,1,K,1,L,1,M,3))
 S FBFPPSC=$P(FBY3,U)
 S FBFPPSL=$P(FBY3,U,2)
 S FBX=$$ADJLRA^FBAAFA(M_","_L_","_K_","_J_",")
 S FBADJLR=$P(FBX,U)
 S FBADJLA=$P(FBX,U,2)
 S TAMT=$FN($P(Y,"^",4),"",2)
 S FBAARCE=$$GET1^DIQ(162.03,M_","_L_","_K_","_J_",",48)
 S FBY2=$G(^FBAAC(J,1,K,1,L,1,M,2))
 S FBUNITS=$P(FBY2,U,14)
 S FBCSID=$P(FBY2,U,16)
 S FBRRMKL=$$RRL^FBAAFR(M_","_L_","_K_","_J_",")
 D FBCKO^FBAACCB2(J,K,L,M)
 S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_J_",1,"_K_",1,"_L_",1,"_M_",""M"")","E")
 D WRT
 Q
WRT ;
 S XX="" D LN S XX="Vendor: "_$E(V,1,33)_"     Vendor ID: "_FBVID,$E(XX,66)=" Obl.#: "_FBOB D LN
 S YY=YY+1,@AXY@(YY)="",YY=YY+1
 S XX=$S(FBTYPE="R":"*",1:" ")_$S(FBVP="VP":"#",1:"")_$S($G(FBCAN)]"":"+",1:""),$E(XX,2)=$$DATX^FBAAUTL(D)
 S $E(XX,12)=FBAACPTC_FBCP_$S($G(FBMODLE)]"":"-"_$P(FBMODLE,","),1:"")
 S $E(XX,22)=FBAARCE,$E(XX,31)=FBUNITS,$E(XX,38)=FBCSID,$E(XX,60)=$J(FBIN,7)
 S $E(XX,71)=FBBN
 S @AXY@(YY)=XX
 I $P($G(FBMODLE),",",2)]"" D  Q:FBAAOUT
 .N FBI
 .F FBI=2:1 S FBMOD=$P(FBMODLE,",",FBI) Q:FBMOD=""  D  Q:FBAAOUT
 ..S YY=YY+1,XX="",$E(XX,17)="-"_FBMOD,@AXY@(YY)=XX ;W !,?17,"-",FBMOD
 S YY=YY+1,XX="    "_$J(A1,6),$E(XX,18)=$J(A2,6)_FBAPS ;W !?5,$J(A1,6),?18,$J(A2,6),FBAPS
 ; write adjustment reasons, if null then write suspend code
 S $E(XX,32)=$S(FBADJLR]"":FBADJLR,1:T) ;W ?32,$S(FBADJLR]"":FBADJLR,1:T)
 ; write adjustment amounts, if null then write amount suspended
 S $E(XX,42)=$S(FBADJLA]"":FBADJLA,1:TAMT) ;W ?42,$S(FBADJLA]"":FBADJLA,1:TAMT)
 S $E(XX,58)=FBRRMKL,$E(XX,71)=D2 ;W ?58,FBRRMKL,?71,D2
 S @AXY@(YY)=XX,XX=""
 I FBFPPSC]"" S XX="    FPPS Claim ID: "_FBFPPSC,$E(XX,32)="FPPS Line Item: "_FBFPPSL,YY=YY+1,@AXY@(YY)=XX,XX=""
 D PMNT
 Q
WRTCK ;
 Q
HED ;
 S XX="Patient: "_FBNAME,$E(XX,40)="SSN: "_$$SSN^FBAAUTL(DFN),YY=YY+1,@AXY@(YY)=XX
 S XX="",$E(XX,10)="('*' Reimb. to Patient  '+' Cancel. Activity  '#' Voided Payment)",YY=YY+1,@AXY@(YY)=XX
 S YY=YY+1,@AXY@(YY)="   (paid symbol: 'R' RBRVS  'F' 75th percentile  'C' contract  'M' Mill Bill"
 S YY=YY+1,@AXY@(YY)="                 'U' U&C)"
 S XX=" Svc Date  CPT-MOD   Rev.Code Units  Patient Account No.   Invoice #  Batch #",YY=YY+1,@AXY@(YY)=XX
 S XX="    Amt Claimed  Amt Paid      Adj Code  Adj Amount      Remit Remark VoucherDt",YY=YY+1,@AXY@(YY)=XX
 S YY=YY+1,@AXY@(YY)=Q,YY=YY+1,@AXY@(YY)="" ;W !,Q,!
 Q
Q Q
SETTR ;
 S D=$S($D(^FBAAC(J,1,K,1,L,0)):$P(^(0),"^",1),1:""),A3=""
 I D]"",$D(^FBAAC(J,3,"AB",D)) S (FBTA,FBCTR)=0 F  S FBTA=$O(^FBAAC(J,3,"AB",D,FBTA)) Q:'FBTA  S B3=$G(^FBAAC(J,3,FBTA,0)),A3=$P(B3,"^",3) I A3>0 S FBCTR=FBCTR+1,FB(D,FBCTR)=$J(A3,6,2)_"^"_$P(B3,"^",7)_"^"_$P(B3,"^",6)
 K A3,B3,FBTA,FBCTR Q
PMNT ;displays check and cancellation information if any exist
 I $G(FBCK)]"" S XX="   >>>Check # "_FBCK D LN:'$G(FBCKDT) I $G(FBCKDT) S XX=XX_"  Date Paid:  "_$$DATX^FBAAUTL(FBCKDT)_$S(FBCKINT>0:"  Interest: "_$FN(FBCKINT,",",2),1:"")_"<<<" D LN D
 .I FBDIS-FBCKINT'=+A2 S XX="   >>>Amount paid altered to $ "_$FN((FBDIS-FBCKINT),",",2)_" on the Fee Payment Voucher document.<<<" D LN
 I $G(FBCANDT)>0 S XX="   >>>Check cancelled on: "_$$DATX^FBAAUTL(FBCANDT) D:'FBCANR LN I +FBCANR S XX=XX_"   Reason:  "_$P($G(^FB(162.95,+FBCANR,0)),"^")_"<<<" D LN D
 .S XX="      "_$S(FBCAN="R":"Check WILL be replaced.",FBCAN="C":"Check WILL be re-issued.",FBCAN="X":"Check WILL NOT be replaced.",1:"") D LN
PMTCLN ;
 K FBCAN,FBCK,FBCKDT,FBCANDT,FBCANR,FBCKINT,FBDIS,FBCKIN
 Q
LN ;
 S YY=YY+1,@AXY@(YY)=XX,XX=""
 Q
