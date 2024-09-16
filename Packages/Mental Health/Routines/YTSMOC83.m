YTSMOC83 ;BAL/KTL - Score MOCA 8.3 ; 10/14/18 2:02pm
 ;;5.01;MENTAL HEALTH;**249**;Dec 30, 1994;Build 30
 ;
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
 Q
 ;
SCORESV ; calculate the score
 ; expects YSDATA from DLLSTR
 N YTI,YTRAW,YTCNT,YTCHC,SCORE,YTMIS,YTQ,YTVAL
 S (YTRAW,YTCNT,YTMIS)=0
 S YTI=2 F  S YTI=$O(YSDATA(YTI)) Q:'YTI  D
 . S YTQ=$P(YSDATA(YTI),U)
 . S YTCHC=$P(YSDATA(YTI),U,3)
 . I (YTCHC=1155)!(YTCHC=1156)!(YTCHC=1157) Q  ; N/A or skipped
 . S YTCNT=YTCNT+1
 . S YTVAL=$P(^YTT(601.75,YTCHC,0),U,2)
 . I YTQ>9481,(YTQ<9487) S YTVAL=$S(YTVAL=3:1,1:0)  ;3 scored as 1 in Total
 . S YTRAW=YTRAW+YTVAL
 . I YTQ>9481,(YTQ<9487) S YTMIS=YTMIS+$P(^YTT(601.75,YTCHC,0),U,2)
 I YTCNT=0 S (SCORE,YTMIS)=0 I 1  ; everything skipped or N/A
 E  S SCORE=YTRAW
 ;
 ; set scores into ^TMP($J,"YSCOR",n)=scaleId=rawScore^tScore
 K ^TMP($J,"YSCOR")
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$P(^YTT(601.87,1586,0),U,4)_"="_SCORE
 S ^TMP($J,"YSCOR",3)=$P(^YTT(601.87,1587,0),U,4)_"="_YTMIS
 Q
REPORT(YSDATA) ; build the numerical answer array for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 Q
