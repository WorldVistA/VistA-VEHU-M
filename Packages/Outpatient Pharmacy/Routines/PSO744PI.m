PSO744PI ;HDSO/LAL-Post-install routine for Patch PSO*7.0*744 ; 12 Mar 2024  2:00 PM
 ;;7.0;OUTPATIENT PHARMACY;**744**;DEC 1997;Build 3
 ;
 Q  ;Must be run from the POST tag
 ;
 ;
 ;  This post-install routine does the following:
 ;
 ;  1. Scans the records in File #52 [PRESCRIPTION] and looks for any Activity Log nodes
 ;     i.e. ^PSRX(RXIEN,"A",N,0), that do not have a Activity Log Header node i.e. ^PSRX(RXIEN,"A",0).
 ;
 ;  2. If any records are are found, the Activity Log Header node will be created and it will 
 ;     match the number of entries in the Activity Log.
 ;
 ;  3. It will also send an email to users with the PSNMGR key with details of the corrected RXs.
 ;
 ;  4. If no records are found that match the criteria, a message will display stating this.
 ;
 ;
POST ; Main entry point
 D BMES^XPDUTL(" ")
 D BMES^XPDUTL("  Starting post-install for PSO*7.0*744")
 D MES^XPDUTL("  This report documents any RXs missing the Activity Log Header")
 D MES^XPDUTL("  node in File #52 [PRESCRIPTION].")
 D MES^XPDUTL("  Any instance of an RX without the Activity Log Header node")
 D MES^XPDUTL("  will automatically be corrected.")
 ;
 N PSODUZ,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTQUEUED,ZTREQ,ZTSK
 S ZTRTN="START^PSO744PI"
 S ZTDESC="PSO*7.0*744 Post-Install Routine"
 S ZTIO="",ZTDTH=$H
 S PSODUZ=DUZ
 S ZTSAVE("PSODUZ")=""
 D ^%ZTLOAD
 ;
 D BMES^XPDUTL(" ")
 D BMES^XPDUTL("  The PSO*7.0*744 Post-Install Routine has been tasked.")
 D MES^XPDUTL("  Task Number: "_$G(ZTSK))
 D MES^XPDUTL("  You will receive a MailMan message when it completes.")
 D BMES^XPDUTL("  ")
 Q
 ;
START ; Start the correction process
 N PSOSUB,PSOFROM,PSOTEXT
 ;
 S ^XTMP("PSO*7.0*744 POST INSTALL",0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^PSO*7.0*744 POST INSTALL"
 D ACTLOG,MAIL
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
ACTLOG ; Fix records in the File #52 [PRESCRIPTION]
 ; INC28706897 - ATP+4^PSO52API error for RXs missing the Activity Log Header node.
 ; Search File #52 [PRESCRIPTION] to find RXs missing the Activity Log Header node and correct.
 N FOUND,PSOLINE,RXIEN,COUNT,FOUND,X1
 S PSOLINE=0 K ^TMP("PSO744PI",$J),^XTMP("PSO744PI",$J)
 ;
 D SETTXT("================ PSO*7.0*744 Summary Report ================")
 D SETTXT("Below is the list of RXs that were missing the Activity Log")
 D SETTXT("Header node that have been corrected.")
 D SETTXT("============================================================")
 D SETTXT("")
 D SETTXT("RX#             File #52 IEN    Log#   Expiration DT/Cancel DT")
 D SETTXT("------------    ------------    ----   -------------------------")
 ;
 S (RXIEN,FOUND)=0
 F  S RXIEN=$O(^PSRX(RXIEN)) Q:'RXIEN  D
 . I $D(^PSRX(RXIEN,"A",1)),'$D(^PSRX(RXIEN,"A",0)) D
 . . S FOUND=FOUND+1
 . . S COUNT=$O(^PSRX(RXIEN,"A","Z"),-1)
 . . S ^PSRX(RXIEN,"A",0)="^52.3DA^"_COUNT_"^"_COUNT
 . . S X1=$$GET1^DIQ(52,RXIEN,.01),$E(X1,17)=RXIEN,$E(X1,33)=COUNT,$E(X1,40)=$$GET1^DIQ(52,RXIEN,26)_"/"_$$GET1^DIQ(52,RXIEN,26.1)
 . . D SETTXT(X1)
 ;
 D SETTXT("")
 I FOUND D SETTXT("Total RXs Corrected = "_FOUND)
 I 'FOUND D SETTXT("No Prescriptions were found with a missing Activity Log Header node.")
 ;
 D BMES^XPDUTL("  Mailman message sent.")
 D BMES^XPDUTL("  Finished post-install for PSO*7.0*744.")
 Q
 ;
SETTXT(TXT) ; Setting Plain Text
 S PSOLINE=$G(PSOLINE)+1,^XTMP("PSO744PI",$J,PSOLINE)=TXT
 Q
 ; 
MAIL ; Sends Mailman message
 S PSOSUB="PSO*7.0*744 Post-Install Summary Information"
 S PSOFROM="PSO*7.0*744 Post-Install"
 S PSOTEXT="^XTMP(""PSO744PI"",$J)"
 D MAILMSG(PSOSUB,PSOFROM,PSOTEXT)
 Q
END ; Exit point
 K ^TMP("PSO744PI",$J),^XTMP("PSO744PI",$J)
 Q
 ;
MAILMSG(MSGSUBJ,MSGFROM,MSGTEXT) ; Build and send a MailMan message
 N PSOREC,PSOMY,PSOMIN,PSOMZ
 I '$D(PSODUZ) S PSODUZ=DUZ
 S PSOMIN("FROM")=MSGFROM
 S PSOREC=""
 F  S PSOREC=$O(^XUSEC("PSNMGR",PSOREC)) Q:PSOREC=""  S PSOMY(PSOREC)=""
 S PSOMY(PSODUZ)=""
 D SENDMSG^XMXAPI(PSODUZ,MSGSUBJ,MSGTEXT,.PSOMY,.PSOMIN,.PSOMZ,"")
 Q
