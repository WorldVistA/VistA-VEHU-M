SDESCREATEAPPREQ  ;ALB/BLB,MGD,BLB,BWF,MGD,LAB,MGD,JAS,BLB,MGD,JDJ,JAS,JAS - SCHEDULING APPOINTMENT REQUEST RPCS; APR 2, 2024
 ;;5.3;Scheduling;**823,826,833,835,837,843,844,846,847,864,869,871,875**;Aug 13, 1993;Build 25
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
 ; RPC: SDES CREATE APPT REQ
 ;
CREATEREQUEST(JSONRETURN,REQUEST) ;
 N REQUESTIEN,ERRORS,RETURN,ISDFNVALID,ISDATETIMEVALID,ISMODALINVALID,ISEASVALID,INSTITUTIONIEN
 N ISCLINSTOPVALID,ISREQUESTBYVALID,ISPROVIDERVALID,ISMODALITYVALID,ISPIDVALID,ISPRIGROUPVALID
 N ISREQTYPEVALID,ISPRIORITYVALID,ISSERVCONNVALID,ISAPPTTYPEVALID,ISAPPTNAMEVALID,ISPATSTATVALID
 N ISDATEPREFVALID,ISMTRCDATAVALID,ISCPRSDATAVALID
 ;
 D VALIDATE(.REQUEST,.INSTITUTIONIEN,.ERRORS)
 ;
 I $D(ERRORS) M RETURN=ERRORS D BUILDJSON(.JSONRETURN,.RETURN) Q
 ;
 D CONVERTSTOPCODE(.REQUEST)
 ;
 S REQUESTIEN=$$BUILDER(.REQUEST,INSTITUTIONIEN)
 ;
 S RETURN("Request","IEN")=$G(REQUESTIEN)
 ;
 D BUILDJSON(.JSONRETURN,.RETURN)
 Q
 ;
VALIDATE(REQUEST,INSTITUTIONIEN,ERRORS) ;
 ;
 S ISDFNVALID=$$VALIDATEDFN^SDESCRTAPPREQVAL(.ERRORS,$G(REQUEST("DFN")))
 S ISDATETIMEVALID=$$VALIDATEDATETIME^SDESCRTAPPREQVAL(.ERRORS,.REQUEST)
 S ISREQTYPEVALID=$$VALIDATEREQTYPE^SDESCRTAPPREQVAL(.ERRORS,$G(REQUEST("REQUEST SUB TYPE")))
 S INSTITUTIONIEN=$$STATIONTOINST^SDESCRTAPPREQVAL(.ERRORS,$G(REQUEST("STATION NUMBER")),$G(REQUEST("INSTITUTION NAME")))
 S ISCLINSTOPVALID=$$VALIDATECLINSTOP^SDESCRTAPPREQVAL(.ERRORS,$G(REQUEST("CLINIC IEN")),$G(REQUEST("STOP CODE")),$G(REQUEST("SECONDARY STOP CODE")))
 S ISREQUESTBYVALID=$$VALIDATEREQBY^SDESCRTAPPREQVAL(.ERRORS,$G(REQUEST("REQUESTED BY")))
 I $G(REQUEST("REQUESTED BY"))=1 S ISPROVIDERVALID=$$VALIDATEPROVIDER(.ERRORS,$G(REQUEST("PROVIDER IEN")))
 I $G(REQUEST("REQUESTED BY"))'=1 S REQUEST("PROVIDER IEN")=""
 S ISPIDVALID=$$VALIDATEPID(.ERRORS,.REQUEST)
 S ISEASVALID=$$VALIDATEEAS(.ERRORS,$G(REQUEST("EAS")))
 I $L($G(REQUEST("MODALITY"))) S ISMODALINVALID=$$VALIDATEMODALITY^SDESINPUTVALUTL(.ERRORS,$G(REQUEST("MODALITY")))
 S ISPRIORITYVALID=$$VALIDATEPRIORITY(.ERRORS,$G(REQUEST("PRIORITY")))
 I $L($G(REQUEST("PRIORITY GROUP"))) S ISPRIGROUPVALID=$$VALIDATEPRIGROUP(.ERRORS,$G(REQUEST("PRIORITY GROUP")))
 S ISSERVCONNVALID=$$VALIDATESERVCONN(.ERRORS,$G(REQUEST("SERVICE CONNECTED")),$G(REQUEST("SERVICE CONNECTED PERCENTAGE")))
 ;
 N SDIEN,SDNAME
 S SDIEN=$G(REQUEST("APPOINTMENT TYPE IEN")),SDNAME=$G(REQUEST("APPOINTMENT TYPE NAME"))
 S ISAPPTTYPEVALID=$$VALIDATEAPPTTYPE(.ERRORS,.SDIEN,SDNAME)
 S REQUEST("APPOINTMENT TYPE IEN")=SDIEN
 I $L($G(REQUEST("PATIENT STATUS"))) S ISPATSTATVALID=$$VALIDATEPATSTAT(.ERRORS,$G(REQUEST("PATIENT STATUS")))
 I $D(REQUEST("PATIENT PREFERRED START DATE")),$D(REQUEST("PATIENT PREFERRED END DATE")) D VALIDATEDATEPREF(.ERRORS,.REQUEST)
 I $D(REQUEST("MRTC")) D VALIDATEMRTCDATA(.ERRORS,.REQUEST,$G(REQUEST("MRTC","PARENT REQUEST")),$G(REQUEST("MRTC","NEEDED")),$G(REQUEST("MRTC","DAYS BETWEEN APPTS")),$G(REQUEST("MRTC","HOW MANY NEEDED")),$G(REQUEST("DFN")))
 I $G(REQUEST("MRTC","PARENT REQUEST")),$G(REQUEST("DFN")) S REQUEST("MRTC","CHILD SEQUENCE NUMBER")=$$MRTCHILDSEQUENCE($G(REQUEST("MRTC","PARENT REQUEST")),$G(REQUEST("DFN")))
 ;
 Q
 ;
