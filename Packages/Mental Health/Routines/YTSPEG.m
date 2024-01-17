YTSPEG ;BAL/KTL - Score PEG ; 3/25/22 2:02pm
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
 I YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 . N SCORES,N
 . D LDSCORES^YTSCORE(.YSDATA,.YS) ; puts score into ^TMP($J,"YSCOR",2)
 . D REPORT(.SCORES)
 . ;S N=$O(YSDATA(""),-1) ; get last node
 Q
 ;
SCORESV ; calculate the score
 ; expects YSDATA from DLLSTR (YSDATA from LOADANSW^YTSCORE,SCALEG^YTQAPI3)
 N I,J,CHOICE,SKPCNT,AVE,QUES,TOT
 S (SKPCNT,AVE,TOT)=0
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S QUES=$P(YSDATA(I),U)
 . S CHOICE=$P(YSDATA(I),U,3)
 . I CHOICE=1155 S SKPCNT=SKPCNT+1 Q
 . S TOT=TOT+CHOICE
 I SKPCNT>0 S TOT=TOT*($S(SKPCNT=1:1.5,SKPCNT=2:3,1:1))  ; Estimated total if skipped questions
 S AVE=$J(TOT/3,"",0)  ;Whole number rounded average of answered questions
 ;
 ; set scores into ^TMP($J,"YSCOR",n)=scaleName=score {rawScore^tScore}
 K ^TMP($J,"YSCOR")
 I $D(^TMP($J,"YSG",1)),(^TMP($J,"YSG",1)="[ERROR]") D  Q  ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 ;
 N SCLID,SCLNM
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S I=2,J=1 F  S I=$O(^TMP($J,"YSG",I)) Q:'I  D
 . S SCLID=+$P(^TMP($J,"YSG",I),"=",2)
 . S SCLNM=$P(^TMP($J,"YSG",I),U,4)
 . S J=J+1
 . I SCLID=1502 S ^TMP($J,"YSCOR",J)=SCLNM_"="_AVE
 Q
REPORT(SCORES) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 Q
 N I,NAME,VAL
 S SCORES="Negative"
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S NAME=$E($P(^TMP($J,"YSCOR",I),"="),1,5)
 . S VAL=$P(^TMP($J,"YSCOR",I),"=",2)
 . I NAME="BIPOL" S SCORES=$S(+VAL=0:"Negative",1:"Positive")
 Q
