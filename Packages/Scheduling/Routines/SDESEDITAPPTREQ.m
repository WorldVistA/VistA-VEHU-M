SDESEDITAPPTREQ ;ALB/BLB,MGD,TJB,BWF,TJB,BLB,LAB,JAS,JAS,JAS,ANU,LAB - SCHEDULING EDIT APPT REQUEST; MAY 10,2024@08:27PM
 ;;5.3;Scheduling;**823,826,837,845,846,847,864,871,873,875,877**;Aug 13, 1993;Build 14
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; SDES EDIT APPT REQ
 ;
 Q
 ;
EDITREQUEST(JSONRETURN,REQUEST) ;
 N REQIEN,ERRORS,RETURN,ISAPPREQIENVALID,ISDFNVALID,ISDATETIMEVALID,ISEASVALID,INSTITUTIONIEN
 N ISCLINSTOPVALID,ISMODALINVALID,ISREQUESTBYVALID,ISPROVIDERVALID,ISPIDVALID,ISPRIGROUPVALID
 N ISREQTYPEVALID,ISPRIORITYVALID,ISSERVCONNVALID,ISAPPTTYPEVALID,ISPATSTATVALID
 N ISDATEPREFVALID,ISMTRCDATAVALID,ISCPRSDATAVALID
 ;
 D VALIDATE(.REQUEST,.ERRORS)
 I $D(ERRORS) M RETURN=ERRORS D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.RETURN) Q
 ;
 S RETURN("Request","IEN")=$$BUILDER(.REQUEST)
 ;
 D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.RETURN)
 Q
 ;
VALIDATE(REQUEST,ERRORS) ;
 ;
 S ISAPPREQIENVALID=$$VALIDATEAPPTREQ^SDESEDITAPREQVAL(.ERRORS,$G(REQUEST("REQUEST IEN")))
 ;
 S ISDFNVALID=$$VALIDATEDFN^SDESEDITAPREQVAL(.ERRORS,$G(REQUEST("DFN")))
 ;
 S ISDATETIMEVALID=$$VALIDATEDATETIME^SDESEDITAPREQVAL(.ERRORS,.REQUEST)
 ;
 S ISREQTYPEVALID=$$VALIDATEREQTYPE^SDESEDITAPREQVAL(.ERRORS,$G(REQUEST("REQUEST SUB TYPE")))
 ;
 S INSTITUTIONIEN=$$STATIONTOINST^SDESEDITAPREQVAL(.ERRORS,$G(REQUEST("STATION NUMBER")),$G(REQUEST("INSTITUTION NAME")))
 ;
 S ISCLINSTOPVALID=$$VALIDATECLINSTOP^SDESEDITAPREQVAL(.ERRORS,.REQUEST,$G(REQUEST("CLINIC IEN")),$G(REQUEST("STOP CODE")),$G(REQUEST("SECONDARY STOP CODE")))
 ;
 S ISREQUESTBYVALID=$$VALIDATEREQBY^SDESEDITAPREQVAL(.ERRORS,$G(REQUEST("REQUESTED BY")))
 I ISREQUESTBYVALID S REQUEST("REQUESTED BY")=$$SOCEXT2INT^SDESUTIL(409.85,11,$G(REQUEST("REQUESTED BY")))
 ;
 I $G(REQUEST("REQUESTED BY"))="PROVIDER" S ISPROVIDERVALID=$$VALIDATEPROVIDER(.ERRORS,$G(REQUEST("PROVIDER IEN")))
 ;
 S ISPIDVALID=$$VALIDATEPID(.ERRORS,.REQUEST)
 ;
 S ISEASVALID=$$VALIDATEEAS(.ERRORS,$G(REQUEST("EAS")))
 ;
 I $L($G(REQUEST("MODALITY"))) S ISMODALINVALID=$$VALIDATEMODALITY^SDESINPUTVALUTL(.ERRORS,$G(REQUEST("MODALITY")))
 ;
 S ISPRIORITYVALID=$$VALIDATEPRIORITY(.ERRORS,$G(REQUEST("PRIORITY")))
 I ISPRIORITYVALID S REQUEST("PRIORITY")=$$SOCEXT2INT^SDESUTIL(409.85,10,$G(REQUEST("PRIORITY")))
 ;
 I $L($G(REQUEST("PRIORITY GROUP"))) S ISPRIGROUPVALID=$$VALIDATEPRIGROUP(.ERRORS,$G(REQUEST("PRIORITY GROUP")))
 ;
 S ISSERVCONNVALID=$$VALIDATESERVCONN^SDESCREATEAPPREQ(.ERRORS,$G(REQUEST("SERVICE CONNECTED")),$G(REQUEST("SERVICE CONNECTED PERCENTAGE")))
 ;
 ; Evaluate Appt Type IEN and Appt Type Name together
 N SDIEN,SDNAME
 S SDIEN=$G(REQUEST("APPOINTMENT TYPE IEN")),SDNAME=$G(REQUEST("APPOINTMENT TYPE NAME"))
 S ISAPPTTYPEVALID=$$VALIDATEAPPTTYPE^SDESCREATEAPPREQ(.ERRORS,.SDIEN,SDNAME)
 S REQUEST("APPOINTMENT TYPE IEN")=SDIEN
 ;
 I $L($G(REQUEST("PATIENT STATUS"))) S ISPATSTATVALID=$$VALIDATEPATSTAT(.ERRORS,$G(REQUEST("PATIENT STATUS")))
 ;
 I $D(REQUEST("PATIENT PREFERRED START DATE")),$D(REQUEST("PATIENT PREFERRED END DATE")) D VALIDATEDATEPREF^SDESEDITAPPTREQ2(.ERRORS,.REQUEST)
 ;
 I $D(REQUEST("MRTC")) D VALIDATEMRTCDATA(.ERRORS,.REQUEST,$G(REQUEST("MRTC","PARENT REQUEST")),$G(REQUEST("MRTC","NEEDED")),$G(REQUEST("MRTC","DAYS BETWEEN APPTS")),$G(REQUEST("MRTC","HOW MANY NEEDED")))
 I $G(REQUEST("REQUEST COMMENT"))]"" D VALREQCOM(.ERRORS,.REQUEST)
 Q
 ;
