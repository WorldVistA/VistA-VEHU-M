PXRMDLGBREPAIR ;SLC/PKR - Utilities for correcting dialog duplicates. ;05/31/2024
 ;;2.0;CLINICAL REMINDERS;**88**;Feb 04, 2005;Build 13
 Q
 ;
 ;===============================
CORRUPTED(IEN) ;Handle corrupted entries.
 N INBINDEX,MSG,NAME,NREFS,TESTIEN,TEXT
 K ^TMP("PXRMMSG",$J)
 S MSG=$NA(^TMP("PXRMMSG",$J))
 ;Find the number of references to this entry.
 D CHKPT^DIUTL(801.41,IEN,MSG,0)
 S NREFS=^TMP("PXRMMSG",$J,0)
 K ^TMP("PXRMMSG",$J)
 I NREFS>0 D  Q
 . S TEXT(1)=""
 . S TEXT(2)="File #801.41 IEN="_IEN
 . S TEXT(3)="is corrupted, it is referenced "_NREFS_$S(NREFS=1:" time.",1:" times.")
 . S TEXT(4)="Therefore it needs to be repaired by hand."
 . S TEXT(5)="If you need help repairing it, enter a ticket."
 . D BMES^XPDUTL(.TEXT)
 ;
 ;See if this entry is in the "B" index.
 S INBINDEX=0,NAME=""
 F  Q:(INBINDEX=1)  S NAME=$O(^PXRMD(801.41,"B",NAME)) Q:NAME=""  D
 . S TESTIEN=$O(^PXRMD(801.41,"B",NAME,""))
 . I TESTIEN=IEN S INBINDEX=1
 ;
 I NREFS=0 D
 . K ^PXRMD(801.41,IEN)
 . I INBINDEX K ^PXRMD(801.41,"B",NAME,IEN)
 . K TEXT
 . S TEXT(1)=""
 . S TEXT(2)="File #801.41 IEN="_IEN
 . S TEXT(3)="was corrupted, and was not being used."
 . S TEXT(4)="It has been deleted."
 . D BMES^XPDUTL(.TEXT)
 Q
 ;
 ;===============================
