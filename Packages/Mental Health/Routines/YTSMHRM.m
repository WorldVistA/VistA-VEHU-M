YTSMHRM ;SLC/BLD- MHRM-10 ANSWERS SPECIAL HANDLING FOR MHRM-10
 ;;5.01;MENTAL HEALTH;**150**;DEC 30,1994;Build 210
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 ;
 N DATA,DES,LEG,NODE,YSQN,YSSCALIEN,TOTSCORE,QUES,BASIS,TOTSCR
 N YSCDA,YSSCNAM,YSINSNAM,STRING,STRING1,TOTSCORE
 ;
 ; Basis-24 Psychosis returns a scale score which is calculated and stored, no special text in report
 I YSTRNG=1 D SCORESV Q
 I YSTRNG=2 Q  ;D
 ;
 Q
 ;
STRING ;
 Q
 ;
DATA1 ;
 ;
 N I,II
 S TOTSCORE=0,II=1
 F I=3:1 Q:'$D(YSDATA(I))  S TOTSCORE=TOTSCORE+$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")
 ;F I=1:1 Q:'$D(TOTSCORE(I))  S TOTSCORE=$G(TOTSCORE)+$G(TOTSCORE(I)) Q:'$D(TOTSCORE(I))
 Q
 ;
SCORESV ;
 N YSSCGROUP,I,II
 D DATA1
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=$G(YSINSNAM)_" Scale not found"
 ;
 K ^TMP($J,"YSCOR")
 ;
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S YSSCALIEN=$P($P(^TMP($J,"YSG",3),"^",1),"=",2)
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,YSSCALIEN_",",3,"I")_"="_TOTSCORE
 Q
 ;
