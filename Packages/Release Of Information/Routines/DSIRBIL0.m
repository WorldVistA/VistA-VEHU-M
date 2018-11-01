DSIRBIL0 ;AMC/EWL - Document Storage System;Billing RPC's and other ;04/14/2011 11:18
 ;;8.2;RELEASE OF INFORMATION - DSSI;;Nov 08, 2011;Build 25
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2052  $$GET1^DID
 ;2053  FILE^DIE
 ;2055  $$EXTERNAL^DILFD
 ;2056  GET1^DIQ
 ;2056  GETS^DIQ
 ;10003 DD^%DT
 ;      
 Q
BILLHIST(AXY,BILN) ;RPC - DSIR BILL HISTORY
 ;       Input Parameter(s)
 ;               1 - Bill IEN
 ;               
 ;       Return Array '^' delimited
 ;               1 - Date of Edit Internal ; External (I ; E)
 ;               2 - Edited By (I ; E)
 ;               3 - Field Edited (I ; E)
 ;               4 - Old Value Internal (I ; E)
 ;               5 - New Value Internal (I ; E)
 ;
 N GLRF,HIST,HISTC,FLD,FLDN,FIL,GET,XX,YY,OLDV,NEWV S GLRF="DSIRBIL0",FIL=19620.29,YY=0
 S AXY=$NA(^TMP(GLRF,$J))
 I '$G(BILN) S ^TMP(GLRF,$J,0)="-1^Invalid Input - Missing Bill Number!" Q
 S HIST=0 F  S HIST=$O(^DSIR(FIL,"B",BILN,HIST)) Q:'HIST  D
 .S HISTC=HIST_"," D GETS^DIQ(FIL,HIST,"*","EI","GET")
 .S FLD=$G(GET(FIL,HISTC,.04,"I")),FLDN=$$GET1^DID(19620.2,FLD,"","LABEL"),OLDV=$G(GET(FIL,HISTC,.05,"I")),NEWV=$G(GET(FIL,HISTC,.06,"I"))
 .S OLDV=OLDV_";"_$$EXTERNAL^DILFD(19620.2,FLD,"",OLDV),NEWV=NEWV_";"_$$EXTERNAL^DILFD(19620.2,FLD,"",NEWV),FLDN=FLD_";"_FLDN
 .S XX=$G(GET(FIL,HISTC,.02,"I"))_";"_$G(GET(FIL,HISTC,.02,"E"))_U_$G(GET(FIL,HISTC,.03,"I"))_";"_$G(GET(FIL,HISTC,.03,"E"))
 .S $P(XX,U,3)=FLDN,$P(XX,U,4)=OLDV,$P(XX,U,5)=NEWV
 .S YY=YY+1,^TMP(GLRF,$J,YY)=XX K GET
 I 'YY S ^TMP(GLRF,$J,0)="-2^No Audit History Records Found!"
 Q
DEVCLNUP ;Development Clean-up INTERNAL USE ONLY
 ;
 N A S A=$P(^DSIR(19620.2,0),U,1,2) K ^DSIR(19620.2) S ^DSIR(19620.2,0)=A
 S A=$P(^DSIR(19620.21,0),U,1,2) K ^DSIR(19620.21) S ^DSIR(19620.21,0)=A
 K ^DD(19620.2)
 Q
 ;
KILLBILL(AXY,BIEN,ADMIN) ;RPC - DSIR KILL BILL
 ;Input Parameters
 ;               BIEN - Bill Internal Entry Number (File 19620.2, Required)
 ;               ADMIN - Flag to allow delete of a bill with payments, deletes payment history also (Optional - default = 0)
 ;               
 ;Return Values
 ;
 ;               1 - Successful deletion
 ;               -1^Missing Bill Number!
 ;               -2^No Bill on file for Bill IEN!
 ;               -3^Payment(s) received for $  nnn.nn. Unable to delete!
 ;               
 ;               
 N DA,DIK,PNTR,FIL,FILE,PAID
 S BIEN=+$G(BIEN),ADMIN=+$G(ADMIN) I 'BIEN S AXY="-1^Missing Bill Number!" Q
 I '$D(^DSIR(19620.2,BIEN,0)) S AXY="-2^No Bill on file for Bill IEN!" Q
 S PAID=$$PAYM(BIEN,ADMIN) I PAID S AXY="-3^Payment(s) received for $"_$J(PAID,8,2)_". Unable to delete!" Q
 F FIL=29,21 S PNTR=0,FILE=19620+(FIL/100) F  S PNTR=$O(^DSIR(FILE,"B",BIEN,PNTR)) Q:'PNTR  S DA=PNTR,DIK="^DSIR("_FILE_"," D ^DIK K DIK
 S DA=BIEN,DIK="^DSIR(19620.2," D ^DIK
 S AXY=1
 Q
