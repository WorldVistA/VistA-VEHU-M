IBCNSU41 ;ALB/CPM - SPONSOR UTILITIES (CON'T) ; 5/9/03 1:25pm
 ;;2.0;INTEGRATED BILLING;**52,211,240,497,654**;21-MAR-94;Build 8
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
SPON(DFN) ; Add/edit sponsor/sponsor relationships for a patient.
 ;  Input:    DFN  --  Pointer to the patient in file #2
 ;
 I '$G(DFN) G SPONQ
 N IBQ S IBQ=0
 F  D LSP Q:IBQ
SPONQ Q
 ;
 ;
 ;
LSP ; Main loop to collect sponsor and relation data.
 S DIR(0)="FAO^3:30",DIR("A")="Select SPONSOR: " D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT)!$D(DUOUT)!$D(DTOUT) K DIRUT,DIROUT,DTOUT,DUOUT S IBQ=1 G LSPQ
 S IBX=X
 ;
 ; - perform lookup to find sponsor or add a patient sponsor
 S DIC(0)="ELMZ",DIC="^IBA(355.8,",DLAYGO=355.8 D ^DIC K DIC,DLAYGO
 I Y>0 S IBSP=+Y,IBSPD=$G(^IBA(355.8,IBSP,0)),IBNAM=Y(0,0) G LSPC
 I IBX'?1.A1","1.ANP W !,"New sponsors must be in the format LAST,FIRST.",! G LSP
 ;
 ; - is this a new sponsor to be added to the system?
 S DIR(0)="Y",DIR("A")="  Are you adding '"_IBX_"' as a new SPONSOR"
 D ^DIR K DIR
 I 'Y!$D(DIRUT)!$D(DIROUT)!$D(DUOUT)!$D(DTOUT) K DIRUT,DIROUT,DTOUT,DUOUT G LSP
 ;
 ; - add non-patient sponsor to file #355.82 (sponsor person file)
 S (X,IBNAM)=IBX,DIC(0)="L",DIC="^IBA(355.82,",DLAYGO=355.82
 D FILE^DICN S IBSPP=+Y K DLAYGO
 I IBSPP<0 W !,"Unable to add a new sponsor!" G LSPQ
 ;
 ; - now add to file #355.8 (sponsor file)
 S (IBSPD,X)=IBSPP_";IBA(355.82,",DIC(0)="L",DIC="^IBA(355.8,",DLAYGO=355.8
 D FILE^DICN S IBSP=+Y K DLAYGO
 I IBSP<0 W !,"Unable to add a new sponsor!" G LSPQ
 ;
