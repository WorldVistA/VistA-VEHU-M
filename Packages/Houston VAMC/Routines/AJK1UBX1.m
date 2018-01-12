AJK1UBX1 ;580/MRL - Collections, Move old data; 05-Dec-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This routine is called to move data from version 1.0 of the
 ;collections module into the new file format associated with
 ;version 2.0.
 ;
EN ; --- enter here
 ;
 ; ==> puts master records into the new file
 ;     transmit string not taken since it wasn't stored at first
 ;     and later on it was in a different format
 ;
 I +$G(^DD("SITE",1))'=580 Q  ;only for Houston
 W !!,">>> Moving master records contained in Version 1.0 to the"
 W !?4,"new AJK1UB TRANSMITAL file..."
 I $O(^AJK1UB(0))>0,$O(^AJK1UBS(0))>0 D  Q
 .W !!,"     Conversion has already taken place..."
 S (AJKCTR,IEN)=0
 F  S IEN=$O(^DIZ(580950,IEN)) Q:IEN'>0  S X=^(IEN,0) D
 .I $D(^AJK1UB(+IEN)) Q  ;already exists
 .S Y="" F I=2:1:4 I $P(X,"^",I) S Y=Y_(I*.01)_"///"_$P(X,"^",I)_";"
 .I $P(X,"^",8) S Y=Y_".06///"_$P(X,"^",8)_";"
 .S Y=Y_".1///1" ;set flag indicating v1.0 record
 .K DD,DO,DIC
 .S DIC("DR")=Y,DIC="^AJK1UB(",(DA,DINUM,X)=+X
 .S DIC(0)="L",DLAYGO=580950.2 D FILE^DICN
 .S AJKCTR=AJKCTR+1 I '(AJKCTR#25) W "."
 .K DR,DIC,DIE,DA,Y,X
 W !!,"$$$ DONE.  Master Records moved into the AJK1UB TRANSMITAL file.."
 ;
1 ; ==> find and move status changes to AJK1UB STATUS CHANGE file
 ;
 W !!,">>> Converting Status Changes into new file format..."
 S X1=DT,X2=-60 D C^%DTC S OLD=X,AJKCTR=0
 S IEN=0 F  S IEN=$O(^AJK1UB(IEN)),J=0 Q:IEN'>0  S IEN(0)=$G(^(IEN,0)) D
 .F  S J=$O(^PRCA(433,"C",+IEN,J)) Q:J'>0  D
 ..S X=$G(^PRCA(433,+J,580000))
 ..I +X=0!(+X>OLD) Q  ;not updated yet/retransmit last 60 days
 ..S CTT=+$P(^PRCA(433,+J,1),"^",2),CTT=+$G(^PRCA(430.3,+CTT,580000))
 ..D UPDATE(IEN,J,CTT,X)
 ..S AJKCTR=AJKCTR+1 I '(AJKCTR#25) W "."
 W !!,"$$$ DONE.  Status Change file updated, master cross-referenced."
 Q
 ;
UPDATE(A,B,C,D) ; --- update status change
 ;
 N IEN,J,X,CTT
 K DD,DO,DIC
 S REC=+B,CTT=+C,IEN=+A,DIC="^AJK1UBS("
 I CTT=2,$P(^AJK1UB(+IEN,0),"^",4)=1 Q  ;active suspension
 S DIC("DR")=".02///"_$P(D,"^",1)_";.03///"_$P(D,"^",2)_";.1///"_+A
 S DIC(0)="L",DLAYGO=580950.3,(DA,X,DINUM)=+B D FILE^DICN
 K DIC,DA,DLAYGO,DINUM
 I $D(^AJK1UB(+IEN,0)) D
 .S $P(^AJK1UB(+IEN,0),"^",5)=+REC
 .S $P(^AJK1UB(+IEN,0),"^",7)=+CTT
 K REC Q
 ;
OTHER ; --- loop thru and close records that don't have 580000 node
 ;
 S IEN=0 F  S IEN=$O(^AJK1UB(IEN)) Q:IEN'>0  S X=^(IEN,0) D:'$P(X,"^",4)
 .I '$P(X,"^",5) S Y=$O(^AJK1UBS("AR",IEN,0)) I Y W !,IEN,?30,Y
 .I $P(X,"^",5),$P(X,"^",7) Q
 .S J=0 F  S J=$O(^PRCA(433,"C",+IEN,J)) Q:J'>0  D
 ..S Y=$G(^PRCA(433,+J,580000))
 ..Q:'+Y
 ..W !,"XMIT Record (",IEN,") = ",X,!?5,"SC Record (",J,") = ",Y
 ..S CTT=+$P(^PRCA(433,+J,1),"^",2),CTT=+$G(^PRCA(430.3,+CTT,580000))
 ..W !?5,"Transaction code = ",CTT
 ..D UPDATE(IEN,J,CTT,Y)
 ..I $D(^AJK1UBS(+J,0)) W !?5,"UPDATED!!!"
