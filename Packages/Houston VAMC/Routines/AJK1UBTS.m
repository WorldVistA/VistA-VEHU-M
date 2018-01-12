AJK1UBTS ;580/MRL - Collections, XMIT Status Change; 15-Nov-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This routine is called by AJK1UBT to create the transmission
 ;array in ^tmp for status changes.
 ;
 Q
 ;
EN ; --- process status updates/file in status change file
 ;
 S IEN=0 F  S IEN=$O(^AJK1UB("AO",1,IEN)) Q:IEN'>0  D
 .S N=$G(^AJK1UB(+IEN,0)) ;zeroth node
 .I $D(^TMP($J,"AJK","N",IEN)),'+^(IEN) Q  ;new xmit today/ignore
 .S TD=$P(N,"^",2) ;initial xmit date
 .D UPDATE^AJK1UBTC(IEN,TD,"*","") ;14-day review/430 comments
 .S AJKU=0 F  S AJKU=$O(^PRCA(433,"C",+IEN,AJKU)) Q:AJKU'>0  D
 ..I $D(^AJK1UBS(+AJKU,0)) Q  ;already xmited
 ..S X=$G(^PRCA(433,+AJKU,1))
 ..I +X'>TD Q  ;status date not after inital xmit
 ..S C=+$G(^PRCA(430.3,+$P(X,"^",2),580000))
 ..I C=5,+$G(^PRCA(430,+IEN,7))>0 Q  ;no cx/balance on file
 ..S AJKC=$P($G(^DIZ(580950.8,+C,0)),"^",2)
 ..Q:AJKC=""  ;no status code
 ..;S D=$$TS^AJK1UBTB(IEN,AJKC) ;xmit string
 ..D TS^AJK1UBTB(IEN,AJKC) Q:'STR
 ..S D=STR(1),STR(2)=""  ;xmit string
 ..I '$$SET^AJK1UBT(0,AJKU,0,IEN,D,STR(2),AJKC) Q  ;unable to set ^tmp
 ..;D UPDATE^AJK1UBTC(IEN,DT,AJKC) ;comments
 ..;
LOCK ..; --- return here if lock unsuccessful
 ..;
 ..L ^AJK1UBS(+AJKU):1 G:'$T LOCK
 ..S ^AJK1UBS(+AJKU,0)=+AJKU_"^^^1^^^^^^"_+IEN ;zeroth node
 ..S ^AJK1UBS(+AJKU,"R",0)="^^1^1^"_DT ;xmit zeroth node
 ..;S ^AJK1UBS(+AJKU,"R",1,0)=D ;transmit string
 ..S ^AJK1UBS(+AJKU,"R1")=D ;xmit string
 ..S ^AJK1UBS("B",+AJKU,+AJKU)="" ;'B' x-ref
 ..S ^AJK1UBS("AO",1,+AJKU)="" ;not sent flag
 ..S ^AJK1UBS("AR",+IEN,+AJKU)="" ;primary record x-ref
 ..L
 ..;D UPDATE^AJK1UBTC(IEN,DT,AJKC) ;update status/430 comments
 ..S SC=SC+1 ;update counter
 ..S X=^AJK1UBS(0),$P(X,"^",3)=AJKU,$P(X,"^",4)=$P(X,"^",4)+1
 ..S ^AJK1UBS(0)=X
 Q
