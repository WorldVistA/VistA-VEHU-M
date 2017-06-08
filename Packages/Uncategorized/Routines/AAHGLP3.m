%AAHGLP3 ;402,DJB,3/31/92**Print PIECE Data Dictionary
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
STRING ;String=code - Prints a string in lines of 55 characters
 NEW I
 F I=1,58,115,172,229,286 Q:$L(STRING)<I  W:I>1 ! W ?M3,$E(STRING,I,I+56) I $Y>GEMSIZE D PAGE Q:FLAGQ
 Q
WORD ;String=text - Prints a string in lines of 55 characters
 S LINE(1)=$E(STRING,1,55)
 I $L(STRING)>55 S LINE(1)=$P(LINE(1)," ",1,$L(LINE(1)," ")-1)
 W ?M3,LINE(1) I $Y>GEMSIZE D PAGE Q:FLAGQ
 S LENGTH=$L(LINE(1))
 Q:$L(STRING)'>LENGTH
 S LINE(2)=$E(STRING,LENGTH+2,LENGTH+57)
 I $L(STRING)>(LENGTH+2+55) S LINE(2)=$P(LINE(2)," ",1,$L(LINE(2)," ")-1)
 W !?M3,LINE(2) I $Y>GEMSIZE D PAGE Q:FLAGQ
 S LENGTH=LENGTH+2+$L(LINE(2))
 Q:$L(STRING)'>LENGTH
 S LINE(3)=$E(STRING,LENGTH+2,LENGTH+57)
 I $L(STRING)>(LENGTH+2+55) S LINE(3)=$P(LINE(3)," ",1,$L(LINE(3)," ")-1)
 W !?M3,LINE(3) I $Y>GEMSIZE D PAGE Q:FLAGQ
 S LENGTH=LENGTH+2+$L(LINE(3))
 S LINE(4)=$E(STRING,LENGTH+2,LENGTH+57)
 I $L(STRING)>(LENGTH+2+55) S LINE(4)=$P(LINE(4)," ",1,$L(LINE(4)," ")-1)
 W !?M3,LINE(4) I $Y>GEMSIZE D PAGE Q:FLAGQ
 S LENGTH=LENGTH+2+$L(LINE(4))
 S LINE(5)=$E(STRING,LENGTH+2,LENGTH+57)
 I $L(STRING)>(LENGTH+2+55) S LINE(5)=$P(LINE(5)," ",1,$L(LINE(5)," ")-1)
 W !?M3,LINE(5) I $Y>GEMSIZE D PAGE Q:FLAGQ
 S LENGTH=LENGTH+2+$L(LINE(5))
 S LINE(6)=$E(STRING,LENGTH+2,LENGTH+57)
 I $L(STRING)>(LENGTH+2+55) S LINE(6)=$P(LINE(6)," ",1,$L(LINE(6)," ")-1)
 W !?M3,LINE(6) I $Y>GEMSIZE D PAGE Q:FLAGQ
 Q
DTYPE1 ;Data types
 W !?M3,$S(ZDSUB["B":"True-False (""Boolean"")",ZDSUB["I":"Uneditable",ZDSUB["O":"Has output transform",ZDSUB["R":"Required field",ZDSUB["X":"Input Transform has been modified in Utility Option",1:"")
 Q
DTYPE2 ;Data types
 W !?M3,$S(ZDSUB["a":"Marked for auditing",ZDSUB["m":"Multilined",ZDSUB["*":"Field has a screen",ZDSUB["'":"LAYGO to ""pointed to"" file not allowed",1:"")
 Q
PAGE ;
 NEW I
 I $Y'>GEMSIZE F I=$Y:1:GEMSIZE W !
 W !,$E(GEMLINE1,1,GEMIOM)
 R !?2,"<RETURN> to continue, '^' to quit: ",Z1:GEMTIME S:'$T Z1="^" I Z1["^" S FLAGQ=1 Q
 W @GEMIOF W !?55,"FLD NUMBER: ",FNUM,!,$E(GEMLINE1,1,GEMIOM)
 Q
