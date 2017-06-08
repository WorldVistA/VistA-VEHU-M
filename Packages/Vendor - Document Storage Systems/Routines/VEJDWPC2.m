VEJDWPC2 ;WPB/CAM routine modified for dental GUI;8/1/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;BIR/MV-RETURN INPATIENT ACTIVE MEDS (EXPANDED) ;05 DEC 97 / 1:36 PM
 ;PSJORRE1;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
OEL(DFN,ON)         ; return list of expanded inpat meds
 K ^TMP("PS",$J)
 N ADM,CNT,DN,DO,F,INFUS,INST,MR,ND,ND0,ND2,ND6,NDOI,SCH,SIO,START,STAT,STOP,TYP,UNITS,X,Y
 ;Check if 5.0 order conversion should be run for the selected patient.
 ;I '$P($G(^PS(55,DFN,5.1)),U,11) D CONVERT^PSJUTL1(DFN,0)
 ;F  S X=$$OTF^OR3CONV(DFN,$S($E(IOST,1)="C":0,1:1)) Q:+X'<0  D
 ;.I +X=-1 H 3
 S F=$S(ON["P":"^PS(53.1,",ON["U":"^PS(55,DFN,5,",1:"^PS(55,"_DFN_",""IV"",")
 I ON'["P",'$D(@(F_+ON_")")) Q
 I ON["P" S X=$G(^PS(53.1,+ON,0)) Q:$P(X,U,15)'=DFN  S TYP=$P(X,U,4) D @$S(TYP="U":"UDTMP",1:"IVTMP")
 D:ON'["P" @$S(ON["U":"UDTMP",1:"IVTMP")
 S Y=$S(ON["V":5,1:12),CNT=0
 I $O(@(F_+ON_","_Y_",0)")) D
 . F X=0:0 S X=$O(@(F_+ON_","_Y_","_X_")")) Q:'X  D
 ..S CNT=CNT+1,ND=$G(@(F_+ON_","_Y_","_X_",0)")),^TMP("PS",$J,"PC",CNT,0)=ND
 S ^TMP("PS",$J,"PC",0)=CNT
 Q
 ;
UDTMP ;*** Set ^TMP for Unit dose orders.
 N DO,DN,INST,X,Y,PROVIDER
 S (MR,SCH,INST)=""
 S ND2=$G(@(F_+ON_",2)")),ND0=$G(@(F_+ON_",0)"))
 S ND6=$G(@(F_+ON_",6)"))
 S STAT=$$STAT^VEJDWPC1($S(ON["P":^DD(53.1,28,0),1:^DD(55.06,28,0)),$P(ND0,U,9))
 D DRGDISP^VEJDWPBZ(DFN,ON,40,0,.DN,1)
 S NDOI=$G(@(F_+ON_",.2)")),DO=$P(NDOI,U,2)
 S UNITS="" I '$O(@(F_+ON_",1,1)")),DO="" S UNITS=$P($G(@(F_+ON_",1,1,0)")),U,2)
 S MR=$$MR(+$P(ND0,U,3)),INST=$G(@(F_+ON_",.3)"))
 S ^TMP("PS",$J,0)=DN(1)_"^^"_$P(ND2,U,4)_"^^"_$P(ND2,U,2)_U_STAT_"^^^"_DO_U_UNITS_U_$P(ND0,U,21)_U_U_$P($G(^PS(55,DFN,5,+ON,0)),"^",22)_U_($P(ND0,U,9)="P"&($P(ND0,U,24)="R"))
 S PROVIDER=$P($G(@(F_+ON_",0)")),"^",2)
 I PROVIDER S ^TMP("PS",$J,"P",0)=PROVIDER_"^"_$P($G(^VA(200,PROVIDER,0)),"^")
 S ^TMP("PS",$J,"MDR",0)=MR]"" S:MR]"" ^TMP("PS",$J,"MDR",1,0)=MR
 S ^TMP("PS",$J,"SCH",0)=$P(ND2,U)]"" S:$P(ND2,U)]"" ^TMP("PS",$J,"SCH",1,0)=$P(ND2,U)
 S ^TMP("PS",$J,"SIG",0)=INST]"" S:INST]"" ^TMP("PS",$J,"SIG",1,0)=INST
 S ^TMP("PS",$J,"ADM",0)=$P(ND2,U,5)]"" S:$P(ND2,U,5)]"" ^TMP("PS",$J,"ADM",1,0)=$P(ND2,U,5)
 S ^TMP("PS",$J,"SIO",0)=ND6]"" S:ND6]"" ^TMP("PS",$J,"SIO",1,0)=ND6
 NEW PSJDD,INACTDT,NDDD,OUTOI,PSJOUT S CNT=0
 F PSJDD=0:0 S PSJDD=$O(@(F_+ON_",1,PSJDD)")) Q:'PSJDD  D
 . S NDDD=@(F_+ON_",1,PSJDD,0)")
 . I $P(NDDD,U,3)]"",($P(NDDD,U,3)'>DT) Q
 . S PSJOUT=$P($G(^PSDRUG(+NDDD,8)),U,5)
 . I +PSJOUT D
 .. S INACTDT=$G(^PSDRUG(+PSJOUT,"I")),OUTOI=+$G(^PSDRUG(+PSJOUT,2))
 .. I INACTDT]"",(INACTDT'>DT) S (PSJOUT,OUTOI)=""
 . I '+PSJOUT,($P($G(^PSDRUG(+NDDD,2)),U,3)["O") D
 .. S PSJOUT=+NDDD,OUTOI=+NDOI
 .. S INACTDT=$G(^PSDRUG(+NDDD,"I"))
 .. I INACTDT]"",(INACTDT'>DT) S (PJSOUT,OUTOI)=""
 . ;* S UNITS=$S('+$P(NDDD,U,2):1,1:$P(NDDD,U,2))
 . S UNITS=$P(NDDD,U,2)
 . S CNT=CNT+1,^TMP("PS",$J,"DD",CNT,0)=+NDDD_U_UNITS_U_PSJOUT_U_$G(OUTOI)
 S ^TMP("PS",$J,"DD",0)=CNT
 Q
 ;
IVTMP ;*** Set ^TMP for IV orders.
 N PROVIDER S ND0=$G(@(F_+ON_",0)")),CNT=0
 F X=0:0 S X=$O(@(F_+ON_",""AD"","_X_")")) Q:'X  S ND=$G(@(F_+ON_",""AD"","_X_",0)")),DN=$P($G(^PS(52.6,+ND,0)),U),Y=DN_U_$P(ND,U,2) S:$P(ND,U,3) Y=Y_U_$P(ND,U,3) S CNT=CNT+1,^TMP("PS",$J,"A",CNT,0)=Y
 S ^TMP("PS",$J,"A",0)=CNT,CNT=0
 F X=0:0 S X=$O(@(F_+ON_",""SOL"","_X_")")) Q:'X  S ND=$G(@(F_+ON_",""SOL"","_X_",0)")),DN=$P($G(^PS(52.7,+ND,0)),U),CNT=CNT+1,^TMP("PS",$J,"B",CNT,0)=DN_U_$P(ND,U,2)
 S ^TMP("PS",$J,"B",0)=CNT
 S INST=$G(@(F_+ON_",.3)"))
 I ON["P" D
 . S SCH=$P($G(^PS(53.1,+ON,2)),U)
 . S PROVIDER=$P(ND0,U,2)
 . S MR=$$MR(+$P(ND0,U,3)),STAT=$$STAT^VEJDWPC1(^DD(53.1,28,0),$P(ND0,U,9))
 . S INFUS=$P($G(^PS(53.1,+ON,8)),U,5)
 . S ND2=$G(@(F_+ON_",2)")),START=$P(ND2,U,2),STOP=$P(ND2,U,4)
 . S ADM=$P(ND2,U,5),SIO=$G(@(F_+ON_",6)"))
 I ON'["P"  D
 . S PROVIDER=$P(ND0,U,6)
 . S SCH=$P(ND0,U,9),INFUS=$P(ND0,U,8),STAT=$$STAT^VEJDWPC1(^DD(55.01,100,0),$P(ND0,U,17))
 . S MR=$$MR(+$P($G(^PS(55,DFN,"IV",+ON,.2)),U,3))
 . S START=$P(ND0,U,2),STOP=$P(ND0,U,3)
 . S ADM=$P(ND0,U,11),SIO=$G(@(F_+ON_",3)"))
 S DN=$G(@(F_+ON_",.2)")),DO=$P(DN,U,2)
 S DN=$S(+$P(DN,U):$$OIDF^VEJDWPBZ($P(DN,U)),1:"")
 S ^TMP("PS",$J,0)=DN_U_INFUS_U_STOP_"^^"_START_U_STAT_"^^^"_DO_"^^"_$P(ND0,U,21)_U_U_U_($P(ND0,U,9)="P"&($P(ND0,U,24)="R"))
 ;*S PROVIDER=$P($G(@(F_+ON_",0)")),"^",6)
 I PROVIDER S ^TMP("PS",$J,"P",0)=PROVIDER_"^"_$P($G(^VA(200,PROVIDER,0)),"^")
 S ^TMP("PS",$J,"MDR",0)=MR]"" S:MR]"" ^TMP("PS",$J,"MDR",1,0)=MR
 S ^TMP("PS",$J,"SCH",0)=SCH]"" S:SCH]"" ^TMP("PS",$J,"SCH",1,0)=SCH
 S ^TMP("PS",$J,"SIG",0)=INST]"" S:INST]"" ^TMP("PS",$J,"SIG",1,0)=INST
 S ^TMP("PS",$J,"ADM",0)=ADM]"" S:ADM]"" ^TMP("PS",$J,"ADM",1,0)=ADM
 S ^TMP("PS",$J,"SIO",0)=SIO]"" S:SIO]"" ^TMP("PS",$J,"SIO",1,0)=SIO
 Q
 ;
MR(X) ;RETURN MED ROUTE ABBR. IF THE ABBR="" RETURN MED ROUTE'S NAME.
 S X=$G(^PS(51.2,X,0))
 Q $S($P(X,U,3)]"":$P(X,U,3),1:$P(X,U))
 ;
GTSTAT(X) ;
 Q $S(X="A":"ACTIVE",X="D":"DISCONTINUED",X="I":"INCOMPLETE",X="N":"NON-VERFIED",X="U":"UNRELEASED",X="P":"PENDING",X="DE":"DISCONTINUED (EDIT)",X="O":"ON CALL",1:"NOT FOUND")
