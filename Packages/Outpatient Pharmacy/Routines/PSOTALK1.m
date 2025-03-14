PSOTALK1 ;BIR/EJW - SCRIPTALK INTERFACE FROM VISTA (CONT'D) ;11/09/17  12:18
 ;;7.0;OUTPATIENT PHARMACY;**135,318,282,442,502,541**;DEC 1997;Build 14
 ;External reference to File ^PS(51 supported by DBIA 2224
 ;ROB SILVERMAN-HINES DEVELOPED ORIGINAL VISTA CUSTOM SOFTWARE FOR SCRIPTALK
INST ;PARSE OUT PRINTED INSTRUCTIONS TO MAX 46 CHAR PER LINE
 K PSOLNE
 S PSOLEN=0,PSOLINE=1,PSOWDS=$L(SIG," ")
 F PSOWORD=1:1 Q:PSOWORD>PSOWDS  D  ;
 . S PSOLNE(PSOLINE)=$G(PSOLNE(PSOLINE))_$P(SIG," ",PSOWORD)_" "
 . S PSOLEN=$G(PSOLEN)+$L($P(SIG," ",PSOWORD))+1
 . I PSOLEN+$L($P(SIG," ",PSOWORD+1))>46 S PSOLINE=PSOLINE+1,PSOLEN=0
 Q
 ;
LSIG(SIG) ;EXPAND A SIG
 S SGY="" F P=1:1:$L(SIG," ") S X=$P(SIG," ",P) D:X]""  ;
 .;PSO*7*282 Intended Use Check
 .N PSOIN S PSOIN=$O(^PS(51,"B",X,0)) I PSOIN,($P(^PS(51,PSOIN,0),"^",4)<2)&($D(^PS(51,"A",X))) S %=^(X),X=$P(%,"^") I $P(%,"^",2)]"" S Y=$P(SIG,"",P-1),Y=$E(Y,$L(Y)) S:Y>1 X=$P(%,"^",2)
 .S SGY=SGY_X_" "
 Q SGY
 ;
READER(ZDIR0,ZDIRA,ZDIRB) ;BASIC SHELL FOR DIR READS
 N X,Y,DIRUT,DIROUT,DTOUT,DUOUT,DIR,ZREAD
 S DIR(0)=ZDIR0 S:$G(ZDIRA)]"" DIR("A")=ZDIRA S:$G(ZDIRB)]"" DIR("B")=ZDIRB
 D ^DIR K DIR
 S:Y]"" ZREAD=Y
 I $D(DTOUT)!($D(DIRUT)) K ZREAD
 Q $G(ZREAD,"")
 ;
PSOSTALK ; SEE IF SCRIPTALK PATIENT AND PRINTER EXISTS AND IS SET TO AUTO-PRINT
 N A
 S PSOSTALK=0
 I $G(PSOONEVA) Q  ; Prevents printing ScripTalk Label for OneVA Pharmacy Fills
 D AUTO^PSOTALK
 I 'PSOSTALK Q
 D NOW^%DTC S NOW=% K %,%H,%I I $G(RXF)="" S RXF=0 F I=0:0 S I=$O(^PSRX(RX,1,I)) Q:'I  S RXF=I
 S IR=0 F FDA=0:0 S FDA=$O(^PSRX(RX,"L",FDA)) Q:'FDA  S IR=FDA
 S IR=IR+1,^PSRX(RX,"L",0)="^52.032DA^"_IR_"^"_IR
 S ^PSRX(RX,"L",IR,0)=NOW_"^"_$S($G(RXP):99-RXPI,1:RXF)_"^"_"ScripTalk label printed"_$S($G(RXP):" (Partial)",1:"")_$S($G(REPRINT):" (Reprint)",1:"")_"^"_PDUZ_"^^"_$G(PSOLAP) ;*442
 S A=$P($G(^PS(59,+PSOSITE,"STALK")),"^",4) I A=0 S PSOSTALK=0
 Q
 ;