DUPFIX ;Check for duplicates and resolve them.
 N CHAR,CLOGSFN,CLOGTEXT,DIK,DUPLIST,FDA,IEN,IND
 N KEEPIEN,KEEPNAME,LASTEDITDATE,LEN,MSG,NAME,NDUP,NENTRIES
 N NL,NLC,NREFS,NTYPE,NUMRPT,NUSED,QUOTE
 N REPLACENAME,REPOINTLIST,RPTLIST,TEXT,TYPE,TYPECOUNT,TYPELIST
 S QUOTE=$C(34)
 S CLOGSFN=$$GETCLOGSFN^PXRMCLEH(801.41)
 S TEXT(1)="Checking for and resolving Reminder Dialog duplicates."
 S TEXT(2)="The first step is to search for and remove trailing non-printing characters"
 S TEXT(3)="in the .01s."
 D BMES^XPDUTL(.TEXT)
 ;Search for and remove trailing non-printing characters in the .01.
 S (IEN,NENTRIES)=0
 F  S IEN=+$O(^PXRMD(801.41,IEN)) Q:IEN=0  D
 . S NAME=$P($G(^PXRMD(801.41,IEN,0)),U,1)
 . I NAME="" D CORRUPTED(IEN) Q
 . S LEN=$L(NAME)
 . S CHAR=$E(NAME,LEN)
 . I $A(CHAR)<33 D
 .. K CLOGTEXT,TEXT
 .. S TEXT(1)=""
 .. S TEXT(2)="Removing trailing non-printing characters from:"
 .. S TEXT(3)=" "_QUOTE_NAME_QUOTE_" ("_IEN_")"
 .. S CLOGTEXT(1)="PXRM*2.0*88 renamed:"
 .. S CLOGTEXT(2)=QUOTE_NAME_QUOTE
 .. D BMES^XPDUTL(.TEXT)
 .. S NAME=$$RMTRNPC(NAME)
 .. S CLOGTEXT(3)="To: "_QUOTE_NAME_QUOTE
 .. S $P(^PXRMD(801.41,IEN,0),U,1)=NAME
 .. D CHANGELOG^PXRMCLEH(CLOGSFN,IEN,.CLOGTEXT)
 .. S NENTRIES=NENTRIES+1
 I NENTRIES>0 D
 . K TEXT
 . S TEXT=NENTRIES_" entries had trailing non-printing characters removed."
 . D BMES^XPDUTL(TEXT)
 ;Rebuild the .01 indexes. Need to make sure the 'B' index is correct so all duplicates are checked.
 S DIK="^PXRMD(801.41,"
 S DIK(1)=".01"
 D BMES^XPDUTL("Rebuilding the .01 indexes so all duplicates are found.")
 K ^PXRMD(801.41,"B")
 D ENALL^DIK
 ;
 D BMES^XPDUTL("Searching for duplicates.")
 S NAME="",NDUP=0
 F  S NAME=$O(^PXRMD(801.41,"B",NAME)) Q:NAME=""  D
 . K DUPLIST,TYPECOUNT,TYPELIST
 . S (IEN,NENTRIES)=0
 . F  S IEN=+$O(^PXRMD(801.41,"B",NAME,IEN)) Q:IEN=0  D
 .. S NENTRIES=NENTRIES+1
 .. S DUPLIST(NENTRIES)=IEN
 . I NENTRIES>1 D
 .. S NDUP=NDUP+1
 .. D MES^XPDUTL("Found "_NENTRIES_" entries for: "_QUOTE_NAME_QUOTE)
 ..;Determine if the duplicate entries all the same type.
 .. F IND=1:1:NENTRIES D
 ... S IEN=DUPLIST(IND)
 ... S TYPE=$P($G(^PXRMD(801.41,IEN,0)),U,4)
 ... I TYPE="" S TYPE="M"
 ... S TYPECOUNT(TYPE)=+$G(TYPECOUNT(TYPE))+1
 ... S TYPELIST(TYPE,IEN)=""
 .. S NTYPE=0,TYPE=""
 .. F  S TYPE=$O(TYPELIST(TYPE)) Q:TYPE=""  S NTYPE=NTYPE+1
 ..;If there are multiple types, remove the duplication by appending
 ..;-TYPE to the name.
 .. I NTYPE>1 D
 ... S TYPE=""
 ... F  S TYPE=$O(TYPELIST(TYPE)) Q:TYPE=""  D
 .... S IEN=""
 .... F  S IEN=$O(TYPELIST(TYPE,IEN)) Q:IEN=""  D
 ..... S NAME=$P(^PXRMD(801.41,IEN,0),U,1)
 ..... K CLOGTEXT,TEXT
 ..... S TEXT(1)=""
 ..... S TEXT(2)="Renaming: "_QUOTE_NAME_QUOTE_" ("_IEN_")"
 ..... S TEXT(3)="by appending -"_TYPE
 ..... S CLOGTEXT(1)="PXRM*2.0*88 renamed:"
 ..... S CLOGTEXT(2)=QUOTE_NAME_QUOTE
 ..... D BMES^XPDUTL(.TEXT)
 ..... S NAME=$E(NAME,1,62)_"-"_TYPE
 ..... S CLOGTEXT(3)="To: "_QUOTE_NAME_QUOTE
 ..... D RENAMEIEN(801.41,IEN,NAME)
 ..... D CHANGELOG^PXRMCLEH(CLOGSFN,IEN,.CLOGTEXT)
 ...;If there are multiple entries for the same TYPE put them on
 ...;the repoint list.
 ... S TYPE=""
 ... F  S TYPE=$O(TYPECOUNT(TYPE)) Q:TYPE=""  D
 .... I TYPECOUNT(TYPE)=1 Q
 .... S IEN=$O(TYPELIST(TYPE,""))
 .... S NAME=$P(^PXRMD(801.41,IEN,0),U,1)
 .... S RPTLIST(NAME)=TYPECOUNT(TYPE)
 .... S LASTEDITDATE=$$LASTEDITDATE(IEN)
 .... S RPTLIST(NAME,LASTEDITDATE,IEN)=""
 .... F  S IEN=$O(TYPELIST(TYPE,IEN)) Q:IEN=""  D
 ..... S LASTEDITDATE=$$LASTEDITDATE(IEN)
 ..... S RPTLIST(NAME,LASTEDITDATE,IEN)=""
 ..;
 .. I NTYPE=1 D
 ... S RPTLIST(NAME)=NENTRIES
 ... F IND=1:1:NENTRIES D
 .... S IEN=DUPLIST(IND)
 .... S LASTEDITDATE=$$LASTEDITDATE(IEN)
 .... S RPTLIST(NAME,LASTEDITDATE,IEN)=""
 D BMES^XPDUTL(NDUP_" duplicated entries were found.")
 ;Process the repoint list.
 I $D(RPTLIST)>0 D
 . K TEXT
 . S TEXT(1)="When the repointing is done:"
 . S TEXT(2)=" KEEPIEN-This entry will be kept in file #801.41."
 . S TEXT(3)=" REPLACEIEN-This entry will be repointed to KEEPIEN and REPLACEIEN"
 . S TEXT(4)=" will be deleted from file #801.41."
 . D BMES^XPDUTL(.TEXT)
 S NAME="",NUMRPT=0
 F  S NAME=$O(RPTLIST(NAME)) Q:NAME=""  D
 . K CLOGTEXT
 . S CLOGTEXT(1)="PXRM*2.0*88 repointed the following IENs to this entry:"
 . S NLC=1
 . S NENTRIES=RPTLIST(NAME)-1
 . K TEXT
 . S KEEPNAME=QUOTE_NAME_QUOTE
 . S LASTEDITDATE=$O(RPTLIST(NAME,""),-1)
 . S KEEPIEN=$O(RPTLIST(NAME,LASTEDITDATE,""))
 . S TEXT(1)=""
 . I NENTRIES=1 S TEXT(2)="Repointing "_(NENTRIES)_" duplicate entry for "_KEEPNAME
 . I NENTRIES>1 S TEXT(2)="Repointing "_(NENTRIES)_" duplicate entries for "_KEEPNAME
 . S TEXT(3)=" KEEPIEN="_KEEPIEN
 . S NL=3
 . S LASTEDITDATE=""
 . F  S LASTEDITDATE=$O(RPTLIST(NAME,LASTEDITDATE)) Q:LASTEDITDATE=""  D
 .. S IEN=""
 .. F  S IEN=$O(RPTLIST(NAME,LASTEDITDATE,IEN)) Q:IEN=""  D
 ... I IEN=KEEPIEN Q
 ... S NUMRPT=NUMRPT+1,REPOINTLIST(NUMRPT)=IEN_U_KEEPIEN
 ... S NL=NL+1,TEXT(NL)=" REPLACEIEN="_IEN
 ... S NLC=NLC+1,CLOGTEXT(NLC)=" "_IEN
 . D BMES^XPDUTL(.TEXT)
 . D CHANGELOG^PXRMCLEH(CLOGSFN,KEEPIEN,.CLOGTEXT)
 D BMES^XPDUTL(NUMRPT_" repoints will be done.")
 ;Do the repoints.
 D EN^DITP(801.41,.REPOINTLIST)
 ;Delete the entries that have been repointed.
 F IND=1:1:NUMRPT D
 . K FDA,MSG
 . S IEN=$P(REPOINTLIST(IND),U,1)
 . S FDA(801.41,IEN_",",.01)="@"
 . D FILE^DIE("","FDA","MSG")
 . I $D(MSG) D
 .. D BMES^XPDUTL("DUPFIX^PXRMDLGBREPAIR, delete failed.")
 .. D AWRITE^PXUTIL("MSG")
 .. D MES^XPDUTL("")
 .. D AWRITE^PXUTIL("FDA")
 Q
 ;
 ;===============================
