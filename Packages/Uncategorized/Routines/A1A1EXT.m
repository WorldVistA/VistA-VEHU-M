A1A1EXT ;ALB/CAW,PKE - Loop through and extract data ;04/05/95 [ 05/29/96  8:15 AM ]
 ;;1.2;Prescription Practices Extract;;MAY 1,1996
 ;
QUEUE ; queue OIG request to run
 ;
 I $G(^VA(200,+$G(DUZ),0))']""!('$D(DUZ(0))) DO  G QUEUEQ
 .W !!,*7,"The variable DUZ must be set to a valid user"
 .W " number before continuing!!"
 .W !,"D ^XUP to set all DUZ variables",!
 ;
 W !,"This routine will retrieve prescription information."
 W ".",!,"This routine should ONLY be run in your production account and"
 W !,"should be run during non-peak hours."
 ;
 W !!,"First, I'm going to add the OIG mailgroup to your system to allow you to",!,"receive error messages regarding transmission problems to the Q-OIG domain."
 S DIC="^XMB(3.8,",X="OIG",DIC(0)="L",DLAYGO=3.8 D ^DIC K DLAYGO
 W !,". .The Mail group OIG ",$S($P(Y,"^",3)=1:"was added",1:"already exists"),".  Please add members as appropriate."
 I $P(Y,"^",3) S DIE=DIC,DA=+Y,DR="4///PU" D ^DIE
 ;
 W !!,".Adding security key XMQ-OIG for Q-OIG.VA.GOV domain"
 S DIC="^DIC(19.1,",X="XMQ-OIG",DIC(0)="L",DLAYGO=19.1 D ^DIC K DLAYGO
 W !,". .The Security key XMQ-OIG ",$S($P(Y,"^",3)=1:"was added",1:"already exists"),".  Please add holders as appropriate."
 ;
 I Y<0 DO  G QUEUEQ
 .W !!,"NOT able to add Security Key XMQ-OIG to file 19.1"
 .W !,"Please add the key XMQ-OIG using VA Fileman"
 .W !,"Please assign the key XMQ-OIG to user ",$P(^VA(200,DUZ,0),"^")
 .W !,"and rerun this routine"
 ;
 I Y,'$D(^XUSEC("XMQ-OIG",DUZ)) S A1DUZ=$G(DUZ(0)) D
 .S DIC(0)="NMQ",DIC("P")=$P(^DD(200,51,0),"^",2)
 .S DUZ(0)="@",DIC="^VA(200,"_DUZ_",51,",DA(1)=DUZ S X=+Y,DINUM=X
 .K DO,DD D FILE^DICN K DIC,DO,DD,DA,DE,DQ
 .S DUZ(0)=A1DUZ
 .I '$P(Y,"^",3) Q
 .W !,". .",$P(^VA(200,DUZ,0),"^")," ..added as an XMQ-OIG key holder"
 ;
 I Y<0 DO  G QUEUEQ
 .W !!,"NOT able to grant user ",$P(^VA(200,DUZ,0),"^")
 .W "the XMQ-OIG Security key"
 .W !,"Please grant this user the XMQ-OIG key and rerun this routine",!
 ;
 W !!,".Adding domain file entry for Q-OIG.VA.GOV"
 S DIC="^DIC(4.2,",X="Q-OIG.VA.GOV",DIC(0)="L",DLAYGO=4.2 D ^DIC K DLAYGO
 W !,". .The Domain file entry Q-OIG.VA.GOV ",$S($P(Y,"^",3)=1:"was added",1:"already exists"),"."
 ;
 I Y<0 DO  G QUEUEQ
 .W !!,"NOT able to add domain Q-OIG.VA.GOV to File 4.2"
 .W !,"Please add this domain with a relay domain of FOC-AUSTIN.VA.GOV"
 .W !,"and rerun this routine",!
 ;
 S A1FOC=$O(^DIC(4.2,"B","FOC-AUSTIN.VA.GOV",0))
 I A1FOC'=$O(^DIC(4.2,"B","FOC-AUSTIN.VA.GOV",""),-1) DO  G QUEUEQ
 .W !,"FOC-Austin has more than one B cross-reference in File 4.2"
 .W !,"Please add FOC-AUSTIN.VA.GOV as the relay domain for Q-OIG.VA.GOV"
 .W !,"and rerun this routine"
 ;
 S DIE=DIC,DA=+Y
 S DR="1///NS;2///^S X=A1FOC;1.5///XMQ-OIG;6.2///OIG;"
 D ^DIE
 W !!
 K A1FOC,A1DUZ,A1A1X,DIV,DA,DIC,DIE,DR,X,Y
 ;
 S ZTDESC="OIG PRESCRIBING PRACTICES DATA EXTRACT",ZTRTN="EN^A1A1EXT",ZTIO=""
 D ^%ZTLOAD
 I '$G(ZTSK) W !!,*7,"Job aborted!"
 I $G(ZTSK) W !!,"Task ",ZTSK," has been queued to run."
 ;
