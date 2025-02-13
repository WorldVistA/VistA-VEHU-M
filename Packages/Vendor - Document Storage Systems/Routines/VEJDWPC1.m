VEJDWPC1 ;WPB/CAM routine modified for dental GUI;8/1/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;BIR/MV-RETURN INPATIENT ACTIVE MEDS (CONDENSED) ;12 DEC 97 / 9:10 AM 
 ;PSJORRE;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
OCL(DFN,BDT,EDT,TFN)         ; return condensed list of inpat meds
 N ADM,CNT,DN,DO,F,FON,INFUS,INST,MR,ND,ND0,ND2,ND6,ON,PON,PST,SCH,SIO,STAT,TYPE,UNITS,WBDT,X,Y
 ;Check if 5.0 order conversion should be run for the selected patient.
 ;F  S X=$$OTF^OR3CONV(DFN,$S($E($G(IOST),1)="C":0,1:1)) Q:+X'<0  D
 ;.I +X=-1 H 3
 ; PON=placer order number (oerr), FON=filler order number
 S:BDT="" BDT=DT S WBDT=BDT_".000001"
 S:EDT="" EDT=9999999
 S:EDT'["." EDT=EDT_".999999"
 S F="^PS(55,DFN,5," F  S WBDT=$O(^PS(55,DFN,5,"AUS",WBDT)) Q:'WBDT  F ON=0:0 S ON=$O(^PS(55,DFN,5,"AUS",WBDT,ON)) Q:'ON  D UDTMP
 S F="^PS(53.1," F PST="P","N" F ON=0:0 S ON=$O(^PS(53.1,"AS",PST,DFN,ON)) Q:'ON  S X=$P($G(^PS(53.1,+ON,0)),U,4) D @$S(X="U":"UDTMP",1:"IVTMP")
 S F="^PS(55,"_DFN_",""IV"",",WBDT=BDT-1 F  S WBDT=$O(^PS(55,DFN,"IV","AIS",WBDT)) Q:'WBDT  F ON=0:0 S ON=$O(^PS(55,DFN,"IV","AIS",WBDT,ON)) Q:'ON  D IVTMP
 Q
 ;
UDTMP ;*** Set ^TMP for Unit dose orders.
 N PROVIDER S (MR,SCH,INST,PON)="",FON=+ON_$S(F["53.1":"P",1:"U")
 S ND2=$G(@(F_ON_",2)")) I F'["53.1",($P(ND2,U,2)>EDT) Q
 S ND0=$G(@(F_ON_",0)")) I F["53.1",($P(ND0,U,16)>EDT) Q
 S STAT=$$STAT($S(FON["P":^DD(53.1,28,0),1:^DD(55.06,28,0)),$P(ND0,U,9))
 S ND6=$G(@(F_ON_",6)")),INST=$G(@(F_+ON_",.3)"))
 S FON=+ON_$S(F["53.1":"P",1:"U"),DO=$P($G(@(F_ON_",.2)")),"^",2)
 D DRGDISP^VEJDWPBZ(DFN,FON,40,0,.DN,1)
 S UNITS="" I '$O(@(F_+ON_",1,1)")),DO="" S UNITS=$P($G(@(F_+ON_",1,1,0)")),U,2)
 S:+$P(ND0,U,3) MR=$$MR^VEJDWPC2(+$P(ND0,U,3))
 S TFN=TFN+1
 S ^TMP("PS",$J,TFN,0)=FON_";I"_U_DN(1)_"^^"_$P(ND2,U,4)_"^^"_DO_U_UNITS_U_$P(ND0,U,21)_U_STAT_U_U_U_U_$P($G(^PS(55,DFN,5,+ON,0)),"^",22)_U_($P(ND0,U,9)="P"&($P(ND0,U,24)="R"))
 S PROVIDER=$P($G(@(F_+ON_",0)")),"^",2)
 I PROVIDER S ^TMP("PS",$J,TFN,"P",0)=PROVIDER_"^"_$P($G(^VA(200,PROVIDER,0)),"^")
 S ^TMP("PS",$J,TFN,"MDR",0)=MR]"" S:MR]"" ^TMP("PS",$J,TFN,"MDR",1,0)=MR
 S ^TMP("PS",$J,TFN,"SCH",0)=$P(ND2,U)]"" S:$P(ND2,U)]"" ^TMP("PS",$J,TFN,"SCH",1,0)=$P(ND2,U)
 S ^TMP("PS",$J,TFN,"SIG",0)=INST]"" S:INST]"" ^TMP("PS",$J,TFN,"SIG",1,0)=INST
 S ^TMP("PS",$J,TFN,"ADM",0)=$P(ND2,U,5)]"" S:$P(ND2,U,5)]"" ^TMP("PS",$J,TFN,"ADM",1,0)=$P(ND2,U,5)
 S ^TMP("PS",$J,TFN,"SIO",0)=ND6]"" S:ND6]"" ^TMP("PS",$J,TFN,"SIO",1,0)=ND6
 Q
 ;
