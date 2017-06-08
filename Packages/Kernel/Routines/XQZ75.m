XQ75 ;SEA/AMF,MJM,JLI - Lookup response for jumps ;10/25/91  12:30;6/24/92  11:35 AM
 ;;7.0;Kernel;;Jul 17, 1992
 ;Enter at S with XQUR. Exit with XQY set to the chosen option #,
 ;with array of possibilities in XQ(XQ):XQY^menu txt [name]^XQPSM
 ;XQXT(XQXT) similarly built, holds exact matches
 ;XQY=-1 (no option found), or XQY=-2 (jumps shut down).
 ;
X ;Unless exact match is found, find all possibilities in any XQDIC
 S XQO=$O(^XUTL("XQO",XQDIC,XQO)) Q:'$S(XQO="":0,XQUR="?":XQO'="^",XQUR=0_$C(1):'$L($P(XQO,"0",1)),1:'$L($P(XQO,XQUR,1)))
 S XQYY=^XUTL("XQO",XQDIC,XQO) S XQY=+XQYY G:$D(XQ("X",+XQY)) X S XQY0=$P(^("^",+XQY),U,2,99)
 S XQCY=XQY,XQCY0=XQY0 D ^XQCHK I XQCY<0 S XQY=0 G X
 S:'$P(XQYY,U,2) XQ("S",+XQY)=$E(XQO,1,$L(XQO)-1)
 I XQUR=$E(XQO,1,$L(XQO)-1),'XQS S XQXT=XQXT+1,XQXT(XQXT)=+XQY_U_$P(XQY0,U,2)_"  ["_$P(XQY0,U)_"] "_U_$S($D(XQUD):XQUD_",",1:"")_XQDIC,XQXT("X",XQY)="" S:'$P(XQYY,U,2) XQXT("S",+XQY)=$E(XQO,1,$L(XQO)-1)
 S XQ=XQ+1,XQ1=XQ1+1,XQ(XQ)=+XQY_U_$P(XQY0,U,2)_"  ["_$P(XQY0,U)_"] "_U_$S($D(XQUD):XQUD_",",1:"")_XQDIC,XQ("X",XQY)=""
 I XQ1>19,'XQXT D C
 Q:XQY<0!(XQUR="")  G X
 Q
 ;
C ;Display a screen-load of 19 possibilities and ask for a choice
 S:XQ1<1 XQ1=XQ W ! F XQI=1:1:XQ1 S XQJ=XQS*20+XQI W !?4,XQJ,?9,$P(XQ(XQJ),U,2) I $D(XQ("S",+XQ(XQJ))) W ?43,"  (",XQ("S",+XQ(XQJ)),")"
