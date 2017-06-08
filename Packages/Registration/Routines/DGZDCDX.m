DGZDCDX ;FIND ORPHAN DISCHARGES
 ;;Version 1;;
 ;
EN ; -- entry pt to run diagnostic
 S IOP="HOME" D ^%ZIS K IOP W @IOF D HD
 S %ZIS="Q" D ^%ZIS K %ZIS G ENQ:POP
 I IO'=IO(0) S ZTRTN="START^DGZDCDX",ZTION=ION D ^%ZTLOAD G ENQ
START D INIT U IO W @IOF D HD
 F DGDT=0:0 S DGDT=$O(^DGPM("ATT3",DGDT)) Q:'DGDT  F DGMVT=0:0 S DGMVT=$O(^DGPM("ATT3",DGDT,DGMVT)) Q:'DGMVT  D CHK
 W !!,"Number of Problem Discharge Movements Found: ",BAD
ENQ K DGDT,DCDT,ADDT,PAT,Y,%DT,CNT,DGMVT,AD,DC,LINK,DASH D ^%ZISC Q
 ;
CHK ; -- check mvt
 S CNT=CNT+1 W:'(CNT#10) "."
 G CHKQ:'$D(^DGPM(DGMVT,0)) S DC=^(0)
 G CHKQ:'$D(^DGPM(+$P(DC,"^",14),0)) S AD=^(0)
 S LINK=$P(AD,"^",17),LINK=$S('LINK:1,DGMVT'=LINK:2,1:0)
 I LINK D PRT S BAD=BAD+1 S BAD(DGMVT)=LINK
CHKQ Q
 ;
HD ; -- header
 W !,"Discharge Movement Integrity Checker..."
 Q
 ;
PRT ; -- print bad mvt
 S Y=+AD X ^DD("DD") S ADDT=Y
 S Y=+DC X ^DD("DD") S DCDT=Y
 S PAT=$G(^DPT(+$P(DC,"^",3),0))
 W !,"Name",?25,"SSN",?40,"Admission",?60,"Discharge"
 W !,"----",?25,"---",?40,"---------",?60,"---------"
 W !,$E($P(PAT,"^"),1,20),?25,$P(PAT,"^",9),?40,ADDT,?60,DCDT
 W !?40,"#",+$P(DC,"^",14),?60,"#",DGMVT
 W:LINK=1 !?5,"ERROR: Admission is not linked to a discharge movement."
 ;
 W:LINK=2 !?5,"ERROR: Admission is linked to a different discharge movement(#",$P(AD,"^",17),")."
 ;
 W !,DASH
 Q
 ;
INIT ;
 K BAD,DASH S $P(DASH,"=",80)="",(BAD,CNT)=0
 Q
 ;
 ;The BAD() array is left defined after this report
 ;has finished. It will contain the following:
 ;    BAD(<movement# of orphan d/c>)= <1|2>
 ;                                      1 := adm is not linked
 ;                                           to any d/c movement
 ;                                      2 := adm is linked to
 ;                                           another d/c movement
