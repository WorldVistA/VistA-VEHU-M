ADXTCVT ;523/RES/KC conversion routine MRS to VA ; 10-aug-92
 ;;1.1;;
EN ;
 N %IS,ADXT,ADXTSTAT,DIC,DIR,ADXTI,ADXTX,ADXTI,X,Y,ADXTZ
XUP ;
 I '$D(U)!('$D(DUZ))!($G(DUZ(0))'="@")!('+$G(DUZ))
 I  W !!,"Not set up with programmer variables!",! G EXIT
MENU ;
 W ! F ADXTI=1:1:5 S ADXTX=$TEXT(INTRO+ADXTI) Q:ADXTX=""  W !,$P(ADXTX,";;",2)
 W !,"    Phase I (Upload Options)",!
 W !,"      1. KERMIT upload (ZSTEM method)"
 W !,"      2. ASCII upload (Crosstalk method)"
 W !,"      3. VMS upload (VMS Kermit method)"
 W !,"      4. Verify file data/record counts in ^TMP global"
 W !!,"    Phase II (Conversion)",!
 W !,"      5. Perform main conversion (Load data from ^TMP to DHCP)"
 W !!,"    Phase III (Post-Conversion)",!
 W !,"      6. Print Error Report"
 W !,"      7. Kill ^TMP(""ADXT"")"
 W !,"      8. Print Never Disease Free Recurrence List",!
 K DIR S DIR(0)="NO^1:8",DIR("A")="    Enter Choice" D ^DIR
 G:$D(DIRUT) EXIT
 ;
 I Y=1 D KERMIT G MENU
 I Y=2 D ^ADXTRX G MENU
 I Y=3 D ^ADXTRVMS G MENU
 I Y=4 D TMPCHK^ADXTCHK R !!,"Press any key...",X:DTIME K ADXT G MENU
 I Y=5 D LOAD^ADXTLOAD G MENU
 I Y=6 D ^ADXTRPT G MENU
 I Y=7 D KILLTMP G MENU
 I Y=8 D ^ADXTRPSU G MENU
 G MENU
EXIT ;
 I $D(IO(0)) U IO(0)
 K %IS,ADXT,ADXTSTAT,DIC,DIR,ADXTI,ADXTX,ADXTI,X,Y,ADXTZ
 D ^%ZISC Q
 ;
KERMIT ;
 I '+$$KERMOK^ADXTUT2() R !!?5,"Must be using Kernel 6.5, 7.1, OR Kernel 7 with patch XU*7*10 applied, to use",!?5,"Kernel Kermit method. Press any key...",ADXTZ:DTIME Q
 W !!,"    ZSTEM Upload (Kermit Method) Options"
 W !!,"      1. Use Kermit to upload MRS files to Kernel Kermit Holding Area"
 W !,"      2. Move MRS files from Kernel Kermit Holding Area to ^TMP global"
 W ! K DIR S DIR(0)="NO^1:2",DIR("A")="    Enter Choice" D ^DIR
 Q:$D(DIRUT)
 I Y=1 D  G KERMIT
 .F ADXTI=5:1 S ADXTX=$TEXT(INTRO+ADXTI) Q:ADXTX=""  W !,$P(ADXTX,";;",2)
 .D ^ADXTRK
 I Y=2 D MOVE G KERMIT
 Q
 ;
MOVE ; move files from Kermit Holding Area to ^TMP
 S ADXTSTAT=1 D CHK^ADXTCHK I 'ADXTSTAT Q  ; check if all six files avail.
 W !! S DIR(0)="Y",DIR("A")="Ready to KILL ^TMP(""ADXT"") and copy files from Kermit Holding Area "
 S DIR("B")="NO" D ^DIR Q:+Y<1  Q:$D(DIRUT)  W !!
 ;
 F ADXTI=1:1:79 W "="
 W !,?10,"Moving files from Kermit Holding Area to ^TMP: ",!
 F ADXTI=1:1:79 W "="
 S ADXTSTAT=1 ; keep track of status of each of five file moves
 K ^TMP("ADXT") ; start fresh
 U IO(0) W !!!,"Copying MRS patient file to ^TMP, at ",$$TIME^ADXTUT(),"."
 D ^ADXTMP I 'ADXTSTAT G EXIT ;  patient file
 U IO(0) W !!,"Copying MRS doctor file to ^TMP, at ",$$TIME^ADXTUT(),"."
 D ^ADXTMDR I 'ADXTSTAT G EXIT ; doctor file
 U IO(0) W !!,"Copying MRS secondary file to ^TMP, at ",$$TIME^ADXTUT(),"."
 D ^ADXTMS I 'ADXTSTAT G EXIT ;  secondary file
 U IO(0) W !!,"Copying MRS diagnosis file to ^TMP, at ",$$TIME^ADXTUT(),"."
 D ^ADXTMDI I 'ADXTSTAT G EXIT ; diagnosis file
 U IO(0) W !!,"Copying MRS follow-up file to ^TMP, at ",$$TIME^ADXTUT(),"."
 D ^ADXTMFL I 'ADXTSTAT G EXIT ; follow-up file
 Q
 ;
KILLTMP ;
 K DIR
 W !!!,"Warning: This will MRS data uploaded into the ^TMP global."
 S DIR(0)="Y",DIR("A")="Ready to KILL ^TMP(""ADXT"") (are you done with the conversion) "
 S DIR("B")="NO" D ^DIR Q:+Y<1  Q:$D(DIRUT)  W !!
 K ^TMP("ADXT")
 R !!,"^TMP(""ADXT"") killed. Press enter to continue...",X:DTIME
 Q
INTRO ;
 ;;
 ;;    ==============================================================
 ;;    DATA CONVERSION FROM MRS TUMOR REGISTRY TO DHCP TUMOR REGISTRY
 ;;    ==============================================================
 ;;
 ;;    You will need to use Kermit to transfer the following FIVE
 ;;    files from the Tumor Registry PC system to Kernel Kermit:
 ;;
 ;;        DAGFILE.T01
 ;;        DOCFILE.T01
 ;;        FLWFILE.T01
 ;;        PATFILE.T01
 ;;        SCDFILE.T01
 ;;
