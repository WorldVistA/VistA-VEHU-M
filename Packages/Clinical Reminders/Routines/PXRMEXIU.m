PXRMEXIU ;SLC/PKR/PJH - Utilities for installing repository entries. ;03/30/2018
 ;;2.0;CLINICAL REMINDERS;**4,6,12,17,18,24,26,47,45**;Feb 04, 2005;Build 566
 ;===================
DEF(FDA,NAMECHG) ;Check the reminder definition to make sure the related
 ;reminder exists and all the findings exist.
 N ABBR,ALIST,IEN,IENS,FILENUM,FINDING,LRD,OFINDING,PT01
 N RNAME,RRG,SPONSOR,TEXT,VERSN
 S IENS=$O(FDA(811.9,""))
 ;Related reminder guideline field 1.4.
 I $D(FDA(811.9,IENS,1.4)) D
 . S RRG=FDA(811.9,IENS,1.4)
 . S IEN=$$EXISTS^PXRMEXIU(811.9,RRG)
 . I IEN=0 D
 ..;Get replacement.
 .. N DIC,X,Y
 .. S TEXT(1)=" "
 .. S TEXT(2)="The Related Reminder Guideline does not exist on your system!"
 .. S TEXT(3)="It is "_RRG_" input a replacement or ^ to leave it empty."
 .. D MES^XPDUTL(.TEXT)
 ..;If this is being called during a KIDS install we need echoing on.
 .. I $D(XPDNM) X ^%ZOSF("EON")
 .. S DIC=811.9,DIC(0)="AEMQ"
 .. D ^DIC
 .. I $D(XPDNM) X ^%ZOSF("EOFF")
 .. I Y=-1 K FDA(811.9,IENS,1.4)
 .. E  S FDA(811.9,IENS,1.4)=$P(Y,U,2)
 ;
 ;Sponsor field 101.
 I $D(FDA(811.9,IENS,101)) D
 . S SPONSOR=FDA(811.9,IENS,101)
 . S IEN=$$FIND1^DIC(811.6,"","U",SPONSOR)
 . I IEN=0 D
 ..;Get replacement.
 .. N DIC,X,Y
 .. S TEXT(1)=" "
 .. S TEXT(2)="The Sponsor does not exist on your system!"
 .. S TEXT(3)="It is "_SPONSOR_" input a replacement or ^ to leave it empty."
 .. D MES^XPDUTL(.TEXT)
 ..;If this is being called during a KIDS install we need echoing on.
 .. I $D(XPDNM) X ^%ZOSF("EON")
 .. S DIC=811.6,DIC(0)="AEMQ"
 .. D ^DIC
 .. I $D(XPDNM) X ^%ZOSF("EOFF")
 .. I Y=-1 K FDA(811.9,IENS,101)
 .. E  S FDA(811.9,IENS,101)=$P(Y,U,2)
 ;
 ;Linked reminder dialog field 51.
 S LRD=$G(FDA(811.9,IENS,51))
 S RNAME=$G(FDA(811.9,IENS,.01))
 I LRD'="",RNAME'="" S ^TMP("PXRMEXDL",$J,LRD,RNAME)=""
 S IEN=$S(LRD="":0,1:+$O(^PXRMD(801.41,"B",LRD,"")))
 I IEN=0 K FDA(811.9,IENS,51)
 ;
 ;Search the finding multiple for replacements and missing findings.
 D SFMVPI(.FDA,.NAMECHG,811.902)
 S VERSN=$$GETTAGV^PXRMEXU3(^PXD(811.8,PXRMRIEN,100,3,0),"<PACKAGE_VERSION>")
 I VERSN=1.5 D CEFD^PXRMDATE(.FDA)
 Q
 ;
 ;===================
