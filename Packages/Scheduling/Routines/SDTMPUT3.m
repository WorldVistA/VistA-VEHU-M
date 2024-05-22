SDTMPUT3 ;BAH/DRF - INSTITUTION DISCREPANCY REPORT;Nov 9, 2023
 ;;5.3;Scheduling;**863**;Aug 13, 1993;Build 14
 Q
 ;
BEGIN ;Report Begin & Title
 W #,"CLINICS THAT HAVE AN INSTITUTIONAL DISCREPANCY",!!
 K ^TMP("SDTMPUT3",$J)
 D ACT I Y="^" Q
 D ASKTYPE I Y="^"!(Y="Q") Q
 D DIV I X="^" Q
 D DISC I Y="^" Q
 ;
IO ;Ask IO device
 S %ZIS="PM" D ^%ZIS I POP D END Q
 ;
LOOP ;Begin Report
 S FND=0,PGNO=0
 S CLNAM="" F  S CLNAM=$O(^TMP("SDTMPUT3",$J,CLNAM)) Q:CLNAM=""  D
 . S CL=0 F  S CL=$O(^TMP("SDTMPUT3",$J,CLNAM,CL)) Q:'CL  D
 .. S IN=$G(^SC(CL,"I"))
 .. I $P(IN,U,1)>0,+$P(IN,U,2)=0,ACT="A" Q  ;Eliminate inactive clinics
 .. I +$P(IN,U,1)=0!(+$P(IN,U,1)>0&(+$P(IN,U,2)>0)),ACT="I" Q  ;Eliminate active clinics
 .. S (DIV,MCD,INST,INSTD)=""
 .. S NODE0=$G(^SC(CL,0)),CLSTC=$P(NODE0,U,7),CLCRSC=$P(NODE0,U,18),DIV=$P(NODE0,U,15)
 .. I 'CLSTC S CLSTC="   "
 .. I 'CLCRSC S CLCRSC="   "
 .. I DIV S MCD=$G(^DG(40.8,DIV,0)),INSTD=$P(MCD,U,7),INST=$P(NODE0,U,4)
 .. I $G(SDIV)]"",DIV'=SDIV Q  ;Eliminate non-matching divisions
 .. I DISC="D",INSTD=INST Q  ;Eliminate non-discrepancy clinics
 .. D LINE
 I 'FND D HEADER W !!,"NO CLINICS MEETING THE CRITERIA WERE FOUND",!
 W !,"** END **"
 G END
 ;
