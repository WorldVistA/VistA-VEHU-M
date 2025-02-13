IBDF6A ;ALB/CJM - ENCOUNTER FORM - (new forms, deleting forms, adding to setup) ;01/16/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**63**;APR 24, 1997;Build 81
 ;
 ;
DELFORM ;
 N CLINIC,FORM,BLOCK,NOCANDO,SETUP,ARY
 S NOCANDO=0,ARY="^TMP(""IBDF"",$J,""TEMPORARY CLINIC LIST"")"
 K @ARY
 D FULL^VALM1
 S VALMBCK="R"
 K DIC S DIC("S")="I '$P(^(0),U,7)",DIC=357,DIC(0)="AEQ",DIC("A")="Select FORM to delete: "
 D ^DIC K DIC S FORM=+Y Q:(FORM<0)
 D CLINICS^IBDFU4(FORM,ARY)
 I $G(@ARY@(0)) D
 .W !,"Cannot be deleted, the form is in use!"
 .D LIST^IBDFU4(ARY,IOSL)
 I '$G(@ARY@(0)) D DELETE^IBDFU2C(FORM,357,1)
 K @ARY
 Q
 ;
NEWFORM ;
 N NAME,FORM,FLD,BLOCK,IBDELETE,IBTXTSZ,IBSCAN,IBDVR
 S (IBTXTSZ,IBSCAN)=0
 S VALMBCK="R"
 S NAME=$$NEWNAME^IBDFU2C Q:NAME=""
 D FULL^VALM1
 K DIC,DD,DO,DINUM S DIC="^IBE(357,",DIC(0)="",X=NAME
 D FILE^DICN K DIC,DIE,DA
 S FORM=+Y
 I FORM<0 D
 .W !,"Unable to create a new form!" D PAUSE^IBDFU5
 E  D
 .K DIE,DR,DA S DIE="^IBE(357,",DR="[IBDF EDIT NEW FORM]",DA=FORM,DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA
 .I IBDELETE S DIK="^IBE(357,",DA=FORM D ^DIK K DIK,DA Q
 .D:'IBTKFORM ADDSETUP(FORM,IBCLINIC,1)
 .;the new form should be empty - make sure
 .S BLOCK="" F  S BLOCK=$O(^IBE(357.1,"C",FORM,BLOCK)) Q:'BLOCK  D
 ..I $P($G(^IBE(357.1,BLOCK,0)),"^",2)'=FORM D
 ...K DA S DIK="^IBE(357.1,",DA=BLOCK D IX^DIK K DIK,DA
 ..E  D DLTBLK^IBDFU3(BLOCK,FORM,357.1)
 .X IBAPI("INDEX")
 Q
COPYFORM ;
 N NAME,OLDFORM,NEWFORM,IBDELETE,IBOLD,IBSCAN,IBDFORM,IBDLST,IBDX,IBDCS,IBDY
 D FULL^VALM1
 S VALMBCK="R"
 S OLDFORM=$$SLCTFORM^IBDFU4("") Q:'OLDFORM
 S NAME=$$NEWNAME^IBDFU2C Q:NAME=""
 S NEWFORM=$$COPYFORM^IBDFU2C(OLDFORM,357,357,NAME,0)
 Q:'NEWFORM
 ;
 ;edit the form
 S IBOLD=$S($P($G(^IBE(357,NEWFORM,0)),"^",16):0,1:1)
 K DIE,DR,DA S DIE="^IBE(357,",DR="[IBDF EDIT OLD OR COPIED FORM]",DA=NEWFORM,DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA
 ;delete the new form if the user didn't complete the edit
 I IBDELETE D DELETE^IBDFU2C(NEWFORM,357) Q
 ;
 D:'IBTKFORM ADDSETUP(NEWFORM,IBCLINIC,1)
 X IBAPI("INDEX")
 ;Now check if new form contains any selection lists that specify ICD-9 or ICD-10
 ;if so, update history field at #357 .19 or .2 plus field .21
 S IBDFORM=0 F  S IBDFORM=$O(^IBE(357.1,"C",NEWFORM,IBDFORM)) Q:IBDFORM=""  D
 .S IBDLST=0 F  S IBDLST=$O(^IBE(357.2,"C",IBDFORM,IBDLST)) Q:IBDLST=""  S IBDX=$P(^IBE(357.2,IBDLST,0),U,11) D:IBDX?1.N
 ..S IBDCS=$P(^IBE(357.6,IBDX,0),U,22) D:IBDCS=1!(IBDCS=30)  ;Coding System 1=ICD-9 30=ICD-10
 ...I '$O(^IBE(357.3,"C",IBDLST,"")) Q  ;Only log history fields if ICD-9 or ICD-10 codes are contained in block.
 ...S IBDY=$$CSUPD357^IBDUTICD(NEWFORM,IBDCS,"",$$NOW^XLFDT(),DUZ)
 Q
SETUP ;
 N FORM
 D FULL^VALM1
 S VALMBCK="R"
 K DIC S DIC("S")="I '$P(^(0),U,7)",DIC=357,DIC(0)="AEQ",DIC("A")="Select FORM for Clinic Setup: "
 D ^DIC K DIC Q:($D(DTOUT)!$D(DUOUT))  S FORM=+Y Q:FORM<0
 D ADDSETUP(FORM,IBCLINIC,0)
 X IBAPI("INDEX")
 Q
ADDSETUP(FORM,IBCLINIC,NEW) ;
 ;NEW=1 if the form was just created, 0 otherwise
 N FLD,NODE,SETUP
 S NEW=+$G(NEW)
 K DA S DA=$O(^SD(409.95,"B",+$G(IBCLINIC),"")) I 'DA D
 .K DIC,DO,DD,DINUM S DIC="^SD(409.95,",DIC(0)="",X=IBCLINIC
 .D FILE^DICN K DIC
 .S DA=$S(+Y<1:0,1:+Y)
 Q:'DA
 S SETUP=DA,NODE=$G(^SD(409.95,SETUP,0))
 W !,"How should the clinic use the form?"
 K DIR
 S DIR(0)="SO^1:BASIC FORM;2:SUPPLEMENTAL FORM FOR ALL PATIENTS;3:SUPPLEMENTAL FORM FOR NEW PATIENTS;4:SUPPLEMENTAL FORM FOR ESTABLISHED PATIENTS;5:FORM TO PRINT WITHOUT PATIENT DATA;6:RESERVED FOR FUTURE USE;"
 S:NEW DIR(0)=DIR(0)_"7:WILL NOT BE USED BY CLINIC;"
 D ^DIR K DIR
 I (Y=-1)!(Y=7)!$D(DIRUT) Q
 S:Y'=2 FLD=$S(Y=1:.02,Y=3:.04,Y=4:.03,Y=5:.05,Y=6:.07,1:0)
 S:Y=2 FLD=$S('$P(NODE,"^",6):.06,'$P(NODE,"^",8):.08,1:.09)
 Q:'FLD
 I $P($G(^SD(409.95,DA,0)),"^",(100*FLD)) Q:'$$OVERLAY
 K DIE,DR S DIE=409.95
 S DR=FLD_"////"_FORM D ^DIE K DIE,DR,DA
 Q
OVERLAY() ;asks the user if the he wants to overlay the form already used for the clinic setup
 W !,"But you already have a form for that use!"
 K DIR S DIR(0)="Y",DIR("A")="Do you want to replace it"
 D ^DIR K DIR
 Q:$D(DIRUT) 0
 Q Y
