%RDEL ; FDN ;UTILITY TO DELETE MULTIPLE ROUTINES; 9-FEB-81
 K ^UTILITY($J) W !,"Multiple Routine Delete",! D ^%RSEL  G:'$D(%GO) ENDX S RTN=-1,COL=0 W !!,"Routines to be deleted...",!!
SHOW S RTN=$N(^UTILITY($J,RTN)) G:RTN=-1 ASK W ?COL,RTN W:COL=70 ! S COL=COL+10#80 G SHOW
ASK R !!,"Are you sure (Y/N) ? ",YN I "YN"'[YN D IV G ASK
 G:YN'="Y" ENDX W !!
 ;
LOOP S RTN=$N(^UTILITY($J,RTN)) I RTN'=-1 X "ZR  ZS @RTN" W RTN," deleted",! G LOOP
ENDX K ^UTILITY($J),COL,RTN,YN Q
 ;
IV W !?5,"Enter 'Y' to delete routines shown, 'N' to exit with no deletion." Q
Z P %RDEL ZS %RDEL Q
