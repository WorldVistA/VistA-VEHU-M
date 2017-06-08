VEJDWPBY ;WPB/CAM routine modified for dental GUI;8/1/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;BHAM ISC/SAB - returns patient's outpatient meds ; 07/21/96  7:53 PM
 ;PSOORRL;7.0;OUTPATIENT PHARMACY;**4**;DEC 1997
OCL(DFN,BDT,EDT) ;entry point to return condensed list
 ;D:$P($G(^PS(55,DFN,0)),"^",6)'=2 EN^PSOHLUPZ(DFN)
 K ^TMP("PS",$J) S TFN=0,PSBDT=$G(BDT),PSEDT=$G(EDT) I +$G(PSBDT)<1 S X1=DT,X2=-120 D C^%DTC S PSBDT=X
 S EXDT=PSBDT-1,IFN=0
 F  S EXDT=$O(^PS(55,DFN,"P","A",EXDT)) Q:'EXDT  F  S IFN=$O(^PS(55,DFN,"P","A",EXDT,IFN)) Q:'IFN  D:$D(^PSRX(IFN,0))
 .Q:$P($G(^PSRX(IFN,"STA")),"^")=13  S TFN=TFN+1,RX0=^PSRX(IFN,0),RX2=$G(^(2)),RX3=$G(^(3)),STA=+$G(^("STA")),TRM=0,LSTFD=$P(RX2,"^",2)
 .F I=0:0 S I=$O(^PSRX(IFN,1,I)) Q:'I  S TRM=TRM+1,LSTFD=$P(^PSRX(IFN,1,I,0),"^")
 .S ^TMP("PS",$J,TFN,0)=IFN_"R;O"_"^"_$P($G(^PSDRUG(+$P(RX0,"^",6),0)),"^")_"^^"_$P(RX2,"^",6)_"^"_($P(RX0,"^",9)-TRM)_"^^^"_$P($G(^PSRX(IFN,"OR1")),"^",2)
 .S ^TMP("PS",$J,TFN,"P",0)=$P(RX0,"^",4)_"^"_$P($G(^VA(200,+$P(RX0,"^",4),0)),"^")
 .S ST0=$S(STA<12&($P(RX2,"^",6)<DT):11,1:STA)
 .S ST=$P("ERROR^ACTIVE^NON-VERIFIED^REFILL FILL^HOLD^NON-VERIFIED^SUSPENDED^^^^^DONE^EXPIRED^DISCONTINUED^DISCONTINUED^DISCONTINUED^DISCONTINUED (EDIT)^HOLD^","^",ST0+2)
 .S ^TMP("PS",$J,TFN,0)=^TMP("PS",$J,TFN,0)_"^"_ST_"^"_LSTFD_"^"_$P(RX0,"^",8)_"^"_$P(RX0,"^",7)_"^^"
 .S ^TMP("PS",$J,TFN,"SCH",0)=0
 .S (SCH,SC)=0 F  S SC=$O(^PSRX(IFN,"SCH",SC)) Q:'SC  S SCH=SCH+1,^TMP("PS",$J,TFN,"SCH",SCH,0)=$P(^PSRX(IFN,"SCH",SC,0),"^"),^TMP("PS",$J,TFN,"SCH",0)=^TMP("PS",$J,TFN,"SCH",0)+1
 .S ^TMP("PS",$J,TFN,"MDR",0)=0,(MDR,MR)=0 F  S MR=$O(^PSRX(IFN,"MEDR",MR)) Q:'MR  D
 ..Q:'$D(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0))  S MDR=MDR+1
 ..I $P($G(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0)),"^",3)]"" S ^TMP("PS",$J,TFN,"MDR",MDR,0)=$P(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0),"^",3)
 ..I $D(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0)),$P($G(^(0)),"^",3)']"" S ^TMP("PS",$J,TFN,"MDR",MDR,0)=$P(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0),"^")
 ..S ^TMP("PS",$J,TFN,"MDR",0)=^TMP("PS",$J,TFN,"MDR",0)+1
 .S PSOELSE=0 I '$P(^PSRX(IFN,"SIG"),"^",2) S PSOELSE=1 S X=$P(^PSRX(IFN,"SIG"),"^") D SIG1
 .I '$G(PSOELSE) S ITFN=1 D
 ..S ^TMP("PS",$J,TFN,"SIG",ITFN,0)=$G(^PSRX(IFN,"SIG1",1,0)),^TMP("PS",$J,TFN,"SIG",0)=+$G(^TMP("PS",$J,TFN,"SIG",0))+1
 ..F I=1:0 S I=$O(^PSRX(IFN,"SIG1",I)) Q:'I  S ITFN=ITFN+1,^TMP("PS",$J,TFN,"SIG",ITFN,0)=^PSRX(IFN,"SIG1",I,0),^TMP("PS",$J,TFN,"SIG",0)=+$G(^TMP("PS",$J,TFN,"SIG",0))+1
 K PSOELSE
 S IFN=0 F  S IFN=$O(^PS(52.41,"P",DFN,IFN)) Q:'IFN  S PSOR=^PS(52.41,IFN,0) D:$P(PSOR,"^",3)'="DC"&($P(PSOR,"^",3)'="DE")
 .Q:$P(PSOR,"^",3)="RF"
 .S TFN=TFN+1,^TMP("PS",$J,TFN,0)=IFN_"P;O^"_$S($P(PSOR,"^",9):$P($G(^PSDRUG($P(PSOR,"^",9),0)),"^"),1:$P(^PS(50.7,$P(PSOR,"^",8),0),"^")_" "_$P(^PS(50.606,$P(^PS(50.7,$P(PSOR,"^",8),0),"^",2),0),"^"))
 .S ^TMP("PS",$J,TFN,0)=^TMP("PS",$J,TFN,0)_"^^^^^^"_$P(PSOR,"^")_"^"_"PENDING^^^"_$P(PSOR,"^",10)_"^"
 .S ^TMP("PS",$J,TFN,0)=^TMP("PS",$J,TFN,0)_"^"_$S($P(PSOR,"^",3)="RNW":1,1:0)
 .S SD=0 F SCH=0:0 S SCH=$O(^PS(52.41,IFN,1,SCH)) Q:'SCH  S SD=SD+1,^TMP("PS",$J,TFN,"SCH",SD,0)=$P(^PS(52.41,IFN,1,SCH,1),"^"),^TMP("PS",$J,TFN,"SCH",0)=SD
 .S SD=0 F SCH=0:0 S SCH=$O(^PS(52.41,IFN,"SIG",SCH)) Q:'SCH  S SD=SD+1,^TMP("PS",$J,TFN,"SIG",SD,0)=$P(^PS(52.41,IFN,"SIG",SCH,0),"^"),^TMP("PS",$J,TFN,"SIG",0)=SD
 .S (IEN,SD)=1,INST=0 F  S INST=$O(^PS(52.41,IFN,2,INST)) Q:'INST  S (MIG,INST(INST))=^PS(52.41,IFN,2,INST,0),^TMP("PS",$J,TFN,"SIO",0)=SD D
 ..F SG=1:1:$L(MIG," ") S:$L($G(^TMP("PS",$J,TFN,"SIO",IEN,0))_" "_$P(MIG," ",SG))>80 IEN=IEN+1,SD=SD+1,^TMP("PS",$J,TFN,"SIO",0)=SD S ^TMP("PS",$J,TFN,"SIO",IEN,0)=$G(^TMP("PS",$J,TFN,"SIO",IEN,0))_" "_$P(MIG," ",SG)
 D OCL^VEJDWPC1(DFN,BDT,EDT,TFN),END
 Q
OEL(DFN,RXNUM) ;returns expanded list on specific order
 I $P(RXNUM,";",2)="I" D OEL^VEJDWPC2(DFN,$P(RXNUM,";")) Q
 ;D:$P($G(^PS(55,DFN,0)),"^",6)'=2 EN^PSOHLUP(DFN) Q:RXNUM=""
 K INST,SD,IFN,^TMP("PS",$J) S FL=$P(RXNUM,";"),IFN=+FL,RXNUM=$P(RXNUM,";",2) G:$G(FL)["P" PEN
 Q:'$D(^PSRX(IFN,0))
 S RX0=^PSRX(IFN,0),RX2=$G(^(2)),RX3=$G(^(3)),STA=+$G(^("STA")),TRM=0,LSTFD=$P(RX2,"^",2)
 F I=0:0 S I=$O(^PSRX(IFN,1,I)) Q:'I  S TRM=TRM+1,LSTFD=$P(^PSRX(IFN,1,I,0),"^"),^TMP("PS",$J,"REF",I,0)=$P(^(0),"^")_"^"_$P(^(0),"^",10)_"^"_$P(^(0),"^",4),^TMP("PS",$J,"REF",0)=$G(^TMP("PS",$J,"REF",0))+1
 S ^TMP("PS",$J,0)=$P($G(^PSDRUG(+$P(RX0,"^",6),0)),"^")_"^^"_$P(RX2,"^",6)
 S ^TMP("PS",$J,"P",0)=$P(RX0,"^",4)_"^"_$P($G(^VA(200,+$P(RX0,"^",4),0)),"^")
 S ST0=$S(STA<12&($P(RX2,"^",6)<DT):11,1:STA)
 S ST=$P("ERROR^ACTIVE^NON-VERIFIED^REFILL FILL^HOLD^NON-VERIFIED^SUSPENDED^^^^^DONE^EXPIRED^DISCONTINUE^DISCONTINUED^DISCONTINUED^DISCONTINUED (EDIT)^HOLD^","^",ST0+2)
 S ^TMP("PS",$J,0)=^TMP("PS",$J,0)_"^"_($P(RX0,"^",9)-TRM)_"^"_$P(RX0,"^",13)_"^"_ST_"^"_$P(RX0,"^",8)_"^"_$P(RX0,"^",7)_"^^^"_$P($G(^PSRX(IFN,"OR1")),"^",2)_"^"_LSTFD_"^^"
 S ^TMP("PS",$J,"DD",0)=1,^TMP("PS",$J,"DD",1,0)=$P(RX0,"^",6)_"^^"
 S COD=$S('$G(^PSDRUG(+$P(RX0,"^",6),"I")):1,+$G(^PSDRUG(+$P(RX0,"^",6),"I"))>DT:1,1:0)
 S ^TMP("PS",$J,"DD",1,0)=^TMP("PS",$J,"DD",1,0)_$S($P($G(^PSDRUG(+$P(RX0,"^",6),2)),"^",3)["U"&(COD):$P(RX0,"^",6),1:"") K COD
 S ^TMP("PS",$J,"SCH",0)=0,(SCH,SC)=0
 F  S SC=$O(^PSRX(IFN,"SCH",SC)) Q:'SC  S SCH=SCH+1,^TMP("PS",$J,"SCH",SCH,0)=$P(^PSRX(IFN,"SCH",SC,0),"^") D
 .S ^TMP("PS",$J,"SCH",0)=^TMP("PS",$J,"SCH",0)+1
 S ^TMP("PS",$J,"MDR",0)=0,(MDR,MR)=0 F  S MR=$O(^PSRX(IFN,"MEDR",MR)) Q:'MR  D
 .Q:'$D(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0))  S MDR=MDR+1
 .I $P($G(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0)),"^",3)]"" S ^TMP("PS",$J,"MDR",MDR,0)=$P(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0),"^",3)
 .I $D(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0)),$P($G(^(0)),"^",3)']"" S ^TMP("PS",$J,"MDR",MDR,0)=$P(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0),"^")
 .S ^TMP("PS",$J,"MDR",0)=^TMP("PS",$J,"MDR",0)+1
 S PSOELSE=0 I '$P(^PSRX(IFN,"SIG"),"^",2) S PSOELSE=1 S X=$P(^PSRX(IFN,"SIG"),"^") D SIG
 I '$G(PSOELSE) S ITFN=1 D
 .S ^TMP("PS",$J,"SIG",ITFN,0)=$G(^PSRX(IFN,"SIG1",1,0)),^TMP("PS",$J,"SIG",0)=+$G(^TMP("PS",$J,"SIG",0))+1
 .F I=1:0 S I=$O(^PSRX(IFN,"SIG1",I)) Q:'I  S ITFN=ITFN+1,^TMP("PS",$J,"SIG",ITFN,0)=^PSRX(IFN,"SIG1",I,0),^TMP("PS",$J,"SIG",0)=+$G(^TMP("PS",$J,"SIG",0))+1
 K PSOELSE
 S ^TMP("PS",$J,"PC",0)=0,ITFN=0
 F I=0:0 S I=$O(^PSRX(IFN,"PRC",I)) Q:'I  S ITFN=ITFN+1,^TMP("PS",$J,"PC",ITFN,0)=^PSRX(IFN,"PRC",I,0),^TMP("PS",$J,"PC",0)=^TMP("PS",$J,"PC",0)+1
 Q
