%AAHGLE ;402,DJB,10/31/92**Edit Global Node
 ;;GEM III;;
 ;;David Bolduc - Augusta,ME
EDITV ;Edit node's value
 NEW CHK,CD,CDX,CDY,FLAGQ,NEW,ND,NODE,OLD,TAB,TEMP,TEMP1,TYPE,X1,X2
 S FLAGQ=0,TYPE="V" D GETNODE Q:FLAGQ  G:$G(X1)]"" RANGE S (CDX,CDY)="",CD=@NODE
 D EDIT Q:$L(CD)>245  D CHECK
 S @NODE=CD
 Q
EDITS ;Edit node's subscript
 NEW CHK,CD,CDX,CDY,FLAGQ,NEW,ND,NODE,OLD,TAB,TEMP,TEMP1,TYPE,X1,X2
 S FLAGQ=0,TYPE="S" D GETNODE Q:FLAGQ  G:$G(X1)]"" RANGE S CDX=$P(NODE,"(")_"(",CDY=")",CD=$P(NODE,"(",2,999),CD=$E(CD,1,$L(CD)-1) ;Set CD=Subscript Only
 D EDIT Q:$L(CD)>127  S CD=CDX_CD_CDY
 I $D(@CD)#2 D MSG1,PAUSE Q  ;Don't overwrite existing node
 I $D(@NODE)>1 D MSG8,PAUSE Q  ;Don't delete node that has decendents
 S @CD=@NODE K @NODE S ^TMP("A#GL",$J,GLS,PAGETEMP,ND)=CD
 Q
GETNODE ;Edit a Global Node
 R !?1,"Enter NODE: ",ND:GEMTIME S:'$T ND="^" I "^"[ND S FLAGQ=1 Q
 ;;Next line allows processing a range. It's commented out because this is dangerous when doing ES (subscript edit). You must understand Node Decendents before using.
 ;I ND?1.N1"-"1.N D  G:ND']"" GETNODE Q
 .S X1=$P(ND,"-"),X2=$P(ND,"-",2)
 .I '$D(^TMP("A#GL",$J,GLS,PAGETEMP,X1))!('$D(^TMP("A#GL",$J,GLS,PAGETEMP,X2)))!(X1>X2) D MSG6 S ND=""
 I ND'?1.N D MSG2 G GETNODE
 I '$D(^TMP("A#GL",$J,GLS,PAGETEMP,ND)) D MSG3 G GETNODE
 S NODE=^TMP("A#GL",$J,GLS,PAGETEMP,ND) S:NODE="" FLAGQ=1
 Q
EDIT ;Edit CD
 W !!,CDX_CD_CDY ;This insures that EL only edits the subscript
 R !!,"REPLACE: ",OLD:GEMTIME Q:OLD=""  S:OLD="end" OLD="END"
 I OLD="..." S OLD=CD
 I OLD?.E1"...".E S TEMP=$P(OLD,"..."),TEMP1=$P(OLD,"...",2) D  I CD'[OLD D MSG5 G EDIT
 .I TEMP="" S OLD=$E(CD,1,($F(CD,TEMP1)-1)) Q
 .I TEMP1="" S OLD=$E(CD,($F(CD,TEMP)-$L(TEMP)),$L(CD)) Q
 .S CHK=$F(CD,TEMP),OLD=$E(CD,(CHK-$L(TEMP)),($F(CD,TEMP1,CHK)-1))
 I OLD'="END",CD'[OLD D MSG5 G EDIT
 R !,"WITH: ",NEW:GEMTIME Q:'$T
 S CD=$S(OLD="END":CD_NEW,1:$P(CD,OLD)_NEW_$P(CD,OLD,2,999))
 I TYPE="V",$L(CD)>245 D MSG4
 I TYPE="S",$L(CD)>127 W ! D MSG7
 G EDIT
RANGE ;Edit a range of subscripts or values
 NEW ADJ,CD,FD,I,NEW,OLD,START
 R !!,"REPLACE: ",OLD:GEMTIME Q:OLD=""
 R !,"WITH: ",NEW:GEMTIME
 F ND=X1:1:X2 D RANGE1
 Q
RANGE1 ;Replace OLD with NEW
 Q:'$D(^TMP("A#GL",$J,GLS,PAGETEMP,ND))  S NODE=^(ND)
 I TYPE="V" S CD=@NODE I CD'[OLD Q
 I TYPE="S" S CD=$P(NODE,"(",2,999),CD=$E(CD,1,$L(CD)-1) I CD'[OLD Q
 S START=0,ADJ=$L(NEW)-$L(OLD) ;ADJ will adjust START if NEW is different length than OLD
 F I=1:1:($L(CD,OLD)-1) S FD=$F(CD,OLD,START),START=FD+ADJ,CD=$E(CD,1,(FD-$L(OLD)-1))_NEW_$E(CD,FD,999)
 I TYPE="V",$L(CD)>245 W *7 Q  ;Value too long
 I TYPE="S",$L(CD)>127 W *7 Q  ;Subscript too long
 I CD']"" Q
 I TYPE="V" S @NODE=CD
 I TYPE="S" S CD=$P(NODE,"(")_"("_CD_")" D
 .I $D(@CD)#2 W *7 Q  ;Don't overwrite an existing node
 .I '$D(@NODE) W *7 Q  ;Old node doesn't exist
 .I $D(@NODE)>1 W *7 Q  ;Don't delete a node with descendents
 .S @CD=@NODE K @NODE S ^TMP("A#GL",$J,GLS,PAGETEMP,ND)=CD
 Q
CHECK ;Check for any exclusive KILLs
 NEW CD1,CHK,I,X,XX
 S CD1=$TR(CD,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q:CD1'?.E1"K".E1"^".E  S CHK=0,X=""
 F I=1:1 S X=$P(CD1," ",I) Q:X=""  I X["^",$P(CD1," ",I-1)["K" S CHK=1 Q
 Q:'CHK
 W *7,!!?2,"WARNING: Your code may contain an exclusive KILL."
 R !?2,"<RETURN> to continue..",GEMXX:GEMTIME
 Q
PAUSE ;
 R !!?2,"<RETURN> to continue..",TEMP:GEMTIME
 Q
MSG ;Messages
MSG1 W *7,!!?2,"This node already exists. Aborting.." Q
MSG2 W "   Enter number from left hand column" Q
MSG3 W *7,"   Invalid. Enter number from left hand column" Q
MSG4 W *7,"   Illegal line" Q
MSG5 W *7,"   No match. NOTE: You may only edit node's subscript." Q
MSG6 W *7,"   Invalid range" Q
MSG7 W *7,"   Subscript too long" Q
MSG8 W *7,"   I can't edit a node that has decendents" Q
