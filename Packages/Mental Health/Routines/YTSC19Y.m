YTSC19Y ;SLC/KCM - Score Modified C19-YRS ; 3/25/22 2:02pm
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
 I YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 . N SCORES,QANDA,N
 . D LDSCORES^YTSCORE(.YSDATA,.YS) ; puts score into ^TMP($J,"YSCOR",2)
 . D REPORT(.SCORES,.QANDA)
 . S N=$O(YSDATA(""),-1) ; get last node
 . S YSDATA(N+1)="7771^9999;1^"_SCORES
 . S YSDATA(N+2)="7772^9999;1^"_QANDA
 Q
 ;
SCORESV ; calculate the score
 ; expects YSDATA from DLLSTR (YSDATA from LOADANSW^YTSCORE,SCALEG^YTQAPI3)
 N QSTN,SYMNOW,SYMPRE,DISNOW,DISPRE,OTHSYM,ALLNOW,ALLPRE
 D BLDQSTN(.QSTN)
 S SYMNOW(1)=$$HIGHEST(.QSTN,"8979,8981,8983,8985")
 S SYMPRE(1)=$$HIGHEST(.QSTN,"8980,8982,8984,8986")
 S SYMNOW(2)=$$HIGHEST(.QSTN,"8987,8989")
 S SYMPRE(2)=$$HIGHEST(.QSTN,"8988,8990")
 S SYMNOW(3)=$G(QSTN(8991))
 S SYMPRE(3)=$G(QSTN(8992))
 S SYMNOW(4)=$$HIGHEST(.QSTN,"8993,8995")
 S SYMPRE(4)=$$HIGHEST(.QSTN,"8994,8996")
 S SYMNOW(5)=$$HIGHEST(.QSTN,"8997,8999,9001,9003,9005")
 S SYMPRE(5)=$$HIGHEST(.QSTN,"8998,9000,9002,9004,9006")
 S SYMNOW(6)=$$HIGHEST(.QSTN,"9007,9009,9011")
 S SYMPRE(6)=$$HIGHEST(.QSTN,"9008,9010,9012")
 S SYMNOW(7)=$$HIGHEST(.QSTN,"9013,9015")
 S SYMPRE(7)=$$HIGHEST(.QSTN,"9014,9016")
 S SYMNOW(8)=$G(QSTN(9017))
 S SYMPRE(8)=$G(QSTN(9018))
 S SYMNOW(9)=$$HIGHEST(.QSTN,"9019,9021,9023,9025,9027")
 S SYMPRE(9)=$$HIGHEST(.QSTN,"9020,9022,9024,9026,9028")
 S SYMNOW(10)=$G(QSTN(9029))
 S SYMPRE(10)=$G(QSTN(9030))
 S SYMNOW=0 F I=1:1:10 S SYMNOW=SYMNOW+SYMNOW(I)
 S SYMPRE=0 F I=1:1:10 S SYMPRE=SYMPRE+SYMPRE(I)
 S DISNOW=$$SUM(.QSTN,"9031,9033,9035,9037,9039")
 S DISPRE=$$SUM(.QSTN,"9032,9034,9036,9038,9040")
 I $G(QSTN(9041))="Left blank by the user." S OTHSYM=0 I 1
 E  S OTHSYM=$$CHKCNT(9041,$G(QSTN(9041)))
 S ALLNOW=$G(QSTN(9043)) ; <-- these aren't CID values
 S ALLPRE=$G(QSTN(9044))
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
 . I SCLID=1495 S ^TMP($J,"YSCOR",J)=SCLNM_"="_SYMNOW
 . I SCLID=1496 S ^TMP($J,"YSCOR",J)=SCLNM_"="_SYMPRE
 . I SCLID=1497 S ^TMP($J,"YSCOR",J)=SCLNM_"="_DISNOW
 . I SCLID=1498 S ^TMP($J,"YSCOR",J)=SCLNM_"="_DISPRE
 . I SCLID=1499 S ^TMP($J,"YSCOR",J)=SCLNM_"="_ALLNOW
 . I SCLID=1500 S ^TMP($J,"YSCOR",J)=SCLNM_"="_ALLPRE
 . I SCLID=1485 S ^TMP($J,"YSCOR",J)=SCLNM_"="_OTHSYM
 Q
