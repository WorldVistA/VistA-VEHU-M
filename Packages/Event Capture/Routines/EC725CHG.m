EC725CHG ;ALB/GTS - EC National Procedure Update 9/8/97
 ;;2.0; EVENT CAPTURE ;**6**;8 May 96
 ;
 ;**  This patch is used as a Post-Init in a KIDS build to modify the
 ;**   the EC National Procedure file [^EC(725,]
 ;
INACPRC ;* Inactivate National Procedures
 D:$P($T(OLD+1),";;",2)'="QUIT" INACT
 Q
 ;
CPTCHG ;* Change CPT codes for National Procedures
 D:$P($T(CPTCHGS+1),";;",2)'="QUIT" CPT
 Q
 ;
SETTMP ;* Set ^TMP global of procedures inactivated
 N ECX,ECXX,ECNATNUM,ECTMPDA
 ;
 ;* Note: ECGOODDA, ECGOODPT set in ECPTRCHK
 S ^TMP($J,"EC*2*6 INACTIVE PROC",ECPTRCHK)=""
 S ^TMP($J,"EC*2*6 INACTIVE PROC",ECGOODPT)=""
 F ECX=1:1 S ECXX=$P($T(OLD+ECX),";;",2) Q:ECXX="QUIT"  DO
 .S ECNATNUM=$P(ECXX,"^",1)
 .S ECTMPDA=$$GETDA^EC2P6PST("",ECNATNUM) ;*Get #725 IENs
 .S ECTMPDA=$P(ECTMPDA,"^",2)_";EC(725,"
 .S ^TMP($J,"EC*2*6 INACTIVE PROC",ECTMPDA)="" ;*Killed by KVARS^EC2P6PST
 Q
 ;
INACT ;** Inactivate National Procedures
 ;
 ;  ECXX is in format:
 ;   NATIONAL NUMBER ^ INACTIVATION DATE
 ;
 N ECX,ECXX,ECINDT,ECEXDT
 D MES^XPDUTL(" ")
 D BMES^XPDUTL(" Inactivating EC National Procedures (file #725)...")
 F ECX=1:1 K DD,DO,DA S ECXX=$P($T(OLD+ECX),";;",2) Q:ECXX="QUIT"  DO
 .S ECEXDT=$P(ECXX,"^",2)
 .S X=ECEXDT
 .S %DT="TX"
 .D ^%DT
 .S ECINDT=$P(Y,".",1)
 .S ECDA=+$O(^EC(725,"D",$P(ECXX,"^",1),0))
 .I $D(^EC(725,ECDA,0)) DO
 ..S DA=ECDA,DR="2////^S X=ECINDT",DIE="^EC(725,"
 ..D ^DIE,MESI(ECEXDT)
 K DD,DO,DR,DA,DIC,DIE,DLAYGO,X,%DT,Y,ECDA,ECXX,ECEXDT,ECINDT
 Q
 ;
MESI(ECEXDT) ;** Inactivate message
 ;
 ;  Parameter:
 ;   ECEXDT - Date inactivation affective (External Format)
 ;
 N ECINMSG
 I '$D(ECEXDT) S ECEXDT="UNKNOWN"
 I $D(ECEXDT),(ECEXDT="") S ECEXDT="UNKNOWN"
 S ECINMSG="    ..."_$P(^EC(725,ECDA,0),"^")_" ("_$P(ECXX,"^",1)_") inactivated as of "_ECEXDT_"..."
 D BMES^XPDUTL(ECINMSG)
 Q
 ;
CPT ;** Change CPT Codes
 ;
 ;  ECXX is in format:
 ; NATIONAL NUMBER ^ NAME ^ NEW CPT ^ OLD CPT
 ;
 N ECX,ECXX,ECDA
 D MES^XPDUTL(" ")
 D BMES^XPDUTL(" Changing CPT Codes in EC National Procedure file (#725)...")
 F ECX=1:1 K DD,DO,DA S ECXX=$P($T(CPTCHGS+ECX),";;",2) Q:ECXX="QUIT"  DO
 .S ECDA=+$O(^EC(725,"D",$P(ECXX,U,1),0))
 .I $D(^EC(725,ECDA,0)) DO
 ..S DA=ECDA,DR="4///"_$P(ECXX,U,3),DIE="^EC(725,"
 ..D ^DIE,MESN
 K DIE,DR,DA,X
 Q
 ;
MESN ;** Change number
 N ECNMSG,ECNMSG1
 S ECNMSG="    ..."_$P(ECXX,U,2)_", CPT: "_$P(ECXX,U,4)
 S ECNMSG1="           changed to "_$P(ECXX,U,3)_"..."
 D BMES^XPDUTL(ECNMSG)
 D MES^XPDUTL(ECNMSG1)
 Q
 ;
OLD ;National Procedures to be inactivated- example ;;NATIONAL NUMBER^INACTIVE DATE
 ;;SP005^8/31/97
 ;;SP012^8/31/97
 ;;SP014^8/31/97
 ;;SP017^8/31/97
 ;;SP020^8/31/97
 ;;SP040^8/31/97
 ;;SP041^8/31/97
 ;;SP042^8/31/97
 ;;SP043^8/31/97
 ;;SP044^8/31/97
 ;;SP045^8/31/97
 ;;SP046^8/31/97
 ;;SP047^8/31/97
 ;;SP048^8/31/97
 ;;SP049^8/31/97
 ;;SP050^8/31/97
 ;;SP113^8/31/97
 ;;SP115^8/31/97
 ;;SP119^8/31/97
 ;;SP120^8/31/97
 ;;SP132^8/31/97
 ;;SP137^8/31/97
 ;;SP139^8/31/97
 ;;SP140^8/31/97
 ;;QUIT
 ;
CPTCHGS ;CPT code change- example ;;NATIONAL NUMBER^NAME^NEW CPT^OLD CPT
 ;;SP107^HEARING AID FITTING/ORIENTATION, MON^97703^97520
 ;;SP108^HEARING AID FITTING/ORIENTATION, BIN^97703^97520
 ;;QUIT
