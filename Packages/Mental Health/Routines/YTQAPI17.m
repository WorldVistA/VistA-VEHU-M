YTQAPI17 ;ALB/ASF - MHA REMOTE PROCEDURES IMPORT ;3/18/10 3:16pm
 ;;5.01;MENTAL HEALTH;**96,217,235,233,240**;Dec 30, 1994;Build 10
 ;
 ;No external references in this routine
 ;
 Q
SAVEALL(YSDATA,YS) ;save all answers from an administration
 ;input: AD = ADMINISTRATION #
 ;output: [DATA] vs [ERROR]
 N G,G1,N,N1,YSIENS,YSAD,YSQN,YSCI,YSCODE,YSOP,YSFLAG
 S YSDATA(1)="[ERROR]"
 S YSAD=$G(YS("AD"))
 I YSAD'?1N.N S YSDATA(2)="bad ad num" Q  ;-->out
 I '$D(^YTT(601.84,YSAD)) S YSDATA(2)="NO Admin set" Q  ;-->out
 ;loop thru YS
 S YSFLAG=0,N=0 F  S N=$O(YS(N)) Q:(N'>0)!(YSFLAG)  D
 . S YSQN=$P(YS(N),U),YSCI=$P(YS(N),U,2)
 . ;use old ien
 . I $D(^YTT(601.85,"AC",YSAD,YSQN)) S YSIENS=$O(^YTT(601.85,"AC",YSAD,YSQN,0))
 . ;set new ien
 . I '$D(^YTT(601.85,"AC",YSAD,YSQN)) S YSIENS="",YSIENS=$$NEW(601.85)
 . I YSIENS'?1N.N S YSFLAG=1,YSDATA(1)="[ERROR]",YSDATA(2)="bad ans ien" Q  ;-->out
 . L +^YTT(601.85,YSIENS):DILOCKTM
 . I '$T S YSFLAG=1,YSDATA(1)="[ERROR]",YSDATA(2)="time out" Q  ;-->out
 . S ^YTT(601.85,YSIENS,0)=YSIENS_U_YSAD_U_YSQN_U_YSCI
 . S ^YTT(601.85,"B",YSIENS,YSIENS)=""
 . S ^YTT(601.85,"AC",YSAD,YSQN,YSIENS)=""
 . S ^YTT(601.85,"AD",YSAD,YSIENS)=""
 . K ^YTT(601.85,YSIENS,1)  ; reset ANSWERS wp field since saving over it
 . S N1=0 F  S N1=$O(YS(N,N1)) Q:N1'>0  S ^YTT(601.85,YSIENS,1,N1,0)=YS(N,N1),^YTT(601.85,YSIENS,1,0)=U_U_N1_U_N1_U_DT_U
 . L -^YTT(601.85,YSIENS)
 . S YSDATA(2)=N_"^OK"
 ;set has been operational
 S YSDATA(1)="[DATA]"
 D UPANS^YTQEVNT($G(YSAD),"saveall") ; publish admin update event
 S YSCODE=$P(^YTT(601.84,YSAD,0),U,3)
 S YSOP=$P($G(^YTT(601.71,YSCODE,2)),U,2)
 S:YSOP="Y" $P(^YTT(601.71,YSCODE,2),U,5)="Y"
 Q
NEW(YSFILEN) ; Adding New Entry -- return IEN -- use incremental locking
 N MHQ2X,MHQ2XFND,YS
 S YS=$P($G(^YTT(YSFILEN,0)),U,3) S:YS<1 YS=1
 I '$D(^XUSEC("YSPROG",DUZ)),(YS<100000) S YS=100000 ; Natl pointers <100000
 S MHQ2XFND=0
 L +^YTT(YSFILEN,0):DILOCKTM Q:'$T ""
 F MHQ2X=YS:1 I '$D(^YTT(YSFILEN,MHQ2X)) D  Q:MHQ2XFND
 . S ^YTT(YSFILEN,MHQ2X,0)=MHQ2X,MHQ2XFND=1
 . S $P(^YTT(YSFILEN,0),U,3)=MHQ2X
 . S $P(^YTT(YSFILEN,0),U,4)=$P($G(^YTT(YSFILEN,0)),U,4)+1
 L -^YTT(YSFILEN,0)
 Q MHQ2X
 ;
