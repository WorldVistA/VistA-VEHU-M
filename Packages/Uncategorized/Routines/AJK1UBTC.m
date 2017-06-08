AJK1UBTC ;580/MRL - Collections, XMIT Update Comments/430; 14-Nov-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This routine is called by AJK1UBT to update the comments field in
 ;the accounts receivable file (#430).  Comments are automatically
 ;inserted whenever:
 ;
 ;    >  Initial transmission occurs to collections.
 ;    >  Every 14 days thereafter, until the record is closed, a
 ;       comment is inserted indicating that the collections
 ;       agency has performed a review.
 ;    >  When the record is transmitted as no longer requiring
 ;       collections action.
 ;    >  When a partial payment is made (decrease adjustment).
 ;    >  When a record is retransmitted.
 ;
UPDATE(B,D,T,S) ; --- stores update in ^TMP
 ;             B = Bill Number (ien)
 ;             D = Transmission Activity Date
 ;             S = Transaction Subtype (cancel, Suspend, etc.)
 ;             T = Transaction Type
 ;                 Values in AJK1UB STATUS CODE file
 ;                 N - New RECORD Transmission
 ;                 U - Status Change Transmission
 ;                 $ - RE-transmission Suffix (x$)
 ;                 * = 14 day review update
 ;                 (The code actually transmitted is defined by the
 ;                 user in the Accounts Receivable Transaction Type
 ;                 file.  For instance, a "waived" bill is usually
 ;                 transmitted as "cancelled" for collection purposes.)
 ;
 N X,X1,X2,Y,Z
 D DATE(D) S X=Y
 G D14:T="*"
 S X=Y_AJKCP("V")_" ",TT=1
 ;
 ; ==> retransmission message
 ;
 I T["$" S X=X_"sent/RETRANSMISSION of " D  G SET
 .S X=X_" "_$S(T["U":"Status Change",1:"Original Transmission")_" "
 ;
 ; ==> new message
 ;
 S X=X_"notified/"
 I T="N" S X=X_"COMMENCE collection efforts." G SET
 ;
 ; ==> status change
 ;
 S Y=$G(^DIZ(580950.8,+$G(S),0)) ;zeroth node of status code file
 I +$P(Y,"^",4) S X=X_"HALT collection" ;record closed
 E  S X=X_"UPDATE Status" ;change only
 S X=X_"/"_$P(Y,"^",5) ;specific transaction
 ;
SET ; --- come here to set global
 ;
 I X?1"|TAB|<<".2N.E S ^TMP($J,"AJK1U",B,TT,D)=X
 Q
 ;
D14 ; --- update 14 day reviews
 ;
 S X=$G(^AJK1UB(+B,0))
 S RVW=+$P(X,"^",6) ;# 14-day reviews done
 S TT=2,START=$P(X,"^",2) Q:'START
 S END=DT I '$P(X,"^",4) D
 .S X=+$P(^PRCA(430,+B,0),"^",8),X=$G(^PRCA(430.3,+X,580000))
 .Q:X'=""  S X=$P(^PRCA(430,+B,0),"^",14) S:+X END=X
 S GO=1,AJK=START,NR=(RVW+1) Q:NR>5
 F AJK1=NR:1:5 Q:'GO  S X1=AJK,X2=(AJK1*14) D C^%DTC D
 .I X'<END S GO=0 Q
 .S Z=X D DATE(X) S X=Y_"14-day review performed by "_AJKCP("V")_"."
 .S ^TMP($J,"AJK1U",B,TT,Z)=X,RVW=RVW+1,$P(^AJK1UB(+B,0),"^",6)=RVW
 Q
 ;
DATE(X) ; --- convert fm date to dd-mmm-yy format
 ;
 N D,M
 S D=$E($E(X,6,7)_"00",1,2)
 S M=$P("Jan^Feb^Mar^Apr^May^Jun^Jul^Aug^Sep^Oct^Nov^Dec","^",+$E(X,4,5))
 S Y="|TAB|<<"_D_"-"_M_"-"_$E(X,2,3)_">>> " Q
 ;
COMMENT ; --- save comments stored during transmission
 ;
 S ZZ=0 F  S ZZ=$O(^TMP($J,"AJK1U",ZZ)) Q:ZZ'>0  D SAVE(ZZ)
 K ZZ,^TMP($J,"AJK1UB") Q
 ;
SAVE(R) ; --- save data in comments field
 ;
 N I,J,X,Y,N,E,K,TEXT,LINE
 S N=$G(^PRCA(430,+R,10,0)),LINE=0 ;zeroth node
 S I=0 F  S I=$O(^PRCA(430,+R,10,I)) Q:I'>0  S X=^(I,0) D
 .S TEXT(I)=X,LINE=LINE+1
 F I=1,2,3 I $D(^TMP($J,"AJK1U",R,I)) S J=0 D
 .F  S J=$O(^TMP($J,"AJK1U",R,I,J)) Q:J'>0  S X=^(J) D
 ..S (E,K)=0 F  S K=$O(TEXT(K)) Q:K'>0!(E)  S Y=TEXT(K) D
 ...I $E(X,1,45)=$E(Y,1,45) S E=1 Q  ;text already exists
 ..I 'E S LINE=LINE+1,TEXT(LINE)=X
 I $O(TEXT(0))>0 D
 .K ^PRCA(430,+R,10)
 .S $P(N,"^",3)=LINE,$P(N,"^",4)=LINE,$P(N,"^",5)=DT,I=0
 .S ^PRCA(430,+R,10,0)=N
 .F  S I=$O(TEXT(I)) Q:I'>0  S ^PRCA(430,+R,10,I,0)=TEXT(I)
 Q
