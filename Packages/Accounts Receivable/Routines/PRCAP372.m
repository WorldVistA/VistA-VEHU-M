PRCAP372 ;SAB/Albany - PRCA*4.5*372 POST INSTALL;07/30/19 2:10pm
 ;;4.5;Accounts Receivable;**372**;Mar 20, 1995;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POSTINIT ;Post Install for PRCA*4.5*372
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for PRCA*4.5*372 ")
 ; Update the AR Category fields 
 D UPCAT104
 D UPCAT105
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for PRCA*4.5*372")
 Q
 ;
UPCAT104 ; Update the 1.04 field in the AR Category file for Tricare/CHAMPVA/LTC copays so they display correctly. 
 ;
 D MES^XPDUTL("Updating the 1.04 field (DISPLAY IN BILL PROFILE) field for LTC/TRICARE/CHAMPVA AR Categories ... ")
 ;
 F LOOP=2:1 S DATA=$T(ARCATDT+LOOP) Q:$P(DATA,";",3)="END"  D
 . S RCIEN=$$FIND1^DIC(430.2,,"B",$P(DATA,";",3),"B")
 . I RCIEN D  Q
 . . N FDA,MESS,TSTAMP
 . . S FDA(430.2,+RCIEN_",",1.04)=$P(DATA,";",4)
 . . D FILE^DIE("","FDA","MESS")
 . . K FDA,MESS,TSTAMP
 . . D MES^XPDUTL("Updated field 1.04 for the "_$P(DATA,";",3)_" AR Category.")
 ;
 Q
ARCATDT ; Categories to update field 1.04
 ;;Category Name;Display on Bill Profile as
 ;;RESPITE CARE-INSTITUTIONAL;3
 ;;NURSING HOME CARE-LTC;3
 ;;ADULT DAY HEALTH CARE;3
 ;;GERIATRIC EVAL-INSTITUTIONAL;3
 ;;GERIATRIC EVAL-NON-INSTITUTION;3
 ;;HOSPITAL CARE PER DIEM;4
 ;;NURSING HOME CARE PER DIEM;4
 ;;NURSING HOME CARE-LTC;3
 ;;RESPITE CARE-INSTITUTIONAL;3
 ;;RESPITE CARE-NON-INSTITUTIONAL;3
 ;;CC NURSING HOME CARE - LTC;3
 ;;CC RESPITE CARE;3
 ;;CC MTF NURSING HOME CARE - LTC;3
 ;;CC MTF RESPITE CARE;3
 ;;CCN NURSING HOME CARE - LTC;3
 ;;CCN RESPITE CARE;3
 ;;CHOICE NURSING HOME CARE - LTC;3
 ;;CHOICE RESPITE CARE;3
 ;;END
 ;
UPCAT105 ; Update the 1.04 field in the AR Category file for Tricare/CHAMPVA/LTC copays so they display correctly. 
 ;
 N RCDATA,RCLOOP,RCIEN,RCCTNM
 ;D MES^XPDUTL("Updating the 1.05 field (DISPLAY BILL PROF DESC INFO) field for affected AR Categories ... ")
 ;
 F RCLOOP=2:1 S RCDATA=$T(ARCT105D+RCLOOP),RCCTNM=$P(RCDATA,";",3) Q:$P(RCDATA,";",3)="END"  D
 . S RCIEN=$$FIND1^DIC(430.2,,"B",$P(RCDATA,";",3),"B")
 . I RCIEN D  Q
 . . N FDA,MESS,TSTAMP
 . . S FDA(430.2,+RCIEN_",",1.05)=$P(RCDATA,";",4)
 . . D FILE^DIE("","FDA","MESS")
 . . D MES^XPDUTL("Updated field 1.05 for the "_$P(RCDATA,";",3)_" AR Category.")
 . . K FDA,MESS,TSTAMP
 ;
 Q
ARCT105D ; Categories to update field 1.04
 ;;Category Name;Display on Bill Profile as
 ;;NURSING HOME CARE(NSC);6
 ;;OUTPATIENT CARE(NSC);2
 ;;HOSPITAL CARE (NSC);3
 ;;RX CO-PAYMENT/SC VET;1
 ;;RX CO-PAYMENT/NSC VET;1
 ;;ADULT DAY HEALTH CARE;2
 ;;CHOICE INPT;3
 ;;CC INPT;3
 ;;CCN INPT;3
 ;;CC MTF INPT;3
 ;;CHOICE RX CO-PAYMENT;4
 ;;CC RX CO-PAYMENT;4
 ;;CCN RX CO-PAYMENT;4
 ;;CC MTF RX CO-PAYMENT;4
 ;;CHOICE OPT;2
 ;;CC OPT;2
 ;;CCN OPT;2
 ;;CC MTF OPT;2
 ;;CC URGENT CARE;2
 ;;RESPITE CARE-INSTITUTIONAL;3
 ;;NURSING HOME CARE-LTC;3
 ;;ADULT DAY HEALTH CARE;5
 ;;GERIATRIC EVAL-INSTITUTIONAL;6
 ;;GERIATRIC EVAL-NON-INSTITUTION;5
 ;;HOSPITAL CARE PER DIEM;3
 ;;NURSING HOME CARE PER DIEM;6
 ;;NURSING HOME CARE-LTC;6
 ;;RESPITE CARE-INSTITUTIONAL;6
 ;;RESPITE CARE-NON-INSTITUTIONAL;5
 ;;CC NURSING HOME CARE - LTC;7
 ;;CC RESPITE CARE;7
 ;;CC MTF NURSING HOME CARE - LTC;7
 ;;CC MTF RESPITE CARE;7
 ;;CCN NURSING HOME CARE - LTC;7
 ;;CCN RESPITE CARE;7
 ;;CHOICE NURSING HOME CARE - LTC;7
 ;;CHOICE RESPITE CARE;7
 ;;END
