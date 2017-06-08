%AAHRRRD ;402,DJB,8/20/92**Single Character Read
 ;;GEM III;;
 ;;David Bolduc - Augusta,ME
READ(PROMPT) ;PROMPT contains what you want the user to see for a prompt.
 NEW CHAR,CHAR1,FLAGQ,I,STRING,WAIT
 S STRING="",FLAGQ=0,PROMPT=$G(PROMPT)
 S WAIT=$S($G(^%AAHSH("PARAM","WAIT"))]"":^("WAIT"),1:150)
 W PROMPT X GEMSYS("EOFF")
 ;FLAGONE returns a single character to the calling program, without hitting <RETURN>.
 F  D GETCHAR D  Q:FLAGQ!($L(STRING)>244)!($G(FLAGONE)=1)
 .I CHAR?1E S STRING=STRING_CHAR Q
 .I "<BS>,<DEL>"[CHAR&(STRING]"") S STRING=$E(STRING,1,$L(STRING)-1) W *8," ",*8 Q
 .S FLAGQ=1 S:STRING="" STRING=CHAR
 X GEMSYS("EON") Q STRING
 ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
GETCHAR ;Single character READ to get individual characters
 R *CHAR:500 S:'$T!(CHAR="") CHAR=-1 I CHAR>31,CHAR<127 S CHAR=$C(CHAR) W CHAR Q
 D:CHAR=0 OTHER
 D:CHAR=27 ESCAPE
 S CHAR=$S(CHAR<0:"TO",CHAR=4:"CTRLD",CHAR=8:"BS",CHAR=9:"TAB",CHAR=13:"RET",CHAR=20:"CTRLT",1:CHAR)
 S CHAR=$S(CHAR=21:"F1",CHAR=22:"F2",CHAR=23:"F3",CHAR=24:"F4",CHAR=27:"ESC",CHAR=127:"DEL",1:CHAR)
 S CHAR="<"_CHAR_">"
 Q
 ;
ESCAPE ;Process Escape Sequences
 F I=1:1:WAIT R *CHAR:0 Q:$T
 I '$T S CHAR=27 Q
 I CHAR=91 D CURSOR Q
 I CHAR=79 D PFKEYS
 Q
CURSOR ;Arrow Keys
 R *CHAR:50 S CHAR=$S(CHAR=65:"AU",CHAR=66:"AD",CHAR=67:"AR",CHAR=68:"AL",1:CHAR)
 Q
PFKEYS ;PF Keys
 R *CHAR:50 S CHAR=$S(CHAR=80:"F1",CHAR=81:"F2",CHAR=82:"F3",CHAR=83:"F4",1:CHAR)
 Q
OTHER ;Pageup,Pagedown,Home,End
 R *CHAR:50 S CHAR=$S(CHAR=73:"PGUP",CHAR=81:"PGDN",CHAR=71:"HOME",CHAR=79:"END",1:CHAR)
 Q
