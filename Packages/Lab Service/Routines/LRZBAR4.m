LRBAR4 ;ALB/MJB ;INTERMEC 4100 2x1 LABEL FORMAT 8/29/94  12:36 [ 07/02/96  4:21 PM ]
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;This routine will program the Intermec 4100 for a 2x1 inch label
 ;which can be used with LRLZBELZ routine.
 ;This routine was written to use the universal ID number.
 ;There is no choice for this, the variable LRUID is defined
 ; and I just use that instead of LRACC.
 ;The code S X=0 X ^%ZOSF("RM") is used to replace U IO:0 which only
 ;works on an MSM system. This code will work with both DSM and MSM
 ;
ZIS K %ZIS S %ZIS="QN" D ^%ZIS I POP W !?7,*7,"NO DEVICE SELECTED ",! D ^%ZISC Q
 S ZTIO=ION,ZTDTH=$H,ZTDESC="BAR CODE FORMAT DOWN LOAD",ZTRTN="BAR^LRBAR4" D ^%ZTLOAD
 D ^%ZISC W !!?5,"Barcode Formating Program",$S($G(ZTSK):" Queued ",1:" NOT QUEUED"),!!
 D ^%ZISC K ZTSK Q
BAR ;programs format F3 for label with the accession # barcoded
 S:$D(ZTQUEUED) ZTREQ="@"
 S X=0 X ^%ZOSF("RM") W *2,*27,"C",*3
 W *2,*27,"P",*3
 W *2,"E3;F3;",*3
LABEL ;
 ; UNIVERSAL ID CODE
L1 W *2,"F3;B1;o175,70;f3;c0,1,h50;w2;d0,12;",*3 ;UID BAR CODED 
L2 W *2,"F3;H2;o117,70;f3;c2;h2;w1;d0,20;",*3 ;PT.NAME
L3 W *2,"F3;H3;o117,344;f3;c2;h1;w1;d0,11;",*3 ;SSN
L4 W *2,"F3;H4;o100,344;f3;c2;h1;w1;d0,9;",*3 ;LOCATION
L5 W *2,"F3;H5;o15,5;f0;c2;h2;w1;d0,14;",*3 ;ACCESSION 
L6 W *2,"F3;H6;o5,35;f0;c2;h1;w1;d0,14;",*3 ;DATE
L7 W *2,"F3;H7;o83,70;f3;c2;h1;w1;d0,13;",*3 ;ORDER#
L8 W *2,"F3;H8;o83,344;f3;c2;h1;w1;d0,14;",*3 ;TOP/SPECIMEN
L9 W *2,"F3;H9;o55,70;f3;c2;h1;w1;d0,14;",*3 ;PROVIDER
L10 W *2,"F3;H10;o55,344;f3;c0;h3;w3;b1;d0,4;",*3 ;STAT
L11 W *2,"F3;H11;o35,70;f3;c2;h2;w1;d0,35;",*3 ;TEST TEXT
 ;next line returns the Intermec to print mode
 W *2,"R",*3
 Q
