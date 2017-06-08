DGYEUTL ;ALB/MTC - UTILITY ROUTINES FOR EPRP PROCESSING ; 2-19-92
 ;;1.0; DGYE ;;28 Apr 92
CVTDATE(DATE) ;-- convert date to printable format
 ;  INPUT : DATE - Date to be converted in FM format
 ;  OUTPUT: date in the following format: AUG 21,91
 N Y
 S Y=DATE D DD^%DT
 Q $E(Y,1,7)_$E(Y,11,12)
 ;
PROV(PTF) ;-- return provider info (primary/attending phy)
 ;  INPUT : PTF - PTF record number
 ;  OUTPUT: PRIMARY^ATTENDING
 N RESULT,FLAG,I,J,K,DFN,CORADM
 S RESULT="",FLAG=0
 I $D(^DGPM("APTF",PTF)) S CORADM=$O(^(PTF,0))
 E  G PROVQ
 S DFN=+^DGPT(PTF,0)
 F I=0:0 S I=$O(^DGPM("ATS",DFN,CORADM,I)) Q:'I  D  Q:FLAG
 .S J="" F  S J=$O(^DGPM("ATS",DFN,CORADM,I,J)) Q:'J  D  Q:FLAG
 ..F K=0:0 S K=$O(^DGPM("ATS",DFN,CORADM,I,J,K)) Q:'K  D  Q:FLAG
 ...S PROV=$G(^DGPM(K,0)) Q:PROV']""
 ...I $P(RESULT,U)']"" S $P(RESULT,U)=$P(PROV,U,8)
 ...I $P(RESULT,U,2)']"" S $P(RESULT,U,2)=$P(PROV,U,19)
 ...I $P(RESULT,U)]"",$P(RESULT,U,2)]"" S FLAG=1
PROVQ Q RESULT
 ;
OUT3(PAT,ADM,DAYS) ;-- this function will determine if a patient
 ; had an outpatient visit within (DAYS) days of an admission.
 ;  INPUT  : PAT -ifn of the patient 
 ;           ADM -the date of admission in FM format
 ;           DAYS -number of days prior to adm to check
 ;  OUTPUT : YES- date of outpatient care, NO-0
 N RESULT
 S RESULT=$$DIS(PAT,ADM,DAYS) G:RESULT OUT3Q
 S RESULT=$$VIS(PAT,ADM,DAYS) G:RESULT OUT3Q
 S RESULT=$$CLIN(PAT,ADM,DAYS) G:RESULT OUT3Q
OUT3Q Q RESULT
 ;
DIS(PAT,ADM,DAYS) ;-- this extrinsic variable will scan the "ADIS" x-ref
 ; of the Patient file(#2) for possible outpatient care (DAYS+1) days
 ; prior to the day before admission.
 ;  INPUT  : PAT -ifn of the patient
 ;           ADM -admission date
 ;           DAYS-number of days prior to adm to check
 ;  OUTPUT : 1-Date of Outpatient Care, 0-NO
 N I,J,Y,RESULT,DTM3,X1,X2,X
 S RESULT=0,X1=ADM,X2=-DAYS-1 D C^%DTC S DTM3=X
 D  Q RESULT
 .F I=DTM3:0 S I=$O(^DPT("ADIS",I)) Q:'I!(I'<(ADM-1))!(RESULT)  F J=0:0 S J=$O(^DPT("ADIS",I,J)) Q:'J  I J=PAT S Y=$O(^(J,0)) I $D(^DPT(PAT,"DIS",+Y,0)),(($P(^(0),U,2)=0)!($P(^(0),U,2)=1)) S RESULT=I Q
 Q
 ;
VIS(DFN,ADM,DAYS) ;-- this extrinsic function will scan the Scheduled 
 ; Visits file (#409.5) for visits (DAYS+1) days prior to the day before admission.
 ; Then a call to ^DGINPW is made to determine if the patient was an
 ; outpatient at the time of the visit.
 ;  INPUT  : DFN -ifn of the patient
 ;           ADM -the date of admission in FM format
 ;           DAYS-number of days prior to adm to check
 ;  OUTPUT : 1-Date of Outpatient care, 0-NO
 N DGT,RESULT,DTM3,X1,X2,X
 S RESULT=0,X1=ADM,X2=-DAYS-1 D C^%DTC S DTM3=X
 F DGT=DTM3:0 S DGT=$O(^SDV("C",DFN,DGT)) Q:'DGT!(DGT'<(ADM-1))  D ^DGINPW I DG1']"" S RESULT=DGT Q
 Q RESULT
 ;
CLIN(DFN,ADM,DAYS) ;-- this extrinsic function will scan the Appointment
 ;  multiple of the Patient file to determine if the patient
 ;  had an outpatient visit (DAYS+1) days prior to the day before admission. 
 ;  If the status (2nd piece) is null then the appointment was kept
 ;  and was an outpatient visit.
 ;  INPUT  : DFN -ifn of the patient
 ;           ADM -the date of admission in FM format
 ;           DAYS-the number of days prior to adm to check
 ;  OUTPUT : YES -date of outpatient care ; NO -0
 N RESULT,DATE,DTM3,X1,X2,X
 S RESULT=0,X1=ADM,X2=-DAYS-1 D C^%DTC S DTM3=X
 F DATE=DTM3:0 S DATE=$O(^DPT(DFN,"S",DATE)) Q:'DATE!(DATE'<(ADM-1))  I $P(^(DATE,0),U,2)']"" S RESULT=DATE Q
 Q RESULT
 ;
DIS10(PAT,ADM,DAYS) ;-- this function will determine if a patient was
 ; discharged within (DAYS) days prior to an admission. The
 ; ^DGPT("ADS" x-ref is used to scan discharge dates then
 ; a check if the patient matches the PAT parameter.
 ;  INPUT  : PAT -ifn of the patient
 ;           ADM -the date of admission in FM format
 ;           DAYS-number of days to check prior to adm
 ;  OUTPUT : YES - discharge date, 0-NO
 N I,Y,RESULT,X1,X2,X,DTM10
 S RESULT=0,X1=ADM,X2=-DAYS D C^%DTC S DTM10=X
 F I=DTM10:0 S I=$O(^DGPT("ADS",I)) Q:'I!(I'<ADM)  S Y=$O(^DGPT("ADS",I,0)) I +$G(^DGPT(+Y,0))=PAT S RESULT=I Q
 Q RESULT
 ;
