DGYEPRN ;ALB/MTC - EPRP PRINT ROUTINE ; 08 Sep 95 / 3:14 PM
 ;;1.0; DGYE ;**7,9,12,15,16**;28 Apr 92
 ;
EN ;-- main entry 
 S DGYER="Unknown",X="RTUTL3" X ^%ZOSF("TEST") S DGYE5=$T
 ;
 N COUNT
 ; get records
 D GETREC^DGYEPRP(DATE,.COUNT),^DGYEOP
 D START(DATE,COUNT)
 Q
 ;
START(MY,TD) ;--report
 ; INPUT : MY- month/year of search in the format
 ;  yyymm00^FEB 1991 (display format)
 ;         TD- total discharges for the month/year selected.      
 ;
 U IO
 I '$D(^TMP("DGYE",$J)) W !,">>> ERROR ^TMP GLOBAL NOT SET-UP." G ENQ
 N DGYEPG,DGYEDT,Y,PTF,I,DGYECNT,RTOTAL,DGYEUSED,SEQ,EFLAG
 S DGYEPG=0,EFLAG=""
 D NOW^%DTC S Y=%,DGYEPG=0 X ^DD("DD") S DGYEDT=Y
 D HEAD
 S I="" F  S I=$O(^TMP("DGYE",$J,"TASK",I)) Q:I']""  S RTOTAL=$$REVIEW^DGYEUTL1(I),SEQ=0 I RTOTAL]"" K DGYEUSED D  G:EFLAG ENQ
 .F PTF=0:0 S PTF=$$NEXTPTF(PTF,RTOTAL,.SEQ,I) Q:'PTF  D LITEMS(PTF,I) Q:EFLAG  S DGYECNT(I)=$G(DGYECNT(I))+1,^TMP("DGYEML",$J,I,PTF)=DGYER
 D PRINT^DGYEOP,FOOT($P(MY,U,2),TD)
ENQ D ^DGYEMAIL Q
 ;
HEAD ;--header
 N Y
 I DGYEPG>0,$P(IOST,"-")="C" S DIR(0)="E" D ^DIR K DIR I 'Y S EFLAG=1 Q
 S DGYEPG=DGYEPG+1
 W @IOF
 W ?25,$P(^XMB("NETNAME"),".")," EXTERNAL PEER REVIEW",?95,DGYEDT,?120,"PAGE ",DGYEPG
 W !!,?46,"ADMISSION",?58,"DISCHARGE"
 W !,"SSN",?15,"PTF #",?22,"PATIENT NAME",?49,"DATE",?61,"DATE",?67,"DISCHARGE BEDSECTION",?91,"PROVIDER",?119,"TASK",?124,"OS FLAG"
 S $P(Y,"=",132)="" W !,Y
 Q
 ;
SUBHEAD ;--header for movements
 W !,"MOVE#",?7,"DISC.DATE",?18,"LOSING BEDSECTION"
 Q
 ;
FOOT(MY,TD) ;--footer for report
 ; INPUT: MY - month/year of report.  In display format.
 ;        TD - total discharges for month/year selected
 N I
 W @IOF
 W !,$P(^XMB("NETNAME"),"."),!
 W !?10,"===  SUMMARY PAGE ==="
 W !!,"DISCHARGE MONTH-YEAR: ",MY
 W !!,"Totals by Task:"
 S I="" F  S I=$O(DGYECNT(I)) Q:I']""  W !?15,I," ",+DGYECNT(I)
 W !!,"TOTAL PATIENTS DISCHARGED IN ",MY,": ",TD,@IOF
 Q
 ;
