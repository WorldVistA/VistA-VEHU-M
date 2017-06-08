%AAHRRC ;402,DJB,6/25/92**Saves any editing changes
 ;;GEM III;;
 ;;David Bolduc - Augusta,ME
SAVE ;Called by ^%AAHE global. Saves any editing changes.
 ;If ARRPGM is defined, ^%AAHE will save edited routine to @ARRPGM.
 ;If you don't want changes saved, this routine should Quit with
 ;ARRPGM="".
 S ARRPGM=$G(^TMP("PGM",$J,1,"NAME")) Q:ARRPGM']""
 N CD,XX
 W !!?1,"Routine: ^",ARRPGM
SAVE1 W !?1,"Save your changes? YES//" D YN I XX="N" S ARRPGM="" G EX
 I XX="?" W "   Y=Yes  N=No  A=Save As" G SAVE1
 I $E(ARRPGM)="%" W *7,"   Sorry, I can't Save a '%' routine" S ARRPGM="" G SAVE1
 I XX="A" W ! D SAVENEW G:ARRPGM']"" EX
 K ^UTILITY($J)
 F XX=1:1 Q:'$D(^TMP("PGM",$J,1,"TXT",XX))  S CD=^(XX),CD=$P(CD,$C(9))_" "_$P(CD,$C(9),2,999),^UTILITY($J,0,XX)=CD
EX ;
 Q
SAVENEW ;
 R !?1,"Save as program: ^",ARRPGM:600 S:'$T ARRPGM="^" I "^"[ARRPGM S ARRPGM="" Q
 I $E(ARRPGM)="?" W "   Saves edited program with specified name" G SAVENEW
 I $E(ARRPGM)="^" S ARRPGM=$E(ARRPGM,2,99)
 I $E(ARRPGM)="%" W *7,"   Sorry, I can't SAVE a '%' routine" G SAVENEW
 I ARRPGM'?1A1.7AN W *7,"   Invalid program name" G SAVENEW
 I $$EXIST^%AAHRRZ(ARRPGM) D SAVEASK I ARRPGM']"" W ! G SAVENEW
 S $P(^TMP("PGM",$J,1,"TXT",1),$C(9))=ARRPGM
 Q
SAVEASK ;
 W *7,!!?1,"WARNING...Program ^",ARRPGM," already exists."
SAVEASK1 W !?1,"Shall I overwrite? YES//" D YN I XX="N" S ARRPGM="" Q
 I XX'="Y" W "   Y=Yes  N=No" G SAVEASK1
 Q
YN ;Process YES/NO type questions. Returns either ^, ?, Y, N, or A.
 R XX:600 S:'$T XX="^" S:XX="" XX="Y" S:XX="a" XX="A"
 I ",n,no,NO,"[(","_XX_",") S XX="N"
 I ",y,yes,YES,"[(","_XX_",") S XX="Y"
 I ",^,Y,N,A,"'[(","_XX_",") S XX="?"
 Q