PAYM(IEN,DEL) ;
 N PAY,PAY0,AMT,DIK,DA,HIST S (PAY,AMT)=0
 F  S PAY=$O(^DSIR(19620.21,"B",IEN,PAY)) Q:'PAY  D
 .I DEL S DIK="^DSIR(19620.21,",DA=PAY D ^DIK K DIK Q
 .S PAY0=$G(^DSIR(19620.21,PAY,0))
 .I $P(PAY0,U,2),'$P(PAY0,U,5),'$P(PAY0,U,7) S AMT=AMT+$P(PAY0,U,2)
 I DEL S HIST=0 F  S HIST=$O(^DSIR(19620.29,"B",IEN,HIST)) Q:'HIST  S DIK="^DSIR(19620.29,",DA=HIST D ^DIK K DIK
 Q AMT
UPDATEFW(AXY,IEN,FWCLERK,FWRQST,FWRQSTDT,FWADJ,FWADJDT,FWGRANT) ; RPC - DSIR UPDATE FEE WAIVER
 ; Input parameters
 ;      IEN      from 19620
 ;      FWCLERK  ID from 200
 ;      FWRQST   Fee Waiver Requested 1=true 0=false
 ;      FWRQSTDT Fee Waiver Requested Date in Fileman format
 ;      FWADJ    Fee Waiver Adjudicated 1=true 0=false
 ;      FWADJDT  Fee Waiver Adjudicated Date in Fileman format
 ;      FWGRANT  Fee Waiver Granted
 ; Return Values
 ;      IEN      from 19620 if successful
 ;      -1       If Unsuccessful
 N FDA,IENS
 I $D(^DSIR(19620,IEN)) D  Q
 .S IENS=IEN_","
 .S FDA("19620",IENS,4.01)=FWRQST
 .S FDA("19620",IENS,4.02)=FWRQSTDT
 .S FDA("19620",IENS,4.03)=FWADJ
 .S FDA("19620",IENS,4.04)=FWADJDT
 .S FDA("19620",IENS,4.05)=FWGRANT
 .S FDA("19620",IENS,4.06)=FWCLERK
 .D FILE^DIE(,"FDA","EMSG")
 .I $D(EMSG) S AXY="-1^"_EMSG("DIERR",1,"TEXT",1) Q
 .S AXY=IEN
 Q "-1^IEN/REQUEST NOT ON FILE"
BLSOUT(RET,IEN) ; RPC - DSIRBIL0 BLSOUT BILLS DUE 
 ;INPUT PARAMETER
 ; IEN - POINTER TO ANY REQUEST REUESTED BY THE DESIRED REQUESTOR
 ;
 ; RETURN ARRAY 
 ;  RETURNS AN ARRAY WHICH IS A FORMATTED TEXT REPORT
 ;
 ; This routine retrieves a requestor from the provided request
 ; and creates an outstanding bill report for that requestor. 
 ;
 K RET S RET=$NA(^TMP("DSIRBIL0 BLSOUT",$J)) K @RET
 N RNAME,RIEN,RQST,RCVD,PATFOIA,AMT,TOT,GET,CT S (TOT,AMT)=0,CT=4
 ; Get the requestor info from the instance file
 K GET D GETS^DIQ(19620,IEN_",",.11,"IE","GET")
 S RNAME=GET(19620,IEN_",",.11,"E")
 S RIEN=GET(19620,IEN_",",.11,"I")
 ; Report heading
 S @RET@(1)="OUTSTANDING BILLS FOR "_RNAME
 S @RET@(2)=""
 S @RET@(3)="    AMOUNT DATE RCVD    PATIENT"
 S @RET@(4)="========== ============ =============================="
 ; process all of the requestors bills with a balance due
 F  S AMT=$O(^DSIR(19620.2,"ARBAL",RIEN,AMT)) Q:'AMT  S RQPTR=0 D
 .F  S RQPTR=$O(^DSIR(19620.2,"ARBAL",RIEN,AMT,RQPTR)) Q:'RQPTR  D
 ..S RCVD=$$GET1^DIQ(19620,RQPTR_",",10.06)
 ..S PAT=$$GET1^DIQ(19620,RQPTR_",",.01)
 ..S TOT=TOT+AMT,CT=CT+1,@RET@(CT)=$$FIXAMT(AMT)_$$FIXRCVD(RCVD)_PAT
 ; Report Footer
 I CT=4 S CT=CT+1,@RET@(CT)="NO OUTSTANDING BILLS"
 E  D
 .S CT=CT+1,@RET@(CT)="---------- ------------ ------------------------------"
 .S CT=CT+1,@RET@(CT)=$$FIXAMT(TOT)_"TOTAL DUE"
 Q
FIXAMT(AMT) ; FORMAT THE AMOUNT FOR THE REPORT
 N DEC,ACCUM,RET
 S ACCUM="$"_$P(AMT,"."),DEC=$P(AMT,".",2)
 S ACCUM=ACCUM_$S('DEC:".00",$L(+DEC)=2:"."_DEC,$L(+DEC)=1:"."_DEC_"0",1:"."_$E(DEC,1,2))
 I $L(ACCUM)>11 S ACCUM="*******.** "
 S $P(RET," ",11-$L(ACCUM))=ACCUM
 Q RET_" "
 ;
FIXRCVD(RCVD) ; FIX THE RECEIVED DATE
 S Y=RCVD D DD^%DT
 S FMTDT=$P(Y,"@",1)
 Q FMTDT_" "
