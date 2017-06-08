DSIFRP67 ;DSS/AMC - CH/CNH PAYMENT HISTORY PRINT ;7/18/2001
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;  5090  $$DATX^FBAAUTL,$$SSN^FBAAUTL
 ;  5098  $$ICD0^FBCSV1,$$ICD9^FBCSV1
 ;  5114  $$EXTRL^FBMRASVR
 ;  5116  EFBCK^FBPAY21
 ;
PRINT ;print data from tmp global
 S FBOUT=0 D:FBCRT&(FBPG) CR Q:FBOUT
 S FBHEAD=$S(FBSORT:"VETERAN",1:"VENDOR")
EN1 ;
 N FBI,FBINV ;entry point from fbchdi
 D HDR S FBVI="" F  S FBVI=$O(^TMP($J,"FB",FBPI,FBVI)) Q:FBVI']""!(FBOUT)  D:FBSORT SH Q:FBOUT  S FBPT="" F  S FBPT=$O(^TMP($J,"FB",FBPI,FBVI,FBPT)) Q:FBPT']""!(FBOUT)  D  Q:FBOUT  D CKANC Q:FBOUT
 .D:'FBSORT SH Q:FBOUT  S FBDT=0 F  S FBDT=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT)) Q:'FBDT!(FBOUT)  S FBI=0 F  S FBI=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,FBI)) Q:'FBI!(FBOUT)  D  Q:FBOUT
 ..;I ($Y+5)>IOSL D PAGE Q:FBOUT
 ..S FBDATA=^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,FBI),A2=$$EXTRL^FBMRASVR($P(FBDATA,U,3))
 ..S FBINV=^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,FBI,"FBINV")
 ..S XX=$S($P(FBDATA,U,8)["R":"*",1:" "),XX=XX_$S($P(FBDATA,U,9)]"":"#",1:" ")
 ..;W ! W:$P(FBDATA,U,8)["R" "*" W:$P(FBDATA,U,9)]"" "#"
 ..S XX=XX_$P(FBDATA,U,1),$E(XX,15)=$P(FBDATA,U,5),$E(XX,31)=$P(FBDATA,U,6)
 ..;W ?2,$P(FBDATA,U,1),?15,$P(FBDATA,U,5),?31,$P(FBDATA,U,6)
 ..S $E(XX,47)=$P(FBDATA,U,7),$E(XX,57)=$P(FBINV,U,2) D LN
 ..;W ?47,$P(FBDATA,U,7),?57,$P(FBINV,U,2)
 ..S XX="  "_$P(FBDATA,U,2),$E(XX,15)=$P(FBDATA,U,3),$E(XX,25)=$P(FBINV,U,1)
 ..;W !?2,$P(FBDATA,U,2),?15,$P(FBDATA,U,3),?25,$P(FBINV,U,1)
 .. ;Print adj reasons, if null then print suspend code
 ..S $E(XX,36)=$S($P(FBINV,U,5)]"":$P(FBINV,U,5),1:$P(FBDATA,U,4))
 ..;W ?36,$S($P(FBINV,U,5)]"":$P(FBINV,U,5),1:$P(FBDATA,U,4))
 ..S $E(XX,46)=$S($P(FBINV,U,5)]"":$J($P(FBINV,U,6),14),1:$J($P(FBDATA,U,10),14))
 ..;W ?46,$S($P(FBINV,U,5)]"":$J($P(FBINV,U,6),14),1:$J($P(FBDATA,U,10),14))
 ..S $E(XX,63)=$P(FBINV,U,7) D LN
 ..;W ?63,$P(FBINV,U,7)
 .. ;If FPPS Claim ID exists then print it.
 ..I $P(FBINV,U,3)]"" D
 ...S $E(XX,5)="FPPS Claim ID: "_$P(FBINV,U,3)_"    FPPS Line Item: "_$P(FBINV,U,4) D LN
 ..F FBY="DX","PROC" I $D(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,FBI,FBY)) S FBDATA=^(FBY),FBSL=$L(FBDATA,"^") S XX="  "_FBY_": " F I=1:1:FBSL S XX=XX_$P(FBDATA,U,I)_"    "
 ..D LN
 ..I $D(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,FBI,"FBCK")) D EFBCK^FBPAY21(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,FBI,"FBCK")) D PMNT^DSIFRP41 K A2
 Q
CKANC ;
 I +$O(^TMP($J,"FB",FBPI,FBVI,FBPT,"A",0)) D PANC(FBI) Q:FBOUT  S XX=FBDASH1 D LN
 Q
