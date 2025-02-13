DVBC238P ;ALB/BG - PATCH 238 POST INSTALL ; 7/27/22 9:04am
 ;;2.7;AMIE;**238**;Apr 10, 1995;Build 16
 ;Per VHA Directive 6402 this routine should not be modified
 ;#1157 - $$ADD^XPDMENU (supported)
 ;Updates Capri Minimum version, parameters and adds options
 Q
 ;
PMAIN ;-- update DVBAB CAPRI MINIMUM VERSION Parameter.
 D MES^XPDUTL("Patch DVBA*2.7*238 post install started")
 N DVBERR,DVBMENU,DVBOPT,DVBOR,DVBSYN
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI MINIMUM VERSION","CAPRI GUI V2.7*238.2*1*A*3220815*1.3*1.3")
 D UPDMSG("CAPRI MINIMUM VERSION",DVBERR)
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI PREVIOUS VERSION","DVBA*2.7*240.1")
 D UPDMSG("DVBAB CAPRI PREVIOUS VERSION",DVBERR)
 K DVBERR S DVBMENU="DVBA C MEDICAL ADM REPORT MENU",DVBOPT="DVBA METRICS DATA REPORT",DVBOR=11,DVBSYN=11
 S DVBERR=$$ADD^XPDMENU(DVBMENU,DVBOPT,DVBSYN,DVBOR)
 I DVBERR=0 D MES^XPDUTL("Error adding option")
 I DVBERR=1 D MES^XPDUTL("DVBA METRICS DATA REPORT added")
 K DVBERR S DVBMENU="DVBA C MEDICAL ADM REPORT MENU",DVBOPT="DVBA METRICS DATA PURGE",DVBOR=12,DVBSYN=12
 S DVBERR=$$ADD^XPDMENU(DVBMENU,DVBOPT,DVBSYN,DVBOR)
 I DVBERR=0 D MES^XPDUTL("Error adding option")
 I DVBERR=1 D MES^XPDUTL("DVBA METRICS DATA PURGE added")
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI VLER DAS PROD URL","https://capriauthsvrprod.domain.ext:7003/dbq")
 D UPDMSG("DVBAB CAPRI VLER DAS PROD URL",DVBERR)
 D SECKEY^DVBCP238
 D MES^XPDUTL("Patch DVBA*2.7*238 post install finished")
 Q
 ;
ENXPAR(DVBENT,DVBPAR,DVBVAL) ;
 ;
 N DVBERR
 D EN^XPAR(DVBENT,DVBPAR,1,DVBVAL,.DVBERR)
 Q DVBERR
 ;
 ;
UPDMSG(DVBPAR,DVBERR) ;
 ;
 I DVBERR D
 . D MES^XPDUTL(DVBPAR_" Update FAILURE.")
 . D MES^XPDUTL("  Failure reason: "_DVBERR)
 E  D
 . D MES^XPDUTL(DVBPAR_" Updated Successfully")
 Q
 ;
