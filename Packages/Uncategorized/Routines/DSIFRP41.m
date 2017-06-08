DSIFRP41 ;DSS/AMC - OUTPATIENT PAYMENT HISTORY SORT/PRINT ;7/11/2001
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;  5090  $$DATX^FBAAUTL,$$SSN^FBAAUTL
 ;  5114  $$EXTRL^FBMRASVR
 ;
PRINT ;write output
 S FBOUT=0 D:FBCRT&(FBPG) CR Q:FBOUT
 D HDR I FBSORT S FBPAT=FBPNAME I $D(^TMP($J,"FBTR")) S FBTRCK=1 D TRAV^DSIFRP67
 S FBVI="" F  S FBVI=$O(^TMP($J,"FB",FBPI,FBVI)) Q:FBVI']""!(FBOUT)  D:FBSORT SH Q:FBOUT  S FBPT="" D  Q:FBOUT
 .F  S FBPT=$O(^TMP($J,"FB",FBPI,FBVI,FBPT)) Q:FBPT']""!(FBOUT)  D:'FBSORT SH,SH1 Q:FBOUT  S FBDT=0 F  S FBDT=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT)) Q:'FBDT!(FBOUT)  D
 ..S L=0 F  S L=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,L)) Q:'L!(FBOUT)  S M=0 F  S M=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,L,M)) Q:'M!(FBOUT)  D
 ...;I ($Y+6)>IOSL D PAGE Q:FBOUT
 ...S FBDATA=^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,L,M)
 ...S FBCKIN=$G(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,L,M,"FBCK")) D EFBCK(FBCKIN)
 ...S FBADJ=$G(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,L,M,"FBADJ"))
 ...S XX=$S($G(FBCAN)]"":"+",1:" ")
 ...;W !,$S($G(FBCAN)]"":"+",1:"")
 ...S XX=XX_$P(FBDATA,U,1)
 ...;W ?1,$P(FBDATA,U,1)
 ...S $E(XX,11)=$P($P(FBDATA,U,2),",")
 ...;W ?11,$P($P(FBDATA,U,2),",")
 ...S $E(XX,22)=$P(FBADJ,U,9)
 ...;W ?22,$P(FBADJ,U,9)
 ...S $E(XX,31)=$J($P(FBADJ,U,2),10)
 ...;W ?31,$J($P(FBADJ,U,2),10)
 ...S $E(XX,43)=$P(FBDATA,U,6)
 ...;W ?43,$P(FBDATA,U,6)
 ...S $E(XX,54)=$P(FBDATA,U,7)
 ...;W ?54,$P(FBDATA,U,7)
 ...S $E(XX,64)=$P(FBDATA,U,8)
 ...;W ?64,$P(FBDATA,U,8)
 ...D LN
 ...I $P($P(FBDATA,U,2),",",2)]"" D  Q:FBOUT
 ....N FBI,FBMOD
 ....F FBI=2:1 S FBMOD=$P($P(FBDATA,U,2),",",FBI) Q:FBMOD=""  D  Q:FBOUT
 .....;I $Y+7>IOSL D PAGE Q:FBOUT  W !,"  (continued)"
 .....S $E(XX,16)="-"_FBMOD D LN
 ...S XX=$P(FBDATA,U,3)
 ...;W !,$P(FBDATA,U,3)
 ...S $E(XX,13)=$P(FBDATA,U,4)
 ...;W ?13,$P(FBDATA,U,4)
 ...S $E(XX,23)=$S($P(FBADJ,U,3)]"":$P(FBADJ,U,3),1:$P(FBDATA,U,5))
 ...;W ?23,$S($P(FBADJ,U,3)]"":$P(FBADJ,U,3),1:$P(FBDATA,U,5))
 ...S $E(XX,33)=$J($S($P(FBADJ,U,4)]"":$J($P(FBADJ,U,4),14),1:$P(FBADJ,U,1)),14)
 ...;W ?33,$J($S($P(FBADJ,U,4)]"":$J($P(FBADJ,U,4),14),1:$P(FBADJ,U,1)),14)
 ...S $E(XX,48)=$P(FBADJ,U,5)
 ...;W ?48,$P(FBADJ,U,5)
 ...S $E(XX,60)=$P(FBADJ,U,6)
 ...;W ?60,$P(FBADJ,U,6)
 ...D LN
 ...I $P(FBADJ,U,7)]"" S $E(XX,5)="FPPS Claim ID: "_$P(FBADJ,U,7)_"     FPPS Line Item: "_$P(FBADJ,U,8) D LN
 ...;I $P(FBADJ,U,7)]"" W !?5,"FPPS Claim ID: ",$P(FBADJ,U,7),"     FPPS Line Item: ",$P(FBADJ,U,8)
 ...S A2=$$EXTRL^FBMRASVR($P(FBDATA,U,4))
 ...S $E(XX,4)="Primary Dx: "_$P(FBDATA,U,10),$E(XX,40)="S/C Condition? "_$P(FBDATA,U,9),$E(XX,63)="Obl.#: "_$P(FBDATA,U,11) D LN
 ...;W !?4,"Primary Dx: ",$P(FBDATA,U,10),?40,"S/C Condition? ",$P(FBDATA,U,9) W ?63,"Obl.#: ",$P(FBDATA,U,11)
 ...D PMNT K A2
 Q
