ICD1867 ;ISL/KER - ICD*18.0*67 Env Check ;12/19/2014
 ;;18.0;DRG Grouper;**67**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^ICDM               N/A
 ;               
 ; External References
 ;    FIND^DIC            ICR   2051
 ;    $$IENS^DILF         ICR   2054
 ;    EN^DIQ1             ICR  10015
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$PATCH^XPDUTL      ICR  10141
 ;    $$VERSION^XPDUTL    ICR  10141
 ;    BMES^XPDUTL         ICR  10141
 ;    MES^XPDUTL          ICR  10141
 ;               
 ; Local Variables Killed by Kernel after Install
 ;     XPDABORT,XPDDIQ,XPDQUIT
 ;     
 ; see Kernel Developer Guide
 ;     Chapter 14, KIDS Developer Tools
 ;     Advanced Build Techniques
 ;               
ENV ; Environment Check
 ;                    
 ;   General
 ;
 N ICDPTYPE,ICDLREV,ICDREQP,ICDBUILD,ICDIGHF,ICDFY,ICDQTR,ICDG,ICDE,ICDSTR D IMP
 K XPDDIQ("XPZ1","B"),XPDDIQ("XPI1","B") S XPDDIQ("XPZ1","B")="NO",XPDDIQ("XPI1","B")="NO"
 S ICDSTR=$G(ICDPTYPE) S:$L($G(ICDFY))&($L($G(ICDQTR))) ICDSTR=ICDSTR_" for "_$G(ICDFY)_" "_$G(ICDQTR)_" Quarter"
 D M(ICDSTR),M("")
 S U="^"
 ;     No user
 D:+($$UR)'>0 ET("User not defined (DUZ)")
 ;     No IO
 D:+($$SY)'>0 ET("Undefined IO variable(s)")
 I $D(ICDE) D ABRT Q
 ;                    
 ;   Load Distribution
 ;
 ;     XPDENV = 0 Environment Check during Load
 ;
 ;       Check Version (18.0)
 I $$VERSION^XPDUTL("ICD")'="18.0" D  D ABRT Q
 . D ET("Version 18.0 not found.  Please install DRG Grouper v 18.0")
 ;
 ;       Check Required Patches
 D:$O(ICDREQP(0))'>0 IMP I $O(ICDREQP(0))>0 D
 . N ICDPAT,ICDI,ICDPN,ICDP,ICDR,ICDC,ICDO,ICDC1,ICDC2,ICDC3,ICDC4,ICD
 . S (ICDR,ICDC)=0 S ICDC1=3,ICDC2=24,ICDC3=36,ICDC4=48
 . S ICDI=0  F  S ICDI=$O(ICDREQP(ICDI)) Q:+ICDI'>0  D
 . . S ICDC=ICDC+1,ICDPAT=$G(ICDREQP(ICDI))
 . S ICDI=0  F  S ICDI=$O(ICDREQP(ICDI)) Q:+ICDI'>0  D
 . . N ICDPAT,ICDPT,ICDREL,ICDINS,ICDCOM,ICDINE,ICDREQ,ICDTX S ICDREQ=$G(ICDREQP(ICDI))
 . . S ICDPAT=$P(ICDREQ,"^",1),ICDREL=$P(ICDREQ,"^",2),ICDCOM=$P(ICDREQ,"^",3)
 . . S ICDPT=$P(ICDPAT," SEQ",1) S:'$L(ICDPT) ICDPT=ICDPAT
 . . S ICDPN=$$INS(ICDPT) S ICDINS=$$INSD(ICDPT),ICDINE=$P(ICDINS,"^",2)
 . . I ICDI=1 D
 . . . W !,?ICDC1,"Checking for ",!
 . . . W !,?ICDC1,"Patch",?ICDC2,"Released",?ICDC3,"Installed",?ICDC4,"Content"
 . . S ICDTX=$J(" ",ICDC1)_ICDPAT
 . . S ICDTX=ICDTX_$J(" ",(ICDC2-$L(ICDTX)))
 . . S:ICDREL?7N ICDTX=ICDTX_$P($$FMTE^XLFDT(ICDREL,"5DZ"),"@",1)
 . . S ICDTX=ICDTX_$J(" ",(ICDC3-$L(ICDTX)))
 . . I +ICDPN>0 D
 . . . S ICDO=+($G(ICDO))+1 S:$L($G(ICDINE)) ICDTX=ICDTX_ICDINE
 . . . S ICDTX=ICDTX_$J(" ",(ICDC4-$L(ICDTX)))
 . . . S:$L(ICDCOM) ICDTX=ICDTX_ICDCOM
 . . D M(ICDTX)
 . . I +ICDPN'>0 D ET((" "_ICDPAT_" not found, please install "_ICDPAT_" before continuing"))
 . W:+($G(ICDO))'=ICDC !
 W ! I $D(ICDE) D M(),ABRT Q
 I '$D(ICDFULL)&(+($G(XPDENV))'=1) D QUIT Q
 ;                    
 ;   Install Package(s)
 ;
 ;     XPDENV = 1 Environment Check during Install
 ;
 ;   Quit, Exit or Abort
 ;
