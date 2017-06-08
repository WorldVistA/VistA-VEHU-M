QIP5A ;SLC/STAFF-QUIC Lab - Ask for Input ;4/15/92  15:13
V ;;1.1;QUALITY IMPROVEMENT CHECKLIST;;MAY 6,1992
 ; sets up QIPQ(question #,input info), begin time: QIPTB, and end time: QIPTE, detailed report QIPDET
ONE ; from QIP5
 ; does not use default dates
 W @IOF D TITLE^QIP5U("TQD") S QIPTB="",QIPTE="" D DATES(.QIPTB,.QIPTE) Q:'$L(QIPTB)  Q:'$L(QIPTE)
 W !!,"Enter the laboratory tests used in this report --",!,"the most common test(s) used for electrolytes (CHEM 7, SMA 6, etc.)",!,"and the most common test(s) used for CBC."
 K DIC,^TMP("QIP5",$J) S DIC=60,DIC(0)="AEMOQZ",DIC("A")="     LABORATORY TEST: " F  D ^DIC Q:Y<1  S ^TMP("QIP5",$J,"TESTS",+Y)=$P(Y(0),U)
 K DIC I '$D(^TMP("QIP5",$J,"TESTS")) K QIPQ Q
 W !!,"Urgencies:" S QIPX="" F  S QIPX=$O(^LAB(62.05,"B",QIPX)) Q:QIPX=""  W !?10,QIPX
 W !,"Enter all urgencies considered to be 'stat'." S DIC=62.05,DIC(0)="AEMOQZ",DIC("A")="     URGENCY: " F  D ^DIC Q:Y<1  S QIPQ("URGENCY",+Y)=$P(Y(0),U)
 K DIC I '$D(QIPQ("URGENCY")) K QIPQ Q
 D DETAIL I QIPDET<0 K QIPQ
 Q
TWO ; from QIP5
 ; uses default dates
 W @IOF D TITLE^QIP5U("TQD") S QIPTB=$G(QIPBDT),QIPTE=$G(QIPEDT) D DATES(.QIPTB,.QIPTE) Q:'$L(QIPTB)  Q:'$L(QIPTE)
 F  W !!?5,"Are Staph aureus and Methicillin resistant Staph aureus (MRSA) defined as",!?5,"two separate organisms" S %=2 D YN^DICN Q:%  W "  enter 'Y'es or 'N'o"
 Q:%<1  S QIPQ("DEF2")=$S(%=1:1,1:0)
 W !!?5,"Enter the organism defined as 'Staphylococcus aureus'." K DIC S DIC=61.2,DIC(0)="AEMOQZ",DIC("A")="     ORGANISM: ",DIC("B")="STAPHYLOCOCCUS AUREUS" D ^DIC K DIC I Y<1 K QIPQ Q
 S QIPQ("ORGANISM",+Y)=$P(Y(0),U)
 I QIPQ("DEF2") D
 .W !!?5,"Enter the organism defined as 'Methicillin resistant Staphylococcus aureus'." S DIC=61.2,DIC(0)="AEMOQZ",DIC("A")="     ORGANISM: " D ^DIC K DIC I Y<1 K QIPQ Q
 .S QIPQ("ORGANISM",+Y)=$P(Y(0),U)_U_"MRSA"
 .F  W !?5,"Are all isolates for MRSA tested against the antibiotic" S %=2 D YN^DICN Q:%  W "  enter 'Y'es or 'N'o"
 .I %<1 K QIPQ Q
 .S $P(QIPQ("DEF2"),U,2)=$S(%=1:1,1:0)
 Q:'$D(QIPQ)
 W !!?5,"Enter the antibiotic used to determine 'methicillin resistant Staph aureus'",!?5,"For example, METHICILLIN, OXACILLIN, or NAFCILLIN",!?5,"Check which antibiotic your Microbiology department uses."
 S DIC=62.06,DIC(0)="AEMOQZ",DIC("A")="     ANTIBIOTIC: " D ^DIC K DIC I Y<1 K QIPQ Q
 S QIPQ("ANTIBIOTIC")=+Y_U_$P(Y(0),U,2)_U_$P(Y(0),U)
 D DETAIL I QIPDET<0 K QIPQ
 Q
FOUR ; from QIP5
 ; does not use default dates
 W @IOF D TITLE^QIP5U("TQD") S QIPTB="",QIPTE="" D DATES(.QIPTB,.QIPTE) Q:'$L(QIPTB)  Q:'$L(QIPTE)
 W !!,"Enter the laboratory tests used in this report --",!,"the tests listed in the user manual."
 K DIC,^TMP("QIP5",$J) S DIC=60,DIC(0)="AEMOQZ",DIC("S")="I $P(^(0),U,4)=""CH"",$E($P(^(0),U,5),1,3)=""CH;""",DIC("A")="     LABORATORY TEST: "
 F  D ^DIC Q:Y<1  S ^TMP("QIP5",$J,"TESTS",+$P($P(Y(0),U,5),";",2))=$P(Y(0),U)_U_+Y
 K DIC I '$D(^TMP("QIP5",$J,"TESTS")) K QIPQ Q
 W !!,"Enter all site/specimens used to define 'blood'.",!,"For example: BLOOD, SERUM, PLASMA, and ARTERIAL BLOOD"
 K DIC S DIC=61,DIC(0)="AEMOQZ",DIC("A")="     SITE/SPECIMEN: " F  D ^DIC Q:Y<1  S QIPQ("SPEC",+Y)=$P(Y(0),U)
 K DIC I '$D(QIPQ("SPEC")) K QIPQ Q
 D DETAIL I QIPDET<0 K QIPQ
 Q
DETAIL ; detailed report=1, no detailed report=0, exit=-1
 F  W !!,"Include a detailed report" S %=2 D YN^DICN Q:%  W "  enter 'Y'es or 'N'o"
 S QIPDET=$S(%=1:1,%=2:0,1:-1)
 Q
DATES(QIPUBD,QIPUED) ; call by reference (begin date default,end date default) returns (begin date selected,end date selected) null selected dates should be used to exit
 W !,"Enter date range for data to be included in report:"
 K %DT S %DT="AEPX",%DT("A")="Start with date: " S:$L(QIPUBD) %DT("B")=$$DATE(QIPUBD) D ^%DT K %DT S QIPUBD=$S(Y<1!$D(DTOUT):"",1:Y) Q:'$L(QIPUBD)
 S %DT="AEPX",%DT("A")="Stop with date: " S:$L(QIPUED) %DT("B")=$$DATE(QIPUED) D ^%DT K %DT S QIPUED=$S(Y<1!$D(DTOUT):"",1:Y) Q:'$L(QIPUED)
 I QIPUBD>QIPUED S QIPX=QIPUED,QIPUED=QIPUBD,QIPUBD=QIPX
 Q
DATE(Y) ; $$(internal date) -> external date
 D DD^%DT Q Y
