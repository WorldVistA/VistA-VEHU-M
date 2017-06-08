MAGDLB3 ;WIRMFO  LB/1/97 Radiology case # lookup cont. [ 10/06/1999   1:51 PM ]
 ;;2.5T;DICOM41F;;6-October-1999
 ;;
 ;; ********************************************************************
 ;; ********************************************************************
 ;; **  Property of the US Government.  No permission to copy or      **
 ;; **  redistribute this software is given. Use of this software     **
 ;; **  requires the user to execute a written test agreement with    **
 ;; **  the VistA Imaging Development Office of the Department of     **
 ;; **  Veterans Affairs, telephone (301) 734-0100.                   **
 ;; **                                                                **
 ;; **  The Food and Drug Administration classifies this software as  **
 ;; **  a medical device.  As such, it may not be changed in any way. **
 ;; **  Modifications of the software may result in an adulterated    **
 ;; **  medical device under 21CFR820 and may be a violation of US    **
 ;; **  Federal Statutes.                                             **
 ;; ********************************************************************
 ;; ********************************************************************
 ;;
ASK ;Prompt for range of entries, parse response
 ;INPUT VARIABLES:     ;ch
 ; MAGF1: If defined, a list or range of numbers are permitted i.e,
 ;       1,2,3-8.  If not defined, only single number input is permitted.
 ; MAGCNT=highest possible number in range
 ; ^TMP($J,"MAGEX",n)=array of acceptable numeric responses
 ;OUTPUT VARIABLES:
 ;  MAGDUP(n)=array of all selected numeric responses
 K MAGDUP S (MAGERR,MAGI)=0
 W !,"Type '^' to STOP, or",!,"CHOOSE FROM 1-",MAGCNT,": "
 R X:600 S:'$T!(X["^") X="^" Q:X="^"!(X="")
 I X["?",$D(MAGF1) D  G ASK
 . W !!?3,"Please enter a number or a range of numbers separated by a"
 . W " dash,",!?3,"or two or more numbers separated by a combination of"
 . W " commas and dashes.",!
 I X["?",'$D(MAGF1) D  G ASK
 . W !!?3,"Enter the number corresponding to the exam you wish to select.",!
 I X'?.N,'$D(MAGF1) D  G ASK
 . W !!?3,"Enter the number of the exam you wish to select."
 . W !?3,"A list or range of numbers will not be accepted.",!
 I '$D(MAGF1),'$D(^TMP($J,"MAGEX",+X)) D  G ASK
 . W !!?3,*7,"Item ",+X," is not a valid selection.",!
 I '$D(MAGF1) S X=+X,Y=^TMP($J,"MAGEX",+X) Q
PARSE S MAGI=MAGI+1,MAGPAR=$P(X,",",MAGI)
 G EX:MAGPAR=""
 I MAGPAR?.N1"-".N S MAGDASH="" F MAGSEL=$P(MAGPAR,"-"):1:$P(MAGPAR,"-",2) D CHK G ASK:MAGERR
 I '$D(MAGDASH) S MAGSEL=MAGPAR D CHK
 K MAGDASH G ASK:MAGERR,PARSE
 ;
CHK I $D(MAGDASH),+$P(MAGPAR,"-",2)<+$P(MAGPAR,"-") D  Q
 . S MAGERR=1 W !?3,*7,"Invalid range of numbers specified."
 I MAGSEL'?.N!(MAGSEL'=+MAGSEL)!(MAGSEL?16.N.E) D  Q
 . W !?3,$C(7),"Item ",MAGSEL," is not a valid selection.",!
 . S MAGERR=1
 . Q
 I '$D(^TMP($J,"MAGEX",MAGSEL)) D  Q
 . W !?3,*7,"Item ",MAGSEL," is not a valid selection.",! S MAGERR=1
 I $D(MAGDUP(MAGSEL)) D  Q
 . W !?3,*7,"Item ",MAGSEL," was already selected.",! S MAGERR=1
 S MAGDUP(MAGSEL)="" Q
EX S X="" I 'MAGERR,$D(MAGDUP) S X=1
 Q
