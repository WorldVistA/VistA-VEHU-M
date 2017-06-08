A4ECLK ;Patient Lookup CFB/MJP ;7/22/94;REVISED WITH NEW RTN NAME;10/27/94
 ;;1.2T4;A4EC;**1**;OCT 21, 1994
 ;D ^DPTLK
EN Q:$E($G(IOST))'="C"
 N A4F
 S A4F("RET")=0 Q:+Y'>0  S A4F(1)=+Y,A4F(1)=^DPT(A4F(1),0),A4F(1)=$P(A4F(1),"^",9) Q:A4F(1)=""  I '$D(^A4DM(14119,"B",A4F(1))),('$D(^A4DM(14119.1,"SSN",A4F(1)))) Q
 S A4F=$O(^A4DM(14119,"B",A4F(1),"")) G:A4F="" L
 I $D(^A4DM(14119,A4F,0))  S A4F("RET")=1,A4F=^(0) D
 .W !!,?20,"NATIONAL NOTICE",!!,"This SSN was presented at "_$P(A4F,"^",2)_" VAMCs in the last year."
 .Q:'($D(DUZ)#2)  Q:'$D(^VA(200,DUZ,0))  Q:'$D(^VA(200,"AK.A4ECLKUP",$P(^(0),"^"),DUZ))
 .S A4F(3)=$P(A4F,"^",3),A4F(4)=$P(A4F,"^",4)
 .S A4F(3)=$S(A4F(3)="":"",$D(^A4DM(14119.3,A4F(3),0)):$P(^(0),"^")_"   "_$P(^(0),"^",6),1:A4F(3))
 .S A4F(4)=$S(A4F(4)="":"",$D(^A4DM(14119.2,A4F(4),0)):$P(^(0),"^"),1:A4F(4))
 .W !,"Latest BDC ELIG:  ",A4F(3),!,"Latest RPM CLASS: ",A4F(4)
L G:'$D(^A4DM(14119.1,"SSN",A4F(1))) Q
 S A4F("RET")=1,A4F=$O(^A4DM(14119.1,"SSN",A4F(1),"")) D
 .W !!,?20,"LOCAL NOTICE",!!,"This patient has been flagged because",!
 .W !,$P(^A4DM(14119.1,A4F,0),"^",3)
 .Q:'($D(DUZ)#2)  Q:'$D(^VA(200,DUZ,0))  Q:'$D(^VA(200,"AK.A4ECLKUP",$P(^(0),"^"),DUZ))
 .W !,$P(^A4DM(14119.1,A4F,0),"^",4)
Q I A4F("RET") R !!,"Press RETURN to continue ",A4D(2):15
 Q
