ICPT616 ;DLS/DEK- ICPT Patch Driver; 10/27/03 3:03pm
 ;;6.0;CPT/HCPCS;**16**;May 19, 1997
 ;
 ; Addresses NOIS: BAY-1003-31889
 ;
 ; External References
 ;   DBIA  1995  CODEN^ICPTCOD
 ;   DBIA  2053  FILE^DIE
 ;   DBIA 10141  BMES^XPDUTL
 ;
POST ;- Post-Init
 N I,ICPTX,FDA,FLAG,CODE,DESC
 S CODE="G0121",ICPTX=$$CODEN^ICPTCOD(CODE),FLAG=1
 I ICPTX<0 D BMES^XPDUTL("INVALID HCPCS Code: "_CODE) Q
 S DESC="Colon ca scrn not hi rsk ind",FDA(81,ICPTX_",",2)=DESC
 F I=1:1:5 Q:'FLAG  D
 . K ^TMP("DIERR",$J)
 . D FILE^DIE("K","FDA")
 . S FLAG=$D(^TMP("DIERR",$J))
 I FLAG S $P(^ICPT(ICPTX,0),"U",2)=DESC
 K ^TMP("DIERR",$J)
 Q
 ;
