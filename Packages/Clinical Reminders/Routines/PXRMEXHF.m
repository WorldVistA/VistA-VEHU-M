PXRMEXHF ;SLC/PKR - Routines to select and deal with host files. ;07/08/2020
 ;;2.0;CLINICAL REMINDERS;**12,17,18,26,74**;Feb 04, 2005;Build 5
 ;================
CHF(SUCCESS,LIST,PATH,FILE) ;Put the repository entries in LIST into the
 ;host file specified by PATH and FILE.
 N IND,GBL,LEN,LNUM,RIEN
 S SUCCESS=1
 S LNUM=$P(LIST,",",1)
 I LNUM="" Q
 S RIEN=$$RIEN^PXRMEXU1(LNUM)
 S GBL="^PXD(811.8,"_RIEN_",100,1,0)"
 ;Save the first entry.
 S SUCCESS(LNUM)=$$GTF^%ZISH(GBL,4,PATH,FILE)
 I SUCCESS(LNUM)=0 Q
 S LEN=$L(LIST,",")-1
 I LEN=1 Q
 ;Append any remaining entries.
 F IND=2:1:LEN D
 . S LNUM=$P(LIST,",",IND)
 . S RIEN=$$RIEN^PXRMEXU1(LNUM)
 . S GBL="^PXD(811.8,"_RIEN_",100,1,0)"
 . S SUCCESS(LNUM)=$$GATF^%ZISH(GBL,4,PATH,FILE)
 Q
 ;
 ;================
