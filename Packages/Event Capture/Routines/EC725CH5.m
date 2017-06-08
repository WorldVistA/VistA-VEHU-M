EC725CH5 ;ALB/GTS/JAP - EC National Procedure Update; 5/8/98
 ;;2.0; EVENT CAPTURE ;**12**;8 May 96
 ;
 ;this routine is used as a post-init in KIDS build 
 ;to modify the the EC National Procedure file #725
 ;
INACT ;* inactivate national procedures
 ;
 ;  ECXX is in format:
 ;   NATIONAL NUMBER^INACTIVATION DATE
 ;
 N ECX,ECXX,ECEXDT,ECINDT,ECDA,DIC,DIE,DA,DR,X,Y,%DT
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Inactivating procedures EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 F ECX=1:1 K DD,DO,DA S ECXX=$P($T(OLD+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECEXDT=$P(ECXX,"^",2)
 .S X=ECEXDT
 .S %DT="X" D ^%DT
 .S ECINDT=$P(Y,".",1)
 .S ECDA=+$O(^EC(725,"D",$P(ECXX,"^",1),0))
 .I $D(^EC(725,ECDA,0)) D
 ..S DA=ECDA,DR="2////^S X=ECINDT",DIE="^EC(725," D ^DIE
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("   "_$P(ECXX,"^",1)_" inactivated as of "_ECEXDT_".")
 Q
 ;
OLD ;national procedures to be inactivated
 ;;CH016^5/1/1998
 ;;CH072^5/1/1998
 ;;QUIT
 ;
CPTCHG ;* change cpt codes
 ;
 ;  ECXX is in format:
 ;  OLD CPT^NEW CPT
 ;
 N ECX,ECXX,CPT,DIC,DIE,DA,DR,X,Y
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Changing CPT Codes in EC NATIONAL PROCEDURE file (#725)...")
 D MES^XPDUTL(" ")
 F ECX=1:1 S ECXX=$P($T(CPT+ECX),";;",2) Q:ECXX="QUIT"  S CPT($P(ECXX,"^",1))=$P(ECXX,"^",2)
 S ECXX=""
 F  S ECXX=$O(^EC(725,"D",ECXX)) Q:ECXX=""  S ECX=$O(^(ECXX,0)) D
 .Q:'$D(^EC(725,ECX,0))
 .S CPT=$P(^EC(725,ECX,0),"^",5) Q:CPT=""  I $D(CPT(CPT)) D
 ..S DA=ECX,DR="4////"_CPT(CPT),DIE="^EC(725," D ^DIE
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("   Entry #"_ECX_" for "_ECXX)
 ..D BMES^XPDUTL("   ...updated to use CPT code "_CPT(CPT)_".")
 Q
 ;
CPT ;cpt codes to be changed
 ;;90842^90808
 ;;90843^90804
 ;;90844^90806
 ;;99351^99347
 ;;99352^99348
 ;;99353^99349
 ;;QUIT
