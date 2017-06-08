GMRQCON ;ISC-SLC/MJC;CONV FOR MISSING SIGNED ON CHART;05/02/94  4:56 PM
V ;;2.5;Progress Notes;**21**;Jan 08,1993
 I '$D(^GMR(121,0)) W $C(7),$C(7),!,"I think you're in the wrong UCI!",!?16,"-or-",!,"You don't have Progress Notes v2.5 installed yet!",!! G EXIT1
 S U="^" I $S('($D(DUZ)#2):1,'$D(^VA(200,DUZ,0)):1,1:0) D  G EXIT1
 .W !!,"Your DUZ is "_$S($D(DUZ):"incorrectly set",1:"not set")_", the CONVERSION has not run!!" Q
 I $S('$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) D  G EXIT1
 .W !!,"DUZ(0) needs to be set to ""@"", the CONVERSION has not run!!" Q
DEV S %ZIS="MQ" D ^%ZIS G:POP EXIT1
 I $E(IOST,1,2)["C-" W !!,$C(7),"You must send your output to a printer!!",!! G DEV
 I $D(IO("Q")) S ZTIO=ION,ZTRTN="CON^GMRQCON",ZTDESC="GMRP*2.5*21 conversion" D ^%ZTLOAD G EXIT1
CON U IO W !!?10,"GMRP*2.5*21 CONVERSION REPORT",!?10,"-----------------------------"
 D NOW^%DTC S Y=% X ^DD("DD") W !!,"Conversion started at: "_Y
 S (GMRPIEN,CTR)=0 F  S GMRPIEN=$O(^GMR(121,GMRPIEN)) G EXIT:'GMRPIEN D
 .I +$P($G(^GMR(121,GMRPIEN,1)),U,3)&'+$P($G(^(1)),U,4) D  Q
 ..W !!,"Problem Entry: ^GMR(121,"_GMRPIEN_",1) = "_^GMR(121,GMRPIEN,1)
 ..S $P(^GMR(121,GMRPIEN,1),U,4)=$P(^GMR(121,GMRPIEN,0),U,3)
 ..S $P(^GMR(121,GMRPIEN,1),U,5)=$P(^GMR(121,GMRPIEN,0),U,5)
 ..W !," Corrected To: ^GMR(121,"_GMRPIEN_",1) = "_^GMR(121,GMRPIEN,1)
 ..S CTR=CTR+1 Q
EXIT W:CTR>0 !!,"The conversion has corrected "_CTR_$S(CTR=1:" entry.",1:" entries.")
 W:CTR=0 !!,"The conversion ran to completion- No problems found."
 D NOW^%DTC S Y=% X ^DD("DD") W !!,"Conversion completed at: "_Y,@IOF
EXIT1 D ^%ZISC K GMRPIEN,CTR Q
