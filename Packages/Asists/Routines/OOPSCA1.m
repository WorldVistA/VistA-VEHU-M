OOPSCA1 ;WIOFO/CAH-CA1 DISPLAY ;12/02/99
 ;;1.0;ASISTS;**6,8,11**;Jun 01, 1998
CA1(IEN,CALL) ;
CA1PG1 N LIN S PG=0,EX="",LIN=$S(($E(IOST,1,2)="C-"):IOSL-2,1:IOSL-6)
 K DIQ,DA,DR
 S DIC="^OOPS(2260,"
 S DR=".01;1;4:12;15:17;60:63;70;107;108;110:118;121:124;126:136;138:149;150:169;171:174;175:185",DA=IEN,DIQ="OOPS"
 D EN^DIQ1
 ; Get witness data
 K DR
 N WIT,LSR
 S LSR=$P($G(^OOPS(2260,IEN,"CA1W",0)),U,3)
 S WIT=$O(^OOPS(2260,IEN,"CA1W",0))
 I $G(WIT) D
 . S DR="125",DR(2260.0125)=".01:7",DA=IEN
 . F II=WIT:1:LSR  I $D(^OOPS(2260,IEN,"CA1W",II)) S DA(2260.0125)=II D EN^DIQ1
 D HDR
 W !,"NAME OF EMPLOYEE...............: ",OOPS(2260,IEN,1) D P Q:EX=U
 W !,"SSN............................: ",OOPS(2260,IEN,5) D P Q:EX=U
 W !,"DOB............................: ",OOPS(2260,IEN,6) D P Q:EX=U
 W !,"SEX............................: ",OOPS(2260,IEN,7) D P Q:EX=U
 W !,"HOME TELEPHONE.................: ",OOPS(2260,IEN,12) D P Q:EX=U
 W !,"GRADE/STEP.....................: ",OOPS(2260,IEN,16) W:OOPS(2260,IEN,16)'="" "/" W OOPS(2260,IEN,17) D P Q:EX=U
 W !,"PAY PLAN.......................: ",OOPS(2260,IEN,63) D P Q:EX=U
 W !,"EMPLOYEE'S ADDRESS.............: ",OOPS(2260,IEN,8) D P Q:EX=U
 W !,"CITY...........................: ",OOPS(2260,IEN,9) D P Q:EX=U
 W !,"STATE..........................: ",OOPS(2260,IEN,10) D P Q:EX=U
 W !,"ZIP............................: ",OOPS(2260,IEN,11) D P Q:EX=U
 W !,"DEPENDENTS.....................: ",OOPS(2260,IEN,107) D P Q:EX=U
 W !,"PLACE WHERE INJURY OCCURRED....: ",OOPS(2260,IEN,108) D P Q:EX=U
 W !,"STREET WHERE INJURY OCCURRED...: ",OOPS(2260,IEN,183) D P Q:EX=U
 W !,"CITY WHERE INJURY OCCURRED.....: ",OOPS(2260,IEN,184) D P Q:EX=U
 W !,"STATE WHERE INJURY OCCURRED....: ",OOPS(2260,IEN,185) D P Q:EX=U
 W !,"ZIP CODE WHERE INJURY OCCURRED.: ",OOPS(2260,IEN,181) D P Q:EX=U
 W !,"DATE/TIME OF OCCURRENCE........: ",OOPS(2260,IEN,4) D P Q:EX=U
 W !,"DATE OF THIS NOTICE............: ",OOPS(2260,IEN,110) D P Q:EX=U
 W !,"EMPLOYEE'S OCCUPATION..........: ",OOPS(2260,IEN,111) D P Q:EX=U
 W !,"CAUSE OF INJURY CODE...........: ",OOPS(2260,IEN,126) D P Q:EX=U
 W !,"CAUSE OF INJURY................: ",OOPS(2260,IEN,112) D P Q:EX=U
 W !,"NATURE OF INJURY...............: ",OOPS(2260,IEN,113) D P Q:EX=U
 W !,"REQUEST PAY OR LEAVE...........: ",OOPS(2260,IEN,114) D P Q:EX=U
 W !,"EMPLOYEE DATE OF SIGNATURE.....: ",OOPS(2260,IEN,121) D P Q:EX=U
 I $D(OOPS(2260.0125)) F II=WIT:1:LSR I $D(OOPS(2260.0125,II)) D  Q:EX=U
 .W !,"WITNESS INFORMATION:"
 .W !,"NAME OF WITNESS................: ",OOPS(2260.0125,II,.01) D P Q:EX=U
 .W !,"WITNESS ADDRESS................: ",OOPS(2260.0125,II,1) D P Q:EX=U
 .W !,"WITNESS CITY...................: ",OOPS(2260.0125,II,2) D P Q:EX=U
 .W !,"WITNESS STATE..................: ",OOPS(2260.0125,II,3) D P Q:EX=U
 .W !,"WITNESS ZIP CODE...............: ",OOPS(2260.0125,II,4) D P Q:EX=U
 .W !,"DATE OF WITNESS SIGNATURE......: ",OOPS(2260.0125,II,5) D P Q:EX=U
 .W !,"STATEMENT OF WITNESS...........: ",OOPS(2260.0125,II,6) D P Q:EX=U
 I CALL="E" D  G KILL
 .I $E(IOST,1,2)="C-" W ! K DIR S DIR(0)="E" D ^DIR W @IOF
