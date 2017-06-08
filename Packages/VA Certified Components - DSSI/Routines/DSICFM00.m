DSICFM00 ;DSS/SGM - Quick Docs for DSIC FM APIs ;01/14/2005 13:26
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;10005 DT^DICRW
 ;10086 HOME^%ZIS
 ;10104 $$CJ^XLFSTR
 N I,X,Y,Z
 D DT^DICRW,HOME^%ZIS W @IOF
 S Z="",$P(Z,"-",80)=""
 F I=1:1 S X=$T(T+I) Q:X=""  S X=$P($T(T+I),";",3,99) D
 .I X'?1"DSICFM".E W !,"  "_X Q
 .W !,Z,!,$$CJ^XLFSTR("Routine "_X,80),!,Z
 .Q
 Q
T ;
 ;;DSICFM
 ;; this displays to your screen brief documentation for the various
 ;; DSICFMxx calls.
 ;;
 ;;DSICFM01
 ;;MSG(FLGS,.OUT,WIDTH,LEFT,INPUT)
 ;; this will run Fileman's MSG^DIALOG routine.  It supports all its
 ;; features.  This is only called as an API, not as an RPC.
 ;; D MSG^DSICFM01(flags,.RETURN,width,left,"INPUT")
 ;; S X=$$MSG^DSICFM01("V"_(FM flags),,,,"INPUT") to return a string
 ;; up to 510 bytes.
 ;;
 ;;DIC(.A)
 ;; this is for terminal interactive mode only.
 ;; A() is passed by reference as is equivalent to DIC()
 ;; It will handle cleaning up all local variables and returns the value
 ;; of Y from ^DIC.
 ;;  Exception: if $D(DUOUT) return -1
 ;;             if $D(DTOUT) return -2
 ;;
 ;;DIR(.DIR)
 ;; this is for terminal interactive mode only.
 ;; DIR() is passed by reference
 ;; It will handle cleaning up all local variables and returns the value
 ;; of Y from ^DIR.
 ;;  Exception: if $D(DUOUT) return -1
 ;;             if $D(DTOUT) return -2
 ;;
 ;;DSICFM02
 ;;DINUM(.DSIC2,FILE,IEN,VAL,IENS)          RPC: DSIC FM DINUM
 ;; this will add an entry to a file that is defined as being dinum'd
 ;;
 ;;DSICFM03
 ;;V1(.DSIC,.INPUT)
 ;; this provides the full features of $$FIND1^DIC.
 ;; D V1^DSICFM03(.RET,.INPUT)
 ;; see line tag PARSE for definition of INPUT()
 ;;
 ;;DSICFM04
 ;;FILE(.DSIC,FILE,IENS,FLAG,.INPUT)       RPC: DSIC FM FILER
 ;; this invokes the Fileman filer to update fields for an existing
 ;; entry.  This will allow you to update any field at the level of
 ;; the FILE including word processing fields.  It does not allow for
 ;; updating different levels of the file.  If you wish to update a
 ;; subfile, then you will have to make multiple calls to this RPC
 ;; for each file or subfile.
 ;;
 ;;DSICFM05
 ;;FIND(.DSIC,.INPUT)                      RPC: DSIC FM FIND
 ;; this provides the full features of FIND^DIC.
 ;;
 ;;LIST(.DSIC,.INPUT)                      RPC: DSIC FM LIST
 ;; this provides most, not all, of the features of LIST^DIC
 ;; work in progress - 11/13/2003
 ;;
 ;;DSICFM06
 ;;EXTERNAL(.DSIC,FILE,FIELD,VALUE,FUN)    RPC: DSIC FM EXTERNAL
 ;; this will convert any data in internal Fileman format to external
 ;; format.  It can be invoked as a API or extrinsic function
 ;; It calls $$EXTERNAL^DILFD
 ;;
 ;;FIELD(DSIC,FILE,FIELD,FLAGS,.ATT,TYPE)  RPC: DSIC FM GET FIELD ATTRIB
 ;; this will return the inputed field attributes for a file
 ;;
 ;;FIELDLST(.DSICX,.INPUT)
 ;; this returns the list of field attributes which are available for
 ;; specific Fileman database server calls.  It calls FIELDLST^DID
 ;;
 ;;ROOT(.DSIC,FILE,IENS,FLAG,FUN)
 ;; Return global root (open or closed) for a file or subfile
 ;; On error return -1^message
 ;;
 ;;VFILE(.DSIC,FILE,FUN)                   RPC: DSIC FM VERIFY FILE
 ;; this will verify whether or not a file or subfile exists
 ;; S X=$$VFILE^DSICFM06(,FILE,1)
 ;;
 ;;VFIELD(.DSIC,FILE,FIELD,FUN)            RPC: DSIC FM VERIFY FIELD
 ;; this will verify whether or not a field exists in a file or subfile
 ;; S X=$$VFIELD^DSICFM06(,FILE,FIELD,1)
 ;;
 ;;VIENS(.DSIC,IENS,FUN)
 ;; validate that IENS is a proper iens string
