SD116E ;ALB/SWO ENVIRONMENT CHECK FOR SD*5.3*116;5.4.97
 ;;5.3;SCHEDULING;**116**;8.13.93
 ;
EN ;ENTRY
 N ROU,TEST,VER,X,ZAP,P32
 S ROU="SDCNP" D CHK
 I $G(ZAP)=1 S XPDABORT=2 W !,"***SD*5.3*116 ABORTED***",! Q
 W !,"***Environment is fine***",!
 Q
CHK ;CHECK FOR PATCH 32 AND VERSION 5.3
 S X="S TEST=$T(+2^"_ROU_")" X X
 S VER=$P(TEST,";",3),P32=$P(TEST,";",5)
 I VER'=5.3 W !,"This is not the current release version!" S ZAP=1
 I P32'[32 W !,ROU," missing patch SD*5.3*32" S ZAP=1
