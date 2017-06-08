DVBH4033 ;ISC-ALBANY/PKE-HINQ-FR,VBA diagnostic ENVIRON CHECK; 8/17/87  08:50 ;
 ;;4.0;HINQ;**33**;03/25/92
 ;
 ; D ^XUP  before using as a diagnostic routine OR
 ; the following line may be removed after KIDS load where it is the environment check routine
 I $G(XPDNM)]"",$G(XPDENV)]"" GOTO ENVIR
 ;
EN S X="A" X ^%ZOSF("LPC") K X S U="^",DVBTSK=0 S:'$D(DTIME) DTIME=300 I $D(IO)<11 S IOP="HOME" D ^%ZIS K IOP
 S:'$D(DVBSTN) DVBSTN=$P(^DVB(395,1,0),U,2) I 'DVBSTN W !!,"Station number not defined in HINQ Parameters file. " D EX1 Q
 S DVBDXX=""
 S DVBZ="HINQ"_DVBSTN_" "_"E00000000000000SS12345678NMTEST,HINQ/ABCD1234"
 W !,"This test will take 30 seconds.  No input is required or allowed.",!,"Responses are from the Frame Relay Network, or remote VBA computer."
 W !,"Success in this test will return a message to the user"
AGN U IO(0) W !!,"Do you wish to continue " S %=1 D YN^DICN
 I %Y["?" G AGN
 I %'=1 D EX1 Q
 W !!
 S DVBIDCU=^DVB(395,1,"HQVD")_"^"_$P(^("HQ"),"^",11)
 S DVBLOG=$P(DVBIDCU,U),(DVBDEV,ION)=$P(DVBIDCU,U,4),DVBPU=$P(DVBIDCU,U,2),DVBID=$P(DVBPU,"-"),DVBPW=$P(DVBPU,"-",2)
 I DVBLOG'?3U1"."4U W !,"IDCU ADDRESS not correct in HINQ Parameter file #395" H 2 G END
 I '$L(DVBDEV) W !!,"DEVICE NAME not defined in HINQ DEVICE NAME of DVB #395" H 2 G END
 I '$L(DVBID) W !,"HINQ IDCU User ID not defined in IDCU USERNAME-PASSWORD parameter." H 2 G END
 I '$L(DVBPW) W !,"HINQ IDCU Password not defined in IDCU USERNAME-PASSWORD parameter." H 2 G END
 I $P(DVBIDCU,"^",6) S DVBLOG="VHA"_$P(DVBLOG,"DMS",2)
 U IO(0) W !,"HINQ device defined as ",DVBDEV,!!
 U IO(0) W !,"Connecting to ",$S(DVBLOG["BDNE":"PHILLY",DVBLOG["BDNC":"HINES",DVBLOG["BDNW":"HINES",DVBLOG["BDNM":"HINES",DVBLOG["HINQ":"HINESs",DVBLOG["BDNS":"PHILLY",1:"???"),"/"_DVBLOG_" ",!
 S %ZIS("A")="Select `new' HINQ device: ",%ZIS("B")=""
 D ^%ZIS I IO=IO(0) W !?3,"The HOME device is not a valid selection.",! Q
 K IOP G:POP BUSY S X=0 U IO X ^%ZOSF("EOFF"),^%ZOSF("TYPE-AHEAD"),^%ZOSF("RM") H 1
 S C=0
NAM ;;;U IO W $C(13)
 ;
HEL F Z2=1:1:50 U IO R X(Z2):1 U IO(0) W "." U IO H 1 I X(Z2)["**HELLO**" S DVBXM=1,DVBTSK=0,DVBABORT=0 U IO S DVBIO=IO,DVBJDX=1 D MES^DVBHQD1 U IO(0) W !,"echo time (seconds) ",DVBECHO,! S IO=DVBIO Q
 I DVBLOG'["VHA" U IO W "$$$BYEF",$C(13) D DISP G EX
 I DVBLOG["VHA" U IO W "$%$DIS",$C(13) D DISP G EX
 D DISP
END F Z=1:1:30 I $D(X(Z)),X(Z)["???" U IO I DVBLOG'["VHA" W "BYEF",$C(13) Q
 F Z=1:1:30 I $D(X(Z)),X(Z)["$%$" U IO I DVBLOG["VHA" W "DIS",$C(13) Q
 ;
EX ;
EX1 K R,DVBJDX,%Y,%,I,K,Y0,Z2,DVBDXX,DVBLEN,D,DVBIO,X,Z,H,DVBSTN,DVBABORT,DVBLOG,DVBDEV,DVBECHO,DVBEND,DVBTMX,DVBTSK,DVBTX,DVBXM,DVBZ,Y,C,G,DVBID,DVBIDCU,DVBPU,DVBPW,^TMP($J) U IO D ^%ZISC U IO(0) S IOP="HOME" D ^%ZIS K IOP
 Q
XXX U IO(0) W:$D(X(Z)) !,X(Z) U IO
 S C=C+1 I C>2 G END
 H 5 G NAM
BUSY U IO(0) W !," ",IO,"   Device is busy" H 1 K DVBLOG,DVBDEV,DVBSTN,DVBDXX,DVBTSK,DVBZ Q
YYY U IO(0) W !,"Bad Network Password notify Site Manager" D EX Q
DISP U IO(0) F G=1:1:Z2 I $D(X(G)) D TRIM W:$L(X(G)) !,X(G) I X(G)["0900 BYE" Q
 U IO Q
TRIM F H=0:0 Q:$E(X(G))'=$C(10)  S X(G)=$E(X(G),2,999)
 F I=$L(X(G)),-1,1 Q:$E(X(G),I)'=$C(10)  S X(G)=$E(X(G),1,I-1)
 Q
 ;
ENVIR ;KIDS install,  environment check for DVB*4*33-37
 S DVBROUTE=".BDNM.BDNE.BDNC.BDNW.BDNS."
 ;           .244 .227 .243 .245 .228
 N S S S="!,""...> """
 I 'XPDENV DO  QUIT  ;Environment check running in Load Phase
 .;
 . S DVBROUT=$P($P($G(^DVB(395,1,"HQVD")),"^",1),".",2)
 . I DVBROUTE'[DVBROUT DO  QUIT
 . .W @S,"Cannot determine the IDCU Address in use.",!
 . .;
 . I DVBROUTE[DVBROUT DO
 . . S DVBHIP=$S(DVBROUT="BDNM":244,DVBROUT="BDNE":227,DVBROUT="BDNC":243,DVBROUT="BDNW":245,DVBROUT="BDNS":228,1:"NOT FOUND")
 . . W @S,"This site uses `.",DVBROUT,"' addressing",!
 . . W @S,"Use IP address = 152.124.127.",DVBHIP,!
 . . W @S
 . . W @S,"Routines will be installed when you install this Patch.",!
 . . I $G(^%ZOSF("OS"))'["DSM" Q
 . . W @S,"DSM sites, make sure the LAT/TCP gateway is installed."
 . . W @S,"The HINQ device will use the LAT/TCP gateway."
 . . W @S,"You should configure the gateway before installing this Patch.",!
 . .;
 ;
 I XPDENV DO
 .; W @S,"Environment check running in Install Phase"
 .;
 . I '$$PATCH^XPDUTL("DVB*4.0*32") DO
 . . W @S,"You must install patch DVB*4.0*32 before installing this patch.",!
 . . S XPDQUIT=2
 .
 Q