LITEMS(PTF,TASK) ;--line items for EPRP report
 ;  Print information for the PTF record
 ;  designated by PTF.
 ;    INPUT : PTF - PTF record number.
 ;
 N DPT0,DGPT0,DGPT70,FLAG,I,J,PROV,Y,OS
 S FLAG=0,OS=""
 ;--get info from patient file (0 node)
 S DPT0=$G(^DPT($P(^DGPT(PTF,0),U),0)) Q:DPT0']""
 I DGYE5 S RTE=+^DGPT(PTF,0)_";DPT(" D MED^RTUTL3 S DGYER=$S($P(RTDATA,"^",3)["/":$P($P(RTDATA,"^",3),"/",2),1:"Unknown")
 ;--get 0 node of the PTF record
 S DGPT0=$G(^DGPT(PTF,0)) Q:DGPT0']""
 ;--get 70 node of the PTF record
 S DGPT70=$G(^DGPT(PTF,70)) Q:DGPT70']""
 ;--get provider information
 S PROV=$$PROV^DGYEUTL(PTF),PROV=$P(PROV,U)_"/"_$P(PROV,U,2)
 ;--call to fuction for EPRP to look at QA
 S OS=$S($$QA^QIEQA($P(DGPT0,"^"),$P(DGPT0,"^",2),$P(DGPT70,"^")):"*",1:"")
 ;--check if page is full
 I $Y>(IOSL-10) D HEAD G:EFLAG LITMQ
 W !!,$P(DPT0,U,9),?15,PTF,?22,$P(DPT0,U),?48,$$CVTDATE^DGYEUTL($P(DGPT0,U,2)),?61,$$CVTDATE^DGYEUTL($P(DGPT70,U)),?74,$P(^DIC(42.4,+$P(DGPT70,U,2),0),U),?89,"  ",$E(PROV,1,28),?119,TASK,?124,OS
 W !,?10,"DOB: ",$$CVTDATE^DGYEUTL($P(DPT0,U,3)),"     Sex: ",$P(DPT0,U,2),"     Race: ",$S($P(DPT0,U,6):$P(DPT0,U,6),1:"Unk"),"     Disposition: ",$S($P(DGPT70,U,3)<6:"Alive",1:"Dead"),"          Chart Location: ",DGYER
 F I="M","S","P" I $D(^TMP("DGYE",$J,PTF,I)) D
 .F J=0:0 S J=$O(^TMP("DGYE",$J,PTF,I,J)) Q:'J  D @I
 S Y=$P(DPT0,"^",9),^TMP("DGYEPL",$J,$E(Y,8,9)_$E(Y,6,7)_$E(Y,4,5)_$E(Y,1,3),$P(DGPT70,"^"))=$P(DPT0,"^")_"^"_DGYER
 S Y="",$P(Y,"-",132)="" W !,Y
LITMQ Q
 ;
M ;-- print movement information (501)
 N MOVE,I,Y
 ;--print sub header once
 I 'FLAG D SUBHEAD S FLAG=1
 S MOVE=$G(^DGPT(PTF,"M",J,0)) Q:MOVE']""
 W !,J,?7,$$CVTDATE^DGYEUTL($P(MOVE,U,10)),?18,$P(^DIC(42.4,+$P(MOVE,U,2),0),U)
 W !?45,"ICD CODES: "
 F I=5:1:9 S Y=$G(^ICD9(+$P(MOVE,U,I),0)) W:Y]"" $P(Y,U)," "
 Q
 ;
S ;-- print surgery information (401)
 N SUR,I,Y
 S SUR=$G(^DGPT(PTF,"S",J,0)) Q:SUR']""
 W !?45,"S/P CODES: "
 F I=8:1:12 S Y=$G(^ICD0(+$P(SUR,U,I),0)) W:Y]"" $P(Y,U)," "
 Q
 ;
P ;-- print procedure information (601)
 N PROC,I,Y
 S PROC=$G(^DGPT(PTF,"P",J,0)) Q:PROC']""
 W !?45,"S/P CODES: "
 F I=4:1:8 S Y=$G(^ICD0(+$P(PROC,U,I),0)) W:Y]"" $P(Y,U)," "
 Q
 ;
NEXTPTF(PTF,COUNT,SEQ,TASK) ; Select PTF record at ramdom
 ; for those tasks that do not require all PTF records printed.
 ; The current PTF record along the the maximum number to print 
 ; for the task are required to make that determination. 
 ;  INPUT  : PTF - current PTF record, 0 to start at top of list
 ;           COUNT - maximum to print for task.
 ;           SEQ  - current sequence number
 ;           TASK  - current task
 ;  OUTPUT : The next PTF record to print, NULL for none.
 N RESULT
 S RESULT=0
 ;-- printed N records for task... so exit
 I COUNT>0,$D(DGYECNT(TASK)),DGYECNT(TASK)=COUNT G NEXTQ
 ;-- print all records for a given task
 I (COUNT=0)!(^TMP("DGYE",$J,"TASK",TASK,0)'>COUNT) S SEQ=$O(^TMP("DGYE",$J,"TASK",TASK,SEQ)) S:SEQ RESULT=$O(^TMP("DGYE",$J,"TASK",TASK,SEQ,0)) G NEXTQ
 ;-- get next PTF record to print
RAN S X=$R(^TMP("DGYE",$J,"TASK",TASK,0))+1
 I $D(DGYEUSED(X)) G RAN
 S SEQ=X,RESULT=$O(^TMP("DGYE",$J,"TASK",TASK,SEQ,0)),DGYEUSED(SEQ)=""
NEXTQ Q RESULT
 ;
