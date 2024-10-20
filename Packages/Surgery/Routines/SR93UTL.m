SR93UTL ;BIR/ADM - Post-install process for SR*3*93 ; [ 02/17/00  8:04 AM ]
 ;;3.0; Surgery ;**93**;24 Jun 93
 ;
 ; Reference to ^DGPM("APTT1" supported by DBIA #565
 ; Reference to File #405 supported by DBIA #3029
 ;
 Q
EN1 ; transmit transfer sites, address & phone number
 K ^TMP("SRA",$J),^TMP("SR93",$J) S SRASITE=+$P($$SITE^SROVAR,"^",3),SRACNT=1
 S SRADFN=0 F  S SRADFN=$O(^SRF("ARS","C","T",SRADFN)) Q:'SRADFN  S SRTN=0 F  S SRTN=$O(^SRF("ARS","C","T",SRADFN,SRTN)) Q:'SRTN  S ^TMP("SR93",$J,SRTN)=""
 S SRTN=0 F  S SRTN=$O(^TMP("SR93",$J,SRTN)) Q:'SRTN  D STUFF
 I SRACNT=1 G END
 D MSG
END K ^TMP("SR93",$J),^TMP("SRA",$J),DA,DFN,DIC,DIQ,DR,I,ISC,NAME,SR,SR24,SRACNT,SRADFN,SRASITE,SRD,SRDT,SRFOL,SRFOLP,SRREF,SRREFP,SRSDATE,SRTN,SRX,SRY,VA,VAIP,VAPA,X,XMSUB,XMTEXT
EN2 ; transmit intubated ? (y/n) for fy2000 cases
 S SITE=+$P($$SITE^SROVAR,"^",3),SRI=0,SROPD=2991000
 F  S SROPD=$O(^SRF("AC",SROPD)) Q:'SROPD  S SRTN=0 F  S SRTN=$O(^SRF("AC",SROPD,SRTN)) Q:'SRTN  I $P($G(^SRF(SRTN,.4)),"^",2)="T" D
 .K SRP F I=1:1:7 S SRP(I)=""
 .S SRA=$G(^SRF(SRTN,0)) Q:SRA=""  S SRP(1)=SITE,SRP(2)=SRTN,DFN=$P(SRA,"^"),SRP(5)=$P(SRA,"^",9) D DEM^VADPT S SRP(4)=VA("PID")
 .S X=$$SITE^SROUTL0(SRTN),SRDIV=$S(X:$P(^SRO(133,X,0),"^"),1:""),SRP(3)=$S(SRDIV:$$GET1^DIQ(4,SRDIV,99),1:SITE)
 .K SRTECH,SRZ S SRT=0 F  S SRT=$O(^SRF(SRTN,6,SRT)) Q:'SRT  D ^SROPRIN Q:$D(SRZ)
 .I $D(SRTECH) S SRP(6)=SRTECH,SRP(7)=$P($G(^SRF(SRTN,6,SRT,8)),"^",2)
 .S SRTMP=SRP(1) F I=2:1:7 S SRTMP=SRTMP_"^"_SRP(I)
 .S SRI=SRI+1,^TMP("SRA",$J,SRI)=SRTMP
 S ISC=0,NAME=$G(^XMB("NETNAME")) I NAME["FORUM"!(NAME["ISC-")!($E(NAME,1,3)="ISC")!(NAME["ISC.") S ISC=1
 I ISC S XMY("G.RISK ASSESSMENT@"_^XMB("NETNAME"))=""
 I 'ISC S XMY("G.SRCOSERV@ISC-CHICAGO.VA.GOV")=""
 S SRD=^XMB("NETNAME") S XMSUB="** SR*3*93-N FROM VAMC-"_SITE_" **",XMDUZ=$S($D(DUZ):DUZ,1:.5)
 S XMTEXT="^TMP(""SRA"",$J," N I D ^XMD
 K ^TMP("SRA",$J) S ZTREQ="@"
 Q
STUFF ; stuff entries into ^TMP("SRA"
 S SR=^SRF(SRTN,0),DFN=$P(SR,"^"),SRSDATE=$P(SR,"^",9) D DEM^VADPT,ADD^VADPT S SRZIP=$S(VAPA(11)'="":$P(VAPA(11),"^",2),1:VAPA(6))
 S (SRREF,SRREFP,SRFOL,SRFOLP)="",VAIP("D")=SRSDATE D IN5^VADPT
 I 'VAIP(13) S X1=$P($G(^SRF(SRTN,.2)),"^",12),X2=1 D C^%DTC S SR24=X,SRDT=$O(^DGPM("APTT1",DFN,SRSDATE)) G:'SRDT!(SRDT>SR24) TS S VAIP("D")=SRDT D IN5^VADPT
TS I VAIP(13) K DA,DIC,DIQ,DR S DIC=405,DR=.05,DA=VAIP(13),DIQ="SRY",DIQ(0)="IE" D EN^DIQ1 S SRREF=SRY(405,VAIP(13),.05,"E"),SRREFP=SRY(405,VAIP(13),.05,"I") I SRREFP S SRREFP=$$GET1^DIQ(4,SRREFP,99)
 I VAIP(17) K DA,DIC,DIQ,DR,SRY S DIC=405,DR=.05,DA=VAIP(17),DIQ="SRY",DIQ(0)="IE" D EN^DIQ1 S SRFOL=SRY(405,VAIP(17),.05,"E"),SRFOLP=SRY(405,VAIP(17),.05,"I") I SRFOLP S SRFOLP=$$GET1^DIQ(4,SRFOLP,99)
 K DA,DIC,DIQ,DR,SRY S SRX=$P(VAPA(5),"^") I SRX S DIC=5,DA=SRX,DR=1,DIQ="SRY",DIQ(0)="E" D EN^DIQ1 S SRX=SRY(5,$P(VAPA(5),"^"),1,"E")
 S ^TMP("SRA",$J,SRACNT)=SRASITE_"^"_SRTN_"^1^"_$E(SRSDATE,1,7)_"^"_VA("PID")_"^"_VAPA(1)_"^"_SRREFP_"^",SRACNT=SRACNT+1
 S ^TMP("SRA",$J,SRACNT)=SRASITE_"^"_SRTN_"^2^"_VAPA(2)_"^"_VAPA(3)_"^",SRACNT=SRACNT+1
 S ^TMP("SRA",$J,SRACNT)=SRASITE_"^"_SRTN_"^3^"_VAPA(4)_"^"_SRX_"^"_SRZIP_"^"_SRREF_"^",SRACNT=SRACNT+1
 S ^TMP("SRA",$J,SRACNT)=SRASITE_"^"_SRTN_"^4^"_VAPA(8)_"^"_SRFOL_"^"_SRFOLP_"^",SRACNT=SRACNT+1
 Q
MSG ; create mail message to Denver
 S ISC=0,NAME=$G(^XMB("NETNAME")) I NAME["FORUM"!(NAME["ISC-")!($E(NAME,1,3)="ISC")!(NAME["ISC.") S ISC=1
 I ISC S XMY("G.RISK ASSESSMENT@"_^XMB("NETNAME"))=""
 I 'ISC S (XMY("G.CARDIAC RISK ASSESSMENTS@DENVER.VA.GOV"),XMY("G.SRCARDIAC@ISC-CHICAGO.VA.GOV"))=""
 S SRD=^XMB("NETNAME") S XMSUB="** SR*3*93 FROM VAMC-"_SRASITE_" **",XMDUZ=$S($D(DUZ):DUZ,1:.5)
 S XMTEXT="^TMP(""SRA"",$J," N I D ^XMD
 Q
POST ; post-install action for SR*3*93
 N SRD S SRD=^XMB("NETNAME") I SRD["TST."!(SRD["TEST")!(SRD["UTL.")!(SRD["TRAIN")!(SRD[".IHS.GOV")!(SRD["CPRS") Q
 D NOW^%DTC S ZTDTH=$E(%,1,12),ZTRTN="EN1^SR93UTL",ZTDESC="Surgery Risk Assessment Retransmission",ZTIO="" D ^%ZTLOAD
 Q