LSPC ; - allow edit of non-patient sponsor name/dob/ssn
 ; Start of Sponsor changes for IB*2.0*654
 N IBFLAG,IBIEN,IBPAT,IBSPON,IBTXT1,IBTXT2,IBTXT3,DIR,DIE,DA,DR
 S IBIEN=""
 ; Loop though Sponsors to find match
 F  S IBIEN=$O(^IBA(355.81,"B",DFN,IBIEN)) Q:'IBIEN  I $P($G(^IBA(355.81,IBIEN,0)),U,2)=IBSP D
 .S DIR(0)="YAO",DIR("B")="NO"
 .; Get Patient name from #2
 .S IBPAT=$$GET1^DIQ(2,DFN_",",.01,"E")
 .; Get Sponsor name from #355.8
 .S IBSPON=$$GET1^DIQ(355.8,IBSP_",",.01,"E")
 .S (IBTXT1,IBTXT2,IBTXT3)=""
 .S IBTXT1=IBSPON_" is a current Sponsor of the Patient "
 .; IF both Sponsor and Patient will fit on 1 line
 .I $L(IBTXT1)+$L(IBPAT)+1'>80 D
 .. S IBTXT1=IBTXT1_IBPAT_"."
 .. S IBTXT2="Would you like to remove this Sponsor from this Patient?"
 .; If IBTXT2 is not defined, 1st IF failed so put the Patient Name on 2nd line
 .I '$L(IBTXT2) D
 .. S IBTXT2=IBPAT_". Would you like to remove this Sponsor from this Patient?"
 .. I $L(IBTXT2)>80 D SPTXT(.IBTXT2,.IBTXT3)
 .W !!,IBTXT1
 .W !,IBTXT2
 .I $L(IBTXT3) W !,IBTXT3
 .S DIR("A")="(Yes to Delete, No to Edit, ^ to Exit ) "
 .S DIR("??")="^ D HELP^IBCNSU41"
 .D ^DIR I Y=1 D
 ..W !
 ..S DIR("A",1)="This will permanently delete the Sponsor Relationship."
 ..S DIR("A")="Are you sure you would like to delete this entry? "
 ..S DIR("??")="^ D HELP^IBCNSU41"
 ..S DIR(0)="YAO",DIR("B")="NO"
 ..D ^DIR I Y=1 D
 ...S DIK="^IBA(355.81,",DA=IBIEN D ^DIK K DIK S IBFLAG=1
 .W !
 .; End of Sponsor changes for IB*2.0*654
 G:$G(IBFLAG) LSPQ
 ;
 ; - allow edit of non-patient sponsor name/dob/ssn
 I $P(IBSPD,"^")["IBA" D
 .S DIE="^IBA(355.82,",DA=+IBSPD
 .S DR=".01  NAME;.02  DATE OF BIRTH;.03  SOCIAL SECURITY NUMBER"
 .D ^DIE K DIE,DA,DR
 ;
 ; - edit remaining sponsor attributes
 S DIE="^IBA(355.8,",DA=IBSP
 S DR=".02  MILITARY STATUS;.03  BRANCH;.04  RANK"
 D ^DIE K DA,DR,DIE
 ;
 ; - find patient relation to sponsor, or create one
 S IBSPR=0 F  S IBSPR=$O(^IBA(355.81,"B",DFN,IBSPR)) Q:'IBSPR  I $P($G(^IBA(355.81,IBSPR,0)),"^",2)=IBSP Q
 I 'IBSPR S IBQQ=0 D  G:IBQQ LSPQ
 .W !!,"The person '",IBNAM,"' is not currently the sponsor of this patient."
 .S DIR(0)="Y",DIR("A")="Okay to add this person as the patient's sponsor"
 .S DIR("?")="Please enter 'YES' to add this person as the patient's sponsor, or 'NO' to select a new sponsor."
 .D ^DIR K DIR I 'Y W ! S IBQQ=1 Q
 .;
 .S X=DFN,DIC="^IBA(355.81,",DIC(0)="L",DIC("DR")=".02////"_IBSP,DLAYGO=355.81
 .D FILE^DICN S IBSPR=+Y S:Y<0 IBQQ=1 K DLAYGO
 ;
 ; - edit sponsor relation attributes
 S DIE="^IBA(355.81,",DA=IBSPR,DR=".03:.06" D ^DIE K DA,DIE,DR
 W !
 ;
LSPQ K IBFLAG,IBIEN,IBPAT,IBSPON,IBSP,IBSPD,IBSPP,IBSPR,IBQQ,IBNAM,IBX,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 Q 
 ;
LSPCX ; - allow edit of non-patient sponsor name/dob/ssn
 I $P(IBSPD,"^")["IBA" D
 .S DIE="^IBA(355.82,",DA=+IBSPD
 .S DR=".01  NAME;.02  DATE OF BIRTH;.03  SOCIAL SECURITY NUMBER"
 .D ^DIE K DIE,DA,DR
 ;
 ; - edit remaining sponsor attributes
 S DIE="^IBA(355.8,",DA=IBSP
 S DR=".02  MILITARY STATUS;.03  BRANCH;.04  RANK"
 D ^DIE K DA,DR,DIE
 ;
 ; - find patient relation to sponsor, or create one
 S IBSPR=0 F  S IBSPR=$O(^IBA(355.81,"B",DFN,IBSPR)) Q:'IBSPR  I $P($G(^IBA(355.81,IBSPR,0)),"^",2)=IBSP Q
 I 'IBSPR S IBQQ=0 D  G:IBQQ LSPQ
 .W !!,"The person '",IBNAM,"' is not currently the sponsor of this patient."
 .S DIR(0)="Y",DIR("A")="Okay to add this person as the patient's sponsor"
 .S DIR("?")="Please enter 'YES' to add this person as the patient's sponsor, or 'NO' to select a new sponsor."
 .D ^DIR K DIR I 'Y W ! S IBQQ=1 Q
 .;
 .S X=DFN,DIC="^IBA(355.81,",DIC(0)="L",DIC("DR")=".02////"_IBSP,DLAYGO=355.81
 .D FILE^DICN S IBSPR=+Y S:Y<0 IBQQ=1 K DLAYGO
 ;
 ; - edit sponsor relation attributes
 S DIE="^IBA(355.81,",DA=IBSPR,DR=".03:.06" D ^DIE K DA,DIE,DR
 W !
 ;
LSPQX K IBSP,IBSPD,IBSPP,IBSPR,IBQQ,IBNAM,IBX,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 Q
 ;
 ;
 ;
POL(DFN) ; Update TRICARE policies with Sponsor information.
 ;  Input:   DFN  --  Pointer to the patient in file #2
 ;
 I '$G(DFN) G POLQ
 N IBX,IBY,IBY7,SPON,X,X1,X3,Y,Z
 ;
 S X=0 F  S X=$O(^IBA(355.81,"B",DFN,X)) Q:'X  D  Q:$D(Z)
 .S Y=$G(^IBA(355.81,X,0))
 .;
 .; - relationship must be with a Tricare sponsor
 .Q:$P(Y,"^",4)'="T"
 .;
 .S SPON=$G(^IBA(355.8,+$P(Y,"^",2),0)) Q:SPON=""
 .;
 .; - if sponsor is a patient, get name/dob/SSN from the patient
 .;   file; otherwise, use file #355.82
 .I $P(SPON,"^")["DPT" D
 ..S X1=$G(^DPT(+SPON,0)) Q:X1=""
 ..S Z("NAME")=$P(X1,"^"),Z("DOB")=$P(X1,"^",3),Z("SSN")=$P(X1,"^",9)
 .E  D
 ..S X1=$G(^IBA(355.82,+SPON,0)) Q:X1=""
 ..S Z("NAME")=$P(X1,"^"),Z("DOB")=$P(X1,"^",2),Z("SSN")=$TR($P(X1,"^",3),"-","")
 .;
 .S Z("BRAN")=$P(SPON,"^",3),Z("RANK")=$P(SPON,"^",4)
 ;
 ; - if no Tricare sponsors were found, quit.
 I '$D(Z) G POLQ
 ;
 ; - update any policies with TRICARE plans
 S IBX=0 F  S IBX=$O(^DPT(DFN,.312,IBX)) Q:'IBX  S IBY=$G(^(IBX,0)),IBY7=$G(^(7)) D       ; IB*2.0*497 (vd)
 .;
 .; - only consider TRICARE plans
 .Q:$P($G(^IBE(355.1,+$P($G(^IBA(355.3,+$P(IBY,"^",18),0)),"^",9),0)),"^",3)'=7
 .;
 .; - the policyholder should not be the veteran (patient)
 .Q:$P(IBY,"^",6)="v"
 .;
 .; - if a sponsor DOB exists, be sure it's the same as the
 .;   sponsor file DOB
 .S X3=$G(^DPT(DFN,.312,IBX,3))
 .I X3,+X3'=Z("DOB") Q
 .;
 .S DR=""
 .;IB*2*211
 .I $P(IBY7,"^")="" S DR=DR_"7.01////"_Z("NAME")_";"            ; IB*2.0*497 (vd)
 .I $P(X3,"^")="",Z("DOB") S DR=DR_"3.01////"_Z("DOB")_";"
 .I $P(X3,"^",2)="",Z("BRAN") S DR=DR_"3.02////"_Z("BRAN")_";"
 .I $P(X3,"^",3)="",Z("RANK")]"" S DR=DR_"3.03////"_Z("RANK")_";"
 .I $P(X3,"^",5)="",Z("SSN")]"" S DR=DR_"3.05////"_Z("SSN")_";"
 .;
 .Q:DR=""
 .I $E(DR,$L(DR))=";" S DR=$E(DR,1,$L(DR)-1)
 .;
 .S DIE="^DPT(DFN,.312,",DA(1)=DFN,DA=IBX D ^DIE K DA,DIE,DR
 ;
POLQ Q
 ;
HELP ; Sponsor Delete Help
 W !!,"Answering Yes will only remove this Sponsor from this Patient."
 W !,"The Sponsor will remain in the Sponsor file and will be"
 W !,"available for selection for other Patients."
 Q
 ;
SPTXT(IBTXT2,IBTXT3) ;
 ; Function to split IBTXT2 into 2 lines each <=80 chars.
 I $L(IBTXT2)'>80 Q
 N ICNT,IBQUIT
 S IBQUIT=0
 F ICNT=80:-1:1 D  Q:IBQUIT
 .I $E(IBTXT2,ICNT)=" " D  Q
 ..S IBQUIT=1
 ..S IBTXT3=$E(IBTXT2,ICNT+1,999)
 ..S IBTXT2=$E(IBTXT2,1,ICNT)
 Q