LASTEDITDATE(IEN) ;Return the last edited date from the Change Log.
 N DATE,LASTENTRY
 S LASTENTRY=$O(^PXRMD(801.41,IEN,110,"B"),-1)
 S DATE=$S(LASTENTRY>0:$P(^PXRMD(801.41,IEN,110,LASTENTRY,0),U,1),1:0)
 Q DATE
 ;
 ;===============================
RENAMEIEN(FILENUM,IEN,NEWNAME) ;Rename IEN to NEWNAME in
 ;file number FILENUM. Ignore the key and input transform.
 ;Any resulting duplicates will be cleaned up by repointing.
 N FDA,MSG,PXRMINST,PXNAT
 S (PXRMINST,PXNAT)=1
 S FDA(FILENUM,IEN_",",.01)=NEWNAME
 D FILE^DIE("U","FDA","MSG")
 I $D(MSG) D
 . D BMES^XPDUTL("RENAMEIEN^PXRMDLGBREPAIR, rename failed.")
 . D AWRITE^PXRMUTIL("MSG")
 . D MES^XPDUTL("")
 . D AWRITE^PXRMUTIL("FDA")
 Q
 ;
 ;===============================
RMTRNPC(STRING) ;Remove trailing non-printing characters from STRING.
 N CHAR,DONE,IND,LEN
 S LEN=$L(STRING)
 S CHAR=$E(STRING,LEN)
 I $A(CHAR)>33 Q STRING
 S DONE=0,IND=LEN-1
 F  Q:DONE  D
 . S CHAR=$E(STRING,IND)
 . I $A(CHAR)>33 S DONE=1,STRING=$E(STRING,1,IND) Q
 . S IND=IND-1
 . I IND=0 S DONE=1,STRING=""
 Q STRING
 ;
