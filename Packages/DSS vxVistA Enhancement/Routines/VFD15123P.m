VFD15123P ; DSS/SMH - Post Install for VFD*15*123 ; 5/10/17 10:49am
 ;;15.0;DSS INC VXVISTA OPEN SOURCE;;7/15/2016;Build 12
 ; (C) 2016 DSS INCORPORATED.
POST ;
 D PATCH^ZTMGRSET(499)
 ;
 ; LM Accept has a tiny bug: says the max height is supposed to be 22.
 ; It is supposed to be 21. B/c need 1 line for divider, 1 for ED/AC,
 ; and one for prompt. That gives you 25 lines if we stay with original.
 D BMES^XPDUTL("Resizing PSJU LM ACCEPT from 22l to 21l...")
 N LMAC S LMAC=$$FIND1^DIC(409.61,,"QX","PSJU LM ACCEPT")
 I 'LMAC D BMES^XPDUTL("Error in installation. Contact Developer.") QUIT
 N DIERR
 S FDA(409.61,LMAC_",",.06)=21 D FILE^DIE(,$NA(FDA))
 I $G(DIERR) D MES^XPDUTL("Error in install. Contact Developer.")
 QUIT