BUILDER(REQUEST) ;
 N FDA,FDAERR,RETURNIEN
 S REQIEN=$G(REQUEST("REQUEST IEN"))_","
 S FDA(409.85,REQIEN,.01)=$G(REQUEST("DFN"))
 S FDA(409.85,REQIEN,.02)=$G(REQUEST("PATIENT STATUS"))
 S FDA(409.85,REQIEN,1)=$G(REQUEST("CREATE DATE"))
 S FDA(409.85,REQIEN,2)=$G(INSTITUTIONIEN)
 S FDA(409.85,REQIEN,4)=$G(REQUEST("REQUEST SUB TYPE"))
 S FDA(409.85,REQIEN,5)=$G(REQUEST("VAOS GUID"))
 S FDA(409.85,REQIEN,6)=$G(REQUEST("MODALITY"))
 S FDA(409.85,REQIEN,8)=$G(REQUEST("CLINIC IEN"))
 S FDA(409.85,REQIEN,8.5)=$G(REQUEST("STOP CODE"))
 S FDA(409.85,REQIEN,8.6)=$G(REQUEST("SECONDARY STOP CODE"))
 S FDA(409.85,REQIEN,8.7)=$G(REQUEST("APPOINTMENT TYPE IEN"))
 S FDA(409.85,REQIEN,9)=$G(DUZ)
 S FDA(409.85,REQIEN,9.5)=$$NOW^XLFDT
 S FDA(409.85,REQIEN,10)=$G(REQUEST("PRIORITY"))
 S FDA(409.85,REQIEN,10.5)=$G(REQUEST("PRIORITY GROUP"))
 S FDA(409.85,REQIEN,11)=$G(REQUEST("REQUESTED BY"))
 S FDA(409.85,REQIEN,12)=$G(REQUEST("PROVIDER IEN"))
 S FDA(409.85,REQIEN,14)=$G(REQUEST("SERVICE CONNECTED PERCENTAGE"))
 S FDA(409.85,REQIEN,15)=$G(REQUEST("SERVICE CONNECTED"))
 ; Removed the update to PID since it occurs in ADDPIDHISTORY as well and the Original PID is needed for ADDPIDHISTORY
 ;S FDA(409.85,REQIEN,22)=$G(REQUEST("PATIENT INDICATED DATE"))
 S FDA(409.85,REQIEN,25)=$TR($G(REQUEST("REQUEST COMMENT")),"^"," ")
 S FDA(409.85,REQIEN,41)=$G(REQUEST("MRTC","NEEDED"))
 S FDA(409.85,REQIEN,42)=$G(REQUEST("MRTC","DAYS BETWEEN APPTS"))
 S FDA(409.85,REQIEN,43)=$G(REQUEST("MRTC","HOW MANY NEEDED"))
 I $G(REQUEST("MRTC","PARENT REQUEST"))'="" S FDA(409.85,REQIEN,43.8)=$G(REQUEST("MRTC","PARENT REQUEST"))
 S FDA(409.85,REQIEN,46)=$G(REQUEST("CPRS ORDER NUMBER"))
 S FDA(409.85,REQIEN,47)=$G(REQUEST("CPRS TIME SENSITIVE"))
 S FDA(409.85,REQIEN,100)=$G(REQUEST("EAS"))
 D FILE^DIE(,"FDA","FDAERR") K FDA
 ;
 D ADDPIDHISTORY^SDESCREATEAPPREQ($G(REQUEST("REQUEST IEN")),$G(REQUEST("PATIENT INDICATED DATE")))
 ;
 I $D(REQUEST("CPRS PREREQUISITES")) D EDITCPRSPREREQS(.REQUEST,$G(REQUEST("REQUEST IEN")))
 ;
 I $D(REQUEST("PATIENT COMMENT"))!($D(REQUEST("PATIENT PREFERRED START DATE"))) D BUILDCOMMENTS(.REQUEST,$G(REQUEST("REQUEST IEN")))
 ;
 I $D(REQUEST("MRTC","PATIENT INDICATED DATE")) D EDITMRTCPID(.REQUEST,$G(REQUEST("REQUEST IEN")))
 ;
 I $D(REQUEST("MRTC","CHILD REQUEST"))!($D(REQUEST("MRTC","MRTC APPOINTMENT"))) D EDITMRTCLINKS(.REQUEST,$G(REQUEST("REQUEST IEN")))
 ;
 D AUDIT($G(REQUEST("REQUEST IEN")),$G(REQUEST("CLINIC IEN")),$G(REQUEST("STOP CODE")))
 ;
 Q $G(REQUEST("REQUEST IEN"))
 ;
 ;877