IVTMP ;*** Set ^TMP for IV orders.
 N PROVIDER S ND0=$G(@(F_ON_",0)")) Q:$P(ND0,U,2)>EDT
 S FON=+ON_$S(F["53.1":"P",1:"V"),TFN=TFN+1,CNT=0
 F X=0:0 S X=$O(@(F_ON_",""AD"","_X_")")) Q:'X  S ND=$G(@(F_ON_",""AD"","_X_",0)")),DN=$P($G(^PS(52.6,+ND,0)),U),Y=DN_U_$P(ND,U,2) S:$P(ND,U,3) Y=Y_U_$P(ND,U,3) S CNT=CNT+1,^TMP("PS",$J,TFN,"A",CNT,0)=Y
 S ^TMP("PS",$J,TFN,"A",0)=CNT,CNT=0
 F X=0:0 S X=$O(@(F_ON_",""SOL"","_X_")")) Q:'X  S ND=$G(@(F_ON_",""SOL"","_X_",0)")),DN=$P($G(^PS(52.7,+ND,0)),U),CNT=CNT+1,^TMP("PS",$J,TFN,"B",CNT,0)=DN_U_$P(ND,U,2)
 S ^TMP("PS",$J,TFN,"B",0)=CNT
 S TYPE=$P(ND0,U,4),(MR,SCH,INST,INFUS)=""
 I FON["P" S ND2=$G(^PS(53.1,+ON,2)),SCH=$P(ND2,U),STOP=$P(ND2,U,4),MR=$P(ND0,U,3),INFUS=$P($G(^PS(53.1,+ON,8)),U,5),STAT=$$STAT(^DD(53.1,28,0),$P(ND0,U,9)),ADM=$P(ND2,U,5),SIO=$G(@(F_+ON_",6)"))
 I FON'["P" S STOP=$P(ND0,U,3),SCH=$P(ND0,U,9),INFUS=$P(ND0,U,8),MR=$P($G(^PS(55,DFN,"IV",+ON,.2)),U,3),STAT=$$STAT(^DD(55.01,100,0),$P(ND0,U,17)),ADM=$P(ND0,U,11),SIO=$G(@(F_+ON_",3)"))
 S DN=$G(@(F_+ON_",.2)")),DO=$P(DN,U,2)
 S DN=$S(+$P(DN,U):$$OIDF^VEJDWPBZ($P(DN,U)),1:"")
 S:MR MR=$$MR^VEJDWPC2(+MR),INST=$G(@(F_+ON_",.3)"))
 ;S ^TMP("PS",$J,TFN,0)=FON_";I"_U_DN_U_INFUS_U_$P(ND0,U,3)_"^^"_DO_"^^"_$P(ND0,"^",21)_U_STAT
 S ^TMP("PS",$J,TFN,0)=FON_";I"_U_DN_U_INFUS_U_STOP_"^^"_DO_"^^"_$P(ND0,"^",21)_U_STAT_U_U_U_U_U_($P(ND0,U,9)="P"&($P(ND0,U,24)="R"))
 S PROVIDER=$P($G(@(F_+ON_",0)")),"^",6)
 I PROVIDER S ^TMP("PS",$J,TFN,"P",0)=PROVIDER_"^"_$P($G(^VA(200,PROVIDER,0)),"^")
 S ^TMP("PS",$J,TFN,"MDR",0)=MR]"" S:MR]"" ^TMP("PS",$J,TFN,"MDR",1,0)=MR
 S ^TMP("PS",$J,TFN,"SIG",0)=INST]"" S:INST]"" ^TMP("PS",$J,TFN,"SIG",1,0)=INST
 S ^TMP("PS",$J,TFN,"SCH",0)=SCH]"" S:SCH]"" ^TMP("PS",$J,TFN,"SCH",1,0)=SCH
 S ^TMP("PS",$J,TFN,"ADM",0)=ADM]"" S:ADM]"" ^TMP("PS",$J,TFN,"ADM",1,0)=ADM
 S ^TMP("PS",$J,TFN,"SIO",0)=SIO]"" S:SIO]"" ^TMP("PS",$J,TFN,"SIO",1,0)=SIO
 Q
STAT(Y,X) ;* Return the full status instead of just the code for U/D.
 S X=$P($P(";"_$P(Y,U,3),";"_X_":",2),";")
 Q X
