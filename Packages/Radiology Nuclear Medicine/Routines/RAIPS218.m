RAIPS218 ;HIRMFO/GJC - post install routine ; Aug 28, 2024@14:56:21
 ;;5.0;Radiology/Nuclear Medicine;**218**;Mar 16, 1998;Build 1
 ;
 ;Routine           File     IA      Type
 ;---------------------------------------
 ;$$FIND1^DIC                2051    (S)
 ;$$FILE^DIE                 2053    (S)
 ;$$GET1^DIQ                 2056    (S)
 ;                  101      872     (C)
 ;
EN ;main entry point
 ; Set key variables (constants)
 ; -----------------------------
 S RAEVTDRV="RA NTPV2 TCP SERVER RPT",RALOGLINK="RA-NTPV2"
 S RASUBSCRIBER="RA NTPV2 TCP REPORT",RASUBSCRIPT="EN^RAIPS218"
 ; variable list
 ; -------------
 ;RANTP2SRV : IEN of the event driver (FN #101)
 ;RANTP2SUB : IEN of the subscriber   (FN #101)
 ;RANTP2LNK : IEN of the logical link (FN #870)
 ;
 ; Find the IEN of the National Teleradiology Program (NTP) event driver: RAEVTDRV
 ; -------------------------------------------------------------------------------
 S RANTP2SRV=$$FIND1^DIC(101,,"X",RAEVTDRV,,,"RAMSGRT(RASUBSCRIPT)")
 ; Check RANTP2SRV: if RANTP2SRV>0 lookup was successful. If RANTP2SRV equals zero -or-
 ; if RAMSGRT(RASUBSCRIPT,"DIERR") exists the lookup failed. Update user on failure.
 ; the lookup failed.
 I RANTP2SRV=0!($D(RAMSGRT(RASUBSCRIPT,"DIERR"))#2) D  D XIT Q
 .N RATXT S RATXT(1)=" ",RATXT(2)="The lookup for event driver: '"_RAEVTDRV_"' failed."
 .S RATXT(3)="Contact the National Radiology development team."
 .D MES(.RATXT)
 .Q
 ;
 ; Find the IEN of the subscriber to the event driver RAEVTDRV: RASUBSCRIBER
 ; ----------------------------------------------------------------------------
 K RAMSGRT S RANTP2SUB=$$FIND1^DIC(101,,"X",RASUBSCRIBER,,,"RAMSGRT(RASUBSCRIPT)")
 I RANTP2SUB=0!($D(RAMSGRT(RASUBSCRIPT,"DIERR"))#2) D  D XIT Q
 .N RATXT S RATXT(1)=" ",RATXT(2)="The lookup for subscriber: '"_RASUBSCRIBER_"' failed."
 .S RATXT(3)="Contact the National Radiology development team."
 .D MES(.RATXT)
 .Q
 ;
 ; /// begin sanity check ///
 K RAERR S RACHKLL=$$GET1^DIQ(101,RANTP2SUB_",",770.7,,,"RAERR")
 I $D(RAERR("DIERR")) D  D XIT Q
 .N RATXT S RATXT(1)=" ",RATXT(2)="Error in the check of logical link: '"_RALOGLINK_"' being"
 .S RATXT(3)="tied to subscriber protocol: '"_RASUBSCRIBER_"'."
 .S RATXT(4)=" ",RATXT(5)="Error "_$G(RAERR("DIERR",1))_": "_$G(RAERR("DIERR",1,"TEXT",1))
 .S RATXT(6)="Contact the National Radiology development team."
 .D MES(.RATXT)
 .Q
 I RACHKLL=RALOGLINK D  D XIT Q
 .N RATXT S RATXT(1)=" "
 .S RATXT(2)="Logical link '"_RALOGLINK_"' is tied to subscriber protocol '"_RASUBSCRIBER_"'."
 .S RATXT(3)="Exiting successfully without taking further action."
 .D MES(.RATXT)
 .Q
 ; /// end sanity check ///
 ;
 ; Find the IEN of the logical link dedicated to our interface with the
 ; National Teleradiology Program (NTP).
 ; ----------------------------------------------------------------------------
 K RAMSGRT S RANTP2LNK=$$FIND1^DIC(870,,"X",RALOGLINK,,,"RAMSGRT(RASUBSCRIPT)")
 I RANTP2LNK=0!($D(RAMSGRT(RASUBSCRIPT,"DIERR"))#2) D  D XIT Q
 .N RATXT S RATXT(1)=" ",RATXT(2)="The lookup for logical link: '"_RALOGLINK_"' failed."
 .S RATXT(3)="Contact the National Radiology development team."
 .D MES(.RATXT)
 .Q
 ;
 ; Update the subscriber PROTOCOL (#101) file's LOGICAL LINK" (#770.7) field with
 ; RANTP2LNK (internal value).
 S RAIEN=RANTP2SUB_",",RAFDA(101,RAIEN,770.7)=RANTP2LNK
 K RAERR D FILE^DIE("","RAFDA","RAERR")
 I $D(RAERR("DIERR")) D
 .N RATXT S RATXT(1)="Error updating LOGICAL LINK for subscriber: '"_RASUBSCRIBER_"'."
 .S RATXT(2)="Error "_$G(RAERR("DIERR",1))_": "_$G(RAERR("DIERR",1,"TEXT",1))
 .S RATXT(3)="Contact the National Radiology development team."
 .D MES(.RATXT)
 .Q
 E  D
 .N RATXT S RATXT(1)="The process of updating the LOGICAL LINK (#770.7) field with a value"
 .S RATXT(2)="of: '"_RALOGLINK_"' for subscriber protocol: '"_RASUBSCRIBER_"' was successful."
 .D MES(.RATXT)
 .Q
 D XIT
 Q
 ;
MES(RAX) ;display/file text identifying issues, if any, as well as indicating success.
 D MES^XPDUTL(.RAX)
 Q
XIT ;clean up variables and exit the 218 post install
 K DIERR,RACHKLL,RAERR,RAEVTDRV,RAFDA,RAIEN,RALOGLINK,RAMSGRT,RANTP2LNK,RANTP2SRV
 K RANTP2SUB,RASUBSCRIBER,RASUBSCRIPT,RATXT
 Q
 ;
