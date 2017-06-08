FB35157 ;ISL/KER - FB*3.5*157 Env Check ;12/19/2014
 ;;3.5;FEE BASIS;**157**;JAN 30, 1995;Build 1
 ;               
 ; Global Variables
 ;    ^FBM               N/A
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
 N FBPTYPE,FBLREV,FBREQP,FBBUILD,FBIGHF,FBFY,FBQTR,FBG,FBE,FBSTR D IMP
 K XPDDIQ("XPZ1","B"),XPDDIQ("XPI1","B") S XPDDIQ("XPZ1","B")="NO",XPDDIQ("XPI1","B")="NO"
 S FBSTR=$G(FBPTYPE) S:$L($G(FBFY))&($L($G(FBQTR))) FBSTR=FBSTR_" for "_$G(FBFY)_" "_$G(FBQTR)_" Quarter"
 D M(FBSTR),M("")
 S U="^"
 ;     No user
 D:+($$UR)'>0 ET("User not defined (DUZ)")
 ;     No IO
 D:+($$SY)'>0 ET("Undefined IO variable(s)")
 I $D(FBE) D ABRT Q
 ;                    
 ;   Load Distribution
 ;
 ;     XPDENV = 0 Environment Check during Load
 ;
 ;       Check Version (3.5)
 I $$VERSION^XPDUTL("FB")'="3.5" D  D ABRT Q
 . D ET("Version 3.5 not found.  Please install Fee Basis v 3.5")
 ;
 ;       Check Required Patches
 D:$O(FBREQP(0))'>0 IMP I $O(FBREQP(0))>0 D
 . N FBPAT,FBI,FBPN,FBP,FBR,FBC,FBO,FBC1,FBC2,FBC3,FBC4,FB
 . S (FBR,FBC)=0 S FBC1=3,FBC2=24,FBC3=36,FBC4=48
 . S FBI=0  F  S FBI=$O(FBREQP(FBI)) Q:+FBI'>0  D
 . . S FBC=FBC+1,FBPAT=$G(FBREQP(FBI))
 . S FBI=0  F  S FBI=$O(FBREQP(FBI)) Q:+FBI'>0  D
 . . N FBPAT,FBPT,FBREL,FBINS,FBCOM,FBINE,FBREQ,FBTX S FBREQ=$G(FBREQP(FBI))
 . . S FBPAT=$P(FBREQ,"^",1),FBREL=$P(FBREQ,"^",2),FBCOM=$P(FBREQ,"^",3)
 . . S FBPT=$P(FBPAT," SEQ",1) S:'$L(FBPT) FBPT=FBPAT
 . . S FBPN=$$INS(FBPT) S FBINS=$$INSD(FBPT),FBINE=$P(FBINS,"^",2)
 . . I FBI=1 D
 . . . W !,?FBC1,"Checking for ",!
 . . . W !,?FBC1,"Patch",?FBC2,"Released",?FBC3,"Installed",?FBC4,"Content"
 . . S FBTX=$J(" ",FBC1)_FBPAT
 . . S FBTX=FBTX_$J(" ",(FBC2-$L(FBTX)))
 . . S:FBREL?7N FBTX=FBTX_$P($$FMTE^XLFDT(FBREL,"5DZ"),"@",1)
 . . S FBTX=FBTX_$J(" ",(FBC3-$L(FBTX)))
 . . I +FBPN>0 D
 . . . S FBO=+($G(FBO))+1 S:$L($G(FBINE)) FBTX=FBTX_FBINE
 . . . S FBTX=FBTX_$J(" ",(FBC4-$L(FBTX)))
 . . . S:$L(FBCOM) FBTX=FBTX_FBCOM
 . . D M(FBTX)
 . . I +FBPN'>0 D ET((" "_FBPAT_" not found, please install "_FBPAT_" before continuing"))
 . W:+($G(FBO))'=FBC !
 W ! I $D(FBE) D M(),ABRT Q
 I '$D(FBFULL)&(+($G(XPDENV))'=1) D QUIT Q
 ;                    
 ;   Install Package(s)
 ;
 ;     XPDENV = 1 Environment Check during Install
 ;
 ;   Quit, Exit or Abort
 ;
QUIT ;     Quit   Passed Environment Check
 K FBFULL D OK
 Q
EXIT ;     Exit   Failed Environment Check
 D:$D(FBE) ED S XPDQUIT=2 K FBE,FBFULL Q
ABRT ;     Abort  Failed Environment Check, KILL the distribution
 D:$D(FBE) ED S XPDABORT=1,XPDQUIT=1,XPDQUIT("FB*3.5*157")=1,XPDQUIT("LEX*2.0*86")=1,XPDQUIT("ICD*18.0*67")=1
 K FBE,FBFULL
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
 N FB,FBP,FBV,FBI S FB=$G(X) I $L(FB,"*")=3 S X=$$PATCH^XPDUTL(FB) Q X
 S FBP=$$PKG^XPDUTL(FB),FBV=$$VER^XPDUTL(FB),FBI=$$VERSION^XPDUTL(FBP)
 Q:+FBV>0&(FBV=FBI) 1
 Q 0
