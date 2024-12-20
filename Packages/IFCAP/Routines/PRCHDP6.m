PRCHDP6 ;WISC/DJM-PRINT AMENDMENT, ROUTINE #2 ;9/15/95  11:41 AM
V ;;5.1;IFCAP;**21,131,221**;Oct 20, 2000;Build 14
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRC*5.1*221 Modify an item description display to skip '|' logic
 ;            if description contains a undefined display command
 ;            like '| IN '.
 ;            Also, the check for an existing amendment on an
 ;            item being displayed. This intial check will allow
 ;            for further determination whether the LATEST amendment
 ;            has a pricing effect on the order printed.
 ;
E22 ;LINE ITEM Delete PRINT
 N FIELD,CHANGE,CHANGES,OLD,ITEM,ITEM0,ITEM1,ITEM2,LCNT,DATA,I,UOP
 S FIELD=0 K ITEM D LCNT^PRCHDP9(.LCNT)
 F  S FIELD=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",AMEND,FIELD)) Q:FIELD'>0  D
 .S CHANGE=0 F  S CHANGE=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",AMEND,FIELD,CHANGE)) Q:CHANGE'>0  D
 ..S CHANGES=^PRC(442,PRCHPO,6,PRCHAM,3,CHANGE,0),OLD=^PRC(442,PRCHPO,6,PRCHAM,3,CHANGE,1,1,0)
 ..S ITEM=$P(CHANGES,U,4) Q:$D(ITEM(ITEM))  S ITEM(ITEM)=1
 ..S ITEM0=$G(^PRC(442,PRCHPO,2,ITEM,0))
 ..I ITEM0="" Q
 ..S ITEM1=$G(^PRC(442,PRCHPO,2,ITEM,1,1,0))
 ..D LINE^PRCHDP9(.LCNT,2) S DATA="The following line item has been cancelled:" D DATA^PRCHDP9(.LCNT,DATA)
 ..S DATA="Item No. "_$P(ITEM0,U)_"     Item Master File No. "
 ..S DATA=DATA_$P(ITEM0,U,5)_"     BOC: "_+$P(ITEM0,U,4)
 ..S DATA=DATA_"   CONTRACT: "_$P($G(^PRC(442,PRCHPO,2,ITEM,2)),U,2)
 ..D DATA^PRCHDP9(.LCNT,DATA)
 ..D NEW^PRCHDP7
 ..S UOP=$S($P(ITEM0,U,3)>0:$P($G(^PRCD(420.5,$P(ITEM0,U,3),0)),U),1:"")
 ..S DATA="    Items per "_UOP_": "_$P(ITEM0,U,12)
 ..F I=1:1:26-$L(DATA) S DATA=DATA_" "
 ..S DATA=DATA_"NSN: "_$P(ITEM0,U,13) D DATA^PRCHDP9(.LCNT,DATA)
 ..I $P(ITEM0,U,6)]"" S DATA="    STK#: "_$P(ITEM0,U,6) D DATA^PRCHDP9(.LCNT,DATA)
 ..S QTY=$$FETCH(2,ITEM)
 ..S AUC=$$FETCH(5,ITEM)
 ..S UOP=$S($P(ITEM0,U,3)>0:$P($G(^PRCD(420.5,$P(ITEM0,U,3),0)),U),1:"")
 ..S DATA="    "_QTY_" "_UOP_" at $"_$J(AUC,12,4)_" = $"_$J(QTY*AUC,9,2) D DATA^PRCHDP9(.LCNT,DATA),LCNT1^PRCHDP9(LCNT)
 Q
 ;
