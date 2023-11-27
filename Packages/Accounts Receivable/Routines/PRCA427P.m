PRCA427P ;MNTVBB/RFS - Update for Annual Interest Rate in File 342 AR SITE PARAMETER; 08/11/23
 ;;4.5;Accounts Receivable;**427**;Mar 20, 1995;Build 1
 Q
 ;
EN ;ENTRY POINT
 D PRCANEW
 Q
PRCANEW ;Add new rates in File 342 AR SITE PARAMETER
 N X,Y
 D BMES^XPDUTL("** Updating AR SITE PARAMETER (#342) file **")
 S DA(1)=0 S DA(1)=$O(^RC(342,DA(1)))
 S X=999999 S X=$O(^RC(342,DA(1),4,X),-1)
 S X=X+1
 K DO
 S DIC="^RC(342,"_DA(1)_",4,",DIC(0)="L",DIC("DR")=".01///3230401;.02///.03;.03///1.40;.04///.06;.05///310.69"
 D FILE^DICN I Y=-1 D PRCAERR Q
 K DA(1),DIC
 D BMES^XPDUTL("** Done **") Q
PRCAERR ;Message to the user that an error occurred.
 D BMES^XPDUTL("*** AN ERROR OCCURRED WHEN ATTEMPTING TO ADD NEW FILE ENTRIES. PLEASE CONTACT PRODUCT SUPPORT ***")
 Q
