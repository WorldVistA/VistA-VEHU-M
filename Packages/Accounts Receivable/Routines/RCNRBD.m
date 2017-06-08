RCNRBD ;Washington ISC@Altoona,Pa/TJK-BAD DEBT ALLOWANCE ;5/22/95  12:01 PM
V ;;4.5;Accounts Receivable;**4**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN1 ;Base Percentage Calculation
 L +^RC(348.1)
 N BEG,END,DEBTOR,ACTDT,BILL,B0,B7,CAT,TRANS,T0,T1,TTYPE,TCA,TPAY,AMT
 N TDEC,TWO,TPRIN,COLPER,WOPER,CAPER,CANPER,PENPER,DIC,DIE,DA,DR,APP
 N DLAYGO
 S X1=DT,X2=-720 D C^%DTC S BEG=$E(X,1,5)_"00"
 S X1=DT,X2=-360 D C^%DTC S END=$E(X,1,5)_"31.9999"
 S BILL=0 F  S BILL=$O(^PRCA(430,BILL)) Q:BILL'?1N.N  S B0=$G(^(BILL,0)),B7=$G(^(7)),B6=$G(^(6)) D
    .Q:$P(B0,U,8)=27
    .S ACTDT=$P(B6,U,21)
    .S:'ACTDT ACTDT=$P(B0,U,10)
    .I ACTDT>BEG,ACTDT<END D
       ..S (CAT,APP)=0 D TPRIN(.CAT,.APP)
       ..Q:'CAT!('APP)
       ..S TRANS=0
       ..F  S TRANS=$O(^PRCA(433,"C",BILL,TRANS)) Q:'TRANS  D
          ...S T0=$G(^PRCA(433,TRANS,0)),T1=$G(^(1)),T8=$P($G(^(8)),U,8)
          ...Q:$P(T0,U,4)'=2
          ...S (AMT,X)=0 F  S X=$O(^PRCA(433,TRANS,4,X)) Q:'X  D
             ....S AMT=AMT+$S($P(^(X,0),U,5)<0:-$P(^(0),U,5),1:$P(^(0),U,5))
             ....Q
          ...Q:'AMT
          ...S TTYPE=$P(T1,U,2) Q:'TTYPE
          ...I (TTYPE=2)!(TTYPE=34) S TPAY(APP)=$G(TPAY(APP))+AMT Q
          ...I TTYPE=35 S:'T8 TDEC(APP)=$G(TDEC(APP))+AMT S:T8 TCA(APP)=$G(TCA(APP))+AMT Q
          ...I ",8,9,10,11,"[(","_TTYPE_",") S TWO(APP)=$G(TWO(APP))+AMT Q
          ...Q
       ..Q
    .Q
 F APP="0160",2431,5014 D
    .S (COLPER(APP),WOPER(APP),CAPER(APP),CANPER(APP),PENPER(APP))=0
    .S TBILLS(APP)=$G(TPRIN(APP))+$G(TPAY(APP))+$G(TWO(APP))+$G(TDEC(APP))+$G(TCA(APP))
    .G EN1A:'TBILLS(APP)
    .S COLPER(APP)=$J($G(TPAY(APP))/TBILLS(APP)*100,0,2)
    .S WOPER(APP)=$J($G(TWO(APP))/TBILLS(APP)*100,0,2)
    .S CAPER(APP)=$J($G(TCA(APP))/TBILLS(APP)*100,0,2)
    .S CANPER(APP)=$J($G(TDEC(APP))/TBILLS(APP)*100,0,2)
    .S PENPER(APP)=100-(COLPER(APP)+WOPER(APP)+CAPER(APP)+CANPER(APP))
EN1A    .K DIC,DR,DA,DIE
    .S DIC="^RC(348.1,",DIC(0)="QL",X=APP,DLAYGO=348.1 D ^DIC
    .S DA=+Y,DIE=DIC
    .S DR=".02///^S X=+COLPER(APP);.03///^S X=+WOPER(APP);.04///^S X=+CAPER(APP);.05///^S X=+CANPER(APP);.06///^S X=+PENPER(APP)"
    .D ^DIE
    .Q
EN1Q L -^RC(348.1)
 Q
EN2 ;Monthly Calculation
 L +^RC(348.1)
 N BILL,B7,B0,TPRIN,APP,WOP,CAP,WONEW,CANEW,WOLD,CAOLD,N0
 S BILL=0
 F  S BILL=$O(^PRCA(430,BILL)) Q:BILL'?1N.N  D
    .S B7=$G(^PRCA(430,BILL,7)) Q:'B7  S B0=$G(^(0)),B6=$G(^(6))
    .Q:$P(B0,U,8)'=16
    .S (CAT,APP)=0 D TPRIN(CAT,APP)
    .Q
 F APP="0160",2431,5014 S DA=$O(^RC(348.1,"B",APP,0)) D
    .S DA=$O(^RC(348.1,"B",APP,0)) Q:'DA
    .S N0=$G(^RC(348.1,DA,0))
    .S WOP=$P(N0,U,3),CAP=$P(N0,U,4)
    .S WONEW=+$J($G(TPRIN(APP))*(WOP/100),0,2)
    .S CANEW=+$J($G(TPRIN(APP))*(CAP/100),0,2)
    .S WOLD=+$P(N0,U,8)
    .S $P(N0,U,7)=WOLD
    .S $P(N0,U,8)=WONEW
    .S CAOLD=+$P(N0,U,10)
    .S $P(N0,U,9)=CAOLD
    .S $P(N0,U,10)=CANEW
    .S $P(N0,U,12)=WONEW-WOLD
    .S $P(N0,U,11)=CANEW-CAOLD
    .S ^RC(348.1,DA,0)=N0
    .Q
 L -^RC(348.1)
EN2Q Q
EN3 ;Entry Point For Printing Report From Nightly Process
 S IOP=PRCADEV G EN32
EN31 ;Entry Point For Printing Report From Menu Option
 N CURRDT
 W !!,"Bad Debt Report Print"
 S CURRDT=+$E(DT,6,7) I CURRDT>23,CURRDT<$$LASTDAY(DT) D  Q
    .W !,"New Report Being Calculated"
    .W !,"Report Unavailable For Printing Until The Last Day Of The Month"
    .H 2
    .Q
EN32 N DIC,FR,TO,L,BY,FLDS,DHD
 S DIC="^RC(348.1,",L=0
 S FLDS="[RCNR BAD DEBT REPORT]",DHD="Bad Debt Report"
 S BY=.01,(FR,TO)="" D EN1^DIP
EN3Q Q
EN4 ;Over-Ride
 N DIC,DIE,DA,DR,N0,CURRDT
 S CURRDT=+$E(DT,6,7)
 I CURRDT'<$$WD4^RCNRBD1,CURRDT<$$LASTDAY(DT) D  Q
    .W !!,"Over-ride can only be done between the last day of the"
    .W !,"month and the 3rd workday of the following month inclusive"
    .H 2
    .Q
 S DA=0 F  S DA=$O(^RC(348.1,DA)) Q:DA'?1N.N  D
    .S (DIC,DIE)="^RC(348.1,"
    .S DR="[RCNR BAD DEBT EDIT]"
    .D ^DIE
    .S $P(^(0),U,12)=$P(^RC(348.1,DA,0),U,8)-$P(^(0),U,7)
    .S $P(^(0),U,11)=$P(^RC(348.1,DA,0),U,10)-$P(^(0),U,9)
    .K DIC,DIE,DR,N0
    .Q
EN4Q Q
LASTDAY(DATE) ;Calculates Last Day Of Month For Bad Debt Purposes
 S LDAY=+$E(DATE,4,5)
 S LDAY=$S(LDAY=4:30,LDAY=6:30,LDAY=9:30,LDAY=11:30,LDAY=2:28,1:31)
 Q LDAY
TPRIN(CAT,APP) ;Calculate Total Principal
 S CAT=$P(B0,U,2) Q:'CAT
 S CAT=$P($G(^PRCA(430.2,CAT,0)),U,7)
 I ",1,2,3,24,31,32,"[(","_CAT_",") S APP=2431
 I ",21,23,26,27,29,30,"[(","_CAT_",") S APP=5014
 I ",20,25,28,"[(","_CAT_",") S APP="0160"
 Q:'APP
 S TPRIN(APP)=$G(TPRIN(APP))+B7
TPRINQ Q
