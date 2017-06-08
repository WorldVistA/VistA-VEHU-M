ATTOB2 ;Wash DC; Sid Everhart; Radiology Exam Objects
 ;
LASTEXAM(DFN,ARRAY,TYPE,PROC,IR) ; retrieve impression of last chest xray
 ;  called by S X=$$LASTEXAM^ATTOB2(DFN,"^TMP(""LASTRADEXAM"",DFN),TYPE,PROC,IR) and test routine ^ATTEMP2
 ;  TYPE:  pointer value to Imaging Type file or wild card "*", for all/any type
 ;  PROC:  string which must be 'contained in' databases's procedure found
 ;         by getting an exams procedure from the RAD Procedures file or wild card "*"
 ;    IR:  return type requested - impression text or report text or both: values: "I","R" (`impression' and `report')
 ; E.G. S X=$$LASTEXAM^ATTOB2(DFN,"^TMP(""LASTRADEXAM"",DFN)",1,"CHEST","R") ; last xray of chest `R'eport.
 ; E.G. S X=$$LASTEXAM^ATTOB2(DFN,"^TMP(""LASTRADEXAM"",DFN)",4,"*","I") ; last MRI of any procedure name `I'mpression.
 ; E.G. S X=$$LASTEXAM^ATTOB2(DFN,"^TMP(""LASTRADEXAM"",DFN)",1,"CHEST;CXR","I");  checks for any
 ;      procedure that contain CXR or CHEST string.  If the string passed `PROC' is `contained' in
 ;      the `DBPROC' which is in the database name field referred to by the report being checked.
MAIN D INIT I $D(ABORT) Q "~@"_$NA(@ARRAY)
 N RPTIEN,EXDT,DBPROC,EXIEN,CIEN,ABORT,CNT,DATE,RIEN,NODE,CASE,IMP,RPT,IRNAME,PROCOK,PCNT,PCE
 D NOW^%DTC S EDT=X,X1=X,X2=-365 D C^%DTC S BDT=X
 S EDT=9999999.99999-EDT,BDT=9999999.99999-(BDT-1)
 S CNT=1,IRNAME=$S(IR="R":"Report",IR="I":"Impression",1:""),EXIEN=""
 F  S EXIEN=$O(^RADPT(DFN,"DT",EXIEN)) Q:EXIEN'?1.N.1".".N  S CIEN=0 D  Q:CNT>1
 .  I EXIEN>BDT Q
 .  F  S CIEN=$O(^RADPT(DFN,"DT",EXIEN,"P",CIEN)) Q:CIEN'?1.N  D  Q:CNT>1
 ..    S DBPROC=$P($G(^RADPT(DFN,"DT",EXIEN,"P",CIEN,0)),U,2) Q:DBPROC'?1.N
 ..    S RIEN=$P($G(^RADPT(DFN,"DT",EXIEN,"P",CIEN,0)),U,17) Q:RIEN'?1.N
 ..    S DBTYPE=$P($G(^RAMIS(71,DBPROC,0)),U,12)
 ..    I TYPE'="*" K TYPEOK F PCNT=1:1:$L(TYPE,";") S PCE=$P(TYPE,";",PCNT) S:DBTYPE=PCE TYPEOK=1
 ..    I TYPE'="*" Q:'$D(TYPEOK)
 ..    S DBPROC=$P($G(^RAMIS(71,DBPROC,0)),U)
 ..    I PROC'="*" K PROCOK F PCNT=1:1:$L(PROC,";") S PCE=$P(PROC,";",PCNT) S:DBPROC[PCE PROCOK=1
 ..    I PROC'="*" Q:'$D(PROCOK)
 ..    S RPTNODE=$G(^RARPT(RIEN,0)) Q:$P(RPTNODE,U,5)'="V"  S CNT=1,TIEN=0
 ..    F  S TIEN=$O(^RARPT(RIEN,IR,TIEN)) Q:TIEN'?1.N  S TXTNODE=$G(^(TIEN,0)) I TXTNODE'="",TXTNODE'?1." " D
 ...     ;S CNT=CNT+1,@ARRAY@(0)="^^"_CNT_"^"_CNT,@ARRAY@(CNT,0)=TXTNODE
 ...     S CNT=CNT+1
 ..    I CNT>1 S EXDT=$P(RPTNODE,U,3),EXDT=$E(EXDT,4,5)_"/"_$E(EXDT,6,7)_"/"_$E(EXDT,2,3),CASE=$P(RPTNODE,U,4) D
 ...     ;S @ARRAY@(1,0)=IRNAME_" for "_DBPROC_", "_EXDT_", case "_CASE
 ...     S @ARRAY@(1,0)=DBPROC_", "_EXDT_", case "_CASE
 ...     ; S CNT=CNT+1,@ARRAY@(0)="^^"_CNT_"^"_CNT,@ARRAY@(CNT,0)="------ End of "_IRNAME_" text ------"
 S:CNT'>1 @ARRAY@(0)="^^1^1",@ARRAY@(1,0)="No "_IRNAME_"s found"
 Q "~@"_$NA(@ARRAY)
INIT K ABORT I DFN'?1.N S ABORT=1,@ARRAY@(0)="^^1^1",@ARRAY@(1,0)="Bad DFN value passed: "_DFN Q
 I TYPE'?1.N.";".E,TYPE'?1"*" S ABORT=1,@ARRAY@(0)="^^1^1",@ARRAY@(1,0)="Bad TYPE value passed: "_TYPE Q
 I IR'="I",IR'="R" S ABORT=1,@ARRAY@(0)="^^1^1",@ARRAY@(1,0)="Bad Impression/Report flag passed: "_IR Q
 I '$D(^RARPT("C",DFN)) S ABORT=1,@ARRAY@(0)="^^1^1",@ARRAY@(1,0)="No Radiology exams found. " Q
 K ^TMP("LASTRADEXAM",DFN)
 Q
TYPES ; Here are the types used.  The number (pointer value) must match
 ;  1         GENERAL RADIOLOGY
 ;  2         NUCLEAR MEDICINE
 ;  3         ULTRASOUND
 ;  4         MAGNETIC RESONANCE IMAGING
 ;  5         COMPUTERIZED TOMOGRAPHY
 ;  6         CT SCAN
 ;  7         ANGIO/NEURO/INTERVENTIONAL
 ;  8         CARDIOLOGY STUDIES (NUC MED)
 ;  9         VASCULAR LAB
 ; 58         MAMMOGRAPHY
 Q
