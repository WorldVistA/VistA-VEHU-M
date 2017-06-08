VEJDVEST        ;DSS/SGM - RPC TO RETURN VESTED STATUS ;04/17/2002 21:25
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;  this routine will return the vested status of a patient
 ;  there are two entry points:
 ;    REM - for clinical reminders
 ;    RPC - for RPC calls
 ;  Either returns 1 if vested, else returns 0
 ;  definition of vested patient if patient had any of:
 ;   a. inpatient in the last 3 full fiscal years (include obs ward)
 ;   b. at least one of the CPT codes listed in the CODE module
 ;
REM(DFN,TEST,DATE,VALUE,TEXT) ;  Clinical Reminder
 ;  see routine description above
 N X
 S TEST=0,DATE=""
 S X=$$CHECK I X=1 S TEST=1,DATE=DT
 Q
 ;
RPC(RET,DFN)      ;  RPC to return vested status
 ;  see routine description above
 S RET=$$CHECK
 Q
 ;
CHECK() ;  called from either REM or VEST
 N X,BEG,END,YR D FY
 I $S($G(DFN)<1:1,1:$G(^DPT(DFN,0))="") Q 0
 S X=$$INP I X=1 Q 1
 S X=$$CPT I X=1 Q 1
 Q 0
 ;
CPT() ;  get list of cpt codes to check for basic outpatient vesting
 N I,X,Y,Z,RTN
 S RTN=0
 F I=1:1 S X=$P($T(C+I),";",3) Q:X=""  D  Q:RTN
 .S Z=$$CODEN^ICPTCOD(X) I Z>0 D  Q:RTN
 ..S Y=$O(^AUPNVCPT("AA",DFN,Z,0)) I Y S Y=9999999-(Y\1)
 ..I Y,Y>BEG,Y<END S RTN=1
 .Q
 Q RTN
 ;
FY ;  determine vesting date range
 ;  using current fiscal year plus previous 3 fiscal years
 ;  set BEG=starting Fiscal Year, END=TODAY
 K BEG,END N YR,MON
 S END=DT+.25
 S YR=$E(DT,1,3),MON=+$E(DT,4,5)
 I MON<10 S YR=YR-1
 S BEG=(YR-3)_"0931",END=DT+.25
 Q
 ;
INP(FLG) ;
 ;  Determine if patient ADMITTED to facility for date range
 ;
 ;  DFN - required - pointer to patient file
 ;  BEG - optional - start date in fileman format
 ;  END - optional - end date in fileman format
 ;  FLG - optional - flag indicates which records to check
 ;        default FLG=""  if FLG="N" - exclude observation wards
 ;  return: -1 for error condition, 1 for admit, 0 for no admit
 N DATE,RTN S FLG=$G(FLG),RTN=0
 I '$G(BEG)!'$G(END) N BEG,END D FY
 S DATE=BEG
 F  S DATE=$O(^DGPM("APTT1",DFN,DATE)) Q:DATE>END!'DATE  D  Q:RTN
 .N X,DIERR,ERR,IEN
 .I FLG'="N" S RTN=1 Q
 .;  exclude observation/lodger admissions
 .S IEN=+$O(^DGPM("APTT1",DFN,DATE,0))
 .S X=$$GET1^DIQ(405,IEN_",",.04,,,"ERR")
 .I X'["OBSERVATION",X'["LODGER" S RTN=1 Q
 .;  local checks for observation - Tampa ward name ends in "O"
 .;S X=$$GET1^DIQ(405,IEN_",",.06,,,"ERR")
 .;I $E(X,$L(X))'="O" S RTN=1
 .Q
 Q RTN
 ;
OUT() ;  check for outpatient encounters
 N DATE,GLB,IEN,RTN S RTN=0
 I '$G(BEG)!'$G(END) N BEG,END D FY
 S GLB=$NA(^SCE("ADFN",DFN,BEG))
 F  S GLB=$Q(@GLB) D  Q:RTN
 .S DATE=$QS(GLB,3),IEN=$QS(GLB,4) I DATE>END!'DATE S RTN=-1 Q
 .I $QS(GLB,1)'="ADFN"!($QS(GLB,2)'=DFN) Q
 .;  local checks for additional criteria on encounter
 .S RTN=1
 .Q
 Q RTN
 ;
C ;  codes from vera 2003
 ;;90801;Psychiatric diagnostic interview examination including history, mental  
 ;;90802;Interactive Psychiatric diagnostic interview  
 ;;90805;Inidividual Psychotherapy, 20 - 30 minutes with Medical Evaluation (Amb)  
 ;;90807;Individual Psychotherapy > 45 mins with Medical E and M  
 ;;90809;Individual Psychotherapy > 60 mins with Medical E and M  
 ;;90813;Individual Psychotherapy, Interactive, > 45 mins with Medical E and M  
 ;;90815;Individual Psychotherapy, Interactive, > 60 mins with Medical E and M  
 ;;90817;Inidividual Psychotherapy, 20 - 30 minutes with Medical Evaluation (IP or Res)  
 ;;90819;Individual Psychotherapy, residntial, > 45 mins with Medical E and M  
 ;;90822;Individual Psychotherapy, residential, > 60 mins with Medical E and M  
 ;;99203;Office/outpatient visit new patient, Level 3  
 ;;99204;Office/outpatient visit, new patient, Level 4  
 ;;99205;Office/outpatient visit, new patient, Level 5  
 ;;99213;Office/outpatient visit, established patient, Level 3  
 ;;99214;Office/outpatient visit, established patient, Level 4  
 ;;99215;Office/outpatient visit, established patient, Level 5  
 ;;99243;Office/outpatient consultation, Level 3  
 ;;99244;Office/outpatient consultation, Level 4  
 ;;99245;Office/outpatient consultation, Level 5  
 ;;99283;Emergency department visit, Level 3  
 ;;99284;Emergency department visit, Level 4  
 ;;99285;Emergency department visit, Level 5  
 ;;99343;Home visit for evaluation and management, > 45 minutes  
 ;;99344;Home visit for evaluation and management, > 60 minutes  
 ;;99345;Home visit for evaluation and management, > 75 minutes   
 ;;99349;Home visit for evaluation and management, > 40 minutes  
 ;;99350;Home visit for evaluation and management, > 60 minutes   
 ;;99385;Initial Preventive Visit with Comp history & Comp Exam, 18-39  
 ;;99386;Initial Preventive Visit with Comp history & Comp Exam, 40-64  
 ;;99387;Initial Preventive Visit with Comp history & Comp Exam, 65 and older  
 ;;99395;Periodic Preventive Visit with Comp history & Comp Exam, 18-39  
 ;;99396;Periodic Preventive Visit with Comp history & Comp Exam, 40-64  
 ;;99397;Periodic Preventive Visit with Comp history & Comp Exam, 65 and older  
 ;;99455;Work related or medical disability exammination by treating physician  
 ;;99456;Work related or medical disability exammination, by non-treating physician  
