ORY639 ;SLC/AGP/ - PRE/POST INSTALL OR*3.0*639 ;Jul 08, 2026@11:34:19
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**639**;Dec 17, 1997;Build 4
 ;
 ; Reference to $$LKOPT^XPDMENU in ICR #1157
 ; Reference to XPDUTL in ICR #10141
 ; Reference to ^DIE in ICR #10018
 ; Reference to ^DIC(19 in ICR #7397
 ;
 Q
 ;
PRE ;
 N DA,DIE,DR,Y
 S DA=$$LKOPT^XPDMENU("OR CPRS GUI CHART")
 I DA<1 D BMES^XPDUTL("OR CPRS GUI CHART, option not found.") Q
 S DIE="^DIC(19,",DR="1///CPRSChart version 1.33.214.5"
 D ^DIE
 Q
 ;
POST ;
 Q
 ;
