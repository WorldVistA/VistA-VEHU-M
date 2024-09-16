YTSYMRS ;BAL/KTL - Score YMRS ; 10/14/18 2:02pm
 ;;5.01;MENTAL HEALTH;**249**;Dec 30, 1994;Build 30
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
 . D REPORT(.YSDATA)  ;Get numerical answer values for report questions
 Q
 ;
SCORESV ; calculate the score
 ; expects YSDATA from DLLSTR
 N YTI,YTRAW,YTCNT,YTCHC,SCORE
 S YTRAW=0,YTCNT=0
 S YTI=2 F  S YTI=$O(YSDATA(YTI)) Q:'YTI  D
 . S YTCHC=$P(YSDATA(YTI),U,3)
 . I (YTCHC=1155)!(YTCHC=1156)!(YTCHC=1157) Q  ; N/A or skipped
 . S YTCNT=YTCNT+1
 . S YTRAW=YTRAW+$P(^YTT(601.75,YTCHC,0),U,2)
 I YTCNT=0 S SCORE="" I 1  ; everything skipped or N/A
 E  S SCORE=YTRAW
 ;
 ; set scores into ^TMP($J,"YSCOR",n)=scaleId=rawScore^tScore
 K ^TMP($J,"YSCOR")
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$P(^YTT(601.87,1580,0),U,4)_"="_SCORE
 Q
REPORT(YSDATA) ; build the numerical answer array for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 ; Question IEN = 9396-9406
 ; Answer array = 7771-7781
 N YTI,YTRAW,YTCNT,YTCHC,YTQUE,YTANS,N,TMPYS
 S N=$O(YSDATA(""),-1) ; get last node
 S YTRAW=0,YTCNT=0
 S YTI=2 F  S YTI=$O(YSDATA(YTI)) Q:'YTI  D
 . S YTQUE=$P(YSDATA(YTI),U)
 . S YTCHC=$P(YSDATA(YTI),U,3)
 . S YTANS=YTQUE-1625  ;e.g. 9396-1625=7771
 . I (YTCHC=1155)!(YTCHC=1156)!(YTCHC=1157) D  Q  ; N/A or skipped
 .. S N=N+1,TMPYS(N)=YTANS_"^9999;1^"_$S(YTCHC=1155:"Skipped",YTCHC=1156:"Not asked (due to responses on other questions)",1:"Missing")
 . S N=N+1,TMPYS(N)=YTANS_"^9999;1^"_$P(^YTT(601.75,YTCHC,0),U,2)
 M YSDATA=TMPYS
 Q