ASK W !!,"Type '^' to stop, or choose a number from 1 to ",XQ," :"
 R XQJ:DTIME S:'$T XQJ=U W:XQJ["?" !!,"**> Choose an item from this list by selecting its corresponding number,",!?5,"or type a '^' to return to your menu.",! G:XQJ["?" ASK
 I XQJ'?1N.N,$L(XQJ),XQJ'=U W *7,"  ??",! G ASK
 I XQJ?1N.N G C:'$D(XQ(XQJ)) W "  " S XQUR="",%=XQ(XQJ),XQY=+% I XQY>0 S XQPSM=$P(%,U,3),XQDIC=$S($L(XQPSM,",")>1:$P(XQPSM,",",$L(XQPSM,",")),1:XQPSM),XQY0=$P(^XUTL("XQO",XQDIC,"^",XQY),U,2,99) Q
 I XQJ?1N.N W *7,$P(XQ(XQJ-1#20+1),U,4),! G C
 I '$L(XQJ),XQ1=20 S XQS=XQS+1,XQ1=0 Q
 I '$L(XQJ),XQ1<20 S XQY=-1,XQ=0 Q
 K XQ S XQY=$S(XQJ=U:-3,XQJ="":-3,1:-1),XQUR=$C(95) S:XQJ=U XQJ="" S:$L(XQJ) XQUR=$S($E(XQDIC,1)="P":U_XQJ,1:XQJ),XQY=0 Q
 Q
 ;
S ;Entry from XQ: Search primary, common, and secondary menus for XQUR
 I XQUR'?.ANP W *7 S XQY=-1 Q
 S:'$D(XQDIC) XQDIC=XQY S XQSV=XQY_U_XQDIC_U_XQY0
 S XQJ="",XQJMP=1,(XQ,XQ1,XQS,XQXT,XQY)=0
 S XQO=$E(XQUR,1,30) I XQUR'?.PUN F XQI=1:1 Q:XQO?.NUP  S XQO1=$A(XQO,XQI) I XQO1<123,XQO1>96 S XQO=$E(XQO,1,XQI-1)_$C(XQO1-32)_$E(XQO,XQI+1,255)
 S XQUR=XQO,(XQO,XQO1)=$E(XQUR,1,$L(XQUR)-1)_$C($A($E(XQUR,$L(XQUR)))-1)_"z"
 S XQDIC="P"_^XUTL("XQ",$J,"XQM") D X G:XQY<0 OUT G:XQUR="" W
 S XQDIC="PXU",XQO=XQO1 D X G:XQY<0 OUT G:XQUR="" W
 S XQDIC="U"_DUZ,XQO=XQO1 D:$S('$D(^XUTL("XQO",XQDIC,0)):1,'$D(^VA(200,DUZ,203.1)):1,1:^VA(200,DUZ,203.1)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET I '$D(^XUTL("XQO",XQDIC,0)),'XQXT D C G:XQY<0 OUT G:XQUR="" W
 D X G:XQY<0 OUT G:XQUR="" W
 F XQK=0:0 S XQUD="U"_DUZ,XQK=$O(^XUTL("XQO",XQUD,U,XQK)) Q:XQK=""  I $P(^(XQK),U,5)="M" S XQST=XQK,XQDIC="P"_XQK,XQO=XQO1 D X G:XQY<0 OUT G:XQUR="" W
 I XQXT K XQ S (XQ,XQ1)=XQXT F XQI=1:1:XQ S XQ(XQI)=XQXT(XQI),%=+XQ(XQI),XQ("X",%)="" I $D(XQXT("S",%)) S XQ("S",%)=XQXT("S",%)
 I XQ=1,XQS=0 S %=XQ(1),XQY=+%,XQPSM=$P(%,U,3),XQDIC=$S($L(XQPSM,",")>1:$P(XQPSM,",",$L(XQPSM,",")),1:XQPSM),XQY0=$P(^XUTL("XQO",XQDIC,U,XQY),U,2,99) G W
 I XQ>0,'$D(XQ(XQS*20+1)) S XQY=-1 G OUT
 D:XQ>0 C G:XQY<0 OUT I XQ=0 S XQY=-1 G OUT
 ;
W ;Write out remaining text and return to XQ
 I $D(XQ("S",+XQY)),XQUR=$E(XQ("S",+XQY),1,$L(XQUR)) W $E(XQ("S",+XQY),$L(XQUR)+1,99),"   ",$P(XQY0,U,2)
 E  W $E($P(XQY0,U,2),$L(XQUR)+1,99) W:$D(XQ("S",+XQY)) "   (",XQ("S",+XQY),")"
 ;
OUT ;Exit here
 K XQ I XQY>0,$D(^XUTL("XQO",XQDIC,"^",+XQY,0)) S XQ=+^(0) F XQI=1:1:XQ S XQ(XQI)=$P(^XUTL("XQO",XQDIC,"^",XQY,0,XQI),U)
 E  S XQ=0
 ;
 K %,I,J,X,XQ1,XQAP,XQCY,XQCY0,XQI,XQJ,XQJMP,XQK,XQO,XQO1,XQS,XQST,XQUD,XQXT,XQYY,Y
 Q
 ;
P ;Entry point for '"' jump to XUCOMMAND options
 I XQUR'?.ANP!(XQUR[U) W *7," ??" S XQY=-1 Q
 S XQO=XQUR I XQUR'?.PUN F XQI=1:1 Q:XQO?.NUP  S XQO1=$A(XQO,XQI) I XQO1<123,XQO1>96 S XQO=$E(XQO,1,XQI-1)_$C(XQO1-32)_$E(XQO,XQI+1,255)
 S XQUR=XQO,XQSV=XQY_U_XQDIC_U_XQY0
 S XQJ="",XQJMP=1,(XQ,XQ1,XQS,XQXT,XQY)=0
 S (XQO,XQO1)=$E(XQUR,1,$L(XQUR)-1)_$C($A($E(XQUR,$L(XQUR)))-1)_"z"
 S XQDIC="PXU" D X G:XQY<0 OUT G:XQUR="" W
 I XQXT K XQ S XQ=XQXT F XQI=1:1:XQ S XQ(XQI)=XQXT(XQI),%=+XQ(XQI),XQ("X",%)="" I $D(XQXT("S",%)) S XQ("S",%)=XQXT("S",%)
 I XQ=1,XQS=0 S %=XQ(1),XQY=+%,XQPSM=$P(%,U,3),XQDIC=$S($L(XQPSM,",")>1:$P(XQPSM,",",$L(XQPSM,",")),1:XQPSM),XQY0=$P(^XUTL("XQO",XQDIC,U,XQY),U,2,99) G OUT
 D:XQ>0 C G:XQY<0 OUT I XQ=0&('XQXT) S XQY=-1 G OUT
 G OUT
