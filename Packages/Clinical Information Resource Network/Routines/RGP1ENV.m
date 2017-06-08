RGP1ENV ;B'HAM/PTD-RG*1*1 PATCH ENVIRONMENT CHECK ROUTINE ;06/17/99
 ;;1.0; CLINICAL INFO RESOURCE NETWORK ;**1**;30 Apr 99
 ;Determine current version of CIRN installed.
 S RGVER=$$VERSION^XPDUTL("RG")
 ;If version not 1.0, abort install.
 I (RGVER'="1.0") W !!," CLINICAL INFO RESOURCE NETWORK version 1.0 must be installed." S XPDQUIT=2
 I '$D(XPDQUIT) W !!,"Environment check is ok.",!
 K RGVER
 Q
 ;
