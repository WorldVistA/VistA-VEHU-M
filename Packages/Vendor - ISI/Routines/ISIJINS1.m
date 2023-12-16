ISIJINS1 ; ISI/JHC - ISI Rad Install Utility ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**100,101,103,104,105,102,106,110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 ;
ENVCHK ; "Environment Check" for KIDS Install
 I 'XPDENV Q  ; Proceed only if in Install phase
 N MAGJKIDS S MAGJKIDS=1
 D BGCSTOP^MAGJMN1  ; stop background compile
 Q
 ;
POST110 ; ISIRAD*1.1*110  "Standalone" KIDS Installation EP
 D UPDAT110
 D BGCSTRT^MAGJMN1  ; re-start background compile
 Q
 ;
UPDAT110 ; ISIRAD patch 110 KIDS post-Install
 ; register rpcs
 N RPCLIST
 S RPCLIST("ISI GET RAD DX CODES")=""
 S RPCLIST("ISI GET RAD STANDARD REPORTS")=""
 S RPCLIST("ISI GET RAD STANDARD TEXT")=""
 S RPCLIST("ISIJ ASSIGN ENABLE")=""
 S RPCLIST("ISIJ DYNAMIC QUERY")=""
 S RPCLIST("ISIJ FAVORITE")=""
 S RPCLIST("ISIJ GET RAD TECHS")=""
 S RPCLIST("ISIJ LOCK REPORT")=""
 S RPCLIST("ISIJ NOTES")=""
 S RPCLIST("ISIJ RAD EXAM UPDATE")=""
 S RPCLIST("ISIJ RAD RPT DETAIL")=""
 S RPCLIST("ISIJ REPORT ENTER")=""
 D ADDRPCS(.RPCLIST)
 D ADDMENU("MAGJ MAIN","ISIJ QUERY STATS INQUIRE","QRST",60) ; new menu options
 ; Fix UNDEF error on RECENT list background compile--initialize the file
 K ^XTMP("MAGJ2",0,"LS9992",1)
 K ^XTMP("MAGJ2",0,"LS9992",2)
 K ^XTMP("MAGJ2","BKGND","LS9992",0)
 K ^XTMP("MAGJ2","LS9992")
 ;
 I '$$UJOCHECK^ISIJUTL9() Q  ; not adding below to VA
 ; update menu for List Stats
 D ADDMENU("MAGJ MAIN","ISIJ LIST STATISTICS PRINT","LSTA",65) ; new menu options
 Q
 ;
POST106 ; ISIRAD*1.1*106  "Standalone" KIDS Installation EP
 D UPDAT106
 D BGCSTRT^MAGJMN1  ; re-start background compile
 Q
UPDAT106 ; ISIRAD*1.1*106  "Rolled up" KIDS Installation EP
 N LSTNUM
 F LSTNUM=980 D BLDLSNUM^MAGJMN1(LSTNUM)  ; re-build exam list definition details
 D POST106L^MAGJMN1 ; stuff search logic for new exam list (added in ISI-P106)
 N RPCLIST
 S RPCLIST("ISIJ GET RAD TECHS")=""
 S RPCLIST("ISIJ RAD EXAM UPDATE")=""
 D ADDRPCS(.RPCLIST)
 Q
 ;
POST102 ; ISIRAD*1.1*102  "Standalone" KIDS Installation EP
 D UPDAT102
 D BGCSTRT^MAGJMN1  ; re-start background compile
 Q
UPDAT102 ; ISIRAD*1.1*102  "Rolled up" KIDS Installation EP
 N LSTNUM
 F LSTNUM=9830,9992 D BLDLSNUM^MAGJMN1(LSTNUM)  ; re-build exam list definition details
 D POST102L^MAGJMN1 ; stuff search logic for MY RECENT EXAMS list (added in ISI-P102)
 N RPCLIST
 S RPCLIST("ISIJ REPORT ENTER")=""
 S RPCLIST("ISIJ LOCK REPORT")=""
 D ADDRPCS(.RPCLIST)
 Q
 ;
