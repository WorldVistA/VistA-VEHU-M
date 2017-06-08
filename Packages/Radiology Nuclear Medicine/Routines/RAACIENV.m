RAACIENV ;HISC/GJC-Environmental Check Routine (Patch 8) ;10/25/96  10:04
VERSION ;;4.5;Radiology/Nuclear Medicine;**8**;Dec 12, 1995
EN1 ; Check that the Scheduling patch SD*5.3*63 is installed prior to this
 ; installation of the Radiology/Nuclear Medicine patch.
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,1:0) D  S XPDABORT=2 Q
 . W !?5,"DUZ and DUZ(0) must be defined as an active user to initialize"
 . W !?5,"the RADIOLOGY/NUCLEAR MEDICINE v",$P($T(+2),";",3)
 . W " software.",$C(7)
 . Q
 I DUZ(0)'="@" D  S XPDABORT=2 Q
 . W !?5,"You must have programmer access i.e, DUZ(0)=@, to run this "
 . W "init!",$C(7)
 . Q
 N RABAD,X S RABAD=0,X="SCDXUAPI" W !?3,"...Checking environment"
 X ^%ZOSF("TEST") S:'$T RABAD=1
 I RABAD!('$$PATCH^XPDUTL("SD*5.3*63")) D  Q
 . W !?5,"You MUST have installed SD*5.3*63 on your system before the"
 . W !?5,"installation of RA*4.5*8 can take place!",!,$C(7)
 . S XPDABORT=2 ; do not install, leave RA*4.5*8 in ^XTMP
 . Q
 W ", done!"
 Q
