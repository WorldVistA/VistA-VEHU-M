DENTVA7 ;DSS/KC - ENCOUNTERS BY PATIENT REPORT;06/20/2005 10:41
 ;;1.2;DENTAL;**47,53,55,57**;Aug 10, 2001;Build 8
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  DBIA#  SUPPORTED
 ;  -----  ---------  ------------------------------------------
 ;  2171      x       $$STA^XUAF4
 ;  2056      x       $$GET1^DIQ
 ;  10103     x       FMTE^XLFDT
 ;
PAT(RET) ; Encounters by Patient Report called by DENTVAU
 ;SDT,EDT,STN,PROVIDEN comes from calling routine DENTVAU
 N I,IDT,IEN,NODE,TOT,RP,DATADFN,SSN,NAM,PCODE,VDT,VIEN,PROV,P
 S DATADFN=$G(DATA("DFN")) I DATADFN="" S @RET@(1)="-1^No patient sent" Q
 I $G(DATA("PROV"))=0 S DATA("PROV")="ALL"
 I $G(DATA("PROV"))="ALL" S PROV=1
 E  S PROV=0,P=$G(DATA("PROV")),I=1 F  Q:'$P(P,U,I)  S PROV($P(P,U,I))="",I=I+1
 I PROV'=1,I=1 S @RET@(1)="-1^Invalid Provider" Q
 S SSN=$E($$GET1^DIQ(2,DATADFN_",",.09),6,10)
 S NAM=$$GET1^DIQ(2,DATADFN_",",.01),NAM=$E(NAM,1,18)_" ("_$E(NAM)_SSN_")"
 S I=0,CNT=0,TOT=0,EDT=EDT_.9 K ^TMP("DENTVST",$J)
 S IDT=SDT-.0001 F  S IDT=$O(^DENT(228.1,"AE",DATADFN,IDT)) Q:'IDT!(IDT>EDT)  D
 .S IEN=0 F  S IEN=$O(^DENT(228.1,"AE",DATADFN,IDT,IEN)) Q:'IEN  D HST
 .Q
 D DAS
 K ^TMP("DENTVST",$J),^TMP("DENTDAS",$J)
 I '$D(@RET) S @RET@(1)="-1^No data for the selected criteria" Q
 S @RET@(0)=TOT_U_NAM
 Q
HST ;process history records
 S NODE=$G(^DENT(228.1,IEN,0))  Q:+$G(^DENT(228.1,IEN,1))
 I STN,$P(NODE,U,18)'=STN Q  ;not selected station
 I 'PROV,'$D(PROV(+$P(NODE,U,7))) Q  ;not selected provider
 S RP="",PCODE=$$PROV^DENTVA6($P(NODE,U,7)),VIEN=$P(NODE,U,5)
 S VDT=$S(VIEN:$$GET1^DIQ(9000010,VIEN,.01,"I"),1:$P(NODE,U,3)),VDT=$E(VDT,1,12)
 I '$D(^TMP("DENTVST",$J,+VDT)) S TOT=TOT+1,^TMP("DENTVST",$J,VDT)=""
 I $P(NODE,U,6) S ^TMP("DENTDAS",$J,$P(NODE,U,6))=""
 S $P(RP,U)=$$FMTE^XLFDT($E(VDT,1,12))
 S $P(RP,U,2)=$S($P(NODE,U,16)=1:"In Progress",$P(NODE,U,16)=2:"Complete",1:"Terminated")
 S $P(RP,U,3)=$S($G(PROVIDEN):$$PNAM^DENTVAU($E(PCODE,2,9)),1:$E(PCODE,2,9))
 S @RET@(9999999-VDT)=RP
 Q
 ;
