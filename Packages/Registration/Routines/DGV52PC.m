DGV52PC ;ALB/MIR - DOM ELIGIBILITY AND CAT C CONVERSIONS ; 5/1/92
 ;;5.2;REGISTRATION;;JUL 29,1992
EN W !,">>> Converting all DOMICILLIARY eligibilities"
 I '$D(DT) D DT^DICRW
 S DGMSGF=1 ; suppress MT REQUIRED messages when editing entries
 S DGDOM="" F I=0:0 S I=$O(^DIC(8,"D",11,I)) Q:'I  S DGDOM=DGDOM_I_","
 ;
 F DFN=0:0 S DFN=$O(^DPT(DFN)) Q:'DFN  W:'(DFN#100) "." S DGNAME=$P($G(^DPT(DFN,0)),"^",1) I DGNAME]"" D DOM
 D DOMOUT
 D CATB
 K DA,DFN,DG,DGDOM,DGEC,DGEFL,DGMSGF,DGNAME,DGPCT,DGPOS,DGSC,DGVET,DIK,I,NODE,^TMP("DG DOM",$J)
 Q
 ;
DOM ;look for DOM eligibilities and replace with most appropriate elig.
 I +$G(^DPT(DFN,.35)) Q  ; patient has died
 I '$$ACTIVE(DT-10000,9999999) Q
 F NODE=.3,.32,.36,"VET" S DG(NODE)=$G(^DPT(DFN,NODE))
 S DGVET=$S($P(DG("VET"),"^",1)="Y":1,1:0),DGSC=$S($P(DG(.3),"^",1)="Y":1,1:0),DGPCT=$S(DGSC:+$P(DG(.3),"^",2),1:0),DGEC=+DG(.36)
 S DGPOS=$P($G(^DIC(21,+$P(DG(.32),"^",3),0)),"^",3)
 K DG,NODE
 F DGEFL=1:1 S DGEFL=$P(DGDOM,",",DGEFL) Q:'DGEFL  I $D(^DPT(DFN,"E",DGEFL,0)) D DOMFIX
 Q
 ;
DOMFIX ; for those patients with a dom eligibility, change it to the most
 ; appopriate
 ;
 I DGEFL'=DGEC S DIK="^DPT("_DFN_",""E"",",DA(1)=DFN,DA=DGEFL D ^DIK Q  ; delete if dom is not primary
 I 'DGVET S DIE="^DPT(",DA=DFN,DR=".361///@" S ^TMP("DG DOM",$J,DGNAME,DFN)="@" D ^DIE Q  ; - delete if not vet
 ;
 ; find most appropriate primary eligility for patient
 ; DGCODE = IFN of appropriate entry in file 8.1 (MAS ELIGIBILITY CODE)
 ;
 I DGSC,DGPCT'<50 S DGCODE=1 G STUFF ; SC>50
 I DGSC S DGCODE=3 G STUFF ; SC<50
 I $P($G(^DPT(DFN,.52)),"^",5)="Y" S DGCODE=18 G STUFF ; POW
 S X=$P($G(^DPT(DFN,0)),"^",3) I X<2200101.9,(DGPOS=1) S DGCODE=17 G STUFF ; WWI
 S X=$G(^DPT(DFN,.362)) I $P(X,"^",12)="Y" S DGCODE=2 G STUFF ; A&A
 I $P(X,"^",13)="Y" S DGCODE=15 G STUFF ; HB
 I $P(X,"^",14)="Y" S DGCODE=4 G STUFF ; NSC, VA PENSION
 S DGCODE=5 ; NSC
 ;
STUFF ; stuff the new eligibility in
 S DGLCODE=$O(^DIC(8,"D",DGCODE,0)) I '$D(^DIC(8,+DGLCODE,0)) Q  ; site doesn't have a local code set up
 S DIE="^DPT(",DA=DFN,DR=".361////"_DGLCODE S ^TMP("DG DOM",$J,DGNAME,DFN)=DGLCODE
 D ^DIE
 K DA,DIE,DR,DGCODE,DGLCODE
 Q
 ;
DOMOUT ;output dom conversions
 W !!,"PATIENTS FOUND WITH DOM ELIGIBILITY ON FILE:"
 S DGNAME="" F  S DGNAME=$O(^TMP("DG DOM",$J,DGNAME)) Q:DGNAME']""  F DFN=0:0 S DFN=$O(^TMP("DG DOM",$J,DGNAME,DFN)) Q:'DFN  S DGLCODE=^(DFN) D PID^VADPT D
 . W !,DGNAME," (",VA("BID"),")"
 . I DGLCODE="@" W ?38,"non-veteran...DOM eligibility deleted!"
 . I $G(^DIC(8,+DGLCODE,0))]"" W ?38,"changed to ",$P(^(0),"^",1)
 K DFN,DGLCODE,VA
 I $O(^TMP("DG DOM",$J,0))']"" W !,"NO DOM PATIENTS FOUND!" Q
 W !!,"Please review above patients to ensure their new eligibility is accurate."
 Q
 ;