BUILDAPPTDATA(REQIEN,APPTDATETIME,CLINICIEN,SERVCONNPERC,SERVCONN,APPTTYPE,EAS,SDUSER,APPTMSG) ;
 N FDA,FDAERR,ERROR
 S REQIEN=$G(REQIEN)_","
 S FDA(409.85,REQIEN,8.7)=$G(APPTTYPE)
 S FDA(409.85,REQIEN,13)=$G(APPTDATETIME)
 S FDA(409.85,REQIEN,13.1)=$P($$NOW^XLFDT,".",1)
 S FDA(409.85,REQIEN,13.2)=$G(CLINICIEN)
 S FDA(409.85,REQIEN,13.3)=$$GET1^DIQ(44,$G(CLINICIEN),3,"I") ; appt institution ;
 S FDA(409.85,REQIEN,13.4)=$$GET1^DIQ(44,$G(CLINICIEN),8,"I") ; appt stop code
 S FDA(409.85,REQIEN,13.6)=$$GET1^DIQ(40.8,$$GET1^DIQ(44,$G(CLINICIEN),3.5,"I"),1,"I") ; appt station number
 ;
 S:$G(SDUSER)="" SDUSER=DUZ
 S FDA(409.85,REQIEN,13.7)=SDUSER
 S FDA(409.85,REQIEN,13.8)="R" ; 'R' FOR Scheduled/Kept;
 S FDA(409.85,REQIEN,14)=$G(SERVCONNPERC)
 S FDA(409.85,REQIEN,15)=$G(SERVCONN)
 S FDA(409.85,REQIEN,100)=$G(EAS)
 S FDA(409.85,REQIEN,19)=$P($$NOW^XLFDT,".",1)
 ;877
 S FDA(409.85,REQIEN,20)=SDUSER
 ;
 S FDA(409.85,REQIEN,21)=$$FIND1^DIC(409.853,,"B","REMOVED/SCHEDULED-ASSIGNED")
 S FDA(409.85,REQIEN,23)="C"
 D FILE^DIE(,"FDA","FDAERR") K FDA
 I $$GET1^DIQ(409.85,REQIEN,4,"I")="RTC" D UPDATEORDER(.APPTMSG,$P(REQIEN,",",1),SDUSER)
 ;
 N PARENTIEN
 S PARENTIEN=$$GET1^DIQ(409.85,REQIEN_",",43.8,"I")
 I PARENTIEN D
 . N CHILDIEN,FOUND
 . S CHILDIEN="",FOUND=0
 . F  S CHILDIEN=$O(^SDEC(409.85,PARENTIEN,2,"B",CHILDIEN)) Q:(CHILDIEN="")!(FOUND)  D
 . . S FOUND=($$GET1^DIQ(409.85,CHILDIEN_",",23,"E")="OPEN")
 . I 'FOUND D
 . . S FDA(409.85,PARENTIEN_",",20)=SDUSER
 . . S FDA(409.85,PARENTIEN_",",21)=$$FIND1^DIC(409.853,,"B","MRTC PARENT CLOSED")
 . . S FDA(409.85,PARENTIEN_",",23)="C"
 . . S FDA(409.85,PARENTIEN_",",19)=$P($$NOW^XLFDT,".",1)
 . . D FILE^DIE(,"FDA","ERROR") K FDA
 . . I $$GET1^DIQ(409.85,PARENTIEN,4,"I")="RTC" D UPDATEORDER(.APPTMSG,PARENTIEN,SDUSER)
 Q
 ;
