SD106E ;ALB/SWO ENVIRONMENT CHECK FOR SD*5.3*106;5.4.97
 ;;5.3;SCHEDULING;**106**;8.13.93
 ;
EN ;ENTRY
 N ROU,TEST,VER,X,ZAP,P37
 F ROU="SDAL","SDAL0" D CHK
 I $G(ZAP)=1 S XPDABORT=2 W !,"***SD*5.3*106 ABORTED***",! Q
 W !,"***Environment is fine***",!
 Q
CHK ;CHECK FOR PATCHES 28,37 AND VERSION 5.3
 S X="S TEST=$T(+2^"_ROU_")" X X
 S VER=$P(TEST,";",3),P37=$P(TEST,";",5)
 I VER'=5.3 W !,"This is not the current release version!" S ZAP=1
 I P37'[37&(ROU="SDAL") W !,ROU," missing patch SD*5.3*37" S ZAP=1
 I P37'[28&(ROU="SDAL0") W !,ROU," missing patch SD*5.3*28" S ZAP=1
 I P37'[37&(ROU="SDAL0") W !,ROU," missing patch SD*5.3*37" S ZAP=1
 Q
