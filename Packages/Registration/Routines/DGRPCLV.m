DGRPCLV ;LV/PB - ADT RPCs
 ;;5.1;MAS;****;DEC 9, 2013;Build 73
 ;This routine has multiple RPCs created to support the mobile Order Management apps
ADMITS(RESULTS,DFN) ;Returns all admisssions for a patient for the last 365 days
 ;Input parameter: Patient DFN
 ;Returns:
 ;  if admissions are found returns an array in the format of:
 ;  RESULTS(0)=Discharge flag (0 = admitted, 1 = discharged)^Admission date^reason for admission^primary provider^attending physician^length of stay^ward^room-bed^treating specialty^date of discharge^type of discharge
 ; if no admissions are found for the patient in the last year
 ; Returns: 
 ;  RESULTS(INC)="0^No admissions"
 ; Returns the following errors:
 ;  RESULTS(0)="0^DFN Missing"
 ;  RESULTS(0)="0^Not a patient at this facility"
 ;
 K MOVEDT,DTFLG
 I $G(DFN)'>0 S RESULTS(0)="0^DFN Missing" Q
 I '$D(^DPT($G(DFN),0)) S RESULTS(0)="0^Not a patient at this facility" Q
 I '$D(^DGPM("APTT1",DFN)) S RESULTS(0)="0^Patient has not been admitted at this facility" Q
 ;D NOW^%DTC S MOVEDT=$$FMADD^XLFDT(%,-366,0,0,0),INC=1,DTFLG=0 ; removed customer wants all admissions
 S MOVEDT="",INC=1,DTFLG=0
 ;I $D(^DGPM("APTT1",DFN)) D CHKDT
 ;I DTFLG=1 S RESULTS(0)="0^Patient has not been admitted at this facility in the last year." Q
 F  S MOVEDT=$O(^DGPM("APTT1",DFN,MOVEDT)) Q:MOVEDT'>0  S REC=0 F  S REC=$O(^DGPM("APTT1",DFN,MOVEDT,REC)) Q:REC'>0  D
 .K NODE,W1,WARD,RM1,RMBED,P1,PROVIDER,ATENDING,DGPP,DGAP,S1,TRSPCLTY,SHRTDIAG,DISFLAG,ADFLG,DISDATE,R1,TYPEDIS,STAYLEN
 .S NODE=$G(^DGPM(REC,0)),ADFLG=0
 .S W1=$P(NODE,"^",6) S:$G(W1)>0 WARD=$P(^DIC(42,W1,0),"^")
 .S RM1=$P(NODE,"^",7) S:$G(RM1)>0 RMBED=$P(^DG(405.4,RM1,0),"^")
 .S (DGPP,DGAP)="" D NOW^%DTC S NOWI=9999999.999999-% K %
 .F I=NOWI:0 S I=$O(^DGPM("ATS",DFN,REC,I)) Q:'I  F J=0:0 S J=$O(^DGPM("ATS",DFN,REC,I,J)) Q:'J  F IFN=0:0 S IFN=$O(^DGPM("ATS",DFN,REC,I,J,IFN)) Q:'IFN  D TS1
 .S PROVIDER=DGPP,ATENDING=DGAP
 .S S1=$P(NODE,"^",9) S:$G(S1)>0 TRSPCLTY=$P(^DIC(45.7,S1,0),"^")
 .S SHRTDIAG=$P(NODE,"^",10)
 .S DISFLAG=$P(NODE,"^",17)
 .I $G(DISFLAG)>0 S ADFLG=1,DISDATE=$P(^DGPM($G(DISFLAG),0),"^"),R1=$P(^DGPM($G(DISFLAG),0),"^",4),TYPEDIS=$P(^DG(405.1,R1,0),"^"),STAYLEN=$$FMDIFF^XLFDT(DISDATE,MOVEDT,1)
 .S RESULTS(INC)=$G(ADFLG)_"^"_MOVEDT_"^"_$G(SHRTDIAG)_"^"_$G(PROVIDER)_"^"_$G(ATENDING)_"^"_$G(STAYLEN)_"^"_$G(WARD)_"^"_$G(RMBED)_"^"_$G(TRSPCLTY)_"^"_$G(DISDATE)_"^"_$G(TYPEDIS),INC=$G(INC)+1
 .K NODE,W1,WARD,RM1,RMBED,P1,PROVIDER,ATENDING,DGPP,DGAP,S1,TRSPCLTY,SHRTDIAG,DISFLAG,ADFLG,DISDATE,R1,TYPEDIS,STAYLEN
 K MOVEDT,DFN,NODE,W1,I,IFN,INC,J,WARD,RM1,RMBED,P1,NOWI,REC,PROVIDER,ATENDING,DGPP,DGAP,S1,TRSPCLTY,SHRTDIAG,DISFLAG,ADFLG,DISDATE,R1,TYPEDIS,STAYLEN,DTFLG
 Q
TS1 ; set DGPP, and DGAP
 Q:'$D(^DGPM(IFN,0))  S DGX=^(0)
 I 'DGPP,$D(^VA(200,+$P(DGX,"^",8),0)) S Y=$P(DGX,"^",8)_"|"_$P(^(0),"^") S DGPP=Y
 I 'DGAP,$D(^VA(200,+$P(DGX,"^",19),0)) S Y=$P(DGX,"^",19)_"|"_$P(^(0),"^") S DGAP=Y
 K DGX,Y
 Q
CHKDT ; checks to see if the patient's admission is prior to the date range entered
 S Z1="" F  S Z1=$O(^DGPM("APTT1",DFN,Z1)) Q:Z1=""  D
 .S:Z1>MOVEDT DTFLG=0
 .S:Z1<MOVEDT DTFLG=1
 K Z1
 Q
