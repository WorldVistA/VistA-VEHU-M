YTSSODU ;BAL/KTL - Score SODU ; 10/07/23 2:02pm
 ;;5.01;MENTAL HEALTH;**238**;Dec 30, 1994;Build 25
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
 . N SCOREVAL,LEVEL,N
 . D LDSCORES^YTSCORE(.YSDATA,.YS) ; puts score into ^TMP($J,"YSCOR",2)
 . D REPORT(.SCOREVAL)
 . S N=$O(YSDATA(""),-1) ; get last node
 . S YSDATA(N+1)="7771^9999;1^"_SCOREVAL
 Q
 ;
SCORESV ; calculate the score
 ; expects YSDATA from DLLSTR
 N YTI,YTCHC,SCORE,YTQUES,YTRES
 S YTRES="NEGATIVE"
 S YTI=2 F  S YTI=$O(YSDATA(YTI)) Q:'YTI  D
 . S YTQUES=$P(YSDATA(YTI),U)
 . S YTCHC=$P(YSDATA(YTI),U,3)
 . I (YTCHC=1155)!(YTCHC=1156)!(YTCHC=1157) Q  ; N/A or skipped
 . I YTQUES=9255,(YTCHC>6) S YTRES="POSITIVE"
 . I YTQUES=9256,(YTCHC>1) S YTRES="POSITIVE"
 ;
 ; set scores into ^TMP($J,"YSCOR",n)=scaleId=rawScore^tScore
 K ^TMP($J,"YSCOR")
 S SCORE=$S(YTRES="POSITIVE":1,1:0)
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$P(^YTT(601.87,1558,0),U,4)_"="_SCORE
 Q
REPORT(SCORES) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 N I,VALUE
 S SCORES="NEGATIVE"
 S I=1 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S VALUE=$P(^TMP($J,"YSCOR",I),"=",2)
 . I VALUE>0 S SCORES="POSITIVE"
 S SCORES="SODU is "_SCORES_" for DUD and NCDU."
 Q
VERIFY(ARGS,RESULTS) ; Add inconsistency messages based on set of answers in ARGS
 N MSGCNT S MSGCNT=0
 I $$LT("q9255","q9256") D MSG("more","1","2")
 S RESULTS("count")=MSGCNT
 Q
LT(ID1,ID2) ; returns 1 if ID1 is less than ID2
 ; expects ARGS from VERIFY
 N VAL1,VAL2        ; 1155=not answered, 1156=skipped by rule
 S VAL1=$G(ARGS(ID1)) S:(VAL1="c1156")!(VAL1="c1155") VAL1=0
 S VAL2=$G(ARGS(ID2)) S:(VAL2="c1156")!(VAL2="c1155") VAL2=0
 I +VAL1<+VAL2 Q 1
 Q 0
MSG(REL,Q1,Q2) ; Add text of message to RESULTS
 ; expects MSGCNT, RESULTS from VERIFY
 N X
 S X="There is an inconsistency: The number of days entered in Question "_Q1
 S X=X_" should be equal to, or "_REL_" than,"
 S X=X_" the number of days in Question "_Q2_"."
 S MSGCNT=MSGCNT+1,RESULTS("messages",MSGCNT)=X
 Q
