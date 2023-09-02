XPDK2VC ; VEN/SMH - KIDS to Version Control Main Routine ;نيسان 27, 2020@09:36
 ;;8.0;KERNEL;**11310**;Mar 28, 2014
 ;
 ; (C) Sam Habiel 2014, who needs more money than fame (but a rich wife will do!)
 ; License: Apache 2
 ;
EXPORT(XPDFAIL,SN,ROOT) ; Export KIDS patch to the File system
 ; .XPDFAIL = Catch failures
 ; SN = Short name for Global
 ; ROOT = File system Root
 ;
 ; Obtain patch descriptor
 N PD  ; PATCH DESCRIPTOR
 N BLDIEN S BLDIEN=$O(@SN@("BLD",""))
 N Z S Z=$G(@SN@("BLD",BLDIEN,0))
 I Z="" S $EC=",U-INVALID-BUILD,"
 S PD=$P(Z,U)
 ;
 ; Clean the short name for the global -- REMOVE NUMERIC SUBS
 N PARS S PARS=$P(SN,"(",2,99) ; Take the ( out and leave the rest
 S PARS=$E(PARS,1,$L(PARS)-1)   ; take the ) out
 N Q S Q=""""
 N I F I=1:1:$QL(SN) I +$QS(SN,I) S $P(PARS,",",I)=Q_PD_Q  ; Replace number with PD
 ;
 N OLDSN S OLDSN=SN
 S SN=$QS(OLDSN,0)_"("_PARS_")"
 M @SN=@OLDSN
 K OLDSN,I,Q,PARS ; removed unneeded vars from job
 ;
 ; Set XPDFAIL to a default value...
 S XPDFAIL=0  ; We didn't fail (yet)!
 ;
 ; Make directory for exporting KIDS compoents
 N D S D=$$D^XPDOS() ; Delimiter
 I $E(ROOT,$L(ROOT))'=D S ROOT=ROOT_D ; Add directory delimiter to end if necessary
 ;
 N PD4FS S PD4FS=$TR(PD,"*","_") ; Package descriptor fur filesystem; like OSEHRA one.
 I ROOT'[PD4FS S ROOT=ROOT_PD4FS_D  
 S ROOT=ROOT_"KIDComponents"_D
 ;
 ; Crazy dance for Windoze!
 N % S %=$$MKDIR^XPDOS(ROOT)
 I % D EN^DDIOL($$RED("Couldn't create KIDCommponents directory")) QUIT
 N % S %=$$RM^XPDOS(ROOT)
 I % D EN^DDIOL($$RED("Deletion of current directory contents failed")) QUIT
 ;
 N % S %=$$MKDIR^XPDOS(ROOT)
 I % D EN^DDIOL($$RED("Couldn't create KIDCommponents directory")) QUIT
 ;
 ; Say that we are exporting
 N MSG S MSG(1)="Exporting Patch "_PD
 S MSG(1,"F")="!!"
 S MSG(2)="Exporting at "_ROOT
 S MSG(2,"F")="!"
 D EN^DDIOL(.MSG)
 ;
 ; Stanza to process each component of loaded global
 ; I $D(^XTMP("K2VC",PD,"DATA")) BREAK
 ; BLD - Build
 D GENOUT(.XPDFAIL,$NA(@SN@("BLD")),ROOT,"Build.zwr",4,"IEN") ; Process BUILD Section
 I XPDFAIL D EN^DDIOL($$RED("Couldn't export BLD")) QUIT
 D ASSERT('XPDFAIL)
 ;
 ; Don't kill "BLD" here. Kill after GLO section b/c we may need it.
 ;
 ; Stanza to branch out to a separate program if we are exporting a globals build
 I $D(@SN@("BLD",BLDIEN,"GLO")) D GLOEXP^XPDK2VG(.XPDFAIL,SN,ROOT,BLDIEN) QUIT
 I XPDFAIL D EN^DDIOL($$RED("Couldn't export Globals")) QUIT
 D ASSERT('XPDFAIL)
 K @SN@("BLD") ; Now bye bye
 ;
 ; FIA, ^DD, ^DIC, SEC, DATA, FR* nodes
 D FIA^XPDK2V0(.XPDFAIL,SN,ROOT)                  ; All file components (DD + data)... Killing done internally.
 I XPDFAIL D EN^DDIOL($$RED("Couldn't export FIA, ^DD, ^DIC, SEC, DATA, FR*")) QUIT
 D ASSERT('XPDFAIL)
 ;
 ; PKG - Package
 D GENOUT(.XPDFAIL,$NA(@SN@("PKG")),ROOT,"Package.zwr",4,"IEN")
 I XPDFAIL D EN^DDIOL($$RED("Couldn't export PKG")) QUIT
 K @SN@("PKG")
 D ASSERT('XPDFAIL)
 ;
 ; VER - Kernel and Fileman Versions
 D GENOUT(.XPDFAIL,$NA(@SN@("VER")),ROOT,"KernelFMVersion.zwr")
 I XPDFAIL D EN^DDIOL($$RED("Couldn't export VER")) QUIT
 K @SN@("VER")
 D ASSERT('XPDFAIL)
 ;
 ; PRE - Env Check
 D GENOUT(.XPDFAIL,$NA(@SN@("PRE")),ROOT,"EnvironmentCheck.zwr")
 I XPDFAIL D EN^DDIOL($$RED("Couldn't export PRE")) QUIT
 K @SN@("PRE")
 D ASSERT('XPDFAIL)
 ;
 ; INI - Pre-Init
 D GENOUT(.XPDFAIL,$NA(@SN@("INI")),ROOT,"PreInit.zwr")
 I XPDFAIL D EN^DDIOL($$RED("Couldn't export INI")) QUIT
 K @SN@("INI")
 D ASSERT('XPDFAIL)
 ;
 ; INIT - Post-Install
 D GENOUT(.XPDFAIL,$NA(@SN@("INIT")),ROOT,"PostInstall.zwr")
 I XPDFAIL D EN^DDIOL($$RED("Couldn't export INIT")) QUIT
 K @SN@("INIT")
 D ASSERT('XPDFAIL)
 ;
 ; MBREQ - Required Build
 D GENOUT(.XPDFAIL,$NA(@SN@("MBREQ")),ROOT,"RequiredBuild.zwr")
 I XPDFAIL D EN^DDIOL($$RED("Couldn't export MBREQ")) QUIT
 K @SN@("MBREQ")
 D ASSERT('XPDFAIL)
 ;
 ; QUES - Install Questions
 D GENOUT(.XPDFAIL,$NA(@SN@("QUES")),ROOT,"InstallQuestions.zwr")
 I XPDFAIL D EN^DDIOL($$RED("Couldn't export QUES")) QUIT
 K @SN@("QUES")
 D ASSERT('XPDFAIL)
 ;
 ; RTN - Routines
 D RTN^XPDK2V0(.XPDFAIL,$NA(@SN@("RTN")),ROOT)
 I XPDFAIL D EN^DDIOL($$RED("Couldn't export RTN")) QUIT
 D ASSERT('XPDFAIL)
 ; Kill is done in RTN
 ;
 ; KRN and ORD - Kernel Components
 D KRN(.XPDFAIL,SN,ROOT)
 I XPDFAIL D EN^DDIOL($$RED("Couldn't export KRN")) QUIT
 D ASSERT('XPDFAIL)
 ; Kill is done in KRN
 ;
 ; TEMP - Transport Global
 D GENOUT(.XPDFAIL,$NA(@SN@("TEMP")),ROOT,"TransportGlobal.zwr")
 I XPDFAIL D EN^DDIOL($$RED("Couldn't export TEMP")) QUIT
 K @SN@("TEMP")
 D ASSERT('XPDFAIL)
 ;
 ; Make sure that the XTMP global is now empty. If there is anything there, we have a problem.
 D ASSERT('$D(@SN))
 ;
 ; Cache locks the directory with a windows handle which makes it undeletable.
 ; We need to clear $ZSEARCH so that it will remove that windows handle
 ; Use Process Explorer from SysInternals to see this.
 D CLRCX^XPDOS
 QUIT
 ;
 ;
GENOUT(FAIL,EXGLO,ROOT,FN,QLSUB,SUBNAME) ; Generic Exporter
 ; .FAIL - Output to tell us if we failed
 ; EXGLO - Global NAME (use $NA) to export
 ; ROOT - File system root where to write the file
 ; FN - File name
 ; QLSUB - Substitute this nth subscript WITH...
 ; SUBNAME - ...subname
 ;
 I '$D(@EXGLO) QUIT  ; No data to export
 ;
 N POP
 D OPEN^%ZISH("EXPORT",ROOT,FN,"W")
 I POP S FAIL=1 QUIT
 U IO
 D ZWRITE(EXGLO,$G(QLSUB),$G(SUBNAME))
 D CLOSE^%ZISH("EXPORT")
 D EN^DDIOL("Wrote "_FN)
 QUIT
 ;
 ;
 ;
 ;
KRN(FAIL,KIDGLO,ROOT) ; Print OPT and KRN sections
 ; .FAIL - Output. Did we fail? Mostly b/c of filesystem issues.
 ; KIDGLO - The KIDS global (not a sub). Use $NA to pass this.
 ; ROOT - File system root where we are gonna export.
 N POP
 N ORD S ORD="" F  S ORD=$O(@KIDGLO@("ORD",ORD)) Q:ORD=""  D  Q:$G(POP)    ; For each item in ORD
 . N FNUM S FNUM=$O(@KIDGLO@("ORD",ORD,0))                                 ; File Number
 . N FNAM S FNAM=^(FNUM,0) ; **NAKED to above line**                       ; File Name
 . N PATH S PATH=ROOT_FNAM_$$D^XPDOS()                                    ; Path to export to
 . S POP=$$MKDIR^XPDOS(PATH)                                              ; Mk dir for the specific component
 . I POP D EN^DDIOL($$RED("Couldn't create directory")) S FAIL=1 QUIT      ;
 . D OPEN^%ZISH("ORD",PATH,"ORD.zwr","W")                                  ; Order Nodes
 . I POP S FAIL=1 QUIT                                                     ; Open failed
 . U IO                                                                    ;
 . D ZWRITE($NA(@KIDGLO@("ORD",ORD,FNUM)))                                 ; Zwrite the ORD node
 . D CLOSE^%ZISH("ORD")                                                    ; Done with ORD
 . D EN^DDIOL("Wrote ORD.zwr for "_FNAM)                                   ; Say so
 . K @KIDGLO@("ORD",ORD,FNUM)                                              ; KILL this entry
 . ;
 . N IENQL S IENQL=$QL($NA(@KIDGLO@("KRN",FNUM,0)))                        ; Where is the IEN sub?
 . N IEN F IEN=0:0 S IEN=$O(@KIDGLO@("KRN",FNUM,IEN)) Q:'IEN  D  Q:$G(POP)  ; For each Kernel component IEN
 . . N ENTRYNAME S ENTRYNAME=$P(@KIDGLO@("KRN",FNUM,IEN,0),U)              ; .01 for the component
 . . S ENTRYNAME=$TR(ENTRYNAME,"\/!@#$%^&*()?<>","---------------")              ; Replace punc with dashes
 . . D OPEN^%ZISH("ENT",PATH,ENTRYNAME_".zwr","W")                         ; Open file
 . . I POP S FAIL=1 QUIT
 . . U IO
 . . D ZWRITE($NA(@KIDGLO@("KRN",FNUM,IEN)),IENQL,"IEN") ; Zwrite, replacing the IEN with IEN
 . . I FNUM=.403 D FORM(KIDGLO,IEN,IENQL)                     ; Special processing for Forms
 . . I FNUM=8989.51 D PARM(KIDGLO,IEN,IENQL)                  ; Special processing for Parameters
 . . I FNUM=8989.52 D PARM2(KIDGLO,IEN,IENQL)                 ; Special processing for Parameter templates
 . . D CLOSE^%ZISH("ENT")                                     ; Done with this entry
 . . D EN^DDIOL("Exported "_ENTRYNAME_".zwr"_" in "_FNAM)     ; Export
 . . K @KIDGLO@("KRN",FNUM,IEN)                               ; KILL this entry
 QUIT
 ;
FORM(KIDGLO,IEN,IENQL) ; Export Blocks
 N I F I=0:0 S I=$O(@KIDGLO@("KRN",.403,IEN,40,I)) Q:'I  D                 ; Loop thourgh pages
 . N J F J=0:0 S J=$O(@KIDGLO@("KRN",.403,IEN,40,I,40,J)) Q:'J  D          ; Loop through blocks
 . . N Z S Z=^(J,0)                                                        ; zero node of block
 . . N BLNM1 S BLNM1=$P(Z,U)                                               ; its name
 . . N BLOCKIEN S BLOCKIEN=$$FNDBLK(KIDGLO,BLNM1)                          ; Block IEN
 . . I BLOCKIEN D                                                          ; if found, print it out and then
 . . . D ZWRITE($NA(@KIDGLO@("KRN",.404,BLOCKIEN)),IENQL,"IEN")
 . . . K @KIDGLO@("KRN",.404,BLOCKIEN)                                     ; delete block
 . ;
 . ;
 . ; Export Header block if there is one...
 . N P0 S P0=@KIDGLO@("KRN",.403,IEN,40,I,0)                               ; Page zero node
 . N HB S HB=$P(P0,U,2)                                                    ; Header block
 . I $L(HB) D                                                              ; If we have it
 . . N BLOCKIEN S BLOCKIEN=$$FNDBLK(KIDGLO,HB)                             ; Find its IEN in the Transport Global
 . . I BLOCKIEN D                                                          ; Print it out if we found it.
 . . . D ZWRITE($NA(@KIDGLO@("KRN",.404,BLOCKIEN)),IENQL,"IEN")            ;
 . . . K @KIDGLO@("KRN",.404,BLOCKIEN)                                     ; delete block
 QUIT
 ;
FNDBLK(KIDGLO,BLNM) ; $$; Find a block in the transport global; Return block IEN
 N SBN S SBN=""                                                   ; Searched block name
 N K F K=0:0 S K=$O(@KIDGLO@("KRN",.404,K)) Q:'K  D  Q:(SBN=BLNM)  ; Now loop through transported blocks
 . N Z S Z=^(K,0),SBN=$P(Z,U)                                     ; ...
 . Q:(SBN=BLNM)                                                   ; until we find the block with our name
 QUIT K
 ;
PARM(KIDGLO,IEN,IENQL) ; Export Parameter Definitions and Package level parameters exported by KIDS
 N PARMNM S PARMNM=$P(@KIDGLO@("KRN",8989.51,IEN,0),U)      ; Get the param name
 N PKGPARM D FNDPRM(.PKGPARM,KIDGLO,PARMNM)                 ; Find matching 8989.5 parameters
 N J F J=0:0 S J=$O(PKGPARM(J)) Q:'J  D                     ; for each one found
 . D ZWRITE($NA(@KIDGLO@("KRN",8989.5,J)),IENQL,"IEN")      ; print it out
 . K @KIDGLO@("KRN",8989.5,J)                               ; and then remove it.
 QUIT
 ;
FNDPRM(RTN,KIDGLO,PARMNM) ; Find exported parameters in 8989.5 in the transport global matching PARMNM
 ; Turns out there is more than 1... so we have to catch them all...
 N I F I=0:0 S I=$O(@KIDGLO@("KRN",8989.5,I)) Q:'I  D
 . N Z S Z=^(I,0) ; **NAKED TO ABOVE**
 . N THISNAME S THISNAME=$P(Z,U,2)
 . I THISNAME=PARMNM S RTN(I)=""
 QUIT
 ;
PARM2(KIDGLO,IEN,IENQL) ; Export Parameters in 8989.51 if sent as part of Parameter templates.
 N I F I=0:0 S I=$O(@KIDGLO@("KRN",8989.52,IEN,10,I)) Q:'I  D  ; for each parameter in the set
 . N PARMNM S PARMNM=$P(^(I,0),U,2)                            ; Get Parameter name
 . N P8989P51 S P8989P51=$$FNDPRM2(KIDGLO,PARMNM)              ; See if it is in 8989.51
 . I P8989P51 D                                                ; if so, print and delete from our global
 . . D ZWRITE($NA(@KIDGLO@("KRN",8989.51,P8989P51)),IENQL,"IEN")
 . . K @KIDGLO@("KRN",8989.51,P8989P51)
 QUIT
 ;
FNDPRM2(KIDGLO,PARMNM) ; $$ ; Find IEN of parameter in 8989.51 matching PARMNM
 N OUT S OUT=0
 N I F I=0:0 S I=$O(@KIDGLO@("KRN",8989.51,I)) Q:'I  D  Q:OUT
 . N NM S NM=$P(^(I,0),U)
 . I NM=PARMNM S OUT=I
 QUIT OUT
 ;
EXPKIDIN ; [PUBLIC] Procedure; Interactive dialog with User to export a single build
 N DIC
 N X,Y,DIRUT,DIROUT
 S DIC(0)="AEMQ",DIC=9.6,DIC("S")="I $P(^(0),U,3)'[12" D ^DIC
 N XPDFAIL S XPDFAIL=0
 I +Y>0 D EXPKID96(.XPDFAIL,+Y)
 QUIT
 ; 
EXPFILIN ; [PUBLIC] Procedure; Interactive export a build based on a file... can do multibuilds
 N DIR,DIRUT,DIROUT,X,Y,DTOUT,DA
 S DIR(0)="F^1:1000" S DIR("A")="Enter a file to import then break down" D ^DIR
 ;
 I $D(DIRUT)!($D(DTOUT)) QUIT
 ;
 G FY
 ;
F(Y) ; [Public] ; Non interactive version of exporting a file
 I ^%ZOSF("OS")["GT.M",$ZCMD'="" S Y=$ZCMD
FY ; ZEXCEPT: Y
 N DIQUIET D DT^DICRW K DIQUIET
 ;
 I Y="" QUIT
 ;
 ; Remove quotes. Single or double.
 N Q F Q="""","'" I $E(Y)=Q,$E(Y,$L(Y))=Q S Y=$E(Y,2,$L(Y)-1)
 ;
 N D S D=$$D^XPDOS()
 N DIR,FN
 I Y[D S DIR=$P(Y,D,1,$L(Y,D)-1),FN=$P(Y,D,$L(Y,D))
 E  S DIR=$$DEFDIR^%ZISH(),FN=Y
 ;
 ;
 K ^TMP("XPDK2VC-OUT",$J),^TMP("XPDK2VC-IN",$J)
 ;
 N % S %=$$FTG^%ZISH(DIR,FN,$NA(^TMP("XPDK2VC-IN",$J,1,0)),3)
 I '% W "FAILED",! QUIT
 K %
 ;
 D ANALYZE^XPDK2V1($NA(^TMP("XPDK2VC-OUT",$J)),$NA(^TMP("XPDK2VC-IN",$J)))
 ;
 N R S R=$NA(^TMP("XPDK2VC-OUT",$J))
 N PD S PD="" F  S PD=$O(@R@(PD)) Q:PD=""  D
 . N S S S=$NA(@R@(PD))
 . ; Stanza: Find $KID; quit if we can't find it. Otherwise, rem where it is.
 . N I,T F I=0:0 S I=$O(@S@(I)) Q:'I  S T=^(I) Q:($E(T,1,4)="$KID")
 . I T'["$KID" QUIT
 . N SVLN S SVLN=I ; Saved line
 . K T
 . ;
 . ; Get rid of the next two lines (**INSTALL NAME** and its value)
 . S SVLN=$O(@S@(SVLN))
 . S SVLN=$O(@S@(SVLN))
 . ;
 . K ^XTMP("K2VC")
 . S ^XTMP("K2VC",0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"KIDS to Version Control"
 . N L1,L2
 . N DONE S DONE=0
 . F  D  Q:DONE
 . . S L1=$O(@S@(SVLN))  ; first line
 . . N L1TXT S L1TXT=^(L1)                   ; its text 
 . . I $E(L1TXT,1,8)="$END KID" S DONE=1 QUIT  ; quit if we are at the end
 . . S L2=$O(@S@(L1))    ; second line
 . . N L2TXT S L2TXT=^(L2)                   ; its text
 . . S @("^XTMP(""K2VC"",""EXPORT"","_L1TXT)=L2TXT      ; Set our data into our global
 . . I $E(@S@(L2+1))'="""",$E(@S@(L2+1))'="$" S @("^XTMP(""K2VC"",""EXPORT"","_L1TXT)=@S@(L2+1) S L2=L2+1  ;temp 
 . . S SVLN=L2                                 ; move data pointer to last accessed one 
 . ;
 . N XPDFAIL S XPDFAIL=0
 . N SN S SN=$NA(^XTMP("K2VC","EXPORT")) ; Short name... I am tired of typing.
 . D EXPORT(.XPDFAIL,SN,DIR)
 . I XPDFAIL D EN^DDIOL($$RED("A failure has occured"))
 QUIT
 ;
EXPKID96(XPDFAIL,XPDA) ; [PUBLIC] Procedure; Export a KIDS file using Build file definition
 ; .XPDFAIL - Did we fail?
 ; XPDA - Build file IEN
 ; TODO: clean up!!! 
 ;
 S XPDFAIL=0 
 N Z S Z=$G(^XPD(9.6,XPDA,0))
 I 12[$P(Z,U,3) QUIT  ; Multi or Global package; can't do!!! I am fricking primitive.
 ; 
 ; Most of the lines below are copied from KIDS
 ;XPDI=name^1=use current transport global
 N XPDERR,XPDGREF,XPDNM,XPDVER  
 N XPDI S XPDI=$P(Z,U)_U
 N XPDT S XPDT=0 
 D PCK^XPDT(XPDA,XPDI)  ; Builds XPDT data structures
 S $P(XPDT(1),U,5)=1 ; Don't send package application history (PAH)
 ;  
 S XPDA=XPDT(1),XPDNM=$P(XPDA,U,2) D  G:$D(XPDERR) ABORT^XPDT 
 . W !?5,XPDNM,"..." S XPDGREF="^XTMP(""XPDT"","_+XPDA_",""TEMP"")"
 . ; if package file link then set XPDVER=version number^package name 
 . S XPDA=+XPDA,XPDVER=$S($P(^XPD(9.6,XPDA,0),U,2):$$VER^XPDUTL(XPDNM)_U_$$PKG^XPDUTL(XPDNM),1:"")
 . ;Inc the Build number
 . S $P(^XPD(9.6,XPDA,6.3),U)=$G(^XPD(9.6,XPDA,6.3))+1
 . K ^XTMP("XPDT",XPDA)
 . 
 . N X F X="DD^XPDTC","KRN^XPDTC","QUES^XPDTC","INT^XPDTC","BLD^XPDTC" D @X Q:$D(XPDERR)
 . D:'$D(XPDERR) PRET^XPDT 
 W !! F XPDT=1:1:XPDT W "Transport Global ^XTMP(""XPDT"","_+XPDT(XPDT)_") created for ",$P(XPDT(XPDT),U,2),!
 N XPDFAIL
 K ^XTMP("K2VC")
 S ^XTMP("K2VC",0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"KIDS to Version Control"
 M ^XTMP("K2VC","EXPORT")=^XTMP("XPDT",+XPDT(XPDT))
 D EXPORT^XPDK2VC(.XPDFAIL,$NA(^XTMP("K2VC","EXPORT")),$$DEFDIR^%ZISH()) 
 K ^XTMP("XPDT",+XPDT(XPDT)),^XTMP("K2VC")
 QUIT
 ;
ZWRITE(NAME,QS,QSREP) ; Replacement for ZWRITE ; Public Proc
 ; ZEXCEPT: XPDK2V0,ZWRITE0
 GOTO ZWRITE0^XPDK2V0 ; Moved to extension routine for size
 ;
RED(X) ; Convenience method for Sam to see things on the screen.
 Q $C(27)_"[41;1m"_X_$C(27)_"[0m"
 ;
TEST D EN^%ut($T(+0),1,1) QUIT
 ;
T4 ; @TEST Export components from KIDS itself - TIU
 ; Loop through all the TIU patches
 N XPDFAIL S XPDFAIL=0
 N XPDI S XPDI="TIU"
 F  S XPDI=$O(^XPD(9.6,"B",XPDI)) Q:($P(XPDI,"*")'="TIU")  D
 . N XPDA S XPDA=$O(^(XPDI,""))
 . D EXPKID96(.XPDFAIL,XPDA)
 . I XPDFAIL D FAIL^%ut("Last export didn't work")  
 QUIT 
 ;
T5 ; @TEST Export components from KIDS itself - MAG
 ; Loop through all the TIU patches
 N XPDFAIL S XPDFAIL=0
 N XPDI S XPDI="MAG"
 F  S XPDI=$O(^XPD(9.6,"B",XPDI)) Q:($P(XPDI,"*")'="MAG")  D
 . N XPDA S XPDA=$O(^(XPDI,""))
 . D EXPKID96(.XPDFAIL,XPDA)
 . I XPDFAIL D FAIL^%ut("Last export didn't work")  
 QUIT 
 ;
ASSERT(X,Y) ; Internal assertion function
 ; ZEXCEPT: %ut
 I $D(%ut) D CHKTF^%ut(X,$G(Y)) 
 E  I 'X S $EC=",U-ASSERTION-FAILED,"
 QUIT