HEADER ;Print header
 W #
 S PGNO=PGNO+1
 W ?1,"CLINICS WITH INSTITUTIONAL DISCREPANCY",?71,"DATE: ",$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),?122,"PAGE: ",PGNO,!
 W ?1,$S(ACT="B":"BOTH ACTIVE AND *INACTIVE CLINICS",ACT="I":"*INACTIVE CLINICS",1:"ACTIVE CLINICS"),!
 W ?1,$S(ASKTYPE="C"&(CRIT="ALL"):"ALL CLINICS",ASKTYPE="C"&(CRIT["["):"CLINICS CONTAINING """_$P(CRIT,"[",2)_"""",ASKTYPE="C":"CLINICS BEGINNING WITH """_CRIT_"""",1:"STOP CODE: "_CRIT_" - "_$P($G(^DIC(40.7,CRIT,0)),U,1)),!
 W ?1,$S(DISC="D":"CLINICS WITH DISCREPANCY ONLY",1:"ALL CLINICS INCLUDING DISCREPANCIES"),!
 W ?1,"DIVISION: ",$S(SDIV="":"ALL",1:$P($G(^DG(40.8,SDIV,0)),U,1)),!
 W ?50,"Station",?59,"Medical Center",?95,"Derived",?107,"Station",!
 W ?1,"Clinic Name",?33,"IEN",?41,"###/###",?50,"Number",?59,"Division",?95,"Institution",?107,"Number",?118,"Institution",!
 W ?1,"------------------------------",?33,"-------",?41,"--------",?50,"--------",?59,"-----------------------------------",?95,"-----------",?107,"----------",?118,"-----------",!
 Q
 ;
LINE ;Write a single clinic record
 S FND=FND+1
 I FND#60=1 D HEADER
 I $P(IN,U,1)>0,+$P(IN,U,2)=0 W ?1,"*"
 W ?2,CLNAM,?33,CL,?41,CLSTC,"/",CLCRSC,?50,$$GET1^DIQ(4,INST_",",99,"E"),?59,$P(MCD,U,1),?95,INSTD,?107,$$GET1^DIQ(4,INSTD_",",99,"E"),?118,INST,!
 Q
 ;
END ;Clean up and Quit
 K ^TMP("SDTMPUT3",$J)
 K %ZIS,ACT,ASKTYPE,CL,CLCRSC,CLNAM,CLSTC,CRIT,DIC,DIR,DIR,DISC,DIV,FND,I,IN,INST,INSTD,MCD,NODE0,PGNO,POP,SDIV,X,Y
 Q
 ;
ACT ;View active, inactive or both clinics
 K DIR,X
 S DIR(0)="SA^A:ACTIVE;I:INACTIVE;B:BOTH^",DIR("B")="B"
 S DIR("A")="List which clinics - (A)ctive, (I)nactive or (B)oth ? "
 D ^DIR
 S ACT=Y
 Q
 ;
ASKTYPE ;Ask search type
 K DIR,X
 S DIR(0)="SA^C:CLINIC;S:STOP CODE;Q:QUIT;^",DIR("B")="C"
 S DIR("A")="Select (C)linic, (S)top Code or (Q)uit: "
 D ^DIR
 S ASKTYPE=Y
 I ASKTYPE="Q" Q
 I ASKTYPE="C" D CLINIC Q
 I ASKTYPE="S" D STOPCODE
 Q
 ;
DIV ;Ask division
 K DIC,X
 S SDIV=""
 S DIC="^DG(40.8,",DIC(0)="AEMQZ" ;,DIC("S")="I $P(^(0),""^"",3)=""C"",'$G(^(""OOS""))"
 S DIC("A")="Select DIVISION: ALL// " W "Press Enter for ALL divisions or " D ^DIC K DIC("S"),DIC("A") Q:"^"[X  I +Y'>0 G:+Y<0 DIV
 I X="^" Q
 S SDIV=$P(Y,U,1)
 K DIC
 Q
 ;
DISC ;Ask DISCREPANCY or ALL
 K DIR,X
 S DIR(0)="SA^D:DISCREPANCY;A:ALL;^",DIR("B")="D"
 S DIR("A")="Select (D)iscrepancy or (A)ll: "
 D ^DIR
 S DISC=Y
 Q
 ;
CLINIC ;Ask CLINIC
 N C,D,FND,X
 K DIR
 S DIR(0)="FO",DIR("A")="CLINIC NAME or ALL"
 S DIR("?")="Enter a partial clinic name to find all clinics beginning with that phrase. Use the left bracket ([) to find any clinics that contain that phrase anywhere in their name. Enter ALL to include all clinics."
 D ^DIR
 W !!
 I X="" W "Response required. Enter ^ to Quit",! G CLINIC
 I X="^" Q
 S CRIT=X
 I X="ALL" S X=""
 S D=X
 S FND=$O(^SC("B",D))
 ;I $E(FND,1,$L(D))'=D W "  NOT FOUND",! G CLINIC
 I X="" S FND="" F I=1:1 S FND=$O(^SC("B",FND)) Q:FND=""  S C=0 F  S C=$O(^SC("B",FND,C)) Q:'C  S ^TMP("SDTMPUT3",$J,FND,C)=""
 I X["[" S FND="" F I=1:1 S FND=$O(^SC("B",FND)) Q:FND=""  I FND[$P(X,"[",2) S C=0 F  S C=$O(^SC("B",FND,C)) Q:'C  S ^TMP("SDTMPUT3",$J,FND,C)=""
 I X]"" F I=1:1 S FND=$O(^SC("B",FND)) Q:$E(FND,1,$L(D))'=D  S C=0 F  S C=$O(^SC("B",FND,C)) Q:'C  S ^TMP("SDTMPUT3",$J,FND,C)=""
 Q
 ;
STOPCODE ;Ask STOPCODE
 N C,CLNAM,D,FND,X
 K DIR
 S DIR(0)="FO",DIR("A")="STOP CODE"
 S DIR("?")="Enter any Stop Code to search for clinics that have that Stop Code as either the primary or secondary Stop Code."
 D ^DIR
 W !!
 I X="" W "Response required. Enter ^ to Quit",! G CLINIC
 I X="^" Q
 S (CRIT,D)=X
 W "  ",$P($G(^DIC(40.7,+D,0)),U,1),!!
 S FND=$D(^SC("AST",D))+$D(^SC("ACST",D))
 I 'FND W "  NOT FOUND IN CLINIC FILE",! G STOPCODE
 S C=0 F I=1:1 S C=$O(^SC("AST",D,C)) Q:'C  S CLNAM=$P($G(^SC(C,0)),U,1),^TMP("SDTMPUT3",$J,CLNAM,C)=""
 S C=0 F I=1:1 S C=$O(^SC("ACST",D,C)) Q:'C  S CLNAM=$P($G(^SC(C,0)),U,1),^TMP("SDTMPUT3",$J,CLNAM,C)=""
 Q