UPDATEORDER(APPTMSG,REQUESTIEN,SDUSER) ;Send HL7 to CPRS if RTC request
 D ARDISP^SDECHL7(REQUESTIEN,"",SDUSER)
 I $D(^TMP($J,"REJECT",REQUESTIEN)) D
 . S APPTMSG="Appointment created; however, ORDER status not updated. Please submit ticket."
 Q
 ;
EDITMRTCLINKS(REQUEST,REQIEN) ;
 N NUM,FDA,FDAERR,SUBIEN
 S SUBIEN=0,NUM=0
 F  S SUBIEN=$O(^SDEC(409.85,REQIEN,2,SUBIEN)) Q:'SUBIEN  D
 .S NUM=NUM+1
 .S FDA(409.852,SUBIEN_","_REQIEN_",",.01)=$G(REQUEST("MRTC","CHILD REQUEST",NUM))
 .S FDA(409.852,SUBIEN_","_REQIEN_",",.02)=$G(REQUEST("MRTC","MRTC APPOINTMENT",NUM))
 .D FILE^DIE(,"FDA","FDAERR") K FDA
 Q
 ;
EDITMRTCPID(REQUEST,REQIEN) ;
 N NUM,FDA,FDAERR,SUBIEN
 S SUBIEN=0,NUM=0
 F  S SUBIEN=$O(^SDEC(409.85,REQIEN,5,SUBIEN)) Q:'SUBIEN  D
 .S NUM=NUM+1
 .S FDA(409.851,SUBIEN_","_REQIEN_",",.01)=$G(REQUEST("MRTC","PATIENT INDICATED DATE",NUM))
 .D FILE^DIE(,"FDA","FDAERR") K FDA
 Q
 ;
BUILDMRTCLINKS(REQUEST,REQIEN) ; called from SDESCREATEAPPT after appt is made from mrtc child
 N FDA,FDAERR,SUBIEN
 S SUBIEN=$O(^SDEC(409.85,REQIEN,2,"B",REQUEST("MRTC","CHILD REQUEST"),0))
 S FDA(409.852,SUBIEN_","_REQIEN_",",.02)=$G(REQUEST("MRTC","MRTC APPOINTMENT"))
 D UPDATE^DIE(,"FDA",,"FDAERR") K FDA
 Q
 ;
BUILDMRTCPID(REQUEST,REQIEN) ; called from SDESCREATEAPPT after appt is made from mrtc child
 N FDA,FDAERR,SDPID
 S SDPID=$G(REQUEST("MRTC","PATIENT INDICATED DATE"))
 S:SDPID="" SDPID=$$GET1^DIQ(409.85,REQIEN,22,"I")
 Q:$O(^SDEC(409.85,REQIEN,5,"B",SDPID,0))
 S FDA(409.851,"+1,"_REQIEN_",",.01)=SDPID
 D UPDATE^DIE(,"FDA",,"FDAERR") K FDA
 Q
 ;
