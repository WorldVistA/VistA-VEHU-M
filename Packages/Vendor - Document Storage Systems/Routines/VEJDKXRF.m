VEJDKXRF ;DSS/AMC Create X-Ref for field 2 in file 19610.5 ;7/18/02  09:28
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
EN ;
 D:$O(^VEJD(16610.1,0))>0 MOVE
 D:VER<6 REINDX
 D:VER<5.3 CPT
 D:VER<5.3 TRT^VEJDKXR1
 D:VER<6.41 FIX
 Q
 ;
MOVE ;  move data from ^VEJD(16610.1) to ^VEJD(19610.1)
 N X,Y S Y=$P(^VEJD(16610.1,0),U,4)
 S X="    **************  MOVING DATA  **************"
 S X(1)="Moving data from ^VEJD(16610.1) to ^VEJD(19610.1)"
 S X(2)="There are "_Y_" records to move.  This may take awhile"
 D MES^DSICXPDU(.X,1) M ^VEJD(19610.1)=^VEJD(16610.1) K ^VEJD(16610.1)
 Q
 ;
REINDX ;   call FM reindexer for all entries for a single field and xref
 S X="Creating new X-Ref on file 19610.5, field 2" D MES^DSICXPDU(X,1)
 N DA,DIK S DIK="^VEJD(19610.5,",DIK(1)="2^F" K ^VEJD(19610.5,"F")
 D ENALL^DIK
 S X="Reindexing field .02 of file 19610.5" D MES^DSICXPDU(X,1)
 K DA,DIK S DIK="^VEJD(19610.5,",DIK(1)=".02^C" K ^VEJD(19610.5,"C")
 D ENALL^DIK
 Q
 ;
FIX ;  fix up back records and xrefs in file 19610.5
 N I,X,Y,Z,BAD,DA,DIERR,DIK,ERR,IEN,VCNT,VST,VTOT
 S (BAD,IEN,VCNT)=0,VTOT=$$GET1^DID(2,,,"ENTRIES",,"ERR")
 S X="Checking file 19610.5 for bad records"
 D MES^DSICXPDU(X,1),UPDSTAT^DSICXPDU(,,1)
 S DIK="^VEJD(19610.5,"
 F  S IEN=$O(^VEJD(19610.5,IEN)) Q:'IEN  D
 .S VST=$P($G(^VEJD(19610.5,IEN,0)),U),X=$G(^(5)),VCNT=VCNT+1
 .I '(VCNT#100) D UPDSTAT^DSICXPDU(VTOT,VCNT)
 .;  delete any entry with no .01 field or patient or visit date.time
 .K DA S DA=IEN I '$P(X,U,3)!'X!'VST D ^DIK S BAD=BAD+1 Q
 .;  delete duplicate entries with same visit pointer
 .F  S DA=$O(^VEJD(19610.5,"B",VST,DA)) Q:'DA  D
 ..D ^DIK S BAD=BAD+1,VCNT=VCNT+1
 ..I '(VCNT#100) D UPDSTAT^DSICXPDU(VTOT,VCNT)
 ..Q
 .Q
 D:BAD MES^DSICXPDU("A total of "_BAD_" record(s) deleted",1)
 Q
 ;
