RJPTFER3 ;RJ WILM DE; CHECK SURGICAL PROCEDURES; OCT 21 86
 ;;4.0
 S (RJPFLAG1,K)=0 F K=0:0 S K=$O(^DGPT(I,"S",K)) Q:K=""!(K'?.N)  D 1
 I RJPFLAG W ! D ^RJPTFESP
 I RJPFLAG1 S RJPFLAG=1
 K RJPFLAG1,DIC,DIE,DA Q
1 S RJPTF=^DGPT(I,"S",K,0),Z=$P(RJPTF,"^",2) I Z="P" G P
 I Z="" W !?10,"...Surgical Procedure is not defined as a Surgery or Procedure." S RJPFLAG=1 G P1
 I $P(RJPTF,"^",1)="" W !?10,"...No DATE for this Surgery." S RJPFLAG=1
 I $P(RJPTF,"^",3)="" W !?10,"...No SURGICAL SPECIALTY." S RJPFLAG=1
 I $P(RJPTF,"^",4)="" W !?10,"...No CATEGORY OF CHIEF SURGEON." S RJPFLAG=1
 I $P(RJPTF,"^",5)="" W !?10,"...No CATEGORY OF FIRST ASSISTANT." S RJPFLAG=1
 I $P(RJPTF,"^",6)="" W !?10,"...No ANESTESIA TECHNIQUE." S RJPFLAG=1
P ;I '$D(^DGPT(I,"S",K,460000)) W !?10,"...No ATTENDING PHYSICIAN NAME." S RJPFLAG=1 G P2
 ;S Z=$P(^(460000),"^",1) I Z="" W !?10,"...No ATTENDING PHYSICIAN NAME." S RJPFLAG=1 G P2
 ;I '$D(^DIC(6,Z,0)) W !?10,"...No PHYSICIAN in the PERSON File.  Use Filemanager to enter it." S RJPFLAG=1 G P2
 ;I $P(^DIC(16,Z,0),"^",9)="" W !?10,"...No SSN in the PERSON File.  Physician: ",$P(^DIC(16,Z,0),"^",1) S RJPFLAG1=1,(DIC,DIE)="^DIC(16,",DA=Z,DR="8;" D ^DIE
P2 I $P(RJPTF,"^",8)="" W !?10,"...surgeries/procedures are not in order or not defined." S RJPFLAG=1
P1 I RJPFLAG W !,"SURGICAL PROCEDURE #",K," MAY NOT HAVE ALL ITS DATA.  YOU MUST ENTER IT IN",!,"BEFORE I CAN CODE IT!",!
 Q
