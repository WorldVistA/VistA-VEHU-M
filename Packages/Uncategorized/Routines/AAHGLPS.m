%AAHGLPS ;402,DJB,3/24/92**PIECES - Xref,Word Proc,Zero Nodes
 ;;GEM III;;
 ;;David Bolduc - Togus,ME
XREF ;Display field if Xref node
 NEW FILE,FLAGQ,FNAM,FNUM,LENGTH,LEV,M1,M2,M3,M4,M5
 S FLAGQ=0,M1=2,M2=15,M3=20,M4=22,M5=25 ;Variables for column numbers
 S TEMP="" F I=1:1:(FLAGXREF-1) S TEMP=TEMP_$P(SUBCHK,ZDELIM,I)_","
 S TEMP=GL_"("_TEMP_"0)" I '$D(@TEMP)#2 D XREFMSG,PAUSE^%AAHGLP Q
 S TEMP1=$P(SUBCHK,ZDELIM,FLAGXREF),TEMP1=$E(TEMP1,2,$L(TEMP1)-1) ;strip off quote marks
 S GEMXX=$P(@TEMP,U,2),GEMXY="" F I=1:1:$L(GEMXX) I $E(GEMXX,I)?1N!($E(GEMXX,I)?1".") S GEMXY=GEMXY_$E(GEMXX,I) ;Strip off alpha
 S LEV=1,FILE(LEV)=$O(^DD(GEMXY,0,"IX",TEMP1,""))
 I $G(FILE(LEV))]"" S FNUM=$O(^DD(GEMXY,0,"IX",TEMP1,FILE(LEV),""))
 I $G(FNUM)]"" S FNAM=$P(^DD(FILE(LEV),FNUM,0),U)
 I $G(FNUM)=""!($G(FNAM)="")!($G(FILE(LEV))="") D XREFMSG,PAUSE^%AAHGLP Q
 D ^%AAHGLP1 I 'FLAGQ D PAUSE^%AAHGLP
 Q
XREFMSG ;Display msg if no data on Xref
 W *7,"   The Data Dictionary has no data on this Xref."
 Q
WP ;Display field if Word Processing node
 NEW FILE,FLAGQ,FNAM,FNUM,LENGTH,LEV,M1,M2,M3,M4,M5
 S FLAGQ=0,FLAGWP=1,M1=2,M2=15,M3=20,M4=22,M5=25 ;Variables for column numbers
 S TEMP="" F I=1:1:($L(SUBCHK,ZDELIM)-4) S TEMP=TEMP_$P(SUBCHK,ZDELIM,I)_","
 S TEMP=GL_"("_TEMP_"0)" I '$D(@TEMP)#2 D WPMSG,PAUSE^%AAHGLP Q
 S NODE=$P(SUBCHK,ZDELIM,($L(SUBCHK,ZDELIM)-2)) I +NODE'=NODE S NODE=$E(NODE,2,$L(NODE)-1) ;If NODE is alpha strip off quotes.
 S GEMXX=$P(@TEMP,U,2),GEMXY="" F I=1:1:$L(GEMXX) I $E(GEMXX,I)?1N!($E(GEMXX,I)?1".") S GEMXY=GEMXY_$E(GEMXX,I) ;Strip off alpha
 I GEMXX']""!(GEMXY']"") D WPMSG,PAUSE^%AAHGLP Q
 S TEMP=$O(^DD(GEMXY,"GL",NODE,0,"")),TEMP="^DD("_GEMXY_","_TEMP_",0)"
 S GEMXX=$P(@TEMP,U,2),GEMXY="" F I=1:1:$L(GEMXX) I $E(GEMXX,I)?1N!($E(GEMXX,I)?1".") S GEMXY=GEMXY_$E(GEMXX,I) ;Strip off alpha
 I GEMXX']""!(GEMXY']"") D WPMSG,PAUSE^%AAHGLP Q
 S LEV=1,FILE(LEV)=GEMXY
 I $G(FILE(LEV))]"" S FNUM=.01
 I $G(FNUM)]"" S FNAM=$P(^DD(FILE(LEV),FNUM,0),U)
 I $G(FNUM)=""!($G(FNAM)="")!($G(FILE(LEV))="") D WPMSG,PAUSE^%AAHGLP Q
 D ^%AAHGLP1 I 'FLAGQ D PAUSE^%AAHGLP
 Q
WPMSG ;Display msg if no data on Word Processing field.
 W *7,"   Invalid node."
 Q
ZERO ;Display characteristics of zero node
 W @GEMIOF,!?1,"Global Pieces(INT VALUE): ",Z1,") ",GLNAM,!,$E(GEMLINE1,1,GEMIOM)
 W !?1 S GLVAL=@GLNAM F I=1:1:4 W:I>1 "    " W "(",I,") ",$P(GLVAL,U,I)
 W !!?1,"This is a Zero Node which has the following characteristics:"
 W !?4,"Piece 1 = File name",?32,"Piece 3 = Most recently assigned entry number"
 W !?4,"Piece 2 = File number",?32,"Piece 4 = Total number of entries"
 W !!?1,"The 2nd piece may also be followed by a string of alphabetic characters"
 W !?1,"to indicate various characteristics of the file:"
 W !?4,"D... .01 field is Date/Time"
 W !?4,"N... .01 field is a Number"
 W !?4,"P... .01 field is a Pointer to another file"
 W !?4,"S... .01 field is a Set of Codes"
 W !?4,"V... .01 field is a Variable Pointer"
 W !?4,"A... Adds entries without asking: ARE YOU ADDING A NEW ENTRY?"
 W !?4,"I... File has Identifiers"
 W !?4,"O... User is asked -OK? when a matching entry is found during look-up"
 W !?4,"s... (Lower case 's') File has a screen in ^DD(file,0,""SCR"")."
 W ! D PAUSE^%AAHGLP
 Q
