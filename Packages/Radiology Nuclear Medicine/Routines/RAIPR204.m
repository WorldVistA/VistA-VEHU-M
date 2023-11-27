RAIPR204 ;WOIFO/KLM - Pre-init Driver, patch 204 ; Aug 31, 2023@09:49:52
 ;;5.0;Radiology/Nuclear Medicine;**204**;Mar 16, 1998;Build 2
 ; Backup 78.3 file during a pre-install process.
 ; Setup ^XTMP to save any errors that occur during post-init
 ; Save backed up data 180 days
 ;
DIAGBKUP ; Backup the 78.3 [DIAGNOSIS FILE]
 I '$D(^XTMP("RA*5.0*204 DIAGNOSTIC CODES FILE UPDATE BACKUP OF 78.3")) D
 .N X,Y
 .S X=DT,Y=180
 .S ^XTMP("RA*5.0*204 DIAGNOSTIC CODES FILE UPDATE BACKUP OF 78.3",0)=$$FMADD^XLFDT(X,Y,0,0,0)_U_$G(DT)_U_"Backup of file 78.3 before update is performed by Patch RA*5*204"
 .M ^XTMP("RA*5.0*204 DIAGNOSTIC CODES FILE UPDATE BACKUP OF 78.3",78.3)=^RA(78.3)
 .D EN^DDIOL("DIAGNOSTIC CODES File 78.3 Backup complete","","!!?1")
 .Q
