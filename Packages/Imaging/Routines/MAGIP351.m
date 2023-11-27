MAGIP351 ;WOIFO/RRM - Install code for MAG*3.0*351 ; 01/23/2023 12:43 PM
 ;;3.0;IMAGING;**351**;Mar 19, 2002;Build 26
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs.     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; There are no environment checks here but the MAGIP351 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
 Q
 ;
 ;+++++ INSTALLATION ERROR HANDLING
ERROR ;
 S:$D(XPDNM) XPDABORT=1
 ;--- Display the messages and store them to the INSTALL file
 D DUMP^MAGUERR1(),ABTMSG^MAGKIDS()
 Q
 ;
 ;***** POST-INSTALL CODE
POS ;
 N CALLBACK
 D CLEAR^MAGUERR(1)
 ;
 D ADDNEWMUSENAME("NX") ;Add new record/entry to the MUSE VERSIONS File #2006.17
 ;
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 Q
 ;
ADDNEWMUSENAME(MUSEVERSIONNAME) ;Add new record/entry to the MUSE VERSIONS File #2006.17
 N DA,MAGFDA,MAGIEN,MAGERR,MESSAGE,ERROR
 ;
 I $G(MUSEVERSIONNAME)="" D  Q
 . S MESSAGE(1)=""
 . S MESSAGE(2)="Muse version name is NULL - nothing to add."
 . S MESSAGE(3)=""
 . D BMES^XPDUTL(.MESSAGE)
 ;
 D BMES^XPDUTL("Checking for existence of the '"_MUSEVERSIONNAME_"' in the MUSE VERSIONS FILE (#2006.17)")
 S DA=+$O(^MAG(2006.17,"B",MUSEVERSIONNAME,0))
 I $G(DA) D  Q
 . S MESSAGE(1)=""
 . S MESSAGE(2)="MUSE version '"_MUSEVERSIONNAME_"' already exists in the MUSE VERSIONS FILE (#2006.17)"
 . S MESSAGE(3)="No action taken."
 . S MESSAGE(4)=""
 . D BMES^XPDUTL(.MESSAGE)
 ;
 ;Add the new MUSE version name to File #2006.17
 D BMES^XPDUTL("Adding MUSE version '"_MUSEVERSIONNAME_"' entry to File #2006.17")
 S MAGFDA(2006.17,"+1,",.01)=MUSEVERSIONNAME
 D UPDATE^DIE("E","MAGFDA","MAGIEN","MAGERR")
 ;
 I +$G(MAGIEN)<1,$D(MAGERR) D  Q
 . S MESSAGE(1)=""
 . S MESSAGE(2)="Error occured: The MUSE version '"_MUSEVERSIONNAME_"' was not added to the MUSE VERSIONS FILE (#2006.17)."
 . S ERROR=$G(MAGERR("DIERR",1,"TEXT",1))
 . I $G(ERROR)'="" S MESSAGE(3)=ERROR,MESSAGE(4)="No action taken",MESSAGE(5)=""
 . D BMES^XPDUTL(.MESSAGE)
 D BMES^XPDUTL("The MUSE version '"_MUSEVERSIONNAME_"' entry has been added to the MUSE VERSIONS FILE (#2006.17) successfully.")
 D MES^XPDUTL("")
 Q
 ;
