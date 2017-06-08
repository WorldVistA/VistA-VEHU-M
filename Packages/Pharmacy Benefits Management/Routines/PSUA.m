PSUA ;BHM ISC/DEB - D&PPM Beginning routine ;4NOV91
 ;;1.0; D&PPM ;**5**;11 May 94
 D NOW^%DTC S DT=$S('$D(DT):$P(%,".",1),1:DT)
 W @IOF,!!,"Good ",$S($P($H,",",2)<43200:"morning",$P($H,",",2)<61200:"afternoon",1:"evening") S X=$P($P($P(^VA(200,DUZ,0),U,1),",",2)," ",1) D LC W " ",X,!,"Welcome to the D&PPM Dispensing Action Review Report.",!
 ;
 D Q ;Kills all variables for this function
 ;
 D ^PSUA0 G Q:$D(ERR)
 ;
 ;
SELF ;Include your self as a recipient ?
 R !!,"Do you want a copy of this report sent to you in a MailMan message ?   NO // ",AN:DTIME G Q:AN["^"!('$T) S AN=$E(AN) I AN="" S AN="N"
 I "YyNn"'[AN W !!,"Answer Yes if you want a copy of this report sent to you." K AN G SELF
 K PSUXM1 I "Yy"[AN S PSUXM1=DUZ I '$D(PSUMNTH) G BCKGND
 ;
 I $D(PSUPSRX) G WHICH
 I '$D(PSUMNTH) G WHICH
HINES ;Send report to Hines
 R !,"Send this to the D&PPM Section for addition to the master file ?       NO // ",AN:DTIME G Q:AN["^"!('$T) S AN=$E(AN) I AN="" S AN="N"
 I "YyNn"'[AN W !!,"Answer a Y for YES, and a copy of this report will be sent to the D&PPM",!,"section, and will be included in the master file.",! K AN G HINES
 K PSUXM2 I "Yy"[AN S PSUXM2=1
WHICH ;Which package to gather data for
 R !!,"Do you want to send data for a specific package ? NO // ",AN:DTIME G Q:AN["^"!('$T) I AN="" S AN="N"
 I "YyNn"'[AN D ASK K AN G WHICH
 I "nN"[AN K PSUHOW G WHERE
 ;
DIR ;Set DIR call
 K PSUHOW S DIR("?",1)="Please select which package's data you want to send to the D&PPM",DIR("?")="section at Hines.",DIR("A")="Select the code associated with the data requested "
 S DIR(0)="S^1:IVs;2:Unit Dose;3:AR/WS;4:Out Patient" D ^DIR
 K DIR G Q:+Y'>0 S PSUHOW=+Y
 ;Q
 ;
WHERE I '$D(PSUXM1),'$D(PSUXM2) W !! G DEVICE
 ;
BCKGND ;Run as a background job ??
 R !,"Would you like this executed as a back-ground job? YES // ",AN:DTIME S AN=$E(AN) G Q:AN["^"!('$T) I AN="" S AN="Y"
 I "YyNn"'[AN W !!,"Answer with a Y for YES, and the search for the data will be done as a back-",!,"ground job, thus allowing you to do other things with the terminal.",! K AN G BCKGND
 I "Yy"[AN S ZTDTH=$H,ZTIO="" G BACK
 ;
 ;Background job not requested.....
 G ^PSUB
 ;
DATE ;Convert Date/Time to readable format
 S Y=X X ^DD("DD") S:Y="" Y="Unknown"
 Q
 ;
BACK S ZTRTN="^PSUB",ZTDESC="Stats Report"
 F Y="PSUDATE","PSUHOW","PSUDT1","PSUDT2","PSUMON","PSUMON1","PSUMON2","PSUPSRX","PSUXM1","PSUXM2","PSURPT","IO" S ZTSAVE(Y)=""
 D ^%ZTLOAD
 I $D(ZTSK) W !!,"ok, this report has been queued."
 ;
Q S:$D(ZTQUEUED) ZTREQ="@" D ^%ZISC
 K CNT,PSUDT2,PSUDT3,PSUMON,PSURPT,DATE,DTE,PSUL,PSU,PSU1,PSU2,PSU3,PSU4,PSU5,PSU6,PSU7,PSU8,PSU9,PSU11,PSU21,PSU31,PSU41,PSU51,PSU61,PSUD,PSUDATA,PSUDT,PSUDT1,PDJYDT2,PSUMON1,PSUMON2,PSUMON3,PSUY,PSUY1,PSUY2,PSUHOW
 K PSU42,PSUXM1,PSUXM2,PSUXM3,XMDUZ,X,XX,XXX,XXXX,Y,YY,XMSUB,AN,PSDT,PSFILL,PSUDATE,PSUPSRX,QTY,PSURF,RXN,RX0,RX1,VPN,VCL,PSUSNDR,SITE,DATA1,PAGE,DRUG,COST,PSU10,PSUMTCH,PSUD1,PSUDTA,PSUER,WSTTL,WS,WD,IVTTL,ZTSK,%DT,Y
 K PSUMNTH,PSUOR,ERR,POP,IVTTL,^TMP($J),OPTTL,UDTTL,WSTTL Q
 ;
DEVICE ;No person selected to receive mail message so send to a device
 S PSURPT=1,%ZIS="QFM",%ZIS("A")="Select 132 column device: " D ^%ZIS G Q:POP K %ZIS I '$D(IO("Q")) U IO G ^PSUB
 S ZTIO=ION G BACK
LC ;Convert 'X' to Lowercase
 F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)
 Q
ASK W !!,"Enter a 'Y' for YES, if you only want to send data for a specific package.",!
 Q