PEN Q:'$D(^PS(52.41,IFN,0))!($P($G(^PS(52.41,IFN,0)),"^",3)="RF")  S PSOR=^PS(52.41,IFN,0)
 S ^TMP("PS",$J,0)=$S($P(PSOR,"^",9):$P($G(^PSDRUG($P(PSOR,"^",9),0)),"^"),1:$P(^PS(50.7,$P(PSOR,"^",8),0),"^")_" "_$P(^PS(50.606,$P(^PS(50.7,$P(PSOR,"^",8),0),"^",2),0),"^"))
 I $P(PSOR,"^",9) D
 .S ^TMP("PS",$J,"DD",0)=1
 .S COD=$S('$G(^PSDRUG($P(PSOR,"^",9),"I")):1,+$G(^PSDRUG($P(PSOR,"^",9),"I"))>DT:1,1:0)
 .S ^TMP("PS",$J,"DD",1,0)=$P(PSOR,"^",9)_"^^"_$S($P($G(^PSDRUG($P(PSOR,"^",9),2)),"^",3)["U"&(COD):$P(PSOR,"^",9),1:"") K COD
 S ^TMP("PS",$J,0)=^TMP("PS",$J,0)_"^"_$S($G(^PS(51.2,+$P(PSOR,"^",15),0))]"":$P(^PS(51.2,+$P(PSOR,"^",15),0),"^",3),1:"")_"^^"_$P(PSOR,"^",11)_"^"_$P($P(PSOR,"^",6),".")_"^"_$S($P(PSOR,"^",3)'="HD":"PENDING",1:" ON HOLD")_"^^"_$P(PSOR,"^",10)
 S SD=0 F SCH=0:0 S SCH=$O(^PS(52.41,IFN,1,SCH)) Q:'SCH  S SD=SD+1,^TMP("PS",$J,"SCH",SD,0)=$P(^PS(52.41,IFN,1,SCH,1),"^"),^TMP("PS",$J,"SCH",0)=SD
 S SD=0 F SCH=0:0 S SCH=$O(^PS(52.41,IFN,"SIG",SCH)) Q:'SCH  S SD=SD+1,^TMP("PS",$J,"SIG",SD,0)=$P(^PS(52.41,IFN,"SIG",SCH,0),"^"),^TMP("PS",$J,"SIG",0)=SD
 S (IEN,SD)=1,INST=0 F  S INST=$O(^PS(52.41,IFN,2,INST)) Q:'INST  S (MIG,INST(INST))=^PS(52.41,IFN,2,INST,0),^TMP("PS",$J,"SIO",0)=SD D
 .F SG=1:1:$L(MIG," ") S:$L($G(^TMP("PS",$J,"SIO",SD,0))_" "_$P(MIG," ",SG))>80 SD=SD+1,^TMP("PS",$J,"SIO",0)=SD S ^TMP("PS",$J,"SIO",SD,0)=$G(^TMP("PS",$J,"SIO",SD,0))_" "_$P(MIG," ",SG)
END K FL,SD,SCH,%T,Y,ST,ST0,PSBDT,PSEDT,IFN,EXDT,RX0,RX2,RX3,TRM,I,X,Z1,Z0,PSOX1,PSOX2,PSOR,STA,TFN,X1,X2,SC,MDR,MR,IFN,MIG,INST
 K BDT,DFN,EDT,IEN,ITFN,RXNUM
 Q
SIG ;expands SIG expanded list
 F Z0=1:1:$L(X," ") G:Z0="" EN S Z1=$P(X," ",Z0) D
 .D:$D(X)&($G(Z1)]"")
 ..S Y=$O(^PS(51,"B",Z1,0)) Q:'Y!($P($G(^PS(51,+Y,0)),"^",4)>1)  S Z1=$P(^PS(51,Y,0),"^",2) Q:'$D(^(9))  S Y=$P(X," ",Z0-1),Y=$E(Y,$L(Y)) S:Y>1 Z1=^(9)
 .I $G(^TMP("PS",$J,"SIG",1,0))']"" S ^TMP("PS",$J,"SIG",1,0)=Z1,^TMP("PS",$J,"SIG",0)=1 Q
 .F PSOX1=0:0 S PSOX1=$O(^TMP("PS",$J,"SIG",PSOX1)) Q:'PSOX1  S PSOX2=PSOX1
 .I $L(^TMP("PS",$J,"SIG",PSOX2,0))+$L(Z1)<245 S ^TMP("PS",$J,"SIG",PSOX2,0)=^TMP("PS",$J,"SIG",PSOX2,0)_" "_Z1
 .E  S PSOX2=PSOX2+1,^TMP("PS",$J,"SIG",PSOX2,0)=Z1
EN K Z1,Z0,PSOX1 Q
SIG1 ;expands SIG for condensed list
 F Z0=1:1:$L(X," ") G:Z0="" EN S Z1=$P(X," ",Z0) D
 .D:$D(X)&($G(Z1)]"")
 ..S Y=$O(^PS(51,"B",Z1,0)) Q:'Y!($P($G(^PS(51,+Y,0)),"^",4)>1)  S Z1=$P(^PS(51,Y,0),"^",2) Q:'$D(^(9))  S Y=$P(X," ",Z0-1),Y=$E(Y,$L(Y)) S:Y>1 Z1=^(9)
 .I $G(^TMP("PS",$J,TFN,"SIG",1,0))']"" S ^TMP("PS",$J,TFN,"SIG",1,0)=Z1,^TMP("PS",$J,TFN,"SIG",0)=1 Q
 .F PSOX1=0:0 S PSOX1=$O(^TMP("PS",$J,TFN,"SIG",PSOX1)) Q:'PSOX1  S PSOX2=PSOX1
 .I $L(^TMP("PS",$J,TFN,"SIG",PSOX2,0))+$L(Z1)<245 S ^TMP("PS",$J,TFN,"SIG",PSOX2,0)=^TMP("PS",$J,TFN,"SIG",PSOX2,0)_" "_Z1
 .E  S PSOX2=PSOX2+1,^TMP("PS",$J,TFN,"SIG",PSOX2,0)=Z1
 Q
