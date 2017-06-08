DGPM5MV0 ;ALB/MRL/MIR - MOVEMENT OF DATA OPTIONS ENTRY; 11 JAN 89
 ;;MAS VERSION 5.0;
VAR K ^DG5(1,"STOP")
VAROTF S (DGSTOP,ERR)=0 ;don't kill STOP parameter if on the fly - from DGPMV
 D TP:'$D(^DG(405.1,"AM",20)) Q:ERR  D DON1^DGPM5M0,KG^DGPM5MV S (DGPMCT,DGPMTC,DGPMPC)=0 F I="ADN","DIS","XFR","TSC" S @I=$P($T(@(I)),";;",2) S:I'="TSC" DGPMT(I)=""
 S I=0 F I1=0:0 S I=$O(^DG5(1,"ME",I)) Q:I'>0  S X=^(I,0),X2=+$P(X,"^",2),X1=$P(X,"^",1),X3=$S(X1[42.1:"ADN",X1[42.2:"DIS",X1[42.3:"XFR",1:"") I X3]"" S $P(DGPMT(X3),"^",+X)=X2
 S X=$S($D(^DG5(1,"P")):^("P"),1:""),DGPMP("I")=+X,DGPMP("A")=+$P(X,"^",2),DGPMP("D")=+$P(X,"^",3) D NOW^%DTC S DGPMP("N")=%
 S C=0 F I=.01:.01:.24,11500.01:.01:11500.07 S C=C+1 I $D(^DD(405,I,0)) S (J,C1)=0 D XREF
 S X1=DT,X2=1 D C^%DTC S VATD=9999999.9999999-(DT+.0000001),(VACN,VAPRC)=1,VAPRT=0
 S TSCN=$O(^DG(405.1,"AM",20,0)) S:TSCN'>0 ERR=1 K C,C1,I,I1,J,J1,X,X1,X2,X3
 Q:'DGPME  ;if on the fly conversion (from DGPMV)
 S X=$S($D(^DG5(1,"LST")):^("LST"),1:"") I +X=DGPME,($P(X,"^",2)=DGPME) S ERR=1 W !,"You have already completed this step!" Q
 K DFN,W I +X=DGPME S DFN=$P(X,"^",3) I DGPME=3 S W=$P(X,"^",4) I W]"" S W=$E(W,1,$L(W)-1)
 S:'ERR $P(^DG5(1,"LST"),"^")=+DGPME S:'$D(DFN) DFN=0 S:'$D(W)#2 W=0 Q
 ;
TP W !?4,"There is no movement in the FACILITY MOVEMENT TYPE file (#405.1) which",!?4,"points to entry #20, PROVIDER/SPECIALTY CHANGE, in the MAS MOVEMENT TYPE"
 W !?4,"file (#405.2).  In order to successfully convert entries which are stored",!?4,"in the ""old"" structure as a TREATING SPECIALTY CHANGE without a"
 W !?4,"corresponding TRANSFER DATE this pointer relationship must exist.  So you",!?4,"don't have to ""re-do"" all of the above steps leave this process now"
 W !?4,"and, using VA FileManager, add a non-movement entry to your file #405.1",!?4,"which will point to entry #20 in the MAS MOVEMENT TYPE file.  You can",!?4,"then proceed with this conversion process."
 S DA(1)=1,DA=+DGPME,DIK="^DG5(1,""SC""," D ^DIK K DIK,DA S ERR=1 Q
 ;
XREF F J1=0:0 S J=$O(^DD(405,I,1,J)) Q:J'>0  I $D(^(J,1)) S X=^(1) I $S(X["DGPMGLC":0,^(0)["TRIGGER":0,X["DGPMDDCN":0,X["A1B2XFR":0,I=.01:1,X["S DGPMDDF=":0,1:1) S C1=C1+1,^UTILITY("DGPMXF",$J,C,C1)=X
 ;C=1-24 for fields .01-.24
 ;C=25-31 for fields 11500.01-11500.07 (ODS fields)
 Q
 ;
ADN ;;0;1^^^0;2^0;3^0;4^0;10^^^0;6^0;5^4;1^^^^0;12
XFR ;;0;1^^^0;2^0;11^0;4^0;10^0;7^0;9^0;6^^^0;5^^0;12
TSC ;;0;1^^^^^^^0;3^0;2
DIS ;;1;1^^^1;2^1;3^^^^^^^^^^^^^^^^^1;6
