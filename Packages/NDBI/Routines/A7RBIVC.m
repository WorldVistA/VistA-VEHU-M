A7RBIVC ;DCIOFO/CMS -STUFF PATIENT POLICY VERIFICATION DATE ;12/17/98
 ;;1.0;NDBI-KERNEL 8.0;;JAN 1, 1997
 Q
 ;
EN ;Enter here from option
 W !!,"This Utility allows users to enter a Verification of Coverage date"
 W !,"in all Patient Policies entered before a specified date."
 W !,"The Verified By field will be stuffed with the specified user selected.",!!
 ;
 ;Enter date Plan should be entered by
 N A7REDT,DTOUT,%DT,X,Y
 S %DT="AEPTX",%DT("A")="Policies entered before: ",%DT(0)="-NOW"
 D ^%DT I Y<1 G EXIT
 I $G(DTOUT) G EXIT
 S A7REDT=Y
 ;
 ;Enter Verification date to be stuffed in
 N A7RVDT,DTOUT K %DT,X,Y
 S %DT="AEPRX",%DT("A")="Verification Date/Time to be stuffed in: ",%DT(0)="-NOW"
 D ^%DT I Y<1 G EXIT
 I $G(DTOUT) G EXIT
 S A7RVDT=Y
 ;
 ;Select user Verified By field should reflect.
 N A7RDUZ,DIC,DA K X,Y
 S DIC("A")="Select Verified By User: "
 S DIC(0)="AEQMN",DIC="^VA(200," D ^DIC
 I +Y<1 G EXIT
 S A7RDUZ=+Y
 ;
 N A7ROUT
 D OKAY I $G(A7ROUT)=1 G EXIT
 D PROC
 ;
EXIT Q
 ;
PROC ;Process through and stuff Date last Verifed #1.03
 N A7RC,A7RPOL,A7R1,A7RXDT,DA,DIE,DFN,DR,X,Y
 ;
 S A7RC=0 F  S A7RC=$O(^DPT("AB",A7RC)) Q:'A7RC  D
 . S DFN=0 F  S DFN=$O(^DPT("AB",A7RC,DFN)) Q:'DFN  D
 .. S A7RPOL=0 F  S A7RPOL=$O(^DPT("AB",A7RC,DFN,A7RPOL)) Q:'A7RPOL  D
 ... S A7R1=$G(^DPT(DFN,.312,A7RPOL,1))
 ... I 'A7R1 Q  ;Date entered does not exist
 ... I +A7R1'<A7REDT Q  ;Date entered must be before user supplied date
 ... S A7RXDT=$P($G(^DPT(DFN,.312,A7RPOL,0)),U,4)
 ... ; I A7RXDT,A7RXDT'>DT Q  ;If Expiration date, must be in future
 ... ;
 ... S DIE="^DPT("_DFN_",.312,",DA=A7RPOL,DA(1)=DFN
 ... S DR="1.03///"_A7RVDT_";1.04///"_A7RDUZ D ^DIE
 ;
 W !!,"Verification of Coverage run is DONE!"
 Q
 ;
OKAY ;Ask Okay to Continue
 N DIR,DTOUT,DIROUT,DIRUT,DUOUT,X,Y
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Okay to Continue"
 S DIR("?")="Enter 'Yes' to process data now." W !
 D ^DIR I $D(DTOUT) S A7ROUT=1 Q
 I $G(Y)'=1 S A7ROUT=1
 Q
