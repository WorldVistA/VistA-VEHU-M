ORY604 ;SLC/JLC - POST INSTALL ;Feb 5, 2024@09:50
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**604**;Dec 17, 1997;Build 11
 ;
POST ;Post install
OVRDRSN ;Add the Order Check Override Reasons (#100.04) file entries
 N ACTIVE,DA,FDA,FDAIEN,FDAMSG,FILE,NAME,SYNONYM,TYPE
 D BMES^XPDUTL("Updating ORDER CHECK OVERRIDE REASON (#100.04) file.")
 D MES^XPDUTL("")
 S FILE=100.04
 S NAME="Indicated for procedure. Risks mitigated and will monitor."
 S SYNONYM="IND",TYPE="B",ACTIVE=1
 S DA=$$FIND1^DIC(FILE,,"X",NAME) I DA>0 D BMES^XPDUTL("Reason already on file.") Q
 I DA="" D BMES^XPDUTL("Failed to add Override reason. Please contact product support.") Q
 S FDA(100.04,"+1,",.01)=NAME
 S FDA(100.04,"+1,",.02)=SYNONYM
 S FDA(100.04,"+1,",.03)=TYPE
 S FDA(100.04,"+1,",.04)=ACTIVE
 D UPDATE^DIE("","FDA","FDAIEN","FDAMSG")
 I +FDAIEN(1)<1 D BMES^XPDUTL("Failed to add Override reason. Please contact product support.") Q
 D BMES^XPDUTL("Successfully updated ORDER CHECK OVERRIDE REASON (#100.04) file.")
 Q
