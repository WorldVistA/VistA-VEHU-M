DG5393EN ;ALB/SEK - Environment check for DG*5.3*93 ; 6/27/96 @ 845
 ;;5.3;Registration;**93**;Aug 13, 1993
 ;
 ; This enviroment check routine will ensure that AICS v2.1 has
 ; been installed prior to installation of this patch.
 ; It will abort if hasn't been installed.
 ;
EN ; begin processing
 N X
 S X="IBDFREG" X ^%ZOSF("TEST") E  W !!,*7,">>> AICS v2.1 must be installed first!",!!,">>> Installation aborted." S XPDQUIT=2 Q
 W !!,"AICS v2.1 found..."
 I XPDENV=1 W "continuing with installation"
 Q