PANC(FBI) ;print anc data - FBI = unique number; called by fbpay3
 S (FBOV,FBK)=0,FBSL=8,FBLOC=1_U_12_U_23_U_33_U_43_U_56_U_62_U_71 D SHA Q:FBOUT
 F  S FBK=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,"A",FBK)) Q:'FBK!(FBOUT)  S FBL=0 F  S FBL=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,"A",FBK,FBL)) Q:'FBL!(FBOUT)  S FBM=0 F  S FBM=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,"A",FBK,FBL,FBM)) Q:'FBM!(FBOUT)  D
 .S FBDATA=^TMP($J,"FB",FBPI,FBVI,FBPT,"A",FBK,FBL,FBM)
 .S FBV=$P(FBDATA,U,12)_";"_$P(FBDATA,U,13)
 .D WRT
 K FBK,FBL,FBM Q
WRT ;write ancillary info
 ;I ($Y+6)>IOSL D PAGE Q:FBOUT  D SHA Q:FBOUT  D SHA2 Q:FBOUT
 D:FBOV'=FBV SHA2
 S FBCKIN=$G(^TMP($J,"FB",FBPI,FBVI,FBPT,"A",FBK,FBL,FBM,"FBCK")) D EFBCK^FBPAY21(FBCKIN)
 S FBADJ=$G(^TMP($J,"FB",FBPI,FBVI,FBPT,"A",FBK,FBL,FBM,"FBADJ"))
 S XX=$S($G(FBCAN)]"":"+",1:" ")
 ;W ! W:$G(FBCAN)]"" "+"
 S XX=XX_$P(FBDATA,U,1)
 ;W ?1,$P(FBDATA,U,1)
 S $E(XX,11)=$P($P(FBDATA,U,2),",")
 ;W ?11,$P($P(FBDATA,U,2),",")
 S $E(XX,22)=$P(FBADJ,U,9)
 ;W ?22,$P(FBADJ,U,9)
 S $E(XX,31)=$J($P(FBADJ,U,2),10)
 ;W ?31,$J($P(FBADJ,U,2),10)
 S $E(XX,43)=$P(FBDATA,U,6)
 ;W ?43,$P(FBDATA,U,6)
 S $E(XX,54)=$P(FBDATA,U,7)
 ;W ?54,$P(FBDATA,U,7)
 S $E(XX,64)=$P(FBDATA,U,8) D LN
 ;W ?64,$P(FBDATA,U,8)
 I $P($P(FBDATA,U,2),",",2)]"" D  Q:FBOUT
 .N FBI,FBMOD
 .F FBI=2:1 S FBMOD=$P($P(FBDATA,U,2),",",FBI) Q:FBMOD=""  D  Q:FBOUT
 ..;I $Y+7>IOSL D PAGE Q:FBOUT  D SHA Q:FBOUT  D SHA2 Q:FBOUT  W !,"  (continued)"
 ..S $E(XX,16)="-"_FBMOD D LN
 S XX=$P(FBDATA,U,3)
 ;W !,$P(FBDATA,U,3)
 S $E(XX,13)=$P(FBDATA,U,4)
 ;W ?13,$P(FBDATA,U,4)
 S $E(XX,23)=$S($P(FBADJ,U,3)]"":$P(FBADJ,U,3),1:$P(FBDATA,U,5))
 ;W ?23,$S($P(FBADJ,U,3)]"":$P(FBADJ,U,3),1:$P(FBDATA,U,5))
 S $E(XX,33)=$J($S($P(FBADJ,U,4)]"":$P(FBADJ,U,4),1:$P(FBADJ,U,1)),14)
 ;W ?33,$J($S($P(FBADJ,U,4)]"":$J($P(FBADJ,U,4),14),1:$P(FBADJ,U,1)),14)
 S $E(XX,48)=$P(FBADJ,U,5)
 ;W ?48,$P(FBADJ,U,5)
 S $E(XX,60)=$P(FBADJ,U,6) D LN
 ;W ?60,$P(FBADJ,U,6)
 ;If FPPS Claim ID exists then print it.
 I $P(FBADJ,U,7)]"" D
 .S $E(XX,5)="FPPS Claim ID: "_$P(FBADJ,U,7)_"    FPPS Line Item: "_$P(FBADJ,U,8) D LN
 S $E(XX,4)="Primary Dx: "_$P(FBDATA,U,10),$E(XX,40)="S/C Condition? "_$P(FBDATA,U,9),$E(XX,66)="Obl.#: "_$P(FBDATA,U,11) D LN
 N A2 S A2=$$EXTRL^FBMRASVR($P(FBDATA,U,4))
 D PMNT^DSIFRP41
 Q
