QAN2P35 ;ALB/MJB - Incident Reporting  Package Decommission ;07/02/2024
 ;;2.0;Incident Reporting ;**35**; JUL 13, 1995;Build 5
 ;
 ; The Incident Reporting package is being retired. 
 ; This routine will remove the Incident Reporting  files and data.
 ;
 Q
 ;
TASK ;task the file deletion
 ;
 N ZTRTN,ZTDESC,ZTIO,ZTDTH
 D MES^XPDUTL(" ")
 D MES^XPDUTL("A background job will be tasked to delete all Incident Reporting files and data.")
 D MES^XPDUTL("A Mailman message will be generated and sent to the installer when the job")
 D MES^XPDUTL("is completed.")
 S ZTRTN="BEGDEL^QAN2P35",ZTDESC="Incident Reporting Package File & Data Removal"
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 Q
 ;
BEGDEL ;background job entry point to remove all files and data
 ;
 N DIU,QANCNT,QANNODE,QANLOOP,QANTXT,QANFILE,QANFLG,QANSTART,QANEND,QANSTR
 S (QANCNT,QANFLG)=0,QANSTART=$$FMTE^XLFDT($$NOW^XLFDT,1)
 K ^TMP($J,"QANP35")
 F QANLOOP=1:1 S QANTXT=$P($T(MSGTXT+QANLOOP),";;",2) Q:QANTXT="QUIT"  D LINE(QANTXT)
 ;build beginning of mail message
 S DIU(0)="DST" ;flags to delete data, subfile and templates
 F QANFILE=742,742.1,742.13,742.14,742.4,742.5,742.6 D
 .;loop through known Incident Reporting files
 .S DIU=$$ROOT^DILFD(QANFILE),QANNODE=$$CREF^DILF(DIU)
 .;set diu=file root and QANnode=closed file root
 .I '$$VFILE^DILFD(QANFILE) Q  ;verify file exists
 .;delete file and data in diu
 .D EN^DIU2
 .;check if DD and data is removed
 .I '$D(@QANNODE),'$$VFILE^DILFD(QANFILE) D  Q  ;file successfully deleted
 ..S QANSTR=DIU_" successfully removed" D LINE(QANSTR) Q
 .S QANSTR=DIU_" was not successfully removed",QANFLG=1 D LINE(QANSTR)  ;fall through if file not deleted
 I QANFLG D
 .D LINE("")
 .S QANSTR="A file was not removed successfully. Please have your IRM re-run"
 .S QANSTR=QANSTR_" the background job" D LINE(QANSTR)
 .S QANSTR="by entering this command at the programmer's prompt" D LINE(QANSTR)
 .S QANSTR="   D BEGDEL^QAN2P35"
 D LINE("")
 S QANSTART="Start Time: "_QANSTART D LINE(QANSTART)
 S QANEND=$$FMTE^XLFDT($$NOW^XLFDT,1)
 S QANEND="End Time:   "_QANEND D LINE(QANEND)
 D MAIL  ;send mail message
 K ^TMP($J,"QANP35")
 Q
 ;
MSGTXT ;message into
 ;; The Social Work package is being retired and all data and data
 ;; dictionary entries will be removed from the system. This 
 ;; message shows a list of files that were removed.
 ;;
 ;;QUIT
 Q
LINE(TEXT) ;add line to tmp global stored for mail message
 ;
 S QANCNT=QANCNT+1,^TMP($J,"QANP35",QANCNT)=TEXT
 Q
 ;
MAIL ;send message
 ;
 N XMDUZ,XMY,XMTEXT,XMSUB
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="Incident Reporting Package Data & Data Dictionary Removal"
 S XMTEXT="^TMP($J,""QANP35"","
 D ^XMD
 Q
