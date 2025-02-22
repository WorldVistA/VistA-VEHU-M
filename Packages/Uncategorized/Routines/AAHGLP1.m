%AAHGLP1 ;402,DJB,3/31/92**Print PIECE Data Dictionary
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
 NEW NODE,I,J,K,L,LINE,NODE,STRING,XREFNAM,XREFTYPE,Z1,ZA,ZB,ZD
 W @GEMIOF
 I FLAGXREF W !?(GEMIOM-32\2),"*** You selected a Xref node ***"
 I FLAGWP W !?(GEMIOM-43\2),"*** You selected a Word Processing node ***"
 W !,$E(GEMLINE1,1,GEMIOM)
 F I=0,.1,2,3,4,7.5,12,12.1 S:$D(^DD(FILE(LEV),FNUM,I)) NODE(I)=^(I)
 W !?M1,"FIELD NAME:",?M3,FNAM
 W !!?M1,"FLD NUMBER:",?M3,FNUM,?36,"FLD TITLE:  " W:$D(NODE(.1)) NODE(.1)
 W !?M1,"NODE;PIECE:",?M3,$S($P(NODE(0),U,4)=" ; ":"Computed",1:$P(NODE(0),U,4))
 W ?35,"HELP FRAME:  " W:$D(^DD(FILE(LEV),FNUM,22)) ^(22)
 W !!?M1,"    ACCESS:",?M3,"RD: ",$S($D(^DD(FILE(LEV),FNUM,8)):^(8),1:""),"   ","DEL: ",$S($D(^(8.5)):^(8.5),1:""),"   ","WR: ",$S($D(^(9)):^(9),1:"")
DATATYPE S ZD=$P(NODE(0),U,2) W !!?M1," DATA TYPE:" 
 W ?M3,$S(ZD["C":"Computed",ZD["D":"Date/Time",ZD["F":"Free Text",ZD["N":"Numeric",ZD["P":"Pointer",ZD["S":"Set of Codes",ZD["W":"Word Processing",ZD["V":"Variable Pointer",ZD["K":"MUMPS code",1:"*****")
 F I=1:1:$L(ZD) S ZDSUB=$E(ZD,I) D:"BIORX"[ZDSUB DTYPE1^%AAHGLP3 D:"am*'"[ZDSUB DTYPE2^%AAHGLP3
 I ZD["S" F I=1:1:$L($P(NODE(0),U,3),";")-1 W !?M4,$P($P(NODE(0),U,3),";",I)
 I ZD["P" S ZA="^"_$P(NODE(0),U,3) W !!?M1,"POINTS TO:",?M3 S ZB=ZA_"0)" W:$D(@ZB) $P(@ZB,U),"  file  -  ",ZA W:'$D(@ZB) ZB," - Global doesn't exist."
 I ZD["V"&($D(^DD(FILE(LEV),FNUM,"V",0))) W !!?M1,"POINTS TO:"
 I  S I=0 F  S I=$O(^DD(FILE(LEV),FNUM,"V",I)) Q:I'>0  S ZDATA1=^DD(FILE(LEV),FNUM,"V",I,0) W ?M3,$P(ZDATA1,U),?M5,$P(ZDATA1,U,2) W:$O(^DD(FILE(LEV),FNUM,"V",I))>0 !
 I $P(NODE(0),U,5)]"" W !!?M1,$S(ZD["C":"CODE CREATING X:",1:"INPUT TRANSFORM:") S STRING=$P(NODE(0),U,5,99) D STRING^%AAHGLP3 G:FLAGQ EX
 I $D(NODE(2)) W !!?M1,"OUTPUT TRANSFORM:" S STRING=NODE(2) D STRING^%AAHGLP3 G:FLAGQ EX
 I $D(^DD(FILE(LEV),FNUM,"DEL")) W !!?M1,"DELETE NODE(S):",?M3,"If $T is set to 1, no deleting." D
 .S I="" F  S I=$O(^DD(FILE(LEV),FNUM,"DEL",I)) Q:I=""  W !?6,"Node: ",I S STRING=^DD(FILE(LEV),FNUM,"DEL",I,0) D STRING^%AAHGLP3 Q:FLAGQ
 G:FLAGQ EX
 I $D(^DD(FILE(LEV),0,"ID",FNUM)) W !!?M1,"IDENTIFIER:" S STRING=^DD(FILE(LEV),0,"ID",FNUM) D STRING^%AAHGLP3 G:FLAGQ EX
 I $G(NODE(3))]"" W !!?M1,"PROMPT MESSAGE:" S STRING=NODE(3) D WORD^%AAHGLP3 G:FLAGQ EX
 I $G(NODE(4))]"" W !!?M1,"EXECUTABLE HELP:" S STRING=NODE(4) D STRING^%AAHGLP3 G:FLAGQ EX
 I $G(NODE(7.5))]"" W !!?M1,"PRE-LOOKUP TRANS:" S STRING=NODE(7.5) D STRING^%AAHGLP3 G:FLAGQ EX
 I $D(NODE(12)) W !!?M1,"SCREEN: " S STRING=NODE(12) D STRING^%AAHGLP3 G:FLAGQ EX
 I $D(NODE(12.1)) W !?M1,"SCREEN CODE:" S STRING=NODE(12.1) D STRING^%AAHGLP3 G:FLAGQ EX
 I $D(^DD(FILE(LEV),FNUM,1)) D XREF^%AAHGLP2 G:FLAGQ EX
 I $D(^DD(FILE(LEV),FNUM,21)) W ! D:$Y>GEMSIZE PAGE^%AAHGLP3 G:FLAGQ EX
 I  W !?M1,"DESCRIPTION:" S I=0 F  S I=$O(^DD(FILE(LEV),FNUM,21,I)) Q:I=""!FLAGQ  S STRING=^(I,0) D WORD^%AAHGLP3 W !
 G:FLAGQ EX
 I $D(^DD(FILE(LEV),FNUM,22)),^(22)]"" D HELP^%AAHGLP2 G:FLAGQ EX
EX ;
 Q:FLAGQ
 I $Y'>GEMSIZE F I=$Y:1:GEMSIZE W !
 W !,$E(GEMLINE1,1,GEMIOM)
 Q
