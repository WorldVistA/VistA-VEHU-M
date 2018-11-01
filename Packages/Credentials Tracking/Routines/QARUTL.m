QARUTL ;HISC/DAD-QAR UTILITIES ;7/20/98  12:43
 ;;2.0;Credentials Tracking;**1,13**;May 04, 1993
 ;
ENNAME ; *** CONVERT 'LAST,FIRST' ==> 'First Last'
 ;REQUIRES & RETURNS
 ; X = TEXT OF NAME
 ;
 S QA2=$P(X,",",2)_" "_$P(X,",") G CNV
 ;
ENTEXT ; *** CONVERT 'TEXT' ==> 'Text'
 ;REQUIRES & RETURNS
 ; X = TEXT STRING
 ;
 S QA2=X
 ;
CNV S QA2=" "_QA2,X=""
 F QA=2:1:$L(QA2) S QA0=$E(QA2,QA-1),QA1=$E(QA2,QA),X=X_$S((QA1?1U)&((QA0'=" ")&(QA0'="-")):$C($A(QA1)+32),1:QA1)
 K QA,QA0,QA1,QA2 Q
