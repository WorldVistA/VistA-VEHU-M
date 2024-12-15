XTVSLPDC ;ALBANY FO/GTS - VistA Package Sizing Manager - Caption display; 12-JUL-2016
 ;;7.3;TOOLKIT;**143,152**;Apr 25, 1995;Build 3
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for XTVS PKG MGR PARAM CAPTN DISP
 NEW CHNGMADE
 SET CHNGMADE=0
 KILL ^TMP("XTVS-PARAM-BI",$J)
 DO EN^VALM("XTVS PKG MGR PARAM CAPTN DISP")
 QUIT
 ;
HDR ; -- header code
 NEW DEFDIR,SPCPAD,DIRHEAD
 SET SPCPAD=""
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Captioned List"
 SET VALMHDR(2)="                     Version: "_$$VERNUM^XTVSLM()_"     Build: "_$$BLDNUM^XTVSLM()
 SET DIRHEAD="Default Directory: "_DEFDIR
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(3)=SPCPAD_DIRHEAD
 SET SPCPAD=""
 SET DIRHEAD="Parameter file: "_XTVPSPRM_$S(+$G(CHNGMADE)>0:"   {EDITED}",1:"")
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(4)=SPCPAD_DIRHEAD
 DO MSG
 QUIT
 ;
INIT ; -- init variables and list array
 NEW DATAITEM,PRMLNLP,PKG,CAPDAT,LPNM,LNENUM,DEFDIR,FILENAME,LCKCHK
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET LCKCHK=$$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM)
 IF $P(LCKCHK,"^")=1 DO
 . DO KILL
 . SET PKG=""
 . SET VALMCNT=0
 . FOR  SET PKG=$O(^TMP("XTVS-PARAM-CAP",$J,PKG)) Q:PKG=""  DO
 .. SET LNENUM=0
 .. SET CAPDAT=""
 .. DO ADD^XTVSLAPI(.VALMCNT," ")
 .. DO ADD^XTVSLAPI(.VALMCNT," ")
 .. FOR  SET LNENUM=$O(^TMP("XTVS-PARAM-CAP",$J,PKG,LNENUM)) Q:+LNENUM'>0  DO
 ... FOR  SET CAPDAT=$O(^TMP("XTVS-PARAM-CAP",$J,PKG,LNENUM,CAPDAT)) Q:CAPDAT=""  DO
 .... SET DATAITEM=^TMP("XTVS-PARAM-CAP",$J,PKG,LNENUM,CAPDAT)
 .... DO SPLITADD^XTVSLAPI(.VALMCNT,CAPDAT_":  "_DATAITEM)
 ;
 IF ($P(LCKCHK,"^")'=1) SET VALMQUIT="" DO EXIT^XTVSLPDC
 QUIT
 ;
HELP ; -- help code
 IF $D(X),X'["??" DO
 . SET X="?"
 . DO DISP^XQORM1 W !
 IF $D(X),X["??" DO
 . DO CLEAR^VALM1
 . DO FULL^VALM1
 . WRITE !,"Captioned List action help..."
 . WRITE !,"List specific actions:",!
 . DO DISP^XQORM1 W !!
 . SET XTQVAR=Y
 . IF XTQVAR DO
 .. SET XTQVAR=0
 .. FOR TXTCT=1:1 SET XTX=$P($T(LPDCTXT+TXTCT^XTVSHLP1),";",3,99) QUIT:XTX="$END"  QUIT:XTQVAR  DO
 ... IF XTX="$PAUSE" DO PAUSE^VALM1 D:Y CLEAR^VALM1 IF 'Y SET XTQVAR=1 QUIT
 ... W !,$S(XTX["$PAUSE":"",1:XTX)
 . W !
 DO HDR,INIT
 S VALMBCK="R"
 K XTX,Y,TXTCT,XTQVAR
 QUIT
 ;
EXIT ; -- exit code
 NEW SVEDT
 SET LCKCHK=$$CHKPID^XTVSLAPI($$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I"),XTVPSPRM)
 IF $P(LCKCHK,"^")=1 DO
 . IF +$G(CHNGMADE)>0 DO
 .. DO FULL^VALM1
 .. WRITE !,"You have unsaved Package edits in this Parameter file!"
 .. SET SVEDT=+$$YNCHK^XTVSLAPI("Do you want to save the Parameter edits before exiting","YES")
 .. IF SVEDT DO PKGSAVE
 .. IF $G(CHNGMADE)>0 DO JUSTPAWS^XTVSLAPI(" Package edits NOT saved!")
 .. IF $G(CHNGMADE)'>0 DO JUSTPAWS^XTVSLAPI(" Package edits saved!")
 ;
 IF ($P(LCKCHK,"^")'=1) DO
 . DO FULL^VALM1
 . W !!," <* LOCK ERROR. LOCK required to proceed. Check LOCK file Integrity. *>"
 . DO JUSTPAWS^XTVSLAPI($P(LCKCHK,"^",2))
 ;
 KILL ^TMP("XTVS-PARAM-BI",$J),LASTSPKG
 DO KILL
 Q
 ;
MSG(TEXT) ; -- set default message
 IF $G(TEXT)]"" SET VALMSG=TEXT
 IF $G(TEXT)']"" SET VALMSG="Enter ?? for more actions and Help"
 QUIT
 ;
KILL ; - Cleanup local and global display arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 KILL ^TMP("XTVS PKG MGR PARAM CAP",$J)
 QUIT
 ;
SELPKG(ADDITM,DELIND) ; Select Package to Edit/Delete from ^TMP("XTVS PKG MGR PARAM CAP",$J)
 ; INPUT:
 ;       ADDITM : 0 - Do not allow add new package [Default]
 ;              : 1 - Allow add new package
 ;       DELIND : 0 - Called to select a package for add/edit [Default]
 ;                1 - Called to select a package to delete
 ;
 ; Set:   ITEMNUM  - Number of items in SELARY 
 ;        SELARY   - Array of Package Parameter files
 ;        PARAMSTR - Array of string parameters as follows:
 ;                       PARAMSTR("ADDITM")   - 0: Adding item to SELARY NOT Allowed;  1: Adding unique item to SELARY Allowed  1^1: Add duplicates allowed
 ;                       PARAMSTR("MAXLNG")   - Maximum length of entered string [default 30, or 10 more than MINLNG when MINLNG>MAXLNG]
 ;                       PARAMSTR("MINLNG")   - Minumum length of entered string [default 10]  - DEV NOTE: MINLNG must be > or = #Chars in PATRN begin & end strings
 ;                       PARAMSTR("PATRN")    - Pattern match definition for text [default .ANP)
 ;                       PARAMSTR("XTUPCASE") - 0: case matters, 1: All item text translated to upper case [default]
 ;
 ;
 ; RETURN  - Name of the selected Package
 ;
 NEW DIR,DIRUT,DTOUT,DUOUT,X,Y,MINLG,MAXLG,PARAMSTR,SELARY,ITEMNUM,PKGNME
 SET PARAMSTR("ADDITM")=+$G(ADDITM) ;Default - 0 No adding items
 SET PARAMSTR("XTUPCASE")=0 ; Case matters
 SET PARAMSTR("PATRN")=".ANP"
 SET PARAMSTR("MINLNG")=4
 SET PARAMSTR("MAXLNG")=50
 SET DELIND=+$G(DELIND) ; Default 0 (add/edit)
 SET PARAMSTR("DELIND")=DELIND
 SET SELARY=""
 ;
 SET ITEMNUM=$$SETSELAY(.SELARY)
 SET PARAMSTR("ITEMNUM")=ITEMNUM
 ;
 IF +ITEMNUM=0 DO JUSTPAWS^XTVSLAPI(" No packages to select. Corrupted Package parameter file!") QUIT  ;Nothing to select
 ;
 SET DIR("A")="Select Package: "
 SET DIR(0)="NAO^1:"_(ITEMNUM+1)_"^K:(X'?.N) X I $D(X),(X>ITEMNUM) K X"
 SET DIR("PRE")="D PRECHK^XTVSLPDC(.X,.LASTSPKG,.SELARY,.ITEMNUM,.PARAMSTR)"
 IF 'ADDITM,('DELIND) SET DIR("?",2)=" New items cannot be added."
 IF ADDITM,('$P(ADDITM,"^",2)) SET DIR("?",2)=" New items can be added but duplicates are not allowed."
 SET DIR("?",1)=" Enter the name or number (1-"_ITEMNUM_") of the Package."
 SET DIR("?")="   [Enter '??' for a numbered list of items OR '^' to exit]"
 SET DIR("??")="^DO LISTOUT^XTVSLAPI(.SELARY)"
 DO ^DIR
 ;
 SET PKGNME=$S(+$G(X)>0:SELARY(X),1:0) ; Return 0 if package not selected
 IF PKGNME'=0 SET LASTSPKG=PKGNME W "  ",PKGNME
 ;
 QUIT PKGNME
 ;
PRECHK(X,LASTSPKG,SELARY,ITEMNUM,PARAMSTR) ; SELPKG X value DIR("PRE") pre-check
 NEW XTVSSAVX,DELIND
 SET DELIND=+$G(PARAMSTR("DELIND"))
 IF (X=" "),($G(LASTSPKG)]"") SET (XTVSSAVX,X)=LASTSPKG W "  ",LASTSPKG
 IF (X]""),('$D(DTOUT)),($E(X,1)'="^") DO
 . IF (X'?.N),($E(X,1)'["?") DO SELLIST^XTVSLPR2(.SELARY,.ITEMNUM,.X,.PARAMSTR)
 IF DELIND,($G(XTVSSAVX)]""),('$D(X)!($D(X)&$G(X)']"")) D SPCPKGCK(XTVSSAVX,ITEMNUM,.SELARY)
 QUIT
 ;
