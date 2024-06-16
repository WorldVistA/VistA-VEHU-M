TIUCCRP363 ;COG/PB - PATCH TIU*1.0*363 POST INSTALL ; 11/08/23 14:30
 ;;1.0;TEXT INTEGRATION UTILITIES;**363**;Nov 08, 2023;Build 69
 ;
 ;SAC EXEMPTION 202311211320-04 : TIU use of vendor specific code
 ;ICR 7205
 ;
 Q
TIU ;  
 N MYREST,IEN1802,PINGRES,MYERR,$ETRAP,X,XOBSTAT,XOBREADR,XOBREAK,NEWRESPONSE,JSON,OLDIP,OLDPORT,SC,resource,RESPJSON,NEWIP,NEWPORT,LINK,TIEN870,FDA,CNT
 S IEN1802=$O(^XOB(18.02,"B","CCRA WEB SERVICE",""))
 I $G(IEN1802)'>0 D  Q
 . D BMES^XPDUTL("**************************************************************************")
 . D BMES^XPDUTL(">>>>         The CCRA WEB SERVICE has not been configured.            <<<<")
 . D BMES^XPDUTL(">>>> Install failed because the CCRA WEB SERVICE has not been set up. <<<<")
 . D BMES^XPDUTL("**************************************************************************")
 . Q
 ;
 Q 1 ; For outside of the VA
 D BMES^XPDUTL("******************************************************************")
 D BMES^XPDUTL("     >>>>     Updating the TIUCCRA HL7 Logical Link    <<<<      ")
 D BMES^XPDUTL("******************************************************************")
 ;S XPDQUIT=1
 S CNT=0
 ;set error trap 
 S $ETRAP="DO PINGH^GMRCCCRP200"
 ;get client REST request object
 S MYREST=$$GETREST^XOBWLIB("CCRA WEB SERVICE","CCRA WEB SERVER"),MYERR=""
 S TIEN870=$O(^HLCS(870,"B","TIUCCRA",""))
 S OLDIP=$$GET1^DIQ(870,TIEN870_",",400.01,"E"),OLDPORT=$$GET1^DIQ(870,TIEN870_",",400.02,"E")
 S resource="/address?oldip="_$G(OLDIP)_"&oldport="_$G(OLDPORT)
 S SC=$$GET^XOBWLIB(MYREST,resource,.MYERR,0)
 I 'SC I MYERR.code=404 D 
 .D BMES^XPDUTL("The Web Service Query didn't return any data. The TIUCCRA link was not updated.")
 .K DIR("A"),DIR(0)
 .S DIR("A")="Press ENTER or RETURN to continue",DIR(0)="E" D ^DIR
 .K DIR("A"),DIR(0)
 I 'SC Q 1
 S NEWRESPONSE=MYREST.HttpResponse
 S JSON=NEWRESPONSE.Data
 S RESPJSON=""
 F  Q:JSON.AtEnd  S RESPJSON=RESPJSON_JSON.ReadLine()
 S NEWIP=$TR($P($P(RESPJSON,",",1),":",2),"""",""),NEWPORT=$TR($P($P(RESPJSON,",",2),":",2),"""",""),NEWPORT=$P(NEWPORT,"}",1)
 D BMES^XPDUTL("*******************************************************************")
 D BMES^XPDUTL("")
 D BMES^XPDUTL("   Updating the TIUCCRA HL7 Logical Link   ")
 D BMES^XPDUTL("   Current IP address: "_OLDIP_" Current Port: "_OLDPORT)
 D BMES^XPDUTL("   New IP address: "_NEWIP_" New Port: "_NEWPORT)
 D BMES^XPDUTL("")
 D BMES^XPDUTL("*******************************************************************")
 K DIR("A"),DIR(0)
 S DIR("A")="Press ENTER or RETURN to continue",DIR(0)="E" D ^DIR
 K DIR("A"),DIR(0)
 D UPDATELINK(TIEN870,NEWIP,NEWPORT) Q
 Q
UPDATELINK(IEN870,NEWIP,NEWPORT) ;
 ;updates the HL7 Logical Link File (#870) with the new ip and port addresses
 ;stop the link
 N IENROOT,MSGROOT
 S FDA(870,IEN870_",",.08)=NEWIP
 S FDA(870,IEN870_",",400.01)=NEWIP
 S FDA(870,IEN870_",",400.02)=NEWPORT
 D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 Q
PINGH ;
 ;this is where to put in the error trapping and capture the error and write out to the KIDS screen
 D ERR2ARR^XOBWLIB(MYERR,.MYERR)
 S CNT=CNT+1
 Q:CNT>1
 D BMES^XPDUTL("******************************************************************")
 D BMES^XPDUTL("  >>>>  The IP address, "_OLDIP_" and port number "_OLDPORT_"  <<<<  ")
 D BMES^XPDUTL("         >>>>  didn't return a new IP address or port.  <<<<         ")
 D BMES^XPDUTL("       >>>> The logical link, TIUCCRA was not changed. <<<<")
 D BMES^XPDUTL("******************************************************************")
 S XPDQUIT=1  ; stop the install
 Q
