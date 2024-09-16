YTSMINIC ;SLC/PIJ - Score MINI COG ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123,234,249**;DEC 30,1994;Build 30
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
BLDQSTN(QSTN) ; build list of questions and response values in .QSTN
 ; expects YSDATA from DLLSTR
 N I,CID,QID
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S CID=$P(YSDATA(I),U,3),QID=$P(YSDATA(I),U)
 . I $P($G(^YTT(601.72,QID,2)),U,2)'=1 D  QUIT
 . . S QSTN(QID)=$G(QSTN(QID))_$P(YSDATA(I),U,3)
 . S QSTN(QID)=$P($G(^YTT(601.75,CID,0)),U,2)
 Q
SUM(QSTN,LIST) ; return sum for questions in LIST
 N I,QID,SUM
 S SUM=0 F I=1:1:$L(LIST,",") S QID=$P(LIST,",",I) D
 . I QID=5536,(QSTN(5536)>0) S SUM=SUM+2 QUIT  ; clock drawing correct
 . I $G(QSTN(QID)) S SUM=SUM+QSTN(QID)         ; everything else
 Q SUM
 ;
SKIPCNT(QSTN,LIST) ; return the number of skipped questions
 N I,QID,SKIP
 S SKIP=0 F I=1:1:$L(LIST,",") S QID=$P(LIST,",",I) D
 . I $G(QSTN(QID)),(QSTN(QID)="X") S SKIP=SKIP+1
 Q SKIP
 ; 
SCORESV ; Used for Graph and Table
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)="Mini-Cog Scale not found"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,624_",",3,"I")_"="_TOTAL
 Q
 ;
REPORT(TOTAL,QSTN,STXT,BODY) ; build report body
 S STXT=TOTAL
 I TOTAL="" S STXT="Too many items were skipped to score this administration."
 I (TOTAL>2) S STXT=STXT_"  Negative screen for dementia."
 I (+TOTAL=TOTAL),(TOTAL<3) S STXT=STXT_"  Positive for cognitive impairment"
 S STXT="|Mini-Cog Results: "_STXT
 S BODY=""
 S BODY=BODY_"|Clock Drawing:         "_$$ATXT($G(QSTN(5536)))
 S BODY=BODY_"|Recall of FIRST WORD:  "_$$ATXT($G(QSTN(5537)))
 S BODY=BODY_"|Recall of SECOND WORD: "_$$ATXT($G(QSTN(5538)))
 S BODY=BODY_"|Recall of THIRD WORD:  "_$$ATXT($G(QSTN(5539)))_"|"
 S BODY=BODY_"|Word List Version: "_$$WLVER($G(QSTN(9172),0))
 I $D(QSTN(9173)),("^1155^1156^1157^"'[(U_QSTN(9173)_U)) S BODY=BODY_"|Person's Answers: "_QSTN(9173)
 Q
ATXT(VALUE) ; return text answer for value
 I VALUE="X" Q "SKIPPED"
 I VALUE=1 Q "Correct"
 I VALUE=0 Q "Incorrect"
 Q ""
 ;
WLVER(AVER) ; return word list version and words
 I AVER=0 Q "0  (Apple, Watch, Penny)"
 I AVER=1 Q "1  (Banana, Sunrise, Chair)"
 I AVER=2 Q "2  (Leader, Season, Table)"
 I AVER=3 Q "3  (Village, Kitchen, Baby)"
 I AVER=4 Q "4  (River, Nation, Finger)"
 I AVER=5 Q "5  (Captain, Garden, Picture)"
 I AVER=6 Q "6  (Daughter, Heaven, Mountain)"
 Q "SKIPPED"
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 N QSTN,TOTAL,SKIPS
 D BLDQSTN(.QSTN)
 S TOTAL=$$SUM(.QSTN,"5536,5537,5538,5539")
 S SKIPS=$$SKIPCNT(.QSTN,"5536,5537,5538,5539")
 I SKIPS>0 S TOTAL=""
 I YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 . N N,SCORE,QANDA
 . D REPORT(TOTAL,.QSTN,.SCORE,.QANDA)
 . S N=$O(YSDATA(""),-1) ; get last node
 . S YSDATA(N+1)="7771^9999;1^"_SCORE
 . S YSDATA(N+2)="7772^9999;1^"_QANDA
 Q