BUILDCOMMENTS(REQUEST,REQIEN) ;
 N REQCOMMS,NUM,NUM2,DONE,PREFDATES,PATCOMMS,RANGE,DATERANGE1,DATERANGE2,DATERANGE3,EDITPATCOM
 S NUM=0
 I $D(REQUEST("PATIENT COMMENT")) D
 .N PC S PC="PATIENT COMMENT"
 .I $G(REQUEST(PC))'["Patient preferred date range" S EDITPATCOM(1)=$G(REQUEST(PC)) D WP^DIE(409.85,REQIEN_",",60,"","EDITPATCOM") Q
 .S EDITPATCOM(1)=$P($G(REQUEST(PC)),"Patient preferred date range",1)
 .S DATERANGE1=$P($G(REQUEST(PC)),"Patient preferred date range",2) I $L($G(DATERANGE1)) S EDITPATCOM(2)="Patient preferred date range"_$P($G(REQUEST(PC)),"Patient preferred date range",2)
 .S DATERANGE2=$P($G(REQUEST(PC)),"Patient preferred date range",3) I $L($G(DATERANGE2)) S EDITPATCOM(3)="Patient preferred date range"_$P($G(REQUEST(PC)),"Patient preferred date range",3)
 .S DATERANGE3=$P($G(REQUEST(PC)),"Patient preferred date range",4) I $L($G(DATERANGE3)) S EDITPATCOM(4)="Patient preferred date range"_$P($G(REQUEST(PC)),"Patient preferred date range",4)
 .D WP^DIE(409.85,REQIEN_",",60,"","EDITPATCOM")
 Q
 ;
EDITCPRSPREREQS(REQUEST,REQIEN) ;
 N NUM,FDA,FDAERR,SUBIEN
 I '$D(^SDEC(409.85,REQIEN,8)) D BUILDCPRSPREREQS^SDESCREATEAPPREQ(.REQUEST,REQIEN) Q
 S SUBIEN=0,NUM=0
 F  S SUBIEN=$O(^SDEC(409.85,REQIEN,8,SUBIEN)) Q:'SUBIEN  D
 .S NUM=NUM+1
 .S FDA(409.8548,SUBIEN_","_REQIEN_",",.01)=$G(REQUEST("CPRS PREREQUISITES",NUM))
 .D FILE^DIE(,"FDA","FDAERR") K FDA
 Q
 ;
AUDIT(REQIEN,CLINICIEN,STOPCODE) ;
 N FDA,FDAERR
 S FDA(409.8545,"+1,"_REQIEN_",",.01)=$$NOW^XLFDT
 S FDA(409.8545,"+1,"_REQIEN_",",1)=$G(DUZ)
 S FDA(409.8545,"+1,"_REQIEN_",",2)=$G(CLINICIEN)
 S FDA(409.8545,"+1,"_REQIEN_",",3)=$G(STOPCODE)
 D UPDATE^DIE("","FDA",,"FDAERR") K FDA
 Q
 ;
VALIDATEPROVIDER(ERRORS,PROVIDERIEN) ;
 I PROVIDERIEN="@" D ERRLOG^SDESJSON(.ERRORS,229) Q 0
 I PROVIDERIEN="" D ERRLOG^SDESJSON(.ERRORS,53) Q 0
 I PROVIDERIEN'="",'$D(^VA(200,PROVIDERIEN,0)) D ERRLOG^SDESJSON(.ERRORS,54) Q 0
 Q 1
 ;
VALIDATEPID(ERRORS,REQUEST) ;
 N REQUESTIEN,OLDPID
 S REQUESTIEN=$G(REQUEST("REQUEST IEN"))
 S OLDPID=$$GET1^DIQ(409.85,REQUESTIEN,22,"I")
 I $G(REQUEST("PATIENT INDICATED DATE"))="@" D ERRLOG^SDESJSON(.ERRORS,229) Q 0
 I $G(REQUEST("PATIENT INDICATED DATE"))="" D ERRLOG^SDESJSON(.ERRORS,159) Q 0
 I $G(REQUEST("PATIENT INDICATED DATE"))'="" S REQUEST("PATIENT INDICATED DATE")=$$ISOTFM^SDAMUTDT($G(REQUEST("PATIENT INDICATED DATE")))
 I $G(REQUEST("PATIENT INDICATED DATE"))=-1 D ERRLOG^SDESJSON(.ERRORS,160) Q 0
 I REQUESTIEN,$$DUPPIDCHK^SDES2CANCELAPPT(REQUESTIEN,$G(REQUEST("PATIENT INDICATED DATE"))) D ERRLOG^SDESJSON(.ERRORS,545) Q 0
 Q 1
 ;