QUEUEQ K ZTDESC,ZTIO,ZTRTN,ZTSK
 K A1FOC,A1DUZ,A1A1X,DA,DIC,DIE,DR,X,Y
 Q
EN ; Start process
 N A1VER,A1XREF,A1SDATE,A1EDATE,A1BEG,A1END
 K ^TMP("A1PROV",$J),^TMP("A1RXEXT",$J),^TMP("A1RXPROV",$J)
 D NOW^%DTC S Y=% D DD^%DT S A1BEG=Y K %,Y
 S A1SDATE=$P($T(DATES+1),";;",2),A1EDATE=$P($T(DATES+2),";;",2)
 S A1VER=$$VCHK,A1MSG=1
 S A1XREF=$S(A1VER=6:"AL",1:"AD")
 D DRUGPT
 D GETDATA^A1A1EXT1(A1XREF,A1SDATE,A1EDATE)
 D PROVDATA^A1A1FMT0
 ;
 I '$D(^TMP("A1RXEXT",$J)) DO
 . I A1XREF="AD" Q
 . I A1XREF="AL" S A1XREF="AD"
 . S A1MSG=1
 . S A1SDATE=$P($T(DATES+1),";;",2),A1EDATE=$P($T(DATES+2),";;",2)
 . D GETDATA^A1A1EXT1(A1XREF,A1SDATE,A1EDATE)
 . D PROVDATA^A1A1FMT0
 ;
 I $D(^TMP("A1RXEXT",$J)) D MAIL^A1A1MAIL
 ;
 I '$D(^TMP("A1RXEXT",$J)) DO
 . S A1MSG=0,A1RXMM=0
 . D END^A1A1MAIL
 ;
 K A1AGE,A1PROV,A1PINFO,A1PSVC,A1PPD,A1PCERT,A1CNT,A1PBRDE,AIPPO,A1PSPEC
 K A1PSCH,A1PSCHS,A1PSCHD,A1PSCHA,A1REFCTR,A1PARCTR,A1PART
 K A1CNT,A1CNTR,A1DATE,A1DATA,A1MSG
KILL ;
 K ^TMP("A1PROV",$J),^TMP("A1RXEXT",$J),^TMP("A1RXPROV",$J)
 Q
 ;
VCHK() ;Check for version
 Q $P($G(^PS(59.7,1,49.99)),U)
 ;
DATES ; Start and end dates
 ;;2951000
 ;;2960331
 ;
 ;
DRUGPT S A1DRUG("NDF",+$O(^PSNDF("B","PROPOXYPHENE",0)))=$P($G(^PSNDF($O(^PSNDF("B","PROPOXYPHENE",0)),0)),"^")
 S A1DRUG("NDF",+$O(^PSNDF("B","ACETAMINOPHEN/PROPOXYPHENE",0)))=$P($G(^PSNDF($O(^PSNDF("B","ACETAMINOPHEN/PROPOXYPHENE",0)),0)),"^")
 S A1DRUG("NDF",+$O(^PSNDF("B","ASPIRIN/PROPOXYPHENE",0)))=$P($G(^PSNDF($O(^PSNDF("B","ASPIRIN/PROPOXYPHENE",0)),0)),"^")
 S A1DRUG("NDF",+$O(^PSNDF("B","ASPIRIN/CAFFEINE/PROPOXYPHENE",0)))=$P($G(^PSNDF($O(^PSNDF("B","ASPIRIN/CAFFEINE/PROPOXYPHENE",0)),0)),"^")
 ;
 S A1DRUG("NDF",+$O(^PSNDF("B","DIPYRIDAMOLE",0)))=$P($G(^PSNDF($O(^PSNDF("B","DIPYRIDAMOLE",0)),0)),"^")
 S A1DRUG("NDF",+$O(^PSNDF("B","CHLORPROPAMIDE",0)))=$P($G(^PSNDF($O(^PSNDF("B","CHLORPROPAMIDE",0)),0)),"^")
 ;
 S A1DRUG("NDF",+$O(^PSNDF("B","AMITRIPTYLINE",0)))=$P($G(^PSNDF($O(^PSNDF("B","AMITRIPTYLINE",0)),0)),"^")
 S A1DRUG("NDF",+$O(^PSNDF("B","AMITRIPTYLINE/CHLORDIAZEPOXIDE",0)))=$P($G(^PSNDF($O(^PSNDF("B","AMITRIPTYLINE/CHLORDIAZEPOXIDE",0)),0)),"^")
 S A1DRUG("NDF",+$O(^PSNDF("B","AMITRIPTYLINE/PERPHENAZINE",0)))=$P($G(^PSNDF($O(^PSNDF("B","AMITRIPTYLINE/PERPHENAZINE",0)),0)),"^")
 Q
