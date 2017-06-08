DENTVHL ;DSS/LM - Dental Transaction Extract HL7 Messaging ;5/29/2003 16:40
 ;;1.2;DENTAL;**40,42,45,47,53,61**;Aug 10, 2001;Build 3
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ; Integration Agreements
 ;
 ; 2051   $$FIND1^DIC
 ; 2056   GETS^DIQ
 ; 2056   $$GET1^DIQ
 ; 10103  $$FMTHL7^XLFD
 ; 3065   $$HLNAME^XLFNAME
 ; 2171   $$STA^XUAF4
 ; 10112  $$SITE^VASITE
 ; 4450   direct global read of ^SCE("AVSIT", waiting for IA
 Q
ADD(IEN) ;;New Dental Transaction Extract
 ; IEN=File #228.2 Internal Entry Number
 ; 
 ; Returns positive message ID or
 ; negative error code:
 ;
 ; -1    =   Missing or invalid parameter
 ; -2    =   Defective HL7 environment 
 ; -3    =   Application not active
 ; -4    =   Bad DENTAL HISTORY file pointer
 ; -5    =   Defective patient IEN
 ; -6    =   Missing station number
 ; -9    =   Missing Relative Value Units (RVU)
 ; -99   =   GENERATE^HLMA failed
 ;
 ; To test in foreground, SET DEBUG=1 WRITE $$ADD^DENTVHL(<IEN>)
 ; Test will not generate message
 ; 
 Q:'$G(IEN) -1 ;Required parameter
 N HL,HLA Q:$$INIT^DENTVHLU(.HL) -2 ;Initialize HL7 variables
 Q:'$$ACTIVE^DENTVHLU(HL("SAN")) -3 ;Application not active
 ; Get data
 N DENTVHLD,FP1,FP2,X D GETS^DIQ(228.2,+IEN,"**","EI","DENTVHLD")
 S FP2="DENTVHLD(228.2,"""_+IEN_","")" ;File 228.2 data
 N IE1 S IE1=$G(@FP2@(1.15,"I")) Q:'IE1 -4 ;DENTAL HISTORY file pointer
 D GETS^DIQ(228.1,+IE1,"**","EI","DENTVHLD")
 S FP1="DENTVHLD(228.1,"""_+IE1_","")" ;File 228.1 data
 ;
 ; Station Number -
 ; Patch 39 changed #.18 from indirect division->institution to ->institution
 N STNO S STNO=$G(@FP1@(.18,"I")) ;S:STNO STNO=$$GET1^DIQ(40.8,STNO,.07,"I")
 S:STNO STNO=$$STA^XUAF4(STNO) ;Station number
 ;
 ; Verify data
 N ERR S ERR=$$VER^DENTVHL2() I ERR D  Q ERR ;SRS validation
 .I ERR="228.2;.04",$G(@FP2@(.09,"I"))=49 Q  ;bridge holder txn/no ADA/don't send msg
 .I ERR="228.2;.04",$G(@FP2@(.09,"I"))=72 Q  ;connbar holder txn/no ADA/don't send msg
 .D MSG^DENTVHL3($G(@FP2@(.01,"E")),ERR)
 .Q
 ; 
 ; Filter HL7 field separator and encoding characters from source fields
 F X=FP1,FP2 F  S X=$Q(@X) Q:X=""  S:@X]"" @(X_"=$$ESC^DENTVHLU("_X_")")
 ;
 N DIV,FN,WL
 S WL=$G(@FP1@(.11,"I")) ;Ward Location IEN
 S DIV=$S(WL:$$GET1^DIQ(44,WL,3.5,"I"),1:"") ;Medical Center Division IEN
 S FN=$S(DIV:$$GET1^DIQ(40.8,DIV,1),1:"") ;Facility Number (Free Text)
 ; Miscellaneous HL7 variables
 N EC1,EC2,EC3,EC4,FS
 S FS=$G(HL("FS")) Q:'$L(FS) -2 ;Field separator
 S EC1=$E($G(HL("ECH"))) Q:'$L(EC1) -2 ;Component separator
 S EC2=$E($G(HL("ECH")),2) Q:'$L(EC2) -2 ;Repetition separator
 S EC3=$E($G(HL("ECH")),3) Q:'$L(EC3) -2 ;Escape character
 S EC4=$E($G(HL("ECH")),4) Q:'$L(EC4) -2 ;Subcomponent separator
 ; Additional message variables
 N DENTVHLI,MSG,SEG
 ; Patient
 N DFN,PNM
 S DENTVHLI=0,MSG="HLA(""HLS"")" ;Segment counter and message array
 S DFN=$G(@FP2@(.02,"I")),PNM=$G(@FP2@(.02,"E")) ;Patient IEN and NAME
 ; Visit
 N VIEN,VDT S VIEN=$G(@FP1@(.05,"I")) ;VISIT file IEN and DATE
 ; To do: Substitute approved API for next.
 S VDT=$S(VIEN:$$GET1^DIQ(9000010,VIEN,.01,"I"),1:"")
 ; Dental Provider
 N PDUZ S PDUZ=$G(@FP2@(.03,"I")) ;File 200 IEN (Provider)
 N PDATE S PDATE=$G(@FP2@(.13,"I")) ;Transaction date KC added "I" to get date P45
 ; Provider type and specialty removed 2/3/04 
 N PRNM S PRNM=$S(PDUZ:$$GET1^DIQ(200,PDUZ,.01),1:"")
 ;
 ; PID segment from ^VAFCQRY
 N PID S DENTVHLI=DENTVHLI+1,@MSG@(DENTVHLI)=$$PID^DENTVHLU(DFN,.PID)
 ; PID continuation
 N I F I=2:1 Q:'$D(PID(I))  S @MSG@(DENTVHLI,I-1)=PID(I)
 ;
 ; PV1 segment
 S DENTVHLI=DENTVHLI+1,@MSG@(DENTVHLI)="PV1"_FS_1 ;Set ID=1
 ; Determine whether IN- or OUT-patient
 N INP S INP=$G(@FP1@(.1,"I"))="I" ;True if and only if INPATIENT
 S $P(@MSG@(DENTVHLI),FS,3)=$S(INP:"I",1:"O") ;Patient Class
 S $P(@MSG@(DENTVHLI),FS,4)=$G(@FP1@(.14,"E")) ;PV1-3 Dental BED SECTION
 I $G(@FP1@(.08,"I")) D   ;PV1-7 Attending Provider (Distributed Provider) P47
 .S X=$G(@FP1@(.08,"I"))_EC1_$TR($$HLNAME^XLFNAME(@FP1@(.08,"E")),U,EC1)
 .S:X $P(@MSG@(DENTVHLI),FS,8)=$G(STNO)_"-"_X
 .Q
 N PPROV S PPROV=$P($G(^DENT(220,DFN,0)),U,9) I PPROV D  ;PV1-8 Primary Provider P53
 .S X=+$G(^DENT(220.5,PPROV,0)) Q:'X
 .S X=X_EC1_$TR($$HLNAME^XLFNAME($$GET1^DIQ(220.5,PPROV,.01)),U,EC1)
 .S:X $P(@MSG@(DENTVHLI),FS,9)=$G(STNO)_"-"_X
 .Q
 N SPROV S SPROV=$P($G(^DENT(220,DFN,0)),U,10) I SPROV D  ;PV1-9 Secondary Provider P53
 .S X=+$G(^DENT(220.5,SPROV,0)) Q:'X
 .S X=SPROV_EC1_$TR($$HLNAME^XLFNAME($$GET1^DIQ(220.5,SPROV,.01)),U,EC1)
 .S:X $P(@MSG@(DENTVHLI),FS,10)=$G(STNO)_"-"_X
 .Q
 S $P(@MSG@(DENTVHLI),FS,11)=$G(@FP1@(.17,"E")) ;PV1-10 SPECIALTY
 S $P(@MSG@(DENTVHLI),FS,19)=$G(@FP1@(.13,"I")) ;PV1-18 Pat. Category
 ; Visit ID -
 N VID S VID=VIEN S $P(VID,EC1,5)="VN",$P(VID,EC1,6)=FN
 S:VDT $P(VID,EC1,7)=$E($$FMTHL7^XLFDT(VDT),1,8) ;Suppress time offset (PR)
 S $P(@MSG@(DENTVHLI),FS,20)=VID ;PV1-19 Visit ID
 ; Admission/Outpatient Encounter Date/Time -
 N PV144 S PV144=""
 D:INP  ;If inpatient, admission date from #405
 .N I,INP,VAIP S VAIP("D")=$G(VDT,$G(@FP1@(.03)))
 .D IN5^VADPT S PV144=+$G(VAIP(13,1))
 .Q
 N EIEN S EIEN=+$O(^SCE("AVSIT",+VIEN,0)) ;S EIEN=$G(@FP1@(.12,"I"))
 D:'INP!'PV144  ;Use Outpatient Encounter Date/Time P53, use Outpt Enc if no Admit date
 .I EIEN S PV144=$$GET1^DIQ(409.68,EIEN,.01,"I")
 .Q
 S:PV144 $P(@MSG@(DENTVHLI),FS,45)=$$FMTHL7^XLFDT(PV144) ;PV1-44 Admit date
 S:EIEN $P(@MSG@(DENTVHLI),FS,51)=EIEN ;PV1-50 OUTPATIENT ENCOUNTER (IEN)
 ; PV2 segment
 N SCTEETH,AMC,CNTT,AMCODE S SCTEETH="",AMC="",CNTT=0 ;P53 get new fields for PV2 and OBR
 F I=1:1 S X=$G(^DENT(220,DFN,5,I,0)) Q:X=""  D
 .I $P(X,":")="SCTeeth" S SCTEETH=$P(X,":",2) Q  ;SCTeeth
 .I $P(X,":")="REHAB" Q
 .I $P(X,":")="Adjuctive Medical Conditions" Q
 .I CNTT=5 Q
 .I +$E(X,2,$L(X)) S AMC=$G(AMC)_$P(X," ",1)_EC2,CNTT=CNTT+1 ;P61 fix AMC codes to return code only
 .Q
 I AMC]"" S AMC=$E(AMC,1,$L(AMC)-1)
 S DENTVHLI=DENTVHLI+1,@MSG@(DENTVHLI)="PV2" ;PV2
 S $P(@MSG@(DENTVHLI),FS,4)=AMC
 ;PV2-18 patient category (overall) P53
 N PCAT S PCAT=$$GET1^DIQ(2,DFN,220,"I") I PCAT S $P(@MSG@(DENTVHLI),FS,19)=PCAT
 ;S:$G(@FP1@(.2,"I"))]"" $P(@MSG@(DENTVHLI),FS,25)=$G(@FP1@(.2,"I")) ;PATIENT STATUS
 I $G(@FP1@(.16,"I"))="" S @FP1@(.16,"I")=1 ;def to inprogress - some txns don't have this -DRM bug when txn not filed to DAS
 S:$G(@FP1@(.16,"I"))]"" $P(@MSG@(DENTVHLI),FS,25)=$S($G(@FP1@(.16,"I"))=1:"A",$G(@FP1@(.16,"I"))=4:"M",1:"I") ;PATIENT STATUS P47 added "M"
 S:$G(@FP1@(.16,"I"))]"" $P(@MSG@(DENTVHLI),FS,32)=$G(@FP1@(.16,"I")) ;PATIENT DISPOSITION
 ; DG1 segment
 ; Primary Patient Care Encounter (PCE) Diagnosis
 S DENTVHLI=DENTVHLI+1,@MSG@(DENTVHLI)="DG1"_FS_1 ;First DG1
 N VDATA S VDATA=$NA(^TMP("DSIC",$J)) D VSTALL^DSICPX2(VDATA,VIEN)
 S $P(@MSG@(DENTVHLI),FS,4)=$P($G(@VDATA@(1)),U,4)_EC1_EC1_"ICD9" K @VDATA
 S $P(@MSG@(DENTVHLI),FS,7)="F" ;DG1-6 Diagnosis Type F[inal]
 ; Additional DG1 segments (Dental)
 ; Note: Following excludes null diagnosis fields.
 ;       To force 5 additional DG1 segments substitute unconditional DO -
 N J,K S J=1 F K=1.06,1.07,1.08,1.09,1.1 D:$G(@FP2@(K,"I"))
 .; Replace VistA table name with constant "ICD9" -
 .N ICDX S ICDX=@FP2@(K,"E")_EC1_EC1_"ICD9" ;"VistA228.2;F"_K ;Omit short desc.
 .S DENTVHLI=DENTVHLI+1,J=J+1,@MSG@(DENTVHLI)="DG1"_FS_J,$P(@MSG@(DENTVHLI),FS,4)=ICDX
 .S $P(@MSG@(DENTVHLI),FS,7)="F" ;DG1-6 Diagnosis Type F[inal]
 .Q
 ; OBR segment
 S DENTVHLI=DENTVHLI+1,@MSG@(DENTVHLI)="OBR"_FS_1 ;Set ID
 N OBR3 S OBR3=$G(@FP2@(.01,"E")),OBR3=STNO_"-"_OBR3 ;OBR-3 UID
 S $P(@MSG@(DENTVHLI),FS,4)=OBR3
 ; OBR-4 Universal Service Identifier.  Use #228.2:.04 as placeholder.
 ; S $P(@MSG@(DENTVHLI),FS,5)=$G(@FP2@(.04,"E"))_EC1_EC1_"CPT" ;OBR-4
 ; Change CPT to VistA table name-
 S:$G(@FP2@(.04,"E"))]"" $P(@MSG@(DENTVHLI),FS,5)=@FP2@(.04,"E")_EC1_EC1_"VistA228.2;F.04" ;OBR-4
 ; OBR-6 Recare Date P53
 N RDAT S RDAT=+$G(^DENT(220,DFN,8)) I RDAT S $P(@MSG@(DENTVHLI),FS,7)=$$FMTHL7^XLFDT(RDAT)
 ; DATE CREATED -
 I $G(@FP2@(1.01,"I")) S $P(@MSG@(DENTVHLI),FS,8)=$$FMTHL7^XLFDT(@FP2@(1.01,"I"))
 ; OBR-13 SC teeth P53
 I SCTEETH]"" S $P(@MSG@(DENTVHLI),FS,14)=$$TRIM^XLFSTR($TR(SCTEETH,",",EC2))
 ; rest of OBR is in DENTVHL1
 ; First OBX segment
 ; Second OBX segment
 ; PRA segment
 ; are in DENTVHL1
 ; 
 Q $$CONT^DENTVHL1 ;Respect SACC 10K limit
 ;
UPD(IEN) ;;Update Dental Transaction Extract
 Q
DEL(IEN) ;;Delete Dental Transaction Extract
 ; Mark as deleted.
 N OBR25 S OBR25="X"
 Q $$ADD(IEN)
 ;
