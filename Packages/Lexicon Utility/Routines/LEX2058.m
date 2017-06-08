LEX2058 ;ISL/FJF - Environment Check/Pre/Post Install ; 16 Sep 2011  11:44 AM
 ;;2.0;LEXICON UTILITY;**58**;Sep 23, 1996;Build 53
 ;                     
 ; External References
 ;   DBIA 10015  EN^DIQ1
 ;   DBIA 10141  $$PATCH^XPDUTL
 ;   DBIA 10141  $$VERSION^XPDUTL
 ;   DBIA 10141  BMES^XPDUTL
 ;   DBIA 10141  MES^XPDUTL
 ;                            
ENV ; LEX*2.0*58 Environment Check
 ;                    
 ;   General
 W !," Problem List Mapping Subset Update",!
 ;
 N LEXBUILD,LEXIGHF,LEXREQP,LEXLREV,LEXG,LEXE
 D IMP
 ;
 ;     No user
 D:+$$UR'>0 ET("User not defined (DUZ)")
 ;
 ;     No IO
 D:+$$SY'>0 ET("Undefined IO variable(s)")
 I $D(LEXE) D ABRT Q
 ;                    
 ;   Load Distribution
 ;
 ;     XPDENV = 0 Environment Check during Load
 ;
 ;       Check Version (2.0)
 I $$VERSION^XPDUTL("LEX")'="2.0" D  D ABRT Q
 .D ET("Version 2.0 not found.  Please install Lexicon Utility v 2.0")
 ;
 ;       Check Required Patches
 D:'$L($G(LEXREQP)) IMP
 I $L(LEXREQP) D
 .N LEXPAT,LEXI,LEXPN
 .F LEXI=1:1 Q:'$L($P(LEXREQP,";",LEXI))  D
 ..S LEXPAT=$P(LEXREQP,";",LEXI)
 ..S LEXPN=$$PATCH^XPDUTL(LEXPAT)
 ..W !,"   Checking for ",LEXPAT I +LEXPN>0 H 1 W " - installed"
 ..I +LEXPN'>0 D ET((LEXPAT_" not found, please install "_LEXPAT_" before continuing"))
 I $D(LEXE) D ABRT Q
 I '$D(LEXFULL)&(+($G(XPDENV))'=1) D QUIT Q
 ;                    
 ;   Install Package(s)
 ;
 ;     XPDENV = 1 Environment Check during Install
 ;
 ;       Check Data "is installed" or "is translated"
 D QUIT
 Q
 ;
QUIT ;     Quit -  Passed Environment Check
 K LEXFULL D OK
 Q
 ;
EXIT ;     Exit -  Failed Environment Check
 D:$D(LEXE) ED
 S XPDQUIT=2
 K LEXE,LEXFULL
 Q
 ;
ABRT ;     Abort - Failed Environment Check, KILL the distribution
 D:$D(LEXE) ED
 S XPDABORT=1,XPDQUIT=1,XPDQUIT("LEX*2.0*58")=1
 K LEXE,LEXFULL
 Q
 ;               
 ; Checks
 ;
SY() ;   Check System variables
 Q:'$D(IO)!('$D(IOF))!('$D(IOM))!('$D(ION))!('$D(IOSL))!('$D(IOST)) 0
 Q 1
 ;
UR() ;   Check User variables
 Q:'$L($G(DUZ(0))) 0
 Q:+$G(DUZ)=0!($$NOTDEF(+$G(DUZ))) 0
 Q 1
 ;            
 ; Error messages
 ; 
ET(X) ;   Error Text
 N LEXI
 S LEXI=+$G(LEXE(0)),LEXI=LEXI+1,LEXE(LEXI)="    "_$G(X),LEXE(0)=LEXI
 Q
ED ;   Error Display
 N LEXI S LEXI=0 F  S LEXI=$O(LEXE(LEXI)) Q:+LEXI=0  D M(LEXE(LEXI))
 D M(" ") K LEXE Q
 ;                   
 ; Miscellaneous
 ;
IMP ;   Import names
 S LEXLREV=58,LEXREQP="LEX*2.0*51",LEXBUILD="LEX*2.0*58"
 Q
 ;
NOTDEF(IEN) ;   Check to see if user is defined
 N DA,DR,DIQ,LEX,DIC
 S DA=IEN,DR=.01,DIC=200,DIQ="LEX"
 D EN^DIQ1
 Q '$D(LEX)
 ;
OK ;   Environment is OK
 N LEXBUILD,LEXIGHF,LEXREQP,LEXLREV,LEXT
 D IMP S LEXT="  Environment "_$S($L(LEXBUILD):("for patch/build "_LEXBUILD_" "),1:"")_"is ok"
 D BM(LEXT),M(" ")
 Q
 ;
BM(X) ;   Blank Line with Message
 D BMES^XPDUTL($G(X))
 Q
 ;
M(X) ;   Message
 D MES^XPDUTL($G(X))
 Q
 ;
TRIM(X) ;   Trim Spaces
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
