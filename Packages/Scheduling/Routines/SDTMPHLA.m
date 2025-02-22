SDTMPHLA ;MS/PB - TMP HL7 Routine;May 29, 2018
 ;;5.3;Scheduling;**704,733,773,780,798,812,821**;SEP 26, 2018;Build 9
 Q
 ;        ;
EN(DFN,APTTM) ; Entry to the routine to build an HL7 message
 ;notification to TMP about a new appointment in a TeleHealth Clinic
 ;
 Q:$G(DFN)=""
 Q:$G(APTTM)=""
 N PARMS,SEG,WHOTO,SNODE,ANODE,CNODE,CLINODE,ERROR,MSG,ANODE1
 S (SSTOP,PSTOP,STOP)=0
 K CLINID
 S RTN=0,CAN=0
 S ANODE=$G(^DPT(DFN,"S",APTTM,0))
 S ANODE1=$G(^DPT(DFN,"S",APTTM,1))
 ;If this appointment was made by the TMP application, stop 773
 I $G(MSH(9)),$D(^XTMP("SDTMP",+MSH(9))) Q
 S CLINID=$P(ANODE,U,1)
 S CLINODE=$G(^SC(CLINID,0))
 S XX=0 F  S XX=$O(^SC(CLINID,"S",APTTM,1,XX)) Q:XX'>0  D  ;Get the correct appointment node for the patient
 .I $P(^SC(CLINID,"S",APTTM,1,XX,0),"^")=DFN S SNODE=$G(^SC(CLINID,"S",APTTM,1,XX,0)),CNODE=$P($G(^SC(CLINID,"S",APTTM,1,XX,"CONS")),"^")
 S PSTOP=$P(CLINODE,"^",7),SSTOP=$P(CLINODE,"^",18)
 ;If both stop codes are null, stop the check, we know it is not a tele health clinic
 Q:($G(PSTOP)="")&(($G(SSTOP))="")
 S STOP=$$CHKCLIN(PSTOP) ;if STOP=0, primary stop code is not a tele health stop code so check secondary stop code to see if it is a tele health clinic
 I $G(STOP)=0 Q:$G(SSTOP)'>0  S STOP=$$CHKCLIN(SSTOP) ; if primary stop code is not tele health check secondary stop code if secondary not tele health stop   ;773
 Q:$G(STOP)=0  ; Double check for either primary or secondary stop code to be a tele health clinic
 I $P($G(ANODE),"^",2)["C" S CAN=1
 S SNODE=$G(^SC(CLINID,"S",APTTM,1,1,0))
 S APTSTATUS=$$GET1^DIQ(2.98,APTTM_","_DFN_",",9.5,"E")
 S:CAN=0 PARMS("MESSAGE TYPE")="SIU",PARMS("EVENT")="S12"
 S:CAN=1 PARMS("MESSAGE TYPE")="SIU",PARMS("EVENT")="S15"
 I '$$NEWMSG^HLOAPI(.PARMS,.MSG,.ERROR) Q 0
 S SEQ=1
 D:CAN=0 SCH(DFN,SEQ,.SEG,$G(ANODE),$G(SNODE))
 I (CAN=0&('$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR))) Q 0
 D:CAN=1 SCHCAN(DFN,SEQ,.SEG,$G(ANODE),$G(SNODE),$G(CNODE))
 I (CAN=1&('$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR))) Q 0
 D NTE(.SEQ,.SEG)
 I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) Q 0
 D PID(DFN,SEQ,.SEG)
 I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) Q 0
 D PV1(DFN,SEQ,.SEG)
 I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) Q 0
 D RGS1("A",SEQ,.SEG)  ;required segment
 I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) Q 0
 D AIL1(ANODE,SEQ,.SEG)
 I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) Q 0
 S PARMS("SENDING APPLICATION")="TMP_OUT"
 S PARMS("APP ACK TYPE")="AL"
 S WHOTO("RECEIVING APPLICATION")="TMP VIMT"
 S WHOTO("FACILITY LINK NAME")="TMP_SEND"
 S WHOTO("FACILITY LINK IEN")=$O(^HLCS(870,"B","TMP_SEND",0))
 S RTN=$$SENDONE^HLOAPI1(.MSG,.PARMS,.WHOTO,.ERROR)
 K CAN,APTSTATUS,SSTOP,PSTOP,STOP,CLINID,PROVID,PROVNM,XX
 Q RTN