HDR ;main header
 ;I FBPG>0!FBCRT W @IOF
 S FBPG=FBPG+1
 I $D(FBHEAD) D
 .S $E(XX,25)=FBHEAD_" PAYMENT HISTORY"
 .I $G(FB1725R)]"",FB1725R'="A" S XX=XX_" "_$S(FB1725R="M":"for 38 U.S.C. 1725 Claims",1:"excluding 38 U.S.C. 1725 Claims")
 .D LN
 .S $E(XX,24)=$E(FBDASH,1,24),$E(XX,71)="Page: "_FBPG D LN S $E(XX,48)="Date Range: "_$$DATX^FBAAUTL(FBBDATE)_" to "_$$DATX^FBAAUTL(FBEDATE) D LN
 I '$D(FBHEAD) S $E(XX,30)="INVOICE DISPLAY" D LN S $E(XX,29)=$E(FBDASH,1,17) D LN,LN
 S:FBSORT XX="Patient: "_FBPNAME,$E(XX,41)="Patient ID: "_FBPID S:'FBSORT XX="Vendor: "_FBVNAME,$E(XX,41)="Vendor ID: "_FBVID D LN
 S $E(XX,80-(13+$L(FBPROG(+FBPI)))/2)="FEE PROGRAM: "_FBPROG(+FBPI) D LN
 S $E(XX,3)="('*' Reimb. to Patient  '+' Cancel. Activity  '#' Voided Payment)" D LN
 S $E(XX,3)="(paid symbol: 'R' RBRVS  'F' 75th percentile  'C' contract  'M' Mill Bill" D LN
 S $E(XX,3)="              'U' U&C)" D LN
 S XX=" Invoice Date",$E(XX,15)="Invoice No.",$E(XX,31)="From Date",$E(XX,48)="To Date",$E(XX,57)="Patient Control #" D LN
 S XX=" Amt Claimed",$E(XX,15)="Amt Paid",$E(XX,25)="Cov Days",$E(XX,36)="Adj Codes",$E(XX,49)="Adj Amounts",$E(XX,63)="Remit Remarks" D LN S XX=FBDASH D LN
 Q
SH ;subheader - vendor if fbsort; patient if 'fbsort, prints when name changed
 ;I ($Y+7)>IOSL D:FBCRT CR Q:FBOUT  D HDR
 I FBSORT D LN S XX="Vendor: "_$P(FBVI,";"),$E(XX,41)="Vendor ID: "_$P(FBVI,";",2) D LN
 I 'FBSORT D LN S XX="Patient: "_$P(FBPT,";"),$E(XX,41)="Patient ID: "_$$SSN^FBAAUTL($P(FBPT,";",2)) D LN
 Q
SHA ;ancillary subheader
 ;I ($Y+14)>IOSL D PAGE Q:FBOUT
 S $E(XX,20)=">>> ANCILLARY SERVICE PAYMENTS <<<" D LN,LN
SHA1 ;subheader for ancillary data
 S XX=" Svc Date CPT-MOD   Rev Code  Units Paid  Batch No.  Inv No.   Voucher Date" D LN
 S XX="Amt Claimed Amt Paid  Adj Code     Adj Amounts Remit Remark Patient Account No" D LN S XX=FBDASH D LN
 Q
SHA2 ;subheader for vendor name
 ;I ($Y+5)>IOSL D:FBCRT CR Q:FBOUT  D HDR,SH,SHA
 I FBOV'=FBV S FBOV=FBV
 D LN S XX="Vendor: "_$P(FBV,";"),$E(XX,41)="Vendor ID: "_$P(FBV,";",2) D LN
 Q
CR ;read for display
 ;Q:'FBPG  S DIR(0)="E" W ! D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) FBOUT=1
 Q
PAGE ;new page
 ;I FBCRT D CR Q:FBOUT
 D HDR,SH
 Q
WRTDX ;
 I $P(FBDX,"^",K)]"" S $E(XX,4)="Dx: "_$$ICD9^FBCSV1($P(FBDX,"^",K))_"  " D LN
 Q
WRTPC ;
 I $P(FBPROC,"^",L)]"" S $E(XX,4)="Proc: "_$$ICD0^FBCSV1($P(FBPROC,"^",L))_"   " Q
 Q
WRTSC ;write service connected
 S XX="SERVICE CONNECTED? "_$S(+VAEL(3):"YES",1:"NO") D LN,LN
 Q
TRAV ;write out travel payments, (FBPAT,FBSORT) must be defined
 S FBTRDT=0
 F  S FBTRDT=$O(^TMP($J,"FBTR",FBPAT,FBTRDT)) Q:'FBTRDT  S FBTRX=0 F  S FBTRX=$O(^TMP($J,"FBTR",FBPAT,FBTRDT,FBTRX)) Q:'FBTRX  S FBCKIN=^(FBTRX),A2=$P(FBCKIN,"^") D TRCK Q:FBOUT  S:$G(FBTRCK) $E(XX,5)="TRAVEL PAYMENTS: " D  K FBTRCK
 .S $E(XX,22)=$$DATX^FBAAUTL(FBTRDT),$E(XX,35)=A2 D LN
 .S A2=$$EXTRL^FBMRASVR(A2) D EFBCK^FBPAY21(FBCKIN),PMNT^DSIFRP41
 .K A2 D LN Q
 Q
TRCK ;
 I ($Y+5)>IOSL D:FBCRT CR Q:FBOUT  D HDR^DSIFRP41
 Q
LN ;
 S YY=YY+1,@AXY@(YY)=XX,XX=""
 Q
