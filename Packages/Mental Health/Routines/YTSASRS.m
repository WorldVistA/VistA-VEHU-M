YTSASRS ;ISP/LMT - Scoring and Report for ASRS ;Dec 20, 2023@13:04:34
 ;;5.01;MENTAL HEALTH;**239**;Dec 30, 1994;Build 16
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
 N YSN,YSTEXT
 ;
 I YSTRNG=1 D SCORESV
 ;
 I YSTRNG=2 D
 . D LDSCORES^YTSCORE(.YSDATA,.YS) ; puts score into ^TMP($J,"YSCOR",2)
 . S YSTEXT=$$REPORT(.YSDATA)
 . S YSN=$O(YSDATA(""),-1) ; get last node
 . S YSN=YSN+1
 . S YSDATA(YSN)="7771^9999;1^"_$P(YSTEXT,U,1)
 . S YSN=YSN+1
 . S YSDATA(YSN)="7772^9999;1^"_$P(YSTEXT,U,2)
 Q
 ;
 ;
SCORESV ; calculate the score
 ; expects YSDATA from DLLSTR (YSDATA from LOADANSW^YTSCORE,SCALEG^YTQAPI3)
 ;
 ; ZEXCEPT: YSDATA
 N YSANSWER,YSCHOICEID,YSI,YSJ,YSPARTA,YSQUESTION,YSSCLID,YSSCLNM,YSSCRCARD
 ;
 S YSSCRCARD(9331)=1 ;answer must be greater than this to have a score of 1
 S YSSCRCARD(9332)=1
 S YSSCRCARD(9333)=1
 S YSSCRCARD(9334)=2
 S YSSCRCARD(9335)=2
 S YSSCRCARD(9336)=2
 S YSPARTA=0
 ;
 S YSI=2
 F  S YSI=$O(YSDATA(YSI)) Q:'YSI  D
 . S YSQUESTION=$P(YSDATA(YSI),U)
 . S YSCHOICEID=$P(YSDATA(YSI),U,3)
 . S YSANSWER=$P($G(^YTT(601.75,+YSCHOICEID,0)),U,2)
 . I YSQUESTION=""!(YSANSWER="") QUIT
 . I $D(YSSCRCARD(YSQUESTION)) D
 . . I YSANSWER>YSSCRCARD(YSQUESTION) S YSPARTA=YSPARTA+1
 ;
 ; set scores into ^TMP($J,"YSCOR",n)=scaleName=score {rawScore^tScore}
 K ^TMP($J,"YSCOR")
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 ;
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S YSI=2
 S YSJ=1
 F  S YSI=$O(^TMP($J,"YSG",YSI)) Q:'YSI  D
 . S YSSCLID=+$P(^TMP($J,"YSG",YSI),"=",2)
 . S YSSCLNM=$P(^TMP($J,"YSG",YSI),U,4)
 . S YSJ=YSJ+1
 . I YSSCLID=1566 S ^TMP($J,"YSCOR",YSJ)=YSSCLNM_"="_YSPARTA
 Q
 ;
 ;
REPORT(YSDATA) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 ;
 N YSANSWER,YSCHOICEID,YSCNT,YSI,YSINDENT,YSNAME,YSNODE,YSPARTA,YSPARTB,YSQUESTION,YSSCRCARD,YSVAL
 N YSCNTNT,YSQIDNT,YSJ,YSINSNAM
 ;
 ; Part A
 S YSI=0 F  S YSI=$O(^TMP($J,"YSCOR",YSI)) Q:'YSI  D
 . S YSNAME=$P(^TMP($J,"YSCOR",YSI),"=")
 . S YSVAL=$P(^TMP($J,"YSCOR",YSI),"=",2)
 . S YSPARTA=""
 . I YSNAME="Total Part A" D
 . . I YSVAL>3 S YSPARTA="Veteran's responses are highly consistent with ADHD in adults and|    further investigation is warranted."
 . . E  S YSPARTA="Veteran's symptoms are not consistent with ADHD in adults."
 ;
 ; Part B Relevant Responses
 S YSSCRCARD(9337)=2 ;answer must be greater than this to be considered relevant
 S YSSCRCARD(9338)=2
 S YSSCRCARD(9339)=1
 S YSSCRCARD(9340)=2
 S YSSCRCARD(9341)=2
 S YSSCRCARD(9342)=1
 S YSSCRCARD(9343)=2
 S YSSCRCARD(9344)=2
 S YSSCRCARD(9345)=2
 S YSSCRCARD(9346)=1
 S YSSCRCARD(9347)=2
 S YSSCRCARD(9348)=1
 ;
 S YSINDENT=9
 S YSPARTB="|"
 S YSCNT=0
 ;
 S YSINSNAM=$P(YSDATA(2),U,3)
 I YSINSNAM'="" S YSINSNAM=$O(^YTT(601.71,"B",YSINSNAM,0))
 S YSI=2
 F  S YSI=$O(YSDATA(YSI)) Q:'YSI  D
 . S YSNODE=$G(YSDATA(YSI))
 . S YSQUESTION=$P(YSNODE,U,1)
 . S YSCHOICEID=$P(YSNODE,U,3)
 . S YSANSWER=$P($G(^YTT(601.75,+YSCHOICEID,0)),U,2)
 . I YSQUESTION=""!(YSANSWER="") QUIT
 . S YSQIDNT=""
 . S YSCNTNT=0
 . S YSJ=0 F  S YSJ=$O(^YTT(601.76,"AE",YSQUESTION,YSJ)) Q:'YSJ  D
 . . I $P($G(^YTT(601.76,YSJ,0)),U,2)=YSINSNAM S YSCNTNT=YSJ
 . I YSCNTNT S YSQIDNT=$P(^YTT(601.76,YSCNTNT,0),U,5)  ;MH CONTENT question DESIGNATOR
 . S:$E(YSQIDNT,$L(YSQIDNT))="." YSQIDNT=$E(YSQIDNT,1,$L(YSQIDNT)-1)  ;Remove trailing .
 . ;
 . I $D(YSSCRCARD(YSQUESTION)),YSANSWER>YSSCRCARD(YSQUESTION) D
 . . S YSCNT=YSCNT+1
 . . S YSPARTB=YSPARTB_$$QFORMAT^YTSLEC(YSQIDNT,YSQUESTION,YSINDENT)  ; question
 . . S YSPARTB=YSPARTB_"|"_$$REPEAT^XLFSTR(" ",YSINDENT)_$P($G(^YTT(601.75,YSCHOICEID,1)),U,1)  ; answer
 ;
 I 'YSCNT S YSPARTB="None."  ; There are no relevant responses.
 ;
 Q YSPARTA_U_YSPARTB
