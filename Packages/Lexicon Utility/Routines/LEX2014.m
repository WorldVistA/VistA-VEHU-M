LEX2014 ; ISA/JPK-Environment Check/Pre/Post Install ; 07/28/1999
 ;;2.0;Lexicon Utility;**14**;Sep 23, 1996
 ;
ENV ; LEX*2.0*14 Environment Check
 ;           
 ;   General
 ;
 N LEXBUILD,LEXIGHF,LEXLAST,LEXLREV,LEXG D IMP S U="^"
 ;     No user
 I '$$UR D ET("User not defined (DUZ)")
 ;     No IO
 D:'$$SY ET("Undefined IO variable(s)") G:$D(LEXE) EXIT
 ;                
 ;   Load Distribution
 ;
 ;     Not version 2.0
 I $$VERSION^XPDUTL("LEX")'="2.0" D ET("Version 2.0 not found.  Please install Lexicon Utility v 2.0") G ABRT
 G:$D(LEXE) ABRT
 ;     Missing last data patch
 D:'$L($G(LEXLAST)) IMP I $L(LEXLAST) D
 . N LEXPN S LEXPN=$$PATCH^XPDUTL(LEXLAST)
 . I 'LEXPN D ET((LEXLAST_" not found, please install "_LEXLAST_" before continuing"))
 G:$D(LEXE) ABRT
 ;I +($G(XPDENV))'=1
 S LEXG=$$RGBL G:$D(LEXE)&(+LEXG=0) EXIT G:$D(LEXE)&(+LEXG<0) ABRT
 G:'$D(LEXFULL)&(+($G(XPDENV))'=1) QUIT
 ;                
 ;   Install Package(s)
 ;
 ;     Check Data "is installed" or "is translated"
 N LEXIT S LEXIT=+($$CPD) G:'$D(LEXFULL)&(LEXIT) QUIT
 ;     Checking Global "Write" Protection during install
 D:+($G(XPDENV))=1 GBLS G:$D(LEXE) EXIT
 ;     Import Global Checksum during install
 D:+($G(XPDENV))=1 CS G:$D(LEXE) EXIT
 ;                
 ;   Quit, Exit or Abort
 ;
QUIT ;     Quit   Passed Environment Check
 K LEXFULL W !!,"  Environment is ok",!
 Q
EXIT ;     Exit   Failed Environment Check
 D:$D(LEXE) ED S XPDQUIT=2 K LEXE,LEXFULL Q
ABRT ;     Abort  Failed Environment Check, KILL the distribution
 D:$D(LEXE) ED S XPDQUIT=1 K LEXE,LEXFULL Q
 ;               
 ; Checks
 ;
GBLS ;   Check Write access on globals
 N LEXOK S LEXOK=1 W !!,"I will now check the protection on ^LEX, ^LEXT and ^LEXM Globals.  If you"
 W !,"get an ERROR, you will need to change the protection on these globals to"
 W !,"allow read/write as indicated for the appropriate M system:"
 W !!,"    SYSTEM   PROTECTION   FOR FILE ACCESS ATTRIBUTES"
 W !,"    ------   ----------   ----------------------------"
 W !,"    DSM          RW       System   World  Group  UCI"
 W !,"    Open M       RW       Network                Owner    (default)"
 W !!,"Checking:" N LEXGL
 F LEXGL="^LEX(757,0)","^LEXT(757.2,0)","^LEXM(0)" D  Q:'LEXOK
 . I '$D(@LEXGL) D RGNF S LEXOK=0 W "      <",$P(LEXGL,"(",1)," not found>" Q
 . W "      ",$P(LEXGL,"(",1) S @LEXGL=$G(@LEXGL) H 1
 W:LEXOK "    --> ok",! W:'LEXOK "    ??",!
 Q