CPT ;
 N X,Y,Z,CNT,DFN,DIERR,EFLG,EMSG,ERR,FDA,FILE,IDAT,IEN,IENS,INC,INC1,NODE
 N PKG,ROOT,SOURCE,TMP,VCNT,VCPT,VIEN,VISIT,VTOT
 S X="Checking for missing provider narratives in V CPT file"
 D MES^DSICXPDU(X,1),UPDSTAT^DSICXPDU(,,1)
 S PKG=$$PKG^DSICXPDU,VTOT=+$P($G(^VEJD(19610.5,0)),U,4)
 S SOURCE=+$O(^PX(839.7,"B","VEJD DSS PCE",0))
 S (INC,VCNT)=0
 F  S INC=$O(^VEJD(19610.5,INC)) Q:'INC  D
 .S VCNT=VCNT+1 I '(VCNT#100) D UPDSTAT^DSICXPDU(VTOT,VCNT)
 .S VISIT=+$G(^VEJD(19610.5,INC,0)),DFN=+$G(^(5)) Q:'VISIT!'DFN
 .S X=+$G(^AUPNVSIT(VISIT,0))\1 Q:'X  S IDAT=9999999-X
 .S INC1=0
 .F  S INC1=$O(^VEJD(19610.5,INC,1,INC1)) Q:'INC1  S VCPT=+^(INC1,0) D
 ..K CNT,EFLG,EMSG,ERR S (CNT,EFLG)=0 D ERR(1)
 ..I '$O(^AUPNVCPT("AA",DFN,VCPT,IDAT,0)) D ERR(2) Q
 ..F IEN=0:0 S IEN=$O(^AUPNVCPT("AA",DFN,VCPT,IDAT,IEN)) Q:'IEN  D
 ...K DIERR,EMSG,ERR,FDA,FILE,IENS,TMP
 ...D ERR(3) S X=$G(^AUPNVCPT(IEN,0))
 ...I X]"",$P(X,U,4)'=+$P(X,U,4) S $P(^AUPNVCPT(IEN,0),U,4)=""
 ...S IENS=IEN_",",FILE=9000010.18
 ...;  there is a PCE api to get this info, but I don't have it handy
 ...D GETS^DIQ(FILE,IENS,".04;81202;81203",,"TMP","ERR")
 ...I $D(ERR) D ERR() Q
 ...Q:$G(TMP(FILE,IENS,.04))]""  ;  provider narrative present
 ...S X=$P($G(^ICPT(VCPT,0)),U,2)
 ...I X="" D ERR(4) Q  ;  no cpt SHORT NAME
 ...S Y=$O(^AUTNPOV("B",X,0))
 ...I 'Y D  Q:'Y
 ....N DIERR,ERR,FDA,VIEN
 ....S FDA(9999999.27,"+1,",.01)=X
 ....D UPDATE^DIE(,"FDA","VIEN","ERR")
 ....I '$D(ERR),$G(VIEN(1)) S Y=VIEN(1) Q
 ....D ERR(5) S Y=0
 ....Q
 ...S FDA(FILE,IENS,.04)=Y
 ...I $G(TMP(FILE,IENS,81202))="",PKG S FDA(FILE,IENS,81202)=PKG
 ...I $G(TMP(FILE,IENS,81203))="",SOURCE S FDA(FILE,IENS,81203)=SOURCE
 ...L +^AUPNVCPT(IEN):10 E  D ERR(6) Q
 ...D FILE^DIE(,"FDA","ERR") L -^AUPNVCPT(IEN)
 ...I $D(ERR) D ERR(7)
 ...Q
 ..I EFLG D MES^DSICXPDU(.EMSG)
 ..Q
 .Q
 Q
 ;
ERR(T) ;  build error messages
 N I,AMSG S T=$G(T) I T'=1,T'=3 S EFLG=1
 S:T=1 T=">>>PCEMD record: "_$NA(^VEJD(19610.5,INC,1,INC1,0))_"<<<"
 S:T=2 T="   Did not find xref "_$NA(^AUPNVCPT("AA",DFN,VCPT,IDAT))
 S:T=3 T="   Evaluating "_$NA(^AUPNVCPT(IEN))
 S:T=4 T="   No SHORT NAME found for "_$NA(^ICPT(VCPT))
 S:T=5 T="   Error while adding new provider narrative to file 9999999.27"
 S:T=6 T="   Unable to lock "_$NA(^AUPNVCPT(IEN))
 S:T=7 T="   Error while updating "_$NA(^AUPNVCPT(IEN))
 I T]"" S CNT=CNT+1,EMSG(CNT)=T Q:'$D(ERR)
 D MSG^DIALOG("AE",.AMSG,,,"ERR")
 F I=0:0 S I=$O(AMSG(I)) Q:'I  S CNT=CNT+1,EMSG(CNT)="   "_AMSG(I)
 Q
 ;
RPT ;Run cleanup in background and report findings
 N %ZIS,IOP,ZTDESC,ZTRTN
 S %ZIS="N",%ZIS("B")="",IOP="Q" D ^%ZIS Q:POP
 S ZTDESC="V CPT File Cleanup of Null Patient Narratives"
 S ZTRTN="QUE^VEJDKXRF" D ^%ZTLOAD,^%ZISC
 Q
