DGPM5MT ;ALB/MRL/MIR - TEST MOVEMENT OF PATIENTS; 03 JAN 89
 ;;MAS VERSION 5.0;
P W !! D VAR^DGPM5MV0 I ERR H 8 G Q
 S DIC(0)="AEQMZ",DIC="^DPT(",DIC("A")="Move data for PATIENT: " D ^DIC G Q:Y'>0 S DFN=+Y I '$O(^DPT(DFN,"DA",0)) W !?4,*7,"Patient has no admissions on file to move.",! G P
 S PAT=DFN D DEM^VADPT W !!,"Moving admission data into new structure for '",VADM(1),"'..." K VADM D KILL,GO,SP^DGPM5MV,DN S DFN=PAT K PAT
 S DGPGM="SHOW^DGPM5MT",DGVAR="DUZ^DFN" D ZIS^DGUTQ G Q:POP
SHOW W @IOF,!,"OLD FORMAT",!,"----------",! S DGPMA=0 F DGPM=0:0 S DGPMA=$O(^DPT(DFN,"DA",DGPMA)) Q:DGPMA'>0  S DIC="^DPT("_DFN_",""DA"",",DA(1)=DFN,DA=DGPMA F DGPM1=0,4,1,2,"T" K S W:$Y>$S($D(IOSL):(IOSL-5),1:19) @IOF S DR=DGPM1 D EN^DIQ
 W @IOF,!,"NEW FORMAT",!,"----------",! S DGPMA=0 F DGPM=0:0 S DGPMA=$O(^DGPM(DGPMA)) Q:DGPMA'>0  S DIC="^DGPM(",DA=DGPMA F DGPM1=0,"DX" K S W:$Y>$S($D(IOSL):(IOSL-5),1:19) @IOF S DR=DGPM1 D EN^DIQ
Q K DIC,DGPGM,DGVAR,DGPMA,DGPM,DA,DR,DFN D CLOSE^DGUTQ Q
 ;
GO S DGPMM("S")=$H Q
 ;
DN Q:'$D(DGPMM("S"))#2  S DGPMM("E")=$H,X=$P(DGPMM("S"),",",2),X1=$P(DGPMM("E"),",",2)
 I +DGPMM("S")=+DGPMM("E") S DGPMM("T")=X1-X
 E  S DGPMM("T")=(5184000-X)+X1
 W !,"...Completed in ",+DGPMM("T")," second",$E("s",DGPMM("T")>1),"...",*7 K DGPMM Q
KILL F I=0:0 S I=$O(^DGPM(I)) Q:I=""  K ^DGPM(I)
 S $P(^DGPM(0),"^",3,4)="^" Q
