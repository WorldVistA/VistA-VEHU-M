DSIVXPR2 ;DSS/AJ - RPCs/APIs FOR PARAMETERS ;4/27/2016 11:52
 ;;2.2;INSURANCE CAPTURE BUFFER;**11,12**;May 19, 2009;Build 13
 ;Copyright 1995-2016, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  *** this routine should only be invoked from DSIVXPR ***
 ;
MULT ;  RPC: DSIV XPAR MULT ACTION
 ;  this rpc will allow for multiple actions add, edit, delete, or
 ;  replace to occur with a single rpc call.  This is the equivalent
 ;  of calling ADD, CHG, DEL, or REPL multiple times.  Since each line
 ;  has an action flag, you can mix actions
 ;  If you do not pass an action code, then the program will first see
 ;  if the param-entity-instance exists.  if it does, then it will
 ;  change the existing value.  Otherwise it will add it.
 ;
 ;  DSIVLIST(#) - required - an array - p1^p2^p3^p4^p5^p6^p7  where
 ;  p1^p2^p3^p4^p5^p6  - same as DATA as described in DSIVXPR
 ;  p7 - optional - action to be performed - default is <null>
 ;                  do change if exists, else do add
 ;       ADD - add a new param-entity-instance
 ;       CHG - change value of existing param-entity-instance
 ;       DEL - delete an exisitng param-entity-instance
 ;    DELALL - delete all instances for a param-entity combo
 ;      REPL - replace instance for existing param-entity-inst
 ;
 ;  DSIVRET - return array
 ;  Return - return the array originally passed in except there will be
 ;    an 8th (or 8-9th ~piece).  For each array if the action was
 ;    successful, the 8th piece will be 1.  If the action was
 ;    unsuccessful, the 8,9th pieceS will be -1^message
 N X,Y,Z,DSIV,DSIVNT,DSIVDAT,DSIVX,TAG
 S DSIVDAT="",DSIVNT=0
 F  S DSIVDAT=$O(DSIVLIST(DSIVDAT)) Q:DSIVDAT=""  D
 .S DSIV=DSIVLIST(DSIVDAT),TAG=$P(DSIV,"~",7),DSIVX=$P(DSIV,"~",1,6)
 .I "^^ADD^CHG^DEL^DELALL^REPL^"'[(U_TAG_U) D  Q
 ..S X="-1~Action flag "_TAG_" is invalid" D SET
 ..Q
 .I TAG="" D  Q:TAG=-1
 ..S Y=$$GET1^DSIVXPR(,$P(DSIV,"~",1,6),1)
 ..S TAG=$S(+Y'=-1:"CHG",Y="-1^No value found":"ADD",1:-1)
 ..I TAG'=-1 S $P(DSIV,"~",7)=TAG
 ..E  S X=$TR(Y,U,"~") D SET
 ..Q
 .S Y="$$"_TAG_"^DSIVXPR(,DSIVX,1)" S @("X="_Y)
 .S X=$TR(X,U,"~") D SET
 .Q
 Q
 ;
SET S DSIVNT=DSIVNT+1,Z=DSIV,$P(Z,"~",8)=X,DSIVRET(DSIVNT)=Z Q
