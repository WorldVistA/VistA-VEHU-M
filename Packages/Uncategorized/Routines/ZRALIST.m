RALIST ;MJK/ALBANY ISC ;List all patients w/exams associated w/specific Amis
 ;VERSION 2.08 010/08/85
 D DATE^RAUTL Q:POP
 S DIC="^RAMIS(71.1,",DIC(0)="AEMQ" D ^DIC Q:Y<0  S RAMIS=+Y,RAMIS1=$P(Y,"^",2)
 S PGM="START^RALIST",VAR="BEGDATE^ENDDATE^RAMIS^RAMIS1"
 W !!,"NOTE: The statistics compiled for this report will be based only",!?6,"on exams that are in one of the following statuses:"
 F RASTAT=0:0 S RASTAT=$N(^RA(72,RASTAT)) Q:RASTAT'>0  I $D(^(RASTAT,0)),$D(^(.3)),$P(^(.3),"^",8)="y" W !?15,$P(^(0),"^",1)
 D ZIS^RAUTL Q:POP
START S Y=BEGDATE D D^RAUTL S BEG=Y,Y=ENDDATE D D^RAUTL S END=Y,%DT="TX",X="NOW" D ^%DT D D^RAUTL S RANOW=Y
 U IO S (PAGE,RACNT,RAIN,RAOUT)=0,BEGDATE=BEGDATE-.0001,ENDDATE=ENDDATE+.9999,RACRT=8 D HD,CRIT^RAUTL1
 F RADTE=BEGDATE:0:ENDDATE S RADTE=$N(^RADPT("AR",RADTE)) Q:RADTE'>0!(RADTE>ENDDATE)  F RADFN=0:0 S RADFN=$N(^RADPT("AR",RADTE,RADFN)) Q:RADFN'>0!('$D(^DPT(RADFN,0)))  S RANME=$P(^(0),"^",1),RASSN=$P(^(0),"^",9) D RACNI
 W !!,"Total=",RACNT,"  Inpatient=",RAIN,"  Outpatient=",RAOUT
 W !!,"+ counts as multiple exams",!,"- counts as zero exams"
 K BEG,BEGDATE,END,ENDDATE,PAGE,PGM,POP,RACNI,RACNT,RADATE,RADFN,RADTE,RADTI,RAIN,RAMIS,RAMIS1,RAMUL,RAMUL1,RANME,RANOW,RAOUT,RASSN,VAR Q
 ;
RACNI S RADTI=9999999.9999-RADTE S Y=RADTE D D^RAUTL S RADATE=Y
 F RACNI=0:0 S RACNI=$N(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  I $D(^(RACNI,0)) S Y=^(0) I $D(RACRT(+$P(Y,"^",3))),$D(^RAMIS(71,"C",RAMIS,+$P(Y,"^",2))) S RAMUL=$N(^(+$P(Y,"^",2),0)) D PRT
 Q
 ;
PRT S RAMUL=$P(^RAMIS(71,+$P(Y,"^",2),2,RAMUL,0),"^",2) I $P(^(0),"^",3)="Y",RAMUL'=2,RAMUL=1 S RAMUL=2
 F RAMUL1=0:0 S RAMUL1=$N(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"M",RAMUL1)) Q:RAMUL1'>0  I $D(^(RAMUL1,0)),$P(^(0),"^",1)=1,RAMUL'=2,RAMUL=1 S RAMUL=2 Q
 D HD:($Y+4)>IOSL W !,RANME,?35,RASSN,?49,$S(RAMUL>1:"+",RAMUL=0:"-",1:""),?50,$S($D(^RAMIS(71,+$P(Y,"^",2),0)):$P(^(0),"^",1),1:"Unknown"),?90,RADATE
 W ?110,$S($D(^DIC(42,+$P(Y,"^",6),0)):$P(^(0),"^",1),$D(^SC(+$P(Y,"^",8),0)):$P(^(0),"^",1),1:"Unknown")
 S RACNT=RACNT+RAMUL I $P(Y,"^",4)="I" S RAIN=RAIN+RAMUL Q
 S RAOUT=RAOUT+RAMUL Q
 ;
HD S PAGE=PAGE+1 W @IOF,"Patient List for AMIS Category ",RAMIS," - ",RAMIS1,?120,"Page: ",PAGE
 W !?90,"For period: ",BEG,"  to",!,"Run Date: ",RANOW,?102,END
 W !!,"Patient Name",?35,"SSN",?50,"Procedure",?90,"Exam Date",?110,"Ward/Clinic"
 W !,"------------",?35,"---",?50,"---------",?90,"-----------",?110,"-----------"
 Q
