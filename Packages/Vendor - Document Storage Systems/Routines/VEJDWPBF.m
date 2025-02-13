VEJDWPBF ; wpb/swo routine modified for dental GUI;7.19.98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;3.0;CONSULTS/REQUEST TRACKING;**1**;JAN 12, 1998
 ;GMRCASV SLC/KCM,DLT -Build ^TMP("GMRCS of Svc(s)/Specialties;1/6/98
ASRV ;Ask for service/specialty group {output} GMRCDG,GMRCBUF,GMRCACT,^TMP("GMRCS",$J,^TMP("GMRCSLIST",$J
 K GMRCQUT
 N GMRCSEL
 D SERV0 D:GMRCDG SERV1
 K W,X,Y Q
SERV0 ;Assume that the lookup must begin with ALL SERVICES, or value of GMRCSVNM
 ;GMRCASV=the ask prompt text
 ;GMRCSVNM=text to use for default name
 S GMRCDG=0
 S:$G(GMRCASV)["Forward" GMRCTO=1
 F  D ASKPRMPT S:X["^^" DIROUT=1 S:X["^" GMRCQUT=1 Q:X["^"  D @$S(X["?":"LISTALL",1:"LKUP") D:($L($G(GMRCSVNM))&GMRCDG) LISTSRV Q:GMRCDG
 Q
ASKPRMPT ;Write the prompt and do the Read to get the user text entered in X
 W !!,$S($D(GMRCASV):GMRCASV,1:"Select Service/Specialty: ")_$S($L($G(GMRCSVNM)):GMRCSVNM,1:"ALL SERVICES")_"// "
 R X:DTIME
 I '$T S X="^"
 I X'["^" S X=$S($G(GMRCASV)["Forward"&('$L(X)):"^",'$L(X):"ALL SERVICES",1:X) Q
 Q
SERV1 ;Create selected SERVICE ^TMP array of service information
 ;If GMRCTO=1 then the BILD section will not include disabled or tracking services which the user cannot send to.
 N GMRCDGT
 S GMRCBUF=GMRCDG
 I GMRCBUF>0 D
 . K ^TMP("GMRCS",$J),^TMP("GMRCSLIST",$J)
 . S GMRCDGT=0,GMRCSEL="BILD" D EN
 . S GMRCGRP("NAM")=^GMR(123.5,GMRCBUF,0)
 . S (GMRCDG,GMRCGRP("ROOT"))=GMRCBUF
 . S GMRCGRP("NAM")=$S($L($P(GMRCGRP("NAM"),"^",3)):$P(GMRCGRP("NAM"),"^",3),1:$E($P(GMRCGRP("NAM"),"^"),1,5))
 K GMRCSEQ,GMRCBUF
 Q
LKUP ;Ask the user for the service; use the value of x for lookup; branch to list on ??
 S DIC="^GMR(123.5,",DIC(0)="MNEQZ",DIC("W")="W ""   "",$P(Y,""^"",2)"
 D ^DIC K DIC I '$D(Y(0)) D LISTALL Q
 N W,GMRCEXCL I +$G(GMRCTO) D
 . S W=Y(0),GMRCDG=+Y
 . S GMRCEXCL=0 D EXCLUDE
 . I GMRCEXCL=1 S GMRCSVNM=Y(0,0),GMRCEXCL=0 Q
 . K GMRCSVNM ;Service selected is not a grouper for lookup
 . I GMRCEXCL=9 S GMRCMSG="You have selected a disabled service!" D EXAC^GMRCADC(GMRCMSG) K GMRCMSG Q
 . N GMRCDAD D CHECKDAD
 . I GMRCEXCL=90 S GMRCMSG="You have selected a service that is not part of the ALL SERVICES heirarchy!",GMRCMSG(1)="Contact Consult ADPAC" D EXAC^GMRCADC(.GMRCMSG) K GMRCMSG Q
 . I GMRCEXCL=9 S GMRCMSG="You have selected a service whose parent is disabled!" D EXAC^GMRCADC(GMRCMSG) K GMRCMSG Q
 . I GMRCEXCL=2 S GMRCMSG="You have selected a service whose parent is a tracking service!",GMRCMSG(1)="You do not have authorization to send consults to this service." D EXAC^GMRCADC(.GMRCMSG) K GMRCMSG Q
 I +$G(GMRCEXCL) S Y=0,GMRCDG=0
 S:Y>0 GMRCDG=+Y ;falls to here when service is a grouper or not excluded
 Q
LISTALL ;display LIST of Services in their heirarchy beginning with ALL SERVICES
 S GMRCDG=$O(^GMR(123.5,"B","ALL SERVICES",0)) Q:'GMRCDG
 S GMRCSEL="DISP" W @IOF D EN
 S GMRCDG=0 W !
 Q
LISTSRV ;display LIST of sub-services beginning with a selected service
 S GMRC1=0,GMRCDG=$O(^GMR(123.5,"B",GMRCSVNM,0)) Q:'GMRCDG
 S GMRCSEL="DISP" W @IOF D EN
 S GMRCDG=0 W !
 Q
EN ;Setup Specialty groups   entry: GMRCDG,GMRCSEL   exit: GMRCGRP if GMRCSEL="BILD"
 N GMRCSTK,PARENT,GMRCUSG,GMRCEXCL
 S GMRCSTK=0,PARENT=0 ;beginning service logic
 D @GMRCSEL Q:$D(DUOUT)!$D(DIROUT)
EN1 ;GMRCSTK is used to manage the level of stacks under beginning service 
 S GMRCSTK=1,GMRCSTK(GMRCSTK)=GMRCDG_"^0",GMRCSTK(0)=0,GMRCMEM=0,GMRCNAM=""
 F  S GMRCNAM=$O(^GMR(123.5,+GMRCSTK(GMRCSTK),10,"AC",GMRCNAM)) D  D @$S(+GMRCMEM'>0:"POP",1:"PROC") Q:GMRCSTK<1
 . I $G(GMRCEXCL) S GMRCMEM=0 Q  ;Exclude children of excluded parent
 . I '$L(GMRCNAM) S GMRCMEM=0 ;No more 10th node children
 . E  S GMRCMEM=$O(^GMR(123.5,+GMRCSTK(GMRCSTK),10,"AC",GMRCNAM,""))
 K DUOUT,GMRCMEM,GMRCNAM,GMRCSTK,GMRCSEL
 Q
POP ;Go back one level in service stack heirarchy and initialize exclude
 S GMRCSTK=GMRCSTK-1,GMRCMEM=$P(GMRCSTK(GMRCSTK),"^",2),GMRCNAM=$P(GMRCSTK(GMRCSTK),"^",3),GMRCEXCL=0
 Q
PROC ;GMRCMEM is the member ien in the 10th node being processed
 ;GMRCDG is the ien of file 123.5 being processed
 ;GMRCNAM is the services name
 S $P(GMRCSTK(GMRCSTK),"^",2)=GMRCMEM
 S $P(GMRCSTK(GMRCSTK),"^",3)=GMRCNAM
 S GMRCDG=$P(^GMR(123.5,+GMRCSTK(GMRCSTK),10,GMRCMEM,0),"^",1)
 S PARENT=+GMRCSTK(GMRCSTK)
 S W=$G(^GMR(123.5,GMRCDG,0))
 I $G(GMRCTO)=1 S GMRCEXCL=0 D EXCLUDE S:GMRCEXCL=1 GMRCEXCL=0 ;Includes grouper only
 D:'+$G(GMRCEXCL) @GMRCSEL G:($D(DUOUT)!$D(DIROUT)) EXIT
 ;Initialize a stack level entry to process children of the multiple
 S GMRCSTK=GMRCSTK+1,GMRCSTK(GMRCSTK)=GMRCDG_"^0",GMRCMEM=0,GMRCNAM=""
 Q
DISP ;Display individual entries alphabetically for each service as processed
 I $Y>(IOSL-4) D READ S:$D(DUOUT)!($D(DIROUT)) GMRCSTK=0 G:GMRCSTK=0 EXIT W @IOF
 S W=$G(^GMR(123.5,GMRCDG,0))
 S GMRCUSG=$P(W,"^",2)
 W !,?((GMRCSTK*2)),$S(GMRCUSG=9:"<",1:"")_$P(W,"^")_$S(GMRCUSG=9:">",1:"")_"  "_$S(GMRCUSG=1:"(Grouper Only)",GMRCUSG=2:"(Tracking Only)",GMRCUSG=9:"<Disabled>",1:"")
 Q
BILD ;The following logic will build an array for review for GUI 
 ;GMRCDGT=sequential number,GMRCDG=service pointer,
 ;W=^GMR(123.5,GMRCDG,0),1st piece is name, 2nd piece usage
 ;If GMRCTO=1 then services that only consults can be sent to will be
 ;included with the exception of "grouper only" which keeps the 
 ;heirarchy in order.
 N CHILD
 S W=$G(^GMR(123.5,GMRCDG,0))
 S ^TMP("GMRCS",$J,GMRCDG)=$P(W,"^")
 S GMRCDGT=GMRCDGT+1
 S CHILD=$O(^GMR(123.5,GMRCDG,10,0)) S CHILD=$S(+CHILD:"+",1:"")
 S ^TMP("GMRCSLIST",$J,GMRCDGT)=GMRCDG_U_$P(W,"^")_U_PARENT_U_CHILD_U_$P(W,"^",2)
 Q
EXCLUDE ;This logic excludes services the user cannot send a consult to.
 ;If GMRCTO=1 the user is forwarding or sending a consult 
 ;W=zeroth node of service,GMRCDG=ien of service,GMRCO=ien of consult (optional)
 Q:'$L($G(W)) 
 S GMRCEXCL=+$P(W,"^",2) ;Include grouper for heirarchy building only
 I GMRCEXCL=2 D  ;tracking service exclusion check
 . N GMRCSRV I +$G(GMRCO) S GMRCSRV=$P($G(^GMR(123,+GMRCO,0)),"^",5) I $D(^GMR(123.5,"APC",+GMRCDG,+GMRCSRV)) S GMRCEXCL=0 Q  ;Checks if parent is the consults current service
 . I $D(^GMR(123.5,+GMRCDG,123.3,"B",DUZ)) S GMRCEXCL=0  ;Assumes user updates selected service
 . Q
 Q 
CHECKDAD ;Check the service usage statuses for a selected services parents
 ;There are two passes, one to get any user accessable parent
 ;and the second pass is through the GMRCDAD array to check the parents usage
 ;The GMRCEXCL value is returned for exclusion due to parent
 S GMRCDAD=""
 ;FIRST PASS
 F  S GMRCDAD=$O(^GMR(123.5,"APC",+GMRCDG,GMRCDAD)) Q:GMRCDAD=""  D  I $P($G(GMRCDAD(+GMRCDAD)),U,2)="OK" S GMRCEXCL="OK"
 . S GMRCDAD(+GMRCDAD)=$P(^GMR(123.5,+GMRCDAD,0),U,2) ;dads service usage
 . I $P($G(^GMR(123.5,+GMRCDAD,0)),U,1)="ALL SERVICES" S $P(GMRCDAD(GMRCDAD),U,2,3)="OK^ALL" Q  ;If one of the dad's is all services, than OK to send to if not previously excluded.
 . I GMRCDAD(+GMRCDAD)=1 S $P(GMRCDAD(+GMRCDAD),"^",2)="OK" Q  ;Groupers Only are OK!
 . I $D(^GMR(123.5,+GMRCDAD,123.3,"B",DUZ)) S $P(GMRCDAD(GMRCDAD),U,2,3)="OK^Update access" Q
 . Q
 I GMRCEXCL="OK" S GMRCEXCL=0 Q  ;There is a parent which user has access to.
 ;Second Pass of the GMRCDAD array (multiple parents)
 S GMRCDAD=$O(GMRCDAD("")) I 'GMRCDAD S GMRCEXCL=90 Q  ;Not part of heirarchy; missing dad
 ;Use first parent found in heirarchy.
 S GMRCEXCL=+GMRCDAD(GMRCDAD)
 Q
READ ;;Hold screen
 I $D(IOST) Q:$E(IOST)'="C"
 W ! I $D(IOSL),$Y<(IOSL-4) G READ
 N X W !?5,"Press RETURN to continue, ^ to exit: " R X:DTIME S:X="^" DUOUT=1 S:'$T!(X="^^") DIROUT=1
 K X Q
EXIT ;Kill off variables and quit
 K DIROUT,DUOUT,DTOUT,DIRUT
 Q
