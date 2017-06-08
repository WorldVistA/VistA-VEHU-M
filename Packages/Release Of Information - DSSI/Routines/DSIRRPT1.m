DSIRRPT1 ;EWL - Document Storage Systems; ROI Report RPC'S ;07/01/2011 11:18
 ;;8.2;RELEASE OF INFORMATION - DSSI;;Nov 08, 2011;Build 25
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2053  FILE^DIE
 ;2053  WP^DIE
 ;2056  GETS^DIQ
 Q
 ;************************
 ; Requests by clerk report
BYCLRK(AXY,FRDT,TODT,STATUS,DIVL,REQS,SCHED,ESTART) ; RPC - DSIRRPT1 BYCLRK RPT BY CLERK
 ;Input Parameters
 ;  FRDT   From Date - required - FileMan Format - No time
 ;  TODT   To Date - required - FileMan Format - No time
 ;  STATUS Status - String of selected statuses delimited by '^' or "ALL" forR
 ;         all. Defaults to the closed statuses EX and all dispositions of ACN.
 ;  DIVL   Divisions - String of selected divisions delimited by '^' or null
 ;         for all if you hold the DSIR MDIV key
 ;  REQS   Clerks - Array of Clerk IEN to file 200
 ;  SCHED  Schedule - Boolean for scheduled or immediate run
 ;         1 = Schedule / 0 or Null = Run Immediately
 ;  ESTART Earliet time to start the scheaduled task
 ;
 ;Return
 ;  When running immediately:
 ;    Array ^ delimited
 ;      1. Division Name
 ;      2. ROI Clerk Name
 ;      3. Patient Name
 ;      4. Patient SSN
 ;      5. Type of Request
 ;      6. External Date Received
 ;      7. External Date Closed (If present)
 ;
 ;  When running as a schedule
 ;    AXY(1)=Task Number
 ;
 ;  If an error occurs:
 ;    AXY(1)="-1^error message
 ;
 ; Test the input parameters:
 S AXY=$NA(^TMP("DSIRRPT1B",$J)),FRDT=$G(FRDT),TODT=$G(TODT) K @AXY
 I 'FRDT S @AXY@(1)="-1^Missing From Date" Q
 I 'TODT S @AXY@(1)="-1^Missing To Date" Q
 S SCHED=+$G(SCHED) I 'SCHED D BYREQ3(.AXY,FRDT,TODT,STATUS,DIVL,.REQS)
 I SCHED D
 .N RPT,EMSG,PARRAY,I
 .;CREATE THE REPORT SCHEDULE RECORD, FILE THE PARAMETERS, AND SUBMIT
 .S ESTART=$G(ESTART),RPT="REQUESTS BY CLERK",IEN=$$UDSCHED^DSIRRPTR(RPT,.ESTART)
 .S PARRAY(1)="S FRDT="_$G(FRDT),PARRAY(2)="S TODT="_$G(TODT),PARRAY(3)="S STATUS="""_STATUS_"""",PARRAY(4)="S DIVL="""_$G(DIVL)_""""
 .S I=0 F  S I=$O(REQS(I)) Q:'I  S PARRAY(I+4)="S REQS("_I_")="_REQS(I)
 .D PREPSUB^DSIRRPTR(.AXY,ESTART,RPT,"BYREQ2^DSIRRPT1",IEN,.PARRAY)
 Q
 ;************************
BYREQ2(SIEN) ; THIS IS LAUNCHED BY THE TASK MANAGER AND IT REASSEMBLES THE PARAMETERS
 N FRDT,TODT,DIVL,REQS,PRMS,RET,DONE S DONE=0,RET="TASK",ZTREQ="@" I '$$INIT^DSIRRPTR(SIEN) Q
 S ^TMP("AXY")=2
 D BYREQ3(.RET,FRDT,TODT,STATUS,DIVL,.REQS)   S ^TMP("AXY")=3 I 'DONE,'$$STOPCHK^DSIRRPTR(SIEN) D RPTDONE^DSIRRPTR(SIEN) ;
 Q
 ;************************
BYREQ3(AXY,FRDT,TODT,STATUS,DIVL,REQS) ;
 ;Input Parameters
 ;  RET    Holds the root of the return global 
 ;
 ;  See BYREQ for the rest of the parameter and return descriptions.
 ;
 N TASK,CLCHK,MDIV,DIVS,YY,II,ALLST,LOOPCT,LOOPCHK S LOOPCT=1,LOOPCHK=50
 S TASK=($G(AXY)="TASK") I TASK S AXY=$NA(^TMP("DSIRRPT1B",$J))
 S CDIV=$G(DUZ(2))
 I CDIV']"" S @AXY@(1)="-1^Missing the requestor division or not logged in." Q 
 S CLCHK=0,STATUS=$TR($G(STATUS),"~",U),DIVL=$TR($G(DIVL),"~",U)
 S MDIV=$D(^XUSEC("DSIR MDIV",DUZ)) S DIVS=$G(DIVL)]"",YY=0
 I DIVS F II=1:1:$L(DIVL,U) S:$P(DIVL,U,II) DIVS($P(DIVL,U,II))=""
 K @AXY,^TMP("DSIR",$J)
 D LDSTAR(.STATUS) S ALLST=(STATUS="ALL"),TODT=TODT+.3,REQS=$D(REQS)>1
 I REQS S II=0 F  S II=$O(REQS(II)) Q:'II  S RQS(REQS(II))=""
 I ALLST D BRLOOP("AOP"),BRLOOP("ACL"):'DONE
 I 'ALLST D
 .S II="" F  S II=$O(STATUS(II)) Q:II=""  I "AECNX"[$E(II) S CLCHK=CLCHK+1
 .I $D(STATUS("O"))!$D(STATUS("P"))!$D(STAT("P-P"))!$D(STATUS("P-C"))!$D(STATUS("P-H")) D BRLOOP("AOP") Q:DONE
 .I CLCHK D BRLOOP("ACL")
 K ^TMP("DSIR",$J)
 I 'YY S @AXY@(1)="-1^"_"No records found for sort criteria!"
 I TASK,'DONE N CT D WP^DIE(19620.35,SIEN_",",2,"",AXY,"EMSG")
 I TASK K @AXY
 Q
 ;************************
BRLOOP(XRF) ;
 N LODT,IEN,DIV,RQFOR,ST,CLRK S LODT=FRDT-.001
 F  S LODT=$O(^DSIR(19620,XRF,LODT)) Q:('LODT)!(LODT>TODT)!DONE  D
 .I TASK S LOOPCT=LOOPCT+1 I '(LOOPCT#LOOPCHK),$G(SIEN),$$STOPCHK^DSIRRPTR(SIEN) S DONE=1 Q
 .S IEN=0 F  S IEN=$O(^DSIR(19620,XRF,LODT,IEN)) Q:('IEN)!DONE  D
 ..I TASK S LOOPCT=LOOPCT+1 I '(LOOPCT#LOOPCHK),$G(SIEN),$$STOPCHK^DSIRRPTR(SIEN) S DONE=1 Q
 ..S DIV=+$P($G(^DSIR(19620,IEN,6)),U,3)
 ..S RQFOR=$S($P(^DSIR(19620,IEN,0),U)["DPT":1,$P(^DSIR(19620,IEN,0),U)[19620.96:2,1:0)
 ..I 'MDIV,DIV'=CDIV Q  ;Multidivisional Check - No key and not in your division
 ..I MDIV,DIVS,'$D(DIVS(DIV)) Q  ;Multidivisional Check - Key holder and divisions selected and not a selected division
 ..S ST=$P($$STONDAT^DSIROI6(IEN,DT),U),CLRK=+$P($G(^DSIR(19620,IEN,0)),U,3) Q:ST=""  I REQS Q:'$D(RQS(CLRK))
 ..I $D(STATUS(ST)) D GETS(19620,IEN,".63;.03;.01;10.01;10.05;10.06;10.07"),SSN I '$D(^TMP("DSIR",$J,IEN)) S YY=YY+1,^TMP("DSIR",$J,IEN)="",@RET@(YY)=XX
 Q
 ;************************
GETS(FILE,IEN,FLDS) ;
 N DATA,II S IEN=IEN_",",(XI,XX)=""
 D GETS^DIQ(FILE,IEN,FLDS,"EI","DATA") I FLDS[.63&('$G(DATA(FILE,IEN,.63,"I"))) D
 .N DSIR S DSIR(19620,IEN,.63)=$G(CDIV) D FILE^DIE("","DSIR"),GETS^DIQ(FILE,IEN,.63,"EI","DATA")
 I FLDS[10.05 N STAT S STAT=$$STONDAT^DSIROI6(+IEN,DT),DATA(FILE,IEN,10.05,"I")=$P(STAT,U),DATA(FILE,IEN,10.05,"E")=$P(STAT,U,2)
 F II=1:1:$L(FLDS,";") S XX=XX_$G(DATA(FILE,IEN,$P(FLDS,";",II),"E"))_U,XI=XI_$G(DATA(FILE,IEN,$P(FLDS,";",II),"I"))_U
 S XX=$E(XX,1,$L(XX)-1)
 Q
 ;************************
SSN ;
 N SSN,FIL,IENS D:RQFOR  S:'RQFOR SSN="N/A"
 .S FIL=$S(RQFOR=1:2,RQFOR=2:19620.96,1:0),IENS=+$P(XI,U,3)_","
 .D GETS^DIQ(FIL,IENS,.09,"I","SSN")
 .S SSN=$G(SSN(FIL,IENS,.09,"I"))
 S XX=$P(XX,U,1,3)_U_SSN_U_$P(XX,U,4,999)
 Q
 ;************************
LDSTAR(STATS) ;Load the Status array with requested statuses
 N ST
 I STATS="" D  Q
 .F ST="E","X","C-D","C-G","C-P","C-PR","A-RV","A-PR","N-RC","N-NR","N-RF","N-ND","N-NV","N-NP","N-NF","N-NU","N-MS","N-PD","N-PA","N-G","N-SL" S STATS(ST)=""
 I STATS="ALL" D  Q
 .F ST="O","P","P-C","P-P","P-H","E","X","C-D","C-G","C-P","C-PR","A-RV","A-PR","N-RC","N-NR","N-RF","N-ND","N-NV","N-NP","N-NF","N-NU","N-MS","N-PD","N-PA","N-G","N-SL" S STATS(ST)=""
 F ST=1:1:$L(STATS,U) S STATS($P(STATS,U,ST))=""
 Q
 ;************************
 ; Requests by requestor type report
RTYP(AXY,FRDT,TODT,STATUS,DIVL,TYPS,SCHED,ESTART) ;RPC - DSIRRPT1 RTYP REQUESTS BY TYPE
 ; INPUT PARAMETERS
 ;  FRDT   - first date to report on
 ;  TODT   - last date to report on
 ;  STATUS - List of selected status codes
 ;  DIVL   - List of selected divisions - "ALL" means all divisions 
 ;  TYPS   - Types of requestors - pointer to file 19620.71
 ;  SCHED  Schedule - Boolean for scheduled or immediate run
 ;         1 = Schedule / 0 or Null = Run Immediately
 ;  ESTART Earliet time to start the scheaduled task
 ;              
 ;Return
 ;  When running immediately:
 ;    Array ^ delimited
 ;       1. DIVISION VAMC
 ;       2. REQUESTOR TYPE
 ;       3. STATUS
 ;       4. CLOSED DATE
 ;       5. DATE RECEIVED
 ;       6. CORPORATE NAME
 ;       7. LAST NAME
 ;       8. FIRST NAME
 ;       9. ADDRESS1
 ;      10. ADDRESS2
 ;      11. CITY
 ;      12. STATE
 ;      13. ZIP
 ;      14. ADDRESS3
 ;      15. PHONE
 ;      16. FAX
 ;
 ;  When running as a schedule
 ;    AXY(1)=Task Number
 ;
 ;  If an error occurs:
 ;    AXY(1)="-1^error message
 ;
 ; Test the input parameters:
 S AXY=$NA(^TMP("DSIRRPT1T",$J)),SCHED=+$G(SCHED) K @AXY
 I '$G(FRDT) S @AXY@(1)="-1^Missing From Date" Q
 I '$G(TODT) S @AXY@(1)="-1^Missing To Date" Q
 I 'SCHED D RTYP3(.AXY,FRDT,TODT,STATUS,DIVL,.TYPS)
 I SCHED D
 .N PARRAY,RPT,EMSG,I
 .;CREATE THE REPORT SCHEDULE RECORD, FILE THE PARAMETERS, AND SUBMIT
 .S RPT="REQUESTS BY TYPE",ESTART=$G(ESTART),IEN=$$UDSCHED^DSIRRPTR(RPT,.ESTART)
 .S PARRAY(1)="S FRDT="_$G(FRDT),PARRAY(2)="S TODT="_$G(TODT),PARRAY(3)="S STATUS="""_STATUS_"""",PARRAY(4)="S DIVL="""_$G(DIVL)_""""
 .S I=0 F  S I=$O(TYPS(I)) Q:'I  S PARRAY(I+4)="S TYPS("_I_")="_TYPS(I)
 .D PREPSUB^DSIRRPTR(.AXY,ESTART,RPT,"RTYP2^DSIRRPT1",IEN,.PARRAY)
 Q
 ;************************
RTYP2(SIEN) ; THIS IS LAUNCHED BY THE TASK MANAGER AND IT REASSEMBLES THE PARAMETERS
 N FRDT,TODT,DIV,PRMS,RET,DONE S DONE=0,RET="TASK",ZTREQ="@" I '$$INIT^DSIRRPTR(SIEN) Q
 D RTYP3(.RET,FRDT,TODT,STATUS,DIVL,.TYPS)  I 'DONE,'$$STOPCHK^DSIRRPTR(SIEN) D RPTDONE^DSIRRPTR(SIEN) ;
 Q
 ;************************
RTYP3(AXY,FRDT,TODT,STATUS,DIVL,TYPS) ; Requests by Type
 ;Input Parameters
 ;
 ;  See RTYP for the parameter and return descriptions.
 ;
 N TASK,CLCHK,MDIV,DIVS,YY,ALLST,LOOPCT,LOOPCHK S LOOPCT=1,LOOPCHK=50
 S TASK=($G(AXY)="TASK") I TASK S AXY=$NA(^TMP("DSIRRPT1T",$J))
 S CDIV=$G(DUZ(2)) I CDIV']"" S @AXY@(1)="-1^Missing the requestor division or not logged in." Q 
 S CLCHK=0,STATUS=$TR($G(STATUS),"~",U),DIVL=$TR($G(DIVL),"~",U)
 S MDIV=$D(^XUSEC("DSIR MDIV",DUZ)) S DIVS=$G(DIVL)]""
 I DIVS F II=1:1:$L(DIVL,U) S:$P(DIVL,U,II) DIVS($P(DIVL,U,II))=""
 S YY=0,TYPS=$D(TYPS)>1,ALLST=(STATUS="ALL")
 S TODT=TODT+.3,FLDS=".63;10.04;10.05;10.07;10.06" D LDSTAR(.STATUS)
 I TYPS S II=0 F  S II=$O(TYPS(II)) Q:'II  S TYPE(TYPS(II))=""
 I ALLST D TYLOOP("AOP"),TYLOOP("ACL"):'DONE
 I 'ALLST D
 .S II="" F  S II=$O(STATUS(II)) Q:II=""!DONE  I "AECNX"[$E(II) S CLCHK=CLCHK+1
 .I $D(STATUS("O"))!$D(STATUS("P"))!$D(STATUS("P-P"))!$D(STATUS("P-H"))!$D(STATUS("P-C")) D TYLOOP("AOP") Q:DONE
 .I CLCHK D TYLOOP("ACL")
 K ^TMP("DSIR",$J)
 I 'YY S @AXY@(1)="-1^"_"No records found for sort criteria!"
 I TASK,'DONE N CT D WP^DIE(19620.35,SIEN_",",2,"",AXY,"EMSG")
 I TASK K @AXY
 Q
 ;
 ;************************
TYLOOP(XRF) ;
 N CT S CT=1
 S LODT=FRDT-.1
 F  S LODT=$O(^DSIR(19620,XRF,LODT)) Q:LODT>TODT!('LODT)  D  Q:DONE
 .I TASK S LOOPCT=LOOPCT+1 I '(LOOPCT#LOOPCHK),$G(SIEN),$$STOPCHK^DSIRRPTR(SIEN) S DONE=1 Q
 .S IEN=0 F  S IEN=$O(^DSIR(19620,XRF,LODT,IEN)) Q:'IEN  D  Q:DONE
 ..I TASK S LOOPCT=LOOPCT+1 I '(LOOPCT#LOOPCHK),$G(SIEN),$$STOPCHK^DSIRRPTR(SIEN) S DONE=1 Q
 ..S DIV=+$P($G(^DSIR(19620,IEN,6)),U,3)
 ..; Multidivisional Check - No key and not in your division
 ..I 'MDIV,DIV'=CDIV Q
 ..; Multidivisional Check - Key holder and divisions selected and not a selected division
 ..I MDIV,DIVS,'$D(DIVS(DIV)) Q
 ..N ST S ST=$P($$STONDAT^DSIROI6(IEN,DT),U),TYPE=+$P($G(^DSIR(19620,IEN,10)),U,4) Q:ST=""  I TYPS Q:'$D(TYPS(TYPE))
 ..;
 ..I $D(STATUS(ST)),'$D(^TMP("DSIR",$J,IEN)) D GETS(19620,IEN,FLDS) D  S YY=YY+1,@AXY@(YY)=XX,^TMP("DSIR",$J,IEN)=""
 ...S RQTR=+$G(^DSIR(19620,IEN,1)) Q:'RQTR
 ...S XXB=XX D GETS(19620.12,RQTR,".14;.13;.11")
 ...S XXC=XXB_U_XX S IENS=IEN_","
 ...;New Code (3 lines) for updated address processing
 ...N GET D GETS^DIQ(19620,IENS,".81","I","GET") S RADDPTR=GET(19620,IENS,.81,"I")
 ...D GETS(19620.92,RADDPTR,".02;.03;.04;.05;.06;.11;1.01;1.02")
 ...S XX=XXC_U_XX
 Q