HIGHEST(QSTN,LIST) ; return highest value in LIST
 N I,HIGH,SKIPS,QID
 S HIGH=0,SKIPS=0
 F I=1:1:$L(LIST,",") S QID=$P(LIST,",",I) D
 . I '$D(QSTN(QID))!($G(QSTN(QID))="") S SKIPS=SKIPS+1 QUIT
 . I QSTN(QID)>HIGH S HIGH=QSTN(QID)
 Q HIGH
 ;
SUM(QSTN,LIST) ; return sum for questions in LIST
 N I,QID,SUM
 S SUM=0 F I=1:1:$L(LIST,",") S QID=$P(LIST,",",I) D
 . I $G(QSTN(QID)) S SUM=SUM+QSTN(QID)
 Q SUM
 ;
CHKCNT(QID,VAL) ; return the number of items checked for question
 N CLST,CNT,I
 D BLDCHKS(.CLST,QID)
 S (CNT,I)=0 F  S I=$O(CLST(I)) Q:'I  I VAL[CLST(I) S CNT=CNT+1
 Q CNT
 ;
BLDCHKS(CLST,QID) ; build list of checklist items for QID into .CLST
 N CTYP,SEQ,CID,X
 K CLST ; make sure list is clear
 S CTYP=$P($G(^YTT(601.72,QID,2)),U,3)
 S SEQ=0 F  S SEQ=$O(^YTT(601.751,"AC",CTYP,SEQ)) Q:'SEQ  D
 . S CID=0 F  S CID=$O(^YTT(601.751,"AC",CTYP,SEQ,CID)) Q:'CID  D
 . . S X=$G(^YTT(601.75,CID,1)),CLST(SEQ)=X
 Q
BLDQSTN(QSTN) ; build list of questions and response values in .QSTN
 ; expects YSDATA,YSTRNG from DLLSTR
 N I,CID,QID
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D
 . S CID=$P(YSDATA(I),U,3),QID=$P(YSDATA(I),U)
 . I CID=1155!(CID=1156)!(CID=1157) Q  ; don't include skipped questions
 . I CID=5548,(YSTRNG=1) Q             ; don't include "Don't Know" for score
 . I $P($G(^YTT(601.72,QID,2)),U,2)'=1 D  QUIT
 . . S QSTN(QID)=$G(QSTN(QID))_$P(YSDATA(I),U,3)
 . S QSTN(QID)=$P($G(^YTT(601.75,CID,0)),U,2)
 Q
REPORT(SCORES,QANDA) ; build the scoring display for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 N BLANKS,QSTN
 D BLDQSTN(.QSTN)
 S $P(BLANKS," ",81)=""
 S SCORES=$$BLDSCR()
 S QANDA=$$BLDQA()
 Q
BLDSCR() ; build the scoring block
 ; expects ^TMP($J,"YSCOR") from DLLSTR
 N I,NAME,VALUE,SYMNOW,SYMPRE,DISNOW,DISPRE,OTHSYM,ALLNOW,ALLPRE,X
 S I=0 F  S I=$O(^TMP($J,"YSCOR",I)) Q:'I  D
 . S NAME=$P(^TMP($J,"YSCOR",I),"=")
 . S VALUE=$P(^TMP($J,"YSCOR",I),"=",2)
 . I NAME="Symptom Severity Now" S SYMNOW=VALUE
 . I NAME="Symptom Severity Pre-COVID" S SYMPRE=VALUE
 . I NAME="Functional Disability Now" S DISNOW=VALUE
 . I NAME="Functional Disability Pre-COVID" S DISPRE=VALUE
 . I NAME="Additional Symptoms" S OTHSYM=VALUE
 . I NAME="Overall Health Now" S ALLNOW=VALUE
 . I NAME="Overall Health Pre-COVID" S ALLPRE=VALUE
 S X=""
 S X=X_"|                         Now  Pre-COVID"
 S X=X_"|                         ---  ---------"
 S X=X_"|      Symptom Severity:"_$$SCRTXT(SYMNOW,SYMPRE)
 S X=X_"| Functional Disability:"_$$SCRTXT(DISNOW,DISPRE)
 S X=X_"|   Additional Symptoms:"_$$SCRTXT(OTHSYM,"")
 S X=X_"|        Overall Health:"_$$SCRTXT(ALLNOW,ALLPRE)
 Q X
 ;
