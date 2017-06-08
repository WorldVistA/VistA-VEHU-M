ENX2IEN ;(CIOFO-2)/DH - ENVIRONMENTAL CHECK ;12.17.97
 ;;7.0;ENGINEERING;**47**;Aug 17, 1993
 Q:'$G(XPDENV)!($$PATCH^XPDUTL("EN*7.0*47"))  ;once is enough, at install
 I $$FIND1^DIC(.402,"","X","ENZEQENTER","B") D
 . W !!,"A customized version of input template ENEQENTER appears to be in use for"
 . W !,"the Equipment File (#6914) at your facility. It's name is ENZEQENTER."
 . W !!,"This patch (EN*7*47) modifies input template ENEQENTER. You should therefore"
 . W !,"compare your existing version of ENZEQENTER with the new version of ENEQENTER"
 . W !,"that you will have after this patch has been installed."
 . W !!,"ENZEQENTER should either be modified or (better yet) deleted."
 . W !!,"Press <RETURN> to continue..." R X:DTIME
 Q
 ;ENX2IEN
