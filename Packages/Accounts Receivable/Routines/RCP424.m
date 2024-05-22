RCP424 ;AITC/CJE - ePayment Lockbox Post-Installation Processing
 ;;4.5;Accounts Receivable;**424**;Oct 4, 2018;Build 11
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ;
 N RCMSG,RCFDA,RCFMERR,X,Y
 D BMES^XPDUTL("PRCA*4.5*424 post-installation work "_$$HTE^XLFDT($H)) ; add date/time to log
 ;
 ; (File #344.61 Field #1.11) AUTO POST ZERO PAY ENABLED
 S RCMSG="AUTO POST ZERO PAY ENABLED set to NO"
 S RCFDA(344.61,"1,",1.11)=0 ; only 1 entry in 344.61
 D FILE^DIE("","RCFDA","RCFMERR")
 D BMES^XPDUTL(RCMSG)
 Q
