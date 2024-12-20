PSJO ;BIR/CML3,PR - GET AND PRINT INPATIENT ORDERS ;Jul 16, 2018@08:25
 ;;5.0;INPATIENT MEDICATIONS;**31,58,110,181,267,275,317,373**;16 DEC 97;Build 3
 ;
 ; Reference to ^PSD(58.8 supported by DBIA #2283.
 ; Reference to ^PSI(58.1 supported by DBIA #2284.
 ; Reference to ^PS(55 supported by DBIA #2191.
 ; Reference to $$GET^XPAR supported by #2263
 ;
 K ^TMP("PSJON",$J),^TMP("PSJ",$J) N TF2 D @$S($D(PSJEXTP):"EN^PSJH1",1:"EN^PSJO1(3)")
 S PSJDEV=IO'=IO(0)!($E(IOST,1,2)'="C-"),(NP,TF2,PSGON,PSJON)=""
 U IO D ENGET^PSJO3 I '$D(^TMP("PSJ",$J)) W !,SLS,SLS,$E(SLS,1,25),!!?22,"NO ORDERS FOUND FOR ",$S(PSJOL="S":"SHORT",1:"LONG")," PROFILE."
 E  S (PSJC,PSJS,PSJO,PSJST)="" F  S PSJC=$O(^TMP("PSJ",$J,PSJC)) Q:PSJC=""  D  G:NP["^" DONE
 .D:$S(($P(PSJC,"^")="Cz")&($P(PSJC,"^",2)'=TF2):1,(($P(PSJC,"^")'="Cz")&PSJC["B"&'TF):0,($P(PSJC,"^")'="Cz"&(PSJC'["A")):1,($P(PSJC,"^")="Cz"&(TF2=$P(PSJC,"^",2))):0,1:1) TF
 .F  S PSJST=$O(^TMP("PSJ",$J,PSJC,PSJST)) Q:PSJST=""  F  S PSJS=$O(^TMP("PSJ",$J,PSJC,PSJST,PSJS)) Q:PSJS=""!(NP[U)  D ON
 G:NP[U DONE I PSJDEV,$S('$D(PSJPRP):1,1:PSJPRP="P") D BOT
 ;
DONE ;
 I $S('$D(PSJPRP):1,1:PSJPRP="P") K ^TMP("PSJ",$J)
 S PSGON=PSJON K:'$D(PSGVBW) PSGODT K %,%H,%I,C,DN,DO,DRG,FQ,GIVE,HDT,I,JJ,LN2,N,ND,ND4,ND6,NF,NP,O,ON,ORIFN,ORTX,P,PF,PG,PS,PSGID,PSGOD,PSIVSC,PSIVST,PSIVTY,PSJC,PSJDEV,PSJF,PSJO,PSJOS,PSJS,PSJSCHT,PSJST,QQ,RB,RTE,SCH,SD,SLS,SM
 K ST,START,STAT,SUB,TF,TYP,UDU,UPD,V,WS,X,X1,X2,Y Q
 ;
ON ;
 S PSJSCHT=$S(PSJOS:PSJS,1:PSJST)
 F FQ=0:0 S PSJO=$O(^TMP("PSJ",$J,PSJC,PSJST,PSJS,PSJO)) Q:PSJO=""  S DN=^(PSJO) D:$Y+6>IOSL ENNP^PSJO3 Q:NP["^"  D  ;
 .I $P(PSJC,"^")="Cz",($P(PSJC,"^",2)]"") S PSJF="^PS("_$S($P(PSJC,"^",4)'["C":"55,"_PSGP_",5,",1:"53.1,")
 .S PSJON=PSJON+1 S:'PSJDEV ^TMP("PSJON",$J,PSJON)=PSJO W !,$J(PSJON,4),?5 D @$S(PSJO["V":"PIV^PSIVUTL(PSJO)",PSJO["U":"PUD",1:"PIV^PSIVUTL(PSJO)")
 Q
 ;
PUD ; print unit dose
 ; Naked reference below refers to full reference ^PS(53.1,+PSJO,0) or ^PS(55,DFN,5,+PSJO,0) using indirection.
 I PSJO["U" S:'$$CLINIC^PSJO1(PSGP,PSJO) C=$G(PSJC)
 I PSJO["P" S:'$$CLINIC^PSJO1(PSGP,PSJO) C=$G(PSJC)
 S ND=$S($D(@(PSJF_+PSJO_",0)")):^(0),1:""),SCH=$G(^(2)),ND4=$G(^(4)),ND6=$P($G(^(6)),"^"),DO=$S($P(DN,"^",2)=.2:$P($G(@(PSJF_+PSJO_",.2)")),"^",2),1:$G(@(PSJF_+PSJO_",.3)")))
 I ("AO"[PSJC)!(PSJC="DF") D
 .S V='$P(ND4,"^",UDU),V=$S(+PSJSYSU=1&V:1,+PSJSYSU=3&V:1,1:0)
 .W $S(ND4="":" ",$P(ND4,"^",12):"D",$P(ND4,"^",18)&($P(ND4,"^",19)!V):"H",$P(ND4,"^",22)&($P(ND4,"^",23)!V):"H",$P(ND4,"^",15)&($P(ND4,"^",16)!V):"R",1:" ")
 .W $S($P($G(@(PSJF_+PSJO_",.2)")),"^",4)="D":"d",1:" ")_$S(V:"->",1:"  ")
 I $S(PSJC["NZ":0,1:PSJC["N") W $S($P(ND4,"^",12):"D",1:" ")
 S RTE=$P(ND,"^",3),SM=$S('$P(ND,"^",5):0,$P(ND,"^",6):1,1:2),STAT=$S($P(ND,"^",28)]"":$P(ND,"^",28),$P(ND,"^",9)]"":$P(ND,"^",9),1:"NF")
 S PF=$E("*",$P(ND,"^",20)>0),PSGID=$P(SCH,"^",2),SD=$P(SCH,"^",4),SCH=$P(SCH,"^")
 I STAT="A",$P(ND,U,27)="R" S STAT="R"
 S NF=$P(DN,"^",2),WS=$S(PSJPWD:$$WS(PSJPWD,PSGP,PSJF,PSJO),1:0)
 ; PSJ*5*317 - If PSJ PADE OE BALANCES parameter is YES, PADE balances should display.
 N PADE S PADE=0 I $$GET^XPAR("SYS","PSJ PADE OE BALANCES") D
 .N PSJTMNOE
 .S PSJTMNOE=$G(PSJNEWOE) N PSJNEWOE S PSJNEWOE=PSJTMNOE
 .I '$G(VAIN(4)),$G(PSGP) N VAIN,DFN S DFN=PSGP D INP^VADPT
 .Q:'$$PADEWD^PSJPAD50(+$G(VAIN(4)))
 .S PADE=$$DRGFLAG^PSJPADSI(PSGP,PSJO,,$G(ON),$G(PSJNEWOE)) S:PADE=0 PADE=1
 NEW MARX,PSJRNDT
 S:($P(PSJC,"^")'="Cz") PSJORFLG=$S(PSJC["A":"U",PSJC["O":"U",PSJC="DF":"U",1:"P")
 S:($P(PSJC,"^")="Cz") PSJORFLG=$S($P(PSJC,"^",4)["A":"U",($P(PSJC,"^",4)["O"):"U",($P(PSJC,"^",4)["DF"):"U",1:"P")
 ;S PSJRNDT=$$LASTREN^PSJLMPRI(DFN,PSJO) S:PSJRNDT PSJRNDT=$E($$ENDTC^PSGMI(+PSJRNDT),1,5) ;#373
 S PSJRNDT=$$LASTREN^PSJLMPRI(DFN,PSJO) S:PSJRNDT PSJRNDT=$E($$ENDTC2^PSGMI(+PSJRNDT),1,10) ;#373
 ;D DRGDISP^PSJLMUT1(PSGP,+PSJO_PSJORFLG,40,54,.MARX,0)  ;#373
 D DRGDISP^PSJLMUT1(PSGP,+PSJO_PSJORFLG,34,28,.MARX,0)   ;#373
 F X=0:0 S X=$O(MARX(X)) Q:'X  W @($S(X=1:"?9",1:"!?11")),$S($E(PSJS)="*":$P(PSJS,"^"),1:MARX(X)) D   ;D:X=1  #373
 . ;W ?50,$S(PSJC["NZ":"?",PSJSCHT'="z":PSJSCHT,1:"?") ;#373
 . I X=1 W ?46,$S(PSJC["NZ":"?",PSJSCHT'="z":PSJSCHT,1:"?") ;#373
 . ;W:'$D(PSJEXTP) ?53,$S(PSJC["NZ":"*****",1:$E($$ENDTC^PSGMI(PSGID),1,5)),?60,$S(PSJC["NZ":"*****",1:$E($$ENDTC^PSGMI(SD),1,5)),?67,STAT ;#373
 . I X=1 W:'$D(PSJEXTP) ?49,$S(PSJC["NZ":"*****",1:$E($$ENDTC2^PSGMI(PSGID),1,10)),?60,$S(PSJC["NZ":"*****",1:$E($$ENDTC2^PSGMI(SD),1,10)),?71,STAT ;#373
 . ;W:$D(PSJEXTP) ?53,$S(PSJC["NZ":"*****",1:$E($$ENDTC^PSGMI(PSGID),1,8)),?63,$S(PSJC["NZ":"*****",1:$E($$ENDTC^PSGMI(SD),1,8)),?73,STAT ;#373
 . I X=1 W:$D(PSJEXTP) ?49,$S(PSJC["NZ":"*****",1:$E($$ENDTC2^PSGMI(PSGID),1,10)),?60,$S(PSJC["NZ":"*****",1:$E($$ENDTC2^PSGMI(SD),1,10)),?71,STAT ;#373
 . ;I NF!WS!SM!PF!$G(PADE)!(PSJRNDT]"") W ?71 W:NF "NF " W:(WS&'PADE) "WS " W:(WS&PADE) "WP " W:(PADE&'WS) "PD " W:SM $E("HSM",SM,3) W:$G(PSJRNDT) PSJRNDT W:PF ?79,"*" ;#373
 . I X=1 D   ;#373
 .. I NF!WS!SM!PF!$G(PADE) W ?74 W:NF "NF " W:(WS&'PADE) "WS " W:(WS&PADE) "WP " W:(PADE&'WS) "PD " W:SM $E("HSM",SM,3) W:PF ?78,"*" ;#373
 . I X=2,PSJRNDT]"" W ?49,"Renewed: ",PSJRNDT ;#373
 I '$D(MARX(2)),PSJRNDT]"" W !?49,"Renewed: ",PSJRNDT  ;#373
 I ND6]"" S Y=$$ENSET^PSGSICHK(ND6) D  K ^PS(53.45,DUZ,5)
 .D GETSI^PSJBCMA5(DFN,PSJO) I $G(^PS(53.45,DUZ,5)) N TXTLN S TXTLN=0 F  S TXTLN=$O(^PS(53.45,DUZ,5,TXTLN)) Q:'TXTLN  D
 ..W !?11,$G(^PS(53.45,DUZ,5,TXTLN,0))
 .W !?11 F X=1:1:$L(Y," ") S V=$P(Y," ",X) W:$L(V)+$X>66 !?11 W V_" "
 K PSJORFLG
 Q
 ;
TF ;
 NEW SLS,C S SLS="",C=PSJC,$P(SLS," -",40)=""
 S LN2=$S(($P(C,"^")="Cz"):$$TXT(C),C="A":$$TXT(C),C["CC":$$TXT("PR"),C["CD":$$TXT("PC"),C["BD":$$TXT("NC"),C["C":$$TXT("P"),C["B":$$TXT("N"),C["NX":$$TXT("N"),C["DF":$$TXT("DF"),C["NZ":$$TXT("P"),1:$$TXT("NA"))
 W:$D(^TMP("PSJ",$J,PSJC)) !,$E($E(SLS,1,(80-$L(LN2))/2)_" "_LN2_$E(SLS,1,(80-$L(LN2))/2),1,80)
 S PSJF="^PS("_$S(PSJC'["C":"55,"_PSGP_",5,",1:"53.1,") S TF=$S(PSJC["C":0,1:TF)
 I $P(PSJC,"^")="Cz",($P(PSJC,"^",2)]"") S PSJF="^PS("_$S($P(PSJC,"^",4)'["C":"55,"_PSGP_",5,",1:"53.1,"),TF2=$P(PSJC,"^",2)
 Q
 ;
TXT(X) ;
 I $G(X)="" Q ""
 I X="A" Q "A C T I V E"
 S PSJDCEXP=$$RECDCEXP^PSJP()
 I $P(X,"^")="Cz" Q $P(X,"^",2)
 I X="DF" Q "RECENTLY DISCONTINUED/EXPIRED (LAST "_+$G(PSJDCEXP)_" HOURS)"
 I X="N" Q "N O N - V E R I F I E D"
 I X="NA" Q "N O N - A C T I V E"
 I X="NC" Q "N O N - V E R I F I E D  C O M P L E X"
 I X="P" Q "P E N D I N G"
 I X="PC" Q "P E N D I N G  C O M P L E X"
 I X="PR" Q "P E N D I N G   R E N E W A L S"
 Q ""
 ;
BOT ; print name, ssn, and dob on bottom of page
 F Q=$Y:1:IOSL-4 W !
 W !,?2,$P(PSGP(0),"^"),?40,PSJPPID,?70,$E($P(PSJPDOB,"^",2),1,8)
 Q
WS(PSJPWD,PSGP,PSJF,PSJO) ; - WARD STOCK flag, input=(ward,dfn,file root,order)
 ; Naked reference below refers to full reference ^PS(55,DFN,5,+PSJO,1,"B",PSWS) using indirection.
 S WS=0,PSJF=PSJF_+PSJO_",1,""B"")" I $D(@PSJF) N PSWS S PSWS=0 F  S PSWS=$O(^("B",PSWS)) Q:'PSWS  S WS=$$WSCHK(PSJPWD,PSWS) Q:WS
 Q WS
 ;
WSCHK(PSJPWD,PSWS) ; Determine if drug is ward stock item.
 Q $S(PSJPWD:$S($D(^PSI(58.1,"D",PSWS,PSJPWD)):1,$D(^PSD(58.8,"D",PSWS,PSJPWD)):1,1:0),1:0)
