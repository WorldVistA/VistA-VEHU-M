A4AARPT3 ;HINES-CIOFO/JJM - GET FILE 341 DATA 7/27/98 18:20
 ;;1.0;**** CLASS III ****;;JUN 30, 1998
START S U="^" S:$D(PG)=0 PG=0
PRTRPT2 ;
 S:'$G(DEBTOR) DEBTOR=+$G(A4ADEB)
 Q:'DEBTOR
 N FLAG1
 S FLAG1=1 ; SET DEFAULT TO PRINT
 S (LST1,LST2,LST3,LST4,LST5,LST6)=0
 S (LSTB1,LSTB2,LSTB3,LSTB4,LSTB5,LSTB6,LSTBT)=0
 Q:$D(^RC(341,"AD",DEBTOR,2))=0
 U IO
 D PRTHDR2
GET341D ; GET DATA FROM FILE 341
 S DAT="",DATE1="",TIME1="",LSTFLAG=0,SDT=""
 F  S DAT=$O(^RC(341,"AD",DEBTOR,2,DAT)) Q:DAT=""  D 
   . S TRANS=""
   . F  S TRANS=$O(^RC(341,"AD",DEBTOR,2,DAT,TRANS)) Q:TRANS=""  D 
        .. S (PA,IA,AD,CA,MA,BAL)=0
        .. I $D(^RC(341,TRANS,1))'=0 D 
           ... S PA=$P(^RC(341,TRANS,1),U,1)
           ... S IA=$P(^RC(341,TRANS,1),U,2)
           ... S AD=$P(^RC(341,TRANS,1),U,3)
           ... S CA=$P(^RC(341,TRANS,1),U,4)
           ... S MA=$P(^RC(341,TRANS,1),U,5)
           ... S BAL=PA+IA+AD+CA+MA
        .. D:LSTFLAG=0 LST
        .. S XDAT=9999999-$P(DAT,".",1)
        .. W !,XDAT,?10,$J(TRANS,8),?20,$J(PA,10,2),?30,$J(IA,10,2),?40,$J(AD,10,2),?50,$J(CA,10,2),?60,$J(MA,10,2),?70,$J(BAL,10,2)
   . S:SDT="" SDT=(9999999.999999-DAT)
   . S:DATE1="" DATE1=9999999-($P(DAT,".",1))
   . S:TIME1="" TIME1=$P((9999999.999999-DAT),".",2)
 S Y=$$EN^A4AARPT5(DEBTOR)
 W:(DAT'=SDT) !!,"WARNING CHECK NEW ACTIVITY TRANSACTIONS BETWEEN ",DAT," - ",SDT
ENDRPT2 ;
 D:IOT="VTRM" PAUSE
 W @IOF
 K C,DAT,LINE,TRANS,PA,IA,AD,CA,MA,BAL,XDAT,X,Y,LSTFLAG
 QUIT
LST ;
 S LSTB1=PA
 S LSTB2=IA
 S LSTB3=AD
 S LSTB4=CA
 S LSTB5=MA
 S LSTB6=BAL
 S LSTBT=TRANS
 S LSTFLAG=1
 QUIT
PRTHDR2 ;
 W @IOF
 D HDR^A4AARPT1
 W !,?25,"STATEMENT HISTORY (FILE 341)"
 W !!,?40," ADMINIST-"
 W !,"  DATE",?10," TRANS #",?20," PRINCIPLE ",?30,"  INTERST",?40,"  RATIVE",?50,"     COURT",?60,"   MARSHAL",?70,"   BALANCE"
 W !
 QUIT
PRTSTB ;
 W #,!!,"LAST STATEMENT COMPUTED BALANCES(FILE 341): (",$J(SRBAL,10,2),")"
 W !,?5,$J(LSTBT,10),?15,$J(LSTB1,10,2),"  (",$J(LST1,10,2),")"
 W !,?15,$J(LSTB2,10,2),"  (",$J(LST2,10,2),")"
 W !,?15,$J(LSTB3,10,2),"  (",$J(LST3,10,2),")"
 W !,?15,$J(LSTB4,10,2),"  (",$J(LST4,10,2),")"
 W !,?15,$J(LSTB5,10,2),"  (",$J(LST5,10,2),")"
 W !,?15,"==========","   =========="
 W !,?15,$J((LSTB1+LSTB2+LSTB3+LSTB4+LSTB5),10,2),"  (",$J((LST1+LST6),10,2),")"
 QUIT
CALCLSB ;
 D CALC4332^A4AARPT
 S LST2=LST2+T7
 S LST3=LST3+T1+T2+T3+T4+T8
 S LST4=LST4+T6
 S LST5=LST5+T5
 S LST6=LST2+LST3+LST4+LST5
 ; D CALC4333^A4AARPT
 ; S LST2=LST2-T2
 ; S LST3=LST3-T3
 ; S LST4=LST4-T4
 ; S LST5=LST5-T5
 ; S LST6=LST2-LST3-LST4-LST5
 QUIT
PRTLSB ;
 W !,"COMPUTED",?20,$J(LST1,10,2),?30,$J(LST2,10,2),?40,$J(LST3,10,2),?50,$J(LST4,10,2),?60,$J(LST5,10,2),?70,$J(BAL,10,2)
 QUIT
PAUSE   ;
 Q:$G(FLAG1)=0
 I $E($G(IOST),1,2)="C-" W !!,"PRESS RETURN TO CONTINUE OR ""^"" TO EXIT: " R X:DTIME S END='$T!(X="^")
