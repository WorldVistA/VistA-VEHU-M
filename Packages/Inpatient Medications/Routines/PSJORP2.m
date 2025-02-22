PSJORP2 ;BIR/JCH-CALCULATE FIRST DOSE FOR OE/RR 3.0 ; 4/12/10 8:59am
 ;;5.0;INPATIENT MEDICATIONS ;**80,110,111,133,189,237,417**;16 DEC 97;Build 3
 ;
 Q
ENQ(PSGP,INFO) ; start
 ; INFO (piece 1) = START DATE/TIME
 ; INFO (piece 2) = STOP DATE/TIME
 ; INFO (piece 3) = SCHEDULE
 ; INFO (piece 4) = SCHEDULE TYPE
 ; INFO (piece 5) = ORDERABLE ITEM
 ; INFO (piece 6) = ADMIN TIMES
 ;
 ;PSJ 417 new TS
 N PSGNESD,PSGSD,PSGNEFD,PSGFD,PSGSCH,PSGST,PST,PSGS0XT,PSGS0Y,PSGED,SCHFREQ,FIRST,PSGDF,PSGS,PSGSTODD,TS
 S (PSGSD,PSGNESD)=$P(INFO,U),(PSGFD,PSGNEFD)=$P(INFO,U,2),PSGSCH=$P(INFO,U,3),(PSGST,PST)=$P(INFO,U,4),PSGS0Y=$P(INFO,U,6)
 S PSGST=$S(PSGST="O":"O",1:"C"),PSGS0XT="",FIRST=""
 Q:'PSGSD "" S X=PSGSCH D ADMIN^PSJORPOE
 I ($P(INFO,"^",6)]""),($G(PSGS0Y)'=$P(INFO,"^",6)) S PSGS0Y=$P(INFO,"^",6)
 I $G(PSJLSTAT),'$G(PSGS0XT),'$$DOW^PSIVUTL(PSGSCH) D
 .N D,DA,X,PSGAT,PSGOES,PSGST,PSJNSS,PSJPWD,TEST,VALMBCK,PSGS0Y,PSGDT S X=$P(INFO,"^",3) I X]"" S PSGOES=1 D EN^PSGORS0
 I '$G(PSJLSTAT) S X2=$S(PSGS0XT>1440:(PSGS0XT\1440)+1,1:7),X1=PSGSD D C^%DTC S (PSGFD,PSGNEFD)=X
 I 'PSGS0Y S:PSGSCH["@" PSGS0Y=$P(PSGSCH,"@",2) I 'PSGS0Y S PSGS0Y=$P(PSGSD,".",2) I $G(PSGST)'="O",($E(PSGS0Y,1,2)<23),($P($G(PSJSYSW0),"^",5)=1) D
 . I $L($P(PSGSD,".",2))<3 S DCAL=$P(PSGSD,".",2) Q
 . N DCAL S DCAL=$E($$FMADD^XLFDT(PSGSD,0,1,0,0),9,10) S:DCAL PSGS0Y=DCAL
 S PSGS=$S(PSGST="C":1,PSGST="P":2,PSGST="O":4,1:"")
 S X2=PSGNESD,X1=PSGNEFD D ^%DTC S PSGDF=X+30
 K PSGD S X=$P(PSGSD,"."),PSGDW="" F Q=0:1:PSGDF-1 S X1=$P(PSGSD,"."),X2=Q D:Q C^%DTC S PSGD(X)=$E(X,4,5)_"/"_$E(X,6,7),HX=X D DW^%DTC S $P(PSGD(HX),U,2)=X
 D NOW^%DTC S PSGDT=%
 S PST=PSGST,PSGED=PSGSD D OS(PSGP,PSGST)
 I $D(PSGD)<10 Q ""
 D PRT(X) I $G(PSJLSTAT) S:$G(LAST)>PSGFD LAST=PSGFD Q +$G(LAST)
 I $G(FIRST)<PSGSD S FIRST=PSGSD
 I $P(PSGSD,".")=$P(FIRST,"."),($P($G(^PS(59.6,+$G(PSJPWD),0)),"^",5)=2),'$G(PSGS0Y) S FIRST=PSGSD
 K PSGD,TS,PSGGD,X,S,Q,QQ,QST
 Q FIRST
 ;
