PRCAAPR ;WASH-ISC@ALTOONA,PA/RGY - PATIENT ACCOUNT PROFILE (CONT) ;3/9/94  8:41 AM
V ;;4.5;Accounts Receivable;**198,221,276,389**;Mar 20, 1995;Build 36
 ;;Per VHA Directive 2004-038, this routine should not be modified.
EN(PRCATY) ;
 NEW DIC,X,Y,DEBT,PRCADB,DA,PRCA,COUNT,OUT,SEL,BILL,BAT,TRAN,DR,DXS,DTOUT,DIROUT,DIRUT,DUOUT
ASK N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 ; PRCA*4.5*276, add blank line before prompt for easier use
 K OUT S COUNT=0 R !!,"Select DEBTOR NAME or BILL NUMBER: ",X:DTIME I "^"[$E(X) S $P(DEBT,"^",2)="" G Q
 S X=$$UPPER^VALM1(X)
 S Y=$S($O(^PRCA(430,"B",X,0)):$O(^(0)),$O(^PRCA(430,"D",X,0)):$O(^(0)),1:-1)
 I Y>0 S DEBT=$P($G(^PRCA(430,Y,0)),"^",9) I DEBT S PRCADB=$P($G(^RCD(340,DEBT,0)),"^"),^DISV(DUZ,"^PRCA(430,")=Y,$P(DEBT,"^",2)=$$NAM^RCFN01(DEBT) D COMP,EN1^PRCAATR(Y) G:$D(DTOUT) Q G ASK
 S DIC="^RCD(340,",DIC(0)="E" D ^DIC G:Y<0 ASK
 S ^DISV(DUZ,"^RCD(340,")=+Y,PRCADB=$P(Y,"^",2),DEBT=+Y_"^"_$P(@("^"_$P(PRCADB,";",2)_+PRCADB_",0)"),"^")
 D COMP,HDR^PRCAAPR1,HDR2^PRCAAPR1,DIS^PRCAAPR1 G:'$D(DTOUT) ASK
Q K ^TMP("PRCAAPR",$J) Q
 ;
EN1(DBTR) ; entry point from repayment plan worklist, called from ^RCRPWL1  PRCA*4.5*389
 ;
 ; DBTR - file 340 ien
 ;
 N BAT,BILL,COUNT,DEBT,PRCADB,PRCATY,OUT,TRAN,X,Y,Z
 K ^TMP("PRCAAPR",$J)
 S PRCATY="ALL",COUNT=0
 S PRCADB=$P($G(^RCD(340,DBTR,0)),U)  ; field 340/.01
 S ^DISV(DUZ,"^RCD(340,")=DBTR
 S DEBT=DBTR_U_$P(@(U_$P(PRCADB,";",2)_+PRCADB_",0)"),U)  ; file 340 ien ^ debtor name
 D COMP,HDR^PRCAAPR1,HDR2^PRCAAPR1,DIS^PRCAAPR1
 K ^TMP("PRCAAPR",$J)
 Q
 ;
COMP ;Compile patient bills
 K ^TMP("PRCAAPR",$J)
 NEW STAT,STAT1,CNT,Y
 S STAT1=0
 F CNT=1:1 S STAT1=+$S(PRCATY="ALL":$O(^PRCA(430,"AS",+DEBT,STAT1)),1:$O(^PRCA(430.3,"AC",+$P(PRCATY,",",CNT),0))) Q:'STAT1  F BILL=0:0 S BILL=$O(^PRCA(430,"AS",+DEBT,STAT1,BILL)) Q:'BILL  D COMP1
 I PRCADB[";DPT(" F BILL=0:0 S BILL=$O(^PRCA(430,"E",+PRCADB,BILL)) Q:'BILL  I PRCATY="ALL"!((","_PRCATY_",")[(","_$P($G(^PRCA(430.3,+$P($G(^PRCA(430,BILL,0)),"^",8),0)),"^",3)_",")) D COMP1
 F BAT=0:0 S BAT=$O(^RCY(344,"AC",PRCADB,BAT)) Q:'BAT  F TRAN=0:0 S TRAN=$O(^RCY(344,"AC",PRCADB,BAT,TRAN)) Q:'TRAN  I $G(^RCY(344,BAT,1,TRAN,0))]"",$P(^(0),"^",5)="" D COMP2
 Q
COMP1 S STAT=$P($G(^PRCA(430.3,+$P($G(^PRCA(430,BILL,0)),"^",8),0)),"^",3) Q:STAT=""
 S X=$G(^PRCA(430,BILL,7)),Y=$P(X,"^")+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)+$P(X,"^",5)
 I $P(^PRCA(430,BILL,0),"^",2)=$O(^PRCA(430.2,"AC",33,0)) S Y=-Y
 S Y=$S($P(^PRCA(430,BILL,0),"^",2)=$O(^PRCA(430.2,"AC",33,0))&(STAT'=112):0,$P(^PRCA(430,BILL,0),"^",9)'=+DEBT:0,",102,107,112,"[(","_STAT_","):Y,1:0)
 S ^TMP("PRCAAPR",$J,"C")=$G(^TMP("PRCAAPR",$J,"C"))+Y
 S ^TMP("PRCAAPR",$J,"C",STAT)=$G(^TMP("PRCAAPR",$J,"C",STAT))+Y_"^"_STAT,^(STAT,BILL)=$P(X,"^",1,5)
 Q
COMP2 ;Compile payments
 S Y=$P(^RCY(344,BAT,1,TRAN,0),"^",4)
 S ^TMP("PRCAAPR",$J,"C")=$G(^TMP("PRCAAPR",$J,"C"))-Y
 S ^TMP("PRCAAPR",$J,"C",99)=$G(^TMP("PRCAAPR",$J,"C",99))-Y_"^99",^TMP("PRCAAPR",$J,"C",99,$P(^RCY(344,BAT,0),"^")_"-"_TRAN)=$P(^RCY(344,BAT,1,TRAN,0),"^",4)
 Q
 ;
COMP3(RCBILL) ; PRCA*4.5*276
 ; Check for 1st and 3rd party payment activity on bill
 ; RCBILL is the IEN for the bill # in files #399/#430 and must be valid,
 ; check the EOB type and exclude it if it is an MRA. Otherwise,
 ; returns the EEOB indicator '%' if payment activity was found.
 ; Access to file #361.1 covered by IA #4051.
 ; Access to file #399 covered by IA #3820.
 N PRCOUT,PRCVAL,Z
 I $G(RCBILL)=0 Q ""
 I '$O(^IBM(361.1,"B",RCBILL,0)) Q ""  ; no entry here
 I $P($G(^DGCR(399,RCBILL,0)),"^",13)=1 Q ""  ;avoid 'ENTERED/NOT REVIEWED' status
 ; handle both single and multiple bill entries in file #361.1
 S Z=0 F  S Z=$O(^IBM(361.1,"B",RCBILL,Z)) Q:'Z  D  Q:$G(PRCOUT)="%"
 . S PRCVAL=$G(^IBM(361.1,Z,0))
 . S PRCOUT=$S($P(PRCVAL,"^",4)=1:"",$P(PRCVAL,"^",4)=0:"%",1:"")
 Q PRCOUT  ; EOB indicator for either 1st or 3rd party payment on bill
