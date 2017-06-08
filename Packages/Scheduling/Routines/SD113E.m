SD113E ;ALB/SWO ENVIRONMENT CHECK FOR SD*5.3*113;5.14.97
 ;;5.3;SCHEDULING;**113**;8.13.93
 ;
EN ;ENTRY
 N ROU,TEST,VER,X,ZAP,P32
 S ROU="SDPPAT2" D CHK
 I $G(ZAP)=1 S XPDABORT=2 W !,"***SD*5.3*113 ABORTED***",! Q
 W !,"***Environment is fine***",!
 Q
CHK ;CHECK FOR PATCH 6 AND VERSION 5.3
 S X="S TEST=$T(+2^"_ROU_")" X X
 S VER=$P(TEST,";",3),P32=$P(TEST,";",5)
 I VER'=5.3 W !,"This is not the current release version!" S ZAP=1
 I P32'[6 W !,ROU," missing patch SD*5.3*6" S ZAP=1
