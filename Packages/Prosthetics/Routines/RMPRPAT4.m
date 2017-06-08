RMPRPAT4 ;PHX/RFM/HNB-CONT. OF DISPLAY PATIENT INFORMATION ;10/19/1993
 ;;2.0;PROSTHETICS;;10/19/1993
P2 W ?15,VDR
 I AD1'="" W !,?15,AD1 I AD2]"" W !?15,AD2
 I CITY'="" W !?15,CITY_","_ST_"  "_ZIP
 S RMPROBL=$P(Y(1),U)
 S DEL=$S($P(Y(0),U,12):$P(Y(0),U,12),1:"") W !,"DELIVERY DATE:" I DEL]"" W ?15,$E(DEL,4,5)_"/"_$E(DEL,6,7)_"/"_$E(DEL,2,3)
 E  I $P(Y(0),U,15)'["*" W ?15," No Delivery Date-Transaction not included in AMIS count! "
 S COST=$S($P(Y(0),U,16):$P(Y(0),U,16),1:$P(Y(0),U,17)) W !,"TOTAL COST:",?15,"$"_$J(COST,0,2),?30,"OBL: ",RMPROBL
 W !,"REMARKS: ",?15,$P(Y(0),U,18)
 S ADATE=$S($P(Y(0),U,20):$P(Y(0),U,1),1:"") W:ADATE]"" ?30,$E(ADATE,4,5)_"/"_$E(ADATE,6,7)_"/"_$E(ADATE,2,3)
 I $P(Y(0),U,15)["*" W ! G EXT
 W !!?15,"AMIS INFORMATION",!
P3 W !,"AMIS DATE: " S ADATE=$P(Y(0),U,12) W:ADATE]"" ?15,$E(ADATE,4,5)_"/"_$E(ADATE,6,7)_"/"_$E(ADATE,2,3)
 W ?40,"AMIS NEW: " I $P(Y(0),U,4)'="X",$P(Y(0),U,15)'="*",$D(^RMPR(661,+$P(Y(0),U,6),0)),$D(^RMPR(663,+$P(^RMPR(661,$P(Y(0),U,6),0),U,3),0)) W $P(^(0),U)
 W !,"DISABILITY SERVED: " S CODE=$S($P(Y("AM"),U,3)'="":$P(Y("AM"),U,3),1:"")
 I CODE'="" S CODEF=";"_$P(^DD(660,62,0),U,3),CODEFO=$F(CODEF,";"_CODE_":") W $P($E(CODEF,CODEFO,999),";",1)
 W ?40,"AMIS REPAIR: " I $P(Y(0),U,4)="X",$P(Y(0),U,15)'="*",$D(^RMPR(661,+$P(Y(0),U,6),0)),$D(^RMPR(663,+$P(^RMPR(661,$P(Y(0),U,6),0),U,4),0)) W $P(^(0),U)
EXT W !,"APPLIANCE: " S APL=$S($D(^RMPR(661,+$P(Y(0),U,6),0)):$P(^(0),U,1),1:"") I APL]"" S APL=$P(^PRC(441,APL,0),U,2) W $E(APL,1,27)
 I $P(Y(0),U,6)="" W "R15"
 W !,"DESCRIPTION: ",?$X+2 W:$D(Y(1)) $P(Y(1),U,2)
 ;EXTENDED DESCRIPTION
 S J=0 F I=1:1 S J=$O(Y("DES",J)) Q:J=""  W !,Y("DES",J,0)," "
EXIT F  W ! Q:$Y>(IOSL-3)
 R !,"Press Any key to continue. ",CONT:DTIME D HDR^RMPRPAT2
 K ZK,TRANS,TRANS1,CONT,MFG,FORM,RMPRFM,RMPRFO,LAB,LABF,LABO,DATE,TYPE,TYPEF,TYPEFO,QTY,APL,APLD,SRC,SRCF,SRCFO,VDR,AD1,AD2,CITY,ST
 K ZIP,DEL,COST,ADATE,CODE,CODEF,CODEFO Q
