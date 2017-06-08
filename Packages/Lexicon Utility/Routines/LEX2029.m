LEX2029 ;ISL/KER - Environment Check/Pre/Post Install ; 04/07/2004
 ;;2.0;LEXICON UTILITY;**29**;Sep 23, 1996
 ;
 ; External References
 ;   DBIA 10141  $$PATCH^XPDUTL
 ;   DBIA 10141  $$VERSION^XPDUTL
 ;   DBIA 10141  BMES^XPDUTL
 ;   DBIA 10141  MES^XPDUTL
 ;   DBIA 10015  EN^DIQ1
 ;                            
ENV ; LEX*2.0*29 Environment Check
 ;           
 ;   General
 ;
 N LEXBUILD,LEXIGHF,LEXREQP,LEXG,LEXE
 D IMP S U="^"
 ;     No user
 I '$$UR D ET("User not defined (DUZ)")
 ;     No IO
 D:'$$SY ET("Undefined IO variable(s)") I $D(LEXE) D ABRT Q
 ;                
 ;   Load Distribution
 ;
 ;     XPDENV = 0 Environment Check during Load
 ;
 ;       Check Version (2.0)
 I $$VERSION^XPDUTL("LEX")'="2.0" D  D ABRT Q
 . D ET("Version 2.0 not found.  Please install Lexicon Utility v 2.0")
 I $D(LEXE) D ABRT Q
 ;       Check Required Patches
 D:'$L($G(LEXREQP)) IMP I $L(LEXREQP) D
 . N LEXPAT,LEXI,LEXPN
 . F LEXI=1:1 Q:'$L($P(LEXREQP,";",LEXI))  S LEXPAT=$P(LEXREQP,";",LEXI) D
 . . S LEXPN=$$PATCH^XPDUTL(LEXPAT)
 . . I +LEXPN'>0 D ET((LEXPAT_" not found, please install "_LEXPAT_" before continuing"))
 I $D(LEXE) D ABRT Q
 S LEXG=$$RGBL
 I $D(LEXE)&(+LEXG=0) D ABRT Q
 I $D(LEXE)&(+LEXG<0) D ABRT Q
 ;
 I '$D(LEXFULL)&(+($G(XPDENV))'=1) D QUIT Q
 ;                
 ;   Install Package(s)
 ;
 ;     XPDENV = 1 Environment Check during Install
 ;
 ;       Check Data "is installed" or "is translated"
 N LEXIT S LEXIT=+($$CPD) I '$D(LEXFULL)&(LEXIT) D QUIT Q
 ;       Checking Global "Write" Protection 
 D:+($G(XPDENV))=1 GBLS I $D(LEXE) D ABRT Q
 ;       Check Import Global Checksum 
 D:+($G(XPDENV))=1 CS I $D(LEXE) D ABRT Q
 ;                
 ;   Quit, Exit or Abort
 ;
QUIT ;     Quit   Passed Environment Check
 K LEXFULL D OK
 Q
EXIT ;     Exit   Failed Environment Check
 D:$D(LEXE) ED S XPDQUIT=2 K LEXE,LEXFULL Q
ABRT ;     Abort  Failed Environment Check, KILL the distribution
 D:$D(LEXE) ED S XPDABORT=1,XPDQUIT=1,XPDQUIT("LEX*2.0*29")=1
 K LEXE,LEXFULL
 Q
 ;               
 ; Checks
 ;
