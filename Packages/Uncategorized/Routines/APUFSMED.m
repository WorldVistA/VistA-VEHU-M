APUFSMED ; 648/RSF-BFD RENEWAL PROGRAM - CREATE UNSIGNED NOTIFICATION ; 3/6/04
 ;;5.0; PORTLAND,OR APPLICATION
 ;
 ; VA Utilities for MAudio Care (renewals) 
 ;  INCLUDES CHANGES TO MAKE NEW VEXRX (BAY PINES) WORK
 ;
 Q
 ;  Program called by APUVEXU
 ;  4-11-07:  Split out the PCP programming and the ALL programming because exceeds size limits 
 ;  New routines are APUFSMEP and APUFSMEA
 ;  
 ;  
 ; BFD Note:  
 ; 
 ; USR is generic audiocare user set up in 200
 ; APUOLDOR is placer order from 52
 ; C tells if 'P' or 'A" 
 ; TYPENU tells if DEA indicates not allow renew/refill
 ; 
 ; Provider is piece 3 of node three in 100   (APUPROV)
 ; Signed by is piece 5 of node three in 100  (APUPSIG)
 ; 
 ; General logic if 'provider' and 'signed by' different:  'Provider' is the person communicate with
 ; Also, If 'written on chart,' 'provider' is only field of the two that is populated
 ; 
 ;Send back results:
 ; RESULT=0  some kind of problem w/order using as template
 ; RESULT=2  status indicates 'human intervention' so tell AudioCare not 'talk' to provider
 ; RESULT=3  "P" parameter & order not from PCP/MHPCP
 ; RESULT=5  Provider(s) on order terminated - no one to send order to
 ;
RENEW(RESULT,APUOLDOR,RVRX,USR,RPCP,RMPCP,C,DEA4N,TYPENU) ;
 ;;
 ;W !!,"NOW IN RENEW^APUFSMED AND PREV ORDER IS "_APUOLDOR
 N ORDERNO,APUNOWT,APUNOWD,PU,COMM,APUENT,APUPSIG,APUPI,APUPROV,APUSEND,APUSIG,APUORDP,APUPROV
 S APUENT=USR,RESULT=0,APUSEND=0
 ; BFD NOTE:  3rd piece of node 3 is order status.  If not expired or active, then send result=2 & quit
 ;S ORDST=$P(^OR(100,APUOLDOR,3),"^",3) W !,"Rob checked if this = 6.  It is "_ORDST
 ;S ORDST=$P(^OR(100,APUOLDOR,3),"^",3) W !,"Rob checked if this = 7.  It is "_ORDST
 ;
 I $P(^OR(100,APUOLDOR,3),"^",3)'=6&($P(^OR(100,APUOLDOR,3),"^",3)'=7) S RESULT=2 Q
 ;
 ; BFD NOTE:  6th piece of node 3 is replacement order.  If there is a value then someone has already replaced this order
 ; and nothing further should be done
 S ORD2=$P(^OR(100,APUOLDOR,3),"^",6)
 I $P(^OR(100,APUOLDOR,3),"^",6)'="" S RESULT=2 G HEYQ
 ;
 ; BFD 11-8-04  Result 3 means not by PCP/MHPCP & parameter requires PCP/MHPCP.  
 ;   but APUVEX needs provider that signed last time 
 ;   *** check when surrogates involved - if data in 5 & it is diff thatn data in 3 which goes back to APUVEX
 ;
 S APUPROV=$P(^OR(100,APUOLDOR,8,1,0),"^",3) S APUPSIG=$P(^OR(100,APUOLDOR,8,1,0),"^",5)
 I C="P" D PCPLIMIT^APUFSMEP I RESULT'=1 G HEYQ
 I C="A" D ALLIMIT2^APUFSMEA I RESULT'=1 G HEYQ
 ;
 D NOW^%DTC S APUNOWT=%,APUNOWD=X
 ;
 ; 3-27-07:  Note fall into following code
