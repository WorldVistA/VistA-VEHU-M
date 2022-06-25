SDESRTVCLN ;ALB/ANU - Get Clinic Info based on Clinic IEN ;SEP 20, 2021@14:39
 ;;5.3;Scheduling;**799**;Aug 13, 1993;Build 7
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ;Reference to $$GETS^DIQ,$$GETS1^DIQ in ICR #2056
 Q
 ;
JSONCLNINFO(SDCLNJSON,SDCLNIEN) ;Get Clinic info
 ;INPUT - SDCLNIEN (Clinic IEN)
 ;RETURN PARMETER:
 ; Clinic information from HOSPITAL LOCAITON (#44) File. Data is delimited by carat (^).
 ; Field List:
 ; (1)     Clinic Name
 ; (2)     Abbreviation
 ; (3)     Patient Friendly Name
 ; (4)     Clinic Meets at this Facility
 ; (5)     ALLOW DIRECT PATIENT SCHEDULING?
 ; (6)     DISPLAY CLIN APPT TO PATIENTS?
 ; (7)     SERVICE
 ; (8)     NON-COUNT CLINIC? (Y OR N)
 ; (9)     DIVISION
 ; (10)    STOP CODE NUMBER
 ; (11)    DEFAULT APPOINTMENT TYPE
 ; (12)    ADMINISTER INPATIENT MEDS?
 ; (13)    TELEPHONE
 ; (14)    REQUIRE X-RAY FILMS?
 ; (15)    REQUIRE ACTION PROFILES?
 ; (16)    NO SHOW LETTER
 ; (17)    PRE-APPOINTMENT LETTER
 ; (18)    CLINIC CANCELLATION LETTER
 ; (19)    APPT. CANCELLATION LETTER
 ; (20)    ASK FOR CHECK IN/OUT TIME
 ; (21)    PROVIDER - This is a multiple
 ; (22)    Flag indicating the provider is the defalut for the clinic
 ; (23)    DEFAULT TO PC PRACTITIONER?
 ; (24)    DIAGNOSIS - This is a multiple
 ; (25)    Flag indicating the diagnosis is the default for the clinic
 ; (26)    WORKLOAD VALIDATION AT CHK OUT
 ; (27)    ALLOWABLE CONSECUTIVE NO-SHOWS
 ; (28)    MAX # DAYS FOR FUTURE BOOKING
 ; (29)    SCHEDULE ON HOLIDAYS?
 ; (30)    CREDIT STOP CODE
 ; (31)    PROHIBIT ACCESS TO CLINIC?
 ; (32)    PHYSICAL LOCATION
 ; (33)    PRINCIPAL Clinic
 ; (34)    OVERBOOKS/DAY MAXIMUM
 ; (35)    SPECIAL INSTRUCTIONS - This is a multiple
 ; (36)    E-CHECKIN ALLOWED
 ; (37)    PRE-CHECKIN ALLOWED
 ; (38)    LENGTH OF APP'T
 ; (39)    VARIABLE APP'NTMENT LENGTH
 ; (40)    DISPLAY INCRUMENTS PER HOUR
 ;
 N SDCLNSREC,ERRPOP,ERR,ERRMSG,SDECI
 D INIT
 D VALIDATE
 I ERRPOP D BLDJSON Q
 D BLDCLNREC
 D BLDJSON
 Q
 ;
INIT ; initialize values needed
 S SDECI=0
 S SDECI=$G(SDECI,0),ERR=""
 S ERRPOP=0,ERRMSG=""
 Q
 ;
VALIDATE ; validate incoming parameters
 I SDCLNIEN="" D ERRLOG^SDESJSON(.SDCLNSREC,18) S ERRPOP=1 Q
 I SDCLNIEN'="" D
 .I '$D(^SC(SDCLNIEN,0)) D ERRLOG^SDESJSON(.SDCLNSREC,19) S ERRPOP=1
 ;
 Q
 ;
BLDJSON ;
 D ENCODE^SDESJSON(.SDCLNSREC,.SDCLNJSON,.ERR)
 K SDCLNSREC
 Q
 ;
BLDCLNREC ;Build a list of Providers
 ;
 N SDFIELDS,SDDATA,SDMSG,SDX,SDC
 S SDFIELDS=".01;1;3.5;8;9;10;60;61;62;2502;2507;2802;99;2000;2000.5;2508;2509;2510;2511;25;2801;30;2001;2002;1918.5;2503;2500;1916;1918;20;21;1912;1913;1917"
 D GETS^DIQ(44,SDCLNIEN_",",SDFIELDS,"IE","SDDATA","SDMSG")
 S SDECI=SDECI+1
 S SDCLNSREC("Cinic","Name")=$G(SDDATA(44,SDCLNIEN_",",.01,"E")) ;Clinic Name
 S SDCLNSREC("Clinic","Abbreviation")=$G(SDDATA(44,SDCLNIEN_",",1,"E")) ;Clinic Abbreviation
 S SDCLNSREC("Clinic","PatientFriendlyName")=$G(SDDATA(44,SDCLNIEN_",",60,"E")) ;Patient Friendly Name
 S SDCLNSREC("Clinic","MeetsAtThisFacility")=$G(SDDATA(44,SDCLNIEN_",",2504,"E")) ;Clinic meets at this facility?
 S SDCLNSREC("Clinic","AllowPatScheduling")=$G(SDDATA(44,SDCLNIEN_",",61,"E")) ;Allow Direct Patient Scheduling?
 S SDCLNSREC("Clinic","DisplayClinicAppt")=$G(SDDATA(44,SDCLNIEN_",",62,"E")) ;DISPLAY CLIN APPT TO PATIENTS?
 S SDCLNSREC("Clinic","Service")=$G(SDDATA(44,SDCLNIEN_",",9,"E")) ;Service
 S SDCLNSREC("Clinic","NonCountClinic")=$G(SDDATA(44,SDCLNIEN_",",2502,"E")) ;NON-COUNT CLINIC? (Y OR N)
 S SDCLNSREC("Clinic","Division")=$G(SDDATA(44,SDCLNIEN_",",3.5,"E")) ;Division
 S SDCLNSREC("Clinic","StopCodeNum")=$G(SDDATA(44,SDCLNIEN_",",8,"E")) ;Stop Code Number
 S SDCLNSREC("Clinic","DefaultApptType")=$G(SDDATA(44,SDCLNIEN_",",2507,"E")) ;Default Appointment type
 S SDCLNSREC("Clinic","AdminInpatientMeds")=$G(SDDATA(44,SDCLNIEN_",",2802,"E")) ;ADMINISTER INPATIENT MEDS?
 S SDCLNSREC("Clinic","Telephone")=$G(SDDATA(44,SDCLNIEN_",",99,"E")) ;TELEPHONE
 S SDCLNSREC("Clinic","ReqXrayFilms")=$G(SDDATA(44,SDCLNIEN_",",2000,"E")) ;REQUIRE X-RAY FILMS?
 S SDCLNSREC("Clinic","ReqActionProfiles")=$G(SDDATA(44,SDCLNIEN_",",2000.5,"E")) ;REQUIRE ACTION PROFILES?
 S SDCLNSREC("Clinic","NoShowLetter")=$G(SDDATA(44,SDCLNIEN_",",2508,"E")) ;NO SHOW LETTER
 S SDCLNSREC("Clinic","PreApptLetter")=$G(SDDATA(44,SDCLNIEN_",",2509,"E")) ;PRE-APPOINTMENT LETTER
 S SDCLNSREC("Clinic","CancelLetter")=$G(SDDATA(44,SDCLNIEN_",",2510,"E")) ;CLINIC CANCELLATION LETTER
 S SDCLNSREC("Clinic","ApptCancelLetter")=$G(SDDATA(44,SDCLNIEN_",",2511,"E")) ;APPT. CANCELLATION LETTER
 S SDCLNSREC("Clinic","CheckinCheckoutTime")=$G(SDDATA(44,SDCLNIEN_",",25,"E")) ;ASK FOR CHECK IN/OUT TIME
 ;S SDCLNSREC("Clinic","Provider")=$G(SDDATA(44,SDCLNIEN_",",.01,"E")) ;PROVIDER - This is a multiple
 S SDCLNSREC("Clinic","defaultToPCPractitioner")=$G(SDDATA(44,SDCLNIEN_",",2801,"E")) ;DEFAULT TO PC PRACTITIONER?
 ;S SDCLNSREC("Clinic","Diagnosis")=$G(SDDATA(44,SDCLNIEN_",",.01,"E")) ;DIAGNOSIS - This is a multiple
 S SDCLNSREC("Clinic","WorkloadValidationCheckout")=$G(SDDATA(44,SDCLNIEN_",",30,"E")) ;WORKLOAD VALIDATION AT CHK OUT
 S SDCLNSREC("Clinic","AllowableConsecutiveNoShows")=$G(SDDATA(44,SDCLNIEN_",",2001,"E")) ;ALLOWABLE CONSECUTIVE NO-SHOWS
 S SDCLNSREC("Clinic","MaxDaysForFutureBooking")=$G(SDDATA(44,SDCLNIEN_",",2002,"E")) ;MAX # DAYS FOR FUTURE BOOKING
 S SDCLNSREC("Clinic","HolidaySchedule")=$G(SDDATA(44,SDCLNIEN_",",1918.5,"E")) ;SCHEDULE ON HOLIDAYS?
 S SDCLNSREC("Clinic","CreditStopCode")=$G(SDDATA(44,SDCLNIEN_",",2503,"E")) ;CREDIT STOP CODE
 S SDCLNSREC("Clinic","ProhibitAccessToClinic")=$G(SDDATA(44,SDCLNIEN_",",2500,"E")) ;PROHIBIT ACCESS TO CLINIC?
 S SDCLNSREC("Clinic","PhysicalLocation")=$G(SDDATA(44,SDCLNIEN_",",10,"E")) ;PHYSICAL LOCATION
 S SDCLNSREC("Clinic","Principal")=$G(SDDATA(44,SDCLNIEN_",",1916,"E")) ;PRINCIPAL Clinic
 S SDCLNSREC("Clinic","OverbooksPerDayMax")=$G(SDDATA(44,SDCLNIEN_",",1918,"E")) ;OVERBOOKS/DAY MAXIMUM
 S SDCLNSREC("Clinic","ECheckinAllowed")=$G(SDDATA(44,SDCLNIEN_",",20,"E")) ;E-CHECKIN ALLOWED
 S SDCLNSREC("Clinic","PreCheckinAllowed")=$G(SDDATA(44,SDCLNIEN_",",21,"E")) ;PRE-CHECKIN ALLOWED NO
 S SDCLNSREC("Clinic","LengthOfAppt")=$G(SDDATA(44,SDCLNIEN_",",1912,"E")) ;LENGTH OF APP'T
 S SDCLNSREC("Clinic","VariableApptLength")=$G(SDDATA(44,SDCLNIEN_",",1913,"E")) ;VARIABLE APP'NTMENT LENGTH
 S SDCLNSREC("Clinic","IncrementsPerHr")=$G(SDDATA(44,SDCLNIEN_",",1917,"E")) ;DISPLAY INCREMENTS PER HOUR
 ; Special Instructions Multiple
 S SDX="",SDC=0
 S SDFIELDS="1910*"
 K SDDATA,SDMSG
 D GETS^DIQ(44,SDCLNIEN_",",SDFIELDS,"E","SDDATA","SDMSG")
 F  S SDX=$O(SDDATA(44.03,SDX)) Q:SDX=""  D
 . S SDC=SDC+1
 . S SDCLNSREC("Clinic","Special Instructions "_SDC)=$G(SDDATA(44.03,SDX,.01,"E"))
 ; Providers Multiple
 S SDX="",SDC=0
 S SDFIELDS="2600*"
 K SDDATA,SDMSG
 D GETS^DIQ(44,SDCLNIEN_",",SDFIELDS,"E","SDDATA","SDMSG")
 F  S SDX=$O(SDDATA(44.1,SDX)) Q:SDX=""  D
 . S SDC=SDC+1
 . S SDCLNSREC("Clinic","Provider",SDC,"Name")=$G(SDDATA(44.1,SDX,.01,"E"))
 . S SDCLNSREC("Clinic","Provider",SDC,"DefaultForClinic")=$G(SDDATA(44.1,SDX,.02,"E"))
 ; Diagnosis Multiple
 S SDX="",SDC=0
 S SDFIELDS="2700*"
 K SDDATA,SDMSG
 D GETS^DIQ(44,SDCLNIEN_",",SDFIELDS,"E","SDDATA","SDMSG")
 F  S SDX=$O(SDDATA(44.11,SDX)) Q:SDX=""  D
 . S SDC=SDC+1
 . S SDCLNSREC("Clinic","Diagnosis",SDC,"Code")=$G(SDDATA(44.11,SDX,.01,"E"))
 . S SDCLNSREC("Clinic","Diagnosis",SDC,"DefaultForClinic")=$G(SDDATA(44.11,SDX,.02,"E"))
 I '$D(SDCLNSREC("Clinic")) S SDCLNSREC("Clinic")=""
 I SDECI=0 D
 . ;create error message - No Clinic found that match Clinic IEN
 . D ERRLOG^SDESJSON(.SDCLNSREC,19)
 . S ERRPOP=1
 Q
 ;
