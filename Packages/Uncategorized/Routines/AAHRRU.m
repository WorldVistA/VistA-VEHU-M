%AAHRRU ;402,DJB,6/25/92**Getline,FF,Msg
 ;;GEM III;;
 ;;David Bolduc - Augusta,ME
GETLINE(PROMPT) ;;Extrinsic Function to return line number
 ;;Returns: ^,?,M,"INVALID","INVALID RNG",Line number or range.
 NEW LN,X1,X2 W !?1,PROMPT
 R LN:GEMTIME S:'$T!(LN="") LN="^" I LN="^" Q LN
 S:LN["." LN=LN\1 S:LN<0 LN=-LN
 I $E(LN)="?" S LN="?" Q LN
 I "m,M"[LN S LN="M" Q LN
 I LN["-" S X1=$P(LN,"-"),X2=$P(LN,"-",2) S:X2>ARRHIGH X2=ARRHIGH S:X1'?1.N!(X1<1)!(X1>X2)!(X2'?1.N) LN="INVALID RNG" S:LN'="INVALID RNG" LN=X1_"-"_X2 Q LN
 I PROMPT["INSERT AFTER LINE NUMBER"!(PROMPT["UNSAVE AFTER LINE NUMBER"),LN=0 Q LN
 I LN'?1.N!(LN<1)!(LN>ARRHIGH) S LN="INVALID"
 Q LN
SCREEN ;Set up bottom part of display
 S DX=1,DY=21 W @GEMSYS("CRSR"),@GEMSYS("BLANK")
 S DX=1,DY=20 W @GEMSYS("CRSR")
 Q
FF ;
 Q:FLAGL
 W @GEMIOF,?15,"Routine ",ARRS," of 4: ^",ARRPGM,"   Lines: ",ARRHIGH,!,$E(ARRLINE,1,GEMIOM)
 Q
MSG ;Messages
MSG1 W "   Select from menu bar above." Q
MSG2 W *7,"   Invalid line number" Q
MSG3 W *7,"   Invalid selection" Q
MSG4 W "   Enter line number or 'M' to return to Marked line" Q
MSG5 W *7,"   You must be Editing & not have branched to another Program" Q
MSG6 W *7,"   You haven't Marked any lines" Q
MSG7 W *7,"   You can't Branch to more than 4 programs" Q
