DSIROIU ;DSS/EWL - Document Storage Systems Inc - ROI Environment Check Routine ;04/14/2011 11:18
 ;;8.2;RELEASE OF INFORMATION - DSSI;;Nov 08, 2011;Build 25
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 Q
 ;
 ; DBIA# Supported Reference
 ; ----- --------------------------------
 ;  1719 GETS^DIQ
 ;  2051 FIND^DIC
 ;  2263 GET^XPAR
 ;  2263 CHG^XPAR
 ;  3281 Fileman read of fields .01 & 17 in INSTALL file - Controlled
 ;
LSTIN(DSIRVER) ; RPC - DSIROIU LSTIN GET LAST INSTALL
 ; no input parameter if called as an RPC
 ; A variable should be passed by reference if called as an API
 ;Returns are as follows:
 ; -1^error message
 ; or
 ; Version #
 ; or
 ; 0 if no version found
 NEW DSIRRET,DSIRERR,IEN,DSIRVAL,DSIRDT,VER S (DSIRDT,IEN)=0
 ; READ THE INSTALL FILE
 D FIND^DIC(9.7,,"@;.01;17I","BPQ","DSIR",,"B",,,"DSIRRET","DSIRERR")
 ; CHECK FOR ERRORS
 I $D(DSIRERR)!'$D(DSIRRET) S DSIRVER="-1^Problems encountered checking version" Q
 ; ALL GOOD - PROCESS RECORDS
 F  S IEN=$O(DSIRRET("DILIST",IEN)) Q:'IEN  D
 .I DSIRDT<$P(DSIRRET("DILIST",IEN,0),U,3) D
 ..S DSIRDT=$P(DSIRRET("DILIST",IEN,0),U,3)
 ..S VER=$P(DSIRRET("DILIST",IEN,0),U,2)
 ..I $E(VER,5,5)=" " S DSIRVER=$P(VER," ",2)
 ..I $E(VER,5,5)="*" S DSIVER=$P(VER,"*",2)_"."_$P(VER,"*",3)
 I '$D(DSIRVER) S DSIRVER=0
 Q
