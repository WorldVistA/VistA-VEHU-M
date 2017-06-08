ECXDVSN2 ;ALB/JAP - Division selection utility (cont.) ;Sep 30, 1997
 ;;3.0;DSS EXTRACTS;**14**;Dec 22, 1997
 ;
RAD(ECXDIV,ECXALL,ECXERR) ;setup division/site information for RAD extract audit report
 ;   input
 ;   ECXDIV = passed by reference array variable (required)
 ;   ECXALL = 0/1 (optional)
 ;            '0' indicates user to select radiology division;
 ;            '1' indicates 'all' radiology divisions selected or only one division
 ;                exists in file #79; default is '1'
 ;   output
 ;   ECXDIV = data for radiology division/site;
 ;            ECXDIV(ien in file #79)=ien in file #4^name^station number
 ;   ECXERR = 0/1
 ;            if input problem, then '1' returned
 N X,Y,DIC,DA,DUOUT,DTOUT,DR,DIQ,OUT,ECXARR,ECXD,ECXIEN
 S:'$D(ECXALL) ECXALL=1 S:ECXALL="" ECXALL=1
 S ECXERR=0,ECXD=""
 ;if ecxall=1, then all radiology divisions/sites are selected
 I ECXALL=1 D
 .;ecxd=ecxien; both are iens in file #4
 .F  S ECXD=$O(^RA(79,"B",ECXD)) Q:ECXD=""  S ECXIEN=$O(^(ECXD,"")) D
 ..K ECXARR S DA=ECXIEN,DIC="^DIC(4,",DR=".01;99",DIQ="ECXARR" D EN^DIQ1
 ..I $D(ECXARR) S ECXDIV(ECXIEN)=ECXIEN_U_ECXARR(4,ECXIEN,.01)_U_ECXARR(4,ECXIEN,99)
 ;if ecxall=0, user selects radiology divisions/sites
 I ECXALL=0 S OUT=0 D
 .F  Q:OUT!ECXERR  D
 ..S DIC="^RA(79,",DIC(0)="AEMQ" K X,Y D ^DIC
 ..I $G(DUOUT)!($G(DTOUT)) S OUT=1,ECXERR=1 Q
 ..I Y=-1,X="" S OUT=1 Q
 ..S (ECXIEN,DA)=+Y K ECXARR S DIC="^DIC(4,",DR=".01;99",DIQ="ECXARR" D EN^DIQ1
 ..I $D(ECXARR) S ECXDIV(ECXIEN)=ECXIEN_U_ECXARR(4,ECXIEN,.01)_U_ECXARR(4,ECXIEN,99)
 I ECXERR=1 K ECXDIV
 I '$D(ECXDIV) S ECXERR=1
 Q
 ;
SUR(ECXDIV,ECXALL,ECXERR) ;setup division/site information for SUR extract audit report
 ;   input
 ;   ECXDIV = passed by reference array variable (required)
 ;   ECXALL = 0/1 (optional)
 ;            '0' indicates user to select surgery division;
 ;            '1' indicates 'all' surgery divisions selected or only one division
 ;                exists in file #133; default is '1'
 ;   output
 ;   ECXDIV = data for surgery division/site;
 ;            ECXDIV(ien in file #133)=ien in file #4^name^station number
 ;   ECXERR = 0/1
 ;            if input problem, then '1' returned
 N X,Y,DIC,DA,DUOUT,DTOUT,DR,DIQ,OUT,ECXARR,ECXD,ECXIEN
 S:'$D(ECXALL) ECXALL=1 S:ECXALL="" ECXALL=1
 S ECXERR=0,ECXD=""
 ;if ecxall=1, then all surgery divisions/sites are selected
 I ECXALL=1 D
 .F  S ECXD=$O(^SRO(133,"B",ECXD)) Q:ECXD=""  S ECXIEN=$O(^(ECXD,"")) D
 ..K ECXARR S DA=ECXD,DIC="^DIC(4,",DR=".01;99",DIQ="ECXARR" D EN^DIQ1
 ..I $D(ECXARR) S ECXDIV(ECXD)=ECXIEN_U_ECXARR(4,ECXD,.01)_U_ECXARR(4,ECXD,99)
 ;if ecxall=0, user selects surgery divisions/sites
 I ECXALL=0 S OUT=0 D
 .F  Q:OUT!ECXERR  D
 ..S DIC="^SRO(133,",DIC(0)="AEMQ" K X,Y D ^DIC
 ..I $G(DUOUT)!($G(DTOUT)) S OUT=1,ECXERR=1 Q
 ..I Y=-1,X="" S OUT=1 Q
 ..S ECXIEN=+Y,(ECXD,DA)=$P(Y,U,2) K ECXARR S DIC="^DIC(4,",DR=".01;99",DIQ="ECXARR" D EN^DIQ1
 ..I $D(ECXARR) S ECXDIV(ECXD)=ECXIEN_U_ECXARR(4,ECXD,.01)_U_ECXARR(4,ECXD,99)
 I ECXERR=1 K ECXDIV
 I '$D(ECXDIV) S ECXERR=1
 Q
 ;
PRO(ECXDUZ,ECXPRIME,ECXDIV,ECXALL,ECXERR) ;setup division/site information for PRO extract reports
 ;   input
 ;   ECXDUX   = ien in file#200 for user
 ;   ECXPRIME = primary division ien in file #4 (required)
 ;   all other variables passed by reference
 ;   output
 ;   ECXALL = 0 (one subdivision)
 ;            1 (all divisions related to primary division)
 ;   ECXDIV = data array for prosthetics division/site;
 ;            ECXDIV(n)=ien in file #4^name^station number
 ;   ECXERR = 0/1
 ;            if input problem, then '1' returned
 N X,Y,DA,DR,DUOUT,DTOUT,DIRUT,DIC,DIQ,DIR,OUT,ECXARR
 S ECXERR=0
 I +ECXPRIME=0 S ECXERR=1
 I '$D(^DIC(4,+ECXPRIME)) S ECXERR=1
 D PDIV3^ECXPUTL(ECXDUZ,ECXPRIME,.ECXDIV)
 I ECXDIV(1)=0 S ECXERR=1 Q
 S ECXALL=1
 S LAST=$O(ECXDIV(99),-1) I LAST>1 D
 .W !!,"You may select ONE or ALL of the following:",!
 .F DIV=1:1:LAST D
 ..W !,"("_DIV_")",?6,$P(ECXDIV(DIV),U,2),?14,$P(ECXDIV(DIV),U,3)
 .S DIR(0)="SMBA^A:ALL;O:ONE",DIR("A")="Select O(ne) or A(ll): ",DIR("B")="ALL"
 .W ! K X,Y D ^DIR K DIR
 .I $D(DUOUT)!($D(DTOUT)) K ECXDIV S OUT=1 Q
 .Q:Y="A"
 .S OUT=0 F  D  Q:OUT
 ..S DIR(0)="NA^1:99:0",DIR("A")="Which one?: ",DIR("?")="^D HELP^ECXDVSN2"
 ..W ! K X,Y D ^DIR K DIR
 ..I $D(ECXDIV(+Y)) S DIV=+Y,OUT=1,ECXALL=0 Q
 ..I $D(DUOUT)!($D(DTOUT)) K ECXDIV S OUT=1 Q
 .Q:'$D(ECXDIV)
 .F X=1:1:LAST I X'=DIV K ECXDIV(X)
 I '$D(ECXDIV) S ECXERR=1
 Q
 ;
HELP ;help for dir in pro
 W !,"A response is required from the following:",!
 F DIV=1:1:LAST D
 .W !,"("_DIV_")",?6,$P(ECXDIV(DIV),U,2),?14,$P(ECXDIV(DIV),U,3)
 W !,"Or ""^"" to exit."
 Q
