SD53P888 ;BAH/DF - SD*5.3*888 Post Init Routine ;Aug 7, 2024
 ;;5.3;Scheduling;**888**;AUG 13, 1993;Build 8
 ;
 ; load new Stop codes to the SD TELE HEALTH STOP CODE FILE #40.6.
 ; *** post install can be rerun with no harm ***
 ;
 Q
EN       ; entry point
 N ERRCNT,FDA,SDIEN,ERR,STP,DA,DIK
 S ERRCNT=0
 D MES^XPDUTL("")
 D MES^XPDUTL("Updating of SD TELE HEALTH STOP CODE FILE...")
 ;Add new codes
 D MES^XPDUTL("") H 1
 F STP=732 D
 . I $O(^SD(40.6,"B",STP,"")) D MES^XPDUTL(STP_"    already on file") Q
 . I '$$CHKSTOP^SDTMPEDT(STP) D MES^XPDUTL(STP_"    ** Not added, invalid stop code") Q
 . S FDA(40.6,"+1,",.01)=STP D UPDATE^DIE("","FDA","SDIEN","ERR")
 . D:'$D(ERR) MES^XPDUTL(STP_"    added stop code")
 . I $D(ERR) D MES^XPDUTL(STP_" failed an attempt to add to the file.") S ERRCNT=ERRCNT+1
 . K FDA,SDIEN,ERR
 D MES^XPDUTL("")
 D MES^XPDUTL("Stop Code Update completed. "_ERRCNT_" error(s) found.")
 D MES^XPDUTL("") H 2
 Q
