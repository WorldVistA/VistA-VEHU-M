DVBAPTBD ;ALB/CMM  2507 BODY SYSTEM FILE UPDATE - POSTINT ; 14 MARCH 1997
 ;;2.7;AMIE;**12**;Apr 10, 1995
 ;
 ; This is the post-in for patch 12 to add 2 new Body Systems to the
 ; 2507 BODY SYSTEM file #396.7
 ;
NEW ; add new body system
 ;
 N NAME
 F NAME="RESPIRATORY","INFECTIOUS/IMMUNE/NUTRITIONAL","DENTAL AND ORAL","HEMIC AND LYMPHATIC","NEUROLOGIC" D
 .S DIC="^DVB(396.7,",DIC(0)="MXZ",X=NAME
 .D ^DIC
 .I +Y>0 K DIC,X,Y D MES^XPDUTL("Body System "_NAME_" already exists") Q
 .; ^ already exists
 .K DD,DO
 .S DIC="^DVB(396.7,",DIC(0)="MLXZ",X=NAME
 .D FILE^DICN
 .I +Y=-1 D MES^XPDUTL("Couldn't add Body System "_NAME_" to file")
 .K DIC,X,Y
 Q
