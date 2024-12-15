PRC236P ;MNTVBB/RD - IFCAP FEDERAL SUPPLY CLASSIFICATION FILE updates ; August 6, 2024 @13:20
 ;;5.1;IFCAP;**236**;21-MAR-94;Build 3
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine is used as a post-init in a KIDS build to
 ; update the FEDERAL SUPPLY CLASSIFICATION file (#441.2).
 ;
 ; Reference to FILE^DICN supported by ICR # 10009
 ; Reference to $$FMADD^XLFDT in ICR #10103
 ; Reference to BMES^XPDUTL supported by ICR# 10141
 ; Reference to MES^XPDUTL supported by ICR# 10141
 ;
 Q
EN ;
 ; Backup 441.2 FEDERAL SUPPLY CLASSIFICATION File
 N P236FILE,P236FILES,PRCCNT
 S P236FILE=""
 S P236FILES="441.2"
 S PRCCNT=0
 F PRCCNT=1:1:$L(P236FILES,"^") D
 . S P236FILE=$P(P236FILES,"^",PRCCNT)
 . D GLBBKUP
 . Q
 ; Begin Update
 D START,ADD,FINISH
 Q
 ;
START D BMES^XPDUTL("    PRC*5.1*236 Post-Install Starting .....")
 Q
 ;
FINISH D BMES^XPDUTL("    PRC*5.1*236 Post-Install Complete")
 Q
 ;
 ;
ADD ;add a new FEDERAL SUPPLY CLASSIFICATION number
 N X,Y,PRCC,PRCCER,PRCT,PRCX,PRCNUM,PRCADES,PRCGRP,PRCCCD,PRCDLA,PRCDES,PRCDINUM,DINUM,DIC,DR,DLAYGO
 D BMES^XPDUTL(" Adding new numbers to file 441.2")
 S (PRCC,PRCCER)=0
 F PRCX=1:1 S PRCT=$P($T(NNUM+PRCX),";;",2) Q:PRCT="QUIT"  D
 . S PRCNUM=$P(PRCT,U)
 . S PRCADES=$P(PRCT,U,2)
 . S PRCGRP=$P(PRCT,U,3)
 . S PRCCCD=$P(PRCT,U,4)
 . S PRCDLA=$P(PRCT,U,5)
 . S PRCDES=$P(PRCT,U,6)
 . I $D(^PRC(441.2,"B",PRCNUM)) D  Q
 . . D BMES^XPDUTL(" Duplication of FEDERAL SUPPLY CLASSIFICATION number "_PRCNUM)
 . S X=PRCNUM
 . D ADD4412
 D BMES^XPDUTL("    >> "_PRCC_$S(PRCC<2:" entry",1:" entries")_" added to file 441.2")
 I PRCCER>0 D MES^XPDUTL("    Total "_PRCCER_" new codes have NOT been added.")
 Q
 ;
ADD4412 ;File new entries
 ;add a new entry
 D BMES^XPDUTL("   "_PRCNUM_"  "_PRCDES)
 N PRCIENS,PRCFDA,PRCER,PRCRET,PRCSTR
 S PRCRET=""
 S PRCIENS="+1,"
 S PRCFDA(441.2,PRCIENS,.01)=PRCNUM
 S PRCFDA(441.2,PRCIENS,1)=PRCADES
 S PRCFDA(441.2,PRCIENS,3)=PRCGRP
 S PRCFDA(441.2,PRCIENS,4)=PRCCCD
 S PRCFDA(441.2,PRCIENS,5)=PRCDLA
 S PRCFDA(441.2,PRCIENS,2)=PRCDES
 S PRCDINUM=$S(PRCNUM?4N:PRCNUM,PRCNUM?1A3N:$A(PRCNUM)_$E(PRCNUM,2,4),PRCNUM?2A2N:$A(PRCNUM)_$A(PRCNUM,2)_$E(PRCNUM,3,4),PRCNUM?1A1N2A:$A(PRCNUM)_$E(PRCNUM,2)_$A(PRCNUM,3)_$A(PRCNUM,4),1:$E(PRCNUM,1)_$A(PRCNUM,2)_$E(PRCNUM,3,4))
 S DINUM=PRCDINUM,DIC(0)="",DLAYGO=441.2,DIC="^PRC(441.2,"
 S DIC("DR")="1///^S X=PRCADES;3///^S X=PRCGRP;4///^S X=PRCCCD;5///^S X=PRCDLA;2///^S X=PRCDES"
 D FILE^DICN
 ;
 I +Y>0 D
 .S PRCC=PRCC+1
 .D MES^XPDUTL(" ")
 .S PRCSTR=PRCNUM_"     "_PRCADES
 .D MES^XPDUTL(PRCSTR)
 .D MES^XPDUTL("      ...successfully added.")
 ;
 I Y=-1 D
 .S PRCCER=PRCCER+1
 .D MES^XPDUTL(" ")
 .D BMES^XPDUTL("    ERROR when attempting to add "_PRCNUM_" ("_PRCADES_")")
 Q
 ;
 ;
GLBBKUP  ; XTMP Backup of file(s)
 N PRCBKNDE
 S PRCBKNDE="PRC*5.1*236-FEDERAL SUPPLY CLASSIFICATION FILE updates (#441.2)"
 S ^XTMP("PRC236P",0)=$$FMADD^XLFDT(DT,120)_"^"_DT_"^"_PRCBKNDE
 M ^XTMP("PRC236P",P236FILE,$H)=^PRC(P236FILE)
 Q
 ;new codes - ADD
NNUM ;;number^abbreviated description^group^commodity code^dla address^description
 ;;DA01^IT&Tel-Bus App/App Dev Supp Svc^115^3^7^IT and Telecom - Business Application/Application Development Support Services (Labor)
 ;;DA10^IT&Tel-Bus App/App Dev Sftwr^115^3^7^IT and Telecom - Business Application/Application Development Software As A Service
 ;;DB01^IT&Tel-High Perf Comp Supp Svc^115^3^7^IT and Telecom - High Performance Computing (HPC) Support Services (Labor)
 ;;DB02^IT&Tel-Comp Supp Svc, Non-HPC^115^3^7^IT and Telecom - Compute Support Services, Non-HPC (Labor)
 ;;DB10^IT&Tel-Comp As A Svc: M-frm/Srvr^115^3^7^IT and Telecom - Compute As A Service: Mainframe/Servers
 ;;DC01^IT&Tel-Data Cntr Support Svc^115^3^7^IT and Telecom - Data Center Support Services (Labor)
 ;;DC10^IT&Tel-Data Cntr As A Svc^115^3^7^IT and Telecom - Data Center As A Service
 ;;DD01^IT&Tel-Svc Del Supp Svc: ITSM, Op^115^3^7^IT and Telecom - Service Delivery Support Services: ITSM, Operations Center, Project/PM (Labor)
 ;;DE01^IT&Tel-End User: Help Desk; Wrks^115^3^7^IT and Telecom - End User: Help Desk; Tier1-2, Workspace, Print, Productivity Tools (Labor)
 ;;DE02^IT&Tel-Mobile Device Supp Svc^115^3^7^IT and Telecom - Mobile Device Support Services (Labor)
 ;;DE10^IT&Tel-End User Svc: Help Desk^115^3^7^IT and Telecom - End User As A Service: Help Desk; Tier 1-2, Workspace, Print, Productivity Tools
 ;;DE11^IT&Tel-Mobile Device As A Svc^115^3^7^IT and Telecom - Mobile Device As A Service
 ;;DF01^IT&Tel-IT Mgmt Support Svcs^115^3^7^IT and Telecom - IT Management Support Services (Labor)
 ;;DF10^IT&Tel-IT Mgmt As A Svc^115^3^7^IT and Telecom - IT Management As A Service
 ;;DG01^IT&Tel-Network Support Svcs^115^3^7^IT and Telecom - Network Support Services (Labor)
 ;;DG10^IT&Tel-Network As A Svc^115^3^7^IT and Telecom - Network As A Service
 ;;DG11^IT&Tel-Network: Tele Access Svc^115^3^7^IT and Telecom - Network: Telecom Access Services
 ;;DH01^IT&Tel-Pltfrm Supp Svcs: Dtbs^115^3^7^IT and Telecom - Platform Support Services: Database, Mainframe, Middleware (Labor)
 ;;DH10^IT&Tel-Pltfrm As A Svc: Dtbs^115^3^7^IT and Telecom - Platform As A Service: Database, Mainframe, Middleware
 ;;DJ01^IT&Tel-Scrty And Cmplnc Supp Svc^115^3^7^IT and Telecom - Security And Compliance Support Services (Labor)
 ;;DJ10^IT&Tel-Scrty And Cmplnc As A Svc^115^3^7^IT and Telecom - Security And Compliance As A Service
 ;;DK01^IT&Tel-Strg Supp Svcs (Labor)^115^3^7^IT and Telecom - Storage Support Services (Labor)
 ;;DK10^IT&Tel - Strg As A Svc^115^3^7^IT and Telecom - Storage As A Service
 ;;7A20^IT&Tel-App Dvlpmnt Sftwr (Prptl^115^3^7^IT and Telecom - Application Development Software (Perpetual License Software)
 ;;7A21^IT&Tel-Bus App Sftwr (Prptl Lcnsr^115^3^7^IT and Telecom - Business Application Software (Pepetual License Software)
 ;;7B20^IT&Tel-High Perf Cmptr (Hrdwr^115^3^7^IT and Telecom - High Performance Compute (Hardware and Perpetual License Software)
 ;;7B21^IT&Tel-Cmptr: M-frm (Hrdwr^115^3^7^IT and Telecom - Compute: Mainframe (Hardware and Perpetual License Software)
 ;;7B22^IT&Tel-Cmptr: Srvrs (Hrdwr/Prptl^115^3^7^IT and Telecom - Compute: Servers (Hardware and Perpetual License Software)
 ;;7C20^IT&Tel-Data Cntr Prdcts (Hrdwr/^115^3^7^IT and Telecom - Data Center Products (Hardware and Perpetual License Software)
 ;;7C21^IT&Tel-Other Data Cntr Fclts Prdct^115^3^7^IT and Telecom - Other Data Center Facilities Products (Hardware and Perpetual License Software)
 ;;7D20^IT&Tel-Svc Del Mgmt (Hrdwr/Prdc^115^3^7^IT and Telecom - Service Delivery Management (Hardware and Perpetual License Software)
 ;;7E20^IT&Tel - End User: Help Desk, Wrk^115^3^7^IT and Telecom - End User: Help Desk;Tier 1-2, Workspace, Print, Productivity Tool (HW/Perpetual SW)
 ;;7E21^IT&Tel-Mobile Device Prdcts (Hrd^115^3^7^IT and Telecom - Mobile Device Products (Hardware and Perpetual License Software)
 ;;7F20^IT&Tel-It Mgmt Tools/Prdcts (Hrd^115^3^7^IT and Telecom - It Management Tools/Products (Hardware and Perpetual License Software)
 ;;7G20^IT&Tel-Ntwrk: Analog Voice Prdct^115^3^7^IT and Telecom - Network: Analog Voice Products (Hardware and Perpetual License Software)
 ;;7G21^IT&Tel-Ntwrk: Dgtl Ntwrk Prdcts^115^3^7^IT and Telecom - Network: Digital Network Products (Hardware and Perpetual License Software)
 ;;7G22^IT&Tel-Ntwrk: Stllt/RF Comm^115^3^7^IT and Telecom - Network: Satellite And RF Communications Products (HW, Perpetual License Software)
 ;;7H20^IT&Tel-Pltfrm Prdcts: Dtbs, M-frm^115^3^7^IT and Telecom - Platform Products: Database, Mainframe, Middleware (HW, Perpetual License Software)
 ;;7J20^IT&Tel-Scrty And Cmplnc Prdcts^115^3^7^IT and Telecom - Security And Compliance Products (Hardware and Perpetual License Software)
 ;;7K20^IT&Tel-Strg Prdcts (Hrdwr/Prptl^115^3^7^IT and Telecom - Storage Products (Hardware and Perpetual License Software)
 ;;QUIT
 ;