E23 ;LINE ITEM Edit PRINT
 N FIELD,CHANGE,CHANGES,IMF,BOC,OLD,ITEM,ITEM0,ITEM1,ITEMZ,QTY,AUC,UOP,UOP1,NSN,UCF,LCNT,DATA,DES,VAL,PRCHLN,ABC,VSN,CONOLD,CON442
 S FIELD=0 K ITEM D LCNT^PRCHDP9(.LCNT)
 F  S FIELD=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",AMEND,FIELD)) Q:FIELD'>0  D
 .S CHANGE=0 F  S CHANGE=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",AMEND,FIELD,CHANGE)) Q:CHANGE'>0  D
 ..S CHANGES=^PRC(442,PRCHPO,6,PRCHAM,3,CHANGE,0),OLD=^PRC(442,PRCHPO,6,PRCHAM,3,CHANGE,1,1,0)
 ..S ITEM=$P(CHANGES,U,4) Q:$D(ITEM(ITEM))  S ITEM(ITEM)=1
 ..S ITEM0=$G(^PRC(442,PRCHPO,2,ITEM,0))
 ..I ITEM0="" Q
 ..I $P(ITEM0,U,2)=0,$P(ITEM0,U,9)=0 Q
 ..S ITEM1=$G(^PRC(442,PRCHPO,2,ITEM,1,1,0))
 ..S (ABC,DES)=$$FETCH(1,ITEM) S PRCHLN=VAL
 ..S IMF=$$FETCH(1.5,ITEM) I IMF'>0 S IMF=$P(ITEM0,U,5)
 ..S BOC=+$$FETCH(3.5,ITEM) I BOC'>0 S BOC=+$P(ITEM0,U,4)
 ..S QTY=$$FETCH(2,ITEM) I QTY'>0 S QTY=$P(ITEM0,U,2)
 ..S AUC=$$FETCH(5,ITEM) I AUC="" S AUC=$P(ITEM0,U,9)
 ..S UOP=$$FETCH(3,ITEM) I UOP'>0 S UOP=$P(ITEM0,U,3)
 ..S NSN=$$FETCH(9.5,ITEM) I NSN="" S NSN=$P(ITEM0,U,13)
 ..S UCF=$$FETCH(3.1,ITEM) I UCF'>0 S UCF=$P(ITEM0,U,12)
 ..S VSN=$$FETCH(9,ITEM) I VSN="" S VSN=$P(ITEM0,U,6)
 ..S CONOLD=$$FETCH(4,ITEM)
 ..S CON442=$P($G(^PRC(442,PRCHPO,2,ITEM,2)),U,2)
 ..I CONOLD="",CON442'="" S CONOLD=CON442
 ..D LINE^PRCHDP9(.LCNT,2) S DATA="**Currently:"
 ..D DATA^PRCHDP9(.LCNT,DATA)
 ..S DATA="Item No. "_$P(ITEM0,U)_"     Item Master File No. "_IMF
 ..S DATA=DATA_"     BOC: "_BOC_"   CONTRACT: "_CONOLD
 ..D DATA^PRCHDP9(.LCNT,DATA)
 ..I $L(ABC)>0 D OLD^PRCHDP7
 ..I $L(ABC)'>0 S ITEMZ=ITEM1 D NEW^PRCHDP7
 ..S UOP1=$S($L(UOP)>0:$P($G(^PRCD(420.5,UOP,0)),U),1:"")
 ..S DATA="    Items per "_UOP1_": "_UCF
 ..F I=1:1:26-$L(DATA) S DATA=DATA_" "
 ..S DATA=DATA_"NSN: "_NSN D DATA^PRCHDP9(.LCNT,DATA)
 ..I $L(VSN)>0 S DATA="    STK#: "_$P(ITEM0,U,6) D DATA^PRCHDP9(.LCNT,DATA)
 ..S UOP1=$S($L(UOP)>0:$P($G(^PRCD(420.5,UOP,0)),U),1:"")
 ..S AMDQTY=QTY,AMDVAL=AUC D NXTAMD
 ..S DATA="    "_AMDQTY_" "_UOP1_" at $"_$J(AMDVAL,12,2)_" = $"_$J(AMDQTY*AMDVAL,9,2) D DATA^PRCHDP9(.LCNT,DATA)
 ..S DATA="                                             "
 ..D DATA^PRCHDP9(.LCNT,DATA)
 ..S DATA=" **Will now be AMENDED to read:" D DATA^PRCHDP9(.LCNT,DATA)
 ..S DATA="Item No. "_$P(ITEM0,U)_"     Item Master File No. "
 ..S DATA=DATA_$P(ITEM0,U,5)_"     BOC: "_+$P(ITEM0,U,4)
 ..S DATA=DATA_"   CONTRACT: "_CON442
 ..D DATA^PRCHDP9(.LCNT,DATA)
 ..S:$D(ITEMZ) ITEM1=ITEMZ D NEW^PRCHDP7
 ..S UOP1=$S($P(ITEM0,U,3)>0:$P($G(^PRCD(420.5,$P(ITEM0,U,3),0)),U),1:"")
 ..S DATA="    Items per "_UOP1_": "_$P(ITEM0,U,12)
 ..F I=1:1:26-$L(DATA) S DATA=DATA_" "
 ..S DATA=DATA_"NSN: "_$P(ITEM0,U,13) D DATA^PRCHDP9(.LCNT,DATA)
 ..I $P(ITEM0,U,6)]"" S DATA="    STK#: "_$P(ITEM0,U,6) D DATA^PRCHDP9(.LCNT,DATA)
 ..S UOP1=$S($P(ITEM0,U,3)>0:$P($G(^PRCD(420.5,$P(ITEM0,U,3),0)),U),1:"")
 ..S AMDQTY=$P(ITEM0,U,2),AMDVAL=$P(ITEM0,U,9) D NXTAMD1
 ..S DATA="    "_AMDQTY_" "_UOP1_" at $"_$J(AMDVAL,12,4)_" = $"_$J(AMDQTY*AMDVAL,9,2)
 ..K AMDQTY,AMDVAL
 ..D DATA^PRCHDP9(.LCNT,DATA),LCNT1^PRCHDP9(LCNT)
 Q
 ;
