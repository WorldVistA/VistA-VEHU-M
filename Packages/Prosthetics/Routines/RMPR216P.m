RMPR216P ;HDSO/DSK - RMPR*3.0*216 Post-Install Routine; May 02, 2024@17:00
 ;;3.0;PROSTHETICS;**216**;Feb 09, 1996;Build 20
 ;
 ; Reference to ^XUSEC in IA #10076
 ; Reference to BMES^XPDUTL in IA #10141
 ; Reference to ^XPDMENU in IA #1157
 ;
 Q
 ;
EN ;
 ;Broadcast which options were placed out of order.
 N RMPROPT
 F RMPROPT="RMPR PURGE MENU","RMPR PURGE CLOSED","RMPR PURGE CANCELLED","RMPR PURGE SUS" D
 . D BMES^XPDUTL("Option "_RMPROPT_" placed ""Out of Order"".")
 ;Delete RMPR PURGE MENU from RMPR UTILITIES
 ;so that the display order will reset after install.
 D DELETE^XPDMENU("RMPR UTILITIES","RMPR PURGE MENU")
 ;Add purge menu back to the utilities menu so will display last
 D ADD^XPDMENU("RMPR UTILITIES","RMPR PURGE MENU","","")
 D MAIL
 D BMES^XPDUTL("A MailMan message has been sent to the installer as well as")
 D BMES^XPDUTL("holders of the RMPRMANAGER security key.")
 Q
 ;
MAIL ;
 N RMPRMIN,RMPRMY,RMPRX,RMPRMSUB,RMPRMTEXT
 S RMPRMIN("FROM")="RMPR*3.0*216 Post-Install"
 S RMPRMY(DUZ)=""
 S RMPRX=""
 F  S RMPRX=$O(^XUSEC("RMPRMANAGER",RMPRX)) Q:RMPRX=""  D
 . S RMPRMY(RMPRX)=""
 S RMPRMSUB="RMPR*3.0*216 Post-Install"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^RMPR*3.0*216 POST INSTALL"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",1)="RMPR*3.0*216 is being released to adhere to a request received from the"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",2)="National Data Management Council (NDMC) to remediate issues related to"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",3)="Prosthetics purge options.  There have been recent situations where sites"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",4)="used an option to purge data, and substantial efforts from Patient Care"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",5)="Services and HDSO Sustainment were required to restore the data. The VHA"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",6)="Business office for Prosthetics requested that the following menu options"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",7)="be placed ""OUT OF ORDER"":"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",8)=" "
 S ^XTMP("RMPR*3.0*216 POST INSTALL",9)=" PGE  Purge Obsolete Data"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",10)="    **> Out of order:  (per patch RMPR*3.0*216)"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",11)=" PCL  Purge Closed Purchasing Transactions"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",12)="    **> Out of order:  (per patch RMPR*3.0*216)"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",13)=" PCX    Purge Cancelled Transactions"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",14)="    **> Out of order:  (per patch RMPR*3.0*216)"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",15)=" PSU    Purge Suspense Records"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",16)="    **> Out of order:  (per patch RMPR*3.0*216)"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",17)=" "
 S ^XTMP("RMPR*3.0*216 POST INSTALL",18)="The Purge Obsolete Data [RMPR PURGE MENU] Main Menu will be placed ""OUT"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",19)="OF ORDER"" and the Purge Aged Purchasing Transactions [RMPR PURGE AGED]"
 S ^XTMP("RMPR*3.0*216 POST INSTALL",20)="option will remain as a standalone option."
 S RMPRMTEXT="^XTMP(""RMPR*3.0*216 POST INSTALL"")"
 D SENDMSG^XMXAPI(DUZ,RMPRMSUB,RMPRMTEXT,.RMPRMY,.RMPRMIN,"","")
 Q
 ;
