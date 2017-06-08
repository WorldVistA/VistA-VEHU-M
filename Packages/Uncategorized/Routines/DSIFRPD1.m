DSIFRPD1 ;DSS/AMC - DISPLAY PATIENT DEMOGRAPHICS ;03/01/2009
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ; 10011  ^DIWP
 ; 10103  $$FMTE^XLFDT
 ;
EN ;
 N FBDX,FBFDT,FBI,FBRR,FBT,FBTYPE,FBV,FBZ,PSA
 S:'$D(FBPROG) FBPROG="I 1"
 S Y=$G(^FBAAA(DFN,4)) S:$P(Y,"^")]"" XX="Fee ID Card #: "_$P(Y,"^"),$E(XX,40)="Fee Card Issue Date: " S Y=$P(Y,"^",2) D PDF S XX=XX_Y D LN,LN
 S FBAAOUT=0 I $O(^FBAAA(DFN,1,0)) D  Q:FBAAOUT
 .S XX="Patient Name: "_VADM(1),$E(XX,55)="Pt.ID: "_$P(VADM(2),"^",2) D LN
 .D LN S XX="AUTHORIZATIONS:" D LN
 .K FBAUT
 .S FBZ=0,FBFDT="9999999"
 .F  S FBFDT=$O(^FBAAA(DFN,1,"B",FBFDT),-1) Q:'FBFDT  D  Q:FBAAOUT
 ..S FBI=0 F  S FBI=$O(^FBAAA(DFN,1,"B",FBFDT,FBI)) Q:'FBI  I $D(^FBAAA(DFN,1,FBI,0)) X FBPROG I  S FBZ=FBZ+1,X=^(0) D  Q:FBAAOUT
 ...S Y=+X,PSA=$P(X,"^",5),FBT=$P(X,"^",13),FBV=+$P(X,"^",4) D PDF
 ...S $E(XX,3)="("_FBZ_")",$E(XX,7)="FR: "_Y,$E(XX,25)="VENDOR: "_$S($D(^FBAAV(FBV,0)):$P(^(0),"^")_" - "_$P(^(0),"^",2),1:"Not Specified") D LN
 ...S FBDX=$G(^FBAAA(DFN,1,FBI,3)) S $E(XX,7)="TO: " S Y=$P(X,"^",2) D PDF S XX=XX_Y D LN S $E(XX,25)="Authorization Type: " D
 ....S FBTYPE=$P(X,"^",3),FBTYPE=$S(FBTYPE=2:"Outpatient - "_$S(FBT=1:"Short Term",FBT=2:"Home Health",FBT=3:"ID Card",1:""),$D(^FBAA(161.8,+FBTYPE,0)):$P(^(0),"^"),1:"Unknown")
 ...S XX=XX_FBTYPE D LN I $P(X,"^",7) S $E(XX,11)="Purpose of Visit: "_$P($G(^FBAA(161.82,$P(X,"^",7),0)),"^") D LN
 ...I $P(X,"^",9)["FB583(" S $E(XX,25)=">> Unauthorized Claim <<" D LN
 ...S $E(XX,11)="DX: "_$P(X,"^",8) D LN
 ...I $P(FBDX,"^")]"" S $E(XX,15)=$P(FBDX,"^") D LN
 ...I $P(FBDX,"^",2)]"" S $E(XX,15)=$P(FBDX,"^",2) D LN
 ...S FBAUT($P(X,"^"))=$P(X,"^",2)
 ...S $E(XX,7)="County: "_FBCOUNTY,$E(XX,40)="PSA: "_$S($P($$NS^XUAF4(PSA),U)]"":$P($$NS^XUAF4(PSA),U),1:"Unknown") D LN
 ...S FBDEL=$G(^FBAAA(DFN,1,FBI,"ADEL")) I FBDEL]"" S Y=$P(FBDEL,"^",2) D PDF S $E(XX,12)=">> DELETE MRA SENT TO AUSTIN ON - "_Y_" >>" D LN
 ...I $D(^FBAAA(DFN,1,FBI,2,0)) K ^UTILITY($J,"W") S DIWL=15,DIWR=70,DIWF="" S $E(XX,11)="REMARKS:" D LN D
 ....S FBRR=0 F  S FBRR=$O(^FBAAA(DFN,1,FBI,2,FBRR)) Q:'FBRR  S (FBXX,X)=^(FBRR,0) D ^DIWP
 ...S FBRR=0 F  S FBRR=$O(^UTILITY($J,"W",15,FBRR)) Q:'FBRR  S $E(XX,15)=^(FBRR,0) D LN
 ...K X,FBDX,FBT,FBTYPE,FBV,PSA
 I $O(^FBAAA(DFN,2,0))>0 D  Q:FBAAOUT
 .S XX="VENDOR CONTACTS:" D LN
 .S (FBZ,FBI)=0
 .F  S FBI=$O(^FBAAA(DFN,2,FBI)) Q:'FBI!(FBAAOUT)  S FBZ=FBZ+1,X=$G(^(FBI,0)),Y=+X D PDF D
 ..S $E(XX,3)="("_FBZ_")",$E(XX,7)="DATE: "_Y,$E(XX,25)="VENDOR: "_$P(X,"^",2),$E(XX,55)="PHONE: "_$S($P(X,"^",3)]"":$P(X,"^",3),1:"Not Found") D LN
 ..I $D(^FBAAA(DFN,2,FBI,1,0)) K ^UTILITY($J,"W") S DIWL=20,DIWR=70,DIWF="" S $E(XX,11)="NARRATIVE:" D LN D
 ...S FBRR=0 F  S FBRR=$O(^FBAAA(DFN,2,FBI,1,FBRR)) Q:'FBRR  S (FBXX,X)=^(FBRR,0) D ^DIWP
 ..S FBRR=0 F  S FBRR=$O(^UTILITY($J,"W",20,FBRR)) Q:'FBRR  S $E(XX,20)=^(FBRR,0) D LN
 Q
PDF ;
 S:Y Y=$$FMTE^XLFDT(Y,5)  ; TRANSLATE TO DISPLAY DATE
 Q
LN ;
 S YY=YY+1,@AXY@(YY)=XX,XX=""
 Q
