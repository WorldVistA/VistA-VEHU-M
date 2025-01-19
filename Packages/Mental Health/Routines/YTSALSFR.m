YTSALSFR ;ISP/LMT - Report ALSFRS-R ;Jul 31, 2024@10:22:10
 ;;5.01;MENTAL HEALTH;**250**;Dec 30, 1994;Build 26
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
 I YSTRNG=1 D BYKEY^YTSCORE(.YSDATA)  ; just use "regular" scoring
 ;
 I YSTRNG=2 D REPORT(.YSDATA)
 ;
 Q
 ;
REPORT(YSDATA) ; line wrap long answers
 ;
 N YSCHOICE,YSI,YSN,YSQLIST,YSQNEW,YSTEXT
 ;
 S YSQLIST(9516)=7771
 S YSQLIST(9522)=7772
 S YSQLIST(9526)=7773
 S YSQLIST(9527)=7774
 ;
 S YSN=$O(YSDATA(""),-1) ; get last node
 ;
 S YSI=2
 F  S YSI=$O(YSDATA(YSI)) Q:'YSI  D
 . S YSTEXT=""
 . S YSQNEW=$G(YSQLIST(+$P(YSDATA(YSI),U,1)))
 . I YSQNEW'>0 QUIT
 . S YSCHOICE=+$P(YSDATA(YSI),U,3)
 . I YSCHOICE=1157 S YSTEXT="|     Skipped but required"
 . I YSTEXT="" D
 . . S YSTEXT=$G(^YTT(601.75,YSCHOICE,1))
 . . S YSTEXT=$$WRAP^YTSCAT(YSTEXT,70,"|     ")
 . S YSN=YSN+1
 . S YSDATA(YSN)=YSQNEW_"^9999;1^"_YSTEXT
 ;
 Q
 ;
