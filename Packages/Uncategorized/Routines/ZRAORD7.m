ZRAORD7 ;AISC/RMO-Log Report of Scheduled Requests by Procedure ;1/29/93  13:40 [ 09/30/94  9:00 AM ]
 ;;4.0;RADIOLOGY;**16,24**;FEB 24, 1992
 ; This has been modified to get the .1 node in DPT if there and set iit to RACL. 
 ; If RACL is null the current location will print as O.P.
 S %DT("A")="Scheduled Request Log Date: ",%DT="EXA" W ! D ^%DT K %DT G Q:Y<0 S RALDTE=Y
 D OMA G Q:'RALOC&('$O(RALOC(0)))
 S ZTRTN="START^ZRAORD7",ZTSAVE("RALDTE")="",ZTSAVE("RALOC(")="" W ! D ZIS^RAUTL G Q:POP
 ;
START U IO K ^TMP($J,"RAORD7") S RAPGE=0,$P(RALNE,"-",79)="",$P(RALNE1,"=",79)="",(RAX,RAHI)="",RABEGDT=RALDTE-.0001,RAENDDT=RALDTE+.9999
 S Y=RALDTE D D^RAUTL S RALDTE=Y,X="NOW",%DT="T" D ^%DT D D^RAUTL S RARUNDTE=Y
 F RAOSCH=RABEGDT:0 S RAOSCH=$O(^RAO(75.1,"AD",RAOSCH)) Q:'RAOSCH!(RAOSCH>RAENDDT)  S RADFN=0 F  S RADFN=$O(^RAO(75.1,"AD",RAOSCH,RADFN)) Q:'RADFN  D
 .S RAOIFN=0 F  S RAOIFN=$O(^RAO(75.1,"AD",RAOSCH,RADFN,RAOIFN)) Q:'RAOIFN  I $D(^RAO(75.1,RAOIFN,0)),$P(^(0),"^",5)=8 S RAORD0=^(0) D
 ..S RAPRI=+$P(RAORD0,"^",2) D  S RACPT=$S($P($G(^RAMIS(71,RAPRI,0)),U)]"":$E($P(^(0),U),1,21),1:"UNKNOWN")
 ...S RAI=0,RAI=$O(^RAMIS(71,RAPRI,2,RAI)) Q:'RAI  S RAMIS=+$G(^(RAI,0))
 ..S ^TMP($J,"RAORD7",$S($P(RAORD0,"^",20):$P(RAORD0,"^",20),1:$O(^RA(79.1,0))),RAMIS,RAOSCH,RACPT,RADFN,RAOIFN)=""
 I '$D(^TMP($J,"RAORD7")) W !!?5,"There are no scheduled requests logged for ",RALDTE,"." G Q
 S (RAI,RAJ,RAOSCH)=0 F  S RAI=$O(^TMP($J,"RAORD7",RAI)) Q:'RAI!(RAX["^")  I $D(RALOC(RAI)) F  S RAJ=$O(^TMP($J,"RAORD7",RAI,RAJ)) Q:'RAJ!(RAX["^")  D
 .F  S RAOSCH=$O(^TMP($J,"RAORD7",RAI,RAJ,RAOSCH)) Q:'RAOSCH!(RAX["^")  D
 ..S RAPRC="" F  S RAPRC=$O(^TMP($J,"RAORD7",RAI,RAJ,RAOSCH,RAPRC)) Q:RAPRC=""!(RAX["^")  W:RAPGE !,RALNE1 D
 ...S (RADFN,RAOIFN)=0 F  S RADFN=$O(^TMP($J,"RAORD7",RAI,RAJ,RAOSCH,RAPRC,RADFN)) Q:'RADFN!(RAX["^")  F  S RAOIFN=$O(^(RADFN,RAOIFN)) Q:'RAOIFN!(RAX["^")  S RAORD0=$G(^RAO(75.1,RAOIFN,0)) D
 ....D HD:($Y+4)>IOSL!('RAPGE)!(RAI'=RAHI) Q:RAX["^"  S RANME=$P($G(^DPT(RADFN,0)),"^")
 ....S RACL=$S($D(^DPT(RADFN,.1)):$P(^(.1),"^"),1:"")
 ....S RAI=RAHI,RALOC=$S($D(^SC(+$P(RAORD0,"^",22),0)):$P(^(0),"^"),1:"UNKNOWN"),Y=RAOSCH D D^RAUTL S RATIME=$P($P(Y,",",2),"  ",2),RAOURG=$P(RAORD0,"^",6)
 ....W !,$E(RANME,1,17),?18,$E(RAPRC,1,12),?33,$$SSN^RAUTL(RADFN,1),?43,$E(RALOC,1,7),?55,$S(RACL'="":RACL,1:"O.P."),?64,RATIME
 ....S C=$P(^DD(75.1,6,0),U,2),Y=RAOURG D Y^DIQ W ?71,$E(Y,1,7),!!
 ;
Q K ^TMP($J,"RAORD7"),POP,RABEGDT,RACPT,RADFN,RADPT0,RAENDDT,RAI,RAHI,RAJ,RALDTE,RALNE,RALNE1,RALOC,RACL,RAMIS,RANME,RAOIFN,RAORD0,RAOSCH,RAOURG,RAPGE,RAPRC,RAPRI,RARUNDTE,RASSN,RATIME,RAX,X,Y
 K RAMES,ZTDESC,ZTRTN,ZTSAVE,C
 W ! D CLOSE^RAUTL
 Q
 ;
HD D CRCHK Q:RAX["^"  W:RAPGE!($E(IOST,1,2)="C-") @IOF W !,"Scheduled Request Log for ",RALDTE," by Location" S RAPGE=RAPGE+1
 W ?70,"Page: ",RAPGE,!,"Run Date: ",RARUNDTE,?35,"Location: ",$S($D(^SC(+$P($G(^RA(79.1,+RAI,0)),"^"),0)):$P(^(0),"^"),1:"UNKNOWN")
 W !!,"Patient",?18,"Procedure",?33,"Pt ID",?43,"Requested",?55,"Current",?64,"Time",?71,"Urgency",!,RALNE
 S RAHI=RAI Q
 ;
CRCHK I RAPGE,$E(IOST)="C" W !!,*7,"Press RETURN to continue or '^' to stop " R X:DTIME S RAX=X
 Q
 ;
OMA ;ask for One/Many/All locations for output
 ;each location will be printed seperately
 ;array returned will be RALOC(ien of 79.1)=IEN in 44
 ;
 N I
 S DIC="^RA(79.1,",VAUTSTR="Location to print",VAUTNI=2,VAUTVB="RALOC" D FIRST^VAUTOMA I 'RALOC&('$O(RALOC(0))) Q
 I RALOC D  G Q:'$D(RALOC)
 . S I=0 F  S I=$O(^RA(79.1,I)) Q:'I  S RALOC(I)=$P($G(^RA(79.1,I,0)),U)
 Q
