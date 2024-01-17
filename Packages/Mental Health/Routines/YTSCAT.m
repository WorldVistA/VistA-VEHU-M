YTSCAT ;SLC/KCM - CAT Scoring and Reporting ; 6/30/2021
 ;;5.01;MENTAL HEALTH;**182,199,202,217,221,234**;DEC 30,1994;Build 38
 ;
DLLSTR(YSDATA,YS,YSMODE) ; main tag for both scores and report text
 Q
SCORE(YSDATA) Q ; iterate through answers and calculate score
REPORT(YSDATA,YS) ; add textual scores to report
 Q
QA4TEST(ITEST) ; add Questions & Answers for 1 Test
 Q
QA4QID(QID) ; return question & response text from answers
 N ANS,QATXT
 S QATXT=""
 Q QATXT
 ;
TM4TEST(SEQ) ; return a block of text with the completion time
 Q
QA4ALL ; add Questions & Answers for all tests together
 Q
TM4ALL ; add elapsed time for all questions
 Q
ADDSCORE(SEQ,WHICH) ; return a block of text with the appropriate scores
 Q
ADDPTSD ; add interpretive text for CAD-PTSD-DX
 Q
ADDLN(TXT) ; add a line of text
 Q
FULLNAME(TTYP) ; return full name for a CAT Test Type
 Q "Unknown Test"
 ;
INSNAME(TTYP) ; return full name for a CAT Test Type
 Q "Unknown Test"
 ;
PAD(LEN,STR) ; return spaces until X is LEN
 N X S X="                                        "
 Q STR_$E(X,1,LEN-$L(STR))
 ;
TMSTR(ATIME) ; return a readable elapsed time
 N MIN,SEC,X
 S X=""
 Q X
 ;
WP2JSON(YSDATA,TREE) ; put YSDATA answer into M-subscript format
 Q
WRAP(IN,MAX,PRE) ; Return with | and spacing in correct place
 Q ""
 ;
TXTPTSD ; Interpretive text for CAD-PTSD-DX
 ;;zzzzz
 Q