DAS ;get the pre-DRM encounter records (dates) from DAS
 N STNN,PN I STN S STNN=$$STA^XUAF4(STN) ;get external station for DAS records
 S IEN=0 F  S IEN=$O(^DENT(221,"E",DATADFN,IEN)) Q:'IEN  D
 .S NODE=$G(^DENT(221,IEN,0)) Q:'NODE!($P(NODE,U,5)="D")  ;bad data or deleted
 .S PN=$P($G(^DENT(220.5,+$P(NODE,U,3),0)),U) ;convert to new person ien
 .I 'PROV,'$D(PROV(+PN)) Q  ;not selected provider
 .I $D(^TMP("DENTDAS",$J,IEN))  Q  ;already counted this encounter in DRM files
 .I $P(NODE,U)'>SDT Q  ;not in date range
 .I $P(NODE,U)'<EDT Q  ;not in date range
 .I STN,$P(NODE,U,40)'=STNN Q  ;not selected station
 .S RP="",PCODE=$$PROV^DENTVA6(PN),VDT=$E($P(NODE,U),1,12)
 .I '$D(^TMP("DENTVST",$J,+VDT)) S TOT=TOT+1,^TMP("DENTVST",$J,VDT)=""
 .S $P(RP,U)=$$FMTE^XLFDT($E(VDT,1,12))
 .S $P(RP,U,2)=$S($P(NODE,U,41)=2:"Complete",$P(NODE,U,41)=3:"Terminated",1:"In Progress")
 .S $P(RP,U,3)=$S($G(PROVIDEN):$$PNAM^DENTVAU($E(PCODE,2,9)),1:$E(PCODE,2,9))
 .S @RET@(9999999-VDT)=RP_U_"DAS"
 .Q
 Q
ACT(RET) ; Active/Inactive Patients by Provider Report called by DENTVAU
 ;SDT,EDT,STN,PTYP,PROVIDEN,DOSEC comes from calling routine DENTVAU
 N PROV,I,P,CNT,IDT,IEN,NAM,SSN,DFN,NODE,PNAM,NAM,PTCT,CL,PCODE,PSORT,STATUS,STATN,PROVALL
 S DOSEC=$G(DOSEC),PTCT=0,PROVALL=0
 I $G(DATA("PROV"))=0 S DATA("PROV")="ALL"
 I $G(DATA("PROV"))="ALL" S PROV=1,PROVALL=1
 E  S PROV=0,P=$G(DATA("PROV")),I=1 F  Q:'$P(P,U,I)  S PROV($P(P,U,I))="",I=I+1
 I PROV'=1,I=1 S @RET@(1)="-1^Invalid Provider" Q
 I $G(@RET@(1))]"" Q
 S I=0,CNT=0,DPAT=$NA(^TMP("DENTPAT",$J)),PTCT=0,EDT=EDT_.9
 S IDT=EDT F  S IDT=$O(^DENT(228.1,"AS",IDT),-1) Q:'IDT!(IDT<SDT)  D
 .S IEN="" F  S IEN=$O(^DENT(228.1,"AS",IDT,IEN),-1) Q:'IEN  D HX
 .Q
 K ^TMP("DENTPAT",$J)
 I '$D(@RET) S @RET@(1)="-1^No data for the selected criteria" Q
 S @RET@(0)="$START"_U_+$G(PTCT)
 Q
