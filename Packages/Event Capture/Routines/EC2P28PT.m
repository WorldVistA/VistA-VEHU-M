EC2P28PT ;ALB/GTS/JAP/JAM/TMD - PATCH EC*2.0*28 Post-Init Rtn ; 5/3/01 8:17pm
 ;;2.0; EVENT CAPTURE ;**28**;8 May 96
 ;
POST ; entry point
 N ECVRRV
 ;* if 725 converted, write message
 ;  since check inserted in addproc subroutine, patch may be re-installed
 I $$GET1^DID(725,"","","PACKAGE REVISION DATA")["EC*2*28" D
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("It appears that the EC NATIONAL PROCEDURE")
 .D MES^XPDUTL("file (#725) has already been updated")
 .D MES^XPDUTL("with Patch EC*2*28.")
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("But the patch may be re-installed...")
 .D MES^XPDUTL(" ")
 D ENTUP
 Q
 ;
ENTUP ; 
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Updating the National Procedures file (#725)...")
 D MES^XPDUTL(" ")
 ;* add new national procedures
 D ADDPROC^EC725U11
 ;* set vrrv node (file #725)
 S ECVRRV=$$GET1^DID(725,"","","PACKAGE REVISION DATA")
 S ECVRRV=ECVRRV_"^EC*2*28"
 D PRD^DILFD(725,ECVRRV)
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Update of EC NATIONAL PROCEDURE file (#725)")
 D BMES^XPDUTL("   completed...")
 D MES^XPDUTL(" ")
 Q
