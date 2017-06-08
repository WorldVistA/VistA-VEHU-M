LRBARA ;SLC/RAF ; 20 Jan 98  3:42 PM
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;This routine will program the Intermec 4100 for two label formats
 ;which can be used with LRLABELA routine to print one normal label
 ;and one with the accesion # barcoded if the BARCODE LABEL field in
 ;file 68 (Accession area) is set to YES
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
L1 W *2,"F3;H1;o150,390;f1;c2;h2;w1;d0,35;",*3 ;TEST
L2 W *2,"F3;H2;o133,350;f1;c2;h1;w1;d0,14;",*3 ;TOP/SPECIMEN
L3 W *2,"F3;H5;o175,418;f2;c2;h1;w1;d0,14;",*3 ;DATE
L4 W *2,"F3;H4;o160,450;f2;c2;h2;w1;d0,14;",*3 ;ACCESSION      
L5 W *2,"F3;H3;o116,350;f1;c2;h1;w1;d0,13;",*3 ;ORDER#
L6 W *2,"F3;H6;o30,350;f1;c2;h1;w1;d0,11;",*3 ;SSN
L7 W *2,"F3;H7;o30,150;f1;c2;h1;w1;d0,9;",*3 ;LOCATION
L8 W *2,"F3;H8;o0,350;f1;c2;h2;w1;d0,21;",*3 ;PT.NAME
L9 W *2,"F3;H9;o115,160;f1;c0;h3;w3;b1;d0,4;",*3 ;STAT
L10 W *2,"F3;B10;o50,350;f1;c0,1;h60;w2;d0,5;",*3 ;BAR CODE
 ;
PLAIN ;programs format F2 for plain label /no barcoded accession #
 W *2,*27,"C",*3
 W *2,*27,"P",*3
 W *2,"E2;F2;",*3
L11 W *2,"F2;H11;o150,450;f1;c2;h2;w1;d0,35;",*3 ;TEST
L12 W *2,"F2;H12;o133,450;f1;c2;h1;w1;d0,13;",*3 ;ORDER#
L13 W *2,"F2;H13;o133,200;f1;c2;h1;w1;d0,12",*3 ;LOCATION
L14 W *2,"F2;H14;o105,350;f1;c2;h1;w1;d0,11;",*3 ;SSN
L15 W *2,"F2;H15;o75,350;f1;c2;h2;w1;d0,21;",*3 ;PT.NAME
L16 W *2,"F2;H16;o50,450;f1;c2;h1;w1;d0,14;",*3 ;TOP/SPECIMEN
L17 W *2,"F2;H17;o33,450;f1;c2;h1;w1;d0,14;",*3 ;DATE
L18 W *2,"F2;H18;o0,450;f1;c2;h2;w1;d0,21;",*3 ;ACCESSION
L19 W *2,"F2;H19;o30,155;f1;c0;h3;w3;b1;d0,4;",*3 ;STAT
 ;
PRT ;programs the Intermec for print mode
 W *2,"R",*3
 D ^%ZISC Q
TEST ;sets variables used with the test labels
 S NUMBER="00087",LRAN="CH 1008 87",LRDAT="10/08/93 18:00" D
 .S LRTOP="MARBLED RED",PNM="YOKUM,HOKUM",SSN="123-45-6789"
 .S LRLLOC="SICU",LRCE="203987",LRTXT="CHEM 7",LRURG="STAT"
 .S LRACCAP="SURG 1008 999",LRSPEC="WOUND TISSUE"
F3 ;prints sample of label with accession # barcoded
 S X=0 X ^%ZOSF("RM") W *2,*27,"E3",*24,!,LRTXT,!,LRTOP,!,"Order#:",LRCE,!,LRAN,*3
 W *2,!,LRDAT,!,SSN,!,"W:",LRLLOC,*3
 W *2,!,PNM,*3
 W *2,! W:$D(LRURG)&(LRURG="STAT") LRURG W *3
 W *2,!,NUMBER,*3
 W *2,*23,*15,"S30",*3
 ;
F2 ;prints sample of label without a barcoded accession number
 S X=0 X ^%ZOSF("RM") W *2,*27,"E2",*24,!,LRTXT,!,"Order#:",LRCE,!,"W:",LRLLOC,!,SSN,!,PNM,!,LRTOP,*3
 W *2,!,LRDAT,!,LRAN,*3
 W *2,! W:$D(LRURG)&(LRURG="STAT") LRURG W *3
 W *2,*23,*15,"S30",*3
 Q
