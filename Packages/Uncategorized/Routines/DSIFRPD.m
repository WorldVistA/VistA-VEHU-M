DSIFRPD ;DSS/AMC - DISPLAY PATIENT DEMOGRAPHICS ;03/01/2009
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;  4419  $$INSUR^IBBAPI
 ;  4807  RDIS^DGRPDB 
 ; 10003  DD^%DT
 ; 10011  ^DIWP
 ; 10061  6^VADPT,ELIG^VADPT,KVA^VADPT
 ; 10103  $$FMTE^XLFDT
 ;
 S VAPA("P")="" D 6^VADPT G END:VAERR
 S:+VADM(6) YY=YY+1,@AXY@(YY)="*** Patient Died on "_$P(VADM(6),"^",2)
 S YY=YY+1,XX=VADM(1),$E(XX,39)="Pt. ID: "_$P(VADM(2),U,2),@AXY@(YY)=XX
 S YY=YY+1,XX=VAPA(1),$E(XX,41)="DOB: "_$P(VADM(3),U,2)
 I VAPA(2)]"" S YY=YY+1,@AXY@(YY)=VAPA(2) ;W !,VAPA(2)
 I VAPA(3)]"" S YY=YY+1,@AXY@(YY)=VAPA(3) ;W !,VAPA(3)
 S YY=YY+1,XX=VAPA(4),$E(XX,41)="TEL: "_$S(VAPA(8)]"":VAPA(8),1:"Not on File"),@AXY@(YY)=XX
 S YY=YY+1,XX=$P(VAPA(5),U,2)_" "_$S('+$G(VAPA(11)):VAPA(6),$P(VAPA(11),U,2)]"":$P(VAPA(11),U,2),1:VAPA(6)),$E(XX,37)="CLAIM #: "_$S(VAEL(7)]"":VAEL(7),1:"Not on File"),@AXY@(YY)=XX
 S FBCOUNTY=$S($P(VAPA(7),"^",2)]"":$P(VAPA(7),"^",2),1:"Not on File")
 S YY=YY+1,XX="",$E(XX,38)="COUNTY: "_FBCOUNTY ;W !?38,"COUNTY: ",FBCOUNTY
 N FBCCADR S FBCCADR=$$CCADR()
 D ELIG,DIS
 D INS
 I $D(^FBAAA(DFN,0)) D ^DSIFRPD1
 ;
END ;
 D KVA^VADPT K FBCOUNTY,FBDEL Q
 ;
ELIG ;
 N I,I1
 S XX="" D LN S XX="Primary Elig. Code: "_$P(VAEL(1),"^",2)_"  --  "_$S(VAEL(8)']"":"NOT VERIFIED",1:$P(VAEL(8),"^",2))
 I VAEL(8)]"" S Y=$P($G(^DPT(DFN,.361)),"^",2) D DD^%DT S XX=XX_"  "_Y ;D DT^DIQ
 D LN
 S XX="Other Elig. Code(s): "
 I $D(VAEL(1))>9 S (I,I1)=0 F  S I=$O(VAEL(1,I)) Q:'I  S I1=I1+1,$E(XX,22)=$P(VAEL(1,I),"^",2) D LN
 E  S XX=XX_"NO ADDITIONAL ELIGIBILITIES IDENTIFIED" D LN
 Q
CCADR() ;COPIED FROM FBAACO0
 N FBACT
 S FBACT=0
 I '$D(VAPA(12)) Q 0  ;if D ADD^VADPT was not invoked before
 I 'VAERR D
 .S FBACT=$$ACTIVECC()
 .Q:'FBACT
 .S XX="" D LN S XX="Confidential Communication address until: "_$P($G(VAPA(21)),U,2) D LN
 .I $G(VAPA(13))]"" S XX="Line 1: "_$G(VAPA(13)) D LN
 .I $G(VAPA(14))]"" S XX="Line 2: "_$G(VAPA(14)) D LN
 .I $G(VAPA(15))]"" S XX="Line 3: "_$G(VAPA(15)) D LN
 .S XX="City:",$E(XX,9)=$S($G(VAPA(16))]"":$G(VAPA(16)),1:"")
 .S $E(XX,40)="State: "_$S($P($G(VAPA(17)),U,2)]"":$P($G(VAPA(17)),U,2),1:"") D LN
 .S $E(XX,FBSTPOS)="Zip:    "_$P($G(VAPA(18)),U,2)
 .S $E(XX,20)="County: "_$P($G(VAPA(19)),U,2) D LN
 Q $G(FBACT)
 ;
 ;is called after ADD^VADPT to verify whether confidential address is 
 ;active or not to encapsulate the logic related to status of CC address
 ;input:  VAPA
ACTIVECC() ;
 Q (+$G(VAPA(12))=1)&($P($G(VAPA(22,3)),"^",3)="Y")
 ;
 ;edit confidential address
 ;returns 1 if CC address has been edited
 ;otherwise - 0
DIS ;rated disabilities - Integration Agreement #700 ;DGRPDB
 ;
 ;  This is called from the FEE and MCCR package!!!
 ;
 ;  Input:  DFN as IEN of PATIENT file
 ;          VAEL array (if no passed, it is set) of eligibility info
 ;
 I '$D(VAEL) D ELIG^VADPT S DGKVAR=1
 S YY=YY+1,@AXY@(YY)="",YY=YY+1,XX=$S('VAEL(3):"  Service Connected: NO",1:"         SC Percent: "_$P(VAEL(3),U,2)_"%"),@AXY@(YY)=XX
 N DGQUIT
 S XX=" Rated Disabilities: " I 'VAEL(4),$S('$D(^DG(391,+VAEL(6),0)):1,$P(^DG(391,+VAEL(6),0),"^",2):0,1:1) S XX=XX_"NOT A VETERAN" D LN G DISQ
 N DSIFRD D RDIS^DGRPDB(DFN,.DSIFRD) I $D(DSIFRD) S I3=0 F I=0:0 S I=$O(DSIFRD(I)) Q:'I!($G(DGQUIT)=1)  D
 .S I1=$P(DSIFRD(I),U),I2=$S($D(^DIC(31,I1,0)):$P(^DIC(31,I1,0),"^",1)_" ("_$P(DSIFRD(I),U,2)_"%-"_$S($P(DSIFRD(I),U,3):"SC",$P(DSIFRD(I),U,3)']"":"not specified",1:"NSC")_")",1:""),I3=I3+1
 .S:I3 XX=XX_I2 S:I3>1 $E(XX,21)=I2 D LN
 I 'I3 S XX=XX_"NONE STATED" D LN
DISQ ;
 I $D(DGKVAR) D KVAR^VADPT K DGKVAR
 K I,I1,I2,I3
 Q
 ;
INS ;insurance information ;DGRPDB
 ;
 ;  This is called form the FEE package!!!
 ;
 ;  Input:  DFN as IEN of PATIENT file
 ;          DGINSDT as date to compute insurance flag as of (default DT)
 ;
 Q:'$D(DFN)
 S Z=$$INSUR^IBBAPI(DFN,$S($D(DGINSDT):DGINSDT,1:DT))
 S YY=YY+1,@AXY@(YY)="",XX="    Health Insurance: "_$S(Z:"YES",1:"NO"),YY=YY+1,@AXY@(YY)=XX
 D DISP^DSIFIBD
INSQ ;
 K I,I1,DGX,Z
 Q
LN ;
 S YY=YY+1,@AXY@(YY)=XX,XX=""
 Q
