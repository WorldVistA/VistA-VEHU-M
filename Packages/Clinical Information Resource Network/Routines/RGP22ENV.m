RGP22ENV ;BIR/PTD-PATCH RG*1*22 ENVIRONMENT CHECK ROUTINE ;09/13/01
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**22**;30 Apr 99
 ;Reference to $$FIND1^DIC(4.2, supported by IA #3452
 ;Ensure that patch XM*DBA*139 is in place.
 N RGDIEN
 S RGDIEN=$$FIND1^DIC(4.2,"","MX","MAIL.CIO.MED.VA.GOV") ;IEN in DOMAIN (#4.2) file.
 I RGDIEN'>0 S XPDQUIT=2 G END  ;DOMAIN not there.
 ;Else we have and IEN for MAIL.CIO.MED.VA.GOV in the DOMAIN (#4.2) file.
END ;Kill variables and quit.
 I '$D(XPDQUIT) W !!," Environment check is ok.",!
 I $D(XPDQUIT) D  ;Print error message.
 .W !!," No DOMAIN (#4.2) file entry was found for MAIL.CIO.MED.VA.GOV."
 .W !," Follow the instructions in VA MailMan patch XM*DBA*139 to create"
 .W !," this new entry in the DOMAIN (#4.2) file.  After the new DOMAIN"
 .W !," has been created, re-install patch RG*1*22.",!
 K RGDIEN
 Q
 ;
