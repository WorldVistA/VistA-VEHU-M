PRCAP415 ;EDE/YMG - PRCA*4.5*415 POST INSTALL;02/15/23
 ;;4.5;Accounts Receivable;**415**;Mar 20, 1995;Build 1
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for PRCA*4.5*415")
 ; Update the AR Category file
 D UPCAT
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for PRCA*4.5*415")
 Q
 ;
UPCAT ; Update field 1.07 in the AR Category file.
 ;
 N CAT,DATA,FDA,RCIEN,Z
 D MES^XPDUTL("Updating field 1.07 (PRINT SPECIAL NOTICE?) in AR Category file ...")
 ;
 F Z=2:1 S DATA=$T(107+Z),CAT=$P(DATA,";",3) Q:CAT="END"  D
 .S RCIEN=+$O(^PRCA(430.2,"B",CAT,"")) I 'RCIEN Q
 .S FDA(430.2,RCIEN_",",1.07)=$P(DATA,";",4)
 .D FILE^DIE("","FDA") K FDA
 .D MES^XPDUTL("  Updated field 1.07 for the "_CAT_" AR Category.")
 D MES^XPDUTL("Done.")
 ;
 Q
107 ; Categories to update field 1.07 for
 ;;Category Name;field 1.07 value
 ;;ADULT DAY HEALTH CARE;1
 ;;C (MEANS TEST);1
 ;;CC INPT;1
 ;;CC MTF INPT;1
 ;;CC MTF OPT;1
 ;;CC MTF RX CO-PAYMENT;1
 ;;CC MTF THIRD PARTY;0
 ;;CC NO-FAULT AUTO;0
 ;;CC NURSING HOME CARE - LTC;1
 ;;CC OPT;1
 ;;CC RESPITE CARE;1
 ;;CC RX CO-PAYMENT;1
 ;;CC THIRD PARTY;0
 ;;CC TORT FEASOR;0
 ;;CC URGENT CARE;1
 ;;CC WORKERS' COMP;0
 ;;CCN INPT;1
 ;;CCN NO-FAULT AUTO;0
 ;;CCN NURSING HOME CARE - LTC;1
 ;;CCN OPT;1
 ;;CCN RESPITE CARE;1
 ;;CCN RX CO-PAYMENT;1
 ;;CCN THIRD PARTY;0
 ;;CCN TORT FEASOR;0
 ;;CCN WORKERS' COMP;0
 ;;CHAMPVA;0
 ;;CHAMPVA SUBSISTENCE;1
 ;;CHAMPVA THIRD PARTY;0
 ;;CHOICE INPT;1
 ;;CHOICE NO-FAULT AUTO;0
 ;;CHOICE NURSING HOME CARE - LTC;1
 ;;CHOICE OPT;1
 ;;CHOICE RESPITE CARE;1
 ;;CHOICE RX CO-PAYMENT;1
 ;;CHOICE THIRD PARTY;0
 ;;CHOICE TORT FEASOR;0
 ;;CHOICE WORKERS' COMP;0
 ;;COMP & PEN PROCEEDS;0
 ;;CRIME OF PER.VIO.;0
 ;;CURRENT EMP.;0
 ;;CWT PROCEEDS;0
 ;;DOMICILIARY;1
 ;;EMERGENCY/HUMANITARIAN;1
 ;;EMERGENCY/HUMANITARIAN REIMB.;0
 ;;ENHANCED USE LEASE PROCEEDS;0
 ;;EX-EMPLOYEE;0
 ;;FEDERAL AGENCIES-REFUND;0
 ;;FEDERAL AGENCIES-REIMB.;0
 ;;FEE REIMB INS;0
 ;;GERIATRIC EVAL-INSTITUTIONAL;1
 ;;GERIATRIC EVAL-NON-INSTITUTION;1
 ;;HOSPITAL CARE (NSC);1
 ;;HOSPITAL CARE PER DIEM;1
 ;;INELIGIBLE HOSP.;1
 ;;INELIGIBLE HOSP. REIMB.;0
 ;;INTERAGENCY;0
 ;;MEDICARE;0
 ;;MILITARY;0
 ;;NO-FAULT AUTO ACC.;0
 ;;NURSING HOME CARE PER DIEM;1
 ;;NURSING HOME CARE(NSC);1
 ;;NURSING HOME CARE-LTC;1
 ;;NURSING HOME PROCEEDS;0
 ;;OUTPATIENT CARE(NSC);1
 ;;PARKING FEES;0
 ;;PREPAYMENT;0
 ;;REIMBURS.HEALTH INS.;0
 ;;RESPITE CARE-INSTITUTIONAL;1
 ;;RESPITE CARE-NON-INSTITUTIONAL;1
 ;;RX CO-PAYMENT/SC VET;1
 ;;RX CO-PAYMENT/NSC VET;1
 ;;SHARING AGREEMENTS;0
 ;;TORT FEASOR;0
 ;;TRICARE;0
 ;;TRICARE BLIND REHABILITATION;0
 ;;TRICARE DENTAL;0
 ;;TRICARE DES;0
 ;;TRICARE PATIENT;1
 ;;TRICARE PHARMACY;0
 ;;TRICARE SCI;0
 ;;TRICARE TBI;0
 ;;TRICARE THIRD PARTY;0
 ;;VENDOR;0
 ;;WORKMAN'S COMP.;0
 ;;END
