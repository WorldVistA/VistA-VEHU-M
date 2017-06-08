AJK1UBT ;580/MRL - Collections, XMIT Driver; 06-Nov-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This routine is the entry point, for a scheduled task, to create
 ;transmission messages.  It should be tasked to run daily, however,
 ;there is code within the process which stops processing early
 ;Sunday and Monday mornings since, usually, there is little, if any,
 ;activity on Saturday's and Sunday's.
 ;
 K ERR,AJKERR
 S X=DT D H^%DTC G END:%Y<2 ;stop on weekends
 S X=$$EC(0)
 G END
 ;
EC(AJKEC) ; ---enter here if checking environment only
 ;
 D CPAR^AJK1UBCP ;get parameters
 I 'AJKCP D  G CHK ;bad parameters
 .F Z=1:1 S Y=+$E($P(AJKCP,"^",2),Z) Q:'+Y  D ERR(Y)
 ;
CHK ; ---  Check status of file (580950.2) zeroth node/reset 4th piece
 ;
 I '$$FILE^AJK1UBCP D ERR(4) ;bad file
 ;
 ; -->  Check transmission string setup status
 ;
 S X=$$SHOW^AJK1UBS(1,0) ;new xmit string 
 S Y=$$SHOW^AJK1UBS(2,0) ;status change string
 I 'X,'Y D ERR(5) G CHK1 ;both invalid
 D:'X ERR(6) I 'Y D ERR(7) ;6=New String bad/7=Status String bad
 ;
CHK1 ; --- continue checking status
 ;
 I '$$TGP^AJK1UBCP D ERR(8) ;transmission mailgroup
 I '$$UGP^AJK1UBCP D ERR(9) ;update mailgroup
 I '$$RGP^AJK1UBCP D ERR(10) ;report mailgroup
 I '$$RATE^AJK1UBDP(0) D ERR(12) ;no rate types
 I '$$CAT^AJK1UBDP(0) D ERR(13) ;no categories
 I '$$TRANS^AJK1UBDP(0) D ERR(14) ;no trans. types.
 I '$$PIECE^AJK1UBCP(17) D ERR(11) ;processor turned off
 I '$G(AJKEC),$O(AJKERR(0))>0 G ERQ ;stop processing due to errors
 I +$G(AJKEC) Q $D(AJKERR)  ;environment checker
 ;
 ; --> clean-up old data
 ;
 S X=$$CHECK^AJK1UBTU(0,1) ;clean xmitted msg's
 ;
 ; --> Set up the transmission global
 ;
 S (NC,RC,SC)=0 ;NC = (N)ew record (C)ounter
 ;               RC = (R)etransmit (C)ounter
 ;               SC = (S)tatus Change (C)ounter
 ;
 K ^TMP($J) ;remove existing global array
 D AUTO^AJK1UBTR ;retransmits (auto)
 D EN^AJK1UBTN ;new xmit's
 D EN^AJK1UBTS ;status changes
 ;
 ; ==> send the transmission message
 ;
 I $D(^TMP($J,"AJK")) D XMIT^AJK1UBTM ;send message
 ;
 ; ==> send the status message
 ;
 D ^AJK1UBT1
 ;
 ; ==> save the activity comments, stored in ^tmp($j,"ajk1u"
 ;     during transmission, and global setup, in the Accounts
 ;     Receivable file, COMMENTS field
 ;
 D COMMENT^AJK1UBTC
 ;
 ; ==> close records in the AJK1UB TRANSMITAL file for which a
 ;     status change transmission was initiated requesting that
 ;     effort to collect cease immediately
 ;
 S AJKREC=0 F  S AJKREC=$O(^TMP($J,"AJK1C",AJKREC)) Q:AJKREC'>0  D
 .I $D(^AJK1UB(+AJKREC,0)),$P(^(0),"^",4)=1 D
 ..K ^AJK1UB("AO",1,AJKREC)
 ..I $D(^AJK1UB(AJKREC,0)) S $P(^(0),"^",4)=""
 ;
 ; ==> set the last date searched
 ;     a)  always set to one day earlier in case a complete day
 ;         wasn't sent
 ;     b)  LDT should be there but, just in case, check prior to
 ;         attempting to set
 ;
 I $G(LDT)'?7N Q 0
 S X1=LDT,X2=-1 D C^%DTC
 S $P(^DIZ(580950.1,1,0),"^",7)=X
 ;
 ; ==> remove retransmission records (clean-up file 580950.4)
 ;
 D OLD^AJK1UBTR
 ;
 ; ==> clean up and quit
 ;
 D END
 ;
 Q 0
 ;
ERQ ; --- send error message and quit processing
 ;
 D ERR^AJK1UBTM
 D END
 Q 1
 ;
END ; --- that's all folks
 ;     kill variables, globals, etc. and quit
 ;
 D ^AJK1UBQ
 ;
 ; ==> send stat message if needed
 ;
 D ^AJK1UBFY
 Q
 ;
SET(AF,AE,AR,AP,A1,A2,AC) ; --- set ^TMP($J
 ;             aP = Primary record # for status changes; (0) otherwise
 ;             aE = entry in file
 ;             aR = (1) retransmit; (0) otherwise
 ;             aF = file (1=transmit; 0=status change)
 ;             aC = Code (status update)
 ;             a1 = transmit string (except for retransmits) 
 ;             a2 = transmit string (second line)
 ;             ^TMP($J,"AJK","N",AE) = new transmissions/retransmits
 ;             ^TMP($J,"AJK","U",AE) = update transmits/retransmits
 ;             ^TMP($J,"AJK",xxx,AE,"T",#) = transmission string
 ;
 ;             returns (1), if successful setup; (0) if not successful
 ;
 N G,N,S
 S G="^"_$S(AF=1:"AJK1UB(",1:"AJK1UBS(")_+AE_","
 I AR S N(1)=@(G_"""R1"")") ;xmit string
 I AR,AF=1 S N(2)=$G(@(G_"""R2"")")) ;for new/2nd line/if one
 I 'AR S N(1)=A1 S:AF N(2)=A2
 S S=$S(AF=1:"N",1:"U") ;n(ew), u(pdate)
 I $L(N(1)) D  Q 1 ;ok to transmit
 .S ^TMP($J,"AJK",S,AE)=AR_"^"_AP_"^"_AC ;xmit info
 .S ^TMP($J,"AJK",S,AE,"T",1)=N(1) ;original xmit string
 .I $L($G(N(2))) S ^TMP($J,"AJK",S,AE,"T",2)=N(2)
 Q 0
 ;
ERR(X) ; --- process and save errors
 ;
 D ERR^AJK1UBTE(X,$S(X=1:1,1:0)) Q