SCRTXT(NOW,PRE) ; return score string
 Q "  "_$J(NOW,3)_"    "_$J(PRE,3)
 ;
BLDQA() ; Build questions & answers
 ; expects QSTN, BLANKS from REPORT
 N I,TEXT,X,XC,WTEXT,WINDENT,WNOW,WPRE
 S WTEXT=56,WINDENT=8
 S WNOW=$L("Moderate")+2
 S WPRE=$L("Don't Know")
 S TEXT="" F I=1:1 S X=$P($T(RPTQA+I),";;",2,99) Q:X="zzzzz"  D
 . ; handle text, wp and checklists first
 . I X=9045 D  QUIT                              ; text
 . . S TEXT=TEXT_"|18a)  Occupation: "_$G(QSTN(+X))
 . I X=9041!(X=9046) D  QUIT                     ; checklist
 . . I '$L($G(QSTN(+X))) S TEXT=TEXT_"|" QUIT
 . . N CLST,J
 . . D BLDCHKS(.CLST,X)                          ; all checkbox items
 . . S J=0 F  S J=$O(CLST(J)) Q:'J  I QSTN(+X)[CLST(J) D
 . . . S TEXT=TEXT_$$WRAP(CLST(J),76,$E(BLANKS,1,WINDENT))
 . I X=9042!(X=9047)!(X=9048) D  QUIT            ; wp text
 . . I '$L($G(QSTN(+X))) S TEXT=TEXT_"|" QUIT
 . . S TEXT=TEXT_$$WRAP(QSTN(+X),76,$E(BLANKS,1,WINDENT))
 . ; handle question / answer text               ; now/pre responses
 . S NOW=$P(X,U,2),PRE=$P(X,U,3)
 . I NOW="",(PRE="") S TEXT=TEXT_"|"_$P(X,U) I 1
 . E  S TEXT=TEXT_"|"_$E($P(X,U)_BLANKS,1,WTEXT)
 . I $L(NOW) S TEXT=TEXT_$E($$ANSTXT(NOW)_BLANKS,1,WNOW)
 . I $L(PRE) S TEXT=TEXT_$$ANSTXT(PRE)
 Q TEXT
 ;
ANSTXT(QID) ; return text for answer to question
 ; expects QSTN from REPORT > BLDQA
 I QID'=+QID Q QID                      ; non-numeric, just return text
 I QID=9043 Q $J($G(QSTN(QID)),2)       ; actual value (range question)
 I QID=9044 Q "   "_$J($G(QSTN(QID)),2)
 I '$D(QSTN(QID)) Q "SKIPPED"
 I $G(QSTN(QID))=0 Q "None"
 I $G(QSTN(QID))=1 Q "Mild"
 I $G(QSTN(QID))=2 Q "Moderate"
 I $G(QSTN(QID))=3 Q "Severe"
 I $G(QSTN(QID))=4 Q "Don't Know"
 Q "??"
 ;
WRAP(IN,MAX,PRE) ; Return with | and spacing in correct place
 N I,J,L,OUT,PAR,TXT,WORD
 S OUT="",TXT="",L=0
 F I=1:1:$L(IN,"|") S PAR=$P(IN,"|",I) D
 . S L=L+1,OUT(L)=PRE_$P(PAR," ")
 . F J=2:1:$L(PAR," ") S WORD=$P(PAR," ",J) D
 . . I ($L(OUT(L))+$L(WORD)+1)<MAX S OUT(L)=OUT(L)_" "_WORD I 1
 . . E  S L=L+1,OUT(L)=PRE_WORD
 S L=0 F  S L=$O(OUT(L)) Q:'L  S TXT=TXT_"|"_OUT(L)
 Q TXT
 ;
