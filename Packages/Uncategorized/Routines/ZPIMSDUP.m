ZPIMSDUP ;Duplicate encounter ;10/8/97  09:51 [2/3/99 2:18pm]
 ;
 ;  This routine will search through the outpatient encounter
 ;  file.  It will take the first two at the same date and time
 ;  and compare the data to see if they are duplicates.  The
 ;  duplicate means that they have the same date/time of
 ;  encounter, same patient, same clinic stop code, same location,
 ;  same unique visit ID.  One has to be checked out and the other
 ;  has to be action required.  They both have to be parent encounters.
 ;
 ;  If you answer yes to FIX it will delete the encounter that
 ;  was action required.
 ;
EN ;ask for dates
 ;
 S %DT="AEP",%DT("A")="Start Date: " D ^%DT S START=Y W ! K %DT,Y,X
 I (START<1)!($D(DTOUT)) G ENQ
 S %DT="AEP",%DT("A")="End Date: " D ^%DT S END=Y K %DT,Y,X
 I (END<1)!($D(DTOUT)) G ENQ
 I START>END W !,"End date cannot be greater than start date." G EN
 S DIR("A")="Want to delete duplicates"
 S DIR("A",1)="Saying no will display the global duplicates, but doesn't delete them."
 S DIR(0)="Y",DIR("B")="NO" D ^DIR G ENQ:$D(DIRUT) S FIX=+Y
 K ^TMP("CAW",$J)
 S I=START F  S I=$O(^SCE("B",I)) Q:'I!(I>END)  K ^TMP("CAW",$J) D
 .S D=0,NUM=0
 .F  S D=$O(^SCE("B",I,D)) Q:'D  S NUM=NUM+1,^TMP("CAW",$J,NUM)=^SCE(D,0),$P(^TMP("CAW",$J,NUM),U,50)=D D:NUM>1 COMPARE
ENQ K DIR,START,END,I,D,DA,CNT,FIX,FST,NUM,SND,^TMP("CAW",$J) Q
 ;
COMPARE ;
 S (NUM,CNT)=1
 S FST=$G(^TMP("CAW",$J,1)),SND=$G(^TMP("CAW",$J,2))
 I $P(FST,U)=$P(SND,U) S CNT=CNT+1 ; same date/time
 I $P(FST,U,2)=$P(SND,U,2) S CNT=CNT+1 ; same patient
 I $P(FST,U,3)=$P(SND,U,3) S CNT=CNT+1 ; same clinic stop
 I $P(FST,U,4)=$P(SND,U,4) S CNT=CNT+1 ; same clinic
 I $P(FST,U,6)=$P(SND,U,6) S CNT=CNT+1 ; both parent encounters
 I $P(FST,U,12)'=$P(SND,U,12) S CNT=CNT+1 ; one checked out, one not
 S ^TMP("CAW",$J,1)=SND
 I CNT>6 W !,FST,!,SND,! I FIX D
 .I $P(FST,U,12)=14 S DA=$P(FST,U,50),DIK="^SCE(" D ^DIK K DA,DIK
 .I $P(SND,U,12)=14 S DA=$P(SND,U,50),DIK="^SCE(" D ^DIK K DA,DIK
COMPAREQ Q
