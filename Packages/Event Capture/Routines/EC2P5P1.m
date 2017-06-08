EC2P5P1 ;ALB/GTS - PATCH EC*2.0*5 Post-Init Rtn #1; 9/19/97
 ;;2.0; EVENT CAPTURE ;**5**;8 May 96
 ;
RNDEX ;Reindex Visit (#28) in the EC Patient file (#721)
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Reindexing the Visit field (#28) in the EC Patient file (#721).")
 D MES^XPDUTL(" ")
 N ECDA,RECCNT
 S (RECCNT,ECDA)=0
 F  S ECDA=$O(^ECH(ECDA)) Q:+ECDA'>0  DO
 .I +$P(^ECH(ECDA,0),"^",21)>0 DO
 ..I '$D(^ECH("C",$P(^ECH(ECDA,0),"^",21),ECDA)) DO
 ...S DA=ECDA
 ...S DIK="^ECH("
 ...S DIK(1)="28"
 ...D EN1^DIK
 ...S RECCNT=RECCNT+1
 D PRD^DILFD(721,"^EC*2*5") ;** Set VRRV node (file #721)
 D MES^XPDUTL(RECCNT_" Event Capture Patient file entries reindexed.")
 D MES^XPDUTL(" Note:  Only entries sending to PCE are indexed. ")
 D MES^XPDUTL(" ")
 Q
