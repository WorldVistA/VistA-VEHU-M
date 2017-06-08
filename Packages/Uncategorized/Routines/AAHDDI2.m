%AAHDDI2 ;402,DJB,11/2/91,EDD**Indiv Fld Sum
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
XREF ;
 S K=0 F  S K=$O(^DD(FILE(LEV),FNUM,1,K)) Q:K=""!(K'>0)!FLAGQ  S XREFNAM=$P(^DD(FILE(LEV),FNUM,1,K,0),U,2) S:XREFNAM="" XREFNAM="-----" S XREFTYPE=$P(^(0),U,3) S:XREFTYPE="" XREFTYPE="REGULAR" D XREF1
 Q
XREF1 ;
 W ! D:$Y>GEMSIZE PAGE^%AAHDDI3 Q:FLAGQ
 W !?M1,"CROSS REF NAME:",?M3,XREFNAM D:$Y>GEMSIZE PAGE^%AAHDDI3 Q:FLAGQ  W !?12,"TYPE:",?M3,XREFTYPE D:$Y>GEMSIZE PAGE^%AAHDDI3 Q:FLAGQ
 S L=0 F  S L=$O(^DD(FILE(LEV),FNUM,1,K,L)) Q:L=""!FLAGQ  D:L="%D" DESCRIP I $D(^(L))#2 W ! W:L'>0 ?M1,L W:L>0 ?6,"Node: ",L S STRING=^(L) D STRING^%AAHDDI3 Q:FLAGQ
 Q
DESCRIP ;
 W ! S M=0 F  S M=$O(^DD(FILE(LEV),FNUM,1,K,L,M)) Q:M=""!FLAGQ  W !,?M1 S STRING=^(M,0) D WORD^%AAHDDI3 Q:FLAGQ
 W ! Q
DTYPE1 ;Data types
 W !?M3,$S(ZDSUB["B":"True-False (""Boolean"")",ZDSUB["I":"Uneditable",ZDSUB["O":"Has output transform",ZDSUB["R":"Required field",ZDSUB["X":"Input Transform has been modified in Utility Option",1:"")
 Q
DTYPE2 ;Data types
 W !?M3,$S(ZDSUB["a":"Marked for auditing",ZDSUB["m":"Multilined",ZDSUB["*":"Field has a screen",ZDSUB["'":"LAYGO to ""pointed to"" file not allowed",1:"")
 Q
HELP ;Print HELP FRAME text (^DIC(9.2,)
 Q:FLAGP
 W ! D:$Y>GEMSIZE PAGE^%AAHDDI3 Q:FLAGQ
 W !?M1,"This field has a HELP FRAME." D:$Y>GEMSIZE PAGE^%AAHDDI3 Q:FLAGQ
 R !?M1,"Do you wish to see the HELP FRAME text?: [YES/NO] NO//",ANS:GEMTIME S:'$T ANS="N" S:ANS="" ANS="N" Q:"Yy"'[$E(ANS)
 S XQH=^DD(FILE(LEV),FNUM,22) D EN^XQH
 K ANS,XQH Q
