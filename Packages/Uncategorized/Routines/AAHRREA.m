%AAHRREA ;402,DJB,6/25/92**CHANGE - Scrn Mode - READ,HELP
 ;;GEM III;;
 ;;David Bolduc - Augusta,ME
 ;YCNT = total lines of code.
 ;XCUR,YCUR = screen location of cursor.
 ;XCHAR = location of cursor in the line of code .
 NEW FLAGQ,FLAGONE,TAB1,TAB2,TEMP,TOP,X,XCHAR,XCUR,YCNT,YCUR
 X GEMSYS("RM0") D SCREEN^%AAHRRU
 S (FLAGQ,TAB1,TAB2)=0,(XCHAR,YCUR)=1,XCUR=9 D PRINTA^%AAHRREP
 S FLAGONE=1 F  D READ Q:FLAGQ  ;FLAGONE makes READ^%AAHRRRD quit after getting a single character. You don't hit <RETURN>
EX ;
 I $P(^TMP("PGM",$J,ARRS,"TXT",ARRLN),$C(9),2,999)'?1.ANP D DELETE
 X GEMSYS("RM80")
 Q
READ ;
 W @GEMSYS("CION") S X=$$READ^%AAHRRRD("") W @GEMSYS("CIOFF")
 I X="<RET>" S FLAGQ=1 Q
 I X="<ESC>" Q
 I X="<CTRLD>" D BULKDEL^%AAHRREB Q
 I X="<CTRLT>" D RESET^%AAHRREU Q
 I X="<TAB>" D HELP,PRINTA^%AAHRREP Q
 I ",<AR>,<AL>,<AU>,<AD>,"[(","_X_",") D ARROW^%AAHRREB,CLRSCRN1^%AAHRREU Q
 I ",<F1>,<F2>,<F3>,<F4>,"[(","_X_",") D OTHER^%AAHRREB,CLRSCRN1^%AAHRREU Q
 I +TAB1>0 D RESET^%AAHRREU
 I ",<BS>,<DEL>,"[(","_X_",") D DELETE^%AAHRREB Q
 D INSERT^%AAHRREB
 Q
DELETE ;Delete the line if all the code has been deleted out.
 F I=ARRLN:1:(ARRHIGH-1) S ^TMP("PGM",$J,ARRS,"TXT",I)=^TMP("PGM",$J,ARRS,"TXT",(I+1))
 K ^TMP("PGM",$J,ARRS,"TXT",ARRHIGH) S ARRHIGH=ARRHIGH-1
 Q
HELP ;
 S DX=0,DY=TOP W @GEMSYS("CRSR"),@GEMSYS("BLANK1") S DY=0 W @GEMSYS("CRSR")
 W !?1,@GEMRON,"QUIT",@GEMROFF
 W " Press <RETURN> to quit CHANGE session and return  to the routine."
 W !!?1,@GEMRON,"INSERT/DELETE",@GEMROFF
 W " Type any character to insert that character to the left of the"
 W !?1,"cursor. <BACKSPACE>/<DELETE> deletes the character to the left of the cursor."
 W !!?1,@GEMRON,"ARROW KEYS",@GEMROFF
 W " Use the <ARROW> keys to position the curser. To edit the TAG, use"
 W !?1,"<UP ARROW> to move cursor to the TAG area, then make desired changes."
 W !!?1,@GEMRON,"PF KEYS",@GEMROFF
 W " Use PF keys to rapidly position the cursor when Inserting & Deleting."
 W !?3,"<PF1>,<F1> = Cursor left 15 spaces   <PF2>,<F2> = Cursor right 15 spaces"
 W !?3,"<PF3>,<F3> = Cursor to line begin    <PF4>,<F4> = Cursor to line end"
 W !!?1,@GEMRON,"BULK DELETE",@GEMROFF
 W " Position cursor and press <CTRL>-D. Reposition cursor and"
 W !?1,"press <CTRL>-D again. Everything from position 1 to position 2 will be"
 W !?1,"deleted. Press <CTRL>-T if you wish to teminate the first <CTRL>-D."
 Q
