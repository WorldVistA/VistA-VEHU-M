LRBART ;SLC/JL/RAF ; INTERMEC 4100 10 PART LABEL FORMAT 8/29/94 12:36 [ 03/04/97  2:33 PM ]
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;This routine will program the Intermec 4100 for a 10 part 2.5X4.0 in
 ;label which can be used with LRLABELB routine to print a 10 part
 ;accession label which includes barcoded accession labels. The large
 ;labels are small enough to fit the small hematology tubes with the
 ;hemaguard
 ;The code S X=0 X ^%ZOSF("RM") is needed to replace U IO:0 which only
 ;works on an MSM system. This code will work with both DSM and MSM
 ;printer settings
 ;9600,7,PARITY EVEN - SW1-1   ON, SW2-1 ON
 ;4800,7,PARITY EVEN - SW1-2   ON, SW2-1 ON
 ;2400,7,PARITY EVEN - SW1-1,1 ON, SW2-1 ON
 ;1200,7,PARITY EVEN - SW1-3   ON, SW2-1 ON
ZIS S %ZIS="QN" D ^%ZIS I POP W ?20,*7,"NO DEVICE SELECTED " Q
 S ZTIO=ION,ZTDTH=$H,ZTDESC="BAR CODE FORMAT DOWN LOAD",ZTRTN="BAR^LRBAR6" D ^%ZTLOAD Q
BAR ;FORMAT BAR CODE LABELS
 S X=0 X ^%ZOSF("RM") W *2,*27,"P",*3 ;SET INTO PROGRAM MODE
 W *2,"E4;F4;",*3 ;ERASES FORMAT STORED IN FORMAT 3 AND ACCESSES FORMAT 4 
