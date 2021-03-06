VEJDPXCW ;AMC - Document Storage Systems Inc ; Data Warehouse setup
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
EN(VST,NEW) ;
 N FAC,ADD,REC,TYP,DEL,CODE,EVNT,PKG,X,DIC,TDT,TIL,AUD,RCST,XX,DIV
 S DIV=$G(DUZ(2)),FAC=+$P($G(^XTV(8989.3,1,"XUS")),U,17),FAC=$P($G(^DIC(4,FAC,99)),U)
 S TIL=ARRY("~",$O(ARRY("~",0))),PKG=$P(TIL,U),AUD=$P(TIL,U,2),RCST=$P(TIL,U,3)
 F TYP="C","D" S REC=0 F  S REC=$O(ARRY(TYP,REC)) Q:'REC  D
 .D NOW^%DTC S TDT=%
 .S DEL=$P(ARRY(TYP,REC),U,$S(TYP="D":14,1:7)),CODE=$P(ARRY(TYP,REC),U,3),ADD='ARRY(TYP,REC)
 .S EVNT=$S(NEW!ADD:"ADD",DEL:"DELETE",1:"EDITED")
 .S XX=TDT_U_FAC_U_VST_U_CODE_U_EVNT_U_PKG_U_TYP,$P(XX,U,10)=DUZ_U_DIV
 .S X=TDT,DIC="^VEJD(19610.45,",DIC(0)="L" D FILE^DICN I Y<0 Q
 .S ^VEJD(19610.45,+Y,0)=XX
 D NOW^%DTC S (X,TDT)=%,DIC="^VEJD(19610.45,",DIC(0)="L" D FILE^DICN I Y<0 Q
 S XX=TDT_U_FAC_U_VST_U_DUZ,$P(XX,U,7)="A"_U_AUD_U_RCST,$P(XX,U,11)=DIV
 S ^VEJD(19610.45,+Y,0)=XX
 Q
EXTRACT(STDT,ENDT,PURG) ;
 Q:'$G(STDT)!'$G(ENDT)
 N LDT,REC,TYP,XX,LOG,CNT,FAC K ^TMP("DSIDWEX",$J),^XTMP("VEJDDWEX",STDT)
 S PURG=+$G(PURG),ENDT=ENDT+.3,^XTMP("VEJDDWEX",STDT)=0
 S LDT=STDT-.000001
 F  S LDT=$O(^VEJD(19610.45,"B",LDT)) Q:'LDT!(LDT>ENDT)  S LOG=0 F  S LOG=$O(^VEJD(19610.45,"B",LDT,LOG)) Q:'LOG  D
 .S REC=^VEJD(19610.45,LOG,0),TYP=$P(REC,U,7)
 .I TYP'="A" S XX=$P(REC,U,2,5)_U_$P(REC,U,10),XX=$P(XX,U)_U_$P(REC,U,11)_U_$P(XX,U,2,99),^TMP("DSIDWEX",$J,TYP,LOG)=XX_U_LDT Q
 .S XX=$P(REC,U,2,4)_U_$P(REC,U,8,9),XX=$P(XX,U)_U_$P(REC,U,11)_U_$P(XX,U,2,99),^TMP("DSIDWEX",$J,"A",LOG)=XX_U_LDT
 S ^XTMP("VEJDDWEX",STDT,1)="**ICDSTART**",LOG=0
 F CNT=2:1 S LOG=$O(^TMP("DSIDWEX",$J,"D",LOG)) Q:'LOG  S ^XTMP("VEJDDWEX",STDT,CNT)=^TMP("DSIDWEX",$J,"D",LOG)
 S ^XTMP("VEJDDWEX",STDT,CNT)="**ICDSTOP**",CNT=CNT+1,^(CNT)="**CPTSTART**",CNT=CNT+1
 F CNT=CNT:1 S LOG=$O(^TMP("DSIDWEX",$J,"C",LOG)) Q:'LOG  S ^XTMP("VEJDDWEX",STDT,CNT)=^TMP("DSIDWEX",$J,"C",LOG)
 S ^XTMP("VEJDDWEX",STDT,CNT)="**CPTSTOP**",CNT=CNT+1,^(CNT)="**AUDSTART**",CNT=CNT+1
 F CNT=CNT:1 S LOG=$O(^TMP("DSIDWEX",$J,"A",LOG)) Q:'LOG  S ^XTMP("VEJDDWEX",STDT,CNT)=^TMP("DSIDWEX",$J,"A",LOG)
 S ^XTMP("VEJDDWEX",STDT,CNT)="**AUDSTOP**",CNT=CNT+1,^(CNT)="**IBSTART**",CNT=CNT+1
 S LDT=STDT-.000001,FAC=+$P($G(^XTV(8989.3,1,"XUS")),U,17),FAC=$P($G(^DIC(4,FAC,99)),U,1)
 F  S LDT=$O(^VEJD(19610.4,"G",LDT)) Q:'LDT!(LDT>ENDT)  S LOG=0 F  S LOG=$O(^VEJD(19610.4,"G",LDT,LOG)) Q:'LOG  D
 .S REC=FAC_U_LOG_U_$$AUD(LOG),CNT=CNT+1,^XTMP("VEJDDWEX",STDT,CNT)=REC_U_LDT
 S CNT=CNT+1,^XTMP("VEJDDWEX",STDT,CNT)="**IBSTOP**",^(CNT+1)="**EOF**"
 K ^TMP("DSIDWEX",$J) S ^XTMP("VEJDDWEX",STDT)=1
 Q:'PURG
 N DA,DIK
 S LDT=0 F  S LDT=$O(^VEJD(19610.45,"B",LDT)) Q:'LDT!(LDT>STDT)  S LOG=0 F  S LOG=$O(^VEJD(19610.45,"B",LDT,LOG)) Q:'LOG  D
 .S DA=LOG,DIK="^VEJD(19610.45," D ^DIK
 Q
AUD(REC) ;
 N AUD
 I $P($P($G(^VEJD(19610.4,REC,4)),U),":")]"" Q $P($P(^(4),U),":")
 S AUD=$P($G(^VEJD(19610.4,REC,1)),U,11)
 S AUD=$S(AUD="P":"OK",AUD="F":"MUL",1:AUD)
 Q AUD
