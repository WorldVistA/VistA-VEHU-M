ECPROV4 ;BIR/MAM,JPW-Event Capture Provider Summary (cont'd) ;7 May 96
 ;;2.0; EVENT CAPTURE ;**5,8,18**;8 May 96
 ; This routine is used when printing the report for
 ; all DSS Units
 S %H=$H D YX^%DTC S ECRDT=Y
 I ECL D LOC,PRINT Q
 S ECL=0 F I=0:0 S ECL=$O(^ECH("ADT",ECL)) Q:'ECL  S ECLN=$P(^DIC(4,ECL,0),"^") D LOC
PRINT S (ECLN,ECPN,ECDN)=0,ECCN="" F I=0:0 S ECLN=$O(^TMP($J,ECLN)) Q:ECLN=""!(ECOUT)!(ECLN["^")  S ECDN="" D NOUNIT F I=0:0 S ECDN=$O(^TMP($J,ECLN,ECDN)) Q:ECDN=""!(ECOUT)  D CATS
 Q
CATS ; continue looping
 I $O(^TMP($J,ECLN,ECDN,""))']"" D PAGE W !!!,?12,"NO PROCEDURES",! S ECPG=1 Q
 D PAGE Q:ECOUT  S ECPG=1,ECUN=0 F I=0:0 S ECUN=$O(^TMP($J,ECLN,ECDN,ECUN)) Q:ECUN=""!(ECOUT)  S ECINZ="^"_$O(^(ECUN,0)) D:$Y+7>IOSL PAGE Q:ECOUT  D PRO
 Q
PRO I $Y+10>IOSL D PAGE I ECOUT Q
 W !!,ECUN S ECCN=0 F I=0:0 S ECCN=$O(^TMP($J,ECINZ,ECCN)) D:ECCN="" TOTP Q:ECCN=""!(ECOUT)  D MORE
 Q
MORE ;
 ;ALB/ESD - Loop through to get procedure reason and print
 W !,?5,ECCN S ECPN=0,ECPRSN=""
 F  S ECPN=$O(^TMP($J,ECINZ,ECCN,ECPN)) Q:ECPN=""!(ECOUT)  S ECUSER=1 D:$Y+7>IOSL PAGE Q:ECOUT  K ECUSER F  S ECPRSN=$O(^TMP($J,ECINZ,ECCN,ECPN,ECPRSN)) Q:ECPRSN=""!(ECOUT)  DO
 .S ECPNAM=$S($P(ECPN,";",3)="E":$P($G(^EC(725,+$P(ECPN,";",2),0)),"^"),$P(ECPN,";",3)="I":$P($G(^ICPT(+$P(ECPN,";",2),0)),"^",2),1:"UNKNOWN")
 .S ECCPT=$S($P(ECPN,";",3)="I":$P(ECPN,";",2),1:$P($G(^EC(725,$P(ECPN,";",2),0)),"^",5))
 .I ECCPT'="" S ECCPT=$$GET1^DIQ(81,ECCPT,.01,"E")
 .S ECPSY=$P(ECPN,";",4),ECPSYN=""
 .I ECPSY'="" S ECPSYN=$P($G(^ECJ(ECPSY,"PRO")),"^",2)
 .W !,?6,ECCPT," ",$E(ECPNAM,1,40) W:ECPSYN'="" " [",$E(ECPSYN,1,25),"]"
 .W:$D(ECRY) ?70,ECPRSN
 .W ?105,$J(^TMP($J,ECINZ,ECCN,ECPN,ECPRSN),6)
 .;print CPT procedure modifiers
 .S IEN=""
 .F  S IEN=$O(^TMP($J,ECINZ,ECCN,ECPN,ECPRSN,"MOD",IEN)) Q:IEN=""  D  I ECOUT Q
 ..S MOD=$$GET1^DIQ(81.3,IEN,.01,"E") I MOD="" Q
 ..S MODESC=$$GET1^DIQ(81.3,IEN,.02,"E") I MODESC="" S MODESC="UNKNOWN"
 ..S MODAMT=^TMP($J,ECINZ,ECCN,ECPN,ECPRSN,"MOD",IEN)
 ..W !?10,"- ",MOD," ",MODESC," (",MODAMT,")"
 ..I ($Y+3)>IOSL D PAGE
 .K MODESC,MOD,IEN,MODAMT
 Q
LOC S (ECDFN,ECOUT,^TMP($J,ECLN))=0
 F I=0:0 S ECDFN=$O(^ECH("ADT",ECL,ECDFN)) Q:'ECDFN  S ECD=0 F I=0:0 S ECD=$O(^ECH("ADT",ECL,ECDFN,ECD)) Q:'ECD  S MM=ECSD F I=0:0 S MM=$O(^ECH("ADT",ECL,ECDFN,ECD,MM)) Q:'MM!(MM>ECED)  D LOC1
 Q
LOC1 S ECFN=0 F I=0:0 S ECFN=$O(^ECH("ADT",ECL,ECDFN,ECD,MM,ECFN)) Q:'ECFN  D UTL
 Q
UTL ; set ^TMP($J,"ECPROV"
 Q:'$D(^ECH(+ECFN,0))!(+$G(ECD)'=$P($G(^ECH(+ECFN,0)),"^",7))
 S ECEC=^ECH(+ECFN,0),ECV=+$P(ECEC,"^",10),ECC=+$P(ECEC,"^",8),ECP=$P(ECEC,"^",9),ECCN=$S($P($G(^EC(726,ECC,0)),"^")]"":$P(^(0),"^"),1:"None")
 Q:ECP']""
 S ECU=+$P(ECEC,"^",11)
 S ECD=$P(ECEC,"^",7),ECDN=$S($P($G(^ECD(ECD,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECUN=$S($P($G(^VA(200,ECU,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECPSY=+$O(^ECJ("AP",ECL,ECD,ECC,ECP,""))
 S ECFILE=$P(ECP,";",2),ECFILE=$S($E(ECFILE)="I":81,$E(ECFILE)="E":725,1:"UNKNOWN")
 I ECFILE="UNKNOWN" S ECPN="UNKNOWN"
 I ECFILE=81 S ECPN=$S($P($G(^ICPT(+ECP,0)),"^",2)]"":$P(^(0),"^",2),1:"UNKNOWN")
 I ECFILE=725 S ECPN=$S($P($G(^EC(725,+ECP,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECPN=$E(ECPN,1,5)_";"_$P(ECP,";")_";"_$E($P(ECP,";",2))_";"_ECPSY
 ;Get Procedure CPT modifiers
 S ECMODF=0 K ECMOD
 I $O(^ECH(+ECFN,"MOD",0))'="" S ECMODF=$$MOD^ECUTL(+ECFN,"I",.ECMOD)
 ;
 ;ALB/ESD - Get procedure reason from EC Patient file (#721) record
 N ECLNK
 S ECPRSN=""
 S ECLNK=+$P(ECEC,"^",23)
 I +ECLNK>0 DO
 .S ECPRSN=$P($G(^ECL(ECLNK,0)),"^",1)
 .S:+ECPRSN'>0 ECPRSN="REASON NOT DEFINED"
 .S:+ECPRSN>0 ECPRSN=$P(^ECR(ECPRSN,0),"^",1)
 S:+ECLNK'>0 ECPRSN="REASON NOT DEFINED"
 I '$D(ECRY) S ECPRSN="REASON NOT DEFINED" ;group proc reason-not print
 I '$D(^TMP($J,ECLN,ECDN,ECUN)) S ECINC=ECINC+1,ECINZ="^"_ECINC,^(ECUN)=0,^(ECUN,ECINC)=0
 S ECINZ="^"_$O(^TMP($J,ECLN,ECDN,ECUN,0))
 I '$D(^TMP($J,ECINZ,ECCN)) S ^(ECCN)=0
 ;
 ;ALB/ESD - Add procedure reason to ^TMP array
 I '$D(^TMP($J,ECINZ,ECCN,ECPN,ECPRSN)) S ^TMP($J,ECINZ,ECCN,ECPN,ECPRSN)=0
 S ^TMP($J,ECLN)=^TMP($J,ECLN)+ECV
 S ^TMP($J,ECLN,ECDN,ECUN)=^TMP($J,ECLN,ECDN,ECUN)+ECV
 S ^TMP($J,ECINZ,ECCN)=^TMP($J,ECINZ,ECCN)+ECV
 ;
 ;ALB/ESD - Add procedure reason to ^TMP array
 S ^TMP($J,ECINZ,ECCN,ECPN,ECPRSN)=^TMP($J,ECINZ,ECCN,ECPN,ECPRSN)+ECV
 ;ALB/JAM - Add Procedure CPT modifier to ^TMP array
 S MOD="" F  S MOD=$O(ECMOD(MOD)) Q:MOD=""  D
 . S ^TMP($J,ECINZ,ECCN,ECPN,ECPRSN,"MOD",MOD)=$G(^TMP($J,ECINZ,ECCN,ECPN,ECPRSN,"MOD",MOD))+ECV
 Q
PAGE ; end of page
 I $D(ECPG),$E(IOST,1,2)="C-" W !!,"Press <RET> to continue, or ^ to quit  " R X:DTIME I '$T!(X="^") S ECOUT=1 Q
HDR ; print heading
 W:$Y @IOF W !!,?49,"EVENT CAPTURE PROVIDER SUMMARY",!,?49,"FROM "_$P(ECDATE,"^")_"  TO "_$P(ECDATE,"^",2),!,?49,"Run Date : ",ECRDT
 W !!?3,"Category",!,?6,"CPT Code",?20,"Description"
 W:$D(ECRY) ?70,"Procedure Reason"
 W ?105,"Volume",!,?10,"CPT Modifier (volume)",!
 F LINE=1:1:132 W "-"
 W !!,"Location: "_ECLN,! W:ECDN]"" "DSS Unit: "_ECDN I $D(ECUSER) W !!,ECUN,!,ECCN
 Q
TOTP Q:ECOUT  W !,?105,"------",!,"Total Procedures for "_ECUN,?105,$J(^TMP($J,ECLN,ECDN,ECUN),6)
 Q
 ;
NOUNIT ;Nothing there
 I $O(^TMP($J,ECLN,ECDN))']"" D PAGE W !!!,?12,"NO PROCEDURES",! S ECPG=1
 Q
