PSUB ;BHM ISC/DEB - D&PPM Collection routine ;4NOV91
 ;;1.0; D&PPM ;;11 May 94
 K ^TMP($J) I $D(PSUDT1),'$D(PSUHOW) D IV G Q:$D(PSUER) D UD G Q:$D(PSUER) D WS G Q:$D(PSUER) D OP G Q
 I $D(PSUHOW) S X=$S(PSUHOW=1:"IV",PSUHOW=2:"UD",PSUHOW=3:"WS",PSUHOW=4:"OP",1:"Q") D @X G Q
 S (PSUXM2,PSUXM3)=1 ;Variables to send messages to HINES and locals
 ;
 ;Executing monthly/automatic collection
 ;
DATES I '$D(DT) D NOW^%DTC S X=$P(%,".")
 S PSUDT=$S('$D(DT):X,1:DT),PSUDT=($E(PSUDT,1,5)-1)
 I $E(PSUDT,4,5)="00" S PSUDT=$E(PSUDT,1)_($E(PSUDT,2,3)-1)_"12"
 S PSUDT1=PSUDT_"01"
 S PSUDT2=PSUDT_$S($E(PSUDT,4,5)="02":"29",$E(PSUDT,4,5)="04":"30",$E(PSUDT,4,5)="06":"30",$E(PSUDT,4,5)="09":"30",$E(PSUDT,4,5)="11":"30",1:31)
 S X=PSUDT1 D DATE^PSUA S PSUMON1=Y ;Formatted beginning data
 S X=PSUDT2 D DATE^PSUA S PSUMON2=Y ;Formatted ending date
 ;
 D IV G Q:$D(PSUER) D UD G Q:$D(PSUER) D WS G Q:$D(PSUER) D OP G Q
RECPT ;Recipients of data report
 ;
IV ;Gather IV statistics
 D QQ,SNDR,^PSUVI S XMSUB="IV" I $D(PSURPT) D IV^PSUC Q
 I '$D(^TMP($J,"IV")) D NODATA Q
 ;
 K CNT,X1
 ;Convert IV data for shipment
IV1 S X1=$S('$D(X1):$O(^TMP($J,"IV",0)),1:$O(^TMP($J,"IV",X1))) G DONEIV:X1="" F X=1:1:6 S DATA(X)=$P(^TMP($J,"IV",X1),U,X)
 S X=DATA(5),PSUL=65 D PAD S VPN=$E(X,1,65)
 S X=DATA(6),PSUL=5 D PAD S VCL=$E(X,1,5)
 S X=$P(X1,"\",1),PSUL=40 D PAD S DATA(7)=$E(X,1,40) ;Drug name
 S X=$P(X1,"\",2),PSUL=6 D PAD S DATA(8)=$E(X,1,6)
 F X=1:1:4 S DATA(X)=$J(DATA(X),14,2)
 S CNT=$G(CNT)+1,^TMP($J,CNT,0)=PSUSNDR_VPN_VCL_DATA(7)_DATA(8)_DATA(1)_DATA(2)_DATA(3)_DATA(4) K DATA
 G IV1
 ;
DONEIV K ^TMP($J,"IV") D SEND Q
 ;
UD ;Gather Unit Dose Data
 D QQ,SNDR,^PSUUD S XMSUB="Unit Dose"
 I $D(PSURPT) D UD^PSUC Q
 I '$D(^TMP($J,"UD")) D NODATA Q
 K PSU,CNT
UD1 S PSU=$S('$D(PSU):$O(^TMP($J,"UD",0)),1:$O(^TMP($J,"UD",PSU))) G UD2:PSU="" S X=$P(^TMP($J,"UD",PSU,0),U,1),PSUL=40 D PAD S PSU(1)=$E(X,1,40)
 F X=2:1:5 S PSU(X)=$S($P(^TMP($J,"UD",PSU,0),U,X)="":0,1:$P(^TMP($J,"UD",PSU,0),U,X)),PSU(X)=$J(PSU(X),14,2)
 ;
 S X=$P(^TMP($J,"UD",PSU,0),U,6),PSUL=65 D PAD S VPN=$E(X,1,65)
 S X=$P(^TMP($J,"UD",PSU,0),U,7),PSUL=5 D PAD S VCL=$E(X,1,5)
 S CNT=$G(CNT)+1,^TMP($J,CNT,0)=PSUSNDR_VPN_VCL_PSU(1)_PSU(2)_PSU(3)_PSU(4)_PSU(5) G UD1
 ;
UD2 K ^TMP($J,"UD") D SEND
 Q
 ;
WS ;Ward Stock/Automatic Replenishment
 D QQ,SNDR,^PSUWS S XMSUB="AR/WS"
 ;
 K PSU,PSU1,PSU2,PSU3,PSU4,PSU5,PSU31,PSU41,PSU6,PSU7,PSU8,PSU9,PSU10
WS1 ;Compile TMP for Mail message
 S PSU=$S('$D(PSU):$O(^TMP($J,"WS",0)),1:$O(^TMP($J,"WS",PSU))) G WS2:PSU="" K PSU1
 S PSU1=$O(^TMP($J,"WS",PSU,0)) I PSU1="" G WS1
 S PSU5=$S('$D(^PSDRUG(PSU1,"PSG")):0,1:$P(^PSDRUG(PSU1,"PSG"),U,2)),PSU5=$S(PSU5=0:"03 or 04",PSU5=1:"06 or 07",PSU5=2:"17      ",PSU5=3:"22      ",1:"O3 or 04")
 I $D(PSURPT) G RPT
 ;
 S X=$P(^TMP($J,"WS",PSU,PSU1),U,5),PSUL=65 D PAD S VPN=$E(X,1,65)
 S X=$P(^TMP($J,"WS",PSU,PSU1),U,6),PSUL=5 D PAD S VCL=X
 ;
 F X=1:1:4 S PSU(X)=$S($P(^TMP($J,"WS",PSU,PSU1),U,X)="":0,1:$P(^TMP($J,"WS",PSU,PSU1),U,X)),PSU(X)=$J(PSU(X),14,2)
 S X=PSU,PSUL=40 D PAD S PSU=$E(X,1,40)
 ;
 S CNT=$G(CNT)+1,^TMP($J,CNT,0)=PSUSNDR_VPN_VCL_PSU_PSU(1)_PSU(2)_PSU(3)_PSU(4)_PSU5 G WS1
 ;
WS2 I $D(PSURPT) D WS^PSUC Q
 I '$D(^TMP($J)) D NODATA Q
 K ^TMP($J,"WS") D SEND
 Q
 ;
OP ;Outpatient data
 D QQ,SNDR S PSUDT=$E(PSUDT1,1,5)_"00" D ^PSUOP S XMSUB="Outpatient"
 I $D(PSURPT) D OP^PSUC Q
 I '$D(^TMP($J)) D NODATA Q
 D SEND Q
NODATA ;No data to report for specified search
 D SNDR S ^TMP($J,1,0)=PSUSNDR_"  No "_XMSUB_" statistics found for "_PSUMON1_" to "_PSUMON2
SEND I $D(PSUXM1) S XMY(PSUXM1)=""
 I $D(PSUXM3) D DPPM
 I $D(PSUXM2) S XMY("G.PSU DPPM@HINES.VA.GOV")=""
 ;
 S XMTEXT="^TMP($J,",XMSUB=XMSUB_" statistics for "_PSUSNDR(1)_" for "_PSUMON1_" to "_PSUMON2,XMDUZ=PSUSNDR(1)
 D ^XMD K XMDUZ,^TMP($J) Q
 ;
QQ ;Kill variables
 K CNT,PSUL,PSU,PSU1,PSU10,PSU2,PSU3,PSU31,PSU4,PSU41,PSU42,PSU5,PSU6,PSU7,PSU8,PSU9,PSUD,PSUD1,PSUDTA,X,XX,XXX,XXXX,Y,YY,XMDUZ Q
PAD ;Pad with spaces
 F YY=$L(X):1:(PSUL-1) S X=X_" "
 Q
RPT ;Formulate AR/WS report
 F X=1:1:4 S PSU(X)=$S($P(^TMP($J,"WS",PSU,PSU1),U,X)="":0,1:$P(^TMP($J,"WS",PSU,PSU1),U,X))
 S X=PSU(2) D RND S PSU(2)=$S('$D(XXXX):X,1:XXXX)
 K XXXX S X=PSU(4) D RND S PSU(4)=$S('$D(XXXX):X,1:XXXX)
 S CNT=$G(CNT)+1,^TMP($J,CNT,0)=PSU_U_PSU(1)_U_PSU(2)_U_PSU(3)_U_PSU(4)_U_PSU5 G WS1
RND Q:X'?.E1".".N  K XX,XXXX,XXX S XX=$P(X,".",2) Q:$L(XX)'>2  S XX=$E(XX,1,2),XXX=$E($P(X,".",2),3),XXXX=$S($P(X,".",1)="":"."_XX,1:$P(X,".",1)_"."_XX) I XXX>4 S X=XXXX+.01 Q
 Q
Q K XMTEXT,VPN,PSUL,VCL,XMY G Q^PSUA
SNDR ;Figure who is sending the data and the dates
 S PSUSNDR=$O(^QIP(738,0)),PSUSNDR(1)=$P(^QIP(736,PSUSNDR,0),U,1)
 S PSUSNDR=PSUSNDR_$S($L(PSUSNDR)=1:"  ",$L(PSUSNDR)=2:" ",1:"")_$E(PSUDT1,1,5) Q
 ;
DPPM Q:'$D(^XMB(3.8,"B","PSU DPPM"))  S X=$O(^XMB(3.8,"B","PSU DPPM",0)) F XX=0:0 S XX=$O(^XMB(3.8,X,1,"B",XX)) Q:XX'>0  S XMY(XX)=""
 Q
