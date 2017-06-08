RGEDENV ;B'HAM/PTD-RGED*2.6*1 PATCH ENVIRONMENT CHECK ROUTINE ;08/30/01
 ;;2.6;EXTENSIBLE EDITOR;**1**;Mar 22, 1999
 ;Determine current version of EXTENSIBLE EDITOR installed.
 S RGVER=$$VERSION^XPDUTL("RGED")
 ;If version not 2.6, abort install.
 I (RGVER'="2.6") W !!," EXTENSIBLE EDITOR version 2.6 is not installed; no need to patch." S XPDQUIT=2
 I '$D(XPDQUIT) W !!,"Environment check is ok.",!
 K RGVER
 Q
 ;
