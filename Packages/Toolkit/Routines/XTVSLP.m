XTVSLP ;ALBANY FO/GTS - VistA Package Sizing Manager; 7-JUL-2016
 ;;7.3;TOOLKIT;**143,152**;Apr 25, 1995;Build 3
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for XTVS PKG MGR PARAM DISPLAY
 D EN^VALM("XTVS PKG MGR PARAM DISPLAY")
 Q
 ;
HDR ; -- header code
 NEW DEFDIR,SPCPAD,DIRHEAD
 SET SPCPAD=""
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Parameter Display"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^XTVSLM()_"     Build: "_$$BLDNUM^XTVSLM()
 SET DIRHEAD="Default Directory: "_DEFDIR
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(3)=SPCPAD_DIRHEAD
 SET SPCPAD=""
 SET DIRHEAD="Parameter file: "_XTVPSPRM
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(4)=SPCPAD_DIRHEAD
 DO MSG
 QUIT
 ;
BUILD ; - Build local and global display arrays
 NEW DEFDIR,LINEITEM
 DO KILL ;Kill all processing & data arrays and video attributes & control arrays
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 DO OPEN^%ZISH("XTMP",DEFDIR,XTVPSPRM,"R")
 U IO
 SET VALMCNT=0
 FOR  S LINEITEM="" READ LINEITEM:5 Q:$$STATUS^%ZISH  DO
 . IF LINEITEM]"" DO 
 .. DO SCAPARY(LINEITEM) ;Creates ^TMP("XTVS-PARAM-CAP",$J) array
 .. DO SPLITADD^XTVSLAPI(.VALMCNT,LINEITEM,1)
 .. DO LOADTMP(LINEITEM) ;Store LineItem into ^TMP global & Index
 D CLOSE^%ZISH("XTMP")
 QUIT
 ;
