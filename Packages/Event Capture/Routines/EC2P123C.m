EC2P123C ;ALB/DE - EC National Procedure Update ; 10/4/12 11:00am
 ;;2.0;EVENT CAPTURE;**123**;8 May 96;Build 8
 ;
 ;this routine is used as a post-init in a KIDS build
 ;to modify the EC National Procedure file (#725)
 ;
 Q
 ;
INACT ;* inactivate national procedures
 ;
 ;  ECXX is in format:
 ;   NATIONAL NUMBER^INACTIVATION DATE^FIRST NATIONAL NUMBER SEQUENCE^
 ;   LAST NATIONAL NUMBER SEQUENCE
 ;
 N ECX,ECXX,ECEXDT,ECINDT,ECDA,DIC,DIE,DA,DR,X,Y,%DT,ECBEG,ECEND,ECADD
 N ECSEQ,ECCODE,ECCODX
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Inactivating procedures EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 F ECX=1:1 K DD,DO,DA S ECXX=$P($T(OLD+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECEXDT=$P(ECXX,U,2),X=ECEXDT,%DT="X" D ^%DT S ECINDT=$P(Y,".",1)
 .S ECCODE=$P(ECXX,U),ECBEG=$P(ECXX,U,3),ECEND=$P(ECXX,U,4),ECCODX=ECCODE
 .I ECBEG="" D UPINACT Q
 .F ECSEQ=ECBEG:1:ECEND D
 ..S ECADD="000"_ECSEQ,ECADD=$E(ECADD,$L(ECADD)-2,$L(ECADD))
 ..S ECCODE=ECCODX_ECADD
 ..D UPINACT
 Q
UPINACT ;Update codes as inactive
 ;
 S ECDA=+$O(^EC(725,"D",ECCODE,0))
 I $D(^EC(725,ECDA,0)) D
 .S DA=ECDA,DR="2///^S X=ECINDT",DIE="^EC(725," D ^DIE
 .D MES^XPDUTL(" ")
 .D BMES^XPDUTL("   "_ECCODE_" inactivated as of "_ECEXDT_".")
 Q
 ;
OLD ;national procedures to be inactivated - national code #^inact. date
 ;;BB001^5/1/2014
 ;;BB002^5/1/2014
 ;;BB003^5/1/2014
 ;;BB004^5/1/2014
 ;;BB005^5/1/2014
 ;;BB006^5/1/2014
 ;;BB007^5/1/2014
 ;;BB008^5/1/2014
 ;;BB009^5/1/2014
 ;;BB010^5/1/2014
 ;;BB011^5/1/2014
 ;;BB012^5/1/2014
 ;;BB013^5/1/2014
 ;;BB014^5/1/2014
 ;;BB015^5/1/2014
 ;;BB016^5/1/2014
 ;;BB017^5/1/2014
 ;;BB018^5/1/2014
 ;;BB019^5/1/2014
 ;;BB020^5/1/2014
 ;;BB021^5/1/2014
 ;;BB022^5/1/2014
 ;;BB023^5/1/2014
 ;;BB024^5/1/2014
 ;;BB025^5/1/2014
 ;;BB026^5/1/2014
 ;;BB027^5/1/2014
 ;;BB028^5/1/2014
 ;;BB029^5/1/2014
 ;;BB030^5/1/2014
 ;;BB031^5/1/2014
 ;;BB032^5/1/2014
 ;;BB033^5/1/2014
 ;;BB034^5/1/2014
 ;;BB035^5/1/2014
 ;;BB036^5/1/2014
 ;;BB037^5/1/2014
 ;;BB038^5/1/2014
 ;;BB039^5/1/2014
 ;;BB040^5/1/2014
 ;;BB041^5/1/2014
 ;;BB042^5/1/2014
 ;;BB043^5/1/2014
 ;;BB044^5/1/2014
 ;;BB989^5/1/2014
 ;;BB990^5/1/2014
 ;;NU203^5/1/2014
 ;;SP006^5/1/2014
 ;;SP013^5/1/2014
 ;;SP015^5/1/2014
 ;;SP018^5/1/2014
 ;;SP021^5/1/2014
 ;;SP022^5/1/2014
 ;;SP023^5/1/2014
 ;;SP024^5/1/2014
 ;;SP228^5/1/2014
 ;;SP245^5/1/2014
 ;;SP246^5/1/2014
 ;;SP247^5/1/2014
 ;;SW002^5/1/2014
 ;;SW011^5/1/2014
 ;;SW012^5/1/2014
 ;;SW013^5/1/2014
 ;;SW014^5/1/2014
 ;;SW025^5/1/2014
 ;;SW026^5/1/2014
 ;;SW027^5/1/2014
 ;;SW028^5/1/2014
 ;;SW031^5/1/2014
 ;;SW032^5/1/2014
 ;;SW054^5/1/2014
 ;;SW056^5/1/2014
 ;;SW057^5/1/2014
 ;;SW058^5/1/2014
 ;;SW059^5/1/2014
 ;;SW081^5/1/2014
 ;;SW083^5/1/2014
 ;;SW084^5/1/2014
 ;;SW085^5/1/2014
 ;;SW089^5/1/2014
 ;;SW090^5/1/2014
 ;;SW096^5/1/2014
 ;;SW097^5/1/2014
 ;;SW098^5/1/2014
 ;;SW099^5/1/2014
 ;;SW100^5/1/2014
 ;;SW101^5/1/2014
 ;;SW102^5/1/2014
 ;;SW103^5/1/2014
 ;;SW105^5/1/2014
 ;;SW106^5/1/2014
 ;;SW109^5/1/2014
 ;;SW110^5/1/2014
 ;;SW111^5/1/2014
 ;;SW112^5/1/2014
 ;;SW113^5/1/2014
 ;;SW114^5/1/2014
 ;;SW115^5/1/2014
 ;;SW116^5/1/2014
 ;;SW117^5/1/2014
 ;;SW118^5/1/2014
 ;;SW119^5/1/2014
 ;;SW125^5/1/2014
 ;;SW126^5/1/2014
 ;;QUIT
 ;
REACT ;* reactivate national procedures
 ;
 ;  ECXX is in format:
 ;   NATIONAL NUMBER^DATE (FUTURE)^FIRST NATIONAL NUMBER SEQUENCE^
 ;   LAST NATIONAL NUMBER SEQUENCE
 ;
 N ECX,ECXX,ECEXDT,ECINDT,ECDA,DIC,DIE,DA,DR,X,Y,%DT,ECBEG,ECEND,ECADD
 N ECSEQ,ECCODE,ECCODX,ECDES
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Reactivating procedures EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 F ECX=1:1 K DD,DO,DA S ECXX=$P($T(ACT+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECDES=$P(ECXX,U,5)
 .S ECCODE=$P(ECXX,U),ECBEG=$P(ECXX,U,3),ECEND=$P(ECXX,U,4),ECCODX=ECCODE
 .I ECBEG="" D UPREACT Q
 .F ECSEQ=ECBEG:1:ECEND D
 ..S ECADD="000"_ECSEQ,ECADD=$E(ECADD,$L(ECADD)-2,$L(ECADD))
 ..S ECCODE=ECCODX_ECADD
 ..D UPREACT
 Q
UPREACT ;Update codes as reactive
 ;
 S ECDA=+$O(^EC(725,"D",ECCODE,0))
 I $D(^EC(725,ECDA,0)) D
 .S DA=ECDA,DR="2///@",DIE="^EC(725," D ^DIE
 .D BMES^XPDUTL("   "_ECCODE_" "_ECDES_" reactivated.")
 Q
 ;
ACT ;national procedures to be reactivated - national number^date
 ;;SW062^5/1/2014
 ;;QUIT
 ;
CPTCHG ;* change cpt codes
 ;
 ;  ECXX is in format:
 ;  NATIONAL NUMBER^NEW CPT^FIRST NATIONAL NUMBER SEQUENCE^LAST NATIONAL
 ;  NUMBER SEQUENCE
 ;
 N ECX,ECXX,ECCPT,DIC,DIE,DA,DR,X,Y,ECBEG,ECEND,ECADD,ECSEQ,ECSTR,ECCPTIEN
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Changing CPT Codes in EC NATIONAL PROCEDURE file (#725)")
 D MES^XPDUTL(" ")
 F ECX=1:1 S ECXX=$P($T(CPT+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECBEG=$P(ECXX,U,3),ECEND=$P(ECXX,U,4),ECCPTIEN=$P(ECXX,U,2)
 .S ECCPTIEN=$S(ECCPTIEN="":"@",1:$$FIND1^DIC(81,"","X",ECCPTIEN))
 .I ECCPTIEN'="@",+ECCPTIEN<1 D  Q
 ..S ECSTR=$P(ECXX,U)_":  CPT code "_$P(ECXX,U,2)_" is invalid."
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("   "_ECSTR)
 .I ECBEG="" S ECCPT($P(ECXX,U))=ECCPTIEN_U_$P(ECXX,U,2) Q
 .F ECSEQ=ECBEG:1:ECEND D
 ..S ECADD="000"_ECSEQ,ECADD=$E(ECADD,$L(ECADD)-2,$L(ECADD))
 ..S ECCPT($P(ECXX,U)_ECADD)=ECCPTIEN_U_$P(ECXX,U,2)
 S ECXX=""
 F  S ECXX=$O(ECCPT(ECXX)) Q:ECXX=""  D
 .S ECX=$O(^EC(725,"D",ECXX,0))
 .Q:+ECX=0
 .I '$D(^EC(725,ECX,0))!(+ECX=0) D  Q
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("   Can't find entry for "_ECXX_",CPT code not updated.")
 .S ECCPT=$P(ECCPT(ECXX),U),DA=ECX,DR="4///"_ECCPT,DIE="^EC(725," D ^DIE
 .D MES^XPDUTL(" ")
 .S ECSTR="   Entry #"_ECX_" for "_ECXX
 .D BMES^XPDUTL(ECSTR_" updated to use CPT code "_$P(ECCPT(ECXX),U,2))
 Q
 ;
CPT ;cpt codes to be changed - national #^new CPT code
 ;;CH100^
 ;;CH101^
 ;;CH102^
 ;;CH103^
 ;;CH104^
 ;;CH105^
 ;;CH106^
 ;;CH107^
 ;;CH108^
 ;;CH109^
 ;;CH110^
 ;;CH111^
 ;;CH112^
 ;;CH113^
 ;;CH114^
 ;;CH115^
 ;;CH116^
 ;;CH117^
 ;;CH118^
 ;;CH119^
 ;;CH120^
 ;;CH121^
 ;;CH122^
 ;;CH123^
 ;;CH124^
 ;;SW046^99600
 ;;SW001^99600
 ;;SW003^T1016
 ;;SW004^90846
 ;;SW006^96152
 ;;SW009^99366
 ;;SW019^96153
 ;;SW035^90847
 ;;SW047^G0155
 ;;SW048^T1016
 ;;SW061^90832
 ;;SW062^90834
 ;;SW063^90837
 ;;SW077^90791
 ;;SW120^3085F
 ;;SW124^T1016
 ;;SW130^90847
 ;;SW131^90846
 ;;QUIT
