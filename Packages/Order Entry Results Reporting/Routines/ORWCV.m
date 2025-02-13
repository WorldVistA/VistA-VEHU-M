ORWCV ;SLC/KCM - Background Cover Sheet Load;03/06/20  13:00
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,109,132,209,214,195,215,260,243,282,302,280,496,377**;Dec 17, 1997;Build 582
 ;
 ;
 ; DBIA 36      Reference to ^DIC(42
 ; DBIA 518     Reference to ^SC(
 ; DBIA 1096    Reference to ^DGPM("ATID1"
 ; DBIA 1894    Reference to GETENC^PXAPI
 ; DBIA 1895    Reference to APPT2VST^PXAPI
 ; DBIA 2096    Reference to ^SD(409.63
 ; DBIA 2437    Reference to ^DGPM(
 ; DBIA 2965    Reference to ^DG(405.1
 ; DBIA 4011    Access ^XWB(8994)
 ; DBIA 4313    Direct R/W permission to capacity mgmt global ^KMPTMP("KMPDT")
 ; DBIA 4325    References to AWCMCPR1
 ; DBIA 10061   Reference to ^UTILITY
 ;
START(VAL,DFN,IP,HWND,LOC,NODO,NEWREM) ; start cover sheet build in background
 N ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC,ZTSK,SECT,BACK,X,I,ORLIST,FILE,NODE,ORHTIME,ORX
 ; Capacity planning timing code uses ORHTIME
 S ORHTIME=$H
 S LOC=$G(LOC),NODO=";"_$G(NODO),NEWREM=+$G(NEWREM)
 D GETLST^XPAR(.ORX,"SYS^PKG","ORWOR COVER RETRIEVAL NEW","Q")
 S I=0 F  S I=$O(ORX(I)) Q:'I  I $D(^ORD(101.24,+ORX(I),0)) S SECT(+$P(^(0),U,2))=$P(ORX(I),U,2)
 D GETLST^XPAR(.ORLIST,"ALL","ORWCV1 COVERSHEET LIST")
 S (VAL,BACK,FILE)=""
 F  S I=$O(ORLIST(I)) Q:'I  I $D(^ORD(101.24,$P(ORLIST(I),U,2),0))  S X0=^(0) D
 . Q:$P(X0,U,8)'="C"
 . S X=$P(X0,U,2)
 . I NODO[(";"_X_";") Q                                  ; if in NODO, dont do section
 . I '$G(SECT(X)) S VAL=VAL_X_";"                        ; load section in foreground
 . E  S BACK=BACK_X_";",FILE=FILE_$P(ORLIST(I),U,2)_";"  ; load section in background
 Q:BACK=""
 S ZTIO="ORW THREAD RESOURCE",ZTRTN="BUILD^ORWCV",ZTDTH=$H
 S (ZTSAVE("DFN"),ZTSAVE("IP"),ZTSAVE("HWND"),ZTSAVE("NEWREM"),ZTSAVE("LOC"),ZTSAVE("BACK"),ZTSAVE("FILE"))=""
 S ZTDESC="CPRS GUI Background Data Retrieval"
 D ^%ZTLOAD I '$D(ZTSK) S VAL=VAL_BACK Q
 S NODE="ORWCV "_IP_"-"_HWND_"-"_DFN
 K ^XTMP(NODE)
 S ^XTMP(NODE,0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"Background CPRS "_ZTSK
 ; Start capacity planning timing clock - will be stopped in POLL code
 I +$G(^KMPTMP("KMPD-CPRS")) S ^KMPTMP("KMPDT","ORWCV",NODE)=$G(ORHTIME)_"^^"_$G(DUZ)_U_$G(IO("CLNM"))
 Q
BUILD ; called in background by task manager, expects DFN, JobID
 N NODE,IFLE,ORFNUM,ID,ENT,RTN,INODE,PARAM1,PARAM2,DETAIL,X0,X2
 S NODE="ORWCV "_IP_"-"_HWND_"-"_DFN
 I $D(ZTQUEUED) S ZTREQ="@"
 I $G(^XTMP(NODE,"STOP")) K ^XTMP(NODE) Q  ; client no longer polling
 I '$D(^XTMP(NODE,0)) Q                    ; XTMP node has been purged
 L +^XTMP(NODE):$S($G(DILOCKTM)>0:DILOCKTM,1:5)
 S ^XTMP(NODE,"DFN")=DFN
 F IFLE=1:1:$L(FILE,";")  D
 . N $ETRAP,$ESTACK,CALL
 . S $ETRAP="D ERR^ORWCV"
 . S ORFNUM=$P(FILE,";",IFLE) Q:'$D(^ORD(101.24,+ORFNUM,0))
 . S X0=^ORD(101.24,+ORFNUM,0),X2=$G(^(2))
 . S ID=$P(X0,U,2),ENT=$P(X0,U,6),RTN=$P(X0,U,5),PARAM1=$P(X2,U)
 . S PARAM2=$P(X2,U,2),INODE=$P(X2,U,5),DETAIL=""
 . I $P(X0,U,18) S DETAIL=$P($G(^ORD(101.24,+$P(X0,U,18),0)),U,13),DETAIL=$P($G(^XWB(8994,+DETAIL,0)),U)  ;DBIA 4011
 . I '$L(INODE) Q
 . I '$L(ENT) S LST(IFLE)="0^ERROR: Missing ENTRY POINT field in file 101.24 for "_$P(X0,U)_", IFN="_+ORFNUM D LST2XTMP(INODE) Q
 . I '$L(RTN) S LST(IFLE)="0^ERROR: Missing ROUTINE field in file 101.24 for "_$P(X0,U)_", IFN="_+ORFNUM D LST2XTMP(INODE) Q
 . I '$L($T(@(ENT_U_RTN))) S LST(IFLE)="0^ERROR: "_ENT_"~"_RTN_" does not exist. See file 101.24 entry: "_$P(X0,U)_", IFN="_+ORFNUM D LST2XTMP(INODE) Q
 . S CALL="(.LST,DFN"
 . I ID=50 S CALL="REM^ORWCV"_CALL_","""_ENT_U_RTN_""""
 . E  S CALL=ENT_U_RTN_CALL
 . I $L(PARAM1) S CALL=CALL_",PARAM1"
 . I $L(PARAM2) S CALL=CALL_",PARAM2"
 . S CALL=CALL_")"
 . D @(CALL),LST2XTMP(INODE)
 S ^XTMP(NODE,"DONE")=1
 I $G(^XTMP(NODE,"STOP")) K ^XTMP(NODE)
 L -^XTMP(NODE)
 Q
ERR ;Error trap
 I $D(NODE),$D(INODE) K LST S LST(0)="",LST(1)="0^ERROR DURING COVER SHEET BUILD:"_$$EC^%ZOSV
 D @^%ZOSF("ERRTN") ;file error
 S $ECODE=""
 Q
LST2XTMP(ID) ; put the list in ^XTMP(NODE,ID)
 I $G(^XTMP(NODE,"STOP")) Q
 N I
 I $L($G(DETAIL)) S I=0 F  S I=$O(LST(I)) Q:'I  S $P(LST(I),U,12)=DETAIL
 K ^XTMP(NODE,ID) M ^XTMP(NODE,ID)=LST S ^XTMP(NODE,ID)=1 K LST
 S ^XTMP(NODE,"PANELS",ID)=""
 Q
POLL(LST,DFN,IP,HWND,ONLYID) ; poll for completed cover sheet parts
 N ILST,ID,NODE,DONE
 I '$D(DFN)!('$D(IP))!('$D(HWND)) S LST="" Q
 S NODE="ORWCV "_IP_"-"_HWND_"-"_DFN,ILST=0,DONE=0
 I '$D(^XTMP(NODE,"DFN")) Q
 I ^XTMP(NODE,"DFN")'=DFN S LST(1)="~DONE=1" Q
 I $G(^XTMP(NODE,"DONE")) S ILST=ILST+1,LST(ILST)="~DONE=1",DONE=1
 I $D(ONLYID) D
 . D CHK(NODE,ONLYID,.ILST,.LST)
 . I DONE,$D(^XTMP(NODE,"PANELS")) S DONE=0
 I '$D(ONLYID) S ID="" F  S ID=$O(^XTMP(NODE,ID)) Q:ID=""  D
 . D CHK(NODE,ID,.ILST,.LST)
 ; Stop capacity planning timing clock - was started in START code
 I DONE K ^XTMP(NODE) I +$G(^KMPTMP("KMPD-CPRS")) S $P(^KMPTMP("KMPDT","ORWCV",NODE),U,2)=$H
 Q
CHK(NODE,ID,ILST,LST) ; check an individual panel
 N I
 I '$G(^XTMP(NODE,ID)) Q
 S ILST=ILST+1,LST(ILST)="~"_ID
 S I=0 F  S I=$O(^XTMP(NODE,ID,I)) Q:'I  S ILST=ILST+1,LST(ILST)="i"_^(I)
 K ^XTMP(NODE,ID),^XTMP(NODE,"PANELS",ID)
 Q
STOP(OK,DFN,IP,HWND) ; stop cover sheet data retrieval
 S NODE="ORWCV "_IP_"-"_HWND_"-"_DFN,ILST=0,DONE=0
 S ^XTMP(NODE,"STOP")=1,OK=1
 L +^XTMP(NODE):$S($G(DILOCKTM)>0:DILOCKTM,1:5)
 I $G(^XTMP(NODE,"DONE")) K ^XTMP(NODE)
 L -^XTMP(NODE)
 Q
CLEAN ; clean up ^XTMP nodes
 S X="ORWCV"
 F  S X=$O(^XTMP(X)) Q:$E(X,1,5)'="ORWCV"  W !,X K ^XTMP(X)
 Q
LAB(LST,DFN) ; return labs for patient
 D:$L($T(STRT2^AWCMCPR1)) STRT2^AWCMCPR1
 D LIST^ORQOR1(.LST,DFN,"LAB",4,"T-"_$$RNGLAB(DFN),"T","AW",1)
 D:$L($T(END^AWCMCPR1)) END^AWCMCPR1
 Q
REM(LST,DFN,OLDCALL) ; return reminders for patient
 I $L($T(STRT3^AWCMCPR1))>0 D STRT3^AWCMCPR1
 I $G(NEWREM) D APPL^ORQQPXRM(.LST,DFN,LOC)
 I '$G(NEWREM) D @(OLDCALL_"(.LST,DFN)")
 I $L($T(END^AWCMCPR1))>0 D END^AWCMCPR1
 Q
VST1(ORVISIT,DFN,BEG,END,SKIP) ;
 N ERR,ERRMSG
 S ERR=0 ; kludge to return errors
 Q:'$G(DFN)
 D VST(.ORVISIT,DFN,.BEG,.END,$G(SKIP),.ERR,.ERRMSG)
 I ERR K ORVISIT S ORVISIT(1)=ERRMSG
 Q
 ;
TEST ;D VST(.ZZZ,76,2950101,3050401,777,1,1)
 Q
VST(ORVISIT,DFN,BEG,END,SKIP,ERR,ERRMSG) ; return appts/admissions for patient
 N CHECKERR,VAERR,VASD,BDT,COUNT,DTM,EDT,LOC,NOW,ORQUERY,ORLST,STI,STS,TODAY,I,J,K,XI,XE,X
 S CHECKERR=($G(ERR)=0) ; kludge to check for errors
 S NOW=$$NOW^XLFDT(),TODAY=$P(NOW,".",1)
 I '$G(BEG) S BEG=$$X2FM($$RNGVBEG)
 I '$G(END) S END=$$X2FM($$RNGVEND)+0.2359
 S COUNT=0
 K ^TMP("ORVSTLIST",$J)
 S VAERR=0
 I END>NOW D   Q:VAERR  ; get future encounters, past cancels/no-shows from VADPT
 . S VASD("F")=BEG
 . S VASD("T")=END
 . S VASD("W")="123456789"
 . D SDA^ORQRY01(.ERR,.ERRMSG)
 . I CHECKERR,ERR K ^UTILITY("VASD",$J) S ORVISIT(1)=ERRMSG Q  ;IA 10061
 . S I=0 F  S I=$O(^UTILITY("VASD",$J,I)) Q:'I  D
 . . S XI=^UTILITY("VASD",$J,I,"I"),XE=^("E")
 . . S DTM=$P(XI,U),IEN=$P(XI,U,2),STI=$P(XI,U,3)
 . . S LOC=$P(XE,U,2),STS=$P(XE,U,3)
 . . I DTM<TODAY,(STI=""!(STI["I")!(STI="NT")) Q  ; no prior kept appts
 . . S ^TMP("ORVSTLIST",$J,DTM,"A",1)="A;"_DTM_";"_IEN_U_DTM_U_LOC_U_STS
 . K ^UTILITY("VASD",$J)
 I BEG'>NOW D  ;past encounters from ACRP Toolkit - set in CALLBACK
 . S BDT=BEG
 . S EDT=$S(END<NOW:END,1:NOW)
 . D COVER^SDRROR
 . D OPEN^SDQ(.ORQUERY)
 . I '$$ERRCHK^SDQUT() D INDEX^SDQ(.ORQUERY,"PATIENT/DATE","SET")
 . I '$$ERRCHK^SDQUT() D PAT^SDQ(.ORQUERY,DFN,"SET")
 . I '$$ERRCHK^SDQUT() D DATE^SDQ(.ORQUERY,BDT,EDT,"SET")
 . I '$$ERRCHK^SDQUT() D
 . . S ORLST=$NA(^TMP("ORVSTLIST",$J))
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
 . . . S ^TMP("ORVSTLIST",$J,MTIM,"I",1)="I;"_MTIM_";"_HLOC_U_MTIM_U_"Inpatient Stay"_U_XLOC_U_XTYP
 ;
 S COUNT=0
 S I=0 F  S I=$O(^TMP("ORVSTLIST",$J,I)) Q:'I  D
 . S J="" F  S J=$O(^TMP("ORVSTLIST",$J,I,J)) Q:J=""  D
 . . S K=0 F  S K=$O(^TMP("ORVSTLIST",$J,I,J,K)) Q:'K  D
 . . . S COUNT=COUNT+1
 . . . S ORVISIT(COUNT)=^TMP("ORVSTLIST",$J,I,J,K)
 K ^TMP("ORVSTLIST",$J)
 Q
CALLBACK(IEN,NODE0,ARRAY,STOP) ; called back from ACRP Toolkit for encounters
 ;
 ; IEN and NODE0 relate to Outpatient Encounter File
 ; set STOP to 1 if need to quit
 ;
 N COUNT,DTM,LOC,OOS,TYPE,XSTAT,XLOC
 S DTM=+NODE0,COUNT=1
 S LOC=$P(NODE0,U,4)
 S XLOC=$P($G(^SC(+LOC,0)),U),OOS=$G(^("OOS"))
 I OOS Q              ; ignore OOS locations
 I $P(NODE0,U,6) Q  ; not parent encounter
 S XSTAT=$P($G(^SD(409.63,+$P(NODE0,U,12),0)),U)
 S TYPE=$S($P(NODE0,U,8)=1:"A",1:"V")
 I TYPE="V",$D(@ARRAY@(DTM,"V")) S COUNT=$O(@ARRAY@(DTM,"V","A"),-1)+1 ; same d/t
 S @ARRAY@(DTM,TYPE,COUNT)=TYPE_";"_DTM_";"_LOC_U_DTM_U_XLOC_U_XSTAT
 Q
DTLVST(RPT,DFN,IEN,APPTINFO) ; return progress notes / discharge summary
 N VISIT
 I $P(APPTINFO,";")="A" D  Q
 . S VISIT=$$APPT2VST^PXAPI(DFN,$P(APPTINFO,";",2),$P(APPTINFO,";",3))
 . I VISIT=0 S VISIT=+$$GETENC^PXAPI(DFN,$P(APPTINFO,";",2),$P(APPTINFO,";",3))
 . D DETNOTE^ORQQVS(.RPT,DFN,VISIT)
 . N X1,X2 S (X1,X2)=0 F  S X1=$O(RPT(X1)) Q:X1'>0  S X2=X1  ;get the last entry in the RPT list
 . I X2'>0 S X2=1
 . N XSD,XSDDT,SDURL
 . S XSD=$P(APPTINFO,";",3),XSDDT=$P(APPTINFO,";",2) ;look up the entry in the appointment multiple and get the url
 . Q:'$D(^SC($G(XSD),0))  ; No clinic
 . Q:'$D(^SC($G(XSD),"S",XSDDT))  ; No appointment at that time
 . K XX1 S XX1=0 F  S XX1=$O(^SC(XSD,"S",XSDDT,1,XX1)) Q:$G(XX1)'>0  D
 . . Q:$P(^SC(XSD,"S",XSDDT,1,XX1,0),"^",1)'=DFN
 . . Q:$G(SDURL)'=""
 . . S SDURL=$G(^SC(XSD,"S",XSDDT,1,XX1,"URL"))
 . S RPT(X2)=$G(SDURL)
 . K XSD,XSDDT,SDURL
 I $P(APPTINFO,";")="V" D  Q
 . S VISIT=+$$GETENC^PXAPI(DFN,$P(APPTINFO,";",2),$P(APPTINFO,";",3))
 . D DETNOTE^ORQQVS(.RPT,DFN,VISIT)
 I $P(APPTINFO,";")="I" D  Q
 . S VISIT=+$$GETENC^PXAPI(DFN,$P(APPTINFO,";",2),$P(APPTINFO,";",3))
 . D DETSUM^ORQQVS(.RPT,DFN,VISIT)
 . K ^TMP("PXKENC",$J)
 I $P(APPTINFO,";")="R" D RCDTL^SDRROR
 Q
X2FM(X) ; return FM date given relative date
 N %DT S %DT="TS" D ^%DT
 Q Y
RNGLAB(DFN) ; return days back for patient
 N INPT,PAR,LOC
 S INPT=0 I $L($G(^DPT(DFN,.1))) S INPT=1,LOC=^(.1)
 S PAR="ORQQLR DATE RANGE "_$S(INPT:"INPT",1:"OUTPT")
 Q $$GET^XPAR("ALL"_$S(INPT:"^LOC."_LOC,1:""),PAR,1,"I")
 ;
RNGVBEG() ; return start date for encounters
 Q $$GET^XPAR("ALL","ORQQCSDR CS RANGE START",1,"I")
 ;
RNGVEND() ; return stop date for encounters
 Q $$GET^XPAR("ALL","ORQQCSDR CS RANGE STOP",1,"I")
 ;
RANGES(REC,DFN) ; return ranges given a patient
 N REC
 S REC=$$RNGLAB(DFN)_U_$$RNGVBEG_U_$$RNGVEND
 Q
