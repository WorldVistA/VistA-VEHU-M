DGP1104 ;ALB/CC - ADD COMPACT TO DG ADMISSIONS FILE ; Mar 22, 2023@14:22:39 
 ;;5.3;Registration;**1104**;Aug 13, 1993;Build 59
 Q
POST ;
 D BMES^XPDUTL("Running post-install routine DGP1104")
 S DIC="^DIC(43.4,"
 S DIC(0)="L"
 S X="COMPACT ACT"
 D ^DIC
 W !,Y
 I Y=-1 D BMES^XPDUTL("COMPACT Act record was not added")
 I Y'=-1 D 
 . D BMES^XPDUTL("COMPACT Act record was added")
 . N POSTSEQ
 . S POSTSEQ=$O(^DIC(43.4,"B","COMPACT ACT",""))
 . S $P(^DIC(43.4,POSTSEQ,0),"^",3)=17.1220
 . S $P(^DIC(43.4,POSTSEQ,0),"^",4)=0
 . S $P(^DIC(43.4,POSTSEQ,0),"^",6)=47
 K DIC,X,Y,DIE,DA,DR
 D BMES^XPDUTL("Post-install routine DGP1104 has completed")
 Q
