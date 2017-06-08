TIMEX2 ;557/THM-AUTOMATIC TIME CHANGE FOR SPRING AND FALL [ 03/22/95  8:35 AM ]
 ;;3.5;AHJ;;Nov 08, 1993
 ;
EN S U="^" I $D(DT)#2=0 S X="T" D ^%DT S DT=Y
 I ^%ZOSF("OS")'["MSM-PC" Q  ;only MSM systems
 X ^%ZOSF("UCI") S VOL=$P(Y,",",2)
 ;         
APRIL K SYS D CIR I $E(DT,4,7)>"0408" G OCTOBER
 G:'$D(SYS) EXIT ;nothing on-line
 ;calculate first Sunday in April
 F ZX=1:1:8 S X=$E(DT,1,3)_"040"_ZX D DW^%DTC Q:X="SUNDAY"
 S TIME="033000",DATE="040"_ZX_$E(DT,2,3) D TASK S TMP($J,3,0)="  April - "_$E(DATE,1,2)_"/"_$E(DATE,3,4)_"/"_$E(DATE,5,6)_" at 02:30 - new time: "_$E(TIME,1,2)_":"_$E(TIME,3,4)_"  (task # "_ZTSK_")"
 D TASK1
 ;
OCTOBER I $E(DT,4,7)>"1022" G EXIT
 G:'$D(SYS) EXIT ;nothing on-line
 ;calculate last Sunday in October
 F ZX=31:-1:22 S X=$E(DT,1,3)_"10"_ZX D DW^%DTC Q:X="SUNDAY"
 S TIME="013000",DATE="10"_ZX_$E(DT,2,3) D TASK S TMP($J,5,0)="October - "_$E(DATE,1,2)_"/"_$E(DATE,3,4)_"/"_$E(DATE,5,6)_" at 02:30 - new time: "_$E(TIME,1,2)_":"_$E(TIME,3,4)_"  (task # "_ZTSK_")"
 D MSG,TASK1
 ;
EXIT K %DT,%H,%T,CIR,DATE,DIC,JI,I,MG,SYS,TIME,TMP,VOL,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,ZDATE,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,Y,ZTSK,ZX,L,ZTUCI
 Q
 ;
MSG ;send scheduling confirmation message
 K XMDUZ N DUZ
 S DUZ=.5,XMSUB="Daylight Savings Time Set",XMTEXT="TMP($J,",TMP($J,1,0)="Daylight Savings Time has been scheduled for:",TMP($J,2,0)=""
 ;
 ;** receiving mail group goes here **
 ;** change AHJZ TIME CHANGE to a local mail group, if desired **
 S DIC="^XMB(3.8,",DIC(0)="M",X="AHJZ TIME CHANGE" D ^DIC S MG=+Y
 S XMY(.5)="" ;send to Postmaster for 'failsafe'
 F JI=0:0 S JI=$O(^XMB(3.8,MG,1,"B",JI)) Q:JI=""  S XMY(JI)=""
 S TMP($J,4,0)=" " D ^XMD
 Q
 ;
CIR ;see what nodes are on line
 S CIR=$V($V(29,-5)+12,-3,0) F I=1:1 S X=$V(CIR+46,-3,2) S X=$C(X\2048+64,X\64#32+64,X\2#32+64),SYS(X)=X S CIR=$V(CIR,-3,0) Q:'CIR
 ;kill nodes on non-MSM or incompatible systems on-line
 K SYS("GSA") ;TCP/IP not needed
 K SYS("VAA") ;VAX not needed
 Q
 ;
TASK ;run time change at 2:30 am
 S ZTUCI="MGR",ZTRTN="ZTSK^TIMEX",ZTIO="",ZTDESC="Yearly Time Change for all MSM Systems" F I="DATE","TIME","SYS*","VOL" S ZTSAVE(I)=""
 S %DT="T",X=DATE_"@02:30" D ^%DT S X=Y D H^%DTC S ZTDTH=%H_","_%T
 D ^%ZTLOAD I '$D(ZTSK)  F I=1:1:6 K TMP(I) S TMP($J,1,0)="Scheduling for Daylight Savings Time has failed."
 Q
 ;
TASK1 ;queue new times verification message
 S ZTUCI="MGR",ZTRTN="MSG1^TIMEX2",ZTIO="",ZTDESC="Time Change Verification Message" F I="DATE","TIME","VOL" S ZTSAVE(I)=""
 S XTIME=$S(TIME="013000":"02:35",1:"03:35")
 S %DT="T",X=DATE_"@"_XTIME D ^%DT S X=Y D H^%DTC S ZTDTH=%H_","_%T
 D ^%ZTLOAD
 Q
 ;
MSG1 K SYS D CIR X ^%ZOSF("UCI")
 S ZZ="",HOMEUCI=$P(Y,",",1),HOMEVOL=$P(Y,",",2),JOB=$J
 S SYS(HOMEVOL)=HOMEVOL ;get this volume set too
 F X=0:0 S ZZ=$O(SYS(ZZ)) Q:ZZ=""  J 10^TIMEX1(HOMEUCI,HOMEVOL,JOB)["MGR",ZZ,ZZ]::10
 H 30 ;wait for all times to return
 S %DT="T",X="NOW" D ^%DT X ^DD("DD") S NOW=Y
 S TMP($J,1,0)="Here are the times that were on your systems on "_$P(NOW,"@",1)_" at "_$P(NOW,"@",2)_" :"
 S TMP($J,2,0)=" ",TMP($J,3,0)=" "
 S L=4,VOL=""  F ZI=0:0 S VOL=$O(^TMP("TIMEX1",$J,VOL)) Q:VOL=""!(VOL="ZZZ")  S TMP($J,L,0)="          "_VOL_" .......... "_^TMP("TIMEX1",$J,VOL),L=L+1
 K XMDUZ N DUZ S DUZ=.5
 S XMSUB="Time Change Verification",XMTEXT="TMP($J,"
 S XMY(.5)="" ;send to Postmaster for 'failsafe'
 ;** change AHJZ TIME CHANGE here also **
 S DIC="^XMB(3.8,",DIC(0)="M",X="K7 TESTING" D ^DIC S MG=+Y
 F JI=0:0 S JI=$O(^XMB(3.8,MG,1,"B",JI)) Q:JI=""  S XMY(JI)=""
 D ^XMD
 K ^TMP("TIMEX1",$J),TMP,XMSUB,XMTEXT,JI,XMY,XMDUZ,DIC,MG,X,Y,VOL,SYS,ZZ,ZI
 Q
