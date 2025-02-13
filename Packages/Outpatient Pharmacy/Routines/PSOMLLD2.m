PSOMLLD2 ;BIR/LE - Service Connection Check for SC>50% ;02/27/04
 ;;7.0;OUTPATIENT PHARMACY;**143,219,239,225,431,514,547**;DEC 1997;Build 1
 ;External reference SDC022 supported by DBIA 1579
 ;External reference DIS^SDROUT2 private by DBIA 112
 ;External reference $$GETSHAD^DGUTL3 supported by DBIA 4462
 ;External reference ^DPT(DFN,.372 private by DBIA 1476
 ;External reference ^DIC(31 supported by DBIA 658
SC ;This routine is used for SC>50% - OUTSIDE OF COPAY - DFN AND PSOSCP VARIABLES ARE EXPECTED TO BE PRESENT WHEN CALLED
 ; Requires: DFN, PSOSCP, PSOSCA 
 I '$G(DFN) N DFN S DFN=+$G(PSODFN)
 ;I $G(DFN) I '$$SC^SDCO22(DFN) D  Q  ;if SC>49 don't ask if api says not to
 ;. K PSOANSQ("SC>50"),PSOANSQD("SC>50") I $G(PSOX("IRXN")) K PSOANSQ(PSOX("IRXN"),"SC>50")
SC2 I $G(PSOMESOI)=1,$G(PSORXED) W !!,"The Pharmacy Orderable Item has changed for this order. Please review any",!,"existing SC or Environmental Indicator defaults carefully for appropriateness.",! S PSOMESOI=2
 I $G(PSOMESFI)=1 W !!,"The Pharmacy Orderable Item has changed for this order. Please review any",!,"existing SC or Environmental Indicator defaults carefully for appropriateness.",! S PSOMESFI=2
 N PSODISAR D CHKPAG,DISSCD ;*514
 N PSOUFLAG S PSOUFLAG=0 K DIR S DIR(0)="Y"
 S DIR("A")="Was treatment for a Service Connected condition"
 S DIR("?")=" ",DIR("?",1)="Enter 'Yes' if this prescription is being used to treat a condition related",DIR("?",2)="to Service Connected."
 I '$G(PSOFLAG) D
 . I PSOSCP<50 S (DIR("B"),PSOUFLAG)=$S($G(PSORX(+$G(PSORENW("OIRXN")),"SC"))=0:"NO",$G(PSORX(+$G(PSORENW("OIRXN")),"SC"))=1:"YES",1:"") I DIR("B")="" K DIR("B") S PSOUFLAG=0
 . I PSOSCP<50&($D(PSORX(+$G(PSORENW("OIRXN")),"SC>50"))) S (DIR("B"),PSOUFLAG)=$S($G(PSORX(+$G(PSORENW("OIRXN")),"SC>50"))=0:"NO",$G(PSORX(+$G(PSORENW("OIRXN")),"SC>50"))=1:"YES",1:"") I DIR("B")=""  K DIR("B") S PSOUFLAG=0
 . I PSOSCP>49 S (DIR("B"),PSOUFLAG)=$S($G(PSORX(+$G(PSORENW("OIRXN")),"SC>50"))=0:"NO",$G(PSORX(+$G(PSORENW("OIRXN")),"SC>50"))=1:"YES",1:"") I DIR("B")=""  K DIR("B") S PSOUFLAG=0
 . I '$D(DIR("B"))&($D(PSOANSQD("SC>50"))!($D(PSOANSQD("SC")))) D  I '$D(DIR("B")) K DIR("B") S PSOUFLAG=0
 .. I $D(PSOANSQD("SC>50")) I $G(PSOANSQD("SC>50"))=0!($G(PSOANSQD("SC>50"))=1) S (PSOUFLAG,DIR("B"))=$S($G(PSOANSQD("SC>50"))=1:"YES",1:"NO")
 .. I $D(PSOANSQD("SC")) I $G(PSOANSQD("SC"))=0!($G(PSOANSQD("SC"))=1) S (PSOUFLAG,DIR("B"))=$S($G(PSOANSQD("SC"))=1:"YES",1:"NO")
 I $G(PSORX("SC"))]""!($G(PSORX(+$G(PSORENW("OIRXN")),"SC"))'="") S DIR("B")=$S($G(PSORX("SC"))="SC":"YES",$G(PSORX("SC"))="NSC":"NO",$G(PSORX(+$G(PSORENW("OIRXN")),"SC"))=1:"YES",$G(PSORX(+$G(PSORENW("OIRXN")),"SC"))=0:"NO",1:"")
 ;
 I $G(PSOFLAG),$G(PSONEWFF) I $G(PSOANSQD("SC>50"))=0!($G(PSOANSQD("SC>50"))=1) S DIR("B")=$S($G(PSOANSQD("SC>50"))=1:"YES",1:"NO")
 I $G(DIR("B"))="YES"!($G(DIR("B"))="NO") S PSOUFLAG=$G(DIR("B"))
 I $G(DIR("B"))="" K DIR("B")
 W ! D ^DIR K DIR
 I $G(Y)=1!($G(Y)=0) D  I $G(PSONEWFF),$G(PSOFLAG) S PSOANSQD("SC>50")=$G(Y)
 . I $G(PSOX("IRXN")) S PSOANSQ(PSOX("IRXN"),"SC>50")=+Y
 . S PSOANSQ("SC>50")=+Y
 I PSOFLAG I Y["^"!($D(DTOUT))!($D(DUOUT)) S PSOCPZ("DFLG")=1
 S:Y=0 Y=2
 S PSOANSR=+Y I 'PSOANSR,'PSOFLAG D  S $P(PSOCPAY,"^")=$S($G(PSOUFLAG)="NO":1,1:0) W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 .W !!,"This Renewal has been designated as "_$S($G(PSOUFLAG)="YES":"SERVICE CONNECTED",1:"NON-SERVICE CONNECTED.")
 .;W !,"Please use the 'Reset Copay Status/Cancel Charges' option to make  corrections."
 .S PSOANSQ("SC>50")=$S($G(PSOUFLAG)="YES":1,1:0)
 I $G(PSOFLAG),$G(PSOCPZ("DFLG")) G EXIT
 S:PSOANSR=1 PSOCPAY=0 S:PSOANSR=2 $P(PSOCPAY,"^")=1
EXIT ;
 K PSOANSR,DIR,DUOUT,DIRUT,DTOUT,Y,X,PSOSCA
 Q
 ;
PAUSE K DIR W ! S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
 ;
SHAD ; PROJ 112/SHAD Question
 I $G(PSODFN),$L($T(GETSHAD^DGUTL3)) I $$GETSHAD^DGUTL3(PSODFN)'=1 D  Q
 . K PSOANSQ("SHAD"),PSOANSQD("SHAD") I $G(PSOX("IRXN")) K PSOANSQ(PSOX("IRXN"),"SHAD")
 N PSOUFLAG S PSOUFLAG=0
 K DIR S DIR(0)="Y"
 S DIR("A")="Was treatment related to PROJ 112/SHAD"
 S DIR("?")=" "
 S DIR("?",1)="Enter 'Yes' if this prescription is being used to treat a condition due to"
 S DIR("?",2)="Shipboard Hazard and Defense (SHAD) exposure."
 S DIR("?",3)="This response will be used to determine whether or not a copay should"
 S DIR("?",4)="be applied to the prescription."
 I '$G(PSOFLAG) D
 . S (DIR("B"),PSOUFLAG)=$S($G(PSORX(+$G(PSORENW("OIRXN")),"SHAD"))=0:"NO",$G(PSORX(+$G(PSORENW("OIRXN")),"SHAD"))=1:"YES",1:"")
 . I DIR("B")="" K DIR("B") S PSOUFLAG=0
 I $G(PSOFLAG),$G(PSONEWFF) D
 . I $G(PSOANSQD("SHAD"))=0!($G(PSOANSQD("SHAD"))=1) D
 . . S DIR("B")=$S($G(PSOANSQD("SHAD"))=1:"YES",1:"NO")
 W ! D ^DIR K DIR
 I $G(PSOFLAG) W ! D  Q
 . I Y["^"!($D(DUOUT))!($G(DTOUT)) S PSOCPZ("DFLG")=1 Q
 . S PSOANSQ("SHAD")=Y
 . I $G(PSONEWFF) S PSOANSQD("SHAD")=Y
 I Y["^"!($D(DUOUT))!($D(DTOUT)) D  Q
 . W !!,"This Renewal has been designated as"_$S($G(PSOUFLAG)="YES":"",1:" NOT")_" being used for treatment of "
 . W !,"Shipboard Hazard and Defense (SHAD) exposure." D:$G(PSOSCP)<50 MESS^PSOMLLDT D PAUSE
 . S PSOANSQ(PSOX("IRXN"),"SHAD")=$S($G(PSOUFLAG)="YES":1,1:0)
 I $G(PSOX("IRXN")) S PSOANSQ(PSOX("IRXN"),"SHAD")=Y
 E  S PSOANSQ("SHAD")=Y
 Q
 ;
CHKPAG ;
 N PSOSPACE K PSODISAR S $P(PSOSPACE," ",50)=""
 S I3=0 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I  D
 .S I1=^DPT(DFN,.372,I,0) I $P(I1,"^",3) D
 ..S I2=$S($D(^DIC(31,+I1,0)):^(0),1:""),I2=$S($P(I2,"^",4)]"":$P(I2,"^",4),1:$P(I2,"^"))
 ..S PSODISAR(I)=I2_$E(PSOSPACE,1,48-$L(I2))_$J($P(I1,"^",2),4)_"% - "_$S($P(I1,"^",3):"SERVICE CONNECTED",1:""),I3=I3+1
 I 'I3 S PSODISAR(1)=$S('$O(^DPT(DFN,.372,0)):"NONE STATED",1:"NO SC DISABILITIES LISTED")
 S PSODISAR=I3
 K I1,I2,I3
 Q
 ;
DISSCD ;DISPLAY SERVICE CONNECTED DISABILITIES - REPLACES CALL TO DIS^SDROUT2
 ;
 ;rated disabilities
 ; -- Pharmacy is allowed to call this tag via a special agreement
 ;    with MAS.  MAS should notify pharmacy developers of any
 ;    changes that may impact PS* code.  (5/91 - MJK/BOK)
 ;
 I '$D(VAEL) D ELIG^VADPT S DGKVAR=1
 I $Y<3,$O(PSODISAR(0)) W "DRUG: "_$S($G(PSODRUG("TRADE NAME"))]"":PSODRUG("TRADE NAME"),1:$G(PSODRUG("NAME")))
 W:'+VAEL(3) !!,"Service Connected: NO" W:+VAEL(3) !!,"       SC Percent: ",$P(VAEL(3),"^",2)_"%"
 W !,"     Disabilities: " I 'VAEL(4),$S('$D(^DG(391,+VAEL(6),0)):1,$P(^(0),"^",2):0,1:1) W "NOT A VETERAN" G DISQ
 S I=0 F  S I=$O(PSODISAR(I)) Q:'I  D
 .W !,PSODISAR(I)
 .I $Y+3>IOSL D
 ..S DIR(0)="E",DIR("A")=" Press the return key to continue" D ^DIR W @IOF
 ..I $O(PSODISAR(I)) W "DRUG: "_$S($G(PSODRUG("TRADE NAME"))]"":PSODRUG("TRADE NAME"),1:$G(PSODRUG("NAME"))),!
DISQ I $D(DGKVAR) D KVAR^VADPT K DGKVAR,I
 Q