POST105 ; ISIRAD*1.1*105  "Standalone" KIDS Installation EP
 D UPDAT105
 D BGCSTRT^MAGJMN1  ; re-start background compile
 Q
UPDAT105 ; ISIRAD*1.1*105  "Rolled up" KIDS Installation EP
 ; n/a
 Q
 ;
POST104 ; ISIRAD*1.1*104  "Standalone" KIDS Installation EP
 D UPDAT104
 D BGCSTRT^MAGJMN1  ; re-start background compile
 Q
UPDAT104 ; ISIRAD*1.1*104  "Rolled up" KIDS Installation EP
 N RPCLIST S RPCLIST("ISIJ NOTES")="" ;  new rpc
 D ADDRPCS(.RPCLIST) D ADDRPCS
 Q
 ;
POST103 ; ISIRAD*1.1*103  "Standalone" KIDS Installation EP
 D UPDAT103
 D BGCSTRT^MAGJMN1  ; re-start background compile
 Q
UPDAT103 ; ISIRAD*1.1*103  "Rolled up" KIDS Installation EP
 D BLDALL^MAGJMN1  ; re-build exam list definition details
 D ISIPOST1^MAGJMN1  ; re-build exam list search logic for Assigned Lists
 Q
 ;
 ;
POST101 ; ISIRAD*1.1*101  "Standalone" KIDS Installation EP
 D UPDAT101
 D BGCSTRT^MAGJMN1  ; re-start background compile
 Q
UPDAT101 ; ISIRAD*1.1*101  "Rolled up" KIDS Installation EP
 D  ; Delete "old version" list entries for 9992 & 9993
 . N DA,DIDEL,DIE,DR,FIL,FILENUM,IEN,LSTID,VALUES
 . S FILENUM=2006.631
 . S VALUES(9992)="All Interpreted or Transcribed"
 . S VALUES(9993)="All Examined, Interpreted, & T"
 . S FIL=$NA(^MAG(FILENUM)),X=""
 . F LSTID=9992,9993 S IEN=$O(@FIL@("B",VALUES(LSTID),"")) I IEN D
 . . S DIDEL=FILENUM,DR=".01////@",DIE="^MAG("_FILENUM_",",DA=IEN D ^DIE
 . Q
 D BLDALL^MAGJMN1  ; re-build exam list definition details
 Q
 ;
 ;
POST100 ; ISIRAD*1.1*100  "Standalone" KIDS Installation EP
 D UPDAT100
 D BGCSTRT^MAGJMN1  ; re-start background compile
 Q
UPDAT100 ; ISIRAD*1.1*100  "Rolled up" KIDS Installation EP
 D ADDMENU("MAGJ MAIN","ISIJ LIST STATISTICS PRINT","LSTA",65)
 Q
 ;
POSTN ; Example for likely items to manage for given install...
 ; D BLDALL ; update list definitions -- call this any time NEW FIELDS are added to lists
 ; N RPCLIST S RPCLIST("ISIJ rpc")="" ;  define new rpcs in this array
 ; D ADDRPCS(.RPCLIST) D ADDRPCS      ;   then call
 ; D ADDMENU("MAGJ MAIN","ISIJ Option","SYN",99) ;  add new menu option
 ; D SRCHn   ;  insert search logic for exam lists if exists
 ; D BGCSTRT^MAGJMN1 ; re-start background compile -- ALWAYS call this
 Q
 ;
ADDRPCS(RPCLIST) ;
 I $D(RPCLIST) S X=$$ADDRPCS^MAGKIDS1(.RPCLIST,"MAGJ VISTARAD WINDOWS")  ; register rpcs
 Q
 ;
ADDMENU(MENU,OPTION,SYNONYM,ORDER) ; add menu options to main menu
 ; use this call to add, since ISI KIDS utility does not work w/ kids comp.
 ;  * DO create kids comp that defines the new menu option, however
 I $G(MENU)]"",($G(OPTION)]"") S MENU=$$ADD^XPDMENU(MENU,OPTION,SYNONYM,ORDER)
 Q
 ;
END ;
