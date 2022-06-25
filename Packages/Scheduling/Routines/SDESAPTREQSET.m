SDESAPTREQSET   ;ALB/TAW - APPOINTMENT REQUEST CREATE / UPDATE ;Aug 18, 2021
 ;;5.3;Scheduling;**794,799**;Aug 13, 1993;Build 7
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;This entry point is used for both the SDES SET APT REQ CREATE and SDES SET APT REQ UPDATE RPCs.
 ;
 ; The parameter list for each RPC must be kept in sync.  This includes in the Remote Procedure file definition.
 ;
ARSET(RETURN,ARIEN,DFN,AREDT,ARINST,ARTYPE,ARCLIN,ARUSER,ARREQBY,ARPROV,ARDAPTDT,ARCOMM,ARENPRI,ARMAR,ARMAI,AMRAN,ARPATCONT,ARSVCCON,ARSVCCOP,MRTCPREFDT,ARSTOP,ARAPTYP,ARPATSTAT,MULTIAPTMADE,ARPARENT,ARNLT,ARPRER,ARORDN,VAOSGUID,EASTRCKNGNMBR) ;
 ; INP - Input parameters array
 ;  ARIEN     = (integer)  IEN point to SDEC APPT REQUEST file 409.85.
 ;                       If null, a new entry will be added
 ;  DFN       = (text)     DFN Pointer to the PATIENT file 2
 ;  AREDT     = (date)     Originating Date/time in external date formt
 ;  ARINST    = (text)     Institution name NAME field from the INSTITUTION file
 ;  ARTYPE    = (text)     Appointment Request Type
 ;  ARCLIN    = (text)     REQ Specific Clinic name - NAME field in file 44
 ;  ARUSER    = (text)     Originating User name  - NAME field in NEW PERSON file 200
 ;  ARREQBY   = (text)     Request By - 'PROVIDER' or 'PATIENT'
 ;  ARPROV    = (text)     Provider name  - NAME field in NEW PERSON file 200
 ;  ARDAPTDT  = (date)     Desired Date of appointment in external format.
 ;  ARCOMM    = (text)     Comment must be 1-60 characters.
 ;  ARENPRI   = (text)     ENROLLMENT PRIORITY - Valid Values are "GROUP 1" through "GROUP 8"
 ;  ARMAR     = (text)     MULTIPLE APPOINTMENT RTC      NO; YES
 ;  ARMAI     = (integer)  MULT APPT RTC INTERVAL integer between 1-365
 ;  AMRAN     = (integer)  MULT APPT NUMBER integer between 1-100
 ;  ARPATCONT = Patient Contacts separated by ::
 ;            Each :: piece has the following ~~ pieces:
 ;            1) = (date)    DATE ENTERED external date/time
 ;            2) = (text)    PC ENTERED BY USER ID or NAME - Pointer toNEW PERSON file or NAME
 ;            4) = (optional) ACTION - valid values are:
 ;                             CALLED, MESSAGE LEFT or LETTER
 ;            5) = (optional) PATIENT PHONE Free-Text 4-20 characters
 ;            6) = NOT USED (optional) Comment 1-160 characters
 ;  ARSVCCON  = (optional) SERVICE CONNECTED PRIORITY valid values are NO YES
 ;  ARSVCCOP  = (optional) SERVICE CONNECTED PERCENTAGE = numeric 0-100
 ;  MRTCPREFDT = (optional) MRTC calculated preferred dates separated by pipe |:
 ;                       Each date can be in external format with no time.
 ;  ARSTOP    = (optional) CLINIC STOP pointer to CLINIC STOP file 40.7
 ;                       used to populate the REQ SERVICE/SPECIALTY field in 409.85
 ;  ARAPTYP   = (optional) Appointment Type ID pointer to APPOINTMENT TYPE file 409.1
 ;  ARPATSTAT = (optional) Patient Status  N = NEW  E = ESTABLISHED
 ;  MULTIAPTMADE = (optional) MULT APPTS MADE
 ;        List of child pointers to SDEC APPOINTMENT and/orSDEC APPT REQUEST files separated by pipe
 ;         each pipe piece contains the following ~ pieces:
 ;           1. Appointment Id pointer to SDEC APPOINTMENT file 409.84
 ;           2. Request Id pointer to SDEC APPT REQUEST file 409.85
 ;  ARPARENT  = (optional) PARENT REQUEST pointer to SDEC APPT REQUEST file 409.85
 ;  ARNLT     = (optional) NLT (No later than) [CPRS RTC REQUIREMENT]
 ;  ARPRER    = (optional) PREREQ (Prerequisites) [CPRS RTC REQUIREMENT]
 ;  ARORDN    = (optional) ORDER IEN [CPRS RTC REQUIREMENT]
 ;  VAOSGUID  = (optional) VAOS GUID
 ;  EASTRCKNGNMBR = (optional) Enterprise Appointment Scheduling Tracking Number associated to an appointment.
 ;
 N POP,SDAPTREQ,X,Y,%DT,ARORIGDT,ARORIGDTI,FNUM,ARINSTI,ARTEAM,ARPOS,ARSRVSP,MI
 N ARPRIO,AREESTAT,FDA,ARNEW,ARRET,ARMSG,ARDATA,ARERR,ARHOSN,AUDF,SDREC,ARMAN,ARPATTEL
 ;
 D VALIDATE
 I 'POP D
 .I +ARIEN D UPDATE
 .I +ARIEN=0 D CREATE
 .I 'POP D FILE
 D BUILDER
 Q
 ;
