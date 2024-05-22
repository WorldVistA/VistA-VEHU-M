GMRC196P ;SLC/WAS - Post Routine To Disable GMRCHCP Link; Jan 25, 2024@13:35
 ;;3.0;CONSULT/REQUEST TRACKING;**196**;FEB 27, 2018;Build 3
 ;
 ; Reference to ^ORD(101 in ICR #872
 ;
 ; Depreciated GMRCHCP via GMRC*3.0*196
 ;
 Q
POST ;
 ;
 D BMES^XPDUTL("Post-install GMRC196P begin...")
 ;
 D LINK,INACTVAPP,PROTODIS,PROTOEDIT,PROTOREM
 ;
 D BMES^XPDUTL("Post-install GMRC196P complete...")
 Q
LINK ; Update the GMRCHCP HL logical link to disable AUTOSTART
 N GMRCIEN,VAL,FDA,GMRCERR
 S VAL="GMRCHCP"
 S GMRCIEN=$$FIND1^DIC(870,,"B",.VAL)
 I 'GMRCIEN D MES^XPDUTL("Missing "_VAL_" - Cannot disable AUTOSTART") Q
 S FDA(870,GMRCIEN_",",4.5)=0 ; AUTOSTART disabled
 D FILE^DIE(,"FDA","GMRCERR") K FDA
 D MES^XPDUTL("")
 I $D(GMRCERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when disabling AUTOSTART for the GMRCHCP HL logical link")
 D MES^XPDUTL("GMRCHCP HL logical link AUTOSTART has been disabled.")
 Q
INACTVAPP ; Update the HL7 Application Parameter file to mark GMRC HCP SEND and GMRC HCP RECEIVE inactive
 N GMRCIEN,VAL,FDA,GMRCERR
 S VAL="GMRC HCP SEND"
 S GMRCIEN=$$FIND1^DIC(771,,"B",.VAL)
 I 'GMRCIEN D MES^XPDUTL("Missing "_VAL_" - Cannot edit application pararmeter")
 D MES^XPDUTL("")
 I GMRCIEN D
 .S FDA(771,GMRCIEN_",",2)="i" ; mark inactive
 .D FILE^DIE(,"FDA","GMRCERR") K FDA
 .I $D(GMRCERR) D MES^XPDUTL("FileMan error when marking the "_VAL_" application parameter inactive")
 .I '$D(GMRCERR) D MES^XPDUTL("The "_VAL_" application parameter has been marked inactive.")
 ;
 N GMRCIEN,VAL,FDA,GMRCERR
 S VAL="GMRC HCP RECEIVE"
 S GMRCIEN=$$FIND1^DIC(771,,"B",.VAL)
 I 'GMRCIEN D MES^XPDUTL("Missing "_VAL_" - Cannot edit application pararmeter")
 D MES^XPDUTL("")
 I GMRCIEN D
 .S FDA(771,GMRCIEN_",",2)="i" ; mark inactive
 .D FILE^DIE(,"FDA","GMRCERR") K FDA
 .I $D(GMRCERR) D MES^XPDUTL("FileMan error when marking the "_VAL_" application parameter inactive")
 .I '$D(GMRCERR) D MES^XPDUTL("The "_VAL_" application parameter has been marked inactive.")
 Q
PROTODIS ; Disable the following protocols
 ; 
 N GMRCIEN,VAL,GMRCERR
 S VAL="GMRC HCP REF-I12 CLIENT"
 S GMRCIEN=$$FIND1^DIC(101,,"B",.VAL)
 I 'GMRCIEN D MES^XPDUTL("Missing "_VAL_" - Cannot disable "_VAL_" protocol")
 D MES^XPDUTL("")
 I GMRCIEN D
 .S FDA(101,GMRCIEN_",",2)="Deprecated via GMRC*3.0*196" ; disable
 .S FDA(101,GMRCIEN_",",770.7)="@" ; Delete GMRCHCP from logical link
 .D FILE^DIE(,"FDA","GMRCERR") K FDA
 .I $D(GMRCERR) D MES^XPDUTL("FileMan error when editing the "_VAL_" protocol to mark as disabled")
 .I '$D(GMRCERR) D MES^XPDUTL("The "_VAL_" Protocol has been updated to disable.")
 ;
 N GMRCIEN,VAL,GMRCERR
 S VAL="GMRC HCP REF-I13 CLIENT"
 S GMRCIEN=$$FIND1^DIC(101,,"B",.VAL)
 I 'GMRCIEN D MES^XPDUTL("Missing "_VAL_" - Cannot disable "_VAL_" protocol")
 D MES^XPDUTL("")
 I GMRCIEN D
 .S FDA(101,GMRCIEN_",",2)="Deprecated via GMRC*3.0*196" ; disable
 .S FDA(101,GMRCIEN_",",770.7)="@" ; Delete GMRCHCP from logical link
 .D FILE^DIE(,"FDA","GMRCERR") K FDA
 .I $D(GMRCERR) D MES^XPDUTL("FileMan error when editing the "_VAL_" protocol to mark as disabled")
 .I '$D(GMRCERR) D MES^XPDUTL("The "_VAL_" Protocol has been updated to disable.")
 ;
 N GMRCIEN,VAL,GMRCERR
 S VAL="GMRC HCP REF-I14 CLIENT"
 S GMRCIEN=$$FIND1^DIC(101,,"B",.VAL)
 I 'GMRCIEN D MES^XPDUTL("Missing "_VAL_" - Cannot disable "_VAL_" protocol")
 D MES^XPDUTL("")
 I GMRCIEN D
 .S FDA(101,GMRCIEN_",",2)="Deprecated via GMRC*3.0*196" ; disable
 .S FDA(101,GMRCIEN_",",770.7)="@" ; Delete GMRCHCP from logical link
 .D FILE^DIE(,"FDA","GMRCERR") K FDA
 .I $D(GMRCERR) D MES^XPDUTL("FileMan error when editing the "_VAL_" protocol to mark as disabled")
 .I '$D(GMRCERR) D MES^XPDUTL("The "_VAL_" Protocol has been updated to disable.")
 ;
 N GMRCIEN,VAL,GMRCERR
 S VAL="GMRC HCP RRI-I13 CLIENT"
 S GMRCIEN=$$FIND1^DIC(101,,"B",.VAL)
 I 'GMRCIEN D MES^XPDUTL("Missing "_VAL_" - Cannot disable "_VAL_" protocol")
 D MES^XPDUTL("")
 I GMRCIEN D
 .S FDA(101,GMRCIEN_",",2)="Deprecated via GMRC*3.0*196" ; disable
 .S FDA(101,GMRCIEN_",",770.7)="@" ; Delete GMRCHCP from logical link
 .D FILE^DIE(,"FDA","GMRCERR") K FDA
 .I $D(GMRCERR) D MES^XPDUTL("FileMan error when editing the "_VAL_" protocol to mark as disabled")
 .I '$D(GMRCERR) D MES^XPDUTL("The "_VAL_" Protocol has been updated to disable.")
 ;
 N GMRCIEN,VAL,GMRCERR
 S VAL="GMRC HCP REF-I12 SERVER"
 S GMRCIEN=$$FIND1^DIC(101,,"B",.VAL)
 I 'GMRCIEN D MES^XPDUTL("Missing "_VAL_" - Cannot disable "_VAL_" protocol")
 D MES^XPDUTL("")
 I GMRCIEN D
 .S FDA(101,GMRCIEN_",",2)="Deprecated via GMRC*3.0*196" ; disable
 .D FILE^DIE(,"FDA","GMRCERR") K FDA
 .I $D(GMRCERR) D MES^XPDUTL("FileMan error when editing the "_VAL_" protocol to mark as disabled")
 .I '$D(GMRCERR) D MES^XPDUTL("The "_VAL_" Protocol has been updated to disable.")
 ;
 N GMRCIEN,VAL,GMRCERR
 S VAL="GMRC HCP REF-I13 SERVER"
 S GMRCIEN=$$FIND1^DIC(101,,"B",.VAL)
 I 'GMRCIEN D MES^XPDUTL("Missing "_VAL_" - Cannot disable "_VAL_" protocol")
 D MES^XPDUTL("")
 I GMRCIEN D
 .S FDA(101,GMRCIEN_",",2)="Deprecated via GMRC*3.0*196" ; disable
 .D FILE^DIE(,"FDA","GMRCERR") K FDA
 .I $D(GMRCERR) D MES^XPDUTL("FileMan error when editing the "_VAL_" protocol to mark as disabled")
 .I '$D(GMRCERR) D MES^XPDUTL("The "_VAL_" Protocol has been updated to disable.")
 ;
 N GMRCIEN,VAL,GMRCERR
 S VAL="GMRC HCP REF-I14 SERVER"
 S GMRCIEN=$$FIND1^DIC(101,,"B",.VAL)
 I 'GMRCIEN D MES^XPDUTL("Missing "_VAL_" - Cannot disable "_VAL_" protocol")
 D MES^XPDUTL("")
 I GMRCIEN D
 .S FDA(101,GMRCIEN_",",2)="Deprecated via GMRC*3.0*196" ; disable
 .D FILE^DIE(,"FDA","GMRCERR") K FDA
 .I $D(GMRCERR) D MES^XPDUTL("FileMan error when editing the "_VAL_" protocol to mark as disabled")
 .I '$D(GMRCERR) D MES^XPDUTL("The "_VAL_" Protocol has been updated to disable.")
 ;
 N GMRCIEN,VAL,GMRCERR
 S VAL="GMRC HCP RRI-I13 SERVER"
 S GMRCIEN=$$FIND1^DIC(101,,"B",.VAL)
 I 'GMRCIEN D MES^XPDUTL("Missing "_VAL_" - Cannot disable "_VAL_" protocol")
 D MES^XPDUTL("")
 I GMRCIEN D
 .S FDA(101,GMRCIEN_",",2)="Deprecated via GMRC*3.0*196" ; disable
 .D FILE^DIE(,"FDA","GMRCERR") K FDA
 .I $D(GMRCERR) D MES^XPDUTL("FileMan error when editing the "_VAL_" protocol to mark as disabled")
 .I '$D(GMRCERR) D MES^XPDUTL("The "_VAL_" Protocol has been updated to disable.")
 ;
 Q
PROTOEDIT ; Edit the following protocol to remove entry action
 ;
 N GMRCIEN,VAL,GMRCERR
 S VAL="GMRC CONSULTS TO HCP"
 S GMRCIEN=$$FIND1^DIC(101,,"B",.VAL)
 I 'GMRCIEN D MES^XPDUTL("Missing "_VAL_" - Cannot edit protocol")
 D MES^XPDUTL("")
 I GMRCIEN D
 .S FDA(101,GMRCIEN_",",20)="@"
 .D FILE^DIE(,"FDA","GMRCERR") K FDA
 .I $D(GMRCERR) D MES^XPDUTL("FileMan error when editing the "_VAL_" protocol to remove entry action")
 .I '$D(GMRCERR) D MES^XPDUTL("The "_VAL_" protocol has been updated to remove entry action.")
 ;
 Q
PROTOREM ; Remove the following child protocol from parent
 ;
 N VAL,VAL1,GMRCIEN,GMRCIEN1,DA,DIK
 S VAL="GMRC CONSULTS TO HCP"
 S VAL1="GMRC EVSEND OR"
 S GMRCIEN=$$FIND1^DIC(101,,"B",.VAL)
 D MES^XPDUTL("")
 I 'GMRCIEN D MES^XPDUTL("Cannot remove "_VAL_" from "_VAL1_" protocol - Missing "_VAL) Q
 S GMRCIEN1=$$FIND1^DIC(101,,"B",.VAL1)
 I 'GMRCIEN1 D MES^XPDUTL("Cannot remove "_VAL_" from "_VAL1_" protocol - Missing "_VAL1) Q
 S DA=$O(^ORD(101,GMRCIEN1,10,"B",GMRCIEN,0))
 I 'DA D MES^XPDUTL("Cannot remove "_VAL_" from "_VAL1_" protocol - Already removed") Q
 S DA(1)=GMRCIEN1
 S DIK="^ORD(101,"_DA(1)_",10,"
 D ^DIK
 D MES^XPDUTL("")
 I $D(GMRCERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when removing "_VAL_" from "_VAL1_" protocol")
 D MES^XPDUTL(VAL_" has been removed from "_VAL1_" protocol.")
 Q
