LEX2027 ;ISL/KER - Environment Check/Pre/Post Install ; 10/27/2003
 ;;2.0;LEXICON UTILITY;**27**;Sep 23, 1996
 ;
 ; External References
 ;   DBIA 10141  $$PATCH^XPDUTL
 ;   DBIA 10141  $$VERSION^XPDUTL
 ;   DBIA 10141  BMES^XPDUTL
 ;   DBIA 10141  MES^XPDUTL
 ;   DBIA 10015  EN^DIQ1
 ;                            
ENV ; LEX*2.0*27 Environment Check
 ;           
 ;   General
 ;
 N LEXBUILD,LEXIGHF,LEXLAST,LEXLREV,LEXG
 D IMP S U="^"
 ;     No user
 I '$$UR D ET("User not defined (DUZ)")
 ;     No IO
 D:'$$SY ET("Undefined IO variable(s)") I $D(LEXE) D ABRT Q
 ;                
 ;   Load Distribution
 ;
 ;     Not version 2.0
 I $$VERSION^XPDUTL("LEX")'="2.0" D  D ABRT Q
 . D ET("Version 2.0 not found.  Please install Lexicon Utility v 2.0")
 I $D(LEXE) D ABRT Q
 ;     Missing last data patch
 D:'$L($G(LEXLAST)) IMP I $L(LEXLAST) D
 . N LEXPN S LEXPN=$$PATCH^XPDUTL(LEXLAST)
 . I 'LEXPN D ET((LEXLAST_" not found, please install "_LEXLAST_" before continuing"))
 I $D(LEXE) D ABRT Q
 ;   Quit, Exit or Abort
QUIT ;     Quit   Passed Environment Check
 K LEXFULL D OK
 Q
EXIT ;     Exit   Failed Environment Check
 D:$D(LEXE) ED S XPDQUIT=2 K LEXE,LEXFULL Q
ABRT ;     Abort  Failed Environment Check, KILL the distribution
 D:$D(LEXE) ED S XPDABORT=1,XPDQUIT=1,XPDQUIT("LEX*2.0*27")=1
 K LEXE,LEXFULL
 Q
 ;               
 ; Checks
 ;
SY(X) ;   Check System variables
 Q:'$D(IO)!('$D(IOF))!('$D(IOM))!('$D(ION))!('$D(IOSL))!('$D(IOST)) 0
 Q 1
UR(X) ;   Check User variables
 Q:'$L($G(DUZ(0))) 0
 Q:+($G(DUZ))=0!($$NOTDEF(+$G(DUZ))) 0
 Q 1
 ;                       
 ; Error messages
 ;
ET(X) ;   Error Text
 N LEXI S LEXI=+($G(LEXE(0))),LEXI=LEXI+1,LEXE(LEXI)="    "_$G(X),LEXE(0)=LEXI
 Q
ED ;   Error Display
 N LEXI S LEXI=0 F  S LEXI=$O(LEXE(LEXI)) Q:+LEXI=0  D M(LEXE(LEXI))
 D M(" ") K LEXE Q
 ;                   
 ; Miscellaneous
 ;
IMP ;   Import names
 S LEXLREV=16,LEXLAST="LEX*2.0*26",LEXBUILD="LEX*2.0*27"
 S LEXIGHF="LEX_2_27.GBL"
 Q
NOTDEF(IEN) ;   Check to see if user is defined
 N DA,DR,DIQ,LEX,DIC S DA=IEN,DR=.01,DIC=200,DIQ="LEX" D EN^DIQ1 Q '$D(LEX)
OK ;   Environment is OK
 N LEXBUILD,LEXIGHF,LEXLAST,LEXLREV,LEXT
 D IMP S LEXT="  Environment "_$S($L(LEXBUILD):("for patch/build "_LEXBUILD_" "),1:"")_"is ok"
 D BM(LEXT),M(" ")
 Q
BM(X) ;   Blank Line with Message
 S X=" "_$G(X) Q:$D(LEXQT)  D:$D(XPDNM) BMES^XPDUTL($G(X)) W:'$D(XPDNM) !!,$G(X) Q
M(X) ;   Message
 S X=" "_$G(X) Q:$D(LEXQT)  D:$D(XPDNM) MES^XPDUTL($G(X)) W:'$D(XPDNM) !,$G(X) Q
