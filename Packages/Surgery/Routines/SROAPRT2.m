SROAPRT2 ;BIR/MAM - PRINT PREOP INFO (PAGE 2); JULY 19, 2011
 ;;3.0;Surgery;**38,125,137,153,160,166,176,182,184,213**;24 Jun 93;Build 1
 I $E(IOST)'="P" W !,?28,"PREOPERATIVE INFORMATION"
 N SRX,Y F I=200,200.1,206,210,204 S SRA(I)=$G(^SRF(SRTN,I))
 S Y=$P(SRA(200),"^",37),SRX=243,SRAO(1)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",38),SRX=328,SRAO("1A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",39),SRX=211,SRAO("1B")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",18),SRX=210,SRAO(2)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",44),SRX=245,SRAO(3)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",19),SRX=332,SRAO("2A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",21),SRX=333,SRAO("2B")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",24),SRX=400,SRAO("2C")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",13),SRX=521,SRAO("2D")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",14),SRX=522,SRAO("2E")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",29),SRX=401,SRAO("2F")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(210),"^"),SRX=662,SRAO("2G")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",45),SRX=338,SRAO("3A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",46),SRX=218,SRAO("3B")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",47),SRX=339,SRAO("3C")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",48),SRX=215,SRAO("3D")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",49),SRX=216,SRAO("3E")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",58),SRX=642,SRAO("3EE")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",50),SRX=217,SRAO("3F")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(204),"^",17),SRX=338.3,SRAO("3G")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",4),SRX=338.2,SRAO("3H")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",8),SRX=218.1,SRAO("3I")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",3),SRX=269,SRAO("3J")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(210),"^",8),SRX=673,SRAO("3K")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(210),"^",9),SRX=674,SRAO("3L")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(210),"^",12) S SRX=677,SRAO("3M")=Y_"^"_SRX
 ;
 W !!,"RENAL:",?31,$P(SRAO(1),"^"),?40,"NUTRITIONAL/IMMUNE/OTHER:",?72,$P(SRAO(3),"^")
 W !,"Acute Renal Failure:",?25,$P(SRAO("1A"),"^"),?40,"Disseminated Cancer:",?72,$P(SRAO("3A"),"^")
 W !,"Currently on Dialysis:",?25,$P(SRAO("1B"),"^"),?40,"Open Wound:",?72,$P(SRAO("3B"),"^")
 W !,?40,"Steroid Use for Chronic Cond.:",?72,$P(SRAO("3C"),"^")
 W !,"CENTRAL NERVOUS SYSTEM:",?31,$P(SRAO(2),"^"),?40,"Weight Loss > 10%:",?72,$P(SRAO("3D"),"^")
 W !,"Impaired Sensorium: ",?25,$P(SRAO("2A"),"^"),?40,"Bleeding Disorders:",?72,$P(SRAO("3E"),"^")
 W !,?40,"Bleeding Due To Med: ",?(79-$L($P(SRAO("3EE"),"^"))),$E($P(SRAO("3EE"),"^"),1,18)
 W !,"Coma:",?25,$P(SRAO("2B"),"^"),?40,"Transfusion > 4 RBC Units:",?72,$P(SRAO("3F"),"^")
 W !,"Hemiplegia:",?25,$P(SRAO("2C"),"^"),?40,"Chemo for Malig Last 90 Days: ",?(79-$L($P(SRAO("3G"),"^"))),$E($P(SRAO("3G"),"^"),1,10)
 W !,"CVD Repair/Obstruct:",?(35-$L($P(SRAO("2D"),"^"))),$P(SRAO("2D"),"^"),?40,"Radiotherapy W/I 90 Days:",?72,$P(SRAO("3H"),"^")
 W !,"History of CVD:",?(35-$L($P(SRAO("2E"),"^"))),$P(SRAO("2E"),"^"),?40,"Preoperative Sepsis:",?(79-$L($P(SRAO("3I"),"^"))),$P(SRAO("3I"),"^")
 W !,"Tumor Involving CNS:",?25,$P(SRAO("2F"),"^"),?40,"Pregnancy:",?(79-$L($P(SRAO("3J"),"^"))),$P(SRAO("3J"),"^")
 W !,"Impaired Cognitive Function: ",?(39-$L($P(SRAO("2G"),"^"))),$E($P(SRAO("2G"),"^"),1,9),?40,"History of Cancer:",?72,$P(SRAO("3K"),"^")
 W !,?40,"History of Radiation Therapy:",?72,$P(SRAO("3L"),"^")
 W !,?40,"Prior Surg in Same Operative:",?72,$P(SRAO("3M"),"^")
 I $E(IOST)="P" W !
 Q
OUT(SRFLD,SRY) ; get data in output form
 N C,Y
 I SRFLD=521 S Y=$S(SRY=1:"YES/NO SURG",SRY=2:"YES/PRIOR SURG",SRY=0:"NO CVD",1:"") Q Y
 I SRFLD=522 S Y=$S(SRY=1:"HIST OF TIA'S",SRY=2:"CVA W/O NEURO DEF",SRY=3:"CVA W/ NEURO DEF",SRY=0:"NO CVD",1:"") Q Y
 S Y=SRY,C=$P(^DD(130,SRFLD,0),"^",2) D:Y'="" Y^DIQ
 I Y="NO STUDY" S Y="NS"
 Q Y