LABEL LOCK ^OR(100,0):1 G:'$T LABEL D  LOCK
 . S ZERONODE=^OR(100,0)
 . S ORDERNO=$P(ZERONODE,"^",3) S ORDERNO=ORDERNO+1 S $P(ZERONODE,"^",3)=ORDERNO
 . S COUNTNO=$P(ZERONODE,"^",4) S COUNTNO=COUNTNO+1 S $P(ZERONODE,"^",4)=COUNTNO
 . S ^OR(100,0)=ZERONODE
 M ^OR(100,ORDERNO)=^OR(100,APUOLDOR)
 S $P(^OR(100,ORDERNO,0),"^",1)=ORDERNO,$P(^(0),"^",6)=APUENT,$P(^(0),"^",7)=APUNOWT,$P(^(0),"^",8)="",$P(^(0),"^",9)=""
 S $P(^OR(100,ORDERNO,3),"^",1)=APUNOWT,$P(^(3),"^",3)=11,$P(^(3),"^",5)=APUOLDOR,$P(^(3),"^",11)=2
 K ^OR(100,ORDERNO,4)
 S PU=$O(^OR(100,ORDERNO,4.5,"ID","PICKUP"," "),-1)
 I PU'>"" S PU=$O(^OR(100,ORDERNO,4.5," "),-1)+1,^OR(100,ORDERNO,4.5,"ID","PICKUP",PU)="",^OR(100,ORDERNO,4.5,PU,0)="9^148^1^PICKUP"  ;S RESULT=0 G HEYQ
 S ^OR(100,ORDERNO,4.5,PU,1)="M"
 S COMM=$O(^OR(100,ORDERNO,4.5,"ID","COMMENT"," "),-1) S:+COMM ^OR(100,ORDERNO,4.5,COMM,2,0)="^^-1^-1^"_APUNOWD_"^"
 I COMM="" D
 . S APUX=$O(^OR(100,ORDERNO,4.5," "),-1),^OR(100,ORDERNO,4.5,APUX,0)="6^15^1^COMMENT"
 . S ^OR(100,ORDERNO,4.5,"ID","COMMENT",APUX)=""
 . S ^OR(100,ORDERNO,4.5,APUX,2,0)="^^-1^-1^"_APUNOWD_"^"
 S APUSIG=$O(^OR(100,ORDERNO,4.5,"ID","SIG"," "),-1) S:APUSIG'="" ^OR(100,ORDERNO,4.5,APUSIG,2,0)="^^1^1"_APUNOWD_"^^"
 S APUPI=$O(^OR(100,ORDERNO,4.5,"ID","PI"," "),-1) S:APUPI'="" ^OR(100,ORDERNO,4.5,APUPI,2,0)="^^1^1"_APUNOWD_"^^"
 ; BFD - Add piece 12 set to 3 (that changes nature of order to 'telephone'
 S $P(^OR(100,ORDERNO,8,1,0),"^",1)=APUNOWT,$P(^(0),"^",4)=2,$P(^(0),"^",5)="",$P(^(0),"^",6)="",$P(^(0),"^",13)=APUENT,$P(^(0),"^",15)=11,$P(^(0),"^",12)="3"
 S ^OR(100,ORDERNO,8,1,0)=$P(^OR(100,ORDERNO,8,1,0),"^",1,15)
 S ^OR(100,ORDERNO,8,1,.1,0)="^^3^3^"_APUNOWD_"^"
 S DIK="^OR(100,"
 S DA=ORDERNO
 D IX^DIK
 S RESULT=1
 D HEY  ;SEND UNSIGNED ORDER ALERT
 Q
 ;
 ; 3-27-07:  Note that HEY called from within APUFSMED
HEY ;  BFD/5-4-04  Change XQAMSG per Dr. Douglas, 2-14-05, chg 'N' msgs per Dr. Douglas
 ;UNSIGNED ORDER ALERT
 ; only here if result =1"
 ;W !!,"In HEY^APUFSMED.  Check if result is really 1... "_RESULT
 N DFN,APUWORD,XQA,XQADATA,APUPT,XQAROU,XQID,XQAMSG
 S DFN=$P($P(^OR(100,ORDERNO,0),"^",2),";")
 Q:$P($G(RESULT),"^")=0
 S XQA(APUSEND)="",XQADATA=ORDERNO_"@"
 S APUPT=$E($P(^DPT(DFN,0),"^"),1,10)_" ("_$E($P(^(0),"^",9),6,9)_")"
 S XQAROU="ESORD^ORB3FUP1"  ;CHECK PKG NAME AND TAG (CAN ALSO BE NEWORD^ORB3FUP1)
 ;IF THIS DOESN'T WORK TRY NEWORDESORD^ORB3FUP1
 S XQAID="OR,"_DFN_",12;"  ;XQAID MAY NOT BE THE SAME AS FOR LAB, CHECK
 I TYPENU["U" S XQAMSG=APUPT_": RX Renewal Request for "_RVRX
 ; LOCAL/BFD 6-27-05 No longer sending unsigned for 'N' so remark out this code.  Remove completely later
SEND ; 3-27-07:  Cannot find call within APUFSMED so appears as if code fall into SEND
 D SETUP^XQALERT
 S RESULT=1_"^"_APUSEND
 Q
 ;       
HEYQ ; 3-27-07: Called from within APUFSMED
 K C,TYPENU,USR,RPCP,RMPCP,APUOLDOR,RVRX,RSF,XQAROU,XQID,XQAMSG,XQA,XQADATA,APUPT,APUX
 K APUNOWD,APUPI,ORD2,APUPROV,APUPSIG,ZERONODE,ORDERNO,APUENT,APUNOWT,PU,COMM,APUFLG,APUSIG
 Q