VALIDATEEAS(ERRORS,EAS) ;
 I $L(EAS) S EAS=$$EASVALIDATE^SDESUTIL($G(EAS))
 I $P($G(EAS),U)=-1 D ERRLOG^SDESJSON(.ERRORS,142) Q 0
 Q 1
 ;
VALIDATEPRIORITY(ERRORS,PRIORITY) ;
 I PRIORITY="" D ERRLOG^SDESJSON(.ERRORS,457) Q 0
 I PRIORITY'="ASAP",PRIORITY'="FUTURE" D ERRLOG^SDESJSON(.ERRORS,211) Q 0
 Q 1
 ;
VALIDATEPRIGROUP(ERRORS,GROUP) ;
 N NUM,FOUND,GCHECK
 S NUM=0,FOUND=0
 F NUM=1:1:8  D
 .S GCHECK="GROUP "_NUM
 .I GROUP=GCHECK S REQUEST("PRIORITY GROUP")=NUM S FOUND=1
 I FOUND=0 D ERRLOG^SDESJSON(.ERRORS,199) Q 0
 Q 1
 ;
VALIDATEPATSTAT(ERRORS,PATIENTSTATUS) ;
 I PATIENTSTATUS'="NEW",PATIENTSTATUS'="ESTABLISHED" D ERRLOG^SDESJSON(.ERRORS,203) Q 0
 S REQUEST("PATIENT STATUS")=$S(PATIENTSTATUS="NEW":"N",PATIENTSTATUS="ESTABLISHED":"E",1:"")
 Q 1
 ;
VALIDATEMRTCDATA(ERRORS,REQUEST,PARENTREQUEST,NEEDED,DAYSBETWEEN,HOWMANY) ;
 N NUM,DONE,CNT
 I NEEDED'="YES" D  Q ""
 .I $G(PARENTREQUEST)!($G(DAYSBETWEEN))!($G(HOWMANY)) D ERRLOG^SDESJSON(.ERRORS,233)
 I NEEDED'="",NEEDED'="YES",NEEDED'="NO" D ERRLOG^SDESJSON(.ERRORS,208) Q
 ;
 I PARENTREQUEST'="",('$D(^SDEC(409.85,PARENTREQUEST)))!(PARENTREQUEST=0) D ERRLOG^SDESJSON(.ERRORS,207)
 ;
 I DAYSBETWEEN'="" D
 .I '+DAYSBETWEEN!(DAYSBETWEEN'<366) D ERRLOG^SDESJSON(.ERRORS,209)
 ;
 I HOWMANY'="" D
 .I '+HOWMANY!(HOWMANY'<101) D ERRLOG^SDESJSON(.ERRORS,210)
 ;
 I $D(REQUEST("MRTC","PATIENT INDICATED DATE")) D
 .S NUM=0,DONE=0
 .F  S NUM=$O(REQUEST("MRTC","PATIENT INDICATED DATE",NUM)) Q:'NUM!(DONE=1)  D
 ..S REQUEST("MRTC","PATIENT INDICATED DATE",NUM)=$$ISOTFM^SDAMUTDT($G(REQUEST("MRTC","PATIENT INDICATED DATE",NUM)))
 ..I $G(REQUEST("MRTC","PATIENT INDICATED DATE",NUM))=-1 D ERRLOG^SDESJSON(.ERRORS,215) S DONE=1 Q
 ;
 I $D(REQUEST("MRTC","CHILD REQUEST"))!($D(REQUEST("MRTC","MRTC APPOINTMENT"))) D
 .S CNT=0,DONE=0
 .F  S CNT=$O(REQUEST("MRTC","CHILD REQUEST",CNT)) Q:'CNT!(DONE=1)  D
 ..I '$D(^SDEC(409.85,$G(REQUEST("MRTC","CHILD REQUEST",CNT)),0)) D ERRLOG^SDESJSON(.ERRORS,216) S DONE=1 Q
 ..I '$D(^SDEC(409.84,$G(REQUEST("MRTC","MRTC APPOINTMENT",CNT)),0)) D ERRLOG^SDESJSON(.ERRORS,217) S DONE=1 Q
 Q
VALREQCOM(ERRORS,REQUEST)   ;
 S REQUEST("REQUEST COMMENT")=$TR(REQUEST("REQUEST COMMENT"),"^"," ")
 I $L($G(REQUEST("REQUEST COMMENT")))>80 D ERRLOG^SDESJSON(.ERRORS,443)
 Q
