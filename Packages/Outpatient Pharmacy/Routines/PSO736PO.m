PSO736PO ;BIR/KML - Patch 736 Post Install routine ;8/28/23
 ;;7.0;OUTPATIENT PHARMACY;**736**;DEC 1997;Build 19
 ;
 ;External reference to HL LOGICAL LINK file (#870) supported by DBIA 6409
 ;
POST ; post installation to assign new domain, TCP/IP and port values for oneVA to VDIF
 D SET
 D MAIL
 Q
 ;
SET ; edit and save the values in HL LOGICAL LINK file entry for PSORRXSEND according to environment type
 N LIEN,VAL,FDA,ERR,TEXT,NOENTRY,PSSLINE,PSOLINK,PSOSERV,PSOPORT
 ;
 K ^TMP("PSO736PO",$J)
 S PSOLINK=$$FIND1^DIC(870,,,"PSORRXSEND")
 S (PSOLDPRT,PSOLDNS,PSOLDNS)=""
 I PSOLINK>0 D SETORIG(PSOLINK)
 S VAL="PSORRXSEND",NOENTRY=0,PSSLINE=0,LIEN=0
 S LIEN=$$FIND1^DIC(870,,"B",.VAL)
 I 'LIEN S NOENTRY=1 D ERROR Q
 ;
 S PSOSERV=$S($$PROD^XUPROD:"hc-vdif-ent-a.domain.ext",1:"")
 S PSOPORT=$S($$PROD^XUPROD:"6230",1:"")
 ;
 S FDA(870,LIEN_",",.08)=PSOSERV
 S FDA(870,LIEN_",",400.01)=PSOSERV
 S FDA(870,LIEN_",",400.02)=PSOPORT
 D FILE^DIE("K","FDA","ERR")
 I $D(ERR("DIERR",1,"TEXT",1)) D ERROR Q
 S TEXT="The TCP/IP, Port, and Domain of the HL LOGICAL LINK entry, PSORRXSEND, has been successfully updated."
 D BMES^XPDUTL(TEXT),SETTXT(TEXT)
 Q
 ;
SETORIG(PSOLNK) ; create ^XTMP("PSO736RR") in case of data rollback
 N DIE,DR,DIC,DA,X,Y,PSOLDPRT,PSOLDNS,PSOLDIP
 K ^XTMP("PSO736RR")
 S PSOLDPRT=$$GET1^DIQ(870,+PSOLNK,400.02)
 S PSOLDNS=$$GET1^DIQ(870,+PSOLNK,.08)
 S PSOLDIP=$$GET1^DIQ(870,+PSOLNK,400.01)
 S ^XTMP("PSO736RR",0)=$$FMADD^XLFDT($$DT^XLFDT(),90)_"^"_$$DT^XLFDT()_"^"_"TCP/IP ADDRESS, TCP/IP PORT, AND DNS DOMAIN BACKUP FOR PSO*7*736"
 S ^XTMP("PSO736RR","PSOLDPRT")=PSOLDPRT
 S ^XTMP("PSO736RR","PSOLDNS")=PSOLDNS
 S ^XTMP("PSO736RR","PSOLDIP")=PSOLDIP
 Q
 ;
ERROR ; an error condition needs to be reported
 S TEXT="The HL LOGICAL LINK entry PSORRXSEND was not updated due to the following error condition:"
 D BMES^XPDUTL(TEXT),SETTXT(TEXT)
 S TEXT=$S($G(ERR("DIERR",1,"TEXT",1))]"":$G(ERR("DIERR",1,"TEXT",1)),NOENTRY:"PSORRXSEND entry not found",1:"No error text available.")
 D BMES^XPDUTL(TEXT),SETTXT(TEXT)
 S TEXT="Submit a ServiceNow ticket requesting assistance in researching the error."
 D BMES^XPDUTL(TEXT),SETTXT(TEXT)
 Q
 ;
MAIL ; Sends Mailman message
 N XMSUB,XMDUZ,XMTEXT,XMY,DIFROM
 D BMES^XPDUTL("Sending Mailman Message with update...")
 S XMY(DUZ)="",XMSUB="PSO*7*736 Post-Install Complete"
 S XMDUZ="PSO*7*736 Install",XMTEXT="^TMP(""PSO736PO"",$J,"
 D ^XMD
 Q
 ;
SETTXT(TXT) ; Setting Plain Text
 S PSSLINE=PSSLINE+1,^TMP("PSO736PO",$J,PSSLINE)=TXT
 Q
