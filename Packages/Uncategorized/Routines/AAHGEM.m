AAHGEM ;402,DJB,5/11/92**Set Up GEM Package
 ;;GEM III;;
 ;David Bolduc - Augusta,ME
 NEW %D,%S,CODE,FF,FLAGQ,I,LINE,SPACE,TXT,U,X,Y
 S FLAGQ=0 D INIT,GEM,BLINK,ASK G:FLAGQ EX D UCI G:FLAGQ EX
 D ^AAHGEMA G:FLAGQ=2 EX ;AGL,ARR,EDD
 W !!?2,"Finished."
EX ;
 Q
GEM ;
 W @FF
 F I=1:1:16 W !?2,LINE
 W !!?4,"WELCOME to the GEM programming environment. GEM is designed to run from"
 W !?4,"your MGR UCI as '%' routines, so it's available to all UCIs."
 W !?4,"This program will initialize the GEM environment."
 Q
BLINK ;Set up blinking GEM
 W $C(27)_"[5m" ;Turn blink on
 S SPACE="@" D LETTERS^AAHGEML
 W $C(27)_"[m" ;Turn blink off
 Q
ASK ;
 NEW XX
 R !!?4,"<RETURN> to begin initialization, '^' to quit:  ",XX:100 S:'$T XX="^" I XX'="" S FLAGQ=1 Q
 Q
UCI ;
 S FLAGQ=0 W @FF
 Q:'$D(^%ZOSF("UCI"))  X ^%ZOSF("UCI") I Y["MG" Q
 W *7,!!?2,"THIS IS NOT THE MANAGER UCI. I think it is ",Y,"."
 D YESNO("Should I continue anyway: YES// ") Q:FLAGQ
 Q
MOVE ;
 F I=1:1:$L(%D,U) S X=$P(%S,U,I),Y=$P(%D,U,I) I X]"",Y]"" W !?2,"Loading ",X X "ZL @X ZS @Y" W ?22,"Saved as ",Y
 Q
YESNO(PRMPT) ;Process YES/NO questions
 NEW XX S PRMPT=$G(PRMPT)
YN W !?2,PRMPT R XX:120 S:'$T XX="^" S:XX="" XX="YES" S XX=$E(XX)
 S:"Nn"[XX FLAGQ=1 S:"^"[XX FLAGQ=2 Q:FLAGQ
 I "YyNn"'[XX W !?10,"Y=Yes  N=No  ^=Quit" G YN
 Q
INIT ;Set numbers
 S FF="#,*27,""[2J"",*27,""[H""",U="^"
 S $P(LINE,"@",76)=""
 Q
