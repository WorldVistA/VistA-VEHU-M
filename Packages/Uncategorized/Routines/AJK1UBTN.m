AJK1UBTN ;580/MRL - Collections, XMIT New String; 15-Nov-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This routine is called by AJK1UBT to create the transmission
 ;array in ^tmp($J for new records.
 ;
 Q
 ;
EN ; --- process new transmissions.
 ;
 I $$ST Q  ;limit reached/go to status update
 S X1=$S(AJKCP("S")>AJKCP("E"):AJKCP("S"),1:AJKCP("E"))
 S X2=1 D C^%DTC S SDT=X ;start date
 S X1=DT,X2="-"_AJKCP("B") D C^%DTC S EDT=X ;end date
 S (LDT,ST)=0 ;stop xmit
 F  S SDT=$O(^PRCA(430,"AJK1",SDT)),IEN=0 Q:SDT'>0!(SDT>EDT!(ST))  D
 .S LDT=SDT ;last date searched
 .F  S IEN=$O(^PRCA(430,"AJK1",SDT,IEN)) Q:IEN'>0!(ST)  D SET(IEN)
 Q
 ;
SET(X) ; --- set transmission global
 ;     X = IEN of entry to be transmitted
 ;
 N IEN
 S IEN=+X
 I +$P($G(^PRCA(430,IEN,7)),"^",7)>0 Q  ;has a payment
 I $D(^AJK1UB(+IEN,0)) Q  ;already on file
 S X=+$G(^PRCA(430,+IEN,7)) Q:'+X  ;no principle due
 I X<$$MAX^AJK1UBCP Q  ;principle less than max parameter
 I $$DC(IEN) Q  ;been referred to DC/DOJ
 ;S X=$$TS^AJK1UBTB(+IEN,9) Q:X=""  ;xmit string
 D TS^AJK1UBTB(+IEN,9) Q:'STR  ;xmit string
 I '$$SET^AJK1UBT(1,IEN,0,0,STR(1),STR(2),"") Q  ;can't transmit
 ;
LOCK ; --- return here if lock unsuccessful
 ;
 L ^AJK1UB(+IEN):1 G:'$T LOCK
 S ^AJK1UB(+IEN,0)=+IEN_"^^^1" ;zeroth node
 ;S ^AJK1UB(+IEN,"R",0)="^^1^1^"_DT ;xmit zeroth node
 ;S ^AJK1UB(+IEN,"R",1,0)=X ;xmit string saved
 S ^AJK1UB(+IEN,"R1")=STR(1) ;1st line/xmit string
 I $L($G(STR(2))) S ^AJK1UB(+IEN,"R2")=STR(2) ;2nd line/xmit string
 S ^AJK1UB("AO",1,+IEN)="" ;active x-ref
 S ^AJK1UB("B",+IEN,+IEN)="" ;'B' x-ref
 S X=$G(^AJK1UB(0)),$P(X,"^",3)=+IEN
 S $P(X,"^",4)=$P(X,"^",4)+1,^AJK1UB(0)=X ;zeroth node
 L
 ;D UPDATE^AJK1UBTC(+IEN,DT,99) ;save comments
 S NC=$G(NC)+1 ;increment new ctr
 S ST=$$ST ;if max reached/stop xmit of new records
 Q
 ;
DC(X) ; --- stop transmit if record was ever referred to DC or DOJ
 ;     checks transaction file (433) for transaction type of
 ;     referred to district counsel or department of justice.
 ;     if a match is found for the record then the xmit is
 ;     halted.
 ;
 N AJKU,IEN,Y
 S (AJKU,Y)=0,IEN=X
 F  S AJKU=$O(^PRCA(433,"C",IEN,AJKU)) Q:AJKU'>0!(Y)  D
 .S X=+$P($G(^PRCA(433,AJKU,1)),"^",2)
 .I X>2,X<5 S Y=1
 Q Y
 ;
ST() ; --- stop transmit, maximum # records reached (1=YES, 0=NO)
 ;     once limit is reached, defined in AJK1UB SITE PARAMETER
 ;     file, no further new records are transmitted, only updates.
 ;
 ;     Returns (1), if maximum has been met; (0) if not met yet
 ;
 N X
 S X=$P($G(^AJK1UB(0)),"^",4) ;current # entries in file
 I (X+1)>AJKCP("X") Q 1
 Q 0
