A1AVLABL ;ISC1/JSH - LABEL FOR PATCH BUCK SLIP ; 09 MAR 90
 ;;V1.0
EN S IOP="HOME;80;99999999" D ^%ZIS K IOP
 W !,"Run test label " S %=1 D YN^DICN Q:"12"'[%  I %=1 D TEST
 R !,"How many labels? ",Y S Y=+Y
 W !,"Hit <cr> when aux port is turned on." R X
LOOP ;W "Patch:____*____*____  Date:__/__/__"
 ;W !,"Verifier:________ Reviewer:________"
 W !,"--------------------------------"
 W !,"SUP,DDD:________TST,DDD:________"
 W !,"SUP,VSA:________TST,VSA:________"
 ;W !," REV,CCC:__/__/__  PRV,CCC:__/__/__"
 W !,"MGR,DDD:________MGR,VSA:________"
 ;W !," KNL,TRI:__/__/__  KNL,VVA:__/__/__"
 W !,"--------------------------------"
 ;W !," VIR,TRI:__/__/__  UTL,TRI:__/__/__"
 ;W !," MGR,TRI:__/__/__  MGR,VVA:__/__/__"
 ;W !," DEV,VAA:__/__/__  MGR,VAA:__/__/__"
 S Y=Y-1 W ! I Y>0 G LOOP
 W *7 R X Q
TEST W !,"Hit <cr> when aux port is turned on." R X
 F I=1:1:10 X "F K=1:1:3 F J=1:1:9,0 W J" W !
 Q