GBLS ;   Check Write access on globals
 N LEXOK,LEXGL,LEXRT,LEXCPD S LEXOK=1
 D BM("I will now check the protection on ^LEX, ^LEXT, ^LEXC and ^LEXM Globals.")
 D M("If you get an ERROR, you will need to change the protection on these")
 D M("globals to allow read/write as indicated for the appropriate M system:")
 D BM("                      System    World    Group    UCI")
 D M("    DSM for OpenVMS    RWP       RW       RW      RW")
 D BM("                      System    World    Group    User")
 D M("    MSM-DOS            RWD       RWD      RWD     RWD")
 D BM("                      Owner     Group    World   Network")
 D M("    Cache systems      RWD       RW       RW      RWD")
 D BM("Checking:")
 F LEXGL="^ICD9(0)","^ICD0(0)","^ICPT(0)","^DIC(81.2,0)","^DIC(81.3,0)","^LEXM(0)","^LEX(757,0)" D  Q:'LEXOK
 . S LEXRT=$P(LEXGL,"(",1) S:LEXGL["81.2" LEXRT="^DIC(81.2)" S:LEXGL["81.3" LEXRT="^DIC(81.3)"
 . S:LEXRT["LEXT" LEXRT="^LEXT(757.2)"
 . S:"^^LEX^^LEXC^^LEXM^^"[("^"_LEXRT_"^") LEXRT=LEXRT_"(*"
 . S:"^^ICD9^^ICD0^^ICPT^^"[("^"_LEXRT_"^") LEXRT=LEXRT_"("
 . I '$D(@LEXGL) D RGNF S LEXOK=0 D  Q
 . . D M(("    <"_LEXRT_" not found>"))
 . D M(("    "_LEXRT)) S @LEXGL=$G(@LEXGL) H 1
 D:LEXOK M("    --> ok") D:'LEXOK M("    ??") D M(" ")
 Q
RGBL(X) ;   Look for required globals
 N LEXREQP,LEXBUILD,LEXIGHF,LEXGL,LEX0,LEXS S LEXS="",X=1
 F LEXGL="^ICD9(0)","^ICD0(0)","^ICPT(0)","^DIC(81.2,0)","^DIC(81.3,0)","^LEXM(0)","^LEX(757,0)" D
 . Q:+($$CPD)>0&(LEXGL["LEXM")
 . N LEXRT S LEXRT=$P(LEXGL,"(",1)
 . S:LEXRT["DIC" LEXRT="^DIC(81.3)"
 . S:LEXRT["LEXT" LEXRT="^LEXT(757.2)"
 . S:"^^LEX^^LEXC^^LEXM^^"[("^"_LEXRT_"^") LEXRT=LEXRT_"(*" S:"^^ICD9^^ICD0^^ICPT^^"[("^"_LEXRT_"^") LEXRT=LEXRT_"("
 . I '$D(@LEXGL) D
 . . S:LEXS'[LEXRT LEXS=LEXS_", "_LEXRT
 . . S X=-1 S:LEXGL["LEXM("&(X=1) X=0
 . I LEXGL'["^LEXC" S LEX0=$G(@LEXGL) I $L(LEX0,"^")'=4 D
 . . S:LEXS'[LEXRT LEXS=LEXS_", "_LEXRT
 . . S:LEXGL["X("!((LEXGL["T(")) X=-1 S:LEXGL["M("&(X=1) X=0
 I $L(LEXS),X'>0 D
 . S:LEXS[", " LEXS=$P(LEXS,", ",1,($L(LEXS,", ")-1))_" and "_$P(LEXS,", ",$L(LEXS,", "))
 . S:$E(LEXS,1,2)=", " LEXS=$E(LEXS,3,$L(LEXS))
 . S:$E(LEXS,1,7)[" and " LEXS=$P(LEXS," and ",2)
 . I X=-1,LEXS="^LEXC(*" D  Q
 . . D ET("Global ^LEXC not found, please create this global and set protection")
 . D:X=-1 ET(("Global"_$S(LEXS[", "!(LEXS[" and "):"s",1:"")_" "_LEXS_" either not found or incomplete."))
 . D:X=0 CM
 Q X
RGNF ;   Required global not found
 N LEXREQP,LEXBUILD,LEXIGHF D IMP
 D:$G(LEXGL)["^LEX"&($G(LEXGL)'["^LEXM") ET(""),ET("Required global "_$P($G(LEXGL),"(",1)_" not found.")
 D:$G(LEXGL)["^LEX"&($G(LEXGL)["^LEXM") CM
 Q
CHK ;   Check the Checksum
 D CS I $D(LEXE) D ED Q
 D BM("  OK"),M(" ")
 Q
CS ;   Checksum for import global
 K LEXE
 D BM("Running checksum routine on the ^LEXM import global, please wait")
 N LEXCHK,LEXNDS,LEXVER S LEXCHK=+($G(^LEXM(0,"CHECKSUM")))
 S LEXNDS=+($G(^LEXM(0,"NODES"))),LEXVER=+($$VC(LEXCHK,LEXNDS))
 D M(" ") D:LEXVER>0 M("  ok"),M(" ")
 D:LEXVER=0 CM D:LEXVER=-1 CW D:LEXVER=-2 CU D:LEXVER=-3 CF
 Q
VC(X,Y) ;   Verify Checksum for import global
 N LEXREQP,LEXBUILD,LEXIGHF Q:'$D(^LEXM) 0
 D IMP I $G(^LEXM(0,"BUILD"))'=$G(LEXBUILD) Q -1
 N LEXCHK,LEXNDS,LEXCNT,LEXLC,LEXL,LEXS,LEXNC,LEXD,LEXN,LEXC,LEXGCS,LEXP,LEXT
 S LEXCHK=+($G(X)),LEXNDS=+($G(Y))
 Q:LEXCHK'>0!(LEXNDS'>0) -2
 S LEXL=68,(LEXCNT,LEXLC)=0,LEXS=+(LEXNDS\LEXL)
 S:LEXS=0 LEXS=1 D:+($O(^LEXM(0)))>0 M("")
 S (LEXC,LEXN)="^LEXM",(LEXNC,LEXGCS)=0
 F  S LEXN=$Q(@LEXN) Q:LEXN=""!(LEXN'[LEXC)  D
 . Q:LEXN="^LEXM(0,""CHECKSUM"")"
 . Q:LEXN="^LEXM(0,""NODES"")"
 . S LEXCNT=LEXCNT+1
 . I LEXCNT'<LEXS S LEXLC=LEXLC+1 W:LEXLC'>LEXL "." S LEXCNT=0
 . S LEXNC=LEXNC+1,LEXD=@LEXN,LEXT=LEXN_"="_LEXD
 . F LEXP=1:1:$L(LEXT) S LEXGCS=$A(LEXT,LEXP)*LEXP+LEXGCS
 Q:LEXNC'=LEXNDS -3
 Q:LEXGCS'=LEXCHK -3
 Q 1
SY(X) ;   Check System variables
 Q:'$D(IO)!('$D(IOF))!('$D(IOM))!('$D(ION))!('$D(IOSL))!('$D(IOST)) 0
 Q 1
UR(X) ;   Check User variables
 Q:'$L($G(DUZ(0))) 0
 Q:+($G(DUZ))=0!($$NOTDEF(+$G(DUZ))) 0
 Q 1
CPD(X) ;   Check Current Patched Data is installed
 N INS S INS=1
 ;     NOIS AUG-0204-32253 and ASH-0204-31578
 I $P($G(^DIC(81.2,1,0)),"^",2)'=3040101 S INS=0
 ;          BIL-1203-30691
 I $P($G(^LEX(757.02,316535,0)),"^",2)'=781.2 S INS=0
 ;          LEX-0204-41676
 I $G(^LEX(757.01,88213,5,1,0))'="HYPOGONADISM" S INS=0
 ;          SAG-1103-40488
 I $G(^LEX(757.01,330833,5,1,0))'="HYPERTENSION" S INS=0
 ;          SAG-1203-41852
 I $G(^LEX(757.02,326755,0))'="330823^E915.^1^181429^1^^1" S INS=0
 ;          PHO-0104-60329
 ;     E3R  18827
 I '$D(^LEX(757.02,"B",186838,326754)) S INS=0
 ;   
 S X=INS Q X
LPD(X) ;   Check Last Patched Data
 N INS S INS=1 S:'$D(^LEX(757.1,"B",181426,258593)) INS=0 S:'$D(^ICPT("F","V2797",107622)) INS=0 S:'$D(^DIC(81.3,"C","TWO PATIENTS SERVED",489)) INS=0 S X=+($G(INS))
 Q X
 ;                    
 ; Error messages
 ;
CM ;   Missing ^LEXM
 D ET(""),ET("Missing import global ^LEXM.") D CO
 Q
CW ;   Wrong ^LEXM
 N LEXREQP,LEXBUILD,LEXIGHF,LEXB D IMP
 S LEXB=$G(^LEXM(0,"BUILD")) D ET("")
 I $L(LEXBUILD),$L(LEXB),LEXBUILD'=LEXB D  Q
 . D ET(("Incorrect import global ^LEXM found ("_LEXB_" global)."))
 . D CKO
 D ET("Incorrect import global ^LEXM found.") D CKO
 Q
CU ;   Unable to verify
 D ET(""),ET("Unable to verify checksum for import global ^LEXM (possibly corrupt).") D CKO
 Q
CF ;   Failed checksum
 D ET("Import global ^LEXM failed checksum.") D CKO
 Q
CO ;   Obtain new global
 N LEXREQP,LEXBUILD,LEXIGHF D IMP
 D ET(""),ET("    Please obtain a copy of the import global ^LEXM contained in the ")
 D ET(("    global host file "_LEXIGHF_" before continuing with the "_LEXBUILD))
 D ET(("    installation."))
 Q
CKO ;   Kill and Obtain new global
 N LEXREQP,LEXBUILD,LEXIGHF D IMP
 D ET(""),ET("    Please KILL the existing import global ^LEXM from your system")
 D ET(("    and obtain a new copy of ^LEXM contained in the global host file"))
 D ET(("    "_LEXIGHF_" before continuing with the "_LEXBUILD_" installation."))
 Q
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
 S LEXREQP="LEX*2.0*28",LEXBUILD="LEX*2.0*29",LEXIGHF="LEX_2_29.GBL"
 Q
NOTDEF(IEN) ;   Check to see if user is defined
 N DA,DR,DIQ,LEX,DIC S DA=IEN,DR=.01,DIC=200,DIQ="LEX" D EN^DIQ1 Q '$D(LEX)
OK ;   Environment is OK
 N LEXBUILD,LEXIGHF,LEXREQP,LEXT
 D IMP S LEXT="  Environment "_$S($L(LEXBUILD):("for patch/build "_LEXBUILD_" "),1:"")_"is ok"
 D BM(LEXT),M(" ")
 Q
BM(X) ;   Blank Line with Message
 S X=" "_$G(X) Q:$D(LEXQT)  D:$D(XPDNM) BMES^XPDUTL($G(X)) W:'$D(XPDNM) !!,$G(X) Q
M(X) ;   Message
 S X=" "_$G(X) Q:$D(LEXQT)  D:$D(XPDNM) MES^XPDUTL($G(X)) W:'$D(XPDNM) !,$G(X) Q