HX ;process history records
 S NODE=$G(^DENT(228.1,IEN,0)) Q:+$G(^DENT(228.1,IEN,1))  ;deleted
 I STN,$P(NODE,U,18)'=STN Q  ;only selected station
 S DFN=$P(NODE,U,2) Q:'DFN  ;no patient
 I $$TESTPAT^VADPT(DFN) Q  ;test pt, don't count
 I $D(@DPAT@(DFN)) Q  ;already have this patient
 S STATUS=$P(NODE,U,16),STATUS=$S(STATUS=1:0,STATUS=4:2,1:1)
 S STATN=$S(STATUS=0:"Active",STATUS=1:"Inact",1:"Maint")
 S @DPAT@(DFN)=STATUS
 I PTYP<3,PTYP'=$G(@DPAT@(DFN)) Q  ;not selected pt status
 I PTYP=4 S X=$G(@DPAT@(DFN)) I "02"'[X Q  ;act/maint only
 S PTCT=PTCT+1,SSN=$E($$GET1^DIQ(2,DFN_",",.09),6,10)
 S NAM=$$GET1^DIQ(2,DFN_",",.01),NAM=NAM_" ("_$E(NAM)_SSN_")"
 S X=$G(^DENT(220,DFN,0)),PROV=0
 I DOSEC<2 S PROV=$S('DOSEC:$P(X,U,9),1:$P(X,U,10)) I PROV S PROV=+$G(^DENT(220.5,PROV,0))
 I DOSEC<2,'PROV S PROV=0,PNAM="Unassigned",PCODE="X9999"
 I DOSEC=2 S PROV=$P(NODE,U,7)
 I 'PROVALL,'$D(PROV(PROV)) Q  ;not selected provider
 I PROV S PCODE=$$PROV^DENTVA6(+PROV),PNAM=$S($G(PROVIDEN):$$PNAM^DENTVAU($E(PCODE,2,9)),1:$E(PCODE,2,9))
 S PSORT=$S($G(PROVIDEN):PNAM,1:PCODE)
 S CL=$$GET1^DIQ(2,DFN,220,"I") I 'CL D
 .S CL=$$GET1^DIQ(228.1,IEN,.13,"I")
 S @RET@(PSORT,+CL,IDT,DFN)=PNAM_U_$$GET1^DIQ(220.2,CL,.01)_U_NAM_U_$$FMTE^XLFDT($E(IDT,1,12),1)_U_STATN
 Q
REC(RET) ;Recare report
 ;RET(n)  =p1-11 = A^recare dt^class^phone1^phone2^SSN^pt name^add1^add2^city^st^zip^sex^lastvist^lastprov
 ;RET(n+1)=p1-11 = B^priProv^secProv^futureappt^futapptclinic^lastcomp^lastbrief^lastperio^lastpano^lastfull^lastBW^lastprophy
 N PROV,I,P,NODE,IDT,DFN,CNT,PPROV,SPROV S CNT=0
 I $G(DATA("PROV"))=0 S DATA("PROV")="ALL"
 I $G(DATA("PROV"))="ALL" S PROV=1
 E  S PROV=0,P=$G(DATA("PROV")),I=1 F  Q:'$P(P,U,I)  S PROV($P(P,U,I))="",I=I+1
 I PROV'=1,I=1 S @RET@(1)="-1^Invalid Provider" Q
 S EDT=EDT_.9,RET=$NA(^TMP("DENTVRCD",$J)) K @RET
 S IDT=SDT-1 F  S IDT=$O(^DENT(220,"AC",IDT)) Q:'IDT!(IDT>EDT)  D
 .S DFN=0 F  S DFN=$O(^DENT(220,"AC",IDT,DFN)) Q:'DFN  D
 ..I $$TESTPAT^VADPT(DFN) Q  ;test pt, don't count
 ..I PTYP<3,'$D(^TMP("DENTPAT",$J,DFN)) S NODE=U_DFN D PATSTA^DENTVA1
 ..I PTYP<3,PTYP'=$G(^TMP("DENTPAT",$J,DFN)) Q  ;not selected pt status
 ..I PTYP=4 S X=$G(^TMP("DENTPAT",$J,DFN)) I "02"'[X Q  ;act/maint only
 ..S NODE=$G(^DENT(220,DFN,0)),PPROV=+$P(NODE,U,9),SPROV=+$P(NODE,U,10)
 ..I PPROV S PPROV=+$G(^DENT(220.5,PPROV,0))
 ..I SPROV S SPROV=+$G(^DENT(220.5,SPROV,0))
 ..I 'PROV,'$D(PROV(PPROV)) S PPROV=0
 ..I 'PROV,'$D(PROV(SPROV)) S SPROV=0
 ..I 'PROV I 'PPROV&'SPROV Q  ;not selected provider
 ..D DATA
 .Q
 K ^TMP("DENTPAT",$J)
 I '$D(@RET) S @RET@(1)="-1^No data for the selected criteria" Q
 Q
DATA ;get pt data
 N CL,DENTDFN,LSTAT,X,Y,DENAL,LDIV,LPROV,FEE,SSN,LVDT,DENTIENS,DENT
 D LST^DENTVTP5(.LSTAT,DFN) I $P(LSTAT,U,3) S DENTIENS=$P(LSTAT,U,3)_","
 I $G(DENTIENS) D  ;P55 get last enc ien to get last prov/div, P57 pt may not have dental hx
 .K DENT D GETS^DIQ(228.1,DENTIENS,".03;.05;.07;.13;.18","IEN","DENT")
 .S LDIV=$G(DENT(228.1,DENTIENS,.18,"I"))
 .S LPROV=$G(DENT(228.1,DENTIENS,.07,"E"))
 .S LVDT=$G(DENT(228.1,DENTIENS,.05,"E")) I LVDT S LVDT=$P(LVDT,"@") Q
 .S LVDT=$G(DENT(228.1,DENTIENS,.03,"E")) ;use create date if no visit date
 .S LVDT=$P(LVDT,"@")
 .Q
 I STN,$G(LDIV)'=STN Q  ;only selected station P55
 S CL=$$GET1^DIQ(2,DFN,220,"I")
 I 'CL,$P(LSTAT,U,3) S CL=$G(DENT(228.1,DENTIENS,.13,"I"))
 D DEM^VADPT,ADD^VADPT
 S DATA=$$FMTE^XLFDT(IDT)_U_CL_U_$$FMP(VAPA(8))_U_$$FMP($$GET1^DIQ(2,DFN,.132))_U
 I +VADM(2) S SSN="XXX-XX-"_$P($P(VADM(2),U,2),"-",3)
 E  S SSN=";"
 S DATA=DATA_SSN_U_$S($P(VADM(5),U)="M":"Mr ",1:"Ms ")_$P($G(VADM(1)),",",2)_" "_$P($G(VADM(1)),",",1)_U
 S DATA=DATA_$G(VAPA(1))_U_$G(VAPA(2))_U_$G(VAPA(4))_U_$$GET1^DIQ(5,+VAPA(5),1)_U
 S DATA=DATA_$P($G(VAPA(11)),U,2)_U_$P($G(VADM(5)),U)_U_$G(LVDT)_U_$G(LPROV)_U
 S CNT=CNT+1,@RET@(CNT)="A^"_DATA
 ;more data
 S DATA=$$PROV($P(NODE,U,9))_U_$$PROV($P(NODE,U,10))_U
 S FEE=$$GET1^DIQ(220,DFN,.11,"E") I FEE]"" S $P(DATA,U)=FEE ;P55 Primary is Fee Basis
 S FEE=$$GET1^DIQ(220,DFN,.12,"E") I FEE]"" S $P(DATA,U,2)=FEE ;P55 Secondary is Fee Basis
 S Y="" K DENAL D GAL^DENTVUTL(.DENAL,DFN) S I=0 F  S I=$O(DENAL(I)) Q:'I  D
 .S X=$G(DENAL(I)) I +X=-1 Q
 .I Y="" S Y=$P(X,U,2)
 .E  S Y=Y_"/"_$P(X,U,2)
 .Q
 S DATA=DATA_$E(Y,1,60)_U ;alerts
 S DENTDFN=DFN,DATA=DATA_$$FAP^DENTVA2() K DENTDFN ;next appt
 S X="" D LDATA^DENTVTP0(.X) S $P(X,U,13)="",X=$$FMD($P(X,U,5,13))
 S DATA=DATA_X
 S CNT=CNT+1,@RET@(CNT)="B^"_DATA
 D KVA^VADPT
 Q
FMP(PHONE) ;format the phone#
 I $G(PHONE)="" Q ""
 I $L(PHONE)=7 Q $E(PHONE,1,3)_"-"_$E(PHONE,4,7)
 I $L(PHONE)=10 Q $E(PHONE,1,3)_"-"_$E(PHONE,4,6)_"-"_$E(PHONE,7,10)
 Q PHONE
FMD(DATES) ;format dates
 N I F I=1:1:8 S $P(DATES,U,I)=$$FMTE^XLFDT($P(DATES,U,I))
 Q DATES
PROV(PIEN) ;get provider id or name from 220.5 entry
 N PC S PC=$P($G(^DENT(220.5,+$G(PIEN),0)),U,4)
 S PC=$E($S($G(PROVIDEN):$$PNAM^DENTVAU(PC),1:PC),1,20)
 I $E(PC,1,7)="Unknown" Q "Unassigned"
 Q PC