OS(PSGP,PSGST) ; order record set
 S SD=PSGNESD I $S($P(SD,".")>PSGNEFD:1,PSGS=1:PSGSCH["PRN",1:0) Q
 S FD=PSGNEFD,T=PSGS0XT
 S QST=$S(PST="C"!(PST="O"):PST,PST="OC":"OA",PST="P":"OP",PSGSCH["PRN":"OR",1:"CR")
 S QQ="" I QST["C" D DTS(PSGSCH) S SD=$P(SD,"."),QQ="" F X=0:0 S X=$O(PSGD(X)) Q:'X  D
 . S QQ=QQ_$S(X<SD:"",X>FD:"",'S:$P(PSGD(X),U),$D(S(X)):$P(PSGD(X),U),1:"")
 I PSGS0XT="D",PSGS0Y="" S PSGS0Y=$P(PSGNESD,".",2)
 S X=$S(QST["C"!(QST="O"):PSGS0Y,1:"")_U_QQ
 Q
 ;
DTS(SCHEDULE) ;
 K S S S=0 I SCHEDULE["@"!(PSGST="D") S WD=$S(SCHEDULE["@":$P(SCHEDULE,"@"),1:SCHEDULE) D
 . F Q=0:0 S Q=$O(PSGD(Q)) Q:'Q  F QQ=1:1:$L(WD,"-") I $P($P(PSGD(Q),U,2),$P(WD,"-",QQ))="" S S(Q)="",S=S+1 Q
 Q:SCHEDULE["@"!(T="D")  Q:T'>1440  S WD=$P(PSGSD,".") I '(T#1440) S SD=$P(SD,"."),X=$S($G(PSGOSD):$P(PSGOSD,"."),1:SD),PSGT=T\1440 D  ;*237 Changed X to PSGOSD if it exists
 . F QQ=0:1 S X1=$S($G(PSGOSD):$P(PSGOSD,"."),1:SD),X2=QQ*PSGT S:'X2 X=X1 D:X2 C^%DTC I X'<WD S S=S+1 Q:X>PSGFD  Q:X>FD  S S(X)="" ;*237 Changed X1 to PSGOSD if it exists
 K PSGT Q:'(T#1440)  S PSGT=T,X1=PSGSD,(ST,X2)=SD I PSGSD>SD D ^%DTC I X>1 S ST=$$EN^PSGCT(SD,X-1*1440\T*T)
 S (PSGS,X)=ST F PSGX=0:1 S AM=PSGT*PSGX,(ST,X)=$S($G(PSGOSD):PSGOSD,1:PSGS) S:AM X=$$EN^PSGCT(ST,AM) S PSGSTODD(PSGX+1)=X S X=$P(X,".") I X'<WD Q:X>PSGFD  Q:X>FD  I '$D(S(X)) S S=S+1,S(X)="" ;*237 Changed ST,X to PSGOSD, added PSGSTODD
 K AM,ST,PSGS,PSGT,PSGX Q
 ;
PRT(PSGTS) ; order info
 S PSGGD=$P(PSGTS,"^",2),PSGTS=$P(PSGTS,"^") S PSJPSTO=PST
 D TS(PSGTS) D FIRST D:$G(PSJLSTAT) LAST
 S PSGOC=$G(PSGOC)+1
 Q
 ;
FIRST ; find expected first dose
 N QTS,ADMIN S FIRST=""
 I PST["CZ" NEW PSGLFFD,PSGGD S P(9)="",PSGLFFD="9999999",PSGGD="" Q
 I TS=1,'PSGTS Q
 ;*237 If frequency is >, but not a multiple of, 24 hours, and no admin times
 I $D(PSGSTODD),$G(PSGOSD),$P(INFO,U,6)="" F Q=0:0 S Q=$O(PSGSTODD(Q)) Q:'Q!$G(FIRST)  D
 . S QTS=PSGSTODD(Q)
 . S FIRST=$S(QTS<PSGSD:"",QTS'<PSGFD:"",1:QTS)
 Q:FIRST
 F Q=0:0 S Q=$O(PSGD(Q)) Q:'Q!$G(FIRST)  S ADMIN=0 F  S ADMIN=$O(TS(ADMIN)) Q:'ADMIN!$G(FIRST)  D
 . S QTS=Q_"."_TS(ADMIN)
 . S FIRST=$S(QTS<PSGSD:"",QTS'<PSGFD:"",PSGGD="":"",PSGGD[$P(PSGD(Q),"^"):QTS,1:"")
 Q
 ;
LAST ; find expected last dose
 N QTS,ADMIN S LAST=""
 I PST["CZ" NEW PSGLFFD,PSGGD S P(9)="",PSGLFFD="9999999",PSGGD="" Q
 I TS=1,'PSGTS Q
 S Q=99999999 F  S Q=$O(PSGD(Q),-1) Q:'Q!$G(LAST)  S ADMIN="" F  S ADMIN=$O(TS(ADMIN),-1) Q:'ADMIN!$G(LAST)  D
 . S QTS=Q_"."_TS(ADMIN)
 . S LAST=$S(QTS>PSGFD:"",QTS'>PSGSD:"",PSGGD="":"",PSGGD[$P(PSGD(Q),"^"):QTS,1:"")
 Q
 ;
TS(X) ;
 K TS S TS=$L(X,"-") F Q=1:1:TS S TS(Q)=$P(X,"-",Q)
 Q
 ;
LASTAT(PSGP,INFO) ;
 N LSTDT,PSJLSTAT S LASTAT=0,PSJLSTAT=1 S LASTAT=$$ENQ(PSGP,INFO)
 I (LASTAT>$P(INFO,"^",2)!'LASTAT) S LASTAT=$P(INFO,"^",2)
 K PSGD,TS,PSGGD,X,S,Q,QQ,QST
 Q LASTAT