RGBL(X) ; Look for require globals
 N LEXGL,LEX0,LEXS S LEXS="",X=1 F LEXGL="^LEX(757,0)","^LEXT(757.2,0)","^LEXM(0)" D
 . I '$D(@LEXGL) S:LEXS'[$P(LEXGL,"(",1) LEXS=LEXS_", "_$P(LEXGL,"(",1) S:LEXGL["X("!((LEXGL["T(")) X=-1 S:LEXGL["M("&(X=1) X=0
 . S LEX0=$G(@LEXGL) I $L(LEX0,"^")'=4 S:LEXS'[$P(LEXGL,"(",1) LEXS=LEXS_", "_$P(LEXGL,"(",1) S:LEXGL["X("!((LEXGL["T(")) X=-1 S:LEXGL["M("&(X=1) X=0
 I $L(LEXS),X'>0 D
 . S:LEXS[", " LEXS=$P(LEXS,", ",1,($L(LEXS,", ")-1))_" and "_$P(LEXS,", ",$L(LEXS,", ")) S:$E(LEXS,1,2)=", " LEXS=$E(LEXS,3,$L(LEXS)) S:$E(LEXS,1,7)[" and " LEXS=$P(LEXS," and ",2)
 . I X=-1 D
 . . D IMP N LEXLN S LEXLN=+($P($G(LEXLAST),"*",3)) D ET(("Lexicon v2.0 global"_$S(LEXS[", "!(LEXS[" and "):"s",1:"")_" "_LEXS_" either not found or incomplete."))
 . . D:LEXLN>1 ET(""),ET(("    Please re-install the Lexicon Utility v 2.0 with patches 1-"_LEXLN_"."))
 . D:X=0 CM
 Q X
RGNF ; Required global not found
 N LEXBUILD,LEXIGHF D IMP
 D:$G(LEXGL)["^LEX"&($G(LEXGL)'["^LEXM") ET(""),ET("Required global "_$P($G(LEXGL),"(",1)_" not found.")
 D:$G(LEXGL)["^LEX"&($G(LEXGL)["^LEXM") CM
 Q
CHK D CS I $D(LEXE) D ED Q
 W !!,"  OK",!
 Q
CS ;   Checksum for import global
 K LEXE W !!,"Running checksum routine on the ^LEXM import global, please wait" N LEXCHK,LEXNDS,LEXVER S LEXCHK=+($G(^LEXM(0,"CHECKSUM"))),LEXNDS=+($G(^LEXM(0,"NODES"))),LEXVER=+($$VC(LEXCHK,LEXNDS))
 W ! W:LEXVER>0 "  ok",! D:LEXVER=0 CM D:LEXVER=-1 CW D:LEXVER=-2 CU D:LEXVER=-3 CF
 Q
VC(X,Y) ;   Verify Checksum for import global
 Q:'$D(^LEXM) 0 D IMP I $G(^LEXM(0,"BUILD"))'=$G(LEXBUILD) Q -1
 N LEXCHK,LEXNDS,LEXCNT,LEXLC,LEXL,LEXS,LEXNC,LEXD,LEXN,LEXC,LEXGCS,LEXP,LEXT S LEXCHK=+($G(X)),LEXNDS=+($G(Y)) Q:LEXCHK'>0!(LEXNDS'>0) -2
 S LEXL=68,(LEXCNT,LEXLC)=0,LEXS=+(LEXNDS\LEXL) S:LEXS=0 LEXS=1 W:+($O(^LEXM(0)))>0 ! S (LEXC,LEXN)="^LEXM",(LEXNC,LEXGCS)=0
 F  S LEXN=$Q(@LEXN) Q:LEXN=""!(LEXN'[LEXC)  D
 . Q:LEXN="^LEXM(0,""CHECKSUM"")"  Q:LEXN="^LEXM(0,""NODES"")"  S LEXCNT=LEXCNT+1
 . I LEXCNT'<LEXS S LEXLC=LEXLC+1 W:LEXLC'>LEXL "." S LEXCNT=0
 . S LEXNC=LEXNC+1,LEXD=@LEXN,LEXT=LEXN_"="_LEXD F LEXP=1:1:$L(LEXT) S LEXGCS=$A(LEXT,LEXP)*LEXP+LEXGCS
 Q:LEXNC'=LEXNDS -3 Q:LEXGCS'=LEXCHK -3 Q 1
SY(X) ;   Check System variables
 Q:'$D(IO)!('$D(IOF))!('$D(IOM))!('$D(ION))!('$D(IOSL))!('$D(IOST)) 0 Q 1
UR(X) ;   Check User variables
 Q:'$L($G(DUZ(0))) 0 Q:+($G(DUZ))=0!($$NOTDEF(+$G(DUZ))) 0 Q 1
CPD(X) ;   Check Current Patched Data is installed
 Q:$D(^LEX(757.21,"C","NEED FOR ISOLATION",186))&('$D(^LEX(757.21,"C","VACCIN FOR MEASLES",1609))) 1 Q 0
 E  Q 0
LPD(X) ;   Check Last Patched Data is installed
 Q:$D(^LEX(757.21,"C","VISCERAL LEISHMANIASIS (KALA-AZAR)",4038))&('$D(^LEX(757.21,"C","RESPIRATORY SYNCYTIAL VIRUS PNEUMONIA",6744))) 1 Q 0
 Q
 ;                   
 ; Error messages
 ;
CM ;   Missing ^LEXM
 N LEXBUILD,LEXIGHF D IMP D ET(""),ET("Missing import global ^LEXM."),CO Q
CW ;   Wrong ^LEXM
 N LEXBUILD,LEXIGHF,LEXB D IMP S LEXB=$G(^LEXM(0,"BUILD"))
 D ET("") I $L(LEXBUILD),$L(LEXB),LEXBUILD'=LEXB D ET(("Incorrect import global ^LEXM found ("_LEXB_" global).")),CKO Q
 D ET("Incorrect import global ^LEXM found."),CKO Q
CU ;   Unable to verify
 N LEXBUILD,LEXIGHF D IMP D ET(""),ET("Unable to verify checksum for import global ^LEXM (possibly corrupt)."),CKO Q
CF ;   Failed checksum
 N LEXBUILD,LEXIGHF D IMP D ET(""),ET("Import global ^LEXM failed checksum."),CKO Q
CO ;   Obtain new global
 D ET(""),ET("    Please obtain a copy of the import global ^LEXM contained in the "),ET(("    global host file "_LEXIGHF_" before continuing with the "_LEXBUILD)),ET(("    installation.")) Q
CKO ;   Kill and Obtain new global
 D ET(""),ET("    Please KILL the existing import global ^LEXM from your system"),ET(("    and obtain a new copy of ^LEXM contained in the global host file")),ET(("    "_LEXIGHF_" before continuing with the "_LEXBUILD_" installation.")) Q
ET(X) ;   Error Text
 N LEXI S LEXI=+($G(LEXE(0))),LEXI=LEXI+1,LEXE(LEXI)="    "_$G(X),LEXE(0)=LEXI Q
ED ;   Error Display
 N LEXI S LEXI=0 F  S LEXI=$O(LEXE(LEXI)) Q:+LEXI=0  W !,LEXE(LEXI)
 W ! K LEXE Q
 ;                   
 ; Miscellaneous
 ;
IMP ;   Import names
 ;
 S LEXLREV=7,LEXLAST="LEX*2.0*13",LEXBUILD="LEX*2.0*14"
 S LEXIGHF="LEX_2_P14.GBL"
 Q
NOTDEF(IEN) ; check to see if user is defined
 N DA,DR,DIQ,LEX,DIC
 S DA=IEN
 S DR=.01
 S DIC=200
 S DIQ="LEX"
 D EN^DIQ1
 Q '$D(LEX)
