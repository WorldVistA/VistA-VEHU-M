%AAHDDM ;402,DJB,11/2/91,EDD**Menu Driver
 ;;GEM III;;
 ;;David Bolduc - Togus ME
EN ;Entry Point
 NEW I,X,Y,ZHDR D HD
 I FLAGP F I=1,7,13,2,8,14,3,9,15,4,10,5,11,6,12 S X=$T(OPT+I) Q:X=""  W @$S(I<7:"!",I<13:"?26",1:"?56"),$S(I=5:"*",I=9:"*",I=13:"*",I=14:"*",1:" "),$J(I,2)_") ",$P(X,";",3)
 E  F I=1,7,13,2,8,14,3,9,15,4,10,5,11,6,12 S X=$T(OPT+I) Q:X=""  W @$S(I<7:"!",I<13:"?26",1:"?56")," ",$J(I,2)_") ",$P(X,";",3)
 W !
B ;
 R !?2,"Select OPTION: ",O:GEMTIME S:'$T O="^^" I "^"[O S FLAGM=1 G EX
 I O="^^" S FLAGE=1 G EX
 I O?1.N,O>0,O<16,$T(OPT+O)'="" G C
 I O'?1.N D ALLCAPS F I=1:1 S X=$P($T(OPT+I),";",5) Q:X=""  I $E(X,1,$L(O))=O W $E(X,$L(O)+1,80) S O=I G C
 W:O'["?" *7 W "   Enter Option number or name." G B
C ;
 S X=$T(OPT+O) D @$P(X,";",4) I FLAGG S FLAGG=0 G B ;FLAGG indicates no Groups or no Pointers.
EX ;
 Q
ALLCAPS ;
 F %=1:1:$L(O) S:$E(O,%)?1L O=$E(O,0,%-1)_$C($A(O,%)-32)_$E(O,%+1,999)
 Q
HD ;
 S ZHDR="M A I N   M E N U" W !?(GEMIOM-$L(ZHDR)\2),ZHDR W:FLAGP ?57,"[*=Opts not printable]"
 W !
 Q
OPT ;MENU OPTIONS
 ;;Cross References;XREF^%AAHDDU;CROSS REFERENCES
 ;;Pointers IN;PTI^%AAHDDPT;POINTERS IN
 ;;Pointers OUT;PTO^%AAHDDPT;POINTERS OUT
 ;;Groups;GRP^%AAHDDU;GROUPS
 ;;Trace a Field;EN^%AAHDDT;TRACE A FIELD
 ;;Indiv Fld Summary;^%AAHDDI;INDIV FLD SUMMARY
 ;;Fld Global Location;EN^%AAHDDL;FLD GLOBAL LOCATION
 ;;Templates;EN^%AAHDDU1;TEMPLATES
 ;;File Description;DES^%AAHDDU1;FILE DESCRIPTION
 ;;Globals In ASCII Order;GL^%AAHDDG;GLOBALS IN ASCII ORDER
 ;;File Characteristics;CHAR^%AAHDDC;FILE CHARACTERISTICS
 ;;Required Fields;REQ^%AAHDDU;REQUIRED FIELDS
 ;;Acme Global Lister;AGL1^%AAHDDZ;ACME GLOBAL LISTER
 ;;Printing-On/Off;PRINTM^%AAHDDPR;PRINTING-ON/OFF
 ;;Help;^%AAHDDH1;HELP