QUIT ;     Quit   Passed Environment Check
 K ICDFULL D OK
 Q
EXIT ;     Exit   Failed Environment Check
 D:$D(ICDE) ED S XPDQUIT=2 K ICDE,ICDFULL Q
ABRT ;     Abort  Failed Environment Check, KILL the distribution
 D:$D(ICDE) ED S XPDABORT=1,XPDQUIT=1,XPDQUIT("ICD*18.0*67")=1,XPDQUIT("LEX*2.0*86")=1,XPDQUIT("FB*3.5*157")=1
 K ICDE,ICDFULL
 Q
ENV2 ; Environment Check (for testing only)
 N XPDENV S XPDENV=1 D ENV
 Q
T1 ; Environment Check #1 (for testing only)
 K XPDENV D ENV
 Q
T2 ; Environment Check #2 (for testing only)
 N XPDENV S XPDENV=1 D ENV
 Q
 ;               
 ; Checks
 ;
INS(X) ;   Installed
 N ICD,ICDP,ICDV,ICDI S ICD=$G(X) I $L(ICD,"*")=3 S X=$$PATCH^XPDUTL(ICD) Q X
 S ICDP=$$PKG^XPDUTL(ICD),ICDV=$$VER^XPDUTL(ICD),ICDI=$$VERSION^XPDUTL(ICDP)
 Q:+ICDV>0&(ICDV=ICDI) 1
 Q 0
INSD(X)  ;   Installed on
 N DA,ICD,ICDDA,ICDE,ICDI,ICDMSG,ICDNS,ICDOUT,ICDPI,ICDPN,ICDSCR,ICDVI,ICDVD,ICDVI,ICDVR S ICD=$G(X)
 S ICDNS=$$PKG^XPDUTL(ICD),ICDVR=$$VER^XPDUTL(ICD),ICDPN=$P(X,"*",3)
 Q:'$L(ICDNS) ""  S ICDVR=+ICDVR Q:ICDVR'>0 ""  S ICDPN=+ICDPN S:ICDVR'["." ICDVR=ICDVR_".0"
 S ICDSCR="I $G(^DIC(9.4,+($G(Y)),""VERSION""))="""_ICDVR_""""
 D FIND^DIC(9.4,,.01,"O",ICDNS,10,"C",ICDSCR,,"ICDOUT","ICDMSG")
 S ICDPI=$G(ICDOUT("DILIST",2,1)) K ICDOUT,ICDMSG Q:+ICDPI'>0 ""  Q:'$D(@("^DIC(9.4,"_ICDPI_",22)")) ""
 K DA S DA(1)=ICDPI S ICDDA=$$IENS^DILF(.DA)
 D FIND^DIC(9.49,ICDDA,".01;1I;2I","O",ICDVR,10,"B",,,"ICDOUT","ICDMSG")
 S ICDVD=$G(ICDOUT("DILIST","ID",1,2)) I $E(ICDVD,1,7)?7N&(+ICDPN'>0) D  Q X
 . S X=$E(ICDVD,1,7)_"^"_$TR($$FMTE^XLFDT($E(ICDVD,1,7),"5DZ"),"@"," ")
 S:$E(ICDVD,1,7)'?7N ICDVD=$G(ICDOUT("DILIST","ID",1,1)) I $E(ICDVD,1,7)?7N&(+ICDPN'>0) D  Q X
 . S X=$E(ICDVD,1,7)_"^"_$TR($$FMTE^XLFDT($E(ICDVD,1,7),"5DZ"),"@"," ")
 Q:+ICDPN'>0 ""  S ICDVI=$G(ICDOUT("DILIST",2,1)) K ICDOUT,ICDMSG
 Q:+ICDVI'>0 ""  Q:'$D(@("^DIC(9.4,"_ICDPI_",22,"_ICDVI_",""PAH"")")) ""
 K DA S DA(2)=ICDPI,DA(1)=ICDVI S ICDDA=$$IENS^DILF(.DA)
 S ICDSCR="I $G(^DIC(9.4,"_ICDPI_",22,"_ICDVI_",""PAH"",+($G(Y)),0))[""SEQ #"""
 D FIND^DIC(9.4901,ICDDA,".01;.02I",,ICDPN,10,"B",ICDSCR,,"ICDOUT","ICDMSG")
 S ICDI=$G(ICDOUT("DILIST","ID",1,.02)) I '$L(ICDI) D
 . S ICDSCR="" D FIND^DIC(9.4901,ICDDA,".01;.02I",,ICDPN,10,"B",ICDSCR,,"ICDOUT","ICDMSG")
 . S ICDI=$G(ICDOUT("DILIST","ID",1,.02))
 Q:'$L(ICDI) ""  Q:$P(ICDI,".",1)'?7N ""  S ICDE=$TR($$FMTE^XLFDT(ICDI,"5DZ"),"@"," ")
 Q:'$L(ICDE) ""  S X=ICDI_"^"_ICDE
 Q X
