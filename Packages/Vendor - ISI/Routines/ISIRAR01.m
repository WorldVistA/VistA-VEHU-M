ISIRAR01 ; ISI/BT - RAD Report ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 ;
 QUIT
 ;
 ; ##### Get RAD 'Standard' reports
 ; 
 ; OUTPUT
 ;   ISIOUT       Array contains all of RAD 'Standard' reports
 ;   ISIOUT(1)    = Number of Records or 0^Error Message
 ;   ISIOUT(2..n) = IEN ^ 'Standard' Report Name
 ;
GETSTD(ISIOUT) ;RPC [ISI GET RAD STANDARD REPORTS]
 K ISIOUT
 S ISIOUT(1)=0_U_"No 'Standard' Report found"
 N LST D LIST^DIC(74.1,,"@;.01",,,,,,,,"LST")
 N ID,CNT S (ID,CNT)=0
 F  S ID=$O(LST("DILIST","ID",ID)) Q:'ID  S CNT=CNT+1,ISIOUT(CNT+1)=ID_U_LST("DILIST","ID",ID,.01)
 S:CNT ISIOUT(1)=CNT
 QUIT
