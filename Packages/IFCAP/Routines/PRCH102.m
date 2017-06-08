PRCH102 ;WISC/SC-Compile the 442 input templates 
 ;;5.0;IFCAP;**102**;4/21/95
 ;
START ;compiling PRCH2138 and PRCHNREQ templates
 N X,Y,DMAX,MSG
 S X="PRCHT1"
 S Y=$O(^DIE("B","PRCH2138",0))
 S DMAX=5000
 D EN^DIEZ
 ;it will display the msg to installer that template has been compiled
 S MSG="Template PRCH2138 is compiled."
 D MES^XPDUTL(MSG)
 S X="PRCHT3"
 S Y=$O(^DIE("B","PRCHNREQ",0))
 S DMAX=5000
 D EN^DIEZ
 ;It will display the msg to installer that template has been compiled
 S MSG="Template PRCHNREQ is compiled."
 D MES^XPDUTL(MSG)
 Q
 ;
