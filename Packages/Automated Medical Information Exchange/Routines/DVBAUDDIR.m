DVBAUDDIR ;ALB/CP - FM DIR API Subroutine Calls ; 4/3/18 8:56am
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;           ^DIR    ; #10026
 ;            ^DISV            ; IA #  510
 ;
 Q
 ;
SELEDIT(DVBRTN) ; Prompt user to determine if wildcard will be used to
 ;
 N @($$DIR^DVBAUDNEW1())
 ; ZEXCEPT: DIR,DUZ,DVBEDIT,DVBQUIT,Y
 ;
 S DVBQUIT=0 ; DVBDEFAULT the return quit variable to successful.
 I $G(DVBRTN)="" S DVBQUIT=1 Q  ; Missing required input parameter
 ;
 S DIR(0)="SO^1:Option NAME;"
 S DIR(0)=DIR(0)_"2:Option NAMESPACE (used with wildcard '*');"
 S DIR(0)=DIR(0)_"3:Options scheduled as regular recurring tasks;"
 I DVBRTN="DVBAUDOAD" D  ;
 . S DIR(0)=DIR(0)_"4:All options with an OUT OF ORDER MESSAGE;"
 S DIR("A")="CHOOSE AUDITING BY"
 S DIR("B")=$G(^DISV(DUZ,DVBRTN,"DVBEDIT"),2)
 ;
 ; If repeating a 2nd time, Kill DVBDEFAULT to allow easy user exiting
 I $G(DVBEDIT) K DIR("B"),DVBEDIT
 ;
 D ^DIR
 ; 2nd time through, Y can equal null if the user hits return on no DVBDEFAULT
 I Y="" S DVBQUIT=1 Q
 I Y["^" S DVBEDIT="",DVBQUIT=1 Q  ; User entered an '^' to EXIT
 ;
 S DVBEDIT=Y ; Save the valid response to the prompt, to save for next DVBDEFAULT
 S ^DISV(DUZ,DVBRTN,"DVBEDIT")=Y ; Save for next DVBDEFAULT response
 ;
 Q  ; Quit SELEDIT
 ;
SELTYPE(DVBRTN) ; Get Option TYPE selection(s) which are candidates for auditing.
 ;
 N DVBCNT,DVBOPTTYPE,DVBOPTTYPEI,DVBOPTTYPES,DVBTYPE
 ; ZEXCEPT: DUZ
 ;
 S DVBQUIT=0 ; Initialize the return quit variable to successful.
 I $G(DVBRTN)="" S DVBQUIT=1 Q  ; Missing required input parameter
 ;
 S DVBCNT=0
 F DVBOPTTYPEI="A","E","I","M","P","R","X","S","C" D  ;
 . S DVBCNT=DVBCNT+1
 . S DVBTYPE(DVBCNT)=DVBOPTTYPEI ; Setup 9 option TYPEs
 ;
 S DVBCNT=0
 F DVBOPTTYPE="1   A:action","2   E:edit","3   I:inquire","4   M:menu" D  ;
 . S DVBCNT=DVBCNT+1
 . S DVBOPTTYPES(DVBCNT)=DVBOPTTYPE
 ;
 F DVBOPTTYPE="5   P:print","6   R:run routine" D  ;
 . S DVBCNT=DVBCNT+1
 . S DVBOPTTYPES(DVBCNT)=DVBOPTTYPE
 ;
 F DVBOPTTYPE="7   X:extended action","8   S:server" D  ;
 . S DVBCNT=DVBCNT+1
 . S DVBOPTTYPES(DVBCNT)=DVBOPTTYPE
 ;
 F DVBOPTTYPE="9   C:ScreenMan" D  ;,"10  Broker (Client/Server)" D  ;
 . S DVBCNT=DVBCNT+1
 . S DVBOPTTYPES(DVBCNT)=DVBOPTTYPE
 ;
 ; Display the available option types for auditing to the user
 ;
 W !!,"Select Option TYPEs to be audited:"
 S DVBOPTTYPE=0
 F  S DVBOPTTYPE=$O(DVBOPTTYPES(DVBOPTTYPE)) Q:DVBOPTTYPE=""  D  ;
 . W !,?5,DVBOPTTYPES(DVBOPTTYPE)
 ;
 N @($$DIR^DVBAUDNEW1()),DVBDEFAULT
 ; ZEXCEPT: DIR,DVBACTION,DVBOPTYPE,DVBQUIT,X,Y
 ;
 S DVBDEFAULT=$S(DVBRTN="DVBAUDOA":"1-3,5-9",DVBRTN="DVBAUDOAD":"1-9",1:"1-3,5-9")
 I DVBRTN="DVBAUDU3",DVBACTION="CREATE" S DVBDEFAULT="1-3,5-9" ; Skip menus
 I DVBRTN="DVBAUDU3",DVBACTION="DELETE" S DVBDEFAULT="1-9" ; Include menus
 ;
 S DIR(0)="LO^1:"_DVBCNT
 S DIR("B")=$G(^DISV(DUZ,DVBRTN,"DVBOPTYPE"),DVBDEFAULT)
 I DVBRTN="DVBAUDU3" S DIR("B")=DVBDEFAULT
 W !
 D ^DIR I Y["^" S DVBQUIT=1 Q  ; User entered an '^' to EXIT
 S ^DISV(DUZ,DVBRTN,"DVBOPTYPE")=X ; Save for next DVBDEFAULT response
 ;
 N DVBCHOICE,DVBPCE
 S DVBOPTYPE=""
 F DVBPCE=1:1 S DVBCHOICE=$P(Y,",",DVBPCE) Q:'DVBCHOICE  D  ;
 . S DVBOPTYPE=DVBOPTYPE_DVBTYPE(DVBCHOICE)
 ;
 Q  ; Quit SELTYPE