CA1PG2 ;
 ; Changed from field 122 to 15
 W !,"OCCUPATION CODE................: ",OOPS(2260,IEN,15) D P Q:EX=U
 W !,"NOI CODE.......................: ",OOPS(2260,IEN,62) D P Q:EX=U
 W !,"TYPE CODE......................: ",OOPS(2260,IEN,123) D P Q:EX=U
 W !,"SOURCE CODE....................: ",OOPS(2260,IEN,124) D P Q:EX=U
 W !,"OWCP CHARGEBACK CODE...........: ",OOPS(2260,IEN,70) D P Q:EX=U
 D:$D(OOPS(2260,IEN,130))  Q:EX=U
 .W !,"AGENCY NAME....................: ",OOPS(2260,IEN,130) D P Q:EX=U
 .W !,"AGENCY ADDRESS.................: ",OOPS(2260,IEN,131) D P Q:EX=U
 .W !,"AGENCY CITY....................: ",OOPS(2260,IEN,132) D P Q:EX=U
 .W !,"AGENCY STATE...................: ",OOPS(2260,IEN,133) D P Q:EX=U
 .W !,"AGENCY ZIP CODE................: ",OOPS(2260,IEN,134) D P Q:EX=U
 D:$D(OOPS(2260,IEN,176))  Q:EX=U
 .W !,"EMPLOYEE'S DUTY STATION........: ",OOPS(2260,IEN,176) D P Q:EX=U
 .W !,"DUTY STATION ADDRESS...........: ",OOPS(2260,IEN,177) D P Q:EX=U
 .W !,"DUTY STATION CITY..............: ",OOPS(2260,IEN,178) D P Q:EX=U
 .W !,"DUTY STATION STATE.............: ",OOPS(2260,IEN,179) D P Q:EX=U
 .W !,"DUTY STATION ZIP CODE..........: ",OOPS(2260,IEN,180) D P Q:EX=U
 W !,"EMPLOYEE RETIREMENT COVERAGE...: ",OOPS(2260,IEN,60) D P Q:EX=U
 I $D(OOPS(2260,IEN,61)) D  Q:EX=U
 . W !,"EMP RETIREMENT COVERAGE DESC...: ",OOPS(2260,IEN,61) D P Q:EX=U
 W !,"REGULAR HRS FROM TIME..........: ",OOPS(2260,IEN,138) D P Q:EX=U
 W !,"REGULAR HRS TO TIME............: ",OOPS(2260,IEN,139) D P Q:EX=U
 W !,"REGULAR WORK SCHEDULE..........: ",OOPS(2260,IEN,140) D P Q:EX=U
 W !,"DATE OF INJURY.................: ",OOPS(2260,IEN,4) D P Q:EX=U
 W !,"DATE NOTICE RECEIVED...........: ",OOPS(2260,IEN,175) D P Q:EX=U
 W !,"DATE/TIME STOPPED WORK.........: ",OOPS(2260,IEN,142) D P Q:EX=U
 W !,"DATE PAY STOPPED...............: ",OOPS(2260,IEN,143) D P Q:EX=U
 W !,"DATE 45 DAY PERIOD BEGAN.......: ",OOPS(2260,IEN,144) D P Q:EX=U
 W !,"DATE/TIME RETURNED TO WORK.....: ",OOPS(2260,IEN,145) D P Q:EX=U
 W !,"INJURED PERFORMING DUTY........: ",OOPS(2260,IEN,146) D P Q:EX=U
 W !,"NOT INJURED PERFORMING JOB.....: ",OOPS(2260,IEN,147) D P Q:EX=U
 W !,"INJURY CAUSED BY EMPLOYEE......: ",OOPS(2260,IEN,148) D P Q:EX=U
 W !,"CAUSED BY EMPLOYEE EXPLAIN.....: ",OOPS(2260,IEN,149) D P Q:EX=U
 W !,"INJURY CAUSED BY 3RD PARTY.....: ",OOPS(2260,IEN,150) D P Q:EX=U
 D:$D(OOPS(2260,IEN,151))  Q:EX=U
 .W !,"3RD PARTY NAME.................: ",OOPS(2260,IEN,151) D P Q:EX=U
 .W !,"3RD PARTY ADDRESS..............: ",OOPS(2260,IEN,152) D P Q:EX=U
 .W !,"3RD PARTY CITY.................: ",OOPS(2260,IEN,153) D P Q:EX=U
 .W !,"3RD PARTY STATE................: ",OOPS(2260,IEN,154) D P Q:EX=U
 .W !,"3RD PARTY ZIP CODE.............: ",OOPS(2260,IEN,155) D P Q:EX=U
 D:$D(OOPS(2260,IEN,156))  Q:EX=U
 .W !,"PROVIDING PHYSICAN NAME........: ",OOPS(2260,IEN,156) D P Q:EX=U
 .W !,"PROVIDING PHYSICIAN ADDRESS....: ",OOPS(2260,IEN,157) D P Q:EX=U
 .W !,"PROVIDING PHYSICIAN CITY.......: ",OOPS(2260,IEN,158) D P Q:EX=U
 .W !,"PROVIDING PHYSICIAN STATE......: ",OOPS(2260,IEN,159) D P Q:EX=U
 .W !,"PROVIDING PHYSICIAN ZIP CODE...: ",OOPS(2260,IEN,160) D P Q:EX=U
 .W !,"PROVIDING PHYSICIAN TITLE......: ",OOPS(2260,IEN,182) D P Q:EX=U
 W !,"FIRST DATE OF MEDICAL CARE.....: ",OOPS(2260,IEN,161) D P Q:EX=U
 W !,"DISABLED FOR WORK..............: ",OOPS(2260,IEN,162) D P Q:EX=U
 W !,"SUPERVISOR AGREE/DISAGREE......: ",OOPS(2260,IEN,163) D P Q:EX=U
 W !,"SUPERVISOR NOT AGREE EXPLAIN...: "
 S OPFLD=164 D WP K OPFLD Q:EX=U
 W !,"REASON FOR CONTROVERTS COP.....: "
 S OPFLD=165 D WP K OPFLD Q:EX=U
 W !,"PAY RATE WHEN WORK STOPPED.....: ",OOPS(2260,IEN,166),"/",OOPS(2260,IEN,167) D P Q:EX=U
 W !,"SUPERVISOR EXCEPTION...........: ",OOPS(2260,IEN,168) D P Q:EX=U
 D:$D(OOPS(2260,IEN,169))  Q:EX=U
 .W !,"NAME OF SUPERVISOR.............: ",OOPS(2260,IEN,169) D P Q:EX=U
 .W !,"SUPERVISOR'S DATE OF SIGNATURE.: ",OOPS(2260,IEN,171) D P Q:EX=U
 .W !,"SUPERVISOR'S TITLE.............: ",OOPS(2260,IEN,172) D P Q:EX=U
 .W !,"SUPERVISOR'S OFFICE PHONE......: ",OOPS(2260,IEN,173) D P Q:EX=U
 W !,"FILING INSTRUCTIONS............: ",OOPS(2260,IEN,174) D P Q:EX=U
 I $E(IOST,1,2)="C-" W ! K DIR S DIR(0)="E" D ^DIR W @IOF
