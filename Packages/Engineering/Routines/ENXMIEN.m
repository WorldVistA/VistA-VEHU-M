ENXMIEN ;WIRMFO/SAB- ENVIRONMENTAL CHECK ;7/9/96
 ;;7.0;ENGINEERING;**32**;Aug 17, 1993
 I $G(XPDENV) D  ; install package option
 . I $$FIND1^DIC(446.6,"","X","JANUS2020","B")'>0 D
 . . S XPDQUIT=2
 . . W !,"  JANUS2020 not found in SPECIALTY COMMAND file. Patch"
 . . W !,"  PRC*5*42 must be installed before installing this patch."
 . . W !,"  Please re-install EN*7*32 after installing PRC*5*42."
 Q
 ;ENXMIEN
