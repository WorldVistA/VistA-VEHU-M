DENTVX2 ;DSS/AJ - Dental Parameter RPCs ;10/11/2013 9:52
 ;;1.2;DENTAL;**66**;Aug 10, 2001;Build 36
 ;Copyright 1995-2013, Document Storage Systems, Inc., All Rights Reserved
 ;
 Q
GETWP(RET,ENT,PAR,INST) ;RPC: DENTVX2 GETWP
 ;get word processing parameter information
 ; ENT = entity (REQUIRED) SYS
 ; PAR = parameter (REQUIRED) name of parameter
 ; INST = instance (OPTIONAL - defaults to 1 if not defined)
 ; RET(n) = lines from the word processing parameter
 S ENT=$G(ENT) I ENT'["SYS" S RET(1)="-1^Missing or invalid Entity" Q
 S PAR=$G(PAR) I PAR="" S RET(1)="-1^Missing Parameter" Q
 S ENT=$G(ENT,"SYS"),INST=$G(INST,1)
 N DENTVLST,DENTVERR,X,Y S DENTVERR=0
 D GETWP^XPAR(.DENTVLST,ENT,PAR,INST,.DENTVERR)
 I +DENTVERR S RET(1)="-1^"_$P(DENTVERR,U,2) Q
 I '$D(DENTVLST) S RET(1)="-1^No data" Q
 S X=0,Y=0 F  S X=$O(DENTVLST(X)) Q:X=""  S Y=Y+1,RET(Y)=DENTVLST(X,0)
 Q
FILEWP(RET,ENT,PAR,INST,DATA) ;RPC: DENTVX2 FILEWP
 ;adds, updates, or deletes word processing parameter information
 ; ENT = entity (REQUIRED) SYS
 ; PAT = parameter (REQUIRED) name of parameter
 ; INST = instance (OPTIONAL - defaults to 1 if not defined)
 ; DATA = value (REQUIRED) - value to file, may be array for WP
 ; RET = 1^Success, else return -1^error message
 ; (note: this call REPLACES all the text in the wp parameter!)
 S ENT=$G(ENT) I ENT'["SYS" S RET="-1^Missing or invalid Entity" Q
 S PAR=$G(PAR) I PAR="" S RET="-1^Missing Parameter" Q
 I '$D(DATA) S RET="-1^Missing data to file" Q
 N DENTVERR S DENTVERR=0,INST=$G(INST,1)
 D EN^XPAR(ENT,PAR,INST,.DATA,.DENTVERR)
 I +DENTVERR S RET="-1^"_$P(DENTVERR,U,2) Q
 S RET="1^Success"
 Q
