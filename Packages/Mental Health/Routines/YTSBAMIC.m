YTSBAMIC ;SLC/KCM - Verify for BAM-IOP-CSG-SUD ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**234**;DEC 30,1994;Build 38
 ;
 Q
 ;
VERIFY(ARGS,RESULTS) ; Add inconsistency messages based on set of answers in ARGS
 N MSGCNT S MSGCNT=0
 I $$LT("q9136","q9137") D MSG("more","4","5A")
 I $$LT("q9138","q9139") D MSG("less","7A","6")
 I $$LT("q9138","q9140") D MSG("less","7B","6")
 I $$LT("q9138","q9141") D MSG("less","7C","6")
 I $$LT("q9138","q9142") D MSG("less","7D","6")
 I $$LT("q9138","q9143") D MSG("less","7E","6")
 I $$LT("q9138","q9144") D MSG("less","7F","6")
 I $$LT("q9138","q9145") D MSG("less","7G","6")
 I $$GTI("q9156","q9157") D MSG("more","5C","5B")
 S RESULTS("count")=MSGCNT
 Q
LT(ID1,ID2) ; returns 1 if ID1 is less than ID2
 ; expects ARGS from VERIFY
 N VAL1,VAL2
 S VAL1=$E($G(ARGS(ID1)),2,9) S:VAL1=1156 VAL1=0  ; 1156 = skipped by rule
 I VAL1 S VAL1=+$P($G(^YTT(601.75,VAL1,0)),U,2)   ; legacy value for compare
 S VAL2=$E($G(ARGS(ID2)),2,9) S:VAL2=1156 VAL2=0
 I VAL2 S VAL2=+$P($G(^YTT(601.75,VAL2,0)),U,2)
 I +VAL1<+VAL2 Q 1
 Q 0
 ;
GTI(ID1,ID2) ; returns 1 if ID1 is more than ID2 (integer question)
 ; expects ARGS from VERIFY
 N VAL1,VAL2
 S VAL1=$G(ARGS(ID1)) S:VAL1="c1156" VAL1=0  ; 1156 = skipped by rule
 S VAL2=$G(ARGS(ID2)) S:VAL2="c1156" VAL2=0
 I +VAL1>+VAL2 Q 1
 Q 0
 ;
MSG(REL,Q1,Q2) ; Add text of message to RESULTS
 ; expects MSGCNT, RESULTS from VERIFY
 N X,NOUN
 S NOUN=$S(Q1="5C":"drinks",1:"days")
 S X="There is an inconsistency:  The number of "
 S X=X_NOUN_" entered in Question "_Q1
 S X=X_" should be equal to, or "_REL_" than,"
 S X=X_" the number of "_NOUN_" in Question "_Q2_"."
 S MSGCNT=MSGCNT+1,RESULTS("messages",MSGCNT)=X
 Q
