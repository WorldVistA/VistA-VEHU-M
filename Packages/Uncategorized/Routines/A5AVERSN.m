A5AVERSN ;verify version numbers of routines [ 02/18/93  8:47 AM ]
 N CHK,I,LOAD
 W !,"I will display the second line of all selected routines",!,"and the routine name, in the form 'ROUTINE  Second line text'",!!
 D BUILD
NUM ;
 S CHK="W:(I#2) ! W:(I#2) RTN,?10,$E($P(L2,"";"",2,4),1,25),?36,""|"" W:'(I#2) ?41,RTN,?51,$E($P(L2,"";"",2,4),1,28)"
 S X=0 F I=1:1 S X=$O(^UTILITY($J,X)) Q:X=""  X LOAD,CHK
 K ^UTILITY($J)
 Q
 ;
PATCH ; Entry point that will display only patched routines
 ;
 N CHK,L2,LOAD,RTN
 W !,"I will display ONLY those routines, from the selected routine set,",!,"that have been patched.",!!
 D BUILD
 S CHK="W ""."" I $P(L2,"";"",5)?1""**""1N.E W !,RTN,?12,$P(L2,"";"",2,99)"
 S X=0 F  S X=$O(^UTILITY($J,X)) Q:X=""  X LOAD,CHK D:$T
 .N X S X=RTN X ^%ZOSF("RSUM") W !?12,"Checksum "_Y,!
 K ^UTILITY($J)
 Q
 ;
BUILD ; build routine set
 K ^UTILITY($J)
 X ^%ZOSF("RSEL") Q:'$D(^UTILITY($J))
 ; build executable vairables
 S LOAD="S RTN=X,L2=$T(+2^@X)"
 Q
 ;
CHECK(VN) ;
 ; Entry point that will check the version number in VN
 ; against the version number of the routines selected in the
 ; routine set from build
 N %,%A2,%QMK,%YN,AND,CHK,DEF,GTNM,L2,LOAD,QUES,RTN,RVN,X
 I 'VN Q
 D BUILD
 S GTNM="S RVN=$P(L2,"";;"",2)"
 S CHK="W ""."" I RVN<VN W !,RTN,?12,$P(L2,"";"",2,99)"
 S X=0 F  S X=$O(^UTILITY($J,X)) Q:X=""  X LOAD,GTNM,CHK
 K ^UTILITY($J)
 Q
 ;
OR ;
 ; Entry point that will check for aby number as the first characters of 
 ; the second line of the routine.
 ; This was the way to flag routines that were in
 ; the process of being patched.
 N %,%A2,%QMK,%YN,AND,CHK,DEF,GTNM,L2,LOAD,QUES,RTN,RVN,X
 D BUILD
 S GTNM="S RVN=$P(L2,"";"",2)"
 S CHK="W ""."" I +RVN W !,RTN,?12,$P(L2,"";"",2,99)"
 S X=0 F  S X=$O(^UTILITY($J,X)) Q:X=""  X LOAD,GTNM,CHK
 K ^UTILITY($J)
 Q
 ;
CHKPATCH(PN) ;
 N LOAD,CHK,RTN,STAR,COMA,IC,ID
 D BUILD
 Q:'$D(^UTILITY($J))
 S STAR="*",COMA=","
 S IA=STAR_PN_COMA,IB=COMA_PN_COMA,IC=STAR_PN_STAR,ID=COMA_PN_STAR
 S CHK="S PN1=$P(L2,"";"",5) I PN1[IA!(PN1[IB)!(PN1[IC)!(PN1[ID) W RTN,?12,$P(L2,"";"",3,99),!"
 S X=0 F  S X=$O(^UTILITY($J,X)) Q:X=""  X LOAD,CHK D:$T
 .N X S X=RTN X ^%ZOSF("RSUM") W ?12,"Checksum "_Y,!
 Q
 ;
 ;
