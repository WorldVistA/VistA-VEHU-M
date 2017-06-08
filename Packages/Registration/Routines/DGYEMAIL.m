DGYEMAIL ; B'ham ISC/DMA - E-mail pull list information to G.WVMI@FORUM  ; 08 Sep 95 / 1:57 PM
 ;;1.0; DGYE ;**9,12,15,16**;28 Apr 92
 ;create and send mail message from ^TMP("DGYEML",$J) which is built
 ;in DGYEPRN as the pull list is printed
 ;
 ;print file room pull list in terminal digit order
 D HEAD
 S J="" F  S J=$O(^TMP("DGYEPL",$J,J)),D="" Q:J=""  F  S D=$O(^TMP("DGYEPL",$J,J,D)) Q:D=""  S NA=^(D) W !,?5,$E(J,7,9),"-",$E(J,5,6),"-",$E(J,3,4),$E(J,1,2),?35,$$FMTE^XLFDT($P(D,".")),?60,$P(NA,"^"),?95,$P(NA,"^",2) I $Y+5>IOSL D HEAD
 D ^%ZISC
 S XMDUZ="EPRP SYSTEM",XMSUB="PULL LIST FROM "_$P(^XMB("NETNAME"),".")
 S XMY("G.WVMI@FORUM.VA.GOV")=""
 D XMZ^XMA2
 S ^XMB(3.9,XMZ,2,1,0)="      "_$P(^XMB("NETNAME"),".")_" EXTERNAL PEER REVIEW   "_DGYEDT
 F L=2:1:4 S ^XMB(3.9,XMZ,2,L,0)=" "
 S WVH="",$P(WVH," ",49)="",WVH=WVH_"ADMISSION    DISCHARGE",^XMB(3.9,XMZ,2,5,0)=WVH
 S ^XMB(3.9,XMZ,2,6,0)="  SSN         PTF #   PATIENT NAME                 DATE        DATE      TASK"
 S WVH="",$P(WVH,"=",79)="",^XMB(3.9,XMZ,2,7,0)=WVH,WVH="",$P(WVH,"-",79)="",L=8
 S TASK="" F  S TASK=$O(^TMP("DGYEML",$J,TASK)),PTF=0 Q:TASK=""  F  S PTF=$O(^TMP("DGYEML",$J,TASK,PTF)) Q:'PTF  D
 .S DGPT0=$G(^DGPT(PTF,0)) Q:DGPT0=""  S DGPT70=^(70) Q:DGPT70=""  S DPT0=$G(^DPT(+DGPT0,0)) Q:DPT0=""
 .S ^XMB(3.9,XMZ,2,L,0)=$$LJ^XLFSTR($P(DPT0,U,9),15)_$$LJ^XLFSTR(PTF,7)_$$LJ^XLFSTR($P(DPT0,U),26)_$$LJ^XLFSTR($$CVTDATE^DGYEUTL($P(DGPT0,U,2)),13)_$$LJ^XLFSTR($$CVTDATE^DGYEUTL($P(DGPT70,U)),13)_TASK,L=L+1
 .S ^XMB(3.9,XMZ,2,L,0)="          DOB: "_$$CVTDATE^DGYEUTL($P(DPT0,U,3))_"     Sex: "_$P(DPT0,U,2)_"     Race: "_$S($P(DPT0,U,6):$P(DPT0,U,6),1:"Unk")_"     Disposition: "_$S($P(DGPT70,U,3)<6:"Alive",1:"Dead"),L=L+1
 .S ^XMB(3.9,XMZ,2,L,0)=WVH,L=L+1
 F L=L:1:L+5 S ^XMB(3.9,XMZ,2,L,0)=" "
 S ^XMB(3.9,XMZ,2,L,0)=WVH,L=L+1
 S ^XMB(3.9,XMZ,2,L,0)="         "_$$LJ^XLFSTR("SSN",16)_$$LJ^XLFSTR("PATIENT NAME",47)_"TASK",L=L+1,$P(^XMB(3.9,XMZ,2,L,0),"=",79)="",L=L+1
 S TSK="" F  S TSK=$O(^TMP("DGYEnML",$J,TSK)),D0=0 Q:TSK=""  F  S D0=$O(^TMP("DGYEnML",$J,TSK,D0)) Q:D0=""  S DATA=^(D0) D
 .S ^XMB(3.9,XMZ,2,L,0)="     "_$$LJ^XLFSTR($P(DATA,"^",9),15)_$$LJ^XLFSTR($P(DATA,"^"),52)_TSK,L=L+1
 .S ^XMB(3.9,XMZ,2,L,0)="       DOB: "_$$CVTDATE^DGYEUTL($P(DATA,"^",3))_"     Sex: "_$P(DATA,"^",2)_"     Race: "_$P(DATA,"^",6),L=L+1
 .S ^XMB(3.9,XMZ,2,L,0)=WVH,L=L+1
 F L=L:1:L+5 S ^XMB(3.9,XMZ,2,L,0)=" "
 S ^XMB(3.9,XMZ,2,L,0)=$P(^XMB("NETNAME"),"."),L=L+1,^XMB(3.9,XMZ,2,L,0)="         === SUMMARY PAGE ===",L=L+1,^XMB(3.9,XMZ,2,L,0)=" ",L=L+1,^XMB(3.9,XMZ,2,L,0)="DISCHARGE MONTH-YEAR:  "_$P(MY,"^",2),L=L+1
 S ^XMB(3.9,XMZ,2,L,0)=" ",L=L+1,^XMB(3.9,XMZ,2,L,0)="  Totals by Task",L=L+1
 S TASK="" F  S TASK=$O(DGYECNT(TASK)) Q:TASK=""  S ^XMB(3.9,XMZ,2,L,0)="           "_TASK_"    "_DGYECNT(TASK),L=L+1
 S ^XMB(3.9,XMZ,2,L,0)=" ",L=L+1,^XMB(3.9,XMZ,2,L,0)="  TOTAL PATIENTS DISCHARGED IN :"_$P(MY,"^",2)_":  "_TD,L=L+1
 F L=L:1:L+5 S ^XMB(3.9,XMZ,2,L,0)=" "
 S ^XMB(3.9,XMZ,2,L,0)="         CHART LOCATION LIST",L=L+1
 S ^XMB(3.9,XMZ,L,0)=$$RJ^XLFSTR("NAME",10)_$$RJ^XLFSTR("CHART LOCATION",55),L=L+1
 S TASK="" F  S TASK=$O(^TMP("DGYEML",$J,TASK)),PTF=0 Q:TASK=""  F  S PTF=$O(^TMP("DGYEML",$J,TASK,PTF)) Q:'PTF  D
 .S DGPT0=$G(^DGPT(PTF,0)) Q:DGPT0=""  S DGPT70=^(70) Q:DGPT70=""  S DPT0=$G(^DPT(+DGPT0,0)) Q:DPT0=""  S ^XMB(3.9,XMZ,2,L,0)=$$LJ^XLFSTR("  "_$P(DPT0,"^"),50)_$$RJ^XLFSTR(^TMP("DGYEML",$J,TASK,PTF),20),L=L+1
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_L_"^"_L_"^"_DT
 D ENT1^XMD
 K DGPT0,DGPT70,DPT0,L,PTF,TASK,WVH,XMDUZ,XMSUB,XMY,^TMP("DGYEML",$J),^TMP("DGYEPL",$J),^TMP("DGYEnML",$J) Q
 ;
HEAD  W:$Y @IOF W !,?30,"EXTERNAL PEER REVIEW",!,?33,"FILE ROOM LIST",!!!,?8,"SSN",?34,"DISCHARGE",?62,"NAME",?99,"CHART",!,?37,"DATE",?97,"LOCATION",! Q
