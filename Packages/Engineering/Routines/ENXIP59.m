ENXIP59 ;WCIOFO/SAB- PATCH ENVIRONMENTAL CHECK ROUTINE ;10/21/1998
 ;;7.0;ENGINEERING;**59**;Aug 17, 1993
 ;
 ;Q:'$G(XPDENV)!($$PATCH^XPDUTL("EN*7.0*59"))  ;once is enough, at install
 ;
 I $$FIND1^DIC(.402,"","X","ENZWOEDIT","B") D
 . W !!,"A customized version of input template ENWOEDIT appears to be in use for"
 . W !,"the Work Order File (#6920) at your facility. It's name is ENZWOEDIT."
 . W !!,"This patch (EN*7*59) modifies input template ENWOEDIT by changing"
 . W !,"the first line (EDIT WHICH FIELD:)"
 . W !,"from"
 . W !,"  .01//   WORK ORDER #"
 . W !,"to"
 . W !,"  W !,""WORK ORDER #: ""_$P($G(^ENG(6920,DA,0)),U)_"" (no editing)"""
 . W !!,"ENZWOEDIT should either be similarly modified or deleted."
 . W !!,"Press <RETURN> to continue..." R X:DTIME
 Q
 ;
 ;ENXIP59
