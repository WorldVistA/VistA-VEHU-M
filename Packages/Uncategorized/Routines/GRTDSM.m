%GRT ;27-Feb-84;Driver for Routines/Globals transfer between systems; DSM V3 ; 12 DEC 84  4:27 PM
 ;****************************************
 ;
 ; Uses Asynch line to send routines or entire Globals to another CPU
 ; Need operators at both ends to start the Sender and Receiver within
 ; 4*MAX seconds of each other.
 ;
 ; DIR = direction [S]end or [R]eceive ; MOD = [G]lobal or [R]outine
 ; transfer ; DSP = Data is displayed or not as going across at sending
 ; end ; DEV = port.
 ;
 ; Uses %RSEL to set routines and %GSEL to select Globals, but only
 ; complete Globals can be transferred.
 ;
 ;****************************************
DIR S QUES="DIRQ",DEF="" X ^%Q("EN"),^%Q("SGCNV") Q:"^"[ANS  S DIR=$E(ANS) G:"SR"'[DIR DIR
MOD S DEF="",QUES="MODQ" X ^%Q("EN"),^%Q("SGCNV") G:"^"[ANS DIR S MOD=$E(ANS) G:"GR"'[MOD MOD
DSP S DSP="N" I DIR="S" S DEF="",QUES="DSPQ" X ^%Q("ASKYN"),^%Q("SGCNV") G:"^"[ANS MOD S DSP="Y"[$E(ANS)
DEV S %QTY=101+(DIR="S") W !!,"Enter port (terminal number) for transfer."
 D ^%IOS G:'$D(%DTY) DSP S DEV=%IOD I %DTY'="TRM" W !!,"NOT A TERMINAL DEVICE." G DEV 
SEL K ^UTILITY($J) I DIR="S" D @("^%"_MOD_"SEL") G:$O(^UTILITY($J,""))="" DEV
 G:MOD="R"!(DIR="R") INI
 S X=""
 F I=1:1 S X=$O(^UTILITY($J,X)) Q:X=""  I ^UTILITY($J,X)]"" W !!,"Only full globals can be transferred.",! Q
 G:X]"" SEL
INI W !! D ^%GRTINI
 W !,"Type <RET> when ",$S(DIR="S":"Receiv",1:"Send") R "er is ready:",Z G:Z="^" DEV
 W !! D @(DIR_"^%GRT"_DIR)
 Q
DIRQ W !,"Are you [S]ending or [R]eceiving" Q
DIRQH W !,"Enter 'S' or 'R'",! Q
MODQ W !,"Are you ",$S(DIR="R":"Receiv",1:"Send"),"ing [G]lobals or [R]outines" Q
MODQH W !,"Enter 'G' or 'R'",! Q
DSPQ W !,"Do you wish to display the data" Q
DSPQH W !,"Enter 'Y' or 'N' indidcating whether you wish the data displayed here",!
 W "as it goes across",! Q
DEVQ W !,"Enter the port (terminal number) for the transfer" Q
DEVQH W !,"The asynchronous line should be entered as a terminal device number",! Q
