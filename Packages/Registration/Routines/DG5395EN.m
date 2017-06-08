DG5395EN ;ALB/ABR - Environment check for DG*5.3*95 ; 7/2/96
 ;;5.3;Registration;**95**;Aug 13, 1993
 ;
 ; This enviroment check routine will ensure that patch DG*5.3*62 has
 ; been installed prior to installation of this patch.
 ; It will abort if hasn't been installed.
 ;
EN ; begin processing
 N X
 S X="DGPWB" X ^%ZOSF("TEST") E  S XPDQUIT=1 D  Q
 .W !!,*7,">>> DG*5.3*62 must be installed first!",!!,">>> Installation aborted."
 .W !!,">>> Please install patch DG*5.3*62 prior to proceeding",!
 I 'XPDENV W "Okay to continue...",!
 I XPDENV W "...continuing with installation"
 Q
