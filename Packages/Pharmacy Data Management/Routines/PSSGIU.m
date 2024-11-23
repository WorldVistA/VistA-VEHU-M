PSSGIU ;BIR/CML-GENERIC "APPLICATION PACKAGES' USE" SET; Jun 04, 2024@14:00
 ;;1.0;PHARMACY DATA MANAGEMENT;**266**;9/30/97;Build 3
 ;
EN ;
 Q:$S('$D(PSIUDA):1,'$D(PSIUX):1,PSIUX'?1E1"^"1.E:1,1:'$D(^PSDRUG(PSIUDA,0)))  S PSIUO=$P($G(^(2)),"^",3) S PSIUT=$P(PSIUX,"^",2),PSIUT=$S($E(PSIUT,1,4)="UNIT":"",1:$E("N","AEIOU"[$E(PSIUT)))_" "_PSIUT,(%,PSIUQ)=PSIUO'[$E(PSIUX)+1
 F  W !!,"A",PSIUT," ITEM" D YN^DICN Q:%  D MQ S %=PSIUQ
 I %<0 S PSIUA="^" G DONE
 S PSIUA=$E("YN",%) G:%=PSIUQ DONE I %=1 S PSIUY=PSIUO_$P(PSIUX,"^"),$P(^PSDRUG(PSIUDA,2),"^",3)=PSIUY I $P(^(0),"^")]"" S ^PSDRUG("AIU"_$P(PSIUX,"^"),$P(^(0),"^"),PSIUDA)=""
 I %=2 D CMOP S PSIUY=$P(PSIUO,$P(PSIUX,"^"))_$P(PSIUO,$P(PSIUX,"^"),2),$P(^PSDRUG(PSIUDA,2),"^",3)=PSIUY I $P(^(0),"^")]"" K ^PSDRUG("AIU"_$P(PSIUX,"^"),$P(^(0),"^"),PSIUDA)
 K:PSIUO]"" ^PSDRUG("IU",PSIUO,PSIUDA) S:PSIUY]"" ^PSDRUG("IU",PSIUY,PSIUDA)=""
 ;
DONE ;
 K PSIU,PSIUO,PSIUQ,PSIUT,PSIUY Q
 ;
MQ ;
 S X="Enter 'YES' (or 'Y') to mark this drug as a"_$S($E(PSIUT,1,2)="N ":"n"_$E(PSIUT,2,99),1:PSIUT)_" item.  Enter 'NO' (or 'N') to not mark (or unmark) this drug."
 W !!?2 F PSIU=1:1:$L(X," ") S Y=$P(X," ",PSIU) W:$X+$L(Y)>79 ! W Y," "
 Q
CMOP I PSIUX="O^Outpatient Pharmacy",$P($G(^PSDRUG(PSIUDA,3)),"^",1)=1 W !,"This item has just been UNMARKED for CMOP transmission.",! S $P(^PSDRUG(PSIUDA,3),"^")=0 K ^PSDRUG("AQ",PSIUDA) S DA=PSIUDA N % D ^PSSREF
 Q
 ;
ENS ;
 Q:$S('$D(PSIUDA):1,'$D(PSIUX):1,'PSIUDA:1,$L($P(PSIUX,"^"))'=1:1,1:'$D(^PSDRUG(PSIUDA,0)))  S PSIU=$P(^(0),"^"),(PSIUO,PSIUY)=$P($G(^(2)),"^",3),PSIUT=$P(PSIUX,"^")
 I PSIUY'[PSIUT S PSIUY=PSIUY_PSIUT,$P(^PSDRUG(PSIUDA,2),"^",3)=PSIUY K:PSIUO]"" ^PSDRUG("IU",PSIUO,PSIUDA)
 S ^PSDRUG("IU",PSIUY,PSIUDA)="" I PSIU]"" S ^PSDRUG("AIU"_PSIUT,PSIU,PSIUDA)=""
 ;PSS*1.0*266: Update CPRS orderable item list
 N PSGOI
 S PSGOI=$$GET1^DIQ(50,PSIUDA,2.1,"I")
 Q:'PSGOI
 D EN2^PSSHL1(PSGOI,"MUP")
 G DONE
 ;
END ;
 Q:$S('$D(PSIUDA):1,'$D(PSIUX):1,'PSIUDA:1,$L($P(PSIUX,"^"))'=1:1,1:'$D(^PSDRUG(PSIUDA,0)))  S PSIU=$P(^(0),"^"),(PSIUO,PSIUY)=$P($G(^(2)),"^",3),PSIUT=$P(PSIUX,"^")
 I PSIUY[PSIUT S PSIUY=$P(PSIUY,PSIUT)_$P(PSIUY,PSIUT,2),$P(^PSDRUG(PSIUDA,2),"^",3)=PSIUY K ^PSDRUG("IU",PSIUO,PSIUDA)
 S:PSIUY]"" ^PSDRUG("IU",PSIUY,PSIUDA)="" I PSIU]"" K ^PSDRUG("AIU"_PSIUT,PSIU,PSIUDA)
 ;PSS*1.0*266: Update CPRS orderable item list
 N PSGOI
 S PSGOI=$$GET1^DIQ(50,PSIUDA,2.1,"I")
 Q:'PSGOI
 D EN2^PSSHL1(PSGOI,"MUP")
 G DONE
 ;
 ;PSS*1.0*266 begin - copied from PSGFILD3
ENIU ; mark/unmark drugs for Unit Dose use
 N DIR,DTOUT,DUOUT,DIROUT,DIRUT,DIC,X,Y,PSIUDA,PSIUX,PSGS,PSGY
 S DIR(0)="SAO^M:MARK FOR UNIT DOSE;U:UNMARK FOR UNIT DOSE"
 S DIR("A")="Do you want to (M)ARK or (U)NMARK items for Unit Dose? "
 S DIR("B")="UNMARK",DIR("?")="^D ENIUH^PSSGIU"
 W ! D ^DIR
 I Y'="U",Y'="M" Q
 S PSGY=Y,PSGS="I $P($G(^(2)),""^"",3)"_$E("'",PSGY="M")_"[""U""",PSIUX="U"
 S DIC="^PSDRUG(",DIC(0)="QEAM",DIC("A")="Select DRUG: ",DIC("S")=PSGS
 F  W ! D ^DIC Q:Y'>0  D
 . S PSIUDA=+Y
 . D:PSGY="U" END
 . D:PSGY="M" ENS
 . W "..."
 . W:PSGY="U" "UN" W "MARKED..."
 Q
 ;
ENIUH ;
 W !!?2,"Enter 'M' to mark items for use by the Unit Dose Medications package."
 W "  (You",!,"will only be shown items that have not been marked for Unit Dose.)"
 W !?2,"Enter 'U' to unmark items that have previously been marked for use with Unit"
 W !,"Dose.  (You will be shown only items that have already been marked for Unit",!,"Dose.)"
 W !!,"Choose from:",!?3,"M  MARK ITEMS FOR UNIT DOSE",!?3,"U  UNMARK ITEMS FOR UNIT DOSE"
 ;PSS*1.0*266 end
 Q
 ;
