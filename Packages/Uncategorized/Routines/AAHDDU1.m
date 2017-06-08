%AAHDDU1 ;402,DJB,11/2/91,EDD**Templates,Description
 ;;GEM III;;
 ;;David Bolduc - Togus,ME
EN ;Templates
 I '$D(^DIBT("F"_ZNUM)),'$D(^DIPT("F"_ZNUM)),'$D(^DIE("F"_ZNUM)) W ?30,"No Templates" S FLAGG=1 G EX
 NEW A,B,DISYS,DIW,DIWI,DIWTC,DIWX,DIWT,DIWL,DIWF,DIWR,DN,HEAD,I,II,R,VAR,ZX
 S Z1="" D INIT^%AAHDDPR G:FLAGQ EX D HD
 D DIPT G:FLAGQ EX D DIBT G:FLAGQ EX D DIE
EX ;
 Q
DIPT ;Print Templates
 S HEAD="A.)  PRINT TEMPLATES:" W !?2,HEAD
 S A="",VAR="^DIPT"
 F II=1:1 S A=$O(^DIPT("F"_ZNUM,A)) Q:A=""  W !?12,$J(II,4),".  ",A S B=$O(^DIPT("F"_ZNUM,A,"")) W:$D(^DIPT(B,"ROU")) ?60,"Compiled: ",^DIPT(B,"ROU") I $Y>GEMSIZE D PAGE Q:FLAGQ!(Z1="S")
 I II=1 W ?25,"No print templates..."
 Q
DIBT ;Sort Templates
 S HEAD="B.)  SORT TEMPLATES:" W !?2,HEAD
 S A="",VAR="^DIBT"
 F II=1:1 S A=$O(^DIBT("F"_ZNUM,A)) Q:A=""  W !?12,$J(II,4),".  ",A I $Y>GEMSIZE D PAGE Q:FLAGQ!(Z1="S")
 I II=1 W ?25,"No sort templates..."
 Q
DIE ;Edit Templates
 S HEAD="C.)  INPUT TEMPLATES:" W !?2,HEAD
 S A="",VAR="^DIE"
 F II=1:1 S A=$O(^DIE("F"_ZNUM,A)) Q:A=""  W !?12,$J(II,4),".  ",A S B=$O(^DIE("F"_ZNUM,A,"")) W:$D(^DIE(B,"ROU")) ?60,"Compiled: ",^DIE(B,"ROU") I $Y>GEMSIZE D PAGE Q:FLAGQ!(VAR="")
 I II=1 W ?25,"No input templates..."
 Q
PAGE ;Templates
 I VAR="^DIE" S ZX=VAR_"(""F"_ZNUM_""","""_A_""")" I $O(@ZX)="" S VAR="" Q
 I FLAGP,$E(GEMIOST,1,2)="P-" W @GEMIOF,!!! D HD Q
 W !!?2,"<RETURN> to continue, 'S' to skip, '^' to quit, '^^' to exit: "
 R Z1:GEMTIME S:'$T Z1="^" I Z1["^" S FLAGQ=1 S:Z1="^^" FLAGE=1 Q
 I Z1="S",VAR="^DIE" S FLAGQ=1 Q
 S ZX=VAR_"(""F"_ZNUM_""","""_A_""")"
 W @GEMIOF D HD I Z1="S"!($O(@ZX)="") Q
 W !?2,HEAD," continued..." Q
PAGE1 ;File Description
 I FLAGP,$E(GEMIOST,1,2)="P-" W @GEMIOF,!!! D HD1 Q
 R !!?2,"<RETURN> to continue, '^' to quit, '^' to exit: ",Z1:GEMTIME
 S:'$T Z1="^" I Z1["^" S FLAGQ=1 S:Z1="^^" FLAGE=1 Q
 W @GEMIOF D HD1
 Q
DES ;File Description
 I FLAGP D PRINT^%AAHDDPR ;Shut off printing
 I '$D(^DIC(ZNUM,"%D")) W ?30,"No description available." S FLAGG=1 Q
 NEW A,DIW,DIWF,DIWL,DIWR,DIWT,DN,Z
 W @GEMIOF D HD1
 K ^UTILITY($J,"W")
 S A=0 F  S A=$O(^DIC(ZNUM,"%D",A)) Q:A=""  S X=^DIC(ZNUM,"%D",A,0),DIWL=5,DIWR=75,DIWF="W" D ^DIWP I $Y>GEMSIZE D PAGE1 Q:FLAGQ
 D:'FLAGQ ^DIWW
 G EX
HD ;Templates
 W !?2,"T E M P L A T E S        PRINT  *  SORT  *  INPUT",!,$E(GEMLINE,1,GEMIOM)
 Q
HD1 ;File description
 W !?2,"File description for ",ZNAM," file.",!,$E(GEMLINE1,1,GEMIOM)
 Q