CONVERTSTOPCODE(REQUEST) ;
 I $D(REQUEST("STOP CODE")) S REQUEST("STOP CODE")=$$FIND1^DIC(40.7,"","X",REQUEST("STOP CODE"),"C")
 I $D(REQUEST("SECONDARY STOP CODE")) S REQUEST("SECONDARY STOP CODE")=$$FIND1^DIC(40.7,"","X",REQUEST("SECONDARY STOP CODE"),"C")
 Q
 ;
BUILDER(REQ,INSTITUTIONIEN) ;
 N FDA,RETURNIEN
 S FDA(409.85,"+1,",.01)=$G(REQ("DFN"))
 S FDA(409.85,"+1,",.02)=$G(REQ("PATIENT STATUS"))
 S FDA(409.85,"+1,",1)=$G(REQ("CREATE DATE"))
 S FDA(409.85,"+1,",2)=$G(INSTITUTIONIEN)
 S FDA(409.85,"+1,",4)=$G(REQ("REQUEST SUB TYPE"))
 S FDA(409.85,"+1,",5)=$G(REQ("VAOS GUID"))
 S FDA(409.85,"+1,",6)=$G(REQ("MODALITY"))
 S FDA(409.85,"+1,",8)=$G(REQ("CLINIC IEN"))
 S FDA(409.85,"+1,",8.5)=$G(REQ("STOP CODE"))
 S FDA(409.85,"+1,",8.6)=$G(REQ("SECONDARY STOP CODE"))
 S FDA(409.85,"+1,",8.7)=$G(REQ("APPOINTMENT TYPE IEN"))
 S FDA(409.85,"+1,",9)=$G(DUZ)
 S FDA(409.85,"+1,",9.5)=$$NOW^XLFDT
 S FDA(409.85,"+1,",10)=$G(REQ("PRIORITY"))
 S FDA(409.85,"+1,",10.5)=$G(REQ("PRIORITY GROUP"))
 S FDA(409.85,"+1,",11)=$G(REQ("REQUESTED BY"))
 S FDA(409.85,"+1,",12)=$G(REQ("PROVIDER IEN"))
 S FDA(409.85,"+1,",14)=$G(REQ("SERVICE CONNECTED PERCENTAGE"))
 S FDA(409.85,"+1,",15)=$G(REQ("SERVICE CONNECTED"))
 S FDA(409.85,"+1,",22)=$G(REQ("PATIENT INDICATED DATE"))
 S FDA(409.85,"+1,",23)="O"
 S FDA(409.85,"+1,",25)=$G(REQ("REQUEST COMMENT"))
 S FDA(409.85,"+1,",41)=$G(REQ("MRTC","NEEDED"))
 S FDA(409.85,"+1,",42)=$G(REQ("MRTC","DAYS BETWEEN APPTS"))
 S FDA(409.85,"+1,",43)=$G(REQ("MRTC","HOW MANY NEEDED"))
 S FDA(409.85,"+1,",43.1)=$G(REQ("MRTC","CHILD SEQUENCE NUMBER"))
 S FDA(409.85,"+1,",43.8)=$G(REQ("MRTC","PARENT REQUEST"))
 S FDA(409.85,"+1,",46)=$G(REQ("CPRS ORDER NUMBER"))
 S FDA(409.85,"+1,",47)=$S($G(REQ("CPRS TIME SENSITIVE"))="YES":"1",$G(REQ("CPRS TIME SENSITIVE"))="NO":"0",1:"")
 S FDA(409.85,"+1,",49)=$G(REQ("PID CHANGE ALLOWED"))
 S FDA(409.85,"+1,",100)=$G(REQ("EAS"))
 ;
 D UPDATE^DIE("","FDA","RETURNIEN") K FDA
 S REQUESTIEN=$G(RETURNIEN(1))
 ;
 D ADDPIDHISTORY(REQUESTIEN,$G(REQ("PATIENT INDICATED DATE")))
 ;
 I $D(REQ("CPRS PREREQUISITES")) D BUILDCPRSPREREQS(.REQ,REQUESTIEN)
 ;
 I $D(REQ("MRTC","PARENT REQUEST"))&($G(REQUESTIEN)'="") D ADDMRTCMULT(REQUESTIEN,REQ("MRTC","PARENT REQUEST"),REQ("PATIENT INDICATED DATE"))
 ;
 I ($D(REQ("PATIENT COMMENT")))!($D(REQ("PATIENT PREFERRED START DATE"))) D BUILDCOMMENTS(.REQ,REQUESTIEN)
 ;
 D AUDIT(REQUESTIEN,$G(REQ("CLINIC IEN")),$G(REQ("STOP CODE")))
 ;
 Q REQUESTIEN
 ;
ADDPIDHISTORY(REQUESTIEN,PID) ;
 N PIDFDA,FDA,OLDPID,PARENTIEN
 ;
 I PID=$$GET1^DIQ(409.854,$O(^SDEC(409.85,REQUESTIEN,10,"A"),-1)_","_REQUESTIEN_",",1,"I") Q
 ;
 S PIDFDA(409.854,"+1,"_REQUESTIEN_",",.01)=$$NOW^XLFDT
 S PIDFDA(409.854,"+1,"_REQUESTIEN_",",1)=PID
 S PIDFDA(409.854,"+1,"_REQUESTIEN_",",2)=$$GET1^DIQ(200,$G(DUZ),.01,"E")
 D UPDATE^DIE(,"PIDFDA") K PIDFDA
 ;
 S OLDPID=$$GET1^DIQ(409.85,REQUESTIEN_",",22,"I")
 S PARENTIEN=$$GET1^DIQ(409.85,REQUESTIEN_",",43.8,"I")
 ;
 S FDA(409.85,REQUESTIEN_",",22)=PID
 D FILE^DIE(,"FDA") K FDA
 ;
 I PARENTIEN,$D(^SDEC(409.85,PARENTIEN)) D
 . N PREFIEN S PREFIEN=$O(^SDEC(409.85,PARENTIEN,5,"B",OLDPID,0))
 . S FDA(409.851,PREFIEN_","_PARENTIEN_",",.01)=PID
 . D FILE^DIE(,"FDA") K FDA
 Q
 ;
ADDMRTCMULT(CHILD,PARENT,PATIENTINDDATE) ;Update the MRTC subfiles
 D ADDMRTCLINKS(CHILD,PARENT)
 D ADDMRTCPIDLINKS(PARENT,PATIENTINDDATE)
 Q
 ;
ADDMRTCLINKS(CHILD,PARENT) ;
 N FDA
 Q:$O(^SDEC(409.85,PARENT,2,"B",CHILD))
 S FDA(409.852,"+1,"_PARENT_",",.01)=CHILD
 D UPDATE^DIE(,"FDA") K FDA
 Q
 ;
ADDMRTCPIDLINKS(PARENT,PATIENTINDDATE) ;
 N SDFDA
 Q:$O(^SDEC(409.85,PARENT,5,"B",PATIENTINDDATE,0))
 S SDFDA(409.851,"+1,"_PARENT_",",.01)=PATIENTINDDATE
 D UPDATE^DIE("","SDFDA") K SDFDA
 Q
 ;
MRTCHILDSEQUENCE(PARENTREQUESTIEN,DFN) ; return next sequence # for child mrtc
 N COUNT,REQUESTIEN,IENS,NEXTSEQUENCENUM,CHILD,LASTCHILD
 S REQUESTIEN=0,COUNT=0,LASTCHILD=""
 F  S REQUESTIEN=$O(^SDEC(409.85,"B",DFN,REQUESTIEN)) Q:'REQUESTIEN  D
 .I $$GET1^DIQ(409.85,REQUESTIEN,43.8,"I")=PARENTREQUESTIEN D
 ..S COUNT=COUNT+1
 ..S CHILD(REQUESTIEN)=COUNT
 I $D(CHILD) D
 .S LASTCHILD=$O(CHILD(LASTCHILD),-1)
 .S NEXTSEQUENCENUM=$G(CHILD($G(LASTCHILD)))+1
 I '$D(CHILD) S NEXTSEQUENCENUM=1
 Q NEXTSEQUENCENUM
 ;
AUDIT(REQUESTIEN,CLINICIEN,STOPCODE) ;
 N FDA
 S FDA(409.8545,"+1,"_REQUESTIEN_",",.01)=$$NOW^XLFDT
 S FDA(409.8545,"+1,"_REQUESTIEN_",",1)=$G(DUZ)
 S FDA(409.8545,"+1,"_REQUESTIEN_",",2)=$G(CLINICIEN)
 S FDA(409.8545,"+1,"_REQUESTIEN_",",3)=$G(STOPCODE)
 D UPDATE^DIE("","FDA") K FDA
 Q
BUILDCOMMENTS(REQUEST,REQUESTIEN) ;
 N REQCOMMS,NUM,NUM2,DONE,PREFDATES,PATCOMMS,RANGE,COUNT
 S NUM=0
 ;
 I $D(REQUEST("PATIENT COMMENT")) D
 .D WP^SDECUTL(.PATCOMMS,$G(REQUEST("PATIENT COMMENT")))
 .D WP^DIE(409.85,REQUESTIEN_",",60,"","PATCOMMS")
 ;
 I '$G(REQUEST("PATIENT PREFERRED START DATE",1)) Q
 ;
 S NUM=0,COUNT="",COUNT=$O(REQUEST("PATIENT PREFERRED START DATE",COUNT),-1)
 F NUM=1:1:COUNT D
 .S STARTDATE=$G(REQUEST("PATIENT PREFERRED START DATE",NUM))
 .S ENDDATE=$G(REQUEST("PATIENT PREFERRED END DATE",NUM))
 .S STARTDATE=$$ISOTFM^SDAMUTDT(STARTDATE),STARTDATE=$$FMTE^XLFDT(STARTDATE)
 .S ENDDATE=$$ISOTFM^SDAMUTDT(ENDDATE),ENDDATE=$$FMTE^XLFDT(ENDDATE)
 .S RANGE(NUM)="Patient preferred date range #"_NUM_": "_STARTDATE_" to "_ENDDATE
 D WP^DIE(409.85,REQUESTIEN_",",60,"A","RANGE")
 Q
 ;
BUILDCPRSPREREQS(REQUEST,REQUESTIEN) ;
 N NUM,FDA
 S NUM=0
 F  S NUM=$O(REQUEST("CPRS PREREQUISITES",NUM)) Q:'NUM  D
 .S FDA(409.8548,"+1,"_REQUESTIEN_",",.01)=$G(REQUEST("CPRS PREREQUISITES",NUM))
 .D UPDATE^DIE(,"FDA") K FDA
 Q
 ;
VALIDATEPROVIDER(ERRORS,PROVIDERIEN) ;
 I PROVIDERIEN="" D ERRLOG^SDESJSON(.ERRORS,53) Q 0
 I PROVIDERIEN'="",'$D(^VA(200,PROVIDERIEN,0)) D ERRLOG^SDESJSON(.ERRORS,54) Q 0
 Q 1
 ;
VALIDATEPID(ERRORS,REQUEST) ;
 I $G(REQUEST("PATIENT INDICATED DATE"))="" D ERRLOG^SDESJSON(.ERRORS,159) Q 0
 I $G(REQUEST("PATIENT INDICATED DATE"))'="" S REQUEST("PATIENT INDICATED DATE")=$$ISOTFM^SDAMUTDT($G(REQUEST("PATIENT INDICATED DATE")))
 I $G(REQUEST("PATIENT INDICATED DATE"))=-1 D ERRLOG^SDESJSON(.ERRORS,160) Q 0
 Q 1
 ;
VALIDATEEAS(ERRORS,EAS) ;
 I $L(EAS) S EAS=$$EASVALIDATE^SDESUTIL($G(EAS))
 I $P($G(EAS),U)=-1 D ERRLOG^SDESJSON(.ERRORS,142) Q 0
 Q 1
 ;
VALIDATEPRIORITY(ERRORS,PRIORITY) ;
 I PRIORITY="" S PRIORITY="ASAP"
 I PRIORITY'="ASAP",PRIORITY'="FUTURE" D ERRLOG^SDESJSON(.ERRORS,211) Q 0
 S REQUEST("PRIORITY")=$S(PRIORITY="ASAP":"A",PRIORITY="FUTURE":"F",1:"")
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
VALIDATESERVCONN(ERRORS,SERVCONN,SERVCONNPERC) ;
 I $L(SERVCONN),SERVCONN'="YES",SERVCONN'="NO" D ERRLOG^SDESJSON(.ERRORS,200) Q 0
 I $G(SERVCONNPERC),'+SERVCONNPERC!(SERVCONNPERC'>0)!(SERVCONNPERC'<101) D ERRLOG^SDESJSON(.ERRORS,201) Q 0
 ;I $G(SERVCONN)="NO",+$G(SERVCONNPERC) D ERRLOG^SDESJSON(.ERRORS,232) Q 0
 S REQUEST("SERVICE CONNECTED")=$S(SERVCONN="YES":"1",SERVCONN="NO":"0",1:"")
 Q 1
 ;
VALIDATEAPPTTYPE(ERRORS,APPTTYPEIEN,APPTTYPENAME) ;
 I APPTTYPEIEN="",APPTTYPENAME="" D ERRLOG^SDESJSON(.ERRORS,306) Q 0
 N APPTTYPIEN
 S APPTTYPIEN=0
 I $G(APPTTYPENAME)'="" D  I 'APPTTYPIEN Q 0
 . S APPTTYPIEN=$$FIND1^DIC(409.1,"","X",APPTTYPENAME,"B")
 . I 'APPTTYPIEN D ERRLOG^SDESJSON(.ERRORS,180)
 I APPTTYPIEN S APPTTYPEIEN=APPTTYPIEN Q 1
 I APPTTYPEIEN'="",'$D(^SD(409.1,APPTTYPEIEN,0)) D ERRLOG^SDESJSON(.ERRORS,180)
 Q 0
 ;
VALIDATEPATSTAT(ERRORS,PATIENTSTATUS) ;
 I PATIENTSTATUS'="NEW",PATIENTSTATUS'="ESTABLISHED" D ERRLOG^SDESJSON(.ERRORS,203) Q 0
 S REQUEST("PATIENT STATUS")=$S(PATIENTSTATUS="NEW":"N",PATIENTSTATUS="ESTABLISHED":"E",1:"")
 Q 1
 ;
VALIDATEDATEPREF(ERRORS,REQUEST) ;
 N ARYIEN,ARYIEN2,DATE,ERR,STARTDATE,ENDDATE
 S ARYIEN=0,ERR=0
 F  S ARYIEN=$O(REQUEST("PATIENT PREFERRED START DATE",ARYIEN)) Q:'ARYIEN!($G(ERR))  D
 .S STARTDATE=$G(REQUEST("PATIENT PREFERRED START DATE",ARYIEN))
 .S STARTDATE=$$ISOTFM^SDAMUTDT(STARTDATE)
 .I STARTDATE=-1!($L(STARTDATE,".")=1) S ERR=1 D ERRLOG^SDESJSON(.ERRORS,206) Q
 .S ARYIEN2=0
 .F  S ARYIEN2=$O(REQUEST("PATIENT PREFERRED END DATE",ARYIEN2)) Q:'ARYIEN2  D
 ..S ENDDATE=$G(REQUEST("PATIENT PREFERRED END DATE",ARYIEN2))
 ..S ENDDATE=$$ISOTFM^SDAMUTDT(ENDDATE)
 ..I ENDDATE=-1!($L(ENDDATE,".")=1) S ERR=1 D ERRLOG^SDESJSON(.ERRORS,206) Q
 I $G(REQUEST("PATIENT PREFERRED START DATE",1)),'$G(REQUEST("PATIENT PREFERRED END DATE",1)) D ERRLOG^SDESJSON(.ERRORS,195) Q 0
 I $G(REQUEST("PATIENT PREFERRED START DATE",2)),'$G(REQUEST("PATIENT PREFERRED END DATE",2)) D ERRLOG^SDESJSON(.ERRORS,195) Q 0
 I $G(REQUEST("PATIENT PREFERRED START DATE",3)),'$G(REQUEST("PATIENT PREFERRED END DATE",3)) D ERRLOG^SDESJSON(.ERRORS,195) Q 0
 Q
 ;
VALIDATEMRTCDATA(ERRORS,REQUEST,PARENTREQUEST,NEEDED,DAYSBETWEEN,HOWMANY,REQDFN) ;
 N NUM,DONE
 I PARENTREQUEST,$$GET1^DIQ(409.85,PARENTREQUEST,.01,"I")'=REQDFN D ERRLOG^SDESJSON(.ERRORS,533)
 I NEEDED'="",NEEDED'="YES",NEEDED'="NO" D ERRLOG^SDESJSON(.ERRORS,208) Q
 S REQUEST("MRTC","NEEDED")=$S(NEEDED="YES":1,NEEDED="NO":0,1:"")
 I REQUEST("MRTC","NEEDED")'=1 D  Q ""
 .I $G(PARENTREQUEST)!($G(DAYSBETWEEN))!($G(HOWMANY)) D ERRLOG^SDESJSON(.ERRORS,233)
 Q 1
 ;
 ;
 I PARENTREQUEST'="",('$D(^SDEC(409.85,PARENTREQUEST)))!(PARENTREQUEST=0) D ERRLOG^SDESJSON(.ERRORS,207)
 ;
 I DAYSBETWEEN'="" D
 .I '+DAYSBETWEEN!(DAYSBETWEEN'<366) D ERRLOG^SDESJSON(.ERRORS,209)
 ;
 I HOWMANY'="" D
 .I '+HOWMANY!(HOWMANY'<101) D ERRLOG^SDESJSON(.ERRORS,210)
 Q
 ;
BUILDJSON(JSONRETURN,RETURN) ;.
 N JSONERROR
 D ENCODE^XLFJSON("RETURN","JSONRETURN","JSONERR")
 Q