FETCH(FIELD,ITEM) ;EXTRINSIC FUNCTION TO RETURN THE 'VALUE' FOR A FIELD FROM 'LINE ITEM
 ;AMENDMENT' OPTIONS.
 N VAL1
 S VAL=0 F  S VAL=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",21,FIELD,VAL)) Q:VAL'>0  S VAL1=$P(^PRC(442,PRCHPO,6,PRCHAM,3,VAL,0),U,4) I VAL1=ITEM S VAL1=0 G EXIT
 S VAL=0 F  S VAL=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",22,FIELD,VAL)) Q:VAL'>0  S VAL1=$P(^PRC(442,PRCHPO,6,PRCHAM,3,VAL,0),U,4) I VAL1=ITEM D  G EXIT
 .S VAL1=^PRC(442,PRCHPO,6,PRCHAM,3,VAL,1,1,0)
 .Q
 S VAL=0 F  S VAL=$O(^PRC(442,PRCHPO,6,PRCHAM,3,"AC",23,FIELD,VAL)) Q:VAL'>0  S VAL1=$P(^PRC(442,PRCHPO,6,PRCHAM,3,VAL,0),U,4) I VAL1=ITEM D  G EXIT
 .S VAL1=^PRC(442,PRCHPO,6,PRCHAM,3,VAL,1,1,0)
 .Q
 S VAL1=""
EXIT Q VAL1
NXTAMD ;FIND PREVIOUS CURRENT QTY/COST WHEN MORE THAN 1 AMENDMENT
 Q:'$D(^TMP($J,"PRCHDP6"))
 N TMPREC
 I +$G(PRCHAMNT),$P(^PRC(442,PRCHPO,6,0),U,3)>PRCHAMCT,'$D(^TMP($J,"PRCHDP6",ITEM,PRCHAM)) S PRCHAMNT=2,AMDQTY=$P(ITEM0,U,2),AMDVAL=$P(ITEM0,U,9) Q   ;PRC*5.1*221
 S TMPREC=^TMP($J,"PRCHDP6",ITEM,PRCHAM)
 S AMDQTY=$P(TMPREC,U) S:AMDQTY="" AMDQTY=$P(ITEM0,U,2)
 S AMDVAL=$P(TMPREC,U,3) S:AMDVAL="" AMDVAL=$P(ITEM0,U,9)
 Q
