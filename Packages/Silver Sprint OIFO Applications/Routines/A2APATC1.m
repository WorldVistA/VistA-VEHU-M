A2APATC1 ;WASH/PEH - CHECK PATCHED ROUTINES (CON'T) ;2/8/02  11:41
 ;;1.0;VERHLP;;
 ;
5 ;Start report
 S ST=0,PG=1,U="^" D NOW^%DTC S Y=% D DD S %DT=Y
 X ^%ZOSF("UCI") S %DT=Y_"  "_%DT
 S RUN=$S(SEL="A":"EVERY PACKAGE (CURRENT VERSIONS)",SEL="P":PACK1,1:"SELECTED ROUTINES   V"_VER),Y=$P(^A2AP(1200035,0),"^",5) X ^DD("DD") S LCD=Y
 S HDR="!,%DT,?45,HEAD,!!,""PATCH FINDINGS LISTING (CHECKING: "",RUN,"")"",!!,""Routine"",?15,""Findings"",!,""----------"",?15,""----------------------------------------------------------"",!"
 S IOC=(IO=IO(0))
 U IO W:$Y>3 @IOF W @HDR I 'IOC U IO(0) W !!
 S (PAC,PACKAGE,RN)="",%Y=IOSL-(255\IOM+1) K %D,%T,%TIM
 F I=1:1 S X=$T(EXEC+I) Q:X=""  S Y=$P(X," "),@Y=$P(X,";",3,99)
 S X="ERR^A2APATC1",@^%ZOSF("TRAP"),(NPAT2,NPAT1)=0
 ;
X ;GET ROUTINE, LOAD IT, CHECK IT
 X $S(SEL="R":"F  S RN=$O(^UTILITY($J,RN)) Q:RN=""""  S X=RN X ^%ZOSF(""TEST"") I $T ZL @RN X %Z1,%Z2",1:"F  S PAC=$O(^TMP($J,PAC)) Q:PAC=""""  F  S RN=$O(^TMP($J,PAC,RN)) Q:RN=""""  S X=RN X ^%ZOSF(""TEST"") I $T ZL @RN X %Z1,%Z2")
 U IO W:SEL'="R"&(NPAT2<1)&(FORM="S") "Package Fully Patched" W !!,"<DONE>" Q
 ;
DD S:Y Y=$S($E(Y,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".")
 Q
 ;
CHK ;This codes checks the installed patches
 N Q1,LVER,PATCH,PATCH1,NPAT,CHK,PAT,I,IPAT
 S VER1=$TR(VER1,"ABCDEFGHIJKLMNOPQRSTUWXYZabcdefghijklmnopqrstuvwxyz #/\()") S:$E(VER1,1)="V" VER1=$E(VER1,2,99)
 S PATCHES=$TR(PATCHES,"* "),PATCHES=$TR(PATCHES,";",","),NPAT1=0
 I $D(PATCHES) F I=2:1 S IPAT=$P(PATCHES,",",I) Q:IPAT=""!(IPAT?1A.E)  S PATCH1(IPAT)=""
 I $D(^A2AP(1200035,"PATCHED",RN,VER)),+VER=+VER1 D  ;
 .I SEL="A",PACK1'=PACKAGE D PAC I $D(Q1) S (NPAT1,NPAT2)=2 ;Q
 .I $S(SEL="P":1,SEL="A":1,1:0) D PAC1 I $D(Q1) S (NPAT1,NPAT2)=2 Q
 .S PAT=0 F  S PAT=$O(^A2AP(1200035,"PATCHED",RN,VER,PAT)) Q:'PAT  S PATCH(PAT)="" K PATCH1(PAT)
 .S CHK=0 F  S CHK=$O(PATCH(CHK)) Q:CHK=""  K:PATCHES[(","_CHK_",") PATCH(CHK),PATCH1(CHK)
 .S (NPAT,CHK)=0 F  S CHK=$O(PATCH(CHK)) Q:CHK=""  S NPAT=NPAT+1,NPAT(RN,NPAT)=" Patch Number "_CHK_" is not installed" I $O(PATCH(CHK))!($O(PATCH1(""))]"")
 .S CHK=0 F  S CHK=$O(PATCH1(CHK)) Q:CHK=""  D
 ..S:CHK'?1N.N NPAT=NPAT+1,NPAT(RN,NPAT)=" * This routines second line is not in the correct format *"
 ..Q
 .I $D(NPAT),+NPAT>0 S NPAT2=2 W !,?5,RN,?15,"DATA: ",RTN,!,?15 S NPAT=0 F  S NPAT=$O(NPAT(RN,NPAT)) Q:NPAT=""  S NPAT1=1 W $G(NPAT(RN,NPAT)) W:$O(NPAT(RN,NPAT)) !,?15
 .I FORM="L",$D(NPAT),NPAT1<1 W !,?5,RN,?15," Fully patched"
 Q
 ;
ERR ;This is the Write Line for routines whose source codes has been deleted
 W !,?5,RN,?15," Cannot check routine, Source code has been deleted." G X
 Q
 ;
PAC ;Display package and version
 I SEL="A",$D(PACKAGE),PACKAGE'="",$D(NPAT1),NPAT2<1 W !,?5,"Package Fully Patched"
 N DIC,X S (NPAT1,NPAT2)=0
 S DIC="^DIC(1200036,",X=PACK1,DIC(0)="MZ",D="C" D IX^DIC
 I Y<0 W !!,"UNABLE TO DETERMINE PACKAGE",! G PACQ
 W !!,$P(Y(0),"^",1),"  V",$P(Y(0),"^",2),"  (",$P(Y(0),"^",3),")",!
 Q
PAC1 ;
 S Q2="" I +VER'=+VER1 D
 .I VER1>VER W !,?5,RN,?15,"Has the version as '"_+VER1
 .I VER>VER1 W !,?5,RN,?15,"Has not the correct version"
 .W !,?5,RN,?15,"Has not the correct version",!,?15,RTN
 ;.I VER>VER1 W !,?5,RN,?15,"Has '"_VER1_"'  as version in the second line"
 .S Q1=1 Q
PACQ S PACKAGE=PACK1
 Q
EXEC ;These lines produce the report output (header,text,form feeds, etc.)
%Z1 ;;U IO I $Y+4'<IOSL&($Y>3) S PG=PG+1,ST=0 X:(PG>1)&(IOST["C-")&IOC %Z3 Q:ST  W @IOF W ?70,"Page ",PG,!,@HDR
%Z2 ;;Q:+ST=1  S:SEL="A" VER=$G(^TMP($J,PAC,RN)),PACK1=$P(VER,"^",2),VER=+VER N VER1,PATCHES,P1 S RTN=$T(+2),P1=$P(RTN,"**",2) S:P1="" P1=$P(RTN,"*",2) S:P1="" P1=$P(RTN,";",5) S VER1=$P(RTN,";",3),PATCHES=","_P1_"," D CHK^A2APATC1
%Z3 ;;R !,"Press RETURN to continue or '^' to exit: ",ST S ST=$S(ST["^":1,1:0) S:ST (I,LC)=9999,(PAC,RN)="zzzzzz",X=""
