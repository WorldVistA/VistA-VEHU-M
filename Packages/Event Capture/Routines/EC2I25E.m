EC2I25E ;ALB/JAM - Event Capture Envir Chk EC*2.0*25 Instal Rtn ; 1/25/01
 ;;2.0; EVENT CAPTURE ;**25**;8 May 96
 ;
ENVCHK ; entry point
 N ECPAR,PIEN,STR,PIEN,ECMSG
 I +$O(^XTV(8989.51,"B","EC HFS SCRATCH",0)) Q
 S DIC="^XTV(8989.51,",DLAYGO=8989.5,DIC(0)="LX",X="EC HFS SCRATCH"
 S STR=".02///Scratch HFS Directory"_";.03///0"
 S STR=STR_";.05///SCRATCH HFS DIRECTORY"_";.06///0"_";1.1///F"
 S DIC("DR")=STR_";1.2///1:50"_";1.3///Enter a valid HFS Directory"
 K DD,DO D FILE^DICN S PIEN=+Y K DLAYGO
 I PIEN<0 D  Q
 .D MES^XPDUTL(" ")
 .S STR="Intall failed to add entry to the Parameter File"
 .D MES^XPDUTL(STR)
 S DIC(0)="L",DA(1)=PIEN,DIC("P")=$P(^DD(8989.51,30,0),U,2)
 S DIC="^XTV(8989.51,"_DA(1)_",30,",X=1,DIC("DR")=".02///4" D FILE^DICN
 I +Y<0 D  Q
 .D MES^XPDUTL(" ")
 .S STR="Install failed to add entry to the Parameter File"
 .D MES^XPDUTL(STR)
 S STR="Name of the HFS directory that all Event Capture processes will"
 S STR=STR_" be able to",TMP($J,"WP",1)=STR
 S TMP($J,"WP",2)="access through ^%ZISH for printing documents."
 S DIC("P")=$P(^DD(8989.51,20,0),U,2),DIE("P")=DIC("P")
 D WP^DIE(8989.51,PIEN_",",20,,"TMP($J,""WP"")","ERMSG")
 I '$D(ERMSG) S $P(^XTV(8989.51,PIEN,20,0),U,2)=$P(^DD(8989.51,20,0),U,2)
 K DIC,DIE,X,Y,DR,DA,DD,DO
 I $D(ERMSG) D  Q
 .D MES^XPDUTL(" ")
 .S STR="Install failed to add entry to the Parameter File"
 Q
