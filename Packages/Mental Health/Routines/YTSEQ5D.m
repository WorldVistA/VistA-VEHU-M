YTSEQ5D ;SLC/KCM - Score EQ-5D-5L ; 3/25/22 2:02pm
 ;;5.01;MENTAL HEALTH;**233**;Dec 30, 1994;Build 13
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
 I YSTRNG=1 D SCORESV Q
 I YSTRNG=2 D
 . N SCORES,STATE,N
 . D LDSCORES^YTSCORE(.YSDATA,.YS) ; puts score into ^TMP($J,"YSCOR",2)
 . D REPORT(.STATE)
 . S N=$O(YSDATA(""),-1) ; get last node
 . S YSDATA(N+1)="7771^9999;1^"_STATE
 Q
SCORESV ; calculate the score
 ; expects YSDATA from DLLSTR (YSDATA from LOADANSW^YTSCORE,SCALEG^YTQAPI3)
 N QSTN,MOBILE,SELFCARE,ACTIVITY,PAIN,ANXIETY,EQVAS
 D BLDQSTN(.QSTN)
 S MOBILE=$G(QSTN(9049))
 S SELFCARE=$G(QSTN(9050))
 S ACTIVITY=$G(QSTN(9051))
 S PAIN=$G(QSTN(9052))
 S ANXIETY=$G(QSTN(9053))
 S EQVAS=$G(QSTN(9054))
 ;
 ; set scores into ^TMP($J,"YSCOR",n)=scaleName=score {rawScore^tScore}
 K ^TMP($J,"YSCOR")
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 ;
 N I,J,SCLID,SCLNM
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S I=2,J=1 F  S I=$O(^TMP($J,"YSG",I)) Q:'I  D
 . S SCLID=+$P(^TMP($J,"YSG",I),"=",2)
 . S SCLNM=$P(^TMP($J,"YSG",I),U,4)
 . S J=J+1
 . I SCLID=1486 S ^TMP($J,"YSCOR",J)=SCLNM_"="_MOBILE
 . I SCLID=1487 S ^TMP($J,"YSCOR",J)=SCLNM_"="_SELFCARE
 . I SCLID=1488 S ^TMP($J,"YSCOR",J)=SCLNM_"="_ACTIVITY
 . I SCLID=1489 S ^TMP($J,"YSCOR",J)=SCLNM_"="_PAIN
 . I SCLID=1490 S ^TMP($J,"YSCOR",J)=SCLNM_"="_ANXIETY
 . I SCLID=1491 S ^TMP($J,"YSCOR",J)=SCLNM_"="_EQVAS
 Q
BLDQSTN(QSTN) ; build list of questions and response values in .QSTN
 ; expects YSDATA from DLLSTR
 N I,CID,QID
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S CID=$P(YSDATA(I),U,3),QID=$P(YSDATA(I),U)
 . I CID=1155!(CID=1156)!(CID=1157) Q  ; don't include skipped questions
 . I $P($G(^YTT(601.72,QID,2)),U,2)'=1 D  QUIT
 . . S QSTN(QID)=$G(QSTN(QID))_$P(YSDATA(I),U,3)
 . S QSTN(QID)=$P($G(^YTT(601.75,CID,0)),U,2)
 Q
 ;
REPORT(STATE) ; Build EQ-5D-5L score string
 N I,NAME,VALUE,MOBILE,SELFCARE,ACTIVITY,PAIN,ANXIETY,X,SKIP
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S NAME=$P(^TMP($J,"YSCOR",I),"=")
 . S VALUE=$P(^TMP($J,"YSCOR",I),"=",2)
 . I NAME="Mobility" S MOBILE=VALUE
 . I NAME="Self-Care" S SELFCARE=VALUE
 . I NAME="Activities" S ACTIVITY=VALUE
 . I NAME="Pain" S PAIN=VALUE
 . I NAME="Anxiety" S ANXIETY=VALUE
 S X="",SKIP="_"
 S X=X_$S(+$G(MOBILE):MOBILE,1:SKIP)
 S X=X_$S(+$G(SELFCARE):SELFCARE,1:SKIP)
 S X=X_$S(+$G(ACTIVITY):ACTIVITY,1:SKIP)
 S X=X_$S(+$G(PAIN):PAIN,1:SKIP)
 S X=X_$S(+$G(ANXIETY):ANXIETY,1:SKIP)
 S STATE=X
 Q
TESTSCR(YSAD) ; Test scoring routine
 N YS,YSDATA
 S YS("AD")=YSAD,YS("CODE")="EQ-5D-5L"
 D LOADANSW^YTSCORE(.YSDATA,.YS)
 D SCALEG^YTQAPI3(.YSDATA,.YS)
 D DLLSTR(.YSDATA,.YS,1)
 Q
