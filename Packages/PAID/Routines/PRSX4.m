PRSX4 ; HISC/REL/FPT-Add Employees to File 200 ;3/26/93  14:12
 ;;3.1;PAID;;Feb 25, 1994
 ;
 ; DFN     = INTERNAL NUMBER (#450)
 ; NAME    = EMPLOYEE NAME
 ; NODE    = ZERO NODE OF #450 ENTRY
 ; PAGE    = PAGE NUMBER
 ; SSN     = SOCIAL SECURITY NUMBER
 ; NCNT    = NUMBER OF ENTRIES NOT ADDED TO #200
 ; TCNT    = NUMBER OF ENTRIES ADDED TO #200
 ;
 W !!,"This Routine will add all employees to File 200 for whom a SSN match"
 W !,"is not made with File 200. I will print a report when finished.",!
 K ^TMP($J),DIR,DIROUT,DIRUT,DTOUT,DUOUT
OK S DIR(0)="Y",DIR("A")="Want to Continue" D ^DIR I $D(DIRUT)!(Y=0) D KILL Q
 W ! D WAIT^DICD S DFN=0
 F  S DFN=$O(^PRSPC(DFN)) Q:DFN<1  I '$D(^PRSPC("A200",DFN)) D SET
 I '$D(^TMP($J)) W !!,"NO one was added to FILE 200" D KILL Q
 ; select device
 K %ZIS S %ZIS="MQ",%ZIS("A")="Select a PRINTER: ",%ZIS("B")="" D ^%ZIS K %ZIS I POP D KILL,^%ZISC Q
 I $D(IO("Q")) S ZTDESC="NEW ENTRIES TO FILE 200 LIST",ZTRTN="LIST^PRSX4",ZTSAVE("^TMP($J,")="" D ^%ZTLOAD D KILL,^%ZISC Q
 U IO D LIST D ^%ZISC
KILL K ^TMP($J),%,DA,DIC,DIR,DIROUT,DIRUT,DD,DFN,DLAYGO,DO,DTOUT,DUOUT,NAME,NCNT,NODE,PAGE,POP,SSN,TCNT,X,Y,ZTDESC,ZTRTN,ZTSAVE
 Q
SET ; add to 200 if no match
 S NODE=$G(^PRSPC(DFN,0))
 S NAME=$P(NODE,"^",1) I NAME="" S NAME="`"_DFN,^TMP($J,"NOTADDED",NAME,DFN)="NO NAME" Q
 S SSN=$P(NODE,"^",9) I SSN'?9N S ^TMP($J,"NOTADDED",NAME,DFN)="BAD SSN" Q
 S DA=$O(^VA(200,"SSN",SSN,0)) I DA S ^TMP($J,"NOTADDED",NAME,DFN)="SSN IS BEING USED" Q
 K DD,DIC,DO S DIC="^VA(200,",DIC(0)="L",DLAYGO=200,X=NAME,DIC("DR")="9///"_SSN D FILE^DICN
 I $P(Y,"^",3)=1 S ^TMP($J,"ADDED",NAME,DFN)=SSN_"^"_+Y,^PRSPC("A200",DFN)=+Y,^PRSPC("A450",+Y)=DFN W "."
 E  S ^TMP($J,"NOTADDED",NAME,DFN)=SSN W "."
 Q
LIST ; list employees added to 200
 S NAME="",(PAGE,TCNT)=0
 D HEADER
 F  S NAME=$O(^TMP($J,"ADDED",NAME)) Q:NAME=""  S DFN=0 F  S DFN=$O(^TMP($J,"ADDED",NAME,DFN)) Q:DFN<1  D
 .S SSN=$P(^TMP($J,"ADDED",NAME,DFN),"^"),TCNT=TCNT+1
 .W !,NAME,?30,$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9),?45,DFN,?60,$P(^TMP($J,"ADDED",NAME,DFN),"^",2)
 W !!,"# of entries added to FILE 200: ",TCNT
 Q:'$D(^TMP($J,"NOTADDED"))
 S NAME="",(PAGE,NCNT)=0
 D HEADER1
 F  S NAME=$O(^TMP($J,"NOTADDED",NAME)) Q:NAME=""  S DFN=0 F  S DFN=$O(^TMP($J,"NOTADDED",NAME,DFN)) Q:DFN<1  S NCNT=NCNT+1 W !,NAME,?30,DFN,?45,^TMP($J,"NOTADDED",NAME,DFN)
 W !!,"# of entries not added to FILE 200: ",NCNT
 Q
HEADER ; header for entries added to file 200
 W:$Y>0 @IOF
 S PAGE=PAGE+1
 D NOW^%DTC S Y=% D DD^%DT W ?63,Y
 W !,"LIST OF EMPLOYEES ADDED TO FILE 200",?70,"PAGE: ",PAGE
 W !,"NAME",?30,"SSN",?45,"FILE 450#",?60,"FILE 200#",!,"----",?30,"---",?45,"---------",?60,"---------",!
 Q
HEADER1 ; header for entries not added to file 200
 W:$Y>0 @IOF
 S PAGE=PAGE+1
 D NOW^%DTC S Y=% D DD^%DT W ?63,Y
 W !,"LIST OF EMPLOYEES NOT ADDED TO FILE 200",?70,"PAGE: ",PAGE
 W !,"NAME",?30,"FILE 450#",?45,"REMARK",!,"----",?30,"---------",?45,"------",!
 Q