INIT ; -- init variables and list array
 NEW XTVSXFNM
 DO FULL^VALM1
 IF (+$G(FIRSTITM)>0),($G(LASTITM)>0) DO
 . NEW CHKLKER,LCKCHK,DEFDIR
 . SET XTVSXFNM=$$SELXTMP^XTVSLAPI(FIRSTITM,LASTITM)
 . IF XTVSXFNM]"" DO
 .. SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 .. SET XTVPSPRM=XTVSXFNM
 .. SET LCKCHK=$$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM) ;Returns 1 when current process has lock
 .. SET CHKLKER=$$REQLOCK^XTVSLAPI(XTVPSPRM) ;Returns 1 when any process has lock
 .. IF (+CHKLKER=0)!(+LCKCHK=1) DO
 ... DO:(+CHKLKER=0) JUSTPAWS^XTVSLAPI($P(CHKLKER,"^",2))
 ... DO:(+LCKCHK=1) JUSTPAWS^XTVSLAPI(XTVPSPRM_" LOCK already held.")
 ... DO BUILD
 .. IF (+CHKLKER=1),(+LCKCHK'=1) DO
 ... W !!," <* LOCK request denied! Try again later. *>"
 ... DO JUSTPAWS^XTVSLAPI($P(CHKLKER,"^",2))
 ... DO EXIT^XTVSLP S VALMQUIT=""
 . IF XTVSXFNM']"" SET VALMQUIT=""
 IF ((+$G(FIRSTITM)'>0)&(+$G(LASTITM)'>0))!($G(XTVSXFNM)']"") SET VALMQUIT=""
 QUIT
 ;
HELP ; -- help code
 IF $D(X),X'["??" DO
 . SET X="?"
 . DO DISP^XQORM1 W !
 IF $D(X),X["??" DO
 . DO CLEAR^VALM1
 . DO FULL^VALM1
 . WRITE !,"Parameter Display action help..."
 . WRITE !,"List specific actions:",!
 . DO DISP^XQORM1 W !!
 . SET XTQVAR=Y
 . IF XTQVAR DO
 .. SET XTQVAR=0
 .. FOR TXTCT=1:1 SET XTX=$P($T(LPTXT+TXTCT^XTVSHLP1),";",3,99) QUIT:XTX="$END"  QUIT:XTQVAR  DO
 ... IF XTX="$PAUSE" DO PAUSE^VALM1 D:Y CLEAR^VALM1 IF 'Y SET XTQVAR=1 QUIT
 ... W !,$S(XTX["$PAUSE":"",1:XTX)
 . W !
 S VALMBCK="R"
 D MSG
 K XTX,Y,TXTCT,XTQVAR
 Q
 ;
EXIT ; -- exit code
 NEW DEFDIR,LCKCHK
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 IF $G(XTVPSPRM)]"" SET LCKCHK=$$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM)
 DO FULL^VALM1
 IF ($P($G(LCKCHK),"^")=1) DO
 . NEW UNLKRSLT
 . SET UNLKRSLT=$$UNLCKPFL^XTVSLAPI(XTVPSPRM)
 . IF ($P(UNLKRSLT,"^")'=1) W !!," <* UNLOCK ERROR. Check LOCK file Integrity. *>"
 . DO JUSTPAWS^XTVSLAPI($P(UNLKRSLT,"^",2))
 IF (($P($G(LCKCHK),"^")=0)!($P($G(LCKCHK),"^")=-1)),('$D(CHKLKER)) DO JUSTPAWS^XTVSLAPI($P(LCKCHK,"^",2))
 ;
 DO KILL
 Q
 ;
REFRESH ; -- refresh display
 DO BUILD
 SET VALMBCK="R"
 QUIT
 ;
MSG(TEXT) ; -- set default message
 IF $G(TEXT)]"" SET VALMSG=TEXT
 IF $G(TEXT)']"" SET VALMSG="Enter ?? for more actions and Help"
 QUIT
 ;
KILL ; - Cleanup local and global display arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 DO CLNTMPGB
 KILL ^TMP("XTVS PKG MAN PARM DISP",$JOB)
 KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 QUIT
 ;
 ;APIs
LOADTMP(LINEITEM) ;Store LineItem into ^TMP global
 ;Input : LINEITEM - A single Package lineitem from XTMPSIZE.DAT
 ;
 ;Output: ^TMP array in the following form:
 ;  ^TMP("{package name}","{primary prefix}")=LINEITEM [Package line from XTMPSIZE.DAT]
 ;  ^TMP("{package name}","{primary prefix}","ADDPFX","{added prefix}")=""
 ;  ^TMP("{package name}","{primary prefix}","F1-FLERNG","{file range 1}")="" [File # range from LOW-HIGH RANGE multiple]
 ;  ^TMP("{package name}","{primary prefix}","F2-BEGFILE")=file number [Start file #]
 ;  ^TMP("{package name}","{primary prefix}","F2-ENDFILE")=file number [Ending file #]
 ;  ^TMP("{package name}","{primary prefix}","F3-FNUM",{file#})="" [File # from FILE NUMBER multiple]
 ;  ^TMP("{package name}","{primary prefix}","PARENT")=Package [PARENT PACKAGE field]
 ;  ^TMP("{package name}","{primary prefix}","REMPFX","{removed prefix}")=""
 ;
 NEW FSET,BEGFLNUM,ENDFLNUM,PCENUM,FNUM,APFX,APFXLST,FILELIST,PKGNAME,PKGPFX,RPFX,RPFXLST
 SET FSET=0
 SET PKGNAME=$P(LINEITEM,"^")
 SET PKGPFX=$P(LINEITEM,"^",2)
 SET BEGFLNUM=$P(LINEITEM,"^",3)
 SET ENDFLNUM=$P(LINEITEM,"^",4)
 ;
 ;Load package components into ^TMP Global (loop)
 SET ^TMP("XTVS-PKGEDIT",$J,PKGNAME,PKGPFX)=LINEITEM ;Define Data node
 ;
 ;Define File Range array nodes
 SET FILELIST=$P(LINEITEM,"^",8)
 ;
 ;File Ranges [1st priority when defined]
 IF FILELIST'="" DO
 . SET PCENUM=0
 . FOR  SET PCENUM=PCENUM+1 SET FLERNG=$P(FILELIST,"|",PCENUM) QUIT:FLERNG']""  DO
 .. SET ^TMP("XTVS-PKGEDIT",$J,PKGNAME,PKGPFX,"F1-FLERNG",FLERNG)=""
 .. DO FILNDX(FLERNG,PKGNAME,"FR",.FSET) ;Set ^TMP("XTVS-FRIDX",$J,<begin file #>,<end file #>,<package name>)=""
 ;
 ;*Lowest File # & *Highest File # [2nd priority when defined and File Ranges Not defined]
 IF FILELIST="" DO
  . IF BEGFLNUM]"",ENDFLNUM]"" DO FILNDX(BEGFLNUM_"-"_ENDFLNUM,PKGNAME,"LH",.FSET) ;Set ^TMP("XTVS-FRIDX",$J,<begin file #>,<end file #>,<package name>)=""
 ;
 ;*File List [3rd priority when defined and File Ranges & *Low/*High not defined]
 IF $P(LINEITEM,"^",7)'="" DO
 . SET FILELIST=$P(LINEITEM,"^",7)
 . SET PCENUM=0
 . FOR  SET PCENUM=PCENUM+1 SET FNUM=$P(FILELIST,"|",PCENUM) QUIT:FNUM']""  DO
 .. SET ^TMP("XTVS-PKGEDIT",$J,PKGNAME,PKGPFX,"F3-FNUM",FNUM_"-"_FNUM)="" ;Define File Number array nodes
 .. DO:'FSET FILNDX(FNUM_"-"_FNUM,PKGNAME,"FL",FSET) ;Set ^TMP("XTVS-FRIDX",$J,<file #>,<file #>,<package name>)=""
 ;
 ;Define Start/End File number array nodes
 IF BEGFLNUM]"" SET ^TMP("XTVS-PKGEDIT",$J,PKGNAME,PKGPFX,"F2-BEGFILE",BEGFLNUM_"-"_ENDFLNUM)=BEGFLNUM
 IF ENDFLNUM]"" SET ^TMP("XTVS-PKGEDIT",$J,PKGNAME,PKGPFX,"F2-ENDFILE",BEGFLNUM_"-"_ENDFLNUM)=ENDFLNUM
 ;
 ;Define Additional & Excepted Prefix Array nodes
 SET APFXLST=PKGPFX_"|"_$P(LINEITEM,"^",5)
 SET RPFXLST=$P(LINEITEM,"^",6)
 SET PCENUM=0
 FOR  SET PCENUM=PCENUM+1 SET APFX=($P(APFXLST,"|",PCENUM)) QUIT:APFX']""  DO
 . SET ^TMP("XTVS-PKGEDIT",$J,PKGNAME,PKGPFX,"ADDPFX",APFX)="" ;Additional Namespace
 . DO PFXIDX(APFX,PKGNAME,APFXLST_"^"_RPFXLST) ;Set ^TMP("XTVS-PFXIDX",$J,,<namespace prefix>,<package name>)="" [Additional & Excepted Prefixe Index]
 DO:PKGPFX]"" PFXIDX(PKGPFX,PKGNAME,APFXLST_"^"_RPFXLST) ;Set ^TMP("XTVS-PFXIDX",$J,<namespace prefix>,<package name>)="" [Primary Prefix index]
 ;
 SET PCENUM=0
 FOR  SET PCENUM=PCENUM+1 SET RPFX=($P(RPFXLST,"|",PCENUM)) QUIT:RPFX']""  DO
 . SET ^TMP("XTVS-PKGEDIT",$J,PKGNAME,PKGPFX,"REMPFX",RPFX)="" ;Excepted Namespace
 ;
 ;Define Parent array node
 SET ^TMP("XTVS-PKGEDIT",$J,PKGNAME,PKGPFX,"PARENT")=$P(LINEITEM,"^",9)
 ;
 QUIT
 ;
 ;
 ;"XTVS-FRIDX" USAGE NOTE: Supports File Range Overlap report
 ; In CHKFILE^XTVSLPR1, loop ^TMP("XTVS-FRIDX,"$J)
 ; Retrieve Begin/End Range values for "F1-FLERNG" [Subscripts 3 & 4]
 ; Check File Range of checked package for:
 ;   If RNGEND < "F1-FLERNG" node begin # ...QUIT check
 ;   If RNGBEG > "F1-FLERNG" node end # ...QUIT check
 ;
 ;   If RNGBEG '< "F1-FLERNG" begin node, check for package name
 ;   If not package name, create a File overlap error node indicating "F1-FLERNG" package, overlapping files and RNG package
 ;   If RNGEND '> "F1-FLERNG" end node, check for package name
 ;     If not package name, create a File overlap error node indicating "F1-FLERNG" package, overlapping files and RNG package
 ;
FILNDX(FLRNGE,PKGNAME,TYPE,FSET) ; Set File Number Index [^TMP("XTVS-FRIDX",$J)]
 ;Input: FLRNGE  - File Range
 ;       PKGNAME - Package name
 ;       TYPE    - Type of File data
 ;                   FR : File Range multiple
 ;                   LH : *Lowest & *Highest fields
 ;                   FL : File List multiple
 ;       FSET    - File Data set indicator for ^XTMP("XTVS-FRIDX")
 ;                   0 : Not set
 ;                   1 : Set
 ;
 ;Output : File Range Node [^TMP("XTVS-FRIDX",$J,<begin file #>,<end file #>,<package name>)=""]
 ;
 ; <begin file #> and <end file #> are defined from the data in the following order:
 ;  1) Package 'File Range' multiple'                                    
 ;        If Overlap package 'File Range' is not defined, then...                
 ;  2) Package file range defined by '*Lowest File#' & '*Highest File#'  
 ;
 NEW BEGFNUM,ENDFNUM
 SET BEGFNUM=$P(FLRNGE,"-")
 SET ENDFNUM=$P(FLRNGE,"-",2)
 SET ^TMP("XTVS-FRIDX",$J,BEGFNUM,ENDFNUM,PKGNAME)=TYPE
 SET FSET=1
 QUIT
 ;
 ;
 ;"XTVS-PFXIDX" USAGE NOTE: Supports Prefix Overlap report
 ; In CHKPFX^XTVSLPR1, loop ^TMP("XTVS-PFXIDX",$J,<prefix>,<package name>)
 ; Extract Primary Prefix (4th subscript) and added Prefixes from "ADDPFX" (6th subscript)
 ; If <package name> in Array subscript doesn't equal "package name"...
 ;   create a Prefix overlap error node indicating "ADDPFX" package, overlapping prefix and "PFXIDX" package [MLTPFX^XTVSLPR1]
 ;
PFXIDX(PKGPFX,PKGNAME,PFXLST) ;Set ^TMP("XTVS-PFXIDX",$J,<namespace prefix>,<package name>)=<list of prefixes>
 SET PFXLST=$G(PFXLST)
 SET ^TMP("XTVS-PFXIDX",$J,PKGPFX,PKGNAME)=PFXLST
 QUIT
 ;
SCAPARY(LINEITEM) ; Set single line Array & caption display array for action processing
 NEW PARMDAT,PKG
 ;
 ;Set Caption Display Array
 SET PKG=$P(LINEITEM,"^")
 SET ^TMP("XTVS-PARAM-CAP",$J,PKG)=LINEITEM
 SET PARMDAT=$P(LINEITEM,"^")
 SET ^TMP("XTVS-PARAM-CAP",$J,PKG,1,"Package Name")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",2)
 SET ^TMP("XTVS-PARAM-CAP",$J,PKG,2,"Primary Prefix")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",3)
 SET ^TMP("XTVS-PARAM-CAP",$J,PKG,3,"*Lowest File#")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",4)
 SET ^TMP("XTVS-PARAM-CAP",$J,PKG,4,"*Highest File#")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",5)
 SET ^TMP("XTVS-PARAM-CAP",$J,PKG,5,"Additional Prefixes")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",6)
 SET ^TMP("XTVS-PARAM-CAP",$J,PKG,6,"Excepted Prefixes")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",7)
 SET ^TMP("XTVS-PARAM-CAP",$J,PKG,7,"File Numbers")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",8)
 SET ^TMP("XTVS-PARAM-CAP",$J,PKG,8,"File Ranges")=PARMDAT
 SET PARMDAT=$P(LINEITEM,"^",9)
 SET ^TMP("XTVS-PARAM-CAP",$J,PKG,9,"Parent Package")=PARMDAT
 QUIT
 ;
CLNTMPGB ;Kill temporary globals
 KILL ^TMP("XTVS-PKGEDIT",$J),^TMP("XTVS-ERROR",$J),^TMP("XTVS-FRIDX",$J),^TMP("XTVS-PFXIDX",$J)
 KILL ^TMP("XTVS-PARAM-CAP",$J)
 QUIT
 ;
PRMFLIST(FLESRCH,PAWSOUT) ;List parameter files for selection
 NEW DEFDIR,FILENME,FILELIST,LSTRSLT,SELARY,ITEMNUM,XVAL
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 IF $G(FLESRCH)="" SET FLESRCH="XTMPSIZE*"
 IF $G(PAWSOUT)="" SET PAWSOUT=" There are no XTMPSIZE files for comparison!"
 SET FILENME(FLESRCH)=""
 SET LSTRSLT=$$LIST^%ZISH(DEFDIR,"FILENME","FILELIST")
 SET FILENME=""
 IF LSTRSLT DO
 .; Move XTMPSIZE files to SELARY
 .SET ITEMNUM=0
 .FOR  SET FILENME=$O(FILELIST(FILENME)) Q:FILENME=""  DO
 ..IF (FLESRCH'[".LCK"),(FILENME'[".LCK") SET ITEMNUM=ITEMNUM+1 SET SELARY(ITEMNUM)=FILENME ;Parameter list
 ..IF (FLESRCH[".LCK") SET ITEMNUM=ITEMNUM+1 SET SELARY(ITEMNUM)=FILENME ; Lock list
 .;
 .IF ITEMNUM>0 DO 
 .. NEW PARAMSTR,QSTHLP1
 .. IF FLESRCH'[".LCK" DO
 ... SET QSTHLP1=" Enter the name or number (1-"_ITEMNUM_") of the desired parameter file to compare."
 ... SET PARAMSTR("MINLNG")=10
 ..;
 .. IF FLESRCH[".LCK" DO
 ... DO LISTOUT^XTVSLAPI(.SELARY)
 ... SET QSTHLP1=" Enter the name or number (1-"_ITEMNUM_") LOCK to release."
 ... SET PARAMSTR("MINLNG")=8
 ..;
 .. SET PARAMSTR("PATRN")="1""XTMPSIZE"".ANP"
 .. SET PARAMSTR("DEFANS")=""
 .. SET PARAMSTR("MAXLNG")=30
 .. SET PARAMSTR("ADDITM")=0
 .. SET XVAL=+$$SELITEM(QSTHLP1,.ITEMNUM,.SELARY,.PARAMSTR)
 .. ;
 ..IF (+$G(XVAL)>0)&(+$G(XVAL)<(ITEMNUM+1)) SET FILENME=SELARY(XVAL) W "   ",FILENME
 ..IF ITEMNUM'>0 DO JUSTPAWS^XTVSLAPI(PAWSOUT)
 ;
 IF 'LSTRSLT DO JUSTPAWS^XTVSLAPI(PAWSOUT)
 QUIT FILENME
 ;
SELITEM(QSTHLP1,ITEMNUM,SELARY,PARAMSTR) ; Select Package Parameter file from SELARY
 ; INPUT: QSTHLP1  - Help string for 1 question mark help [Optional]
 ;        ITEMNUM  - Number of items in SELARY 
 ;        SELARY   - Array of Package Parameter files
 ;        PARAMSTR - Array of string parameters as follows:
 ;                       PARAMSTR("ADDITM")   - 0: Adding item to SELARY NOT Allowed;  1: Adding unique item to SELARY Allowed  1^1: Add duplicates allowed
 ;                       PARAMSTR("DEFANS")   - Only pertains to Package selection.  Not Null: Last selected Package
 ;                       PARAMSTR("MAXLNG")   - Maximum length of entered string [default 30, or 10 more than MINLNG when MINLNG>MAXLNG]
 ;                       PARAMSTR("MINLNG")   - Minumum length of entered string [default 10]  - DEV NOTE: MINLNG must be > or = #Chars in PATRN begin & end strings
 ;                       PARAMSTR("PATRN")    - Pattern match definition for text [default .ANP)
 ;                       PARAMSTR("XTUPCASE") - 0: case matters, 1: All item text translated to upper case [default]
 ;
 ;
 ; OUTPUT: Y - Item # for selected Parameter file
 ;
 NEW DIR,DIRUT,DTOUT,DUOUT,X,Y,MINLG,MAXLG,ADDITEM,DEFANS
 IF +$G(PARAMSTR("ADDITM"))=0 SET ADDITEM=0 ;Default - No adding items
 IF +$G(PARAMSTR("ADDITM"))>0 SET ADDITEM=+$G(PARAMSTR("ADDITM"))
 IF $G(PARAMSTR("XTUPCASE"))="" SET PARAMSTR("XTUPCASE")=1
 IF $G(PARAMSTR("PATRN"))="" SET PARAMSTR("PATRN")=".ANP"
 SET DEFANS=$G(PARAMSTR("DEFANS"))
 SET MINLG=+$G(PARAMSTR("MINLNG"))
 SET MAXLG=+$G(PARAMSTR("MAXLNG"))
 IF MINLG=0 SET (MINLG,PARAMSTR("MINLNG"))=10
 IF (MINLG<30),(MINLG>MAXLG) SET (MAXLG,PARAMSTR("MAXLNG"))=30
 IF (MINLG>29),(MINLG>MAXLG) SET PARAMSTR("MAXLNG")=MINLG+10
 SET DIR("A")="Select File: "
 SET DIR(0)="NAO^1:"_(ITEMNUM+1)_"^K:(X'?.N) X I $D(X),(X>ITEMNUM) K X"
 SET DIR("PRE")="D PRECHK^XTVSLP(DEFANS,.X,.SELARY,.ITEMNUM)"
 IF '$D(QSTHLP1) DO
 . SET DIR("?",1)=" Enter the name or number (1-"_ITEMNUM_") of the desired item."
 . IF '$P(ADDITEM,"^",2) SET DIR("?",2)=" Duplicates are not allowed."
 . SET DIR("?")="   [Enter '??' for a numbered list of items OR '^' to exit]"
 IF $D(QSTHLP1) DO
 . SET DIR("?",1)=QSTHLP1
 . IF QSTHLP1'["LOCK" DO
 .. IF 'ADDITEM SET DIR("?",2)=" New items cannot be added."
 .. IF ADDITEM,('$P(ADDITEM,"^",2)) SET DIR("?",2)=" New items can be added but duplicates are not allowed."
 . SET DIR("?")="   [Enter '??' for a numbered list of items OR '^' to exit]"
 SET DIR("??")="^DO LISTOUT^XTVSLAPI(.SELARY)"
 DO ^DIR
 QUIT Y
 ;
PRECHK(DEFANS,X,SELARY,ITEMNUM) ; SELITEM X value DIR("PRE") pre-check
 IF X=" ",$G(DEFANS)]"" SET X=DEFANS W " ",X
 IF X]"",'$D(DTOUT),$E(X,1)'="^" DO
 . IF ((X'?.N)&($E(X,1)'["?")) DO SELLIST^XTVSLPR2(.SELARY,.ITEMNUM,.X,.PARAMSTR)
 QUIT
 ;
PARMMAP ; Map of Parameter data elements
 ; 
 ;Parameter List data map to Package file (#9.4):
 ;-----------------------------------------------
 ; ^ pce 1 : Package Name
 ;              [Source: NAME (#.01)]
 ; ^ pce 2 : Primary Prefix
 ;              [Source: PREFIX (#1)]
 ; ^ pce 3 : *Lowest File #
 ;              [Source: *LOWEST FILE NUMBER (#10.6)]
 ; ^ pce 4 : *Highest File #
 ;              [Source: *HIGHEST FILE NUMBER (#11)]
 ; ^ pce 5 : Pipe character (|) delimited list of Additional Prefixes
 ;              [Source: ADDITIONAL PREFIXES multiple (#14)]
 ; ^ pce 6 : Pipe character (|) delimited list of Excepted Prefixes
 ;              [Source: EXCLUDED NAME SPACE multiple (#919)]
 ; ^ pce 7 : Pipe character (|) delimited list of File Number entries
 ;              [Source: FILE NUMBER multiple (#15001)]
 ; ^ pce 8 : Pipe character (|) delimited list of File Range entries 
 ;              [Source: LOW-HIGH RANGE multiple (#15001.1)]
 ; ^ pce 9 : Parent Package
 ;              [Source: PARENT PACKAGE field (#15003)]
 ; 
 ;$END
 ;
 ;PROTOCOL entry points
 ;
PKGERR ; -- Package Parameter Errors
 ; -- Protocol: XTVS PKG MGR PARAM ERR DISP ACTION
 DO EN^XTVSLPER
 DO REFRESH
 DO MSG
 QUIT
 ;
PARAMRPT ; -- Package Parameter Caption list
 ; -- Protocol: XTVS PKG MGR PARAM DISP CAPTION ACTION
 NEW LCKCHK
 DO EN^XTVSLPDC
 SET LCKCHK=$$CHKPID^XTVSLAPI($$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I"),XTVPSPRM)
 IF $P(LCKCHK,"^")=1 DO 
 . DO REFRESH
 . DO MSG
 IF $P(LCKCHK,"^")'=1 S VALMQUIT=""
 QUIT
 ;
PARAMAP ; -- Display Data Map for Parameter File
 ; -- Protocol: XTVS PKG MGR PARAM DATA MAP HELP ACTION
 NEW HLPTEXT,LNENUM
 DO FULL^VALM1
 FOR LNENUM=1:1 SET HLPTEXT=$P($TEXT(PARMMAP+LNENUM),";",2) Q:HLPTEXT="$END"  W !,HLPTEXT
 DO JUSTPAWS^XTVSLAPI
 ;
 DO REFRESH
 DO MSG
 QUIT
 ;
PARAMCMP ; -- Package Parameter Comparison report
 ; -- Protocol: XTVS PKG MGR PARAM COMPARE ACTION
 NEW CMPRFNME
 DO FULL^VALM1
 SET CMPRFNME=$$PRMFLIST^XTVSLP() ;Select a File to compare
 IF CMPRFNME["XTMPSIZE" DO
 . DO EN^XTVSLPC(CMPRFNME)
 IF CMPRFNME'["XTMPSIZE" DO JUSTPAWS^XTVSLAPI("Comparison XTMPSIZE.DAT file NOT selected!")
 DO REFRESH
 DO MSG
 QUIT
