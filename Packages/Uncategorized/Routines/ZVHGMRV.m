ZVHGMRV ;SLC/DAN Auto-populate database with vitals ;6/28/06  15:31 [9/19/09 1:42pm]
 ;
 W !,"This routine will assign vital measurements to a range of patients across",!,"a range of dates.  You can select the values or they will be randomly",!,"generated.",!
SDATE ;sets DIR call to ask the user for a starting date
 N DIR,SDATE,EDATE,SD1,SD2,Y,X,DTOUT,DUOUT,NUMDAYS,LONER,LOC,J,VALUE,ATIME
 S DIR(0)="DA^::EX"
 S DIR("A")="Enter a starting date: "
 S DIR("?")="Enter the starting date to be used to auto-assign vitals."
 D ^DIR S:+Y>0 (SDATE,SD1)=+Y K DIR I $D(DTOUT)!$D(DUOUT) Q
EDATE ;sets DIR call to ask the user for an ending date (optional)
 S DIR(0)="DA^::EX"
 S DIR("A")="Enter an ending date: "
 S DIR("?")="Enter the last date to assign vitals for."
 D ^DIR S (EDATE,SD2)=+Y K DIR I $D(DTOUT)!$D(DUOUT) Q
SWITCH ;takes the date input from the user and does a switcheroo so the program
 ;can work as intended
 I EDATE'>SDATE S EDATE=SD1,SDATE=SD2
 S NUMDAYS=$$FMDIFF^XLFDT(EDATE,SDATE,1)+1
 S DIR(0)="FO^4:4^K:+X<1!(+X>2400) X"
 S DIR("A")="Enter 4 digit military time (0001-2400) or return for a random time"
 S DIR("?")="Enter 4 digit military time, no punctuation.  Use 2400 for midnight.",DIR("?",1)="Enter a time to be assigned to each date in the range or enter blank",DIR("?",2)="to have a time randomly assigned."
 D ^DIR K DIR Q:$D(DTOUT)!($D(DUOUT))
 I Y'="" S ATIME=Y
 ;
 W !!,"Select patients to assign vitals results to.  Select numbers between",!,"0 and 605 with the number corresponding to the VeHU patient that you want to",!,"update.  For example, choosing number 12 will update twelve,patient.",!!
 S DIR("A")="Select patient(s) to be updated"
 S DIR(0)="LO^0:605" D ^DIR K DIR Q:Y=""!($D(DUOUT))!($D(DTOUT))
 D PARSE(Y,.LONER) S J=0 F  S J=$O(Y(J)) Q:'+J  D PARSE(Y(J),.LONER)
 ;
LOC ;Get location to associate with vitals
 W ! S DIR(0)="PO^44:AEQM",DIR("A")="Select hospital location to associate with vital entry",DIR("B")="GENERAL MEDICINE"
 D ^DIR
 S:+Y>0 LOC=+Y K DIR I Y=""!($D(DTOUT))!($D(DUOUT)) Q
 W !,"The following vitals may be added for each patient and each day:",!,"temperature, respirations, pulse, blood pressure, height, weight, pulse ox",!,"and pain.",!!
 W "Select the method for assigning values.",!
 S DIR(0)="SO^R:Randomly assigned;U:User assigned" D ^DIR K DIR Q:Y=""!($D(DTOUT))!($D(DUOUT))  D:Y="U" GETVAL(.VALUE) W !,"Assigning values",!
 S IEN=0 F  S IEN=$O(LONER(IEN)) Q:'+IEN  D DATE  W "."
 Q
 ;
DATE ;Traverse dates selected
 N DATE,HOUR,MIN,TIME,HGT,WGT
 S:$G(VALUE(8))="" HGT=$S($P($G(^GMR(120.5,+$O(^PXRMINDX(120.5,"PI",IEN,8,+$O(^PXRMINDX(120.5,"PI",IEN,8,""),-1),0)),0)),U,8):$P(^(0),U,8),1:(60+$R(18)))
 S:$G(VALUE(9))="" WGT=$S($P($G(^GMR(120.5,+$O(^PXRMINDX(120.5,"PI",IEN,9,+$O(^PXRMINDX(120.5,"PI",IEN,9,""),-1),0)),0)),U,8):$P(^(0),U,8),1:(110+$R(150)))
 S DATE=$$FMADD^XLFDT(SDATE,-1) F NUM=1:1:NUMDAYS S DATE=$$FMADD^XLFDT(DATE,1) Q:DATE>EDATE  D
 .S HOUR=$R(24) S:HOUR<10 HOUR=0_HOUR
 .S MIN=$R(60) S:MIN<10 MIN=0_MIN
 .S TIME=$S($D(ATIME):ATIME,1:(HOUR_MIN))
 .D VITALS
 Q
 ;
VITALS ;Add vitals for patient
 N DATA,VIT,READ,GORL,GMRVOK,LBS,DTE
 F VIT=1,2,3,5,8,9,21,22 D
 .I $G(VALUE(VIT))="N" Q  ;If no value should be added - stop
 .S READ="" I $G(VALUE(VIT))'="" S READ=VALUE(VIT)
 .I $G(READ)="" D
 ..S:VIT=1 READ=($R(80)+110)_"/"_($R(30)+55)
 ..S:VIT=2 READ=($R(2)+97)_"."_($R(9)+1)
 ..S:VIT=3 READ=$R(8)+12
 ..S:VIT=5 READ=$R(30)+65
 ..S:VIT=8 READ=HGT
 ..S:VIT=9 GORL=$R(2),LBS=$R(5),(READ,WGT)=WGT+($S(GORL=0:"-",1:"+")_LBS)
 ..S:VIT=21 READ=$R(9)+91
 ..S:VIT=22 READ=$R(3)
 .S DTE=(DATE_"."_TIME),DTE=+DTE
 .S DATA=DTE_U_IEN_U_VIT_";"_READ_U_LOC_U_$G(DUZ,.5)
 .D EN1^GMVDCSAV(.GMRVOK,DATA)
 Q
 ;
PARSE(ARRAY,LIST) ;
 N NUM,R,LNUM,L4,SSN
 S NUM=$L(ARRAY,",")-1
 F R=1:1:NUM S LNUM=$P(ARRAY,",",R) S L4=$S(LNUM=0:"0000",1:$E("000",1,(4-$L(LNUM)))_LNUM) D
 .S SSN="66600"_L4
 .I $D(^DPT("SSN",SSN)) S LIST($O(^DPT("SSN",SSN,0)))=""
 Q
 ;
GETVAL(VITAL) ;Get user values for vital measurements
 N VAL,VALUE
 W !!,"Enter value for the measurement or enter R to have the value randomly",!,"assigned.  Entries left blank will not have values assigned.  Height and",!,"weight will only be randomly assigned if no previous value exists.",!
 W !,"**NOTE: values are not validated, whatever you enter is what will get stored.",!
 F VAL="1;BP (Systolic/Diastolic)","2;TEMP (F)","3;RESP","5;PULSE","8;HEIGHT (inches)","9;WEIGHT (lbs)","21;PULSE OX","22;PAIN (0-10,99)" D
 .W !,$P(VAL,";",2)_": " R VALUE I VALUE'="",$S(+VAL=1:VALUE["/",1:+VALUE=VALUE) S VITAL(+VAL)=VALUE
 .I VALUE="" W "...not assigned" S VITAL(+VAL)="N" 
 .I $E($$UP^XLFSTR(VALUE),1)="R" W "...randomly assigned"  S VITAL(+VAL)=""
 Q