VALIDATE ;
 S (POP,AUDF)=0
 S FNUM=$$FNUM^SDECAR
 ;
 S ARIEN=$G(ARIEN,"")
 ; If the Update RPC is called and no ARIEN is sent then it will show as -1
 I ARIEN'="" D
 .I ARIEN=-1 S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,3) Q
 .I '$D(^SDEC(409.85,ARIEN)) S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,4)
 ;
 S DFN=$G(DFN,"")
 I ARIEN="" D
 .I DFN="" S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,1)
 .I DFN'="",'$D(^DPT(DFN,0)) S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,2)
 ;Originating Dt/Tm
 S AREDT=$G(AREDT,"")
 I ARIEN="",AREDT="" S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,48)
 I AREDT'="" S AREDT=$$NETTOFM^SDECDATE($P(AREDT,":",1,2),$S(AREDT["@":"Y",1:"N"))
 I AREDT=-1 S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,49)
 S ARORIGDT=$P(AREDT,".",1)
 ;Instution name
 S ARINST=$G(ARINST,"")
 I ARINST'="" S ARINST=$O(^DIC(4,"B",ARINST,0))
 ;Appt Request Type
 S ARTYPE=$G(ARTYPE,"")
 S:ARTYPE="APPOINTMENT" ARTYPE="APPT"
 I ARIEN="",ARTYPE="" S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,60)
 ;Clinic name/number
 S ARCLIN=$G(ARCLIN,"")
 I ARCLIN'="" D
 .I +ARCLIN=ARCLIN D
 ..I '$D(^SC(+ARCLIN,0)) S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,19)
 .I +ARCLIN'=ARCLIN D
 ..S ARCLIN=$O(^SC("B",ARCLIN,0))
 ..I ARCLIN="" S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,51)
 ;User
 S ARUSER=$G(ARUSER,"")
 I ARUSER'="",'+ARUSER S ARUSER=$O(^VA(200,"B",ARUSER,0))
 I ARUSER="" S ARUSER=DUZ
 ;Reqested by
 S ARREQBY=$G(ARREQBY,"")
 I ARREQBY'="" D
 .S ARREQBY=$S(ARREQBY="PATIENT":2,ARREQBY="PROVIDER":1,1:"")
 I ARIEN="",ARREQBY="" S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,62)
 ;Provider name
 S ARPROV=$G(ARPROV,"")
 I ARPROV'="" S ARPROV=$O(^VA(200,"B",ARPROV,0))
 ;Desired date of appt
 S ARDAPTDT=$G(ARDAPTDT,"")
 S ARPRIO=""
 I ARIEN="",ARDAPTDT="" S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,57)
 I ARDAPTDT'="" D
 .S ARDAPTDT=$$CALLDT($P($G(ARDAPTDT),"@",1))
 .I ARDAPTDT=-1 S ARDAPTDT="",POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,58) Q
 .I ARIEN="",ARDAPTDT<DT S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,59) Q  ;Only validate on Create
 .S ARPRIO=$S(ARDAPTDT=$P($$NOW^XLFDT,".",1):"A",1:"F") ;Priority ASAP or Future
 ;comment
 S ARCOMM=$TR($G(ARCOMM),"^"," ")
 ;S ARCOMM=$E(ARCOMM,1,60)
 ;Enrollment priority
 S ARENPRI=$G(ARENPRI,"")
 S:ARENPRI'="" ARENPRI=$S(ARENPRI="GROUP 1":1,ARENPRI="GROUP 2":2,ARENPRI="GROUP3":3,ARENPRI="GROUP4":4,ARENPRI="GROUP 5":5,ARENPRI="GROUP 6":6,ARENPRI="GROUP 7":7,ARENPRI="GROUP 8":8,1:ARENPRI)
 ;MRTC Yes/No
 S ARMAR=$G(ARMAR,"")
 I ARMAR'="" S ARMAR=$S(ARMAR="YES":1,1:0)
 ;Multi Apt IEN
 S ARMAI=$G(ARMAI,"")
 ;Multi Apt numbers
 S ARMAN=$G(ARMAN,"")
 ;Patient Contaccts
 ;
 ;Serv Connect Prio
 S ARSVCCON=$G(ARSVCCON,"")
 S:ARSVCCON'="" ARSVCCON=$S(ARSVCCON="YES":1,1:0)
 ;Serv Connect %
 S ARSVCCOP=$G(ARSVCCOP,"")
 I ARSVCCOP'="" S:(+ARSVCCOP<0)!(+ARSVCCOP>100) ARSVCCOP=""
 ;MRTC calc pref dates
 ;
 ;Clinic Stop Code
 S ARSTOP=$G(ARSTOP,"")
 I ARIEN="",ARCLIN="",ARSTOP="" S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,63)
 I ARSTOP'="",ARCLIN'="" S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,52,"Cannot include both Clinic Name and Clinic Stop.")
 ;Appointment Type #
 S ARAPTYP=+$G(ARAPTYP,"")
 I +ARAPTYP,'$D(^SD(409.1,ARAPTYP,0)) S ARAPTYP=""
 ;Patient Status
 S ARPATSTAT=$G(ARPATSTAT,"")
 I ARPATSTAT'="" S ARPATSTAT=$S(ARPATSTAT="N":"N",ARPATSTAT="NEW":"N",ARPATSTAT="E":"E",ARPATSTAT="ESTABLISHED":"E",1:"")
 ;Multi Apt Made
 ;
 ;Parent Request
 S ARPARENT=+$G(ARPARENT,"")
 I +ARPARENT,'$D(^SDEC(409.85,+ARPARENT,0)) S ARPARENT=""
 ;No Later Than
 S ARNLT=+$G(ARNLT,"")
 I +ARPARENT>0&(+$G(ARNLT)=0) S ARNLT=$P($G(^SDEC(409.85,+ARPARENT,7)),"^",2)
 ;Prerequisit
 S ARPRER=$G(ARPRER,"")
 I +ARPARENT>0&(ARPRER="") D
 .N PRIEN,PR
 .S PRIEN=0 F  S PRIEN=$O(^SDEC(409.85,+ARPARENT,8,PRIEN)) Q:PRIEN'>0  D
 ..S PR=$P($G(^SDEC(409.85,+ARPARENT,8,PRIEN,0)),"^")
 ..S:PR'="" ARPRER=$S(ARPRER'="":ARPRER_";"_PR,1:PR)
 ;Order IEN
 S ARORDN=+$G(ARORDN)
 I +ARPARENT>0&(+$G(ARORDN)=0) S ARORDN=$P($G(^SDEC(409.85,+ARPARENT,7)),"^",1)
 ;VAOS ID
 S VAOSGUID=$G(VAOSGUID,"")
 ;validate EAS Tracking Number
 S EASTRCKNGNMBR=$TR($E($G(EASTRCKNGNMBR),1,30),"^"," ")
 Q
 ;
