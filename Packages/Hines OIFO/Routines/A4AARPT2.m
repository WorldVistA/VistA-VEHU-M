A4AARPT2 ;HINES-CIOFO/JJM - ROUTINE TO PRINT REPORT  3/01/99 15:45
V ;;1.0;**** CLASS III ****;;JUN 30, 1998
 S:'$G(DEBTOR) DEBTOR=+$G(A4ADEB)
 Q:'DEBTOR
 S FLAG1=1
 N RFLAG
 I '$G(END) S END=0 D SETUP^A4AARPT
 D:'$G(SDT) GETLSD^A4AARPT5
PRTRPT3 ;
 N BILL
 U IO
 S (LST1,LST2,LST3,LST4,LST5,LST6,SRBAL)=0
 S:'$G(FLAG1) FLAG1=1 ; DEFAULT = PRINT
 D:$G(DATE1)="" GETDAT
 U IO
 D PRTHDR3
 S TRANS="",RBAL=0,NATOTAL=0,TAMT=0,SRBAL=0
 S XDATE1=0
 F  S XDATE1=$O(^XTMP("A4AARPT",$J,XDATE1)) Q:(XDATE1="")!(END)  D
    . S BILL=""
    . F  S BILL=$O(^XTMP("A4AARPT",$J,XDATE1,BILL)) Q:(BILL="")!(END)  D
         .. S XTRANS1="",TRANS=0
         .. ; D:$G(^XTMP("A4AARPT",$J,XDATE1,BILL))=1 PRTTRANS,PRTTRAN2
         .. D:$G(^XTMP("A4AARPT",$J,XDATE1,BILL))=1 PRTTRAN2
         .. F  S XTRANS1=$O(^XTMP("A4AARPT",$J,XDATE1,BILL,XTRANS1)) Q:(XTRANS1="")!(END)  S TRANS=XTRANS1 D PRTTRAN3
 Q:END
 ; S Y=DATE1 X ^DD("DD")
 S Y=SDT X ^DD("DD")
 S A4ATNA=NATOTAL
 W !!,"* TOTAL OF NEW ACTIVITY ",$S(DATE1'="":"SINCE ",1:""),Y,$J(NATOTAL,12,2)
 W !!!,"* NEW ACTIVITY"
 W !,"I MARKED AS INVALID TRANSACTION"
 W !,"R REPAYMENT PLAN"
 W !,"S SUSPENDED"
 D:IOT="VTRM" PAUSE^A4AARPT3
 W @IOF
 ; QUIT:(LSTBT'=SRBAL)!(END)
 D PRTSTB^A4AARPT3
 ; D:A4APAT[";DPT"
 ;   . S Y=$$EN^A4AARPT5(DEBTOR)
 ;   . W !!,"ACCOUNT IS ",$S(Y=1:"OUT OF BALANCE",1:"IN BALANCE")
 S Y=$$EN^A4AARPT5(DEBTOR)
 W !!,"ACCOUNT IS ",$S(Y=1:"OUT OF BALANCE",1:"IN BALANCE")
ENDRPT3 ;
 QUIT
 K AB,BAL,BILL,BS,C,CA,CC,CS,DAT,DATE,DATE1,DATE2,DATE3,DEBTOR,DIC,DIYS,EP,FLAG1IB,ITF,LINE,MF,NAF,NAME,NATOTAL,OV1,OV2,PAT,PB,PFLAG,PG,PRCA4307,RBAL,SC,SDAY,SSN,TAMT,TDATE,TEMP,TIME1,TIME2,TRANS,TYPE,U1N4,X,XBILL,XDATE,Y
 K LST1,LST2,LST3,LST4,LST5,LST6,LSTB1,LSTB2,LSTB3,LSTB4,LSTB5,LSTB6,LSTBT
 K BILL,XDATE1,XTRANS1
 QUIT
GETDAT ;
 D SETUP^A4AARPT
 S DAT=""
 S DAT=$O(^RC(341,"AD",DEBTOR,2,DAT))
 S:DAT'="" DATE1=9999999-($P(DAT,".",1))
 S:DAT'="" TIME1=$P((9999999.999999-DAT),".",2)
 QUIT
PRTTRANS ;
 S CS=$P(^PRCA(430,BILL,0),U,8)
 S BS=$P(^PRCA(430.3,CS,0),U,2)
 Q:(CS=15)!(CS=18)!(CS=20)!(CS=27)!(CS=48)!(CS=49)
 ; Q:(CS=15)!(CS=18)!(CS=20)!(CS=27)!(CS=40)!(CS=48)!(CS=49)
 S RFLAG=""
 S XDATE=""
 QUIT
 F  S XDATE=$O(BILL(XDATE)) Q:XDATE=""  D CHECK1
 D:TRANS'["Z" PRTTRAN3
 QUIT
CHECK1 ;
 S TDATE=$P(^PRCA(430,BILL,0),U,10)
 S XBILL=""
 F  S XBILL=$O(BILL(XDATE,XBILL)) Q:XBILL=""  D 
 . I (XDATE<TDATE)&(XBILL<BILL) D 
 .. S TBILL=BILL
 .. S BILL=XBILL
 .. D PRTTRAN2
 .. S BILL=TBILL
 .. K TBILL,BILL(XDATE,XBILL)
 . I (TDATE=XDATE)&(BILL=XBILL) D PRTTRAN2 K BILL(XDATE,XBILL)
 QUIT
PRTTRAN2 ;
 S CS=$P(^PRCA(430,BILL,0),U,8)
 Q:CS=""
 S BS=$P(^PRCA(430.3,CS,0),U,2)
 ; Q:(CS'=16)&(CS'=42)
 S RFLAG=""
 S XDATE=""
 S SFLAG=""
 Q:(CS=15)!(CS=18)!(CS=20)!(CS=27)!(CS=48)!(CS=49)
 ; Q:(CS=15)!(CS=18)!(CS=20)!(CS=27)!(CS=40)!(CS=48)!(CS=49)
 I $Y+5>IOSL D PAUSE^A4AARPT3 Q:END  D PRTHDR3
 S TAMT=$P(^PRCA(430,BILL,0),U,3)
 I "^19^40^47^"[("^"_CS_"^") S:TAMT>0 TAMT=+TAMT S SFLAG=1
 S:DATE1=-1 TIME1=0
 S DATE2=$P($P($G(^PRCA(430,BILL,6)),U,21),".")
 S:DATE2="" DATE2=$P($P($G(^PRCA(430,BILL,0)),U,10),".")
 S TIME2="."_$P($P($G(^PRCA(430,BILL,6)),U,21),".",2)
 S:TIME2="." TIME2=0
 S NAF=$S(((DATE2>DATE1)!((DATE1=DATE2)&(TIME2>TIME1))):"*",(DATE2="")&(XDATE>DATE1)!(DATE1=""):"*",1:" ")
 S:NAF=("*")&(SFLAG="") NATOTAL=NATOTAL+TAMT S A4ATNA=NATOTAL
 S:NAF'=("*")&(SFLAG="") SRBAL=SRBAL+TAMT S A4APSB=SRBAL
 S:NAF'="*" LST1=LST1+TAMT
 S:SFLAG="" RBAL=RBAL+TAMT S A4AFRB=RBAL
 ; S NAF=$S(((DATE2>DATE1)!((DATE1=DATE2)&(TIME2>TIME1)))!(DATE1=""):"*",1:" ")
 S TYPE=$P(^PRCA(430.3,$P(^PRCA(430,BILL,0),U,8),0),U,2)
 S OV1=$P(^PRCA(430,BILL,0),U,10)
 S OV2=$P($P($G(^PRCA(430,BILL,6)),U,21),".")
 W:$G(FLAG1)=1 !,?10,$J(BILL,6),"*",?17,OV1," ",OV2,?35,$J(TYPE,4),?57,$J(TAMT,10,2),NAF,?70,$J(RBAL,10,2)
 QUIT
PRTHDR3 ;
 Q:$G(FLAG1)=0
 W @IOF
 D HDR^A4AARPT1
 W !,"AR TRANSACTION FILE ( 433 ) DATA ",!!
TRANHDR W !," TRANS #",?10,"BILL #",?18,"  DATE",?29,"      TYPE",?41,"RECEIPT #",?52,"ADJ #",?59,"   AMOUNT",?73,"BALANCE"
 QUIT
PRTTRAN3 ;
 S F433N0=$G(^PRCA(433,TRANS,0))
 S F433N1=$G(^PRCA(433,TRANS,1))
 S F433N8=$G(^PRCA(433,TRANS,8))
 I $Y+5>IOSL D PAUSE^A4AARPT3 Q:END  D PRTHDR3
 S TYPE=$S($P(F433N1,U,2)'="":$P(F433N1,U,2),1:BS)
 S TAMT=$P(F433N1,U,5)
 S RFLAG="",SFLAG=""
 I "^1^12^13^43^"[("^"_TYPE_"^") S:TAMT>0 TAMT=+TAMT S RFLAG=1
 I "^2^8^9^10^11^14^26^29^34^35^41^"[("^"_TYPE_"^") S:TAMT>0 TAMT=+TAMT/-1 S RFLAG=1
 I "^19^40^47^"[("^"_CS_"^") S:TAMT>0 TAMT=+TAMT S SFLAG=1,RFLAG=0
 I TYPE=14,TAMT<0 S TAMT=TAMT
 S:$P(^PRCA(430,BILL,0),U,2)=26 TAMT=TAMT*-1
 S:$P(F433N1,U,2)=25 TAMT=TAMT*1
 D:$D(F433N8)'=0 CALC
 S DATE2=$S($P($P(F433N1,U,9),".")'="":$P($P(F433N1,U,9),"."),$P($P(F433N1,U,1),".")'="":$P($P(F433N1,U,1),"."),1:"")
 S TIME2="."_$S($P($P(F433N1,U,9),".",2)'="":$P($P(F433N1,U,9),".",2),$P($P(F433N1,U,1),".",2)'="":$P($P(F433N1,U,1),".",2),1:"")
 S:TIME2="." TIME2=0
 S NAF=$S(((DATE2>DATE1)!((DATE1=DATE2)&(TIME2>TIME1)))!(DATE1=""):"*",1:" ")
 S ITF=$P(F433N0,U,10)
 S ITF=$S(ITF="":" ",1:"I")
 S:($P(F433N1,U,2)=25) ITF=ITF_"R"
 S:SFLAG=1 ITF=ITF_"S"
 S:(NAF="*")&(ITF'["I")&(ITF'["R")&(ITF'["S")&(RFLAG=1) NATOTAL=NATOTAL+TAMT S A4ANAT=NATOTAL
 S:(NAF'="*")&(ITF'["I")&(ITF'["R")&(ITF'["S")&(RFLAG=1) SRBAL=SRBAL+TAMT S A4APSB=SRBAL
 S:(ITF'["I")&(ITF'["R")&(ITF'["S")&(RFLAG=1) RBAL=RBAL+TAMT S A4AFRB=RBAL
 S DATE3=$S($P($P(F433N1,U,1),".")'=$P($P(F433N1,U,9),"."):$P($P(F433N1,U,9),"."),1:"")
 W:$G(FLAG1)=1 !,$J(TRANS,8),?10,$J($P(F433N0,U,2),6),?17,$P($P(F433N1,U,1),".")," ",DATE3,?35,$J(TYPE,4),?40,$P(F433N1,U,3),?50,$J($P(F433N1,U,4),5),?57,$J(TAMT,10,2),NAF,ITF,?70,$J(RBAL,10,2)
CLSB ;
 I (NAF'="*")&(ITF'["I")&(ITF'["S")&(ITF'["R")&(RFLAG=1) D
   . D CALCLSB^A4AARPT3
   . S LST1=LST1+(TAMT)
   . S:TYPE=13 LST1=LST1-(TAMT)
   . S (T1,T2,T3,T4,T5)=0
   . I "^2^34^"[("^"_TYPE_"^") D
     .. D CALC4333^A4AARPT
     .. S LST1=LST1-T1-TAMT
     .. S LST2=LST2-T2
     .. S LST3=LST3-T3
     .. S LST4=LST4-T4
     .. S LST5=LST5-T5
 ; W !,TRANS,"  ",TYPE,"  ",LST1,"  ",LST2,"  ",LST3,"  ",LST4," ",LST5,"  ",LST6
 QUIT
CALC ;
 S BAL=0
 Q:$D(F433N8)=0
 S PRCA4338=F433N8
 S PB=$P(PRCA4338,U,1)
 S IB=$P(PRCA4338,U,2)
 S AB=$P(PRCA4338,U,3)
 S MF=$P(PRCA4338,U,4)
 S CC=$P(PRCA4338,U,5)
 S EP=$P(PRCA4338,U,7)
 S CA=$P(PRCA4338,U,8)
 S BAL=PB+IB+AB+MF+CC+EP+CA
 K PRCA4338
 QUIT