RPTQA ; Questions & Answers for Report
 ;;Questions and Answers:
 ;;
 ;;SYMPTOM SEVERITY^Now^Pre-COVID
 ;;  ^---^---------
 ;;Breathlessness
 ;;1a)  Breathlessness: At rest^8979^8980
 ;;1b)  Breathlessness: Changing position e.g. from^8981^8982
 ;;     lying to sitting or sitting to lying
 ;;1c)  Breathlessness: On dressing yourself^8983^8984
 ;;1d)  Breathlessness: On walking up a flight of stairs^8985^8986
 ;;
 ;;Cough/ throat sensitivity/ voice change
 ;;2a)  Cough / throat sensitivity^8987^8988
 ;;2b)  Change of voice^8989^8990
 ;;
 ;;Fatigue (tiredness not improved by rest)
 ;;3)   Fatigue levels in your usual activities^8991^8992
 ;;
 ;;Smell / taste
 ;;4a)  Altered smell^8993^8994
 ;;4b)  Altered taste^8995^8996
 ;;
 ;;Pain / discomfort
 ;;5a)  Chest pain^8997^8998
 ;;5b)  Joint pain^8999^9000
 ;;5c)  Muscle pain^9001^9002
 ;;5d)  Headache^9003^9004
 ;;5e)  Abdominal pain^9005^9006
 ;;
 ;;Cognition
 ;;6a)  Problems with concentration^9007^9008
 ;;6b)  Problems with memory^9009^9010
 ;;6c)  Problems with planning^9011^9012
 ;;
 ;;Palpitations / dizziness
 ;;7a)  Palpitations in certain positions, activity or^9013^9014
 ;;     at rest
 ;;7b)  Dizziness in certain positions, activity or at^9015^9016
 ;;     rest
 ;;
 ;;Post-exertional malaise (worsening of symptoms)
 ;; 8)  Crashing or relapse hours or days after physical,^9017^9018
 ;;     cognitive or emotional exertion
 ;;
 ;;Anxiety / mood
 ;;9a)  Feeling anxious^9019^9020
 ;;9b)  Feeling depressed^9021^9022
 ;;9c)  Having unwanted memories of your illness or^9023^9024
 ;;     time in hospital
 ;;9d)  Having unpleasant dreams about your illness or^9025^9026
 ;;     time in hospital
 ;;9e)  Trying to avoid thoughts or feelings about your^9027^9028
 ;;     illness or time in hospital
 ;;
 ;;Sleep
 ;;10)  Sleep problems, such as difficulty falling^9029^9030
 ;;     asleep, staying asleep or oversleeping
 ;;
 ;;
 ;;FUNCTIONAL ABILITY
 ;;
 ;;Communication
 ;;11)  Difficulty with communication / word finding^9031^9032
 ;;     difficulty / understanding others
 ;;
 ;;
 ;;Walking or moving around
 ;;12)  Difficulties with walking or moving around^9033^9034
 ;;
 ;;Personal Care
 ;;13)  Difficulties with personal tasks such as using^9035^9036
 ;;     the toilet or getting washed and dressed
 ;;
 ;;Other activities of Daily Living^9037^9038
 ;;14)  Difficulty doing wider activities, such as
 ;;     household work, leisure/sporting activities,
 ;;     paid/unpaid work, study or shopping
 ;;
 ;;Social Role
 ;;15)  Problems with socializing / interacting with^9039^9040
 ;;     friends* or caring for dependents
 ;;     *related to your illness and not due to social
 ;;     distancing / lockdown measures
 ;;    
 ;;
 ;;OTHER SYMPTOMS
 ;;
 ;;16a)  Please select any of the following symptoms you have experienced 
 ;;      since your illness in the last 7 days. Please also select any 
 ;;      previous problems that have worsened for you following your illness.
 ;;9041
 ;;16b)  Other symptoms - free text
 ;;9042
 ;;
 ;;
 ;;OVERALL HEALTH^Now^Pre-COVID
 ;;  ^---^---------
 ;;17a)  How good or bad is your health overall in the^9043^9044
 ;;      last 7 days?
 ;;
 ;;
 ;;EMPLOYMENT
 ;;
 ;;9045
 ;;18b)  Has your COVID-19 illness affected your work??
 ;;9046
 ;;18c)  Any other comments/concerns
 ;;9047
 ;;
 ;;
 ;;PARTNER / FAMILY / CAREGIVER PERSPECTIVE
 ;;
 ;;19)   This is space for your partner, family or caregiver to add anything
 ;;      from their perspective:
 ;;9048
 ;;zzzzz
 ;
TESTSCR(YSAD) ; Test scoring routine
 N YS,YSDATA
 S YS("AD")=YSAD,YS("CODE")="C19-YRS"
 D LOADANSW^YTSCORE(.YSDATA,.YS)
 D SCALEG^YTQAPI3(.YSDATA,.YS)
 D DLLSTR(.YSDATA,.YS,1)
 Q