QUE ;
 N X,CNT,CPT,CPTI,DA,DIE,DR,FIXD,NRECS,SRC,PNAR,VCPT,VSRC,TRT,TCNT,TNRECS,TFIXD,AMC,PCNT,PNRECS,PFIXD,POV
 S (CNT,AMC,FIXD,NRECS,TCNT,TNRECS,TFIXD,PCNT,PNRECS,PFIXD)=0,SRC="VEJD DSS PCE",SRC=+$O(^PX(839.7,"B",SRC,0))
 I 'SRC G QERR
 K ^TMP("VEJDKXRF",$J),^TMP("VEJDKXRF1",$J),^TMP("VEJDKXRF2",$J)
 F CNT=1:1 S AMC=$O(^AUPNVCPT(AMC)) Q:'AMC  S CPT=$G(^(AMC,0)) D:CPT
 .S CPTI=+CPT,PNAR=$P(CPT,U,4) Q:PNAR=+PNAR&(PNAR>0)  S NRECS=NRECS+1
 .S VSRC=+$P($G(^AUPNVCPT(AMC,812)),U,3)
 .I VSRC'=SRC S ^(VSRC)=$G(^TMP("VEJDKXRF",$J,VSRC))+1
 .S PNAR=$P($G(^ICPT(CPTI,0)),U,2) Q:PNAR=""
 .K DR S PNAR=$$NEWPRNA^VEJDPXCX(PNAR,9000010.18) Q:PNAR'>0
 .S DIE="^AUPNVCPT(",DR=".04////"_PNAR,DA=AMC D ^DIE K DR
 .S FIXD=FIXD+1
 S AMC=0
 F TCNT=1:1 S AMC=$O(^AUPNVTRT(AMC)) Q:'AMC  S TRT=$G(^(AMC,0)) D:TRT
 .S PNAR=$P(TRT,U,6) S:PNAR=0!(PNAR="")!(PNAR<0) PNAR=$P($G(^AUTTTRT(+TRT,0)),U) Q:PNAR=+PNAR&PNAR  S TNRECS=TNRECS+1
 .S VSRC=+$P($G(^AUPNVTRT(AMC,812)),U,3)
 .I VSRC'=SRC S ^(VSRC)=$G(^TMP("VEJDKXRF1",$J,VSRC))+1
 .K DR S PNAR=$$NEWPRNA^VEJDPXCX(PNAR,9000010.15) Q:PNAR'>0
 .S DIE="^AUPNVTRT(",DR=".06////"_PNAR,DA=AMC D ^DIE K DR
 .S TFIXD=TFIXD+1
 S AMC=0
 F PCNT=1:1 S AMC=$O(^AUPNVPOV(AMC)) Q:'AMC  S POV=$G(^(AMC,0)) D:POV
 .S PNAR=$P(POV,U,4) Q:PNAR>0&(PNAR=+PNAR)  ;PNAR is numeric not 0
 .S:0[PNAR PNAR=$S($G(^ICD9(+POV,0))]"":^(1),1:$P($G(^ICD9(+POV,0)),U,3))
 .S PNRECS=PNRECS+1
 .S VSRC=+$P($G(^AUPNVPOV(AMC,812)),U,3)
 .I VSRC'=SRC S ^(VSRC)=$G(^TMP("VEJDKXRF2",$J,VSRC))+1
 .K DR S PNAR=$$NEWPRNA^VEJDPXCX(PNAR,9000010.07) Q:PNAR'>0
 .S DIE="^AUPNVPOV(",DR=".04////"_PNAR,DA=AMC D ^DIE K DR
 .S PFIXD=PFIXD+1
 U IO W:'$D(ZTQUEUED) @IOF
 W !,"V CPT File Provider Narrative Clean-Up Results"
 W !,"                Total Records Reviewed: "_CNT
 W !,"Total Leading Numeric Narratives Found: "_NRECS
 W !,"                           Total Fixed: "_FIXD
 ;W !,"   Others not from Source VEJD DSS PCE: ",(NRECS-FIXD)
 S X="",$P(X,"-",50)="" W !,X
 I $O(^TMP("VEJDKXRF",$J,0)) S SRC=0 D
 .F  S SRC=$O(^TMP("VEJDKXRF",$J,SRC)) Q:'SRC  S VSRC=^(SRC) D
 ..S X=$P($G(^PX(839.7,SRC,0)),U) S:X="" X="IEN "_SRC
 ..W !,$J(X,31)_": "_VSRC
 ..Q
 .Q
 W @IOF,"V Treatment File Provider Narrative Clean-Up Results"
 W !,"                Total Records Reviewed: "_TCNT
 W !,"Total Leading Numeric Narratives Found: "_TNRECS
 W !,"                           Total Fixed: "_TFIXD
 ;W !,"   Others not from Source VEJD DSS PCE: ",(TNRECS-TFIXD)
 S X="",$P(X,"-",50)="" W !,X
 I $O(^TMP("VEJDKXRF1",$J,0)) S SRC=0 D
 .F  S SRC=$O(^TMP("VEJDKXRF1",$J,SRC)) Q:'SRC  S VSRC=^(SRC) D
 ..S X=$P($G(^PX(839.7,SRC,0)),U) S:X="" X="IEN "_SRC
 ..W !,$J(X,31)_": "_VSRC
 ..Q
 .Q
 W @IOF,"V POV File Provider Narrative Clean-Up Results"
 W !,"                Total Records Reviewed: "_PCNT
 W !,"Total Leading Numeric Narratives Found: "_PNRECS
 W !,"                           Total Fixed: "_PFIXD
 ;W !,"   Others not from Source VEJD DSS PCE: ",(PNRECS-PFIXD)
 S X="",$P(X,"-",50)="" W !,X
 I $O(^TMP("VEJDKXRF2",$J,0)) S SRC=0 D
 .F  S SRC=$O(^TMP("VEJDKXRF2",$J,SRC)) Q:'SRC  S VSRC=^(SRC) D
 ..S X=$P($G(^PX(839.7,SRC,0)),U) S:X="" X="IEN "_SRC
 ..W !,$J(X,31)_": "_VSRC
 ..Q
 .Q
QQ I $D(ZTQUEUED) S ZTREQ="@"
 E  D ^%ZISC
 Q
QERR ;
 U IO W @IOF,"DSS PCE not defined in Package File!" G QQ