CHK ;   Check the Checksum
 D CS I $D(ICDE) D ED Q
 D BM("  OK"),M(" ")
 Q
CS ;   Checksum for import global
 K ICDE D BM("   Running checksum routine on the ^ICDM import global, please wait")
 N ICDCK,ICDND,ICDV S ICDCK=+($G(^ICDM(0,"CHECKSUM")))
 S ICDND=+($G(^ICDM(0,"NODES"))),ICDV=+($$VC(ICDCK,ICDND))
 D M(" ") D:ICDV>0 M("     Checksum is ok"),M(" ")
 D:ICDV=0 CM D:ICDV=-1 CW D:ICDV=-2 CU D:ICDV=-3 CF
 Q
VC(X,Y) ;   Verify Checksum for import global
 N ICDPTYPE,ICDLREV,ICDREQP,ICDBUILD,ICDIGHF,ICDFY,ICDQTR Q:'$D(^ICDM) 0
 D IMP I $G(^ICDM(0,"BUILD"))'=$G(ICDBUILD) Q -1
 N ICDCK,ICDND,ICDCNT,ICDLC,ICDL,ICDS,ICDNC,ICDD,ICDN,ICDC,ICDGCS,ICDP,ICDT
 S ICDCK=+($G(X)),ICDND=+($G(Y))
 Q:ICDCK'>0!(ICDND'>0) -2
 S ICDL=64,(ICDCNT,ICDLC)=0,ICDS=(+(ICDND\ICDL))
 S:ICDS=0 ICDS=1 D:+($O(^ICDM(0)))>0 M("")
 S (ICDC,ICDN)="^ICDM",(ICDNC,ICDGCS)=0 W "   "
 F  S ICDN=$Q(@ICDN) Q:ICDN=""!(ICDN'[ICDC)  D
 . Q:ICDN="^ICDM(0,""CHECKSUM"")"
 . Q:ICDN="^ICDM(0,""NODES"")"
 . S ICDCNT=ICDCNT+1
 . I ICDCNT'<ICDS S ICDLC=ICDLC+1 W:ICDLC'>ICDL "." S ICDCNT=0
 . S ICDNC=ICDNC+1,ICDD=@ICDN,ICDT=ICDN_"="_ICDD
 . F ICDP=1:1:$L(ICDT) S ICDGCS=$A(ICDT,ICDP)*ICDP+ICDGCS
 Q:ICDNC'=ICDND -3
 Q:ICDGCS'=ICDCK -3
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
 Q 0
 ;               
 ; Error messages
 ;
CM ;   Missing ^ICDM
 N ICDPTYPE,ICDLREV,ICDREQP,ICDBUILD,ICDIGHF,ICDFY,ICDQTR D IMP D ET(""),ET("Missing import global ^ICDM.") D CO
 Q
CW ;   Wrong ^ICDM
 N ICDB,ICDPTYPE,ICDLREV,ICDREQP,ICDBUILD,ICDIGHF,ICDFY,ICDQTR D IMP S ICDB=$G(^ICDM(0,"BUILD")) D ET("")
 I $L(ICDBUILD),$L(ICDB),ICDBUILD'=ICDB D  Q
 . D ET(("Incorrect import global ^ICDM found ("_ICDB_" global).")) D CKO
 D ET("Incorrect import global ^ICDM found.") D CKO
 Q
CU ;   Unable to verify
 N ICDPTYPE,ICDLREV,ICDREQP,ICDBUILD,ICDIGHF,ICDFY,ICDQTR D IMP D ET(""),ET("Unable to verify checksum for import global ^ICDM (possibly corrupt).") D CKO
 Q
CF ;   Failed checksum
 N ICDPTYPE,ICDLREV,ICDREQP,ICDBUILD,ICDIGHF,ICDFY,ICDQTR D IMP D ET("") D ET("Import global ^ICDM failed checksum.") D CKO
 Q
CO ;   Obtain new global
 N ICDPTYPE,ICDLREV,ICDREQP,ICDBUILD,ICDIGHF,ICDFY,ICDQTR D IMP
 D ET(""),ET("    Please obtain a copy of the import global ^ICDM contained in the ")
 D ET(("    global host file "_ICDIGHF_" before continuing with the "_ICDBUILD))
 D ET(("    installation."))
 Q
TEST ;
 D CW,ED
 Q
CKO ;   Kill and Obtain new global
 N ICDPTYPE,ICDLREV,ICDREQP,ICDBUILD,ICDIGHF,ICDFY,ICDQTR D IMP D ET("")
 D ET(("    Use the entry point KALL^ICDXGI2 to safely KILL the existing "))
 D ET(("    import global ^ICDM from your system.  Then obtain a new copy"))
 D ET(("    of ^ICDM contained in the global host file "_ICDIGHF_" before"))
 D ET(("    continuing with the "_ICDBUILD_" installation."))
 Q
ET(X) ;   Error Text
 N ICDI S ICDI=+($G(ICDE(0))),ICDI=ICDI+1,ICDE(ICDI)="    "_$G(X),ICDE(0)=ICDI
 Q
ED ;   Error Display
 N ICDI S ICDI=0 F  S ICDI=$O(ICDE(ICDI)) Q:+ICDI=0  D M(ICDE(ICDI))
 D M(" ") K ICDE Q
 ;                   
 ; Miscellaneous
 ;
NOTDEF(IEN) ;   Check to see if user is defined
 N DA,DR,DIQ,ICD,DIC S DA=IEN,DR=.01,DIC=200,DIQ="ICD" D EN^DIQ1 Q '$D(ICD)
OK ;   Environment is OK
 N ICDPTYPE,ICDLREV,ICDREQP,ICDBUILD,ICDIGHF,ICDFY,ICDQTR,ICDT
 D IMP S ICDT="  Environment "_$S($L(ICDBUILD):("for patch/build "_ICDBUILD_" "),1:"")_"is ok"
 D M(ICDT),M(" ")
 Q
BM(X) ;   Blank Line with Message
 S X=$G(X) S:$E(X,1)'=" " X=" "_X D BMES^XPDUTL(X) Q
M(X) ;   Message
 S X=$G(X) S:$E(X,1)'=" " X=" "_X D MES^XPDUTL(X) Q
TRIM(X) ;   Trim Spaces
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 N XPDABORT,XPDDIQ,XPDENV,XPDQUIT
 Q X
IMP ;   Import names
 S ICDPTYPE="ICD-10 API Changes"
 ;     Revision
 S ICDLREV=67
 ;     Required Builds - ICDREQP(n)=build^released^comment
 S ICDREQP(1)="ICD*18.0*64 SEQ #68^3140805^ICD-10 DRG Grouper"
 ;     This Build Name
 S ICDBUILD="ICD*18.0*67"
 ;     This Build's Export Global Host Filename
 S ICDIGHF=""
 ;     Fiscal Year
 S ICDFY=""
 ;     Quarter
 S ICDQTR=""
 Q
