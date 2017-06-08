DSIFINP1 ;DSS/RED - RPC FOR FEE BASIS INPATIENT ;07/16/2007 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;   2053  FILE^DIE,UPDATE^DIE
 ;  10013  ^DIK
 ;   3990  $$ICDOP^ICDCODE
 ;
 Q   ;Cannot be called directly
 ;
PROCLK(DSOUT,CODE,DATE) ;RPC: DSIF INP PROCEDURE
 ;Lookup a procedure based on a code or the IEN
 ;INPUT: ICD0 code or IEN (procedure), date - default if null is today
 ;OUTPUT: DSOUT=IEN;ICD0(^ICD-9 code (#.01)^Id (#2)^MDC24 (#5)^Versioned Oper/Proc (67 multiple)^
 ;           <null>^<null>^<null>^ICD Expanded (#8) 1:Yes 0:No^Status (66 multiple)^Use with Sex (#9.5)^Inactive Date (66 multiple)^
 ;           Activation Date (66 multiple)^Message
 ;           (or) DSOUT="-1^"error code
 K DSOUT
 S:$G(DATE)="" DATE=""
 I $G(CODE)="" S DSOUT="-1^No code entered" Q
 S DSOUT=$$ICDOP^ICDCODE(CODE,DATE)
 S DSOUT=$TR($P(DSOUT,U,1,2),U,";")_$P(DSOUT,U,3,14)
 Q
LOOKUP(DSOUT,TEXT,NUMBER) ;RPC:  DSIF INP PROC LOOKUP
 ;Allow lookup of 80.1 (procedures) based on user input
 ;Input:  Text string for lookup
 N OUT,CNT,DATA,FILE,IENS,FIELDS,FLAGS,FROM,PART,INDEX,SCREEN,ID,TARGET,MSG
 K ^TMP($J,"DSIFINP1"),^TMP("DILIST",$J),^TMP("DIERR",$J)
 S DSOUT=$NA(^TMP($J,"DSIFINP1")),NUMBER=$G(NUMBER) S:'NUMBER NUMBER=100
 S CNT=0,FILE=80.1,(IENS,ID,FLAGS,MSG,TARGET)="",FIELDS=".01;@",FLAGS="",INDEX="D",PART=TEXT,FROM=""
 D GETXREF^DSIFPAYR(.TARGET) I $D(^TMP("DIERR")) S @DSOUT@(0)="-1^Error in data return for file "_FILE Q
 S OUT=$NA(^TMP("DILIST",$J,"ID"))
 F I=0:0 S I=$O(@OUT@(I)) Q:'I  D PROCLK(.DATA,@OUT@(I,.01)) S @DSOUT@(@OUT@(I,.01),0)=DATA,CNT=CNT+1
 K ^TMP("DILIST",$J)
 I CNT=0 S @DSOUT@(0)="-1^No records found" Q
 S @DSOUT@(0)=1_U_CNT
 Q
 ;
DELNOTF(DSOUT,FBDA) ; RPC: DSIF INP NOTIFICATION DELETE
 ;INPUT: IEN of file 162.2        (Logic exported from FBCHDEL)
 ;This option allows you to delete a Request/Notification as long as there is not a 7078 set up for the request. In order to delete the request,
 ;you must either be the user who entered the request or be the holder of the FBAASUPERVISOR security key.
 N DA,DIK
 I $G(FBDA)="" S DSOUT="-1^Invalid notification selected" Q 
 I '$D(^FBAA(162.2,FBDA,0)) S DSOUT="-1^Invalid notification selected" Q
 ;Check supervisor key or DFN of clerk who entered and if 7078 pointer is not null
 I $D(^XUSEC("FBAASUPERVISOR",DUZ)),$P(^FBAA(162.2,FBDA,0),U,17)'="" S DSOUT="-1^7078 exists, cannot delete Notification" Q
 I $P(^FBAA(162.2,FBDA,0),U,17)'=""&$P(^FBAA(162.2,FBDA,0),U,8)=$G(DUZ) S DSOUT="-1^7078 exists, cannot delete Notification" Q
 S DA=FBDA,DIK="^FBAA(162.2," D ^DIK   ;Notification file
 I $D(FBDA),FBDA,$D(^FBAA(161.5,FBDA,0)) S DA=FBDA,DIK="^FBAA(161.5," D ^DIK  ;CH ROC file
 S DSOUT="1^Request deleted"
 K DIC,DIK,DA,FBDA,X,VAL,FBDA,DR,Y
 Q
 ;
ROCEDIT(DSOUT,IEN,DATA) ;ROC: DSIF INP ROC EDIT
 ; Input:  IEN = IEN of files 161.5 and 162.2, they MUST match
 ;      DATA(n)="Field^value", fields allowed: 5;6.5;7-13;16;16.5;17;18
 N IENS,IENS1,FILE,NEW,NUM,FLD,VAL,FLDU,FIL1,DSIF,DSIF1,DSIFD,ERR,NARR K DSOUT,ERR
 S DSOUT="0^",NUM=0,FILE=161.5,IENS=IEN_","
 F  S NUM=$O(DATA(NUM)) Q:NUM=""!(DSOUT<0)  D
 .S FLD=$P(DATA(NUM),U),VAL=$P(DATA(NUM),U,2),FLDU=U_FLD_U
 .I "^5^6.5^7^8^9^10^11^12^13^16^16.5^17^18^NARR^"'[FLDU S DSOUT="-1^Invalid field entered, quitting" Q
 .I FLD=17,(VAL'?7N1".".6N) S DSOUT="-1^Invalid date/time of report of contact entered" Q
 .I FLD=5,"TP"'[VAL S DSOUT="-1^Invalid Type of contact entered" Q
 .I FLD=16,$G(^DGBT(392.4,VAL,0))="" S DSOUT="-1^Invalid mode of travel entry" Q
 .I FLD=18 D  Q:DSOUT<0
 ..I VAL="" S DSOUT="-1^Missing approving official" Q
 ..I '$D(^VA(200,VAL,0)) S DSOUT="-1^Invalid Approving official" Q
 .I FLD="NARR" S NARR($P(DATA(NUM),U,2))=$P(DATA(NUM),U,3)
 .Q:DSOUT<0
 .I FLD'=17 S DSIFD(FLD)=VAL
 .I FLD=17 S DSIFD(17,.01)=VAL
 Q:DSOUT<0
 M DSIF(FILE,IENS)=DSIFD K DSIF(FILE,IENS,17)
 I $D(DSIF) D
 .L +^FBAA(161.5,IEN):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S DSOUT="-1^Unable to lock file, try again later" Q
 .D FILE^DIE(,"DSIF","ERR") L -^FBAA(161.5,IEN)
 .I $D(ERR) S DSOUT="-1^File write error" Q
 I $D(DSIFD(17)) D
 .S FIL1=161.517,NEW=1
 .D:$D(DSIFD(17,.01))
 ..S IENS1="+1,"_IENS
 ..S DSIF(FIL1,IENS1,.01)=DSIFD(17,.01),DSIF(FIL1,IENS1,2)=$G(DUZ)
 ..D UPDATE^DIE(,"DSIF","DSIF1")
 .N ERR
 .S IENS2=DSIF1(1)_","_IENS
 .D WP^DIE(FIL1,IENS2,1,,"NARR","ERR")
 .I $D(ERR) S DSOUT="-1^Word processing error" Q
 S DSOUT="1^ROC edited successfully"
 Q