NXTAMD1 ;FIND PREVIOUS AMENDED TO +INFO WHEN MORE THAN 1
 Q:'$D(^TMP($J,"PRCHDP6"))
 N TMPREC
 I +$G(PRCHAMNT),$P(^PRC(442,PRCHPO,6,0),U,3)>PRCHAMCT,'$D(^TMP($J,"PRCHDP6",ITEM,PRCHAM)) S PRCHAMNT=2,AMDQTY=$P(ITEM0,U,2),AMDVAL=$P(ITEM0,U,9) Q   ;PRC*5.1*221
 S TMPREC=^TMP($J,"PRCHDP6",ITEM,PRCHAM)
 S AMDQTY=$P(TMPREC,U,5) S:AMDQTY="" AMDQTY=$P(ITEM0,U,2)
 S AMDVAL=$P(TMPREC,U,7) S:AMDVAL="" AMDVAL=$P(ITEM0,U,9)
 Q
AMENDS ;SET UP AMENDMENT HISTORY
 Q:'$D(^PRC(442,D0,6))
 N ITIEN,AMDQTY,AMDVAL,CURQTY,CURVAL,NXTAMD,HNXTAMD,NXTCHG,NXTFLD,ITEMNO,ITNO,AMDATA,AREC,NAMEND,J,XOLD1
 K ^TMP($J,"PRCHDP6") S ITIEN=0
 S NXTAMD=0 F  S NXTAMD=$O(^PRC(442,D0,6,NXTAMD)) Q:'NXTAMD  S HNXTAMD=NXTAMD
AM1 F  S ITIEN=$O(^PRC(442,D0,2,ITIEN)) Q:'ITIEN  D
 . S ITEM0=$G(^PRC(442,D0,2,ITIEN,0)) S CURQTY=$P(ITEM0,U,2),CURVAL=$P(ITEM0,U,9)
 . F J=1:1:HNXTAMD S ^TMP($J,"PRCHDP6",ITIEN,J)=CURQTY_U_0_U_CURVAL_U_0_U_CURQTY_U_0_U_CURVAL_U_0
AM2 S NXTAMD=0
AM3 S NXTAMD=$O(^PRC(442,D0,6,NXTAMD)),NXTFLD=0 G AMX:'NXTAMD
AM4 S NXTFLD=$O(^PRC(442,D0,6,NXTAMD,3,"AC",23,NXTFLD)),NXTCHG=0 G:'NXTFLD AM3
AM5 S NXTCHG=$O(^PRC(442,D0,6,NXTAMD,3,"AC",23,NXTFLD,NXTCHG)) G:'NXTCHG AM4
 S XOLD1=$G(^PRC(442,D0,6,NXTAMD,3,NXTCHG,0)),ITEMNO=$P(XOLD1,U,4)
COST I $P(XOLD1,U,3)["5;442.01" S NAMEND=0 D
 . S AMDVAL=$G(^PRC(442,D0,6,NXTAMD,3,NXTCHG,1,1,0))
 . F J=1:1 S NAMEND=$O(^TMP($J,"PRCHDP6",ITEMNO,NAMEND)) Q:NAMEND=""  D
 .. S AMDATA=^TMP($J,"PRCHDP6",ITEMNO,NAMEND)
 .. I $P(AMDATA,U,4)=0,NAMEND'>NXTAMD S $P(^TMP($J,"PRCHDP6",ITEMNO,NAMEND),U,3,4)=AMDVAL_U_NXTAMD
 .. I $P(AMDATA,U,8)=0,NAMEND<NXTAMD S $P(^TMP($J,"PRCHDP6",ITEMNO,NAMEND),U,7,8)=AMDVAL_U_NXTAMD
QUANT I $P(XOLD1,U,3)["2;442.01" S NAMEND=0 D
 . S AMDQTY=$G(^PRC(442,D0,6,NXTAMD,3,NXTCHG,1,1,0))
 . F J=1:1 S NAMEND=$O(^TMP($J,"PRCHDP6",ITEMNO,NAMEND)) Q:NAMEND=""  D
 .. S AMDATA=^TMP($J,"PRCHDP6",ITEMNO,NAMEND)
 .. I $P(AMDATA,U,2)=0,NAMEND'>NXTAMD S $P(^TMP($J,"PRCHDP6",ITEMNO,NAMEND),U,1,2)=AMDQTY_U_NXTAMD
 .. I $P(AMDATA,U,6)=0,NAMEND<NXTAMD S $P(^TMP($J,"PRCHDP6",ITEMNO,NAMEND),U,5,6)=AMDQTY_U_NXTAMD
 G AM5
AMX Q
