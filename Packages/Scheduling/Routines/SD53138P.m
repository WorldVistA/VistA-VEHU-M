SD53138P ;ALB/SEK - ADD ERRORS CODES TO TRANS OUTPAT ENCOUNT ERROR CODE FILE; 08 January 1998
 ;;5.3;Scheduling;**138**;Aug 13, 1993
 ;
 ;This post-install routine for patch SD*5.3*138 will add error codes
 ;and descriptions to the TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE
 ;file (#409.76).
 ;
EN ;begin processing
 ;
 N DA,DIC,DIE,DLAYGO,DR,X,Y,I,SDNAME,SDTYPE
 ;
 D BMES^XPDUTL(">>>Adding error codes and descriptions...")
 ;
 S (DIC,DIE)="^SD(409.76,",DIC(0)="LMX"
 F I=1:1 S X=$P($T(DATA+I),";;",2) Q:X="QUIT"  D  Q:$G(Y)=-1
 .S SDNAME=$P(X,"^",2),DR="11////^S X=SDNAME"
 .S X=$P(X,"^")
 .S DLAYGO=409.76
 .D ^DIC
 .I Y=-1 D  Q
 .. D BMES^XPDUTL("   ...Problem encountered adding error codes.  Please try")
 .. D MES^XPDUTL("      again or contact your IRM Field Office for assistance.")
 .S SDTYPE=$S($P(Y,"^",3):"Added",1:"EDITED")
 .D MES^XPDUTL(">>>>>"_SDTYPE_"  "_X_" - "_SDNAME)
 .S DA=+Y
 .D ^DIE
 .Q
 ;
 Q:$G(Y)=-1
 D MES^XPDUTL(">>>Adding codes and descriptions completed")
 Q
 ;
 ;
DATA ;lines to add error codes and descriptions
 ;;226^Inactive State/County code.
 ;;322^Type of Insurance is inactive.
 ;;406^Inactive Purpose of Visit or Appointment Type.
 ;;416^Inactive Facility Station Number.
 ;;502^Inactive Diagnosis Code.
 ;;607^Inactive Procedure Code.
 ;;622^Inactive Procedure Practitioner code.
 ;;703^Encounter Eligibility Code inactive.
 ;;812^Means Test Indicator inactive.
 ;;906^Inactive Outpatient Classification Type.
 ;;A02^Inactive DSS Identifier/Stop Code.
 ;;B12^Inactive Period of Service.
 ;;QUIT
