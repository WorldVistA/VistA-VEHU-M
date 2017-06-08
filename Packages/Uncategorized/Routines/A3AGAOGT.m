A3AGAOGT ;BHAM ISC/LC - GAO PHARMACY DATA COMPILE ROUTINE ; 04/14/94 16:05
 ;;1.0;SPECIAL DATA COMPILE;;
 ;This routine compiles data for patients with RX's in FY93"
 I '$D(DUZ) W *7,!,"DUZ number needs to be defined !",!,*7 G EX
 I $G(DUZ)=.5 W *7,!,"Your DUZ number needs to be different from the Postmaster !",!,*7 G EX
 W !!,"This background job will not add or delete any data or files from your system.  It will create two mail messages, one to the postmaster, the other to the"
 W !,"initializer of this job.  After the successful transmission of the mail",!,"message to the Birmingham ISC the messages can be deleted.  This job will take"
 W !,"several hours to complete.  Please queue to run during none peak hours.",!!
 S ZTRTN="START^A3AGAOGT",ZTDESC="GAO Data Transmission job (outpatient)",ZTIO="" D ^%ZTLOAD W:$D(ZTSK) !,"Task #"_ZTSK_" queued." Q
START K ^TMP("XMIT"),^TMP("TRANS") D NOW^%DTC S ^TMP("XMIT","TIME")="#^"_%
 S STN=+$S($P($G(^DIC(4,+$P(^XMB(1,1,"XUS"),"^",17),99)),"^")'="":$P(^DIC(4,+$P(^XMB(1,1,"XUS"),"^",17),99),"^"),1:$G(^DD("SITE",1))),SDT=2920930,EDT=2930930
 D LOOP D:$O(^TMP("TRANS",0)) COMP,XMIT
EX K DA,DRG,EDT,I,IFN,RX,RXC,RXF,RXN,STN,SSN,SDT,TY,XMDUZ,XMSUB,XMTEXT,XMY,^TMP("TRANS"),^TMP("XMIT") S:$D(ZTQUEUED) ZTREQ="@"
 Q
COMP ;compresses data
 S ^TMP("XMIT",1,0)=STN_"&",IFN=1
 F I=0:0 S I=$O(^TMP("TRANS",I)) Q:'I  D:$L(^TMP("XMIT",IFN,0))+$L(^TMP("TRANS",I,0))>245  S ^TMP("XMIT",IFN,0)=^TMP("XMIT",IFN,0)_^TMP("TRANS",I,0)_"/"
 .S IFN=IFN+1,^TMP("XMIT",IFN,0)=""
 S IFN=IFN+1,^TMP("XMIT",IFN,0)=^TMP("XMIT","TIME")
 Q
LOOP F I=0:0 S SDT=$O(^PSRX("AD",SDT)) Q:'SDT!(SDT>EDT)  D
 .F RXN=0:0 S RXN=$O(^PSRX("AD",SDT,RXN)) Q:'RXN  S DA="" F TY=0:0 S DA=$O(^PSRX("AD",SDT,RXN,DA)) Q:DA=""  I $D(^PSRX(RXN,0)),$D(^DPT($P(^PSRX(RXN,0),"^",2),0)) D
 ..S DRG=+$P(^PSRX(RXN,0),"^",6),SSN=$E($P(^DPT(+$P(^(0),"^",2),0),"^",9),1,9) I SSN D:'DA ORI D:DA REF
 Q
ORI S RX=^PSRX(RXN,0),RXC=+$P(RX,"^",7)*$S($P(RX,"^",17):+$P(RX,"^",17),'$P(RX,"^",17)&($P($G(^PSDRUG(DRG,660)),"^",6)):$P(^PSDRUG(DRG,660),"^",6),1:0) D BLD
 Q
REF Q:'$D(^PSRX(RXN,1,DA,0))  S RXF=^PSRX(RXN,1,DA,0),RXC=+$P(RXF,"^",4)*$S($P(RXF,"^",11):+$P(RXF,"^",11),'$P(RXF,"^",11)&($P($G(^PSDRUG(DRG,660)),"^",6)):$P(^PSDRUG(DRG,660),"^",6),1:0) D BLD
 Q
BLD W:'$D(ZTQUEUED) "."
 S:'$D(^TMP("TRANS",+SSN,0)) ^TMP("TRANS",+SSN,0)=SSN_"^0^0"
 S $P(^TMP("TRANS",+SSN,0),"^",2)=$P(^TMP("TRANS",+SSN,0),"^",2)+1,$P(^(0),"^",3)=$P(^(0),"^",3)+RXC
 Q
XMIT W:'$D(ZTQUEUED) !!,"NOW TRANSMITTING MAIL",! D NOW^%DTC S $P(^TMP("XMIT",IFN,0),"^",3)=%
 S XMSUB="FY93 PHARMACY DATA FOR GAO REPORT ("_^DD("SITE")_")",XMDUZ=.5,XMY(DUZ)="",XMY("G.PHARMGAO@ISC-BIRM.VA.GOV")="",XMTEXT="^TMP(""XMIT""," D ^XMD
 Q
