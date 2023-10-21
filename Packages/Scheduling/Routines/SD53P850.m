SD53P850 ;TMP/GN - SD*5.3*850 Post Init Routine ;June 12, 2023
 ;;5.3;Scheduling;**850**;Aug 13, 1993;Build 12
 ;
 ; Cleanup the SDEC APPT REQUEST file (#409.85).  
 ; TMP had stored in the an IEN in the PARENT REQUEST field (#43.8) and this field is reserved for MRTC appts made by VSE.
 ; This utility will follow the logic below to find and erase this field, so VSE can once again Cancel those appointments normally.
  ; *** post install can be rerun with no harm ***
 ;
 Q
EN ; entry point
 N DFN,PARENT,CHILD,MRTC,FIX,TOT,STRTDT,QQ,RR
 S (FIX,TOT)=0
 D MES^XPDUTL("")
 D MES^XPDUTL("Updating of the SDEC APPT REQUEST file...")
 D MES^XPDUTL("")
 D MES^XPDUTL("   An email with the results of this cleanup will be sent to the installer ")
 D MES^XPDUTL("   Please forward this email to the Schedulers for their use.")
 D MES^XPDUTL("") H 4
 ;
 S STRTDT=$$FMADD^XLFDT(DT,-365)
 F QQ=0:0 S QQ=$O(^SDEC(409.85,"AC",QQ)) Q:'QQ  D
 . F RR=0:0 S RR=$O(^SDEC(409.85,"AC",QQ,RR)) Q:'RR  D
 .. F CHILD=0:0 S CHILD=$O(^SDEC(409.85,"AC",QQ,RR,CHILD)) Q:'CHILD  D
 ... S TOT=TOT+1
 ... S MRTC=$P(^SDEC(409.85,CHILD,3),U)
 ... S PARENT=$P(^SDEC(409.85,CHILD,3),U,5)
 ... I 'MRTC,PARENT D
 .... S DFN=$$GET1^DIQ(409.85,CHILD,.01,"I")
 .... I '$D(^SDEC(409.85,PARENT)) D ERASE
 .... I $D(^SDEC(409.85,PARENT)),$P(^SDEC(409.85,PARENT,3),U)'=$P(^SDEC(409.85,CHILD,3),U) D ERASE
 S ^TMP("SDTMP",$J)=FIX
 D SNDMAIL
 D MES^XPDUTL("")
 D MES^XPDUTL("Update completed. Records examined: "_TOT)
 D MES^XPDUTL("                     Records fixed: "_FIX)
 D MES^XPDUTL("") H 1
 Q
 ;
ERASE ;
 N FDA,LSTNAM1,SSN4,APPDT,CIDDT
 S FIX=FIX+1
 S FDA(409.85,CHILD_",",43.8)="@" D UPDATE^DIE("","FDA","ERR")  ;erase parent field data
 ;build text line for mailman msg
 S LSTNAM1=$E($$GET1^DIQ(2,DFN,"NAME"),1,1)
 S SSN4=$E($$GET1^DIQ(2,DFN,"SSN"),6,9)
 S APPDT=$$GET1^DIQ(409.85,CHILD,"SCHEDULED DATE OF APPT","I")
 S CIDDT=$$GET1^DIQ(409.85,CHILD,"CID/PREFERRED DATE OF APPT","I")
 W !,CHILD,?20,CIDDT
 S ^TMP("SDTMP",$J,FIX+3)="Patient: "_LSTNAM1_SSN4_$S('APPDT:" Req CID: "_$$FMTE^XLFDT(CIDDT),1:" Appt: "_$$FMTE^XLFDT(APPDT))_" has been fixed."
 Q
 ;
SNDMAIL ;send mailman to installer
 N XMSUB,XMY,XMTEXT,XMDUZ
 S ^TMP("SDTMP",$J,1)="Patient appointment date/times that were fixed, can now be cancelled via VSE."
 S ^TMP("SDTMP",$J,2)=" Appt Request CID records that were fixed have no associated appointment made."
 S ^TMP("SDTMP",$J,3)=""
 I ^TMP("SDTMP",$J)=0 S ^TMP("SDTMP",$J,4)="** No Appointment Request Records found that needed repair."
 S XMSUB="SD TMP cleanup of MRTC parent field in SDEC APPT REQUEST file #409.85"
 S XMDUZ=.5
 S XMTEXT="^TMP(""SDTMP"",$J,"
 S XMY(DUZ)=""
 N DIFROM D ^XMD K ^TMP("SDTMP",$J)
 Q
