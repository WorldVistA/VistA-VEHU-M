RGP13ENV ;B'HAM/PTD-PATCH RG*1*13 ENVIRONMENT CHECK ROUTINE ;03/21/01
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**13**;30 Apr 99
 ;Reference to LINK^HLUTIL3 and $$GET1^DIQ(870 supported by IA #3335
 ;Reference to $$FIND1^DIC(4.2, $$FIND1^DIC(4.21, $$GET1^DIQ(4.2 and
 ;$$GET1^DIQ(4.21 supported by IA #3100
 ;
 ;Ensure that patch XM*DBA*144 is in place for production account.
 ;
 N RGDOMAIN
 S RGDOMAIN=""
 ;Determine test or production account (production must have
 ;"MPI-AUSTIN.VA.GOV" domain for logical link "MPIVA").
 ;For production, check value of flags (#1) field in DOMAIN (#4.2) file.
 ;Also check for 'TCP/IP' transmission script (#4) and for that entry,
 ;check for the correct address (#1.4) and that there is no value in
 ;the out of service (#1.5) field.
 ;
 ;Get logical link IEN for "MPIVA".
DOMAIN ;Get domain for "MPIVA" logical link in HL LOGICAL LINK (#870) file.
 D LINK^HLUTIL3("200M",.HLL,"I")
 S IEN=$O(HLL(0)) I +IEN>0 S RGDOMAIN=$$GET1^DIQ(870,+IEN_",",.03)
 I RGDOMAIN'="" D
 .Q:RGDOMAIN'="MPI-AUSTIN.VA.GOV"  ;No check necessary - not production; quit.
 .I RGDOMAIN="MPI-AUSTIN.VA.GOV" D  ;Production account - confirm setup.
 ..S RGDIEN=$$FIND1^DIC(4.2,"","MX",RGDOMAIN) ;IEN in DOMAIN (#4.2) file.
 ..I RGDIEN'>0 S RGMSG(1)="",XPDQUIT=2 Q  ;DOMAIN not there; quit.
 ..;Else we have and IEN for MPI-AUSTIN.VA.GOV in the DOMAIN (#4.2) file.
 ..S RGFLAG=$$GET1^DIQ(4.2,RGDIEN,1) ;get value of FLAGS (#1) field.
 ..I RGFLAG'["S" S RGMSG(2)="",XPDQUIT=2 ;FLAGS (#1) field not correct.
 ..S RGTCPIP=$$FIND1^DIC(4.21,","_RGDIEN_",","BX","TCP/IP") ;IEN for TCP/IP.
 ..I RGTCPIP'>0 S RGMSG(3)="",XPDQUIT=2 Q  ;No 'TCP/IP' transmission script.
 ..;Else we have a 'TCP/IP' transmission script.
 ..S RGADDR=$$GET1^DIQ(4.21,RGTCPIP_","_RGDIEN,1.4) ;get value of NETWORK ADDRESS (MAILMAN HOST) (#1.4) field.
 ..I RGADDR'="152.125.191.142" S RGMSG(4)="",XPDQUIT=2 ;address not correct.
 ..;Else the address is correct.
 ..S RGOOS=$$GET1^DIQ(4.21,RGTCPIP_","_RGDIEN,1.5,"I") ;get value of OUT OF SERVICE (#1.5) field.
 ..I RGOOS=1 S RGMSG(5)="",XPDQUIT=2 ;transmission script out of service.
 ;
ERR ;If XPDQUIT has been set, print error message(s).
 I $D(XPDQUIT) W ! S MSG=0 F  S MSG=$O(RGMSG(MSG)) Q:'MSG  D  W !
 .I MSG=1 W !," No DOMAIN entry found for "_RGDOMAIN_"."
 .I MSG=2 W !," FLAG (#1) field is not set to 'S' for "_RGDOMAIN_"."
 .I MSG=3 W !," No 'TCP/IP' transmission script found for "_RGDOMAIN_"."
 .I MSG=4 W !," The TCP/IP address for "_RGDOMAIN_" should be 152.125.191.142."
 .I MSG=5 W !," The OUT OF SERVICE (#1.5) field should not be set for "_RGDOMAIN_"."
 ;
 I '$D(XPDQUIT) W !!,"Environment check is ok.",!
 K DIC,HLL,IEN,MSG,RGADDR,RGDIEN,RGDOMAIN,RGFLAG,RGMSG,RGOOS,RGTCPIP,X,Y
 Q
 ;
