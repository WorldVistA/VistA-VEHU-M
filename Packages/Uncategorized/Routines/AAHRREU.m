%AAHRREU ;402,DJB,6/25/92**CHANGE - Scrn Mode - Utilities
 ;;GEM III;;
 ;;David Bolduc - Augusta,ME
CHKTAG ;Check for invalid line tag
 NEW TAG,TAG1
 S TAG1=$P(CD,$C(9)) Q:TAG1']""  S TAG=$P(TAG1,"(")
 I $E(TAG)'?1AN,$E(TAG)'="%" D MSG1,PAUSE S FLAGQ=1 Q
 I $L(TAG)>1,$E(TAG)'?1N,$E(TAG,2,999)'?1.AN D MSG1,PAUSE S FLAGQ=1 Q
 I $E(TAG)?1N,TAG'?1.N D MSG1,PAUSE S FLAGQ=1 Q
 I TAG1?.E1"(""".E1""")" D  D MSG2,PAUSE S FLAGQ=1 Q
 .S CODETG=$P(CODETG,"("),$P(CD,$C(9))=CODETG D SAVE
 Q
CLRSCRN ;Clear the editing portion of the screen
 S DX=0,DY=TOP
 W @GEMSYS("CRSR"),@GEMSYS("BLANK"),ARRLINE,@GEMSYS("CRSR")
 Q
CLRSCRN1 ;
 S DX=XCUR,DY=(TOP+YCUR+1) W @GEMSYS("CRSR")
 Q
SAVE ;Save changes.
 S ^TMP("PGM",$J,ARRS,"TXT",ARRLN)=CD,FLAGSAVE=1
 Q
CHECK ;Check for any exclusive KILLs
 Q:$G(CD)']""
 NEW CHK,CDLN,I,X,XX
 S CD=$TR(CD,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ"),CDLN=$P(CD,$C(9),2,999)
 Q:CDLN'?.E1"K".E1"^".E  S CHK=0,X=""
 F I=1:1 S X=$P(CDLN," ",I) Q:X=""  I X["^",$P(CDLN," ",I-1)["K" S CHK=1 Q
 Q:'CHK
 W *7,!?15,@GEMRON," WARNING: Your code may contain an exclusive KILL. ",@GEMROFF
 W !?15,@GEMRON," <RETURN> to continue..                            ",@GEMROFF R GEMXX:GEMTIME
 Q
RESET ;TAB1 cancelled. Erase "DEL" display
 S (TAB1,TAB2)=0
 S DX=70,DY=TOP W @GEMSYS("CRSR"),@GEMSYS("BLANK2"),"========|"
 S DX=XCUR,DY=TOP+1+YCUR W @GEMSYS("CRSR")
 Q
PAUSE ;
 NEW XX R XX:GEMTIME
 Q
MSG1 W *7,!?15,@GEMRON,"Invalid Line Tag      ",@GEMROFF,!?15,@GEMRON,"<RETURN> to continue..",@GEMROFF Q
MSG2 W *7,!?15,@GEMRON," Line Tag may not be in the form: NAME(""AA""). ",@GEMROFF,!?15,@GEMRON,"             <RETURN> to continue..           ",@GEMROFF Q