PID(DFN,SEQ,SEG) ;
 N VA,VADM,VAHOW,VAROOT,VATEST,VAPA,NAME,DOB,SSN,ICN,ADDRESS
 K SEG S SEG=""
 S VAHOW=1
 D DEM^VADPT
 S NAME=VADM("NM") D STDNAME^XLFNAME(.NAME,"C")
 S DOB=$P(VADM("DB"),"^"),SSN=$P(VADM("SS"),"^")
 S VAHOW=""
 D ADD^VADPT
 S ADDRESS("STREET")=VAPA(1),ADDRESS("STREET2")=VAPA(2),ADDRESS("CITY")=VAPA(4),ADDRESS("STATE")=$P(VAPA(5),"^",2),ADDRESS("ZIP")=VAPA(6)
 S ICN=$$GETICN^MPIF001(DFN)
 D SET^HLOAPI(.SEG,"PID",0) ; Set segment type to PID
 D SET^HLOAPI(.SEG,SEQ,1) ; Set PID-1
 ; set ICN into PID-3, repitition 1
 D SET^HLOAPI(.SEG,+ICN,3,1,1,1) ; Component 1, subcomponent 1, Patient ICN
 D SET^HLOAPI(.SEG,$P(ICN,"V",2),3,2,1,1) ; Component 1, subcomponent 2, Patient ICN checksum
 D SET^HLOAPI(.SEG,DFN,4,1,1,1) ; patient DFN
 D SET^HLOAPI(.SEG,"USVHA",3,4,1,1) ; component 4, subcomponent1
 D SET^HLOAPI(.SEG,"0363",3,5,1,1) ; component 5
 ; set SSN into PID-3, repetition 2
 D SET^HLOAPI(.SEG,SSN,3,1,1,2) ;component 1, subcomponent1
 D SET^HLOAPI(.SEG,"USSSA",3,4,1,2) ; Component 4, subcomponent 1
 D SET^HLOAPI(.SEG,"0363",3,4,3,2) ; component 4, subcomponent 3
 D SET^HLOAPI(.SEG,"SS",3,5,1,2) ; component 1
 ;Set the name inot PID-5
 D SETXPN^HLOAPI4(.SEG,.NAME,5)
 ; Set the DOB into PID-7
 D SETDT^HLOAPI4(.SEG,DOB,7)
 ; set the address into PID-11
 D SETAD^HLOAPI4(.SEG,.ADDRESS,11)
 Q
PD1      ; Not needed right now
 Q
