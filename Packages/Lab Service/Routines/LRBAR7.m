LRBAR7 ;SLC/RAF ;INTERMEC 4100 2x1 LABEL FORMAT 8/29/94  12:36 [ 06/25/96  10:32 AM ]
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;This routine will program the Intermec 4100 for a 2x1 inch label
 ;which can be used with LRLZBELZ routine.
 ;The code S X=0 X ^%ZOSF("RM") is used to replace U IO:0 which only
 ;works on an MSM system. This code will work with both DSM and MSM
 ;
ZIS K %ZIS S %ZIS="QN" D ^%ZIS I POP W !?7,*7,"NO DEVICE SELECTED ",! D ^%ZISC Q
 S ZTIO=ION,ZTDTH=$H,ZTDESC="BAR CODE FORMAT DOWN LOAD",ZTRTN="BAR^LRBAR7" D ^%ZTLOAD
 D ^%ZISC W !!?5,"Barcode Formating Program",$S($G(ZTSK):" Queued ",1:" NOT QUEUED"),!!
 D ^%ZISC K ZTSK Q
BAR ;programs format F3 for label with the accession # barcoded
 S:$D(ZTQUEUED) ZTREQ="@"
 S X=0 X ^%ZOSF("RM") W *2,*27,"C",*3
 W *2,*27,"P",*3
 W *2,"E3;F3;",*3
L1 W *2,"F3;H1;o150,390;f1;c2;h2;w1;d0,35;",*3 ;TEST TEXT
L2 W *2,"F3;H2;o133,350;f1;c2;h1;w1;d0,14;",*3 ;TOP/SPECIMEN
L3 W *2,"F3;H3;o116,350;f1;c2;h1;w1;d0,13;",*3 ;ORDER#
L4 W *2,"F3;H4;o160,450;f2;c2;h2;w1;d0,14;",*3 ;ACCESSION
L5 W *2,"F3;H5;o175,418;f2;c2;h1;w1;d0,14;",*3 ;DATE
L6 W *2,"F3;H6;o30,350;f1;c2;h1;w1;d0,11;",*3 ;SSN
L7 W *2,"F3;H7;o30,200;f1;c2;h1;w1;d0,9;",*3 ;LOCATION
L8 W *2,"F3;H8;o0,350;f1;c2;h2;w1;d0,21;",*3 ;PT.NAME
L9 W *2,"F3;H9;o115,160;f1;c0;h3;w3;b1;d0,4;",*3 ;STAT
L10 W *2,"F3;B10;o50,350;f1;c0,1;h60;w2;d0,5;",*3 ;BAR CODE
 ;next line returns the Intermec to print mode
 W *2,"R",*3
 Q
