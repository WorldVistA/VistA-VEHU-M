DENTVXPR ;DSS/SGM - EDIT DENTV PARAMETERS ;08/29/2003 00:31
 ;;1.2;DENTAL;**31,43**;Aug 10, 2001
 ;Copyright 1995-2005, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  DBIA#  SUPPORTED
 ;  -----  ---------  ----------------------------------------
 ;   2336      x      EDIT^XPAREDIT
 ;                      need to get IA to call GETCLS^XPAREDIT
 ;   2343      x      $$LOOKUP^XUSER
 ;  10006      x      ^DIC
 ;  10013      x      ^DIK
 ;  10104      x      $$CJ^XLFSTR
 ;                      need IA to do FM lookup on file 8989.51
 ;
 ;  terminal interactive option to edit DRM parameters
 ;
 N X,Y,Z,DENT,ENT,PARM,PKG
A W !! S PARM=$$PARM Q:PARM<1
 W @IOF,!,$$CJ^XLFSTR("  EDIT Parameter "_$P(PARM,U,2)_"  ",80,"-"),!
 S ENT=$$LST I ENT<1 G A
 I +ENT=9.4 S ENT=$P(ENT,U,4)
 I +ENT=200 S X=$$DIC G:X<1 A S ENT=X_";VA(200,"
 D EDIT^XPAREDIT(ENT,PARM)
 D DIR
 G A
 ;
DIC() ;  ask for new person to edit
 N X,Y S X=$$LOOKUP^XUSER("A") S:X<1 X=-1 Q +X
 ;
DIR ;  prompt to press return
 N X,Y,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" W ! D ^DIR
 Q
 ;
LST() ;  get list of acceptable entities for parm
 N I,X,Y,DEN,LST
 D ENT^DSICXPR1(.LST,+PARM,1)
 F I=0:0 S I=$O(LST(I)) Q:'I  I +LST(I)=4.2 K LST(I) Q
 K LST("M","SYSTEM"),LST("P","SYS")
 I I>0 S LST=LST-1
 I LST<1 Q -1
 I LST=1 S X=$O(LST(0)) Q LST(X)
 D GETCLS^XPAREDIT(.DEN,PARM,.LST)
 S X=$S(DEN>0:LST(DEN),1:-1)
 Q X
 ;
PARM() ;  select parameter to edit
 N X,Y,Z,DIC,DTOUT,DUOUT
 S DIC=8989.51,DIC(0)="QAEM"
 S DIC("S")="I $E($P(^(0),U),1,5)=""DENTV""&($D(^XTV(8989.51,Y,30,""AG"",""VA(200,"")))"
 W ! D ^DIC I Y>-1,$D(DTOUT)!$D(DUOUT) S Y=-1
 Q Y
