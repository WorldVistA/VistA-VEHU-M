YTSMIOS2 ;BAL/KTL - Score MIOS+B-IPF_V2 ; 11/09/23 2:02pm
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
 . N SCOREVAL,CHKTXT,N
 . D LDSCORES^YTSCORE(.YSDATA,.YS) ; puts score into ^TMP($J,"YSCOR",2)
 . D REPORT(.SCOREVAL,.CHKTXT)
 . S N=$O(YSDATA(""),-1) ; get last node
 . S YSDATA(N+1)="7771^9999;1^"_SCOREVAL
 . S YSDATA(N+2)="7772^9999;1^"_CHKTXT
 Q
 ;
SCORESV ; calculate the score
 ; expects YSDATA from DLLSTR
 N I,J,QSTN,QCNT,CID,TOTAL,SHAME,TRUST,BIPF
 S I=2,QCNT=0 F  S I=$O(YSDATA(I)) Q:'I  D
 . S CID=$P(YSDATA(I),U,3) Q:'CID      ; skip checkbox question (no CID)
 . I CID=1155!(CID=1156)!(CID=1157) Q  ; don't include skipped questions
 . S QSTN($P(YSDATA(I),U))=$P($G(^YTT(601.75,CID,0)),U,2),QCNT=QCNT+1
 ; normal cases --
 S TOTAL=$$SUM(.QSTN,"9284,9285,9286,9287,9288,9289,9290,9291,9292,9293,9294,9295,9296,9297")
 S SHAME=$$SUM(.QSTN,"9284,9286,9290,9291,9295,9296,9297") ; Questions 2,4,8,9,13,14,15
 S TRUST=$$SUM(.QSTN,"9285,9287,9288,9289,9292,9293,9294") ; Questions 3,5,6,7,10,11,12
 S BIPF=$$BIPF(.QSTN,"9299,9300,9301,9302,9303,9304,9305")  ; B-IPF questions
 ;
 ; set scores into ^TMP($J,"YSCOR",n)=scaleId=rawScore^tScore
 K ^TMP($J,"YSCOR")
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 ;
 N SCLID,SCLNM
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S I=2,J=1 F  S I=$O(^TMP($J,"YSG",I)) Q:'I  D
 . S SCLID=+$P(^TMP($J,"YSG",I),"=",2)
 . S SCLNM=$P(^TMP($J,"YSG",I),U,4)
 . S J=J+1
 . I SCLID=1561 S ^TMP($J,"YSCOR",J)=SCLNM_"="_SHAME
 . I SCLID=1562 S ^TMP($J,"YSCOR",J)=SCLNM_"="_TRUST
 . I SCLID=1560 S ^TMP($J,"YSCOR",J)=SCLNM_"="_TOTAL
 . I SCLID=1563 S ^TMP($J,"YSCOR",J)=SCLNM_"="_BIPF
 Q
SUM(QSTN,LIST) ; return sum for questions in LIST
 N I,QID,SUM
 S SUM=0
 F I=1:1:$L(LIST,",") S QID=$P(LIST,",",I) D  Q:SUM<0
 . I '$D(QSTN(QID)) S SUM=-1 Q
 . I QSTN(QID)="" S SUM=-1 Q
 . S SUM=SUM+QSTN(QID)
 Q $S(SUM<0:"",1:SUM)
 ;
BIPF(QSTN,LIST) ; return the B-IPF score from questions in LIST
 ; expects YSDATA
 N I,QID,SUM,CNT
 S SUM=0,CNT=0
 F I=1:1:$L(LIST,",") S QID=$P(LIST,",",I) D  Q:SUM<0
 . Q:'$D(QSTN(QID))  ; skipped questions aren't in array  
 . Q:QSTN(QID)=7    ; not applicable (N/A) value is 7 (CHC=5839)
 . S CNT=CNT+1,SUM=SUM+QSTN(QID)
 ; score is (raw score / maximum given number answered) * 100
 I CNT=0 Q ""  ; everything skipped or N/A
 Q $FN((SUM/(CNT*6))*100,"",0)
 ;
REPORT(SCORES,CHKTXT) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 ; YSDATA(2+n)=questionId^sequence^choiceId or text response
 N I,X,NAME,VALUE,TOTAL,SHAME,TRUST,BIPF
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S NAME=$P(^TMP($J,"YSCOR",I),"=")
 . S VALUE=$P(^TMP($J,"YSCOR",I),"=",2)
 . I NAME="MIOS SHAME" S SHAME=VALUE
 . I NAME="MIOS TRUST" S TRUST=VALUE
 . I NAME="MIOS TOTAL" S TOTAL=VALUE
 . I NAME="B-IPF TOTAL" S BIPF=VALUE
 ;
 ; split the checkboxes selected into separate lines <*Answer_9283*>
 S X="",CHKTXT=""
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D  Q:$L(CHKTXT)
 . I $P(YSDATA(I),U)'=9283 Q
 . S X=X_$P(YSDATA(I),U,3,99)
 I +X=1155 S CHKTXT="|     SKIPPED"
 I +X=1156 S CHKTXT="|     Not asked (due to responses to other questions)"
 I +X=1157 S CHKTXT="|     Skipped but required"
 I CHKTXT="" D
 . I X["1. " S CHKTXT=$$WRAP^YTSCAT($G(^YTT(601.75,5822,1)),70,"|     ")_"|"
 . I X["2. " S CHKTXT=CHKTXT_$$WRAP^YTSCAT($G(^YTT(601.75,5823,1)),70,"|     ")_"|"
 . I X["3. " S CHKTXT=CHKTXT_$$WRAP^YTSCAT($G(^YTT(601.75,5824,1)),70,"|     ")_"|"
 . I X["4. " S CHKTXT=CHKTXT_$$WRAP^YTSCAT($G(^YTT(601.75,5825,1)),70,"|     ")_"|"
 I CHKTXT="" S CHKTXT="|     (No selections made)"
 ;
 S X=""
 ; normal case
 S BIPF=$S(BIPF="":" no score",1:$J(BIPF,3)) ; ="" if all N/A
 S X=X_"|            Shame-related Outcomes: "_$J(SHAME,3)
 S X=X_"|  Trust Violation-related Outcomes: "_$J(TRUST,3)
 S X=X_"|                        MIOS Total: "_$J(TOTAL,3)
 S X=X_"|                       B-IPF Total: "_BIPF
 S X=X_"|"
 S X=X_"|Higher MIOS scores indicate greater levels of current moral injury."
 S X=X_"|Higher B-IPF scores indicate more functional impairment."
 S SCORES=X
 Q
