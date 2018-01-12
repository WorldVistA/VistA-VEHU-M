DSIVNICB ;DSS/CAJ - NON-ICB IMPORT ;7/24/2014 9:55
 ;;2.2;INSURANCE CAPTURE BUFFER;**11**;May 19, 2009;Build 16
 ;Copyright 1995-2014, Document Storage Systems, Inc., All Rights Reserved
 ;
 Q
N1 ; called by DSIV NIGHTLY NON-ICB
 N BIEN,DSIVAR,DSIVARR,DSIVERR,DSIVN,DSIVNEW,DSIVNODE,DSIVRET,X
 ; Get the last Buffer IEN checked during the last execution of this task
 D GET1^DSICXPR(.DSIVNODE,"SYS~DSIV NON-ICB INDEX~1")
 S DSIVNODE=$S(+DSIVNODE<0:0,1:+DSIVNODE),BIEN=DSIVNODE
 F  S BIEN=$O(^IBA(355.33,BIEN)) Q:'+BIEN  D
 .K DSIVARR
 .S DSIVNODE=BIEN_",",DSIVAR=$NA(DSIVARR(355.33,DSIVNODE)) K @DSIVAR
 .D GETS^DIQ(355.33,DSIVNODE,"60.01;20.01;90.01;.03;.02;.01;.09;.07;.08","IE","DSIVARR")
 .; Quit if there is no patient attached to #355.33
 .; This must be done since #19625 has Patient IEN as a primary, required field
 .Q:@DSIVAR@(60.01,"I")=""
 .; Check to ensure that all variables used in the following global check
 .;  are not null to prevent <UNDEFINED> errors
 .Q:@DSIVAR@(.01,"I")=""
 .Q:BIEN=""
 .; Quit if the relevant x-ref is found
 .; If the entry is already in the #19625 file, it should have a "G" x-ref entry
 .;  and therefore should not be added to #19625
 .Q:$D(^DSI(19625,"G",@DSIVAR@(60.01,"I"),BIEN,@DSIVAR@(.01,"I")))
 .S DSIVN=$NA(DSIVNEW(19625,"+1,"))
 .S @DSIVN@(.01)=@DSIVAR@(60.01,"I")   ;Patient IEN
 .S @DSIVN@(.02)=BIEN                  ;Buffer IEN
 .S @DSIVN@(.03)=@DSIVAR@(20.01,"E")   ;Insurance Company Name
 .S @DSIVN@(.031)=$G(@DSIVAR@(90.01,"E"))  ;Group Name
 .S @DSIVN@(.032)=@DSIVAR@(.03,"E")    ;Source of Information
 .S @DSIVN@(1)=@DSIVAR@(.02,"I")       ;Entered By
 .S @DSIVN@(1.01)=@DSIVAR@(.01,"I")    ;Date Entered
 .; These three fields from #335.33 are stored in one field in #19625
 .; They are booleans and are stored in a 10 bit free text field
 .;  1st bit = New Policy
 .;  2nd bit = New Company
 .;  3rd bit = New Group/Plan
 .S @DSIVN@(6)=@DSIVAR@(.09,"I")_@DSIVAR@(.07,"I")_@DSIVAR@(.08,"I")_"0000000"
 .S @DSIVN@(10)=1                      ;Non-ICB Flag
 .K DSIVERR
 .D UPDATE^DIE("","DSIVNEW",,"DSIVERR")
 .Q:$D(DSIVERR)
 .; Update the parameter each pass so it will restart at the same
 .;  index if a fatal error were to occur prior to task completion
 .D CHG^DSICXPR(.DSIVRET,"SYS~DSIV NON-ICB INDEX~1~"_BIEN)
 Q
CLEAR ; a routine to clean out non-ICB buffer entries from the ICB audit file
 N AUDITARR,AUDITIEN
 S AUDITIEN=0
 F  S AUDITIEN=$O(^DSI(19625,AUDITIEN)) Q:'+AUDITIEN  D
 .Q:'+$$GET1^DIQ(19625,AUDITIEN_",","10","I")
 .S AUDITARR(19625,AUDITIEN_",",.01)="@"
 .D FILE^DIE("K","AUDITARR")
 D CHG^DSICXPR(.DSIVRET,"SYS~DSIV NON-ICB INDEX~1~0")
 Q