HDR ;main header
 ;I FBPG>0!FBCRT W @IOF
 S FBPG=FBPG+1
 S $E(XX,25)=$S($G(FBSORT):"VETERAN",1:"VENDOR")_" PAYMENT HISTORY"
 ;W !?25,$S($G(FBSORT):"VETERAN",1:"VENDOR")," PAYMENT HISTORY"
 I $G(FB1725R)]"",FB1725R'="A" S XX=XX_" "_$S(FB1725R="M":"for 38 U.S.C. 1725 Claims",1:"excluding 38 U.S.C. 1725 Claims")
 ;I $G(FB1725R)]"",FB1725R'="A" W " ",$S(FB1725R="M":"for 38 U.S.C. 1725 Claims",1:"excluding 38 U.S.C. 1725 Claims")
 D LN S $E(XX,24)=$E(FBDASH,1,24),$E(XX,71)="Page: "_FBPG D LN
 ;W !?24,$E(FBDASH,1,24),?71,"Page: ",FBPG,!
 S:FBSORT XX="Patient: "_FBPNAME,$E(XX,41)="Patient ID: "_FBPID S:'FBSORT XX="Vendor: "_FBVNAME,$E(XX,41)="Vendor ID: "_FBVID D LN
 ;W:FBSORT "Patient: ",FBPNAME,?41,"Patient ID: ",FBPID W:'FBSORT "Vendor: ",FBVNAME,?41,"Vendor ID: ",FBVID
 ;W ?71,"Page: ",FBPG
 S $E(XX,80-(13+$L(FBPROG(+FBPI)))/2)="FEE PROGRAM: "_FBPROG(+FBPI) D LN
 ;W !?(IOM-(13+$L(FBPROG(+FBPI)))/2),"FEE PROGRAM: ",FBPROG(+FBPI)
 S $E(XX,3)="('*' Reimb. to Patient   '+' Cancel. Activity   '#' Voided Payment)" D LN
 S $E(XX,3)="(paid symbol: 'R' RBRVS  'F' 75th percentile  'C' contract  'M' Mill Bill" D LN
 S $E(XX,3)="              'U' U&C)" D LN
 S XX=" "_"Svc Date",$E(XX,11)="CPT-MOD ",$E(XX,21)="Rev Code",$E(XX,31)="Units Paid",$E(XX,43)="Batch No.",$E(XX,54)="Inv No.",$E(XX,64)="Voucher Date" D LN
 S XX="Amt Claimed",$E(XX,13)="Amt Paid",$E(XX,23)="Adj Code",$E(XX,36)="Adj Amounts",$E(XX,48)="Remit Remark",$E(XX,61)="Patient Account No" D LN S XX=FBDASH D LN
 Q
SH ;subheader - vendor if fbsort; patient if 'fbsort, prints when name changed
 D HDR
 I FBSORT D LN S XX="Vendor: "_$P(FBVI,";"),$E(XX,41)="Vendor ID: "_$P(FBVI,";",2) D LN
 I 'FBSORT D LN S XX="Patient: "_$P(FBPT,";"),$E(XX,41)="Patient ID: "_$$SSN^FBAAUTL($P(FBPT,";",2)) D LN
 Q
SH1 ;
 S FBPAT=$P(FBPT,";") I $D(^TMP($J,"FBTR",FBPAT)) S FBTRCK=1 D TRAV^DSIFRP67
 Q
CR ;read for display
 ;S DIR(0)="E" W ! D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) FBOUT=1
 Q
PAGE ;new page
 ;I FBCRT D CR Q:FBOUT
 D HDR,SH
 Q
EFBCK(FBCKIN) ;extract check information from ^TMP
 I $G(FBCKIN)']"" S (FBCK,FBCKDT,FBCANDT,FBCANR,FBCAN,FBDIS,FBCKINT)="" Q
 S U="^",FBCK=$P(FBCKIN,U,2),FBCKDT=$P(FBCKIN,U,3),FBCANDT=$P(FBCKIN,U,4),FBCANR=$P(FBCKIN,U,5),FBCAN=$P(FBCKIN,U,6),FBDIS=$P(FBCKIN,U,7),FBCKINT=$P(FBCKIN,U,8)
 K FBCKIN
 Q
 ;
EN ;entry from fbpay67 to set '*' if ancillary payment is
 ;a reimbursement.  returns FBRP=to '*' or " "
 ;'Y' passed in equal to zero node of 162.03 look at $P(Y,U,20)
 ;
 S FBR=$P($G(Y),U,20),FBR=$S(FBR="R":"*",1:" ")
 Q
LN ;
 S YY=YY+1,@AXY@(YY)=XX,XX=""
 Q
PMNT ;displays check and cancellation information if any exist
 I $G(FBCK)]"" S $E(XX,4)=">>>Check # "_FBCK I $G(FBCKDT) S XX=XX_"  Date Paid:  "_$$DATX^FBAAUTL(FBCKDT)_$S(FBCKINT>0:"  Interest: "_$FN(FBCKINT,",",2),1:"")_"<<<" D
 .D LN I FBDIS-FBCKINT'=+A2 S $E(XX,4)=">>>Amount paid altered to $ "_$FN((FBDIS-FBCKINT),",",2)_" on the Fee Payment Voucher document.<<<" D LN
 I $G(FBCANDT)>0 S $E(XX,4)=">>>Check cancelled on: "_$$DATX^FBAAUTL(FBCANDT) I +FBCANR S XX=XX_"   Reason:  "_$P($G(^FB(162.95,+FBCANR,0)),"^")_"<<<" D
 .D LN S $E(XX,7)=$S(FBCAN="R":"Check WILL be replaced.",FBCAN="C":"Check WILL be re-issued.",FBCAN="X":"Check WILL NOT be replaced.",1:"") D LN
PMTCLN ;
 K FBCAN,FBCK,FBCKDT,FBCANDT,FBCANR,FBCKINT,FBDIS,FBCKIN
 Q
