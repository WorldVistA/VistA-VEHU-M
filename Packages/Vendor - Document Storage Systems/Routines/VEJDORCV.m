VEJDORCV ;DSS/AMC - copied and modified ORWCV ;6/2/2000
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
START(VAL,DFN,IP,HWND,LOC,NODO,NEWREM)  ; start cover sheet build in background
 N ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC,SECT,BACK,X,I
 D GETLST^XPAR(.X,"SYS^PKG","ORWOR COVER RETRIEVAL","Q")
 S LOC=$G(LOC),NODO=$G(NODO),NEWREM=+$G(NEWREM)
 S I=0 F  S I=$O(X(I)) Q:'I  S SECT($P(X(I),U))=$P(X(I),U,2)
 S (VAL,BACK)=""
 F X="p","c","m","r","l","v","e" D       ; loop thru cover sections
 . I NODO[X Q                            ; if in NODO, dont do section
 . I '$G(SECT(X)) S VAL=VAL_X            ; load section in foreground
 . E  S BACK=BACK_X                      ; load section in background
 Q:BACK=""
 S ZTIO="ORW THREAD RESOURCE",ZTRTN="BUILD^ORWCV",ZTDTH=$H
 S (ZTSAVE("DFN"),ZTSAVE("IP"),ZTSAVE("HWND"),ZTSAVE("NEWREM"),ZTSAVE("LOC"),ZTSAVE("BACK"))=""
 S ZTDESC="CPRS GUI Background Data Retrieval"
 D ^%ZTLOAD I '$D(ZTSK) S VAL=$TR("pcmrlve",NODO) Q
 S NODE="ORWCV "_IP_"-"_HWND_"-"_DFN
 K ^XTMP(NODE)
 S ^XTMP(NODE,0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"Background CPRS "_ZTSK
 Q
BUILD ; called in background by task manager, expects DFN, JobID
 S NODE="ORWCV "_IP_"-"_HWND_"-"_DFN
 I $D(ZTQUEUED) S ZTREQ="@"
 I $G(^XTMP(NODE,"STOP")) K ^XTMP(NODE) Q  ; client no longer polling
 I '$D(^XTMP(NODE,0)) Q                    ; XTMP node has been purged
 L +^XTMP(NODE)
 S ^XTMP(NODE,"DFN")=DFN
 I BACK["p" D LIST^ORQQPL(.LST,DFN,"A"),LST2XTMP("PROB") ; problem list
 I BACK["c" D LIST^ORQQPP(.LST,DFN),LST2XTMP("CWAD")     ; postings
 I BACK["m" D COVER^ORWPS(.LST,DFN),LST2XTMP("MEDS")     ; meds
 I BACK["l" D LAB(.LST,DFN),LST2XTMP("LABS")              ; labs
 I BACK["v" D FASTVIT^ORQQVI(.LST,DFN,"",""),LST2XTMP("VITL") ; vitals
 I BACK["e" D VST(.LST,DFN),LST2XTMP("VSIT")             ;appts
 I BACK["r" D                                            ; reminders
 .I +$G(NEWREM) D APPL^ORQQPXRM(.LST,DFN,LOC) I 1
 .E  D REMIND^ORQQPX(.LST,DFN)
 .D LST2XTMP("RMND")
 S ^XTMP(NODE,"DONE")=1
 I $G(^XTMP(NODE,"STOP")) K ^XTMP(NODE)
 L -^XTMP(NODE)
 Q
LST2XTMP(ID)     ; put the list in ^XTMP(NODE,ID)
 I $G(^XTMP(NODE,"STOP")) Q
 K ^XTMP(NODE,ID) M ^XTMP(NODE,ID)=LST S ^XTMP(NODE,ID)=1 K LST
 Q
POLL(LST,DFN,IP,HWND)       ; poll for completed cover sheet parts
 N I,ILST,ID,NODE,DONE
 S NODE="ORWCV "_IP_"-"_HWND_"-"_DFN,ILST=0,DONE=0
 I '$D(^XTMP(NODE,"DFN")) Q
 I ^XTMP(NODE,"DFN")'=DFN S LST(1)="~DONE=1" Q
 I $G(^XTMP(NODE,"DONE")) S ILST=ILST+1,LST(ILST)="~DONE=1",DONE=1
 F ID="PROB","CWAD","MEDS","RMND","LABS","VITL","VSIT" D
 . I '$G(^XTMP(NODE,ID)) Q
 . S ILST=ILST+1,LST(ILST)="~"_ID
 . S I=0 F  S I=$O(^XTMP(NODE,ID,I)) Q:'I  S ILST=ILST+1,LST(ILST)="i"_^(I)
 . K ^XTMP(NODE,ID)
 I DONE K ^XTMP(NODE)
 Q
STOP(OK,DFN,IP,HWND)    ; stop cover sheet data retrieval
 S NODE="ORWCV "_IP_"-"_HWND_"-"_DFN,ILST=0,DONE=0
 S ^XTMP(NODE,"STOP")=1,OK=1
 L +^XTMP(NODE)
 I $G(^XTMP(NODE,"DONE")) K ^XTMP(NODE)
 L -^XTMP(NODE)
 Q
CLEAN ; clean up ^XTMP nodes
 S X="ORWCV"
 F  S X=$O(^XTMP(X)) Q:$E(X,1,5)'="ORWCV"  W !,X K ^XTMP(X)
 Q
LAB(LST,DFN)    ; return labs for patient
 D LIST^ORQOR1(.LST,DFN,"LAB",4,"T-"_$$RNGLAB(DFN),"T","AW",1)
 Q
VST(ORVISIT,DFN,BEG,END,SKIP)    ; return appts/admissions for patient
 N VAERR,VASD,BDT,COUNT,DTM,EDT,LOC,NOW,ORLST,STI,STS,TODAY,I,XI,X
 S NOW=$$NOW^XLFDT(),TODAY=$P(NOW,".",1)
 I '$G(BEG) S BEG=$$X2FM($$RNGVBEG)
 I '$G(END) S END=$$X2FM($$RNGVEND_".2359")
 S COUNT=0
 ;
 I END>NOW D   ; get future encounters, past cancels/no-shows from VADPT
 . S VASD("F")=BEG
 . S VASD("T")=END
 . S VASD("W")="123456789"
 . D SDA^VADPT
 . S I=0 F  S I=$O(^UTILITY("VASD",$J,I)) Q:'I  D
 . . S XI=^UTILITY("VASD",$J,I,"I"),XE=^("E")
 . . S DTM=$P(XI,U),IEN=$P(XI,U,2),STI=$P(XI,U,3)
 . . S LOC=$P(XE,U,2),STS=$P(XE,U,3)
 . . I DTM<TODAY,(STI=""!(STI["I")!(STI="NT")) Q  ; no prior kept appts
 . . S ORLST(DTM,"A",1)="A;"_DTM_";"_IEN_U_DTM_U_LOC_U_STS
 . K ^UTILITY("VASD",$J)
 ;
 I BEG'>NOW D  ;past encounters from ACRP Toolkit - set in CALLBACK
 . S BDT=BEG
 . S EDT=$S(END<NOW:END,1:NOW)
 . D OPEN^SDQ(.ORQUERY)
 . I '$$ERRCHK^SDQUT() D INDEX^SDQ(.ORQUERY,"PATIENT/DATE","SET")
 . I '$$ERRCHK^SDQUT() D PAT^SDQ(.ORQUERY,DFN,"SET")
 . I '$$ERRCHK^SDQUT() D DATE^SDQ(.ORQUERY,BDT,EDT,"SET")
 . I '$$ERRCHK^SDQUT() D
 . . D SCANCB^SDQ(.ORQUERY,"D CALLBACK^ORWCV(Y,Y0,.ORLST,.ORSTOP)","SET")
 . I '$$ERRCHK^SDQUT() D ACTIVE^SDQ(.ORQUERY,"TRUE","SET")
 . I '$$ERRCHK^SDQUT() D SCAN^SDQ(.ORQUERY,"FORWARD")
 . D CLOSE^SDQ(.ORQUERY)
 ;
 I '$G(SKIP) D
 . N TIM,MOV,X0,Y,MTIM,XTYP,XLOC,HLOC,EARLY,DONE                ; admits
 . S EARLY=$$X2FM($$RNGVBEG),DONE=0
 . S TIM="" F  S TIM=$O(^DGPM("ATID1",DFN,TIM)) Q:TIM'>0  D  Q:DONE
 . . S MOV=0  F  S MOV=$O(^DGPM("ATID1",DFN,TIM,MOV)) Q:MOV'>0  D  Q:DONE
 . . . S X0=^DGPM(MOV,0),MTIM=$P(X0,U)
 . . . I MTIM<EARLY S DONE=1 Q
 . . . S XTYP=$P($G(^DG(405.1,+$P(X0,U,4),0)),U,1)
 . . . S XLOC=$P($G(^DIC(42,+$P(X0,U,6),0)),U,1),HLOC=+$G(^(44))
 . . . S ORLST(MTIM,"I",1)="I;"_MTIM_";"_HLOC_U_MTIM_U_"Inpatient Stay"_U_XLOC_U_XTYP
 ;
 S COUNT=0
 S I=0 F  S I=$O(ORLST(I)) Q:'I  D
 . S J="" F  S J=$O(ORLST(I,J)) Q:J=""  D
 . . S K=0 F  S K=$O(ORLST(I,J,K)) Q:'K  D
 . . . S COUNT=COUNT+1
 . . . S ORVISIT(COUNT)=ORLST(I,J,K)
 N K,DATA S I=0 F  S I=$O(ORVISIT(I)) Q:'I  I "VSA"[$P(ORVISIT(I),";") S DATA=ORVISIT(I) D
 .N VDT,J,K S VDT=$P(ORVISIT(I),";",2),(K,J)=0
 .F  S J=$O(^AUPNVSIT("B",VDT,J)) Q:'J  I $P($G(^AUPNVSIT(J,0)),U,5)=DFN S ORVISIT(I+K)=DATA_"^"_J,K=K+.01
 .S I=I+.99
 Q
CALLBACK(IEN,NODE0,ARRAY,STOP) ; called back from ACRP Toolkit for encounters
 ;
 ; IEN and NODE0 relate to Outpatient Encounter File
 ; set STOP to 1 if need to quit
 ;
 N COUNT,DTM,LOC,OOS,TYPE,XSTAT,XLOC
 S DTM=+NODE0,COUNT=1
 S LOC=$P(NODE0,"^",4)
 S XLOC=$P($G(^SC(+LOC,0)),U),OOS=$G(^("OOS"))
 I OOS Q              ; ignore OOS locations
 I $P(NODE0,"^",6) Q  ; not parent encounter
 S XSTAT=$P($G(^SD(409.63,+$P(NODE0,"^",12),0)),"^")
 S TYPE=$S($P(NODE0,"^",8)=1:"A",1:"V")
 I TYPE="V",$D(ARRAY(DTM,"V")) S COUNT=$O(ARRAY(DTM,"V","A"),-1)+1 ; same d/t
 S ARRAY(DTM,TYPE,COUNT)=TYPE_";"_DTM_";"_LOC_U_DTM_U_XLOC_U_XSTAT
 Q
DTLVST(RPT,DFN,X)   ; return progress notes / discharge summary
 N VISIT
 I $P(X,";")="A" D
 . S VISIT=$$APPT2VST^PXAPI(DFN,$P(X,";",2),$P(X,";",3))
 . D DETNOTE^ORQQVS(.RPT,DFN,VISIT)
 I $P(X,";")="V" D
 . S VISIT=+$$GETENC^PXAPI(DFN,$P(X,";",2),$P(X,";",3))
 . D DETNOTE^ORQQVS(.RPT,DFN,VISIT)
 I $P(X,";")="I" D
 . S VISIT=+$$GETENC^PXAPI(DFN,$P(X,";",2),$P(X,";",3))
 . D DETSUM^ORQQVS(.RPT,DFN,VISIT)
 . K ^TMP("PXKENC",$J)
 Q
X2FM(X)       ; return FM date given relative date
 N %DT S %DT="TS" D ^%DT
 Q Y
RNGLAB(DFN)     ; return days back for patient
 N INPT,PAR
 S INPT=0 I $L($G(^DPT(DFN,.1))) S INPT=1
 S PAR="ORQQLR DATE RANGE "_$S(INPT:"INPT",1:"OUTPT")
 Q $$GET^XPAR("ALL",PAR,1,"I")
 ;
RNGVBEG()       ; return start date for encounters
 Q $$GET^XPAR("ALL","ORQQVS SEARCH RANGE START",1,"I")
 ;
RNGVEND()       ; return stop date for encounters
 Q $$GET^XPAR("ALL","ORQQAP SEARCH RANGE STOP",1,"I")
 ;
RANGES(REC,DFN) ; return ranges given a patient
 N REC
 S REC=$$RNGLAB(DFN)_U_$$RNGVBEG_U_$$RNGVEND
 Q
  