PCHFILE ; to build a VMS file which contains only patched routines
 ; Dialog will ask for a routine set
 ; then make a call to %ZIS to get a HFS device
 ; then go thru the routine set to get the names of patched routines
 ; only.  Rotuine will then write these routines out the the HFS device
 ; specified by the user.
 N %ZIS,POP,SAVEDT,LOAD,CHK,RTN,X,RN
 D BUILD Q:'$D(^UTILITY($J))!($O(^($J,""))'["")
 S SAVEDT=$P($$HTE^XLFDT($H),":",1,2)
 S LOAD="ZL @X X GTNM",GTNM="S RTN=$T(+0),L2=$T(+2)"
 S CHK="W ""."" I $P(L2,"";"",5)?1""**""1N.E W !,RTN,?12,$P(L2,"";"",2,99)"
 S X=0 F  S X=$O(^UTILITY($J,X)) Q:X=""  X LOAD,CHK K:'$T ^UTILITY($J,RTN)
 I ^%ZOSF("OS")["VAX DSM"  D VAX Q
 W !! S %ZIS="",%ZIS("B")="PATCH FILE" D ^%ZIS I POP D CLEAN Q
 U IO W "Saved by %RS on "_SAVEDT,!,"Patched routines as of "_SAVEDT,!
 S RN=""
 F  S RN=$O(^UTILITY($J,RN)) Q:RN=""   U IO(0) W:$X>70 ! W $E(RN_"          ",1,10) X ("ZL "_RN_" U IO W RN,! ZP")
 D ^%ZISC,CLEAN
 Q
 ;
VAX ; VAX DSM SAVE OF ROUTINES
 W !! S %ZIS="",%ZIS("B")="PATCH FILE" D ^%ZIS I POP D CLEAN Q
 ;S IO="VA09$:[USER.DOTAPE]"_$P(IO,"]",2) C IO O IO:NEW W !,"Saving patched routines.",!
 C IO O IO:NEW W !,"Saving patched routines.",!
 U IO W "Saved by %RS on "_SAVEDT,!,"Patched routines as of "_SAVEDT,!
 S RN=""
 F  S RN=$O(^UTILITY($J,RN)) Q:RN=""  U IO(0) W:$X>70 ! W $E(RN_"        ",1,10) X ("ZL "_RN_" U IO W RN,! ZP") W !
 D ^%ZISC
 U 0 W !,"FILE "_$P(IO,"]",2)_"Written to :  "_$P(IO("CLOSE"),";")
 ;
CLEAN ; CLEANUP UTILITY GLOBAL
 K ^UTILITY($J)
 Q
SAVE(NM,P) ;
 ; Entry point that will check package name and save them
 ; to a vms file.  if the parameter "P" is passed the routines will
 ; be deleted
 ; 
 Q:'$L(NM)
 N %,%A2,%QMK,%YN,AND,CHK,DEF,GTNM,L2,LOAD,QUES,RTN,RVN,X
 D BUILD
 S GTNM="S RVN=$P(L2,"";;"",2)"
 S CHK="W ""."" B 1  I RVN<VN W !,RTN,?12,$P(L2,"";"",2,99)"
 b 1  S X="" F  S X=$O(^UTILITY($J,X)) Q:X=""  X LOAD,GTNM,CHK
 K ^UTILITY($J)
 Q
PURGE(NM,P) ;
 ; Entry point that will check package name and save them
 ;; ZXZXZXZXZXZXZXZXZto a vms file.  if the parameter "P" is passed the routines will
 ; be deleted
 ; 
 Q:'$L(NM)
 N %,%A2,%QMK,%YN,AND,CHK,DEF,GTNM,L2,LOAD,QUES,RTN,RVN,X
 D BUILD
 S GTNM="S RVN=$P(L2,"";;"",2)"
 S CHK="W ""."" B 1  I RVN'=NM W !,RTN,?12,$P(L2,"";"",2,99)"
 S X="" F  S X=$O(^UTILITY($J,X)) Q:X=""  X LOAD,GTNM,CHK
 K ^UTILITY($J)