LSTRQSTS ; LIST REQUESTS Utility for listing request information for a given
 ; patient including Name, SSN, Address, & Phone followed by:
 ; All request data concerning Requestor, Mail to Address and Patient Address
 ; PTRS and data
 ; This only works for registered patients.
 ; Unregistered patients and FOIA will not work.
 W # N DIR,PATIENT,REQUESTS,DFN,IEN,PTRS
 S DIR(0)="F",DIR("A")="ENTER PATIENT INFO TO SEARCH FOR ==> " D ^DIR
 I $D(DIRUT) W !,"REQUEST TIMED OUT OR WAS CANCELLED BY USER" Q
 S DIC="^DPT(",DIC(0)="QEMZ" D ^DIC
 I Y=-1 W !,"NO PATIENT WAS SELECTD" Q
 S DFN=$P(Y,U)_";DPT(",PATIENT=$P(Y,U,2),SSN=$P(Y(0),U,9)
 W #,PATIENT,"    SSN: ",SSN,"  DFN: ",DFN
 W !,"========================================================================"
 I '$D(^DSIR(19620,"B",DFN)) K DIR W !,"THIS PATIENT HAS NO ROI REQUESTS",! S DIR(0)="E" D ^DIR Q
 K ^TMP("DSIRRQINQ",$J)
 W !,"IEN          REQUESTOR    MAIL TO ADDR PATIENT ADDR"
 W !,"------------ ------------ ------------ ------------"
 N REQUESTR,MAILTO,PATADDR
 S IEN=0 F  S IEN=$O(^DSIR(19620,"B",DFN,IEN)) Q:'IEN  D
 .K PTRS,REQUESTR,MAILTO,PATADDR S IENS=IEN_"," D GETS^DIQ(19620,IENS,".11;.81;.82","I","PTRS")
 .S REQUESTR=+$G(PTRS(19620,IENS,.11,"I")) S:'REQUESTR REQUESTR="-"
 .S MAILTO=+$G(PTRS(19620,IENS,.81,"I")) S:'MAILTO MAILTO="-"
 .S PATADDR=+$G(PTRS(19620,IENS,.82,"I")) S:'PATADDR PATADDR="-"
 .S ^TMP("DSIRRQINQ",$J,"REQUEST",IEN,"REQUESTOR")=REQUESTR
 .S ^TMP("DSIRRQINQ",$J,"REQUEST",IEN,"MAIL TO ADDRESS")=MAILTO
 .S ^TMP("DSIRRQINQ",$J,"REQUEST",IEN,"PATIENT ADDRESS")=PATADDR
 .S ^TMP("DSIRRQINQ",$J,"REQSTOR",REQUESTR)=REQUESTR
 .S ^TMP("DSIRRQINQ",$J,"ADDR",MAILTO)=MAILTO
 .S ^TMP("DSIRRQINQ",$J,"ADDR",PATADDR)=PATADDR
 .W !,$E(IEN_"             ",1,13)
 .W $E(^TMP("DSIRRQINQ",$J,"REQUEST",IEN,"REQUESTOR")_"             ",1,13)
 .W $E(^TMP("DSIRRQINQ",$J,"REQUEST",IEN,"MAIL TO ADDRESS")_"             ",1,13)
 .W $E(^TMP("DSIRRQINQ",$J,"REQUEST",IEN,"PATIENT ADDRESS")_"             ",1,13)
 W !,!,"REQUESTOR #  LOOKUP NAME          FIRST           M LAST"
 W !,"------------ -------------------- --------------- - ---------------"
 N LOOKN,FN,MN,LN,RNBR,RNBRS,RQSTRAR,REQSTRN
 S RNBR=0 F  S RNBR=$O(^TMP("DSIRRQINQ",$J,"REQSTOR",RNBR)) Q:'RNBR  D
 .S RNBRS=RNBR_",",REQSTRN=+$G(RNBR) S:'REQSTRN REQSTRN="-"
 .S REQSTRN=$E(REQSTRN_"             ",1,13) K RQSTRAR
 .D GETS^DIQ(19620.12,RNBRS,".01;.11;.12;.13","E","RQSTRAR")
 .S LOOKN=$G(RQSTRAR(19620.12,RNBRS,.01,"E")) S:""[LOOKN LOOKN="-"
 .S FN=$G(RQSTRAR(19620.12,RNBRS,.11,"E")) S:""[FN FN="-"
 .S MN=$G(RQSTRAR(19620.12,RNBRS,.12,"E")) S:""[MN MN="-"
 .S LN=$G(RQSTRAR(19620.12,RNBRS,.13,"E")) S:""[LN LN="-"
 .S LOOKN=$E(LOOKN_"                     ",1,21)
 .S FN=$E(FN_"                ",1,16)
 .S MN=$E(MN_"  ",1,2)
 .S LN=$E(LN_"               ",1,15)
 .W !,REQSTRN,LOOKN,FN,MN,LN,$$GET1^DIQ(19620.12,RNBRS,5,"I")
 W !,!,"ADDRESS #    NAME, ADDRESS & PHONE"
 W !,"------------ ------------------------------------------------------"
 S RNBR=0 F  S RNBR=$O(^TMP("DSIRRQINQ",$J,"ADDR",RNBR)) Q:'RNBR  D
 .S RNBRS=RNBR_",",ADDRN=$E(RNBR_"             ",1,13),TAB="             "
 .K RQSTRAR D GETS^DIQ(19620.92,RNBRS,"*","E","RQSTRAR")
 .S NAME=RQSTRAR(19620.92,RNBRS,.01,"E")
 .S STR1=RQSTRAR(19620.92,RNBRS,.02,"E")
 .S STR2=RQSTRAR(19620.92,RNBRS,.03,"E")
 .S STR3=RQSTRAR(19620.92,RNBRS,.11,"E")
 .S CITY=RQSTRAR(19620.92,RNBRS,.04,"E")
 .S STATE=RQSTRAR(19620.92,RNBRS,.05,"E")
 .S ZIP=RQSTRAR(19620.92,RNBRS,.06,"E")
 .S CSZ=$$CSZ(CITY,STATE,ZIP)
 .S PHONE=RQSTRAR(19620.92,RNBRS,1.01,"E")
 .S FAX=RQSTRAR(19620.92,RNBRS,1.02,"E")
 .W !,ADDRN S TB=0
 .I NAME]"" W NAME,! S TB=1
 .I STR1]"" W $S(TB:TAB_STR1,1:STR1),! S TB=1
 .I STR2]"" W $S(TB:TAB_STR2,1:STR2),! S TB=1
 .I STR3]"" W $S(TB:TAB_STR3,1:STR3),! S TB=1
 .I CSZ]"" W $S(TB:TAB_CSZ,1:CSZ),! S TB=1
 .I PHONE]"" W $S(TB:TAB_"PHONE: "_PHONE,1:"PHONE: "_PHONE),! S TB=1
 .I FAX]"" W $S(TB:TAB_"FAX: "_FAX,1:"FAX: :"_FAX),!
 Q
CSZ(C,S,Z) ; FORMAT CITY, STATE ZIP
 N CSZ
 I $G(C)]"" D
 .I $G(S)]"" D
 ..S CSZ=C_", "_S_" "_Z
 .I $G(S)']"" D
 ..S CSZ=C_" "_Z
 I $G(C)']"" D
 .I $G(S)]"" D
 ..S CSZ=S_" "_Z
 .I $G(S)']"" D
 ..S CSZ=Z
 Q CSZ
GDYS(DAYS) ; RPC - DSIROIU GDYS GET RPT KILL DAYS
 ; INPUT PARAMETERS
 ; REURNS
 ;  DAYS WHICH INDICATES DAYS TO RETAIN REPORTS
 S DAYS=$$GET^XPAR("PKG","DSIR REPORT RETENTION PERIOD",1)
 Q
 ;
SDYS(RET,DAYS) ; RPC - DSIROIU SDYS SET RPT KILL DAYS
 ; INPUT PARAMETERS
 ; OUTPUT IS EITHER
 ;  DAYS - WHICH INDICATES SUCCESS
 ;  OR -1^ERROR MESSAGE
 S DAYS=+$G(DAYS)
 I DAYS=0!(DAYS\1'=DAYS) S RET="-1^The DAYS parameter is required and must be an integer greater than zero."
 D CHG^XPAR("PKG","DSIR REPORT RETENTION PERIOD",1,DAYS,.MSG)
 S RET=DAYS
 Q
GETDAYS ; CALLS SDYS
 D GDYS(.DAYS)
 W !,"The number of days to retain reports is set to "_DAYS
 Q
SETDAYS(DAYS) ; CALLS GDYS
 D SDYS(.RET,$G(DAYS))
 I +RET=-1 W !,RET Q
 W !,"The number of days to retain reports was changed to "_RET
 Q