INSD(X)  ;   Installed on
 N DA,FB,FBDA,FBE,FBI,FBMSG,FBNS,FBOUT,FBPI,FBPN,FBSCR,FBVI,FBVD,FBVI,FBVR S FB=$G(X)
 S FBNS=$$PKG^XPDUTL(FB),FBVR=$$VER^XPDUTL(FB),FBPN=$P(X,"*",3)
 Q:'$L(FBNS) ""  S FBVR=+FBVR Q:FBVR'>0 ""  S FBPN=+FBPN S:FBVR'["." FBVR=FBVR_".0"
 S FBSCR="I $G(^DIC(9.4,+($G(Y)),""VERSION""))="""_FBVR_""""
 D FIND^DIC(9.4,,.01,"O",FBNS,10,"C",FBSCR,,"FBOUT","FBMSG")
 S FBPI=$G(FBOUT("DILIST",2,1)) K FBOUT,FBMSG Q:+FBPI'>0 ""  Q:'$D(@("^DIC(9.4,"_FBPI_",22)")) ""
 K DA S DA(1)=FBPI S FBDA=$$IENS^DILF(.DA)
 D FIND^DIC(9.49,FBDA,".01;1I;2I","O",FBVR,10,"B",,,"FBOUT","FBMSG")
 S FBVD=$G(FBOUT("DILIST","ID",1,2)) I $E(FBVD,1,7)?7N&(+FBPN'>0) D  Q X
 . S X=$E(FBVD,1,7)_"^"_$TR($$FMTE^XLFDT($E(FBVD,1,7),"5DZ"),"@"," ")
 S:$E(FBVD,1,7)'?7N FBVD=$G(FBOUT("DILIST","ID",1,1)) I $E(FBVD,1,7)?7N&(+FBPN'>0) D  Q X
 . S X=$E(FBVD,1,7)_"^"_$TR($$FMTE^XLFDT($E(FBVD,1,7),"5DZ"),"@"," ")
 Q:+FBPN'>0 ""  S FBVI=$G(FBOUT("DILIST",2,1)) K FBOUT,FBMSG
 Q:+FBVI'>0 ""  Q:'$D(@("^DIC(9.4,"_FBPI_",22,"_FBVI_",""PAH"")")) ""
 K DA S DA(2)=FBPI,DA(1)=FBVI S FBDA=$$IENS^DILF(.DA)
 S FBSCR="I $G(^DIC(9.4,"_FBPI_",22,"_FBVI_",""PAH"",+($G(Y)),0))[""SEQ #"""
 D FIND^DIC(9.4901,FBDA,".01;.02I",,FBPN,10,"B",FBSCR,,"FBOUT","FBMSG")
 S FBI=$G(FBOUT("DILIST","ID",1,.02)) I '$L(FBI) D
 . S FBSCR="" D FIND^DIC(9.4901,FBDA,".01;.02I",,FBPN,10,"B",FBSCR,,"FBOUT","FBMSG")
 . S FBI=$G(FBOUT("DILIST","ID",1,.02))
 Q:'$L(FBI) ""  Q:$P(FBI,".",1)'?7N ""  S FBE=$TR($$FMTE^XLFDT(FBI,"5DZ"),"@"," ")
 Q:'$L(FBE) ""  S X=FBI_"^"_FBE
 Q X
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
 N FBI S FBI=+($G(FBE(0))),FBI=FBI+1,FBE(FBI)="    "_$G(X),FBE(0)=FBI
 Q
ED ;   Error Display
 N FBI S FBI=0 F  S FBI=$O(FBE(FBI)) Q:+FBI=0  D M(FBE(FBI))
 D M(" ") K FBE Q
 ;                   
 ; Miscellaneous
 ;
NOTDEF(IEN) ;   Check to see if user is defined
 N DA,DR,DIQ,FB,DIC S DA=IEN,DR=.01,DIC=200,DIQ="FB" D EN^DIQ1 Q '$D(FB)
OK ;   Environment is OK
 N FBPTYPE,FBLREV,FBREQP,FBBUILD,FBIGHF,FBFY,FBQTR,FBT
 D IMP S FBT="  Environment "_$S($L(FBBUILD):("for patch/build "_FBBUILD_" "),1:"")_"is ok"
 D M(FBT),M(" ")
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
 S FBPTYPE="Fee Basis Payment Change"
 ;     Revision
 S FBLREV=157
 ;     Required Builds - FBREQP(n)=build^released^comment
 S FBREQP(1)="FB*3.5*123 SEQ #130^3141219^VA-DoD VistA Fee IPAC Interface"
 ;                        Fee Basis ICD-10 Remediation"
 ;     This Build Name
 S FBBUILD="FB*3.5*157"
 ;     This Build's Export Global Host Filename
 S FBIGHF=""
 ;     Fiscal Year
 S FBFY=""
 ;     Quarter
 S FBQTR=""
 Q
