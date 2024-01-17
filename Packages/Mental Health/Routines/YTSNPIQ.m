YTSNPIQ ;SLC/KCM - Reporting logic for NPI-Q ; 3/25/22 2:02pm
 ;;5.01;MENTAL HEALTH;**234**;Dec 30, 1994;Build 38
 ;
DLLSTR(YSDATA,YS,YSTRNG) ; compute scores or report text based on YSTRNG
 ; input
 ;   YSDATA(2)=adminId^patientDFN^instrumentName^dateGiven^isComplete
 ;   YSDATA(2+n)=questionId^sequence^choiceId
 ;   YS("AD")=adminId
 ;   YSTRNG=1 for score, 2 for report
 ; output if YSTRNG=1: ^TMP($J,"YSCOR",n)=scaleId=score
 ; output if YSTRNG=2: append special "answers" to YSDATA
 ;
 I YSTRNG=1 D BYKEY^YTSCORE(.YSDATA)  ; just use "regular" scoring
 I YSTRNG=2 D
 . N SUMMARY,LN,SCORES
 . D LDSCORES^YTSCORE(.YSDATA,.YS)    ; puts scores into ^TMP($J,"YSCOR")
 . D BLDSCR(.SCORES)
 . D REPORT(.SUMMARY,.SCORES)
 . S LN=$O(YSDATA(""),-1) ; get last node
 . S YSDATA(LN+1)="7771^9999;1^"_SUMMARY
 Q
 ;
REPORT(SUMMARY,SCORES) ; build .SCORE string
 ; expects YSDATA for answers
 N QSTN,X
 D BLDQSTN(.QSTN)
 S X=""
 S X=X_$$MKLN("|","Symptom","","Caregiver")
 S X=X_$$MKLN("|","Present","Severity","Distress")
 S X=X_"|--------------------------------------------------------"
 S X=X_$$MKLN("|Delusions",QSTN(9176),QSTN(9177),QSTN(9178))
 S X=X_$$MKLN("|Hallucinations",QSTN(9179),QSTN(9180),QSTN(9181))
 S X=X_$$MKLN("|Agitation/Aggression",QSTN(9182),QSTN(9183),QSTN(9184))
 S X=X_$$MKLN("|Depression/Dysphoria",QSTN(9185),QSTN(9186),QSTN(9187))
 S X=X_$$MKLN("|Anxiety",QSTN(9188),QSTN(9189),QSTN(9190))
 S X=X_$$MKLN("|Elation/Euphoria",QSTN(9191),QSTN(9192),QSTN(9193))
 S X=X_$$MKLN("|Apathy/Indifference",QSTN(9194),QSTN(9195),QSTN(9196))
 S X=X_$$MKLN("|Disinhibition",QSTN(9197),QSTN(9198),QSTN(9199))
 S X=X_$$MKLN("|Irritability/Lability",QSTN(9200),QSTN(9201),QSTN(9202))
 S X=X_$$MKLN("|Motor Disturbance",QSTN(9203),QSTN(9204),QSTN(9205))
 S X=X_$$MKLN("|Nighttime Behaviors",QSTN(9206),QSTN(9207),QSTN(9208))
 S X=X_$$MKLN("|Appetite/Eating",QSTN(9209),QSTN(9210),QSTN(9211))
 S X=X_"|"
 S X=X_$$MKLN("|                TOTAL",SCORES("Symptoms"),SCORES("Severity"),SCORES("Distress"))
 S SUMMARY=X
 Q
MKLN(SYM,PRES,SEV,DIS) ; return a summary line
 N LN,SPACES
 S LN="",SPACES="                              "
 I PRES="No" S SEV="",DIS=""
 S LN=LN_SYM_$E(SPACES,1,25-$L(SYM))
 S LN=LN_PRES_$E(SPACES,1,10-$L(PRES))
 S LN=LN_SEV_$E(SPACES,1,11-$L(SEV))
 S LN=LN_DIS
 Q LN
 ;
BLDQSTN(QSTN) ; build list of questions and response values in .QSTN
 ; expects YSDATA,YSTRNG from DLLSTR
 N I,CID,QID,VAL
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S CID=$P(YSDATA(I),U,3),QID=$P(YSDATA(I),U),VAL="?"
 . ; check the symptom selections
 . I (QID=9176)!(QID=9179)!(QID=9182)!(QID=9185)!(QID=9188)!(QID=9191)!(QID=9194)!(QID=9197)!(QID=9200)!(QID=9203)!(QID=9206)!(QID=9209) D
 . . I CID=1155!(CID=1156)!(CID=1157) S VAL="SKIP"
 . . I CID=5690 S VAL="Yes"
 . . I CID=5691 S VAL="No"
 . E  D
 . . ; check the severity, distress selections
 . . I CID=1155!(CID=1156)!(CID=1157) S VAL=""
 . . I CID=5692 S VAL="Mild"
 . . I CID=5693 S VAL="Moderate"
 . . I CID=5694 S VAL="Severe"
 . . I CID=5695 S VAL="Not distressing"
 . . I CID=5696 S VAL="Minimal"
 . . I CID=5697 S VAL="Mild"
 . . I CID=5698 S VAL="Moderate"
 . . I CID=5699 S VAL="Severe"
 . . I CID=5700 S VAL="Extreme"
 . S QSTN(QID)=VAL
 Q
BLDSCR(SCORES) ; build array of .SCORES
 ; expects ^TMP($J,"YSCOR") from DLLSTR
 N I,NAME,VALUE
 S SCORES("Symptoms")=""
 S SCORES("Severity")=""
 S SCORES("Distress")=""
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S NAME=$P(^TMP($J,"YSCOR",I),"=")
 . S VALUE=$P(^TMP($J,"YSCOR",I),"=",2)
 . I NAME="Symptoms" S SCORES("Symptoms")=VALUE
 . I NAME="Severity" S SCORES("Severity")=VALUE
 . I NAME="Distress" S SCORES("Distress")=VALUE
 Q