EDITPRM ; Edit parameters for a package
 ; -- Protocol: XTVS PKG MGR EDIT PACKAGE PARM ACTION
 ;
 ;Logic notes:
 ; Select package name
 ; Edit package data in ^TMP("XTVS-PARAM-CAP") array
 ; Redisplay all 'Edited' packages to screen, set "Edit" [CHNGMADE] param to allow Write Edited pkgs action
 ;
 NEW PKGNME,EDITARY,CAPARY,EDPKG,DEFDIR,LCKCHK
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET LCKCHK=$$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM)
 IF $P(LCKCHK,"^")=1 DO
 . DO FULL^VALM1
 . SET PKGNME=$$SELPKG(1)
 . IF PKGNME'=0 DO
 ..;
 .. IF PKGNME["""" DO  ;Assumes that " only in PKGNME via Add New Package (XT*7.3*152)
 ... SET PKGNME=$REPLACE(PKGNME,"""","''")
 ... SET LASTSPKG=PKGNME
 ... DO JUSTPAWS^XTVSLAPI("Quotation marks changed to apostrophes in "_PKGNME_" name.")
 ..;
 .. IF '$D(^TMP("XTVS-PARAM-CAP",$J,PKGNME)) DO SETADD(PKGNME)
 .. IF '$D(^TMP("XTVS-PARAM-BI",$J,PKGNME)) DO BEFORIMG^XTVSLPD1(PKGNME)
 .. SET CAPARY="^TMP(""XTVS-PARAM-CAP"","_$J_","""_PKGNME_""")"
 .. DO EDPKGPRM^XTVSLPD1(PKGNME)
 .. SET EDPKG=$$EDCHK^XTVSLPD1(PKGNME)
 .. IF EDPKG SET @CAPARY=$$SETSTR^XTVSLPD1(CAPARY) ;Update header
 .. IF 'EDPKG KILL ^TMP("XTVS-PARAM-BI",$J,PKGNME)
 .. SET CHNGMADE=$E($D(^TMP("XTVS-PARAM-BI",$J)),1,1)
 ..;
 .. SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 .. SET LCKCHK=$$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM)
 .. IF $P(LCKCHK,"^")=1 DO HDR,INIT
 .;
 . IF PKGNME=0 DO JUSTPAWS^XTVSLAPI(" Package Not Selected.") DO MSG
 ;
 IF $P(LCKCHK,"^")=1 SET VALMBCK="R"
 IF $P(LCKCHK,"^")'=1 SET VALMQUIT=""
 QUIT
 ;
DELPMPKG ; Delete parameters from a package
 ; -- Protocol: XTVS PKG MGR DEL PACKAGE PARM ACTION
 ;
 NEW PKGNME,CAPARY,DELPKG,LCKCHK,DEFDIR
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET LCKCHK=$$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM)
 IF $P(LCKCHK,"^")=1 DO
 . DO FULL^VALM1
 . SET PKGNME=$$SELPKG(0,1)
 . IF PKGNME'=0 DO
 .. SET CAPARY="^TMP(""XTVS-PARAM-CAP"","_$J_","""_PKGNME_""")"
 .. WRITE !,"You have chosen to delete the "_PKGNME_" entry"
 .. WRITE !," from the "_XTVPSPRM_" Package Parameter file.",!
 .. WRITE !,"[If deleted, "_PKGNME_" will not be included"
 .. WRITE !,"  in any VistA Size Report derived from "_XTVPSPRM_"!]",!
 .. SET DELPKG=+$$YNCHK^XTVSLAPI("Are you SURE you want to delete the parameters for this package")
 .. IF 'DELPKG DO MSG
 .. IF DELPKG DO
 ... IF '$D(^TMP("XTVS-PARAM-BI",$J,PKGNME)) DO BEFORIMG^XTVSLPD1(PKGNME) ; Create BI when delete an existing, unedited package.
 ... KILL @CAPARY
 ... IF $D(^TMP("XTVS-PARAM-BI",$J,PKGNME,2,"Primary Prefix")),((^TMP("XTVS-PARAM-BI",$J,PKGNME,2,"Primary Prefix"))="") KILL ^TMP("XTVS-PARAM-BI",$J,PKGNME)
 ... SET CHNGMADE=$E($D(^TMP("XTVS-PARAM-BI",$J)),1,1)
 ... DO:$P($$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM),"^")=1 HDR,INIT
 .;
 . IF PKGNME=0 DO JUSTPAWS^XTVSLAPI(" Package Not Selected.") DO MSG
 .;
 . SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 . SET LCKCHK=$$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM)
 ;
 IF $P(LCKCHK,"^")=1 SET VALMBCK="R"
 IF $P(LCKCHK,"^")'=1 SET VALMBCK="Q" SET VALMQUIT=""
 QUIT
 ;
SAVPMPKG ; Save Package Parameters file
 ; -- Protocol: XTVS PKG MGR SAVE PACKAGE PARM ACTION
 ;
 NEW LCKCHK,DEFDIR
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET LCKCHK=$$CHKPID^XTVSLAPI(DEFDIR,XTVPSPRM)
 IF $P(LCKCHK,"^")=1 DO
 . DO FULL^VALM1
 . IF +$G(CHNGMADE)'>0 DO JUSTPAWS^XTVSLAPI("File Content not edited.  No modifications to save!") DO MSG
 . IF +$G(CHNGMADE)>0 DO 
 .. DO PKGSAVE
 .. IF $G(CHNGMADE)'>0 DO HDR,INIT
 .. IF $G(CHNGMADE)>0 DO MSG
 . SET VALMBCK="R"
 ;
 IF $P(LCKCHK,"^")'=1 SET VALMQUIT=""
 QUIT
 ;
PKGSAVE ;Save Package Changes
 NEW NOWDT,INITIAL,PKGNME,WNFILE,WOFILE,FILENME,DEFDIR
 SET NOWDT=$$FMTE^XLFDT($$NOW^XLFDT,"2M")
 SET NOWDT=$TR(NOWDT,"/","-")
 SET NOWDT=$TR(NOWDT,"@","_")
 SET NOWDT=$TR(NOWDT,":","")
 SET INITIAL=$P($G(^VA(200,DUZ,0)),"^",2)
 IF INITIAL']"" SET INITIAL="<unk>"
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 ;
 SET (WNFILE,WOFILE)=0
 SET WNFILE=+$$YNCHK^XTVSLAPI("Do you want to create a new package parameters file")
 SET:'WNFILE WOFILE=+$$YNCHK^XTVSLAPI("Do you want to OVERWRITE the existing package parameters file")
 IF (WNFILE)!(WOFILE) DO
 . NEW DELRSLT
 . IF WNFILE SET FILENME="XTMPSIZE"_"_"_INITIAL_NOWDT_".DAT" ;Output a New Parameter file
 . ;
 . SET DELRSLT=1 ; Initialize DELRSLT (delete Result) variable
 . IF WOFILE DO  ;Write Old File: FILENME remains the selected/displayed parameter file
 .. NEW DELFLE,OLDFNME,CHKLKER
 .. SET FILENME=XTVPSPRM
 .. IF FILENME[";" SET FILENME=$P(FILENME,";")
 .. SET OLDFNME=$P(FILENME,".")_".BAK"
 .. SET DELFLE(OLDFNME)="" SET DELRSLT=$$DEL^%ZISH(DEFDIR,$NA(DELFLE)) K DELFLE(OLDFNME) ;Delete current Parameter file
 .. SET DELRSLT=$$MV^%ZISH(DEFDIR,XTVPSPRM,DEFDIR,OLDFNME) ;Save current file to "BAK" before overwriting
 .. IF DELRSLT SET DELFLE(XTVPSPRM)="" SET DELRSLT=$$DEL^%ZISH(DEFDIR,$NA(DELFLE)) ;Delete current Parameter file
 .. SET FILENME=XTVPSPRM
 .. DO CRTFLE(DEFDIR,FILENME,WNFILE)
 . ;
 . ; If file name definitions and copies were completed successfully, create the Parameter file
 . IF DELRSLT DO
 .. IF WNFILE DO  ;Write New File
 ... SET UNLKRSLT=$$UNLCKPFL^XTVSLAPI(XTVPSPRM)
 ... IF ($P(UNLKRSLT,"^")'=1) W !!," <* UNLOCK ERROR. Check LOCK file Integrity. *>"
 ... DO JUSTPAWS^XTVSLAPI($P(UNLKRSLT,"^",2))
 ... IF ($P(UNLKRSLT,"^")=1) DO CRTFLE(DEFDIR,FILENME,WNFILE)
 ;
 QUIT
 ;
CRTFLE(DEFDIR,FILENME,WNFILE) ; Update old file/Write New file
 NEW POPERR,CHKLKER
 SET POPERR=0
 DO OPEN^%ZISH("XTMP",DEFDIR,FILENME,"A")
 SET:POP POPERR=POP
 IF 'POPERR DO
 . U IO
 . SET PKGNME=""
 . FOR  SET PKGNME=$O(^TMP("XTVS-PARAM-CAP",$J,PKGNME)) QUIT:PKGNME']""  WRITE !,^TMP("XTVS-PARAM-CAP",$J,PKGNME)
 . D CLOSE^%ZISH("XTMP")
 . SET XTVPSPRM=FILENME
 . SET CHNGMADE=0
 . KILL ^TMP("XTVS-PARAM-BI",$J)
 . IF WNFILE DO
 .. SET CHKLKER=$$REQLOCK^XTVSLAPI(XTVPSPRM)
 .. DO JUSTPAWS^XTVSLAPI($P(CHKLKER,"^",2))
 QUIT
 ;
SETADD(X) ; Add a new package to ^TMP("XTVS-PARAM-CAP")
 SET ^TMP("XTVS-PARAM-CAP",$J,X)=X ;Create new entry in TMP global
 SET ^TMP("XTVS-PARAM-CAP",$J,X,1,"Package Name")=X
 SET ^TMP("XTVS-PARAM-CAP",$J,X,2,"Primary Prefix")=""
 SET ^TMP("XTVS-PARAM-CAP",$J,X,3,"*Lowest File#")=""
 SET ^TMP("XTVS-PARAM-CAP",$J,X,4,"*Highest File#")=""
 SET ^TMP("XTVS-PARAM-CAP",$J,X,5,"Additional Prefixes")=""
 SET ^TMP("XTVS-PARAM-CAP",$J,X,6,"Excepted Prefixes")=""
 SET ^TMP("XTVS-PARAM-CAP",$J,X,7,"File Numbers")=""
 SET ^TMP("XTVS-PARAM-CAP",$J,X,8,"File Ranges")=""
 SET ^TMP("XTVS-PARAM-CAP",$J,X,9,"Parent Package")=""
 QUIT
 ;
SETSELAY(SELARY) ; Move Package names to SELARY from ^TMP("XTVS-PARAM-CAP") array
 NEW ITEMNUM,FILENME
 SET FILENME=""
 SET ITEMNUM=0
 FOR  SET FILENME=$O(^TMP("XTVS-PARAM-CAP",$J,FILENME)) Q:FILENME=""  DO
 . SET ITEMNUM=ITEMNUM+1 SET SELARY(ITEMNUM)=FILENME ;Parameter list
 QUIT ITEMNUM
 ;
SPCPKGCK(XTVSSAVX,ITEMNUM,SELARY) ; Check for existence of the <SPACE> select package in SELARY
 NEW SELARYCT
 FOR SELARYCT=1:1:ITEMNUM QUIT:(SELARY(SELARYCT)=XTVSSAVX)
 IF (+SELARYCT+1)>(+ITEMNUM) W !!,"??  ",XTVSSAVX_" VistA package is undefined."
 QUIT