GETEHF(EXT,DPATH) ;Get an existing host file.
 ;Build a list of all .EXT files in the current directory.
 N DEXT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILESPEC,FILELIST,PATH,X,Y
 I EXT="" D
 . S DIR(0)="FAU"_U_"1:32"
 . S DIR("A")="Enter a file extension: "
 . S DIR("?")="A file specification has the format name.extension."
 . D ^DIR
 . S EXT=Y
 I $D(DIRUT) Q ""
 S DEXT="*."_EXT
 S FILESPEC(DEXT)=""
 S PATH=$S($G(DPATH)'="":DPATH,1:$$PWD^%ZISH)
 S DIR(0)="FAU"_U_"1:32"
 S DIR("A")="Enter a path: "
 S DIR("B")=PATH
 S DIR("?",1)="A host file is a file on your host system."
 S DIR("?",2)="A complete host file consists of a path, file name, and extension."
 S DIR("?",3)="A path consists of a device and directory name."
 I $G(EXT)'="" S DIR("?",4)="The default extension is "_EXT_"."
 S DIR("?")="The default path is "_PATH
 D ^DIR
 I $D(DIRUT) Q ""
 S PATH=Y
 S Y=$$LIST^%ZISH(PATH,"FILESPEC","FILELIST")
 I Y D
 . W !,"The following "_EXT_" files were found in ",PATH
 . S FILE=""
 . F  S FILE=$O(FILELIST(FILE)) Q:FILE=""  W !,?2,FILE
 E  W !,"No "_EXT_" files were found in path ",PATH
 ;
 K DIR,X,Y
 S DIR(0)="FAOU"_U_"1:32"
 S DIR("A")="Enter a file name: "
 S DIR("?",1)="A file name has the format NAME.EXTENSION, the default extension is "_EXT
 S DIR("?",2)="Therefore if you type in FILE for the file name, the host file will be"
 S DIR("?")="  "_PATH_"FILE."_EXT
 D ^DIR
 I $D(DIRUT) Q ""
 S FILE=Y
 ;Add the default extension if there isn't one.
 I FILE'["." S FILE=FILE_"."_EXT
 Q PATH_U_FILE
 ;
 ;================
GETHFN(EXT) ;Get the name of a host file to store repository entries in.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILE,HFNAME,PATH,X,Y
GETHF ;As a default set the path to the current directory.
 S PATH=$$PWD^%ZISH
 S DIR(0)="FAU"_U_"1:32"
 S DIR("A")="Enter a path: "
 S DIR("B")=PATH
 S DIR("?",1)="A host file is a file on your host system."
 S DIR("?",2)="A complete host file consists of a path, file name, and extension."
 S DIR("?",3)="A path consists of a device and directory name."
 I $G(EXT)'="" S DIR("?",4)="The default extension is "_EXT_"."
 S DIR("?")="The default path is "_PATH
 D ^DIR
 I $D(DIRUT) Q 0
 S PATH=Y
 K DIR,X,Y
 S DIR(0)="FAU"_U_"1:32"
 S DIR("A")="Enter a file name: "
 I $G(EXT)'="" D
 . S DIR("?",1)="A file name has the format NAME.EXTENSION, the default extension is "_EXT
 . S DIR("?",2)="Therefore if you type in FILE for the file name, the host file will be"
 . S DIR("?")="  "_PATH_"FILE."_EXT
 E  D
 . S DIR("?",1)="A file name has the format NAME.EXTENSION"
 . S DIR("?")="There is no default extension so you must input the complete file name."
 D ^DIR
 I $D(DIRUT) Q 0
 S FILE=Y
 ;Add the default extension if there isn't one.
 I FILE'["." S FILE=FILE_"."_EXT
 I $P(FILE,".",2)="" W !,"The file name must include an extension." G GETHF
 S HFNAME=PATH_FILE
 S DIR(0)="YAO"
 S DIR("A")="Host file is "_HFNAME_" is this correct?: "
 S DIR("B")="Y"
 K X,Y
 D ^DIR
 I $D(DIRUT) Q 0
 I 'Y G GETHF
 Q PATH_U_FILE
 ;
 ;================
LHF(SUCCESS,PATH,FILE) ;Load a host file containing exchange entries into
 ;the Exchange file.
 N GBL
 K ^TMP($J,"EXHF")
 S GBL="^TMP($J,""EXHF"",1,1)"
 S GBL=$NA(@GBL)
 S SUCCESS=$$FTG^%ZISH(PATH,FILE,GBL,3)
 I 'SUCCESS Q
 ;Make sure it has the correct format.
 I (^TMP($J,"EXHF",1,1)'["xml")!(^TMP($J,"EXHF",2,1)'="<REMINDER_EXCHANGE_FILE_ENTRY>") D  Q
 . W !,"This host file does not have the correct format!"
 . H 2
 . S SUCCESS=0
 . K ^TMP($J,"EXHF")
 W !,"Loading host file ",PATH,FILE
 D LTMP(.SUCCESS,"EXHF")
 Q
 ;
 ;================
LTMP(SUCCESS,NODE) ;Load the contents of ^TMP($J,NODE) into the Exchange
 ;file. The format is ^TMP($J,NODE,NUM,1)=data
 N CURRL,CSUM,DATEP,DONE,EXIEN,EXTYPE,FDA,IENROOT,IND,LINE
 N MSG,NENTRY,NLINES,RETMP,RNAME,SITE,SOURCE,SSOURCE,US,USER,VRSN
 S RETMP="^TMP($J,""EXLHF"")"
 S (CURRL,DONE,NENTRY,NLINES,SSOURCE)=0
 F  Q:DONE  D
 . S CURRL=CURRL+1
 . I '$D(^TMP($J,NODE,CURRL,1)) S DONE=1 Q
 . S LINE=^TMP($J,NODE,CURRL,1)
 .;Look for overflow lines.
 . S IND=0
 . F  S IND=$O(^TMP($J,NODE,CURRL,"OVF",IND)) Q:IND=""  S LINE=LINE_^TMP($J,NODE,CURRL,"OVF",IND)
 . S NLINES=NLINES+1
 . S ^TMP($J,"EXLHF",NLINES,0)=LINE
 . I LINE["<PACKAGE_VERSION>" S VRSN=$$GETTAGV^PXRMEXU3(LINE,"<PACKAGE_VERSION>")
 . I LINE["<EXCHANGE_TYPE>" S EXTYPE=$$GETTAGV^PXRMEXU3(LINE,"<EXCHANGE_TYPE>",1)
 . I LINE="<SOURCE>" S SSOURCE=1
 . I SSOURCE D
 .. I LINE["<NAME>" S RNAME=$$GETTAGV^PXRMEXU3(LINE,"<NAME>",1)
 .. I LINE["<USER>" S USER=$$GETTAGV^PXRMEXU3(LINE,"<USER>",1)
 .. I LINE["<SITE>" S SITE=$$GETTAGV^PXRMEXU3(LINE,"<SITE>",1)
 .. I LINE["<DATE_PACKED>" S DATEP=$$GETTAGV^PXRMEXU3(LINE,"<DATE_PACKED>")
 . I LINE="</SOURCE>" D
 .. S SSOURCE=0
 .. S SOURCE=USER_" at "_SITE
 .;See if the entry is loaded into the temporary storage.
 . I LINE="</REMINDER_EXCHANGE_FILE_ENTRY>" D
 .. S NLINES=0
 .. S NENTRY=NENTRY+1
 ..;Make sure it has the correct format.
 .. I (^TMP($J,"EXLHF",1,0)'["xml")!(^TMP($J,"EXLHF",2,0)'="<REMINDER_EXCHANGE_FILE_ENTRY>") D  Q
 ... W !,"There is a problem reading this .prd file, try a new copy of it."
 ... S SUCCESS=0
 ... H 2
 ..;Make sure this entry does not already exist.
 .. S EXIEN=$$REXISTS^PXRMEXIU(RNAME,DATEP)
 .. I EXIEN>0 D
 ... W !,RNAME
 ... W !,"with a date packed of ",DATEP
 ... W !,"is already in the Exchange File, it will not be added again."
 ... S SUCCESS(NENTRY)=EXIEN_"A"
 ... H 2
 .. E  D
 ... K FDA,IENROOT
 ... S FDA(811.8,"+1,",.01)=RNAME
 ... S FDA(811.8,"+1,",.02)=SOURCE
 ... S FDA(811.8,"+1,",.03)=DATEP
 ... D UPDATE^PXRMEXPU(.US,.FDA,.IENROOT)
 ... S SUCCESS(NENTRY)=US
 ...;Create the description and save the data.
 ... N DESCT,DESL,KEYWORDT
 ... D DESC^PXRMEXU3(RETMP,.DESCT)
 ... D KEYWORD^PXRMEXU3(RETMP,.KEYWORDT)
 ... S DESL("RNAME")=RNAME,DESL("SOURCE")=SOURCE,DESL("DATEP")=DATEP
 ... S DESL("VRSN")=VRSN
 ... D DESC^PXRMEXU1(IENROOT(1),.DESL,"DESCT","KEYWORDT")
 ... M ^PXD(811.8,IENROOT(1),100)=^TMP($J,"EXLHF")
 ... W !,"Added Reminder Exchange entry ",RNAME H 2
 .. K ^TMP($J,"EXLHF")
 ;
 ;Check the success of the entry installs.
 K ^TMP($J,NODE),^TMP($J,"EXLHF")
 ;If no entries were created there was a problem.
 I NENTRY=0 S SUCCESS=0 Q
 S SUCCESS=1
 S IND=""
 F  S IND=$O(SUCCESS(IND)) Q:+IND=0  D
 . I 'SUCCESS(IND) S SUCCESS=0 Q
 Q
 ;