PV1(DFN,SEQ,SEG) ;
 N FAC
 S CLASS="OUTPATIENT"
 S FAC=$$KSP^XUPARAM("INST")
 D SET^HLOAPI(.SEG,"PV1",0) ; Set the segment type
 D SET^HLOAPI(.SEG,SEQ,1) ; Set the PV1-1
 ; set the PV1-2, patient class (tbl 5-20 in the TMP HL7 specification
 D SET^HLOAPI(.SEG,CLASS,2) ;
 ; set the PV1-4, Purpose of Visit
 D SET^HLOAPI(.SEG,APTSTATUS,4)
 ; set the PV1-7, provider
 D SET^HLOAPI(.SEG,$G(PROVID),7,1,1)
 D SET^HLOAPI(.SEG,$G(PROVNM),7,2,1)
 ; set the PV1-39 facility id
 D SET^HLOAPI(.SEG,FAC,39)
 K CLASS
 Q
SCH(DFN,SEQ,SEG,ANODE,SNODE)  ; update for new appointments
 N APTSTATUS,LENGTH,TMUNITS,SCHED,ENTEREDBY,STATUS,START,CONNM,PREMAIL,END
 S:$G(SNODE)'="" LENGTH=$P($G(SNODE),"^",2)
 S TMUNITS="M"
 ;821 Create best default LENGTH variable.  Also, the main value will be found in SDECLEN variable that is
 ;used by SDEC07 & 08A APIs, as a key param. If not there, use the new best default variable.
 N LENDEF S:$G(SDECAPPTID) LENDEF=$P(^SDEC(409.84,SDECAPPTID,0),U,18) S:'$G(LENDEF) LENDEF=$P(^SC(CLINID,"SL"),U)
 S:$G(LENGTH)="" LENGTH=$S($G(SDECLEN):SDECLEN,1:LENDEF)
 S START=$$TMCONV(APTTM,$$INST(CLINID)),END=$$FMADD^XLFDT(APTTM,0,0,LENGTH,0),END=$$TMCONV(END,$$INST(CLINID))
 S:$G(CNODE)>0 CONNM=$P(^GMR(123.5,$P(^GMR(123,CNODE,0),"^",5),0),"^")
 S PROVID=$P(^SC(CLINID,0),"^",13) S:$G(PROVID)>0 PROVNM=$P(^VA(200,PROVID,0),"^"),PREMAIL=$P($G(^VA(200,PROVID,.15)),"^")
 K XS S (STATUS("ID"))=$S($P(ANODE,"^",2)="":"S",1:$P(ANODE,"^",2)) S:STATUS("ID")="S" STATUS("TEXT")="SCHEDULED"
 N X,X1 S STATUS("TEXT")=$$STATUS(STATUS("ID"))
 S STATUS("SYSTEM")=2
 S APTSTATUS=$$GET1^DIQ(2.98,APTTM_","_DFN_",",9.5,"E")
 S:$G(SNODE)'="" ENTEREDBY=$P(^VA(200,$P(SNODE,"^",6),0),"^"),SCHEMAIL=$P($G(^VA(200,$P(SNODE,"^",6),.15)),"^",1)
 S:$G(SNODE)="" ENTEREDBY=$P(^VA(200,$G(DUZ),0),"^"),SCHEMAIL=$P($G(^VA(200,$G(DUZ),.15)),"^",1)
 D SET^HLOAPI(.SEG,"SCH",0) ; Set the segment type
 D SET^HLOAPI(.SEG,SEQ,1) ; Set the SCH-1
 D SET^HLOAPI(.SEG,APTSTATUS,6)  ;Field 6, Appointment status
 D:$G(CNODE)>0 SET^HLOAPI(.SEG,CNODE,7,1)  ;Consult ID if this is for a consult request
 D SET^HLOAPI(.SEG,LENGTH,9)  ;Field 9, Apt Length
 D SET^HLOAPI(.SEG,TMUNITS,10)  ; Field 10, time units
 D SET^HLOAPI(.SEG,START,11,4,1,1)  ; Field 11, appointment start and end time
 D SET^HLOAPI(.SEG,END,11,5,1,1)  ; Field 11, appointment start and end time
 D SET^HLOAPI(.SEG,$G(PROVID),16,1,1)  ; Field 16 provider duz
 D SET^HLOAPI(.SEG,$G(PROVNM),16,2,1)  ; Field 16 provider name
 D SET^HLOAPI(.SEG,$G(PREMAIL),17,4,1)  ; Field 17 provider eMail
 D SET^HLOAPI(.SEG,$G(ENTEREDBY),20,2,1)  ; Field 20, scheduling clerk's the appointment
 D SET^HLOAPI(.SEG,$G(SCHEMAIL),21,4,1)  ;Field 21, scheduling clerk's email
 D SETCE^HLOAPI4(.SEG,.STATUS,25)  ; Field 25, current status of the appointment
 Q
SCHCAN(DFN,SEQ,SEG,ANODE,SNODE,CNODE)  ; update for cancelled appointments
 N APTSTATUS,LENGTH,TMUNITS,SCHED,ENTEREDBY,STATUS,START,PREMAIL,END
 Q:$G(SNODE)=""  ;SNODE=SNODE=$G(^SC(CLINID,"S",APTTM,1,XX,0))
 S:$G(DUZ)="" DUZ=.5
 S:$G(DUZ(2))="" DUZ=$$KSP^XUPARAM("SITE")
 S LENGTH=$P(^SC(CLINID,"SL"),"^",1),TMUNITS="M"
 S START=$$TMCONV(APTTM,$$INST(CLINID)),END=$$FMADD^XLFDT(APTTM,0,0,LENGTH,0),END=$$TMCONV(END,$$INST(CLINID))
 S:$G(CNODE)>0 CONNM=$$GET1^DIQ(123,CNODE_",",1,"E")
 S PROVID=$P(^SC(CLINID,0),"^",13) S:$G(PROVID)>0 PROVNM=$P(^VA(200,PROVID,0),"^"),PREMAIL=$P($G(^VA(200,PROVID,.15)),"^")
 K XS S (STATUS("ID"),XS)=$S($P(ANODE,"^",2)="":"S",1:$P(ANODE,"^",2)) S:STATUS("ID")="S" STATUS("TEXT")="SCHEDULED"
 N X,X1 S STATUS("TEXT")=$$STATUS(STATUS("ID"))
 S STATUS("SYSTEM")=2
 S APTSTATUS=$$GET1^DIQ(2.98,APTTM_","_DFN_",",9.5,"E")
 S ENTEREDBY=$P(^VA(200,$P(SNODE,"^",6),0),"^"),SCHEMAIL=$P($G(^VA(200,$P(SNODE,"^",6),.15)),"^",1)
 D SET^HLOAPI(.SEG,"SCH",0) ; Set the segment type
 D SET^HLOAPI(.SEG,SEQ,1) ; Set the SCH-1
 D SET^HLOAPI(.SEG,APTSTATUS,6)  ;Field 6, Appointment status
 D:$G(CNODE)>0 SET^HLOAPI(.SEG,CNODE,7,1)  ;Consult ID if this is for a consult request
 D SET^HLOAPI(.SEG,LENGTH,9)  ;Field 9, Apt Length
 D SET^HLOAPI(.SEG,TMUNITS,10)  ; Field 10, time units
 D SET^HLOAPI(.SEG,START,11,4,1,1)  ; Field 11, appointment start and end time
 D SET^HLOAPI(.SEG,END,11,5,1,1)  ; Field 11, appointment start and end time
 D SET^HLOAPI(.SEG,$G(PROVID),16,1,1)  ; Field 16 provider duz
 D SET^HLOAPI(.SEG,$G(PROVNM),16,2,1)  ; Field 16 provider name
 D SET^HLOAPI(.SEG,$G(PREMAIL),17,4,1)  ; Field 17 provider eMail
 D SET^HLOAPI(.SEG,$G(ENTEREDBY),20,2,1)  ; Field 20, scheduling clerk's the appointment
 D SET^HLOAPI(.SEG,$G(SCHEMAIL),21,4,1)  ;Field 21, scheduling clerk's email
 D SETCE^HLOAPI4(.SEG,.STATUS,25)  ; Field 25, current status of the appointment
 K SCHEMAIL
 Q
PV2      ; Not needed right now
 Q
OBX1     ; Not needed right now
 Q
OBX2     ; Not needed right now
 Q
OBX3     ; Not needed right now
 Q
OBX4     ; Not needed right now
 Q
RGS1(FLAG,SEQ,SEG) ; At least one RGS segment is required
 N GRP
 S GRP=""
 D SET^HLOAPI(.SEG,"RGS",0)
 D SET^HLOAPI(.SEG,SEQ,1)
 D SET^HLOAPI(.SEG,FLAG,2)
 D SET^HLOAPI(.SEG,GRP,3)
 Q
AIS1     ;
 Q
NTE(SEQ,SEG) ;
 N NOTES,CLINID,CLINNM
 S NOTES="THESE ARE BOOKING NOTES",CLINID=23,CLINNM="GENERAL MEDICINE"
 D SET^HLOAPI(.SEG,"NTE",0)
 D SET^HLOAPI(.SEG,SEQ,1)
 D SET^HLOAPI(.SEG,"NOTES",3)
 D SET^HLOAPI(.SEG,NOTES,4)
 Q
AIL1(ANODE,SEQ,SEG) ;
 K LOC
 S LOC("ID")=$P(ANODE,"^",1),LOC("TEXT")=$P(^SC(LOC("ID"),0),"^"),LOC("SYSTEM")="44",CODE="A"
 S LOC("ALTERNATE ID")=$$STATION(CLINID) ;780
 D SET^HLOAPI(.SEG,"AIL",0)
 D SET^HLOAPI(.SEG,SEQ,1)
 D SET^HLOAPI(.SEG,CODE,2)
 D SETCE^HLOAPI4(.SEG,.LOC,4)
 K LOC,CODE
 Q
TMCONV(X,INST) ;Uses division/institution to determine tz instead of mailman files / 773
 ;convert FileMan local time to Zulu timezone in JSON format: YYYY-MM-DDTHH:MM:00.000Z
 ;Inputs:
 ; X = Time
 ; INST = Institution
 ;Output:
 ; Zulu Time in JSON format
 N OFFSET,UTC,UTC1,UTC2
 I X#1=0 S X=X+.000001 ;Add 1 second if midnight to avoid midnight problem in DIUTC. The second is not included in UTC2
 S OFFSET=$P($$UTC^DIUTC(X,,$G(INST),,1),"^",3)
 S UTC=$$FMADD^XLFDT(X,,-$G(OFFSET),,),UTC1=$$FMTHL7^XLFDT(UTC)
 S UTC2=$E(UTC1,1,4)_"-"_$E(UTC1,5,6)_"-"_$E(UTC1,7,8)_"T"_$E(UTC1,9,10)_":"_$E(UTC1,11,12)_":00.000Z"
 Q UTC2
CHKCLIN(X) ; check to see if this is a primary or secondary stop code for a tele health clinic
 I $G(X)'>0 S STOP=0 Q STOP
 S STOP=0
 N TEST,I,CODE,X1,X2
 S X2=0
 S X1=$$GET1^DIQ(40.7,X_",",1,"I"),X2=$O(^SD(40.6,"B",X1,""))
 S:$G(X2)>0 STOP=1
 Q STOP
STATUS(X) ; a $Select to convert code to text too many characters in a single line. returns the text version of the appointment code
 S X1=""
 Q:$G(X)=""
 S:X="N" X1="NO-SHOW"
 S:X="C" X1="CANCELLED BY CLINIC"
 S:X="NA" X1="NO&AUTO RE-BOOK"
 S:X="CA" X1="CANCELLED BY CLINIC & AUTO RE-BOOK"
 S:X="I" X1="INPATIENT APPOINTMENT"
 S:X="PC" X1="CANCELLED BY PATIENT"
 S:X="PCA" X1="CANCELLED BY PATIENT & AUTO-REBOOK"
 S:X="NT" X1="NO ACTION TAKEN"
 S:X="S" X1="SCHEDULED"
 Q X1
 ;
INST(CLNC) ;Derives the institution value for the clinic
 ;Inputs:
 ; CLNC = Clinic IEN from the Hospital Location (#44) file
 ;Output:
 ; INST = Institution IEN from the Institution (#4) file. Null indicates an error.
 I CLNC="" Q ""
 N DIV,INST,MCD0,NEWINST,TZ
 S MCD0=$G(^SC(CLNC,0))
 I MCD0="" Q ""  ;No entry in the Hospital Location (#44) file
 S INST=$P(MCD0,U,4)
 I INST S TZ=$P($G(^DIC(4,INST,8)),U,1) I TZ Q INST
 S DIV=$P(MCD0,U,15) I 'DIV Q ""
 S INST=$P($G(^DG(40.8,DIV,0)),U,7)
 S NEWINST=$$CHKINST(INST)
 Q NEWINST
 ;
CHKINST(INST) ;Derives the parent institution if the passed-in institution does not have a time zone
 I 'INST Q ""
 N TZ,AS
 S TZ=$P($G(^DIC(4,INST,8)),U,1) I TZ Q INST
 S AS=$O(^DIC(4,INST,7,"B",2,"")) I AS S INST=$P(^DIC(4,INST,7,AS,0),U,2)
 I INST S TZ=$P($G(^DIC(4,INST,8)),U,1)
 I TZ Q INST
 Q ""  ;Never found an institution with a timezone
 ;
STATION(CLNC) ;Derives the station number from the clinic - 780
 ;Inputs:
 ; CLNC = Clinic IEN from the Hospital Location (#44) file
 ;Output:
 ; STATN = Station number from the Institution (#4) file. Null indicates an error.
 I CLNC="" Q ""
 N INST,MCD,MCD0,STATN,Z
 S MCD0=$G(^SC(CLNC,0)) I MCD0="" Q ""  ;No entry in the Hospital Location (#44) file
 S INST=$P(MCD0,U,4) I INST]"" S STATN=$P($G(^DIC(4,INST,99)),U,1) I STATN Q STATN        ;quit if found Stn#
 S MCD=$P(MCD0,U,15) I MCD]"" S Z=$G(^DG(40.8,MCD,0)) S STATN=$P(Z,U,2) I STATN Q STATN   ;quit if found Stn#
 Q ""  ;Could not locate station number