CATB ; loop through cat Bs for active ones
 W !,">>> Print all active Cat 'B's",!!
 F DFN=0:0 S DFN=$O(^DPT("ACS",5,DFN)) Q:DFN'>0  D CATBLST
 D CATBOUT
 K ^TMP("DGPOST",$J,"WHEN"),DFN
 Q
CATBLST N NODE0,DGWHEN
 S NODE0=$G(^DPT(DFN,0)) Q:(+$G(^(.35)))!($P(NODE0,U,14)'=5)
 S DGWHEN=""
 I $$ACTIVE(DT-10000,DT) S $P(DGWHEN,U,1)="X"  ;PAST YR
 I +$G(^DPT(DFN,.105)) S $P(DGWHEN,U,2)="X"    ;INHOUSE
 I $$ACTIVE(DT,9999999) S $P(DGWHEN,U,3)="X"   ;FUTURE
 S:DGWHEN]"" ^TMP("DGPOST",$J,"WHEN",DFN)=DGWHEN_";;"_$P(NODE0,U,1)
 Q
ACTIVE(FROM,TO) ;
 ;Y=0 IF NOT ACTIVE
 ;1:DISPOSITION
 ;2:CLINIC APPT
 ;3:SCHEDULED ADMISSION
 ;4:PATIENT MOVEMENT
 ;
 N A,X,Y
 S Y=0
 S X=$O(^DPT(DFN,"DIS",(9999999-TO))) S:X&(X<(9999999-FROM)) Y=1
 I 'Y S X=$O(^DPT(DFN,"S",FROM)) S:(+X)&(+X<TO) Y=2
 I 'Y F A=0:0 S A=$O(^DGS(41.1,"B",DFN,A)) Q:A'>0  S X=$P($G(^DGS(41.1,+A,0)),U,2) S:(X'<FROM)&(X'>TO) Y=3
 I 'Y S X=$O(^DGPM("APRD",DFN,FROM)) S:(+X)&(+X<TO) Y=4
 Q Y
CATBOUT ;
 N DGLINE,DFN,DGYRAGO,DGTODAY,DGX,VAERR,VA,Y
 S Y=DT-10000 X ^DD("DD") S DGYRAGO=Y
 S Y=DT X ^DD("DD") S DGTODAY=Y
 W !!,"Listing Active Category 'B' Patients..."
 I $D(^TMP("DGPOST",$J,"WHEN")) D
 .W !!,?10,"INHOUSE = Current Inpatient"
 .W !!,?5,"For Scheduled Admissions, Dispositions, or Clinic Appointments:"
 .W !,?10,"PAST    = ",DGYRAGO," to ",DGTODAY
 .W !,?10,"FUTURE  = After ",DGTODAY
 .W !!!,"PATIENT NAME",?35,"PATIENT ID #",?55,"PAST",?61,"INHOUSE",?70,"FUTURE"
 .S DGLINE="",$P(DGLINE,"=",81)=""
 .W !,DGLINE
 .F DFN=0:0 S DFN=$O(^TMP("DGPOST",$J,"WHEN",DFN)) Q:DFN'>0  S DGX=^(DFN) D
 ..D PID^VADPT6
 ..W !,$P(DGX,";;",2),?35,VA("PID"),?56,$P($P(DGX,";;",1),U,1),?64,$P($P(DGX,";;",1),U,2),?72,$P($P(DGX,";;",1),U,3)
 I '$D(^TMP("DGPOST",$J,"WHEN")) W !!,"NO ACTIVE CATEGORY B PATIENTS FOUND",!,"   ------",!
 K VAPTYP
 Q