L0 W *2,"F4:H0;o0,166;f1;c2;h2;w1;d0,14;",*3 ;ACC#
L1 W *2,"F4:H1;o35,183;f1;c2;h1;w1;d0,14;",*3 ;DATE
L2 W *2,"F4:H2;o89,140;f0;c2;h1;w1;d0,14;",*3 ;TUBE
L3 W *2,"F4:H3;o89,1;f0;c2;h2;w1;d0,21;",*3 ;NAME
L4 W *2,"F4:H4;o89,37;f0;c2;h1;w1;d0,11;",*3 ;SSN
L5 W *2,"F4:H5;o260,37;f0;c2;h1;w1;d0,9;",*3 ;LOCATION
L6 W *2,"F4:B6;o93,59;f0;c0,1;h60;w2;d0,5;",*3 ;BARCODE
L7 W *2,"F4:H7;o89,125;f0;c2;h1;w1;d0,13;",*3 ;ORDER#
L8 W *2,"F4:H8;o89,157;f0;c2;h2;w1;d0,22;",*3 ;TESTS
L9 W *2,"F4:H9;o278,133;f0;c0;h2;w3;b1;d0,4;",*3 ;STAT
L10 W *2,"F4:H10;o6,219;f0;c2;h2;w1;d0,14;",*3 ;1-SMALL LABEL/ACC#
L11 W *2,"F4:H11;o6,267;f0;c2;h1;w1;d0,14;",*3 ;1-SMALL LABEL/TOP
L12 W *2,"F4:H12;o6,311;f0;c2;h2;w1;d0,14;",*3 ; 1-LL LABEL/ACC#
L13 W *2,"F4:H13;o6,345;f0;c2;h2;w1;d0,20;",*3 ;1-LL LABEL/NAME
L14 W *2,"F4:H14;o6,380;f0;c2;h1;w1;d0,11;",*3 ;1-LL LABEL/SSN
L15 W *2,"F4:H15;o6,406;f0;c2;h1;w1;d0,14;",*3 ;1-LL LABEL/DATE
L16 W *2,"F4:H16;o6,438;f0;c2;h2;w1;d0,13;",*3 ;1-LL LABEL/TEST
L17 W *2,"F4:H17;o202,219;f0;c2;h2;w1;d0,14;",*3 ;2-ML/ACC#
L18 W *2,"F4:H18;o202,267;f0;c2;h1;w1;d0,14;",*3 ;2-ML/TOP
L19 W *2,"F4:H19;o202,311;f0;c2;h2;w1;d0,14;",*3 ;2-LL LABEL ACC#
L20 W *2,"F4:H20;o202,345;f0;c2;h2;w1;d0,20;",*3 ;2-LL LABEL/NAME
L21 W *2,"F4:H21;o202,380;f0;c2;h1;w1;d0,11;",*3 ;2-LL LABEL/SSN
L22 W *2,"F4:H22;o202,406;f0;c2;h1;w1;d0,14;",*3 ;2-LL LABEL/DATE
L23 W *2,"F4:H23;o202,438;f0;c2;h2;w1;d0,13;",*3 ;2-LL LABEL/TEST
L24 W *2,"F4:H24;o390,1;f0;c2;h2;w1;d0,14;",*3 ;2-TR LABEL/ACC#
L25 W *2,"F4:H25;o390,35;f0;c2;h1;w1;d0,14;",*3 ;2-TR LABEL/DATE
L26 W *2,"F4:H26;o390,55;f0;c2;h1;w1;d0,30;",*3 ;2-TR LABEL/TUBE
L27 W *2,"F4:H27;o475,79;f0;c2;h2;w1;d0,21;",*3 ;2-TR LABEL/NAME
L28 W *2,"F4:H28;o475,110;f0;c2;h1;w1;d0,11;",*3 ;2-TR LABEL/SSN
L29 W *2,"F4:H29;o655,133;f0;c2;h1;w1;d0,9;",*3 ;2-TR LABEL/LOCATION
L30 W *2,"F4:H30;o390,133;f0;c2;h1;w1;d0,13;",*3 ;2-TR LABEL/OR#
L31 W *2,"F4:H31;o390,157;f0;c2;h2;w1;d0,22;",*3 ;2-TR LABEL/TEST
L32 W *2,"F4:H32;o668,35;f0;c0;h3;w3;b1;d0,4;",*3 ;2-TR LABEL/STAT
L33 W *2,"F4:H33;o405,219;f0;c2;h2;w1;d0,14;",*3 ;3-MR LABEL/ACC#
L34 W *2,"F4:H34;o405,267;f0;c2;h1;w1;d0,14;",*3 ;3-MR LABEL/TOP
L35 W *2,"F4:H35;o405,311;f0;c2;h2;w1;d0,14;",*3 ;3-BR LABEL/ACC#
L36 W *2,"F4:H36;o405,345;f0;c2;h2;w1;d0,20;",*3 ;3-BR LABEL/NAME
L37 W *2,"F4:H37;o405,380;f0;c2;h1;w1;d0,11;",*3 ;3-BR LABEL/SSN
L38 W *2,"F4:H38;o405,406;f0;c2;h1;w1;d0,14;",*3 ;3-BR LABEL/DATE
L39 W *2,"F4:H39;o405,438;f0;c2;h2;w1;d0,13;",*3 ;3-BR LABEL/TEST
L40 W *2,"F4:H40;o605,219;f0;c2;h2;w1;d0,14;",*3 ;4-MR LABEL/ACC#
L41 W *2,"F4:H41;o605,267;f0;c2;h1;w1;d0,14;",*3 ;4-MR LABEL/TOP
L42 W *2,"F4:H42;o605,311;f0;c2;h2;w1;d0,14;",*3 ;3-BR LABEL/ACC#
L43 W *2,"F4:H43;o605,345;f0;c2;h2;w1;d0,20;",*3 ;3-BR LABEL/NAME
L44 W *2,"F4:H44;o605,380;f0;c2;h1;w1;d0,11;",*3 ;3-BR LABEL/SSN
L45 W *2,"F4:H45;o605,406;f0;c2;h1;w1;d0,14;",*3 ;3-BR LABEL/DATE
L46 W *2,"F4:H46;o605,438;f0;c2;h2;w1;d0,13;",*3 ;3-BR LABEL/TEST
 W *2,"R",*3 ;Terminate programming function, returns to print mode.
 Q