CREATE ;Build FDA array to creat a new entry in 409.85
 S AUDF=1
 S FDA=$NA(FDA(FNUM,"+1,"))
 S @FDA@(.01)=+DFN
 S:$G(ARORIGDT)'="" @FDA@(1)=ARORIGDT
 S:$G(ARINST)'="" @FDA@(2)=+ARINST
 S:$G(ARTYPE)'="" @FDA@(4)=ARTYPE
 S:$G(VAOSGUID)'="" @FDA@(5)=VAOSGUID
 S:$G(ARCLIN)'="" @FDA@(8)=+ARCLIN
 S:$G(ARSTOP)'="" @FDA@(8.5)=+ARSTOP
 S:+ARAPTYP @FDA@(8.7)=+ARAPTYP
 S:$G(ARUSER)'="" @FDA@(9)=+ARUSER
 S:$G(AREDT)'="" @FDA@(9.5)=AREDT
 S:$G(ARPRIO)'="" @FDA@(10)=ARPRIO
 S:$G(ARENPRI)'="" @FDA@(10.5)=ARENPRI
 S:$G(ARREQBY)'="" @FDA@(11)=ARREQBY
 S:$G(ARPROV)'="" @FDA@(12)=+ARPROV
 S:$G(ARSVCCOP)'="" @FDA@(14)=ARSVCCOP
 S:$G(ARSVCCON)'="" @FDA@(15)=+ARSVCCON
 S:$G(ARDAPTDT)'="" @FDA@(22)=ARDAPTDT
 S:$G(ARNLT)'="" @FDA@(47)=ARNLT
 S:EASTRCKNGNMBR'="" @FDA@(100)=EASTRCKNGNMBR
 D FDAPRER(.FDA,ARPRER,"+1")
 S:$G(ARORDN)'="" @FDA@(46)=ARORDN
 S @FDA@(23)="O"
 S:$G(ARCOMM)'="" @FDA@(25)=ARCOMM
 S:$G(ARMAR)'="" @FDA@(41)=ARMAR
 I +ARMAR,$G(ARMAI)'="" S @FDA@(42)=ARMAI
 I +ARMAR,$G(ARMAN)'="" S @FDA@(43)=ARMAN
 S:ARPATSTAT'="" @FDA@(.02)=ARPATSTAT
 S:+ARPARENT @FDA@(43.8)=+ARPARENT
 Q
 ;
