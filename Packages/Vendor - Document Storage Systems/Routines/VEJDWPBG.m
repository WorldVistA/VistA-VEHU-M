VEJDWPBG ;WPB/CAM routine modified for dental GUI;8/1/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;;SLC/DCM - List Manager routine - Detailed consult display and printing ;7/16/98  02:00
 ;GMRCSLM2;3.0;CONSULT/REQUEST TRACKING;**1,4**;DEC 27,1997
DT(GMRCO) ;;Entry point to set-up detailed display.
 ;;Pass in GMRCO as +GMRCO - a number only. GMRCO=IEN from of consult from file 123
 ;;Results are placed in ^TMP("GMRCR",$J,"DT",
 ;;Pass in variable GMRCOER=2 if calling from the GUI, GMRCOER=1 if call is from CPRS consults tab
 ;;Pass in variable GMRCOER=0 (or as <UNDEFINED>) if call is from consults routines
 K GMRCQUT
 N DFN,GMRCD,GMRCDA,ORIFN,GMRCSF S GMRCDVDL="",$P(GMRCDVDL,"-",80)=""
 I $S('GMRCO:1,'$D(^GMR(123,+GMRCO,0)):1,1:0) D:$S('$D(GMRCOER):1,'GMRCOER:1,1:0)  S GMRCQUT=1 Q
 .S GMRCMSG="The consult entry selected for the Detailed Display is unknown." D EXAC^VEJDWPBH(GMRCMSG) K GMRCMSG
 .Q
 K ^TMP("GMRCR",$J,"DT") S TAB="",$P(TAB," ",30)="",GMRCCT=1
 S GMRCO(0)=^GMR(123,+GMRCO,0),ORIFN=$P(GMRCO(0),"^",3),DFN=$P(GMRCO(0),"^",2)
 S X="SDUTL3" X ^%ZOSF("TEST") I  D
 .N PR S PR=$$OUTPTPR^SDUTL3(DFN) I $L(PR) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Current PC Provider:   "_$P(PR,"^",2),GMRCCT=GMRCCT+1
 .S PR=$$OUTPTTM^SDUTL3(DFN) I $L(PR) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Current PC Team:       "_$P(PR,"^",2),GMRCCT=GMRCCT+1
 .Q
 N VAIN,VAEL
 D INP^VADPT S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Current Pat. Status:   "_$S(+VAIN(8):"Inpatient",1:"Outpatient"),GMRCCT=GMRCCT+1
 I $D(VAIN(4)),$L($P(VAIN(4),"^",2)) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Ward:"_$E(TAB,1,18)_$P(VAIN(4),"^",2),GMRCCT=GMRCCT+1
 D ELIG^VADPT
 I $L($P(VAEL(6),"^",2)) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Eligibility:"_$E(TAB,1,11)_$P(VAEL(6),"^",2),GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Order Information",GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="To Service:"_$E(TAB,1,12)_$P($G(^GMR(123.5,+$P(GMRCO(0),"^",5),0)),"^"),GMRCCT=GMRCCT+1
 I $P(GMRCO(0),"^",11) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Attention:"_$E(TAB,1,13)_$P($G(^VA(200,$P(GMRCO(0),"^",11),0)),"^"),GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="From Service:"_$E(TAB,1,10)_$P($G(^SC(+$P(GMRCO(0),"^",6),0)),"^"),GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Requesting Provider: "_$E(TAB,1,2)_$S($P(GMRCO(0),"^",14)]"":$P($G(^VA(200,$P(GMRCO(0),"^",14),0)),"^",1),1:""),GMRCCT=GMRCCT+1
 I $L($P(GMRCO(0),"^",18)) D
 .S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Service is to be rendered on an "_$S($P(GMRCO(0),"^",18)="I":"INPATIENT",1:"OUTPATIENT")_" basis",GMRCCT=GMRCCT+1
 .Q
 I $P(GMRCO(0),"^",10) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Place:"_$E(TAB,1,17)_$P($G(^ORD(101,+$P(GMRCO(0),"^",10),0)),"^",2),GMRCCT=GMRCCT+1
 I $P(GMRCO(0),"^",9) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Urgency:"_$E(TAB,1,15)_$P($G(^ORD(101,+$P(GMRCO(0),"^",9),0)),"^",2),GMRCCT=GMRCCT+1
 S X="ORX8" X ^%ZOSF("TEST")
 ; blj/dss 14/6/2000  The entry point $$OI^ORX8 is no longer present.
 ; S X="ORX8" X ^%ZOSF("TEST") I  D
 ; .S GMRCOITM=$$OI^ORX8(ORIFN)
 ; .S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Orderable Item:"_$E(TAB,1,8)_$P(GMRCOITM,U,2),GMRCCT=GMRCCT+1
 ; .Q
 S GMRCPRNM=$P(GMRCO(0),"^",8),GMRCPROC=$S(+GMRCPRNM:$P($G(^ORD(101,+GMRCPRNM,0)),"^",2),1:"Consult Request")
 I $L(GMRCPROC) D
 .S GMRCTYPE=$S(+$P(GMRCO(0),"^",17):$P(^ORD(101,+$P(GMRCO(0),"^",17),0),"^"),1:"")
 .S GMRCTYPE=$S(GMRCTYPE="GMRCOR REQUEST":"Procedure",1:"Request Type")
 .S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=GMRCTYPE_":"_$E(TAB,1,22-$L(GMRCTYPE))_GMRCPROC,GMRCCT=GMRCCT+1
 .Q
 S GMRCD=$G(^GMR(123,+GMRCO,30)) I $L(GMRCD) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Provisional Diagnosis: "_GMRCD,GMRCCT=GMRCCT+1
 I $D(^GMR(123,+GMRCO,20,0)) D
 .I $O(^GMR(123,+GMRCO,20,1)) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Reason For Request:",GMRCCT=GMRCCT+1 D  Q
 ..S LN=0 F  S LN=$O(^GMR(123,+GMRCO,20,LN)) Q:LN=""  S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=^(LN,0),GMRCCT=GMRCCT+1
 ..Q
 .S FLG=1,LINE="Reason For Request:"_$E(TAB,1,4)
 .; blj/dss 14/6/2000 Routine VEGMRCUTIL doesn't exist anymore. 
 .; D WPSET^VEGMRCUTIL("^GMR(123,+GMRCO,20)","^TMP(""GMRCR"",$J,""DT"")",LINE,.GMRCCT,TAB,FLG)
 .Q
 S GMRCCT=GMRCCT+1,^TMP("GMRCR",$J,"DT",GMRCCT,0)=" ",GMRCCT=GMRCCT+1
 ;get status, last action, and significant findings
 S STS=$P(GMRCO(0),"^",12),^TMP("GMRCR",$J,"DT",GMRCCT,0)="Status:  "_$E(TAB,1,14)_$S($D(^ORD(100.01,+STS,0)):$P(^(0),"^",1),1:$P(^ORD(100.01,6,0),"^",1)),GMRCCT=GMRCCT+1
 S GMRCA=$P(^GMR(123,+GMRCO,0),"^",13),^TMP("GMRCR",$J,"DT",GMRCCT,0)="Last Action:"_$E(TAB,1,11)_$S(+GMRCA:$P($G(^GMR(123.1,GMRCA,0)),"^",1),1:""),GMRCCT=GMRCCT+1
 I $L($P(GMRCO(0),"^",19)) D
 .S GMRCSF=$P(GMRCO(0),"^",19)
 .S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Significant Findings:  "_$S(GMRCSF="Y":"YES",GMRCSF="N":"NO",1:"Unknown")
 .S GMRCCT=GMRCCT+1
 .Q
 D ACTLOG^VEJDWPBI(+GMRCO)
 D GETRSLTS^VEJDWPBK(GMRCO,.GMRCAR) ;GMRCAR=Array results from TIU and Medicine Package is returned in
 I $O(GMRCAR(0)) S GMRCND=0 F  S GMRCND=$O(GMRCAR(GMRCND)) Q:GMRCND=""  D
 .I $E($P(GMRCND,";",2),1,4)="MCAR" S GMRCSR=GMRCND D  Q
 ..S MCFILE=$P(GMRCSR,";",2),MCFILE=$P(MCFILE,","),MCPROC=$O(^MCAR(697.2,"C",MCFILE,"")) Q:'MCPROC  S GMRCPRNM=$P(^MCAR(697.2,MCPROC,0),"^",8)
 ..; blj/dss 14/6/2000 Routine VEGMRCSLM3 isn't here, and would be illegal even if it were here.
 ..; D EN^VEGMRCSLM3(+GMRCO,GMRCSR,.GMRCCT)
 ..S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 ..Q
 .I $E($P(GMRCND,";",2),1,3)="TIU" S DR=".01;.05;.09;1201;1202;1204;1208;1302;1501",GMRCTUFN=$P(GMRCND,";",1) D
 ..S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 ..D EXTRACT^TIULQ(GMRCTUFN,"LOCAL",.GMRCERR,DR)
 ..I '$O(LOCAL("")) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="No TIU results exist for Note # "_GMRCTUFN_".",GMRCCT=GMRCCT+1,^TMP("GMRCR",$J,"DT",GMRCCT,0)="The Note has been DELETED from TIU!!",GMRCCT=GMRCCT+1 Q
 ..; I '$L($G(LOCAL(GMRCTUFN,1501,"E"))) D TIU^VEGMRCSLMU(GMRCTUFN,.GMRCCT,.LOCAL) K LOCAL Q
 ..K GMRCCNM
 ..S GMRCTUFN=$P(GMRCND,";",1)
 ..S:$L(LOCAL(GMRCTUFN,.01,"E")) GMRCCNM=LOCAL(GMRCTUFN,.01,"E"),^TMP("GMRCR",$J,"DT",GMRCCT,0)="",$P(^(0),"-",80-$L(GMRCCNM)\2)="",^(0)=^(0)_" "_GMRCCNM_" "_^(0),GMRCCT=GMRCCT+1
 ..K LOCAL
 ..; blj/dss 14/6/2000 Routine VEGMRCTIU isn't here, either.  Sheesh, doesn't anyone read the SAC anymore?
 ..;D DSPLAY^VEGMRCTIU(GMRCTUFN,.GMRCCT)
 ..S GMRCCT=GMRCCT+1,^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 ..K DR
 ..Q
 .Q
 I $S('$D(GMRCOER):1,'GMRCOER:1,1:0),$D(VALMAR) D CLEAN^VALM10
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",$P(^(0),"=",80)="",^(0)=$E(^(0),1,36)_" END "_$E(^(0),43,80)
DTQ K X,LN,PL,TO,WP,FLG,SEX,STS,URG,WRD,BKLN,DATA,WRD,PROC,LINE,GMRC(0),GMRC(40),GMRCD,GMRCDVDL,GMRCO,GMRCAR,GMRCRB,GMRCLA,GMRCSR,GMRCTO,MCFILE,MCPROC,DSPLINE,GMRCLA1,GMRCPRNM,GMRCPROC,GMRCTYPE,GMRCWARD
 I $D(GMRCOER),'GMRCOER D:$D(VALMEVL) KILL^VALM10() D:$D(VALMAR) CLEAN^VALM10
 Q
