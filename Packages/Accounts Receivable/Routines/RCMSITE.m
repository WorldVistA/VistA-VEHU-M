RCMSITE ;ALB/RRG - EDIT SITE PARAMETERS ;Jul 02, 2014@15:46:14
V ;;4.5;Accounts Receivable;**173,236,253,298,315,350**;Mar 20, 1995;Build 66
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
BEG ;Start editing site paramters
 N DA,DIC,DIE,DLAYGO,DR,X,Y
 ; edit SITE field (#.01) in AR SITE PARAMETER file (#342)
 S DIC="^RC(342,",DIC(0)="QEAML",DLAYGO=342 D ^DIC I Y>0 S DA=+Y,DR=.01,DIE="^RC(342," D ^DIE
 Q
 ;
ALC ;Edit ALC parameter
 NEW DIC,DR,DA,Y
 S DIE="^RC(342,",DA=1,DR=".07;31" D ^DIE
 Q
IRS ;Edit IRS OFFSET site parameters
 NEW DIE,DR,DA,Y
 I '$D(^RC(342,1,0)) D BEG G:'$D(^RC(342,1,0)) Q
 S DA=1,DR="[RCMS IRS]",DIE="^RC(342," D ^DIE
Q Q
STAT ;Edit NOTIFICATION site parameters
 NEW DIE,DR,DA,Y
 I '$D(^RC(342,1,0)) D BEG G:'$D(^RC(342,1,0)) Q1
 S DA=1,DR="[RCMS NOTIFICATION]",DIE="^RC(342," D ^DIE
Q1 Q
GRP ;Edit AR Group Parameters
 NEW DIE,DR,DA,Y
 F  W ! S DIC(0)="QEAML",DIC="^RC(342.1,",DLAYGO=342.1 D ^DIC K DIC G:Y<0 Q3 S DA=+Y,DIE="^RC(342.1,",DR=$P($G(^RC(342.2,+$P(^RC(342.1,+Y,0),"^",2),1)),"^") I DR]"" D ^DIE
Q3 Q
TCSP ;Edit TCSP Site enable/disable PRCA*4.5*350
 N DIE,DR,DA,Y,A,NZ,%
 I $O(^RC(342,1,40,0))="" W !,"**** SITE IS ACTIVATED ****" S NZ="",A=0
 E  S A=$O(^RC(342,1,40,99999),-1),NZ=^RC(342,1,40,A,0)
 I NZ'="" W !,"SITE IS ",$S($P(NZ,U)="S":"STOPPED",1:"REACTIVATED")," as of ",$$FMTE^XLFDT($P(NZ,U,2)\1,"5Z")," by ",$P($G(^VA(200,$P(NZ,U,3),0)),U)
 W ! S DIR("A")="Are you sure you want to "_$S(NZ="":"stop",$P(NZ,U)="R":"stop",1:"reactivate")_" site",DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR
 I 'Y W !!,"*** NO ACTION TAKEN ***" Q
 D NOW^%DTC
 S ^RC(342,1,40,A+1,0)=$S($P(NZ,U)="S":"R",1:"S")_U_%_U_DUZ
 S ^RC(342,1,40,"B",$S($P(NZ,U)="S":"R",1:"S"),A+1)=""
 S $P(^RC(342,1,40,0),U,2)=342.02 S $P(^RC(342,1,40,0),U,3)=A+1,$P(^RC(342,1,40,0),U,4)=$P(^RC(342,1,40,0),U,4)+1
 W !!,"**** SITE IS NOW ",$S(NZ="":"STOPPED",$P(NZ,U)="R":"STOPPED",1:"REACTIVATED")," ****"
 Q
DEA ;Deactive an AR group
 NEW DIE,DIC,DA,DR,Y,GRP
 S DIC="^RC(342.1,",DIC(0)="QEAM",DIC("S")="I $P(^(0),""^"",2)'=7" D ^DIC Q:Y<0  S GRP=+Y
 W ! S DIR("A")="Are you sure you want to Deactive Group '"_$P(^RC(342.1,GRP,0),"^")_"'",DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR
 I 'Y W !!,"*** NO ACTION TAKEN ***" Q
 I Y S DIE="^RC(342.1,",DA=GRP,DR=".02////^S X=7" D ^DIE W !!,"*** Group Deactivated ***"
 Q
SITE() ;Return site number
 Q +$G(^DIC(4,+$P($G(^RC(342,1,0)),"^"),99))
INT ;Print Inter/Admin/Pen effective report
 NEW DIC,BY,FR,TO,FLDS,L
 S DIC="^RC(342,",BY=.01,(FR,TO)="",FLDS="[RCMS INT/ADM/PEN]",L=0 D EN1^DIP
 Q
UPINT ;Update Rate site parameters
 NEW DIE,DR,DA,Y,IOP
 S IOP=ION D INT
 I '$D(^XUSEC("PRCAF LATE CHARGES",DUZ)) D BMES^XPDUTL("A Security Key is required to edit the Interest/Admin and Penalty Rates.") Q  ;PRCA*4.5*315 Added Security Key
 I '$D(^RC(342,1,0)) D BEG G:'$D(^RC(342,1,0)) Q4
 F  W ! S DA=1,DR="[RCMS RATES]",DIE="^RC(342," D ^DIE Q:$D(Y)
Q4 Q
 ;
EDILOCK() ; function, Update EDI Lockbox site parameters
 ; returns 1 on success, else "^error message"
 N RSLT S RSLT=""
 I '$D(^RC(342,1,0)) D BEG
 S:'$D(^RC(342,1,0)) RSLT="^no site defined"  ; can't continue
 ;
 Q:RSLT]"" RSLT
 ;
 N DA,DIE,DR,Y
 S DA=1,DR="[RCMS EDI LOCKBOX]",DIE="^RC(342," D ^DIE
 S RSLT=$S($D(Y):"^user aborted",1:1)  ; if Y remains from ^DIE call
 ;
 Q RSLT  ; success
 ;
EDITRDDT ;Update # OF DAYS FOR RD ELIG CHG RPT site parameter
 ;This is the number of days for the Rated Disability Eligibility
 ;Change Report to be used when the report is scheduled to be run
 ;on a recurring basis. (Added for Hold Debt to DMC Project)
 N DIE,DR,DA,Y
 I '$D(^RC(342,1,0)) D BEG G:'$D(^RC(342,1,0)) Q6
 S DA=1,DR="8.01",DIE="^RC(342," D ^DIE
Q6 Q
 ;
GETRDDAY() ;Return # OF DAYS FOR RD ELIG CHG RPT site parameter
 Q $$GET1^DIQ(342,1_",",8.01)
 ;
EDITRDAY ;Update NUMBER OF DAYS FOR DMC REPORTS site parameter.
 ;This is the number of days in the past bills for episodes
 ;of care will be included for the following reports when scheduled by
 ;IRM to be run on a recurring basis:
 ;   DMC Debt Validity Report
 ;   DMC Debt Validity Management Report
 ;   Rated Disability Eligibility Change Report
 ;The minimum value for this field is 365 days (1 year) and the maximum
 ;value is 3650 days (10 years). If no value is added in this field the
 ;report will default to 365 days. (Added for Hold Debt to DMC Project)
 N DIE,DR,DA,Y
 I '$D(^RC(342,1,0)) D BEG G:'$D(^RC(342,1,0)) Q7
 S DA=1,DR="8.02",DIE="^RC(342," D ^DIE
Q7 Q
 ;
GETRDAY() ;Return NUMBER OF DAYS FOR DMC REPORTS site parameter
 Q $$GET1^DIQ(342,1_",",8.02)
 ;