UPDATE ;
 S ARIEN=ARIEN_"," ; Append the comma for both
 K ARDATA,ARERR
 D GETS^DIQ(FNUM,ARIEN,"*","IE","ARDATA","ARERR")
 I $D(ARERR) D  Q
 .S POP=1
 .K FDA
 .F MI=1:1:$G(ARERR("DIERR")) S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,48,$G(ARERR("DIERR",MI,"TEXT",1)))
 S FDA=$NA(FDA(FNUM,ARIEN))
 I ARORIGDT'="" D
 .S ARORIGDT=$P(ARORIGDT,"@",1) S ARORIGDTI=$$CALLDT(ARORIGDT)
 .I ARORIGDTI'=ARDATA(FNUM,ARIEN,1,"I") S @FDA@(1)=$S(ARORIGDT="":"@",1:ARORIGDT)
 I ARINST'="",ARINST'=ARDATA(FNUM,ARIEN,2,"I") S @FDA@(2)=+ARINST
 I ARTYPE'="",ARTYPE'=ARDATA(FNUM,ARIEN,4,"I") S @FDA@(4)=ARTYPE
 I VAOSGUID'="",VAOSGUID'=ARDATA(FNUM,ARIEN,5,"I") S @FDA@(5)=VAOSGUID
 I ARCLIN'="",ARCLIN'=ARDATA(FNUM,ARIEN,8,"I") S @FDA@(8)=+ARCLIN,AUDF=1 S:ARDATA(FNUM,ARIEN,8.5,"I")'="" @FDA@(8.5)="@"
 I ARSTOP'="",ARSTOP'=ARDATA(FNUM,ARIEN,8.5,"I") S @FDA@(8.5)=+ARSTOP,AUDF=1 S:ARDATA(FNUM,ARIEN,8,"I")'="" @FDA@(8)="@"
 S:+ARAPTYP @FDA@(8.7)=+ARAPTYP
 I ARUSER'="",ARUSER'=ARDATA(FNUM,ARIEN,9,"I") S @FDA@(9)=+ARUSER
 I AREDT'="",AREDT'=$G(ARDATA(FNUM,ARIEN,9.5,"I")) S @FDA@(9.5)=AREDT
 I ARPRIO'="",ARPRIO'=ARDATA(FNUM,ARIEN,10,"I") S @FDA@(10)=$S(ARPRIO="":"@",1:ARPRIO)
 I ARENPRI'="",ARENPRI'=ARDATA(FNUM,ARIEN,10.5,"I") S @FDA@(10.5)=ARENPRI
 I ARREQBY'="",ARREQBY'=ARDATA(FNUM,ARIEN,11,"I") S @FDA@(11)=$S(ARREQBY="":"@",1:ARREQBY)
 I ARPROV'="",ARPROV'=ARDATA(FNUM,ARIEN,12,"I") S @FDA@(12)=+ARPROV
 I ARSVCCOP'="",ARSVCCOP'=$G(ARDATA(FNUM,ARIEN,14,"I")) S @FDA@(14)=ARSVCCOP
 I ARSVCCON'="",ARSVCCON'=ARDATA(FNUM,ARIEN,15,"I") S @FDA@(15)=+ARSVCCON
 I ARDAPTDT'="",ARDAPTDT'=ARDATA(FNUM,ARIEN,22,"I") S @FDA@(22)=$S(ARDAPTDT="":"@",1:ARDAPTDT)
 I ARCOMM'="",ARCOMM'=ARDATA(FNUM,ARIEN,25,"I") S @FDA@(25)=$S(ARCOMM="":"@",1:ARCOMM)
 S:ARMAR'="" @FDA@(41)=ARMAR
 S:ARMAI'="" @FDA@(42)=ARMAI
 S:ARMAN'="" @FDA@(43)=ARMAN
 S:ARNLT'="" @FDA@(47)=ARNLT
 S:EASTRCKNGNMBR'="" @FDA@(100)=EASTRCKNGNMBR
 D DELPRER(+ARIEN)
 D FDAPRER(.FDA,ARPRER,+ARIEN)
 S:ARORDN'="" @FDA@(46)=ARORDN
 S:ARPATSTAT'="" @FDA@(.02)=ARPATSTAT
 S:+ARPARENT @FDA@(43.8)=+ARPARENT
 Q
 ;
