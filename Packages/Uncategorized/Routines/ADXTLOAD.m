ADXTLOAD ;523/KC perform the conversion ;;15-SEP-1992
 ;;1.1;;
LOAD ;
 N X,ADXTI,Y
 I '$D(^DD(165.51,.041,0)) D  Q
 .W !!?10,"You must be running Oncology 2.1 !!!"
 .R !!?10," press any key...",X:DTIME
 I '$D(^DD(523701,0,"NM","ADXT ERROR FILE"))=1 D  Q
 .W !!?10,"ADXT ERROR FILE not defined. Run ^ADXTINIT first to set up"
 .W !?10,"this fileman file. Then try the conversion again!"
 .R !!?10," press any key...",X:DTIME
 I '$$LOCALOK^ADXTUT2() D  Q
 .W !!?10,"Not all local fields are set up. Run ^ADXTINIT first to set"
 .W !?10,"up local field in Oncology package files. Then try the convesion"
 .W !?10,"again!"
 .R !!?10," press any key...",X:DTIME
 I $G(^ONCO(160.1,"AJ"))'?2N D  Q
 .W !!?10,"Warning: Site Parameter for YEAR START AJCC 4TH EDITION not"
 .W !?10,"defined. Before converting, use the Oncology Package to enter"
 .W !?10,"this site parameter. New users of the Oncology package should"
 .W !?10,"in most cases set this value to 93."
 .R !!?10," press any key...",X:DTIME
 K ADXTQUIT D TMPCHK^ADXTCHK
 W ! F ADXTI="PAT","DOC","SCD","DI","FL" D  Q:$D(ADXTQUIT)
 .Q:+ADXT(ADXTI)
 .W !,"Warning: 0 records found in ^TMP from "
 .D LOAD1
 W ! F ADXTI="PAT","DOC","SCD","DI","FL" D  Q:$D(ADXTQUIT)
 .Q:'+ADXT(ADXTI,"FAIL")
 .W !,"Warning: ",ADXT(ADXTI,"FAIL")," record(s) failed verification test in ^TMP from "
 .D LOAD1
 I $D(ADXTQUIT) K ADXTQUIT Q
 ;
STATE ;
 K ADXTQUIT D ^ADXTGTST I $D(ADXTQUIT) K ADXTQUIT Q
 ;
ADD W !! K ADXT
 W !,"This conversion is Class 3 Software. It is the sole responsibility"
 W !,"of the site using the software to verify the accuracy of the results "
 W !,"of the conversion performed by it. Furthermore, the correction of"
 W !,"any conversion errors in the converted data is the sole responsibility"
 W !,"of the site using the software.",!!
 K DIR S DIR(0)="Y"
 S DIR("A")="Ready to transfer above data to Oncology package files? "
 S DIR("B")="NO" D ^DIR Q:+Y<1  Q:$D(DIRUT)  W !!
 K %IS S %IS="M",%IS("A")="Enter a (FAST) device for input transform dialogue to print to: "
 D ^%ZIS I POP Q
 ;
 ; fill in BIRTHPLACE FOR ONCOLOGY file
 D ^ADXTBRTH
 ; add entries from ^TMP to Oncology package files
 U IO(0) W !!! D LINE W "Now beginning to load into DHCP files: " D LINE
 S X="ERRTN^ADXTLOAD",@^%ZOSF("TRAP")
 ;
ADDP U IO(0) W !! D LINE W "Processing MRS patient file, at ",$$TIME^ADXTUT(),"." D LINE
 D ^ADXTAP1 ;  patient file
ADDD U IO(0) W !! D LINE W "Processing MRS doctor file, at ",$$TIME^ADXTUT(),"." D LINE
 D ^ADXTADR ; doctor file
ADDS U IO(0) W !! D LINE W "Processing MRS secondary file, at ",$$TIME^ADXTUT(),"." D LINE
 D ^ADXTAS ;  secondary file
ADDDI U IO(0) W !! D LINE W "Processing MRS diagnosis file, at ",$$TIME^ADXTUT(),"." D LINE
 D ^ADXTADI ; diagnosis file
ADDF U IO(0) W !! D LINE W "Processing MRS follow-up file, at ",$$TIME^ADXTUT(),"." D LINE
 D ^ADXTAFL ; follow-up file
 ;
 U IO(0) W !! D LINE W "Performing post-conversion, at ",$$TIME^ADXTUT(),"." D LINE
ADDPC D ^ADXTPCVT ; post-conversion
 ;
 U IO(0) W !!!,"Data conversion from MRS Tumor Registry to DHCP Tumor Registry completed...",!,"Time is ",$$TIME^ADXTUT(),".",!!
 D ^ADXTMM ; send Boston a mail message
 R !!,"Press any key...",X:DTIME
 K X,ADXTI,Y
 Q
LOAD1 ;
 W $S(ADXTI="PAT":"Patient",ADXTI="DOC":"Doctor",ADXTI="SCD":"Secondary",ADXTI="DI":"Diagnosis",ADXTI="FL":"Follow-up",1:"unknown!!")
 W " MRS file." K DIR S DIR(0)="Y"
 I +ADXT(ADXTI,"FAIL") D
 .W !,"If you continue with the conversion, these record(s) will be skipped."
 .W !,"See appendix E of the documentation for possible actions to fix these"
 .W !,"record(s) before continuing the conversion.",!
 S DIR("A")="Are you sure you want to continue? ",DIR("B")="NO"
 D ^DIR S:((+Y<1)!($D(DIRUT))) ADXTQUIT=1
 Q
LINE ; write a line
 N ADXTZ U IO(0) W ! F ADXTZ=1:1:79 W "="
 W ! K ADXTZ Q
ERRTN ;
 U IO(0) W !!,"Recording that an error occurred, then quitting..."
 D @^%ZOSF("ERRTN")
 Q
