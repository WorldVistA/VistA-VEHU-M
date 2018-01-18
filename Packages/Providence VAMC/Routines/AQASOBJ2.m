AQASOBJ2 ;GCD/PROV-Local routine with embedded object codes for TIU;5/19/99
 ;
PADM(DFN,TARGET) ;get previous admissions
 N LINE S LINE=0
 S VA200=1,TT=1,FLGDX=0,FLGDC=0
 D NOW^%DTC S EDT=X,X1=X,X2=-1825 D C^%DTC S BDT=X
 S EDT=9999999.99999-EDT,BDT=9999999.99999-(BDT-1)
 K DIQ
 S MAX=5,GMC=-1,GMN="",ADM=EDT,FLAG=0
 N X
 I TT=1 D FADM
 F  S ADM=$O(^DGPM("ATID"_TT,DFN,ADM)) Q:'ADM!(ADM>BDT)  D
 .N VAHOW
 .S ADA=$O(^DGPM("ATID"_TT,DFN,ADM,0)) Q:'ADA
 .;S MAX=MAX-1 I MAX<0 Q
 .S VAIP("E")=ADA D IN5^VADPT
 .S (X,ADATE)=+VAIP(3) D REGDT4^GMTSU S ADT=X
 .K DGPMIFN S DGPMIFN=ADA
 .S GMC=2
 .D ^DGPMLOS S LOS=+X
 .S FLAG=2 
 .I $G(VAIP(17,1))="" S DDT="Present"
 .E  S X=$P(VAIP(17,1),U,1) D REGDT4^GMTSU S DDT=X
 .S LINE=LINE+1,@TARGET@(LINE,0)=" "_ADT_" - "_DDT_"   LOS: "_LOS_" Adm Dx: "_$G(VAIP(13,7))
 Q "~@"_$NA(@TARGET)
FADM ;
 N NODE,X
 K ^TMP("GMFADM",$J)
 N DA,DIQ,DIC,DR
 Q:'$D(^DGS(41.1,"B",DFN))
 S DA=0,DIC=41.1,DR="2;3;4;5;6;8;9;10;13;17"
 F  S DA=$O(^DGS(41.1,"B",DFN,DA)) Q:DA'>0  D
 .N GMFADM,DIQ,RESDT,ADDX,PROV,SUR,LOC,LOS
 .S DIQ="GMFADM",DIQ(0)="IE"
 .D EN^DIQ1
 .;quit if reservation day is past, admission cancel or patient admitted
 .S RESDT=GMFADM(41.1,DA,2,"I"),ADDX=GMFADM(41.1,DA,4,"I")
 .S PROV=GMFADM(41.1,DA,5,"E"),SUR=GMFADM(41.1,DA,6,"E")
 . ; LOC will contain either ward or treating specialty
 .S LOC=$S(GMFADM(41.1,DA,10,"I")="W":GMFADM(41.1,DA,8,"E"),GMFADM(41.1,DA,10,"I")="T":GMFADM(41.1,DA,9,"E"),1:"")
 .S LOS=GMFADM(41.1,DA,3,"I")
 .S ^TMP("GMFADM",$J,9999999-RESDT)=RESDT_U_ADDX_U_PROV_U_SUR_U_LOC_LOS
 Q:'$D(^TMP("GMFADM",$J))
 S GMC=1,GMDT=0
 F  S GMDT=$O(^TMP("GMFADM",$J,GMDT)) Q:GMDT'>0  D
 .S NODE=$G(^TMP("GMFADM",$J,GMDT))
 .S X=$P(NODE,U) D REGDT4^GMTSU
 .S LINE=LINE+1,@TARGET@(LINE,0)=X_" (Future)    "_$E($P(NODE,U,5),1,24)
 .I $P(NODE,U,6)>0 S @TARGET@(LINE,0)=@TARGET@(LINE,0)_" Expected LOS: "_$P(NODE,U,6)
 .I $P(NODE,U,2)]"" S LINE=LINE+1,@TARGET@(LINE,0)="        Admitting Dx: "_$P(NODE,U,2)
 .S LINE=LINE+1,@TARGET@(LINE,0)="         Provider: "_$E($P(NODE,U,3),1,15)
 K ^TMP("GMFADM",$J)
 Q
ADM(DFN,TARGET) ; get current admission info
 N VAIP,LINE 
 S LINE=0
 D IN5^VADPT
 I $P(VAIP(3),U)]"" S LINE=LINE+1,@TARGET@(LINE,0)="Admission Date: "_$P($P(VAIP(3),U,2),"@",1)
 I $P(VAIP(9),U)]"" S @TARGET@(LINE,0)=@TARGET@(LINE,0)_" Admission Dx: "_$P(VAIP(9),U)
 I $P(VAIP(7),U)]"" S LINE=LINE+1,@TARGET@(LINE,0)=" Admitting Physician: "_$P(VAIP(7),U,2)
 Q "~@"_$NA(@TARGET)
CD(DFN,TARGET) ; get Advanced Directive
 N X,DIC,TIUTYPE,Y,TIUFPRIV S TIUFPRIV=1
 N LINE S LINE=0
 K ^TMP("TIU",$J)
 S X="ADVANCE DIRECTIVE",DIC="^TIU(8925.1,",DIC(0)="X",DIC("S")="I $P($G(^(0)),U,4)=""DC""" D ^DIC I Y>0 S TIUTYPE=+Y 
 S MAX=2,BDT="",EDT=""
 D MAIN^TIULAPI(DFN,TIUTYPE,"ALL",BDT,EDT,MAX,1)
 I '$D(^TMP("TIU",$J)) S @TARGET@(1,0)="None" Q "~@"_$NA(@TARGET)
 S GMTSI=0 F  S GMTSI=$O(^TMP("TIU",$J,GMTSI)) Q:+GMTSI'>0  D
 .S GMTSJ=0
 .F  S GMTSJ=$O(^TMP("TIU",$J,GMTSI,GMTSJ)) Q:+GMTSJ'>0  D
 ..S TDT=^TMP("TIU",$J,GMTSI,GMTSJ,1301,"I")
 ..I TDT]"" S LINE=LINE+1,@TARGET@(LINE,0)=$$DATE^TIULS(TDT,"MM/DD/CCYY HR:MIN")
 Q "~@"_$NA(@TARGET)
GAF(DFN) ;
 S REC=$$RET^YSGAF(DFN)
 I REC]"",REC=-1 S RC="Last GAF Score: None" Q RC
 ;I REC]"" S Y=$P(REC,U,2) X ^DD("DD") S RC="Last GAF Score: "_$P(REC,U)_" on "_Y_" by "_$P(^VA(200,$P(REC,U,3),0),U)
 I REC]"" S Y=$P(REC,U,2) X ^DD("DD") S RC="Last GAF Score: "_$S($P(REC,U)]"":$P(REC,U),1:"UNKNOWN")_" on "_Y_" by "_$S($P(REC,U,3)]"":$P(^VA(200,$P(REC,U,3),0),U),1:"UNKNOWN")
 Q RC
 
 Q