DELFIND(SFN,IENS,FDA) ;Delete a finding from the FDA.
 N IENSD,SFND
 S SFND=""
 F  S SFND=$O(FDA(SFND)) Q:SFND=""  D
 . S IENSD=""
 . F  S IENSD=$O(FDA(SFND,IENSD)) Q:IENSD=""  I IENSD[IENS K FDA(SFND,IENSD)
 K FDA(SFN,IENS)
 Q
 ;
 ;===================
EDU(FDA,EDULIST) ;Education Topics special handling. Add national education
 ;topics to EDULIST.
 N CDEF,IENS,MSG
 S IENS=$O(FDA(9999999.09,""))
 I IENS="" Q
 S EDULIST(FDA(TOPFNUM,IENS,.01))=""
 ;If the Class field exists, make sure there is a value for it
 ;in the FDA.
 I $G(FDA(9999999.09,IENS,100))'="" D  Q
 . I FDA(9999999.09,IENS,100)="NATIONAL" S EDULIST(FDA(TOPFNUM,IENS,.01))=""
 S CDEF=$S($$GET1^DID(9999999.09,100,"","LABEL","","MSG")="CLASS":1,1:0)
 I 'CDEF Q
 S FDA(9999999.09,IENS,100)=$S($G(PXRMNAT):"NATIONAL",1:"LOCAL")
 I FDA(9999999.09,IENS,100)="NATIONAL" S EDULIST(FDA(TOPFNUM,IENS,.01))=""
 Q
 ;
 ;===================
EXAM(FDA) ;Check the health factor to make sure a category does not
 ;have a category.
 N CDEF,IENS,MSG
 S IENS=$O(FDA(9999999.15,""))
 I IENS="" Q
 ;If the Class field exists, make sure there is a value for it
 ;in the FDA.
 I $G(FDA(9999999.15,IENS,100))'="" Q
 S CDEF=$S($$GET1^DID(9999999.15,100,"","LABEL","","MSG")="CLASS":1,1:0)
 I 'CDEF Q
 S FDA(9999999.15,IENS,100)=$S($G(PXRMNAT):"NATIONAL",1:"LOCAL")
 Q
 ;
 ;===================
EXISTS(FILENUM,NAME,FLAG) ;Check for existence of an entry with the
 ;same name. Return 0 for null name. If FLAG="W" then if necessary
 ;display the warning message.
 I NAME="" Q 0
 ;Return the IEN if it does, 0 otherwise.
 N IEN,MSG
 I FILENUM=0 S IEN=$$EXISTS^PXRMEXCF(NAME) Q
 N FLAGS,RESULT,SCREEN
 S RESULT=NAME
 ;Special lookup for files 80 and 80.1, they do not have a standard "B"
 ;cross-reference.
 I (FILENUM=80)!(FILENUM=80.1) D
 .;Name may or may not have the necessary space appended, make sure
 .;it does.
 . S RESULT=$S($E(NAME,$L(NAME))'=" ":NAME_" ",1:NAME)
 . S FLAGS="MX"
 E  S FLAGS="BXU"
 ;File 8927.1 only allows upper case .01s.
 I FILENUM=8927.1 S RESULT=$$UP^XLFSTR(NAME)
 S SCREEN=$S(FILENUM=50.6:"I $$VAGENSCR^PXRMEXIU(Y)",1:"")
 S IEN=$$FIND1^DIC(FILENUM,"",FLAGS,RESULT,"",SCREEN,"MSG")
 I +IEN>0 Q IEN
 ;If IEN is null then there was an error try FIND^DIC.
 N IND,FILENAME,LIST,MLIST,NFOUND,NMATCH,TEXT
 K MSG
 D FIND^DIC(FILENUM,"","",FLAGS,NAME,"","",SCREEN,"","LIST","MSG")
 I $D(MSG) D  Q 0
 . K TEXT
 . S TEXT(1)=""
 . S TEXT(2)="Cannot install the entry named "_NAME
 . S TEXT(3)="In file number "_FILENUM
 . S TEXT(4)="For the reason see the error message below."
 . S TEXT(5)=""
 . D EN^DDIOL(.TEXT)
 . D AWRITE^PXRMUTIL("MSG")
 . H 2
 S NFOUND=+$P(LIST("DILIST",0),U,1)
 I NFOUND=0 Q 0
 I NFOUND=1 Q LIST("DILIST",2,1)
 ;Multiple entries with the same name found, search for a match with
 ;the .01.
 S NMATCH=0
 F IND=1:1:NFOUND D
 . I LIST("DILIST",1,IND)=NAME S NMATCH=NMATCH+1,MLIST(NMATCH)=IND
 I NMATCH=1 Q LIST("DILIST",2,MLIST(1))
 I NMATCH=0 Q 0
 ;If FLAG="W" display the warning message, return the first entry on 
 ;the list and quit.
 I (NMATCH>1),$G(FLAG)="W" D  Q LIST("DILIST",2,1)
 . S FILENAME=$$GET1^DID(FILENUM,"","","NAME")
 . K TEXT
 . S TEXT(1)=""
 . S TEXT(2)="Warning there are "_NMATCH_" "_FILENAME_" entries with the name "_NAME_"!"
 . S TEXT(3)="If this is used as a finding, and it is not resolved by FileMan during"
 . S TEXT(4)="installation, any component using this finding will not install."
 . D EN^DDIOL(.TEXT)
 . H 3
 ;If FLAG is not "W" prompt the user for the replacement.
 I NMATCH>1 S IEN=$$GETIEN^PXRMEXU0(NMATCH,.LIST)
 Q IEN
 ;
 ;===================
GETACT(CHOICES,DIR) ;Get the action
 ;If CHOICES is empty the only action is skip.
 I CHOICES="" Q "S"
 N DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="S"_U
 I CHOICES["C" S DIR(0)=DIR(0)_"C:Create a new entry by copying to a new name"
 I CHOICES["D" S DIR(0)=DIR(0)_";D:Delete"
 I CHOICES["I" S DIR(0)=DIR(0)_";I:Install"
 I CHOICES["M" S DIR(0)=DIR(0)_";M:Merge findings"
 I CHOICES["O" S DIR(0)=DIR(0)_";O:Overwrite the current entry"
 I CHOICES["P" S DIR(0)=DIR(0)_";P:Replace with an existing entry"
 I CHOICES["U" S DIR(0)=DIR(0)_";U:Update"
 I CHOICES["Q" S DIR(0)=DIR(0)_";Q:Quit the install"
 I CHOICES["R" S DIR(0)=DIR(0)_";R:Restart"
 I CHOICES["S" S DIR(0)=DIR(0)_";S:Skip, do not install this entry"
 ;If this is being called during a KIDS install we need echoing on.
 I $D(XPDNM) X ^%ZOSF("EON")
 D ^DIR
 I $D(XPDNM) X ^%ZOSF("EOFF")
 I $D(DIROUT)!$D(DIRUT) S Y="S"
 I $D(DTOUT)!($D(DUOUT)) S Y="S"
 Q Y
 ;
 ;===================
GETNAME(MIN,MAX) ;Get a name to use.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="FAOU"_U_MIN_":"_MAX
 S DIR("A")="Input the new name: "
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) Q ""
 I $D(DTOUT)!$D(DUOUT) Q ""
 Q Y
 ;
 ;===================
GETUNAME(ATTR) ;Get a unique name to use, ATTR holds the attributes.
 N IEN,NEWPT01,TEXT
GNEW S NEWPT01=$$GETNAME(ATTR("MIN FIELD LENGTH"),ATTR("FIELD LENGTH"))
 S IEN=+$$EXISTS(ATTR("FILE NUMBER"),NEWPT01)
 I IEN>0 D  G GNEW
 . S TEXT(1)=ATTR("FILE NAME")_" entry "_NEWPT01_" already exists."
 . S TEXT(2)="Input a different name or type <ENTER> to quit."
 . D EN^DDIOL(.TEXT)
 E  S ATTR("NAME")=NEWPT01
 Q NEWPT01
 ;
 ;===================
HF(FDA) ;Health factor special handling.
 N CDEF,IENS,MSG
 S IENS=$O(FDA(9999999.64,""))
 I IENS="" Q
 ;Make sure a category does not have a category.
 I FDA(9999999.64,IENS,.1)="CATEGORY" K FDA(9999999.64,IENS,.03)
 ;If the Class field exists, make sure there is a value for it
 ;in the FDA.
 I $G(FDA(9999999.64,IENS,100))'="" Q
 S CDEF=$S($$GET1^DID(9999999.64,100,"","LABEL","","MSG")="CLASS":1,1:0)
 I 'CDEF Q
 S FDA(9999999.64,IENS,100)=$S($G(PXRMNAT):"NATIONAL",1:"LOCAL")
 Q
 ;
 ;===================
REXISTS(NAME,DATEP) ;See if this Exchange File entry already exists.
 N IEN,LUVALUE
 S LUVALUE(1)=NAME
 S LUVALUE(2)=DATEP
 S IEN=+$$FIND1^DIC(811.8,"","KU",.LUVALUE)
 Q IEN
 ;
 ;===================
SFMVPI(FDA,NAMECHG,SFN) ;Search a variable pointer list for items that do not
 ;exist and prompt the user for a replacement. Works for definitions,
 ;terms, and health summary types.
 N ABBR,ACTION,ALIST,DIR,IEN,IENS,FILENUM,FINDING,HSUB,OFINDING,PT01
 N REPFI,TYPE
 ;Search the finding multiple for replacements and missing findings.
 S HSUB=$S(SFN=142.14:"HSTI",SFN=811.52:"TRMF",1:"DEFF")
 S TYPE=$S(SFN=142.14:"Selection item",1:"Finding")
 D BLDALIST^PXRMVPTR(SFN,.01,.ALIST)
 S (ACTION,IENS)=""
 F  S IENS=$O(FDA(SFN,IENS)) Q:(IENS="")!(ACTION="Q")  D
 . S (FINDING,OFINDING)=FDA(SFN,IENS,.01)
 . S ABBR=$P(FINDING,".",1)
 . S PT01=$P(FINDING,".",2)
 . S FILENUM=$P(ALIST(ABBR),U,1)
 . I $D(NAMECHG(FILENUM,PT01)) D
 .. S FINDING=ABBR_"."_NAMECHG(FILENUM,PT01)
 .. S FDA(SFN,IENS,.01)=FINDING
 . S IEN=+$$VFIND1(FINDING,.ALIST)
 . I IEN>0 S FDA(SFN,IENS,.01)=ABBR_".`"_IEN,REPFI=""
 .;Check if a replacement already exists.
 . I IEN=0 S REPFI=$G(^TMP($J,"PXRM FINDING REPLACE",FINDING))
 . I REPFI'="" S (FINDING,FDA(SFN,IENS,.01))=REPFI
 . I (IEN=0),(REPFI="") D
 ..;Get replacement
 .. N DIC,DUOUT,ROOT,TEXT,X,Y,YY
 .. S TEXT(1)=TYPE_" "_FINDING_" does not exist, what do you want to do?"
 .. D BMES^XPDUTL(.TEXT)
 .. S ACTION=$$GETACT^PXRMEXIU("DPQ",.DIR)
 .. I ACTION="Q" K FDA Q
 .. I ACTION="D" D DELFIND(SFN,IENS,.FDA) Q 
 .. S DIC=FILENUM
 .. S ROOT=$P($$ROOT^DILFD(FILENUM),U,2)
 .. S DIC("S")="S YY=Y_"";""_ROOT I $$VFINDING^PXRMINTR(YY)"
 .. S DIC(0)="AEMNQ"
 .. S Y=-1
 .. F  Q:+Y'=-1  D
 ...;If this is being called during a KIDS install we need echoing on.
 ... I $D(XPDNM) X ^%ZOSF("EON")
 ... D ^DIC
 ... I $D(XPDNM) X ^%ZOSF("EOFF")
 ... I $D(DUOUT) D
 .... S Y=""
 .... K FDA
 .. I Y="" K FDA(SFN,IENS)
 .. E  D
 ... S REPFI=ABBR_"."_$P(Y,U,2)
 ... S FDA(SFN,IENS,.01)=REPFI
 ... S ^TMP($J,"PXRM FINDING REPLACE",FINDING)=REPFI
 .;Save the finding information for the history.
 . S ^TMP("PXRMEXIA",$J,HSUB,$P(IENS,",",1),OFINDING)=FINDING
 Q
 ;
 ;===================
TIUOBJ(FDA) ;Resolve the name of the health summary object.
 N COWN,END,HSOBJIEN,IENS,START,TEMP
 S IENS=$O(FDA(8925.1,""))
 S TEMP=$G(FDA(8925.1,IENS,9))
 I TEMP'["TIU^GMTSOBJ" Q
 S START=$F(TEMP,"DFN,")
 S END=$L(TEMP)-1
 S TEMP=$E(TEMP,START,END)
 S HSOBJIEN=$O(^GMT(142.5,"B",TEMP,""))
 I HSOBJIEN="" D  Q
 . N TEXT
 . S TEXT(1)="Health Summary Object "_TEMP_" does not exist."
 . S TEXT(2)="It must be installed before this TIU Health Summary Object can be installed."
 . S TEXT(3)="Please go back and install it, making sure the corresponding Health Summary"
 . S TEXT(4)="Type has been installed first."
 . S TEXT(5)=" "
 . I '$D(XPDNM) D EN^DDIOL(.TEXT)
 . I $D(XPDNM) D BMES^XPDUTL(.TEXT)
 ;Make sure either the Personal Owner (.05) or Class Owner (.06) is set.
 ;If CLINICAL COORDINATOR is defined use it as the Class Owner.
 S COWN=+$$EXISTS(8930,"CLINICAL COORDINATOR")
 I COWN=0 S FDA(8925.1,IENS,.05)="`"_DUZ
 I COWN>0 S FDA(8925.1,IENS,.06)="`"_COWN
 S FDA(8925.1,IENS,9)="S X=$$TIU^GMTSOBJ(DFN,"_HSOBJIEN_")"
 S FDA(8925.1,IENS,99)=$H
 Q
 ;
 ;===================
VAGENSCR(IEN) ;Screen for VA Generic, file #50.6, return true only for
 ;active entries.
 N OK
 ;DBIA #4540
 D ZERO^PSN50P6(IEN,"",1,"","LIST")
 ;If ^TMP($J,"LIST",IEN,1) is null then then entry is active.
 S OK=$S(^TMP($J,"LIST",IEN,1)="":1,1:0)
 K ^TMP($J,"LIST")
 Q OK
 ;
 ;===================
VDLGFIND(ABBR,IEN,ALIST) ;Determine if the finding item associated with a
 ;reminder dialog is active. Returns a 1 if it is active otherwise
 ;returns a 0.
 N FILENUM
 S FILENUM=$P(ALIST(ABBR),U,1)
 Q $$FILESCR^PXRMDLG6(IEN,FILENUM)
 ;
 ;===================
VFIND1(VPTR,ALIST) ;Given a variable pointer of the form ABBR.NAME
 ;and ALIST which contains the link between abbreviations and files
 ;return the IEN if it exists and 0 if no match if found.
 N ABBR,IEN,FILENUM,PT01,RESULT
 S IEN=0
 S ABBR=$P(VPTR,".",1)
 S PT01=$P(VPTR,".",2,99)
 S FILENUM=$P(ALIST(ABBR),U,1)
 S IEN=$$EXISTS(FILENUM,PT01)
 Q IEN
 ;
