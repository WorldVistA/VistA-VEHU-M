FBCHCD ;AISC/DMK - COMPLETE DISPOSITION ;1/22/2015
 ;;3.5;FEE BASIS;**108,154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
ASK S DIC="^FB7078(",DIC(0)="AEQMZ",D="D",DIC("A")="Select Veteran: ",DIC("S")="I $P(^(0),U,9)=""I""" D IX^DIC G END:$E(X)="^"!(X=""),ASK:Y<0 S (DA,FBAA78)=+Y,FBTYPE=6,FB(0)=Y(0),FBDXS="",FBFRDT=$P(FB(0),"^",4) K DIC("S"),D
EN S DIR(0)="162.4,4",DIR("A")="AUTHORIZATION TO DATE" D ^DIR
 G END:$D(DUOUT)!$D(DTOUT),END:+Y'>0 S FBTODT=+Y K DIR,X,Y
 I FBTODT]"",FBFRDT>FBTODT W !!,*7,?5,"Authorization To Date must be after Authorization From Date!",! G EN
 S DIR(0)="162.4,4.5",DIR("A")="DATE OF DISCHARGE" D ^DIR K DIR
 G END:$D(DUOUT)!$D(DTOUT),END:+Y'>0 S FBDOD=+Y K X,Y
 I FBDOD]"",FBTODT>FBDOD W !!,*7,?5,"Date of Discharge must not be earlier than the Authorization To Date!",! G EN
 S FBVEN=$P(FB(0),"^",2),FBVET=$P(FB(0),"^",3),DIE=DIC,DR="4////^S X=FBTODT;S:X="""" (Y,FBTODT)="""";S FBTODT=X;4.5////^S X=FBDOD" D ^DIE G END:FBTODT=""
 D
 . N FBX
 . S FBX=$$ADDUA^FBUTL9(162.4,FBAA78_",","Complete 7078 authorization.")
 . I 'FBX W !,"Error adding record in User Audit. Please contact IRM."
ASKPT W ! S DIR(0)="SAO^00:SURGICAL;10:MEDICAL;86:PSYCHIATRY",DIR("A")="BEDSECTION/TREATING: ",DIR("?")="^D HELP^FBCH780" D ^DIR D NOUP:$D(DIRUT) G ASKPT:$D(DIRUT) S FBPT=Y K X,Y,DIRUT,DIR G AUTH^FBCH78
EDIT ;ENTRY TO EDIT A COMPLETED DISPOSITION
 S FBEDAT=0
 S DIC="^FB7078(",DIC(0)="AEMQZ",D="D",DIC("A")="Select Patient: ",DIC("S")="I $P(^(0),U,9)=""C""&($P(^(0),U,11)=6)" D IX^DIC G END:X="^"!(X=""),EDIT:Y<0 S FB7078=+Y,FBVET=$P(Y(0),"^",3),FBHTDT=$P(Y(0),"^",5),FBHFDT=$P(Y(0),"^",4)
 G END:'$D(^FBAAA("AG",FB7078_";FB7078("))
 D
 . N FBX
 . S FBX=$$ADDUA^FBUTL9(162.4,FB7078_",","Edit 7078 authorization.")
 . I 'FBX W !,"Error adding record in User Audit. Please contact IRM."
 I $D(^FBAAI("E",FB7078_";FB7078(")) S FBEDAT=1 W !!,*7,"Payment already exists for this disposition, editing of dates not allowed!",!
 I 'FBEDAT S DA=$O(^FBAA(162.2,"AM",+FB7078,0)) I DA]"" S DIE="^FBAA(162.2,",DR="4;S FBFRDT=(X\1)",DIE("NO^")="" D ^DIE K DIE,DR
 I 'FBEDAT,(DA']"") G END
 I 'FBEDAT,$G(FBFRDT) S DIE="^FB7078(",DA=+FB7078,DR=$S(FBHFDT'=FBFRDT:"3///^S X=FBFRDT;I 1;",1:"")_"4;S FBTODT=X",DIE("NO^")="" D ^DIE K DIE,DR
 G END:+$G(FBTODT)'>0,END:'$G(FBFRDT)
 I 'FBEDAT,(FBHTDT'=FBTODT),(FBTODT>$P(^FB7078(+FB7078,0),"^",16)) W !!,*7,"Date of Discharge must now be edited to be equal to or later than",!,"the Authorization To Date.",! S FBDR="4.5////^S X=FBTODT;I 1;"
 I 'FBEDAT S FBDR=$G(FBDR)_"4.5;"
 S FBTYPE=6,DIE="^FB7078(",DA=+FB7078,DR=$S($G(FBDR):FBDR,1:"")_"7///^S X=""@"";5ADMITTING AUTHORITY~",DIE("NO^")="" D ^DIE K DIC,DIE,D,DR,DA,FBDR
 S DA(1)=FBVET,DIC="^FBAAA("_FBVET_",1,",DIC(0)="EQM",DA=$O(^FBAAA("AG",FB7078_";FB7078(",FBVET,0))
 S DR=$S(FBEDAT'=1:".01////^S X=FBFRDT;",1:"")_$S(FBEDAT'=1:".02////^S X=FBTODT;",1:"")
 ; FB*3.5*108 edit contract
 I $$EDCNTRA^FBUTL7(DA(1),DA) S DR=DR_"105;"
 S DR=DR_".06;D DEFPTC^FBCHCD;.065///^S X=FBPT;.07;.021;.096;.097//^S X=""NO"""
 S DR(1,161.01,1)="I $D(^FBAAA(FBVET,1,DA,2,0)) S ^FB7078(FB7078,1,0)=^(0) F FBI=1:1 Q:'$D(^FBAAA(FBVET,1,DA,2,FBI,0))  I $D(^(0)) S ^FB7078(FB7078,1,FBI,0)=^(0);101",DIE=DIC,DIE("NO^")="" W ! D ^DIE K DIE,DR,DIC
 W !! G EDIT
END K DIC,DIE,DA,DR,FB,FBPROG,FBAAOUT,FBSW,FBVET,FB7078,FBHTDT,FBTODT,FBTYPE,FBAA78,FBFRDT,FBVEN,K,PTYPE,X,Y,Z,FBDEF,FBPT,FBI,FBHFDT,J,FBZZ,FBDA,FBDFN,FBDXS,FBNAME,FBSSN,FBZZ,ZZZ,FBDOD,FBEDAT
 Q
DEFPTC S FBDEF=$P(^FBAAA(FBVET,1,DA,0),U,18),FBDEF=$S(FBDEF="00":"SURGICAL",FBDEF=10:"MEDICAL",FBDEF=86:"PSYCHIATRY",1:"")
 N X,DP,Y,DQ S DIR(0)="SA^00:SURGICAL;10:MEDICAL;86:PSYCHIATRY",DIR("A")="BEDSECTION/TREATING SPECIALTY: ",DIR("?")="^D HELP^FBCH780",DIR("B")=FBDEF D ^DIR D NOUP:$D(DUOUT) G DEFPTC:$D(DIRUT) S FBPT=Y K DIR,DIRUT Q
NOUP W !!,*7,?5,"This is a mandatory response. Entering an '^' is not allowed!",! D HELP^FBCH780 Q