KILL ;Kill Variables and Exit
 S:$D(ZTQUEUED) ZTREQ="@"
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,IEN,DASHES,OOPS,DA,DO,EX
 K DO,DIQ,DISYS,DIW,DIWI,DIWT,DIWTC,DIWX,DN,DR,I,Z,POP
 Q
P ;PRINT
 I ($Y'<(LIN-3)) D  Q:EX=U
 .I $E(IOST,1,2)="C-" W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HDR Q
 Q
WP ;Process Word Processing Fields
 N DIWL,DIWR,DIWF,OPGLB,OPI,OPNODE,OPT,OPC
 K ^UTILITY($J,"W")
 S DIWL=1,DIWR="",DIWF="|C76"
 S OPNODE=$P($$GET1^DID(2260,OPFLD,"","GLOBAL SUBSCRIPT LOCATION"),";")
 S OPGLB="^OOPS(2260,IEN,OPNODE,OPI)"
 S OPI=0 F  S OPI=$O(@OPGLB) Q:'OPI  S X=$G(^(OPI,0)) D:X]"" ^DIWP
 S OPT=$G(^UTILITY($J,"W",1))+0
 I OPT S OPI=0 F OPC=1:1 S OPI=$O(^UTILITY($J,"W",1,OPI)) Q:'OPI!(EX=U)  D
 .W !?1,^UTILITY($J,"W",1,OPI,0) D P Q:EX=U
 K ^UTILITY($J,"W"),X
 Q
HDR ;HEADER
 W @IOF S PG=PG+1 K DASHES S $P(DASHES,"-",80)="-"
 W !,"Case # ",OOPS(2260,IEN,.01),?73,"Page ",PG
 W !,DASHES
 Q
