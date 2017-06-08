ZZVST150 ;ISC-ALB/CAW-JMS-MJB - UTILITY TO CHECK 150 NODE IN VISIT FILE  ; Compiled 04/20/98 09:36AM for M/WNT
 ; NO VERSION;PCE ENCOUNTERS;APRIL 17, 1998
 ;
 ; This is a class III routine which will simply $Order down the 
 ; VISIT file (AUPNVSIT).  It checks for the 150 node, if it is 
 ; defined, it QIUTs.  If a record has no 150 node, it sets the
 ; second piece to 2 via a call to DIE.
START ;
 W !,?5,"This routine will run down the VISIT file"
 W !,?5,"checking for a 150 node.  If the node is NOT DEFINED"
 W !,?5,"I'm going to set it !!!"
 W !!,?5,"and there is nothing you can do about it.. :-)  "
 ;
 W !!,?5,"Are you ready to run" S %=1 D YN^DICN
 I %=-1 Q
 I %=2 Q
 I %=0,%=1 D LOOP,PRINT
 ;
LOOP S I=0,JMS=0,^TMP($J,JMS)=0
 F  S I=$O(^AUPNVSIT(I)) Q:'I  D
 . Q:$G(^AUPNVSIT(I,150))
 . S DIE="^AUPNVSIT("
 . S DA=I
 . S DR="15002////2"
 . S JMS=DA,^TMP($J,JMS)=$G(^AUPNVSIT(DA,0))
 . D ^DIE  W !,?5,"."
 ;
PRINT ; This will list the ^TMP data which should be the zero nodes in
 ; the visit file
 W !!!,?5,"I have captured the visit file records which I've added"
 W !,?5,"the 150 node to...."
 W !!,?5,"Would you care to see them" S %=2 D YN^DICN
 I %=-1,%=0,%=2 D CLEAN
 I %=1 W !!,?5,"I'm no programmer, capture this or slave",!,?5,"it out",!!! H 2  ZW ^TMP($J,JMS)
 ;         
CLEAN K ^TMP($J),%,I,JMS,DA,DR,DIE
 Q
