MAGDLB2 ;LB/WIRMFO  1/97 Routine to look Radiology case # [ 10/06/1999   1:51 PM ]
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
CASE S U="^"
 N DIC,ENTRY,FLD,I,JJ,MAGCN,MAGCNI,MAGCNT,MAGDATE,MAGDFN,MAGDIV,MAGDTCN
 N MAGELOG,MAGDTE,MAGDTI,MAGEND,MAGFL,MAGFST,MAGHEAD,MAGI,MAGIMAGE,MAGIX
 N MAGNME,MAGPIEN,MAGNODE,MAGPRC,MAGRPT,MAGSEND,MAGSN,MAGSSN
 N MAGST,MAGVW,MAGXHOLD,NUM,XJ,XX,XXX,ZZ,X,Y
 R !!,"Enter Case Number: ",X:600 S:'$T!(X="") X="^"  G Q:X="^"
 I X?1A D  G CASE
 . W !?3,*7,"You must enter more than one character of the name!"
 I X?1A.AP!(X?1A4N)!(X?9N) D  G CASE:'Y S MAGDFN=+Y G ^MAGDLB4
 . S MAGHEAD="**** Case Lookup by Patient ****",DIC(0)="EMQ"
 . D PAT
 I X?16.N.E D QUES G CASE
 G Q:X="^" D QUES:'X&(X'="??")
 G CASE:X="^" D SEL G CASE:"^"[X!('MAGCNT)
 S MAGDFN=$P(Y,"^"),MAGDTI=$P(Y,"^",2),MAGCNI=$P(Y,"^",3)
 S MAGNME=$P(Y,"^",4),MAGSSN=$P(Y,"^",5),MAGCN=$P(Y,"^",13)
 S MAGPRC=$P(Y,"^",9),MAGPIEN=$P(Y,"^",12)
 I MAGCNT'=1 D
 . W !!?1,"Case No.: ",MAGCN,?16,"Procedure: ",$E(MAGPRC,1,30)
 . W ?58,"Name: ",$E(MAGNME,1,20)
 I $D(^RADPT(MAGDFN,"DT",MAGDTI,"P",MAGCNI,0)) D
 . S MAGDY(0)=^RADPT(MAGDFN,"DT",MAGDTI,"P",MAGCNI,0)
 S MAGDY=MAGDFN_"^"_MAGNME_"^"_MAGSSN_"^"_MAGCN_"^"_MAGPRC
 S MAGDY=MAGDY_"^"_MAGDTI_"^"_MAGCNI_"^"_MAGPIEN
Q K ^TMP($J,"MAGEX") Q
 ;
SEL K ^TMP($J,"MAGEX") S MAGCNT=0 G ADC:X["-"
 S MAGFST=$S(X:X-.01,1:0),MAGEND=$S(X:X+.9,1:99999),MAGCN=X,X=""
 S MAGIX=$S($O(^RADPT("C","")):"C",1:"AE")  ;;3/31/99 RA*5*7 patch
 I '$D(^RADPT(MAGIX,MAGCN)) W !,"Short case number not found." Q
 S MAGDFN=0
 F  S MAGDFN=$O(^RADPT(MAGIX,MAGCN,MAGDFN)) Q:'MAGDFN  D  D PRT Q:X="^"!(X>0)
 . S MAGDTI=$O(^RADPT(MAGIX,MAGCN,MAGDFN,0)),MAGCNI=$O(^(MAGDTI,0)) S X=""
 G CHK
ADC S MAGIX="ADC",MAGCN=$P(X,"-",2),MAGDTCN=X,X=""
 F MAGDFN=0:0 S MAGDFN=$O(^RADPT(MAGIX,MAGDTCN,MAGDFN)) Q:MAGDFN'>0  D  D PRT Q:X="^"!(X>0)
 . S MAGDTI=$O(^(MAGDFN,0)),MAGCNI=$O(^(MAGDTI,0)) S X=""
CHK Q:X="^"!(X>0)  I 'MAGCNT W !?3,*7,"No matches found!" Q
 I MAGCNT=1 S X=1,Y=^TMP($J,"MAGEX",1) Q
CHK1 Q:'(MAGCNT#15)  W !,"CHOOSE FROM 1-",MAGCNT,": " R X:600
 S:'$T!(X="") X="^" Q:X="^"  I X["?" D HLP G CHK1
 I '$D(^TMP($J,"MAGEX",+X)) S X="^" W *7," ??" Q
 S Y=^TMP($J,"MAGEX",+X) Q
PRT S MAGFL=0 Q:'$D(^RADPT(MAGDFN,0))!('$D(^DPT(MAGDFN,0)))
 S MAGNME=^(0),MAGSSN=$P(MAGNME,"^",9),MAGNME=$P(MAGNME,"^")
 Q:'$D(^RADPT(MAGDFN,"DT",MAGDTI,0))
 I $D(^RADPT(MAGDFN,"DT",MAGDTI,0)) D  Q:'MAGFL
 . S MAGNODE=$G(^RADPT(MAGDFN,"DT",MAGDTI,0))
 . S MAGDIV=+$P(MAGNODE,"^",3),MAGIMAGE=+$P(MAGNODE,"^",2)
 . S MAGDIV=+$G(^RA(79,MAGDIV,0)),MAGDIV=$P($G(^DIC(4,MAGDIV,0)),"^")
 . S:MAGDIV']"" MAGDIV="Unknown"
 . S MAGIMAGE=$P($G(^RA(79.2,MAGIMAGE,0)),"^")
 . S:MAGIMAGE']"" MAGIMAGE="Unknown"
 . S (Y,MAGDTE)=+$P(MAGNODE,"^") D DT S MAGDATE=Y
 . I $D(^RADPT(MAGDFN,"DT",MAGDTI,"P",MAGCNI,0)) S MAGFL=1,Y=^(0)
 . Q
 S MAGPIEN=$P(Y,"^",2),MAGST=+$P(Y,"^",3),MAGRPT=+$P(Y,"^",17)
 S MAGCSE=$S('MAGRPT:+MAGCN,1:$P(^RARPT(+MAGRPT,0),"^"))
 S MAGPRC=$S($D(^RAMIS(71,+$P(Y,"^",2),0)):$P(^(0),"^"),1:"Unknown")
 S MAGCNT=MAGCNT+1
 S ^TMP($J,"MAGEX",MAGCNT)=MAGDFN_"^"_MAGDTI_"^"_MAGCNI_"^"_MAGNME_"^"_MAGSSN_"^"_MAGDATE_"^"_MAGDTE_"^"_MAGCN_"^"_MAGPRC_"^"_MAGRPT_"^"_MAGST_"^"_MAGPIEN_"^"_MAGCSE
 I MAGCNT=1,$S('$D(MAGEND):1,MAGEND<99999:1,1:0),$D(MAGVW),$O(^RADPT(MAGIX,$S(MAGIX="ADC":MAGDTCN,1:MAGCN),MAGDFN))'>0 S X=1,Y=^TMP($J,"MAGEX",1) Q
 D HD:MAGCNT=1
 W !?2,MAGCNT,?10,MAGCN
 W:$O(^RARPT(MAGRPT,2005,0)) ?18,"i" W ?20,$E(MAGPRC,1,30)
 W ?52,$E(MAGNME,1,20),?71,$G(MAGSSN) Q:MAGCNT#15
PRT1 W !,"Type '^' to STOP, or",!,"CHOOSE FROM 1-",MAGCNT,": "
 R X:600 S:'$T X="^" Q:X="^"!(X="")  I X["?" D HLP G PRT1
 I '$D(^TMP($J,"MAGEX",+X)) W *7," ??" S X="^" Q
 S X=+X,Y=^TMP($J,"MAGEX",X) Q
 ;
HD W !!,"Choice",?8,"Case No.",?20,"Procedure",?52,"Name",?71,"Pt ID"
 W !,"------",?8,"--------",?20,"---------",?52,"-----------------",?71,"------" Q
 ;
QUES W !,"Enter an active case number in the following form '999'..."
 W !?10,"...or enter a completed case number as 'MMDDYY-999'"
 W !?10,"...or enter a patient's name"
 W !?10,"...or enter a patient's 9-digit SSN"
 W !?10,"...or enter the first character of the patient's"
 W !?13,"last name and the last four digits of their SSN."
ASKACT R !!,"Do you wish to see the entire list of active cases? NO// ",X:600
 S X=$E(X) S:'$T!("Nn"[X) X="^"
 I "Yy"'[X,X'="^" D  G ASKACT
 . W:X'="?" *7
 . W !!?3,"Enter 'YES' to list all active cases, or 'NO' not to."
 S:"Yy"[X X="??" Q
HLP W !!?3,"Enter the number corresponding to the exam you wish to select.",! Q
PAT ;
 N DIR,DIRUT,DTOUT,DUOUT S Y=-1
 S DIR(0)="P^70:QEMZ",DIR("B")=X D ^DIR
 I $D(DIRUT)!($D(DTOUT))!($D(DUOUT)) S Y=-1 Q
 I 'Y,'$D(^RADPT(+Y,0)) S Y=-1
 Q
 ;
DT S Y=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",$E(Y,4,5))
 S Y=Y_"  "_$S(Y#100:$J(Y#100\1,2)_",",1:"")_(Y\10000+1700)
 S Y=Y_$S(Y#1:"  "_$E(Y_0,9,10)_" "_$E(Y_"000",11,12),1:"") Q