BACKOUT ;place options back "in order"
 N DIR,DTOUT,DUOUT,Y,RMPROPT
 S DIR("A")="Do you wish to back out the RMPR*3.0*216 patch",DIR("B")="NO",DIR(0)="Y"
 D ^DIR
 I 'Y!($D(DTOUT))!($D(DUOUT)) Q
 N DIR
 S DIR("A",1)=" "
 S DIR("A",2)="After completion, a MailMan message will be sent to holders of"
 S DIR("A",3)="of the RMPRMANAGER security key as well as yourself."
 S DIR("A")="Press enter to continue",DIR(0)="E"
 D ^DIR
 I 'Y!($D(DTOUT))!($D(DUOUT)) D  Q
 . W !!,"Aborting backout process"
 ;Removing out of order messages.
 F RMPROPT="RMPR PURGE MENU","RMPR PURGE CLOSED","RMPR PURGE CANCELLED","RMPR PURGE SUS" D
 . D OUT^XPDMENU(RMPROPT,"")
 . D BMES^XPDUTL("Option "_RMPROPT_" - out of order message removed.")
 ;Removing RMPR PURGE AGED from RMPR UTIILITIES menu.
 D DELETE^XPDMENU("RMPR UTILITIES","RMPR PURGE AGED")
 D BMES^XPDUTL("Option RMPR PURGE AGED removed from RMPR UTILITIES menu.")
 ;Adding RMPR PURGE AGED to the RMPR PURGE MENU.
 D ADD^XPDMENU("RMPR PURGE MENU","RMPR PURGE AGED","PAG","")
 D BMES^XPDUTL("Option RMPR PURGE AGED added back to the RMPR PURGE MENU.")
 ;Restore display order for RMPR PURGE MENU under RMPR UTILITIES.
 D ADD^XPDMENU("RMPR UTILITIES","RMPR PURGE MENU","PGE",8)
 D BMES^XPDUTL("Option RMPR PURGE MENU placed back into original position")
 D BMES^XPDUTL("within the RMPR UTILITIES menu.")
 D BMES^XPDUTL("RMPR*3.0*216 backout completed.")
 D BACKMAIL
 Q
 ;
BACKMAIL ;
 N RMPRMIN,RMPRMY,RMPRX,RMPRMSUB,RMPRMTEXT
 S RMPRMIN("FROM")="RMPR*3.0*216 Patch Backout"
 S RMPRMY(DUZ)=""
 S RMPRX=""
 F  S RMPRX=$O(^XUSEC("RMPRMANAGER",RMPRX)) Q:RMPRX=""  D
 . S RMPRMY(RMPRX)=""
 S RMPRMSUB="RMPR*3.0*216 Patch Back out"
 S ^XTMP("RMPR*3.0*216 BACKOUT",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^RMPR*3.0*216 Back out"
 S ^XTMP("RMPR*3.0*216 BACKOUT",1)="The out of order message has been removed from the following options:"
 S ^XTMP("RMPR*3.0*216 BACKOUT",2)=" "
 S ^XTMP("RMPR*3.0*216 BACKOUT",3)="   PGE    Purge Obsolete Data"
 S ^XTMP("RMPR*3.0*216 BACKOUT",4)="   PCL    Purge Closed Purchasing Transactions"
 S ^XTMP("RMPR*3.0*216 BACKOUT",5)="   PCX    Purge Cancelled Transactions"
 S ^XTMP("RMPR*3.0*216 BACKOUT",6)="   PSU    Purge Suspense Records"
 S ^XTMP("RMPR*3.0*216 BACKOUT",7)=" "
 S ^XTMP("RMPR*3.0*216 BACKOUT",8)="The ""PGE Purge Obsolete Data"" menu has been placed back into its"
 S ^XTMP("RMPR*3.0*216 BACKOUT",9)="original position within the RMPR UTILITIES menu."
 S ^XTMP("RMPR*3.0*216 BACKOUT",10)=" "
 S ^XTMP("RMPR*3.0*216 BACKOUT",11)="Option ""PAG Purge Aged Purchasing Transactions"" has been placed back"
 S ^XTMP("RMPR*3.0*216 BACKOUT",12)="into its original position within the ""PGE Purge Obsolete Data"" menu."
 S RMPRMTEXT="^XTMP(""RMPR*3.0*216 BACKOUT"")"
 D SENDMSG^XMXAPI(DUZ,RMPRMSUB,RMPRMTEXT,.RMPRMY,.RMPRMIN,"","")
 Q
