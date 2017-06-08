AJK1UBTU ;580/MRL - Collections, XMIT Update Status; 03-Dec-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This routine is called for a couple of purposes.  The tag CHECK
 ;is the only supported call.  Calling CHECK with +C will cause
 ;a clean-up process to be initiated.  Messages will be checked
 ;to make sure they've been transmitted to the remote domain and,
 ;if so, then any status updates associated with those messages
 ;will be updated to reflect transmission completed.  Calling CHECK
 ;with '+C simply checks the environment to see if all messages have
 ;been transmitted but performs no updating.  If +S, then the
 ;messages which are pending are stored in ^TMP.
 ;
CHECK(S,C) ; --- check messages to make sure they've left
 ;             if messages haven't been sent after X days
 ;                1)  return 1 (or greater, # of messages)
 ;                2)  Save in ^tmp, if S (ignore S, if C)
 ;                3)  C = clean up old entries
 ;
 N I,X,Y,J,Q,Z
 K ^TMP($J,"AJKR")
 S (Z,I)=0 F  S I=$O(^DIZ(580950.7,"AO",1,I)) Q:I'>0  D
 .S X=$P($G(^DIZ(580950.7,+I,0)),"^",5) Q:X'>0
 .I '$D(^XMB(3.9,+I,0)) Q  ;message purged/stop
 .I C S (J,Q)=0 F  S J=$O(^XMB(3.9,+I,1,J)) Q:J'>0  S Y=^(J,0) D
 ..I Y["@" S Q=(Q+1) I Q,$P(Y,"^",5) S Q=(Q-1) ;remote xmit recipient
 .I C D:'Q CLEAN Q  ;no remote recipient
 .S Y=$$PIECE^AJK1UBCP(12) S:'Y Y=3
 .I $$DAY(X,Y)<DT Q  ;too soon
 .S J=0 F  S J=$O(^XMB(3.9,+I,1,J)) Q:J'>0  S Y=^(J,0) D:Y["@"
 ..I '$P(Y,"^",5) S:S ^TMP($J,"AJKR",+I)="" S Z=Z+1
 S S=Z
 Q S
 ;
CLEAN ; --- remove active flag from message file
 ;
 K ^DIZ(580950.7,"AO",1,+I)
 S $P(^DIZ(580950.7,+I,0),"^",5)=""
 ;
 ; --> clean up status change file when msg sent
 ;
 S G=0 F  S G=$O(^AJK1UBS("AM",I,G)) Q:G'>0  D
 .S $P(^AJK1UBS(G,0),"^",4)=""
 .K ^AJK1UBS("AO",1,G)
 K G,G1,M,P Q
 ;
DAY(X1,X2) ; --- get day in future/past
 ;
 N I,X,Y
 D C^%DTC Q X