DELPRER(ARIEN) ;Delete all entries in the PREREQUISITE multiple (#48)
 N DIK,DA
 Q:$G(ARIEN)'=+$G(ARIEN)  Q:ARIEN'>0
 S DIK="^SDEC(409.85,"_ARIEN_",8,",DA(1)=ARIEN
 S DA=0 F  S DA=$O(^SDEC(409.85,ARIEN,8,DA)) Q:DA'>0  D ^DIK
 Q
 ;
FDAPRER(FDA,ARPRER,ARIEN) ;Setup the FDA array for the PREREQUISITE multiple (#48)
 N ASEQ,DELIM,PC,PR
 Q:$G(ARPRER)=""
 S DELIM=";",ASEQ=80
 F PC=1:1:$L(ARPRER,DELIM) D
 .S PR=$P(ARPRER,DELIM,PC) Q:PR=""
 .S ASEQ=ASEQ+1,FDA(409.8548,"+"_ASEQ_","_ARIEN_",",.01)=PR
 Q
 ;
FILE ;Perform file update
 ; Only call UPDATE^DIE if there are any array entries in FDA
 D:$D(FDA)>9 UPDATE^DIE("","FDA","ARRET","ARMSG")
 I $D(ARMSG) D  Q
 . F MI=1:1:$G(ARMSG("DIERR")) S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,48,$G(ARMSG("DIERR",MI,"TEXT",1)))
 ;
 N IEN
 S IEN=$S(+ARIEN:+ARIEN,1:ARRET(1))
 S ARINSTI=$P($G(^SDEC(409.85,IEN,0)),U,3)
 I $G(ARPATCONT)'="" D AR23(ARPATCONT,IEN)   ;patient contacts
 I +ARMAR,$G(MRTCPREFDT)'="" D AR435(MRTCPREFDT,IEN)   ;MRTC CALC PREF DATES
 I +AUDF D ARAUD(IEN,ARCLIN,ARSTOP)   ;VS AUDIT
 I $G(MULTIAPTMADE)'="" D
 .N SDI
 .F SDI=1:1:$L(MULTIAPTMADE,"|") S SDREC=$P(MULTIAPTMADE,"|",SDI) D AR433(IEN,SDREC)
 I +ARPARENT D AR433(+ARPARENT,"~"_IEN)
 ;
 I +$G(ARRET(1)) S SDAPTREQ("AptReqCreate","IEN")=IEN
 E  S SDAPTREQ("AptReqUpdate","IEN")=IEN
 Q
 ;
ARAUD(ARIEN,ARCLIN,ARSTOP,DATE,USER) ;populate VS AUDIT multiple field 45
 ; ARIEN   - (required) pointer to SDEC APPT REQUEST file 409.85
 ; ARCLIN  - (optional) pointer to HOSPITAL LOCATION file 44
 ; ARSTOP  - (optional) pointer to CLINIC STOP file
 ; DATE    - (optional) date/time in fileman format
 N SDFDA,SDP,SDPN
 S ARIEN=$G(ARIEN) Q:ARIEN=""
 S ARCLIN=$G(ARCLIN)
 S ARSTOP=$G(ARSTOP)
 S SDP=$O(^SDEC(409.85,ARIEN,6,9999999),-1)
 I +SDP S SDPN=^SDEC(409.85,ARIEN,6,SDP,0) I $P(SDPN,U,3)=ARCLIN,$P(SDPN,U,4)=ARSTOP Q
 S DATE=$G(DATE) S:DATE="" DATE=$E($$NOW^XLFDT,1,12)
 S USER=$G(USER) S:USER="" USER=DUZ
 S SDFDA(409.8545,"+1,"_ARIEN_",",.01)=DATE
 S SDFDA(409.8545,"+1,"_ARIEN_",",1)=USER
 S:ARCLIN'="" SDFDA(409.8545,"+1,"_ARIEN_",",2)=ARCLIN
 S:ARSTOP'="" SDFDA(409.8545,"+1,"_ARIEN_",",3)=ARSTOP
 D UPDATE^DIE("","SDFDA")
 Q
 ;
AR433(ARIEN,SDEC) ;set MULT APPTS MADE
 ;INPUT:
 ;  ARIEN  = (required) pointer to SDEC APPT REQUEST file 409.85
 ;  SDEC   = (required) child pointers to SDEC APPOINTMENT and SDEC APPTREQUEST file separated by pipe
 ;                    each pipe piece contains the following ~ pieces:
 ;                1. Appointment Id pointer to SDEC APPOINTMENT file 409.84
 ;                2. Request Id pointer to SDEC APPT REQUEST file 409.85
 N SDAPP,SDFDA,SDI,SDIEN
 S ARIEN=$G(ARIEN)
 Q:'$D(^SDEC(409.85,ARIEN,0))
 S SDEC=$G(SDEC)
 F SDI=1:1:$L(SDEC,"|") D
 .K SDFDA
 .S SDAPP=$P(SDEC,"|",SDI)
 .I $P(SDAPP,"~",2)="",$P(SDAPP,"~",1)'="" S $P(SDAPP,"~",2)=$P($$GET1^DIQ(409.84,+SDAPP_",",.22,"I"),";",1)
 .Q:$P(SDAPP,"~",2)=""
 .S SDIEN=$O(^SDEC(409.85,ARIEN,2,"B",$P(SDAPP,"~",2),0))
 .S SDIEN=$S(SDIEN'="":SDIEN,1:"+1")
 .I $D(^SDEC(409.85,+$P(SDAPP,"~",2),0)) S SDFDA(409.852,SDIEN_","_ARIEN_",",.01)=+$P(SDAPP,"~",2)
 .I $D(^SDEC(409.84,+$P(SDAPP,"~",1),0)) S SDFDA(409.852,SDIEN_","_ARIEN_",",.02)=+$P(SDAPP,"~",1)
 .D:$D(SDFDA) UPDATE^DIE("","SDFDA")
 Q
 ;
AR435(SDDT,ARIEN) ;set dates into MRTC CALC PREF DATES multiple field 43.5
 ;INPUT:
 ; ARIEN - Requested date ID pointer to SDEC REQUESTED APPT file 409.85
 ; SDDT  - MRTC calculated preferred dates separated by pipe |:
 ;         Each date can be in external format with no time.
 N SDI,SDJ,SDFDA,TMPDT
 F SDI=1:1:$L(SDDT,"|") D
 .S TMPDT=$P($P(SDDT,"|",SDI),"@",1)
 .S SDJ=$$CALLDT(TMPDT)
 .Q:SDJ=-1
 .Q:$O(^SDEC(409.85,ARIEN,5,"B",SDJ,0))   ;don't add duplicates
 .S SDFDA(409.851,"+1,"_ARIEN_",",.01)=SDJ
 .D UPDATE^DIE("","SDFDA")
 Q
 ;
AR23(INP17,ARI) ;Patient Contacts
 N STR17,ARASD,ARASDH,ARDATA1,ARERR1,ARI1,ARIENS,ARIENS1,ARRET1,FDA,ARMSG1
 N ARDT,ARUSR
 S ARIENS=ARI_","
 F ARI1=1:1:$L(INP17,"::") D
 .S STR17=$P(INP17,"::",ARI1)
 .K FDA
 .;
 .;  Change date conversion to deal with midnight.  5/29/18 wtc patch 694
 .;
 .S ARASD=$P($P(STR17,"~~",1),":",1,2)
 .S ARASD=$$NETTOFM^SDECDATE(ARASD,"Y")
 .I (ARASD=-1)!(ARASD="") Q
 .S ARDT=$P($P(STR17,"~~",1),":",1,2)
 .S ARASDH=""
 .S ARIENS1=$S(ARASDH'="":ARASDH,1:"+1")_","_ARIENS
 .S FDA=$NA(FDA(409.8544,ARIENS1))
 .I ARASDH'="" D
 ..D GETS^DIQ(409.8544,ARIENS1,"*","IE","ARDATA1","ARERR1")
 ..I $P(STR17,"~~",1)'="" S @FDA@(.01)=ARDT ;DATE ENTERED external date/time
 ..I $P(STR17,"~~",2)'="" S ARUSR=$P(STR17,"~~",2) S @FDA@(2)=$S(ARUSR="":"@",+ARUSR:$P($G(^VA(200,ARUSR,0)),U,1),1:ARUSER)  ;PC ENTERED BY USER
 ..I $P(STR17,"~~",4)'="" S @FDA@(3)=$P(STR17,"~~",4)     ;ACTION  C=Called; M=Message Left; L=LETTER
 ..I $P(STR17,"~~",5)'="" S @FDA@(4)=$P(STR17,"~~",5)     ;PATIENT PHONE
 .I ARASDH="" D
 ..I $P(STR17,"~~",1)'="" S @FDA@(.01)=ARDT ;DATE ENTERED external date/time
 ..I $P(STR17,"~~",2)'="" S ARUSR=$P(STR17,"~~",2) S @FDA@(2)=$S(ARUSR="":"@",+ARUSR:$P($G(^VA(200,ARUSR,0)),U,1),1:ARUSR)     ;PC ENTERED BY USER
 ..I $P(STR17,"~~",4)'="" S @FDA@(3)=$P(STR17,"~~",4)     ;ACTION  C=Called; M=Message Left; L=LETTER
 ..I $P(STR17,"~~",5)'="" S @FDA@(4)=$P(STR17,"~~",5)     ;PATIENT PHONE
 .D:$D(@FDA) UPDATE^DIE("E","FDA","ARRET1","ARMSG1")
 Q
CALLDT(X) ;
 N Y,%DT
 S %DT="" D ^%DT
 Q Y
 ;
BUILDER ;Convert data to JSON
 N JSONERR
 S JSONERR=""
 D ENCODE^SDESJSON(.SDAPTREQ,.RETURN,.JSONERR)
 Q
