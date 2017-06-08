ECX3P8P3 ;ALB/JAP - National Service update ;July 14, 1998
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
 ;
MOD7271 ;** modify entries in file #727.1
 ;ECXX is in format: ien;running piece;0 node;routine
 N ECX,ECXDA,ECXDAX,ECXX,ECXX2,ECXX3,ECXF,A1,A2,A3,A7,A8,A9,A10,DA,DIK,DIC,DIE,DR,ROU
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Modifying entries in EXTRACT DEFINITIONS File (#727.1)...")
 D MES^XPDUTL(" ")
 F ECX=1:1 S ECXX=$P($T(UPDATE+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECXDA=$P(ECXX,";",1)
 .;if specified ien exists then update record  
 .I $D(^ECX(727.1,ECXDA)) D  Q
 ..S ECXX2=$P(ECXX,";",2)
 ..S ECXDAX=ECXDA_","
 ..S ECXF(727.1,ECXDAX,11)=ECXX2
 ..K ^TMP("DIERR",$J)
 ..D FILE^DIE("","ECXF")
 ..I ECXDA=3 D
 ...S ^ECX(727.1,3,0)=$P(ECXX,";",3)
 ..I ECXDA=12 D
 ...S ^ECX(727.1,12,"ROU")="ECXLABN"
 ..I ECXDA=16 D
 ...S ^ECX(727.1,16,1,20,0)="on facility treating specialties which are entries in the FACILITY TREATING"
 ..I '$D(^TMP("DIERR",$J)) D MESS
 .I '$D(^ECX(727.1,ECXDA)) D
 ..S ROU=$P(ECXX,";",4),ECXX3=$P(ECXX,";",3)
 ..S A1=$P(ECXX3,U,1),A2=$P(ECXX3,U,2),A3=$P(ECXX3,U,3),A7=$P(ECXX3,U,7),A8=$P(ECXX3,U,8),A9=$P(ECXX3,U,9),A10=$P(ECXX3,U,10)
 ..S X=A1,DINUM=ECXDA,DIC="^ECX(727.1,",DLAYGO=727.1,DIC(0)="LX",DIC("DR")="1///^S X=A2;2///^S X=A3;4///^S X=ROU;7///^S X=A7;8///^S X=A8;9///^S X=A9;11///^S X=A10"
 ..K DD,DO D FILE^DICN K DLAYGO
 ..I Y D MESS
 ;establish the new "AC" index
 S DIK="^ECX(727.1,",DIK(1)="7^AC" D ENALL^DIK
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Done.")
 D MES^XPDUTL(" ")
 Q
 ;
MESS ;** modify message
 N ECXADMSG
 S ECXADMSG="     record #"_ECXDA_" updated."
 D MES^XPDUTL(ECXADMSG)
 D MES^XPDUTL(" ")
 Q
 ;
UPDATE ;updates to records
 ;;1;13
 ;;2;11
 ;;3;15;CLINIC NOSHOW^727.804^M^^^^Clinic no shows^NOS^SCNS^15
 ;;4;7
 ;;5;9
 ;;7;14
 ;;8;8
 ;;9;2
 ;;10;5
 ;;12;1
 ;;13;6
 ;;14;3
 ;;15;19
 ;;16;17
 ;;17;20
 ;;18;21
 ;;19;22
 ;;20;23;PROSTHETICS^727.826^M^^^^Prosthetics^PRO^PRO^23;ECXPRO
 ;;QUIT
