PRCH120 ;WISC/SC-Compile the 442 input templates ;3-10-97 
 ;;5.0;IFCAP;**120**;4/21/95
 S DIK="^DD(442,",DA(1)=46,DA=46 D ^DIK K DA,DIK
 QUIT
 ;
START ;compiling PRCH2138 and PRCHNREQ templates
 N X,Y,DMAX,MSG
 S X="PRCHT1"
 S Y=$O(^DIE("B","PRCH2138",0))
 S DMAX=5000
 D EN^DIEZ
 ; display the msg to installer that template has been compiled
 S MSG="Template PRCH2138 is compiled."
 D MES^XPDUTL(MSG)
 S X="PRCHT3"
 S Y=$O(^DIE("B","PRCHNREQ",0))
 S DMAX=5000
 D EN^DIEZ
 ; display the msg to installer that template has been compiled
 S MSG="Template PRCHNREQ is compiled."
 D MES^XPDUTL(MSG)
 M ^PRC(442,"AM")=^PRC(442,"M") K ^PRC(442,"M")
 Q
