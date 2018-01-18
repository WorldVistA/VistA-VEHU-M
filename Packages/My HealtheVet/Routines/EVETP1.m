EVETP1 ;BP/GPM - Patch EVET*1.0*1 Install Utility Routine ; 8/4/03 1:19pm
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
 ;
PRE ;Main entry point for Pre-init items.
 Q
 ;
 ;
POST ;Main entry point for Post-init items.
 D POST1      ;create entry in EVET LOCAL CONFIG FILE
 ;
 Q
 ;
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
 ;
POST1 ; Create SYS entry in EVET LOCAL CONFIG file# 2276.999.
 N DR,DIC,DIE,D0,X,Y,DA,ROOT,IPADDR,PORT
 D BMES^XPDUTL("*** Adding definitions to EVET LOCAL CONFIG file.")
 I $$FIND1^DIC(2276.999,"","X","SYS") D BMES^XPDUTL("*** SYS configuration already exists, not added.") Q
 S ROOT="^EVET(2276.999,"
 S IPADDR="10.2.29.60"
 S PORT=5700
 S DIC=ROOT,DIC(0)=""
 S X="SYS"
 D FILE^DICN
 Q:Y<1
 S DA=+Y
 S DIE=ROOT
 S DR=".02////"_IPADDR_";.03////"_PORT_";.04////Y"
 D ^DIE
 Q
 ;
POST2 ; Interactive edit of EVET LOCAL CONFIG file# 2276.999
 N DR,DIC,DIE,D0,X,Y,DA,ROOT,PADDR,PPORT,TADDR,TPORT
 D BMES^XPDUTL("Editing EVET LOCAL CONFIG file.")
 S DA=$$FIND1^DIC(2276.999,"","X","SYS")
 I DA<1 D BMES^XPDUTL("SYS configuration does not exist, edit aborted") Q
 S ROOT="^EVET(2276.999,"
 S PADDR="10.2.29.60"
 S TADDR="10.2.29.60"
 S PPORT=5700
 S TPORT=5700
 S DIE=ROOT
 S DR=".04;S:X[""Y"" Y=""@98"";"
 S DR=DR_".02////"_PADDR_";.03////"_PPORT_";S Y=""@99"";"
 S DR=DR_"@98;.02////"_TADDR_";.03////"_TPORT_";.05;S Y=""@99"";"
 S DR=DR_"@99;.02;.03"
 D ^DIE
 Q
 ;
