ZVHZSDM ;SLC/DAN Stuff appointments for patients ;1/8/08  16:11 [12/27/09 5:14pm]
 ;v1.0 Vehu-ware;;;;;Build 1
 N SDATE,LIST,CLIN,EDATE
 W !,"This routine will automatically make clinic visits for selected",!,"patients for selected dates.  All appointments are for 15 minutes.",!!,"All appointments will be for 8 am on the date selected.",!
 S SDATE=$$DATE(1) Q:'+SDATE  ;get starting date range for appointments
 S EDATE=$$DATE(2) Q:'+EDATE  ;get ending date range for appointments
 S CLIN=$$CLIN Q:'+CLIN  ;get clinic for appointments
 D PATS(.LIST) Q:'$O(LIST(0))  ;get list of patients
 D ASSIGN ;make appointments
 Q
 ;
DATE(TYPE) ;Ask the user for a date
 N DIR,Y,DTOUT,DUOUT,APDATE,X
 S DIR(0)="DA^"_$S($G(SDATE):SDATE,1:DT)_":9999999:EX"
 S DIR("A")="Enter "_$S(TYPE=1:"starting",1:"ending")_" date for clinic visits: "
 S DIR("?")="Enter the date (no time) to be used to auto-assign clinic visits.  "_$S(TYPE=1:"Start date must be today or a future date.",1:"Ending date must be equal to or greater than "_$$FMTE^XLFDT(SDATE)_".")
 I TYPE=2 S DIR("B")=$$FMTE^XLFDT(SDATE)
 D ^DIR S:+Y>0 APDATE=+Y K DIR I $D(DTOUT)!$D(DUOUT) S APDATE=0
 Q APDATE
 ;
CLIN() ;Get clinic to put appointments into
 N DIC,X,Y,DTOUT,DUOUT
 S DIC="^SC(",DIC(0)="AEMZQ",DIC("A")="Select CLINIC: ",DIC("S")="I $P(^(0),U,3)=""C"",'$G(^(""OOS""))" D ^DIC K DIC
 I Y<0 S Y=0
 Q +Y
 ;
PATS(LIST) ;Select patients to assign visits to
 N DIR,X,Y,DUOUT,DTOUT,J
 W !!,"Select patients to assign clinic visits to.  Select numbers between",!,"0 and 950 with the number corresponding to the VeHU patient that you want to",!,"update.  For example, choosing number 12 will update VeHU patient twelve",!!
 S DIR("A")="Select patient(s) to be updated"
 S DIR(0)="LO^0:950" D ^DIR K DIR Q:Y=""!($D(DUOUT))!($D(DTOUT))
 D PARSE(Y,.LIST) S J=0 F  S J=$O(Y(J)) Q:'+J  D PARSE(Y(J),.LIST)
 Q
 ;
ASSIGN ;Assign clinic visit for patients
 N IEN,DATE
 F DATE=SDATE:0 D  S DATE=$$FMADD^XLFDT(DATE,1) Q:DATE>EDATE
 .W !,"Making appointments for ",$$FMTE^XLFDT(DATE),"..."
 .S IEN=0 F  S IEN=$O(LIST(IEN)) Q:'+IEN  D MKAPPT
 W !,"Done!"
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
MKAPPT ;Make appointment for patient on date selected for clinic selected
 N COLLAT,SDY,COV,SDYC,ADATE
 S ADATE=DATE_.08
 S ^DPT(IEN,"S",ADATE,0)=CLIN,^SC(CLIN,"S",ADATE,0)=ADATE S:'$D(^DPT(IEN,"S",0)) ^(0)="^2.98P^^" S:'$D(^SC(CLIN,"S",0)) ^(0)="^44.001DA^^"
S1 F SDY=1:1 I '$D(^SC(CLIN,"S",ADATE,1,SDY)) S:'$D(^(0)) ^(0)="^44.003PA^^" S ^(SDY,0)=IEN_U_15 Q
 S COLLAT=0,COV=3,SDYC="",COV=$S(COLLAT=1:1,1:3),SDYC=$S(COLLAT=7:1,1:"")
 S:ADATE<DT SDSRTY="W"
 S ^DPT(IEN,"S",ADATE,0)=CLIN_"^"_""_"^^^^^"_COV_"^^^^"_SDYC_"^^^^^"_9_U_$G(SD17)_"^^"_DT_"^^^^^"_$G(SDXSCAT)_U_$P($G(SDSRTY),U,2)_U_$$NAVA^SDMANA(CLIN,ADATE,$P($G(SDSRTY),U,2))
 S ^DPT(IEN,"S",ADATE,1)=$G(ADATE)_U_$G(SDSRFU)
 ;xref DATE APPT. MADE field
 D
 .N DIV,DA,DIK
 .S DA=ADATE,DA(1)=IEN,DIK="^DPT(DA(1),""S"",",DIK(1)=20 D EN1^DIK
 .Q
 Q
