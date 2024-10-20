KMPVCCFG ;SP/JML - VSM configuration functions -- APIs for data access ;11/1/2023
 ;;4.0;CAPACITY MANAGEMENT;**1,2,4**;3/1/2018;Build 36
 ;
 ; Integration Agreements
 ;  Reference to GETENV^%ZOSV supported by ICR #10097
 ;  Reference to $$SITE^VASITE supported by ICR #10112
 ;
CFGARR(KMPVMKEY,KMPVCFG,KMPVFLAG) ; Return configuration by monitor in array
 ; to be deprecated
 K KMPVCFG S U="^"
 N KMPVIEN,KMPV0,KMPV1,KMPV2,KMPV3,KMPV4
 I $D(^KMPV(8969,"B",KMPVMKEY)) S KMPVIEN=$O(^KMPV(8969,"B",KMPVMKEY,""))
 Q:$G(KMPVIEN)=""
 S KMPV0=$G(^KMPV(8969,KMPVIEN,0)),KMPV1=$G(^KMPV(8969,KMPVIEN,1))
 S KMPV2=$G(^KMPV(8969,KMPVIEN,2)),KMPV3=$G(^KMPV(8969,KMPVIEN,3)),KMPV4=$G(^KMPV(8969,KMPVIEN,4))
 S KMPVCFG("ONOFF")=$$GETVAL(KMPVMKEY,"ONOFF",8969,$G(KMPVFLAG)),KMPVCFG("VERSION")=$P(KMPV0,U,4)
 S KMPVCFG("VERSION INSTALL DATE")=$P(KMPV0,U,5),KMPVCFG("DAYS TO KEEP DATA")=$P(KMPV1,U)
 S KMPVCFG("COLLECTION INTERVAL")=$P(KMPV1,U,2),KMPVCFG("CACHE DAILY TASK")=$P(KMPV1,U,3)
 S KMPVCFG("ALLOW TEST SYSTEM")=$$GETVAL(KMPVMKEY,"ALLOW TEST SYSTEM",8969,$G(KMPVFLAG)),KMPVCFG("HTTP REQUEST MAX LENGTH")=$P(KMPV1,U,5)
 S KMPVCFG("MONITOR START DELAY")=$P(KMPV1,U,6),KMPVCFG("TASKMAN OPTION")=$P(KMPV1,U,7)
 S KMPVCFG("ENCRYPT")=$P(KMPV1,U,9)
 S KMPVCFG("LAST START TIME")=$P(KMPV2,U),KMPVCFG("LAST STOP TIME")=$P(KMPV2,U,2)
 S KMPVCFG("LAST RUN TIME")=$P(KMPV2,U,3),KMPVCFG("NATIONAL DATA EMAIL ADDRESS")=$P(KMPV3,U)
 S KMPVCFG("NATIONAL SUPPORT EMAIL ADDRESS")=$P(KMPV3,U,2)
 S KMPVCFG("VSM CFG EMAIL ADDRESS")=$P(KMPV3,U,3),KMPVCFG("LOCAL SUPPORT EMAIL ADDRESS")=$P(KMPV3,U,4)
 S KMPVCFG("NATIONAL IP ADDRESS")=$P(KMPV4,U,1),KMPVCFG("NATIONAL FQDN")=$P(KMPV4,U,2)
 S KMPVCFG("NATIONAL PORT")=$P(KMPV4,U,3),KMPVCFG("APIKEY")=$P(KMPV4,U,4)
 Q
 ;
GETDEF(KMPVMKEY,KMPVDEF,KMPVFLAG) ; Return default configuration in array
 ; to be deprecated - fields have changed
 K KMPVDEF S U="^"
 N KMPVIEN,KMPV0,KMPV1
 I $D(^KMPV(8969.02,"B",KMPVMKEY)) S KMPVIEN=$O(^KMPV(8969.02,"B",KMPVMKEY,""))
 Q:$G(KMPVIEN)=""
 S KMPV0=$G(^KMPV(8969.02,KMPVIEN,0)),KMPV1=$G(^KMPV(8969.02,KMPVIEN,1))
 S KMPV2=$G(^KMPV(8969.02,KMPVIEN,2))
 W KMPV0
 S KMPVDEF("DAYS TO KEEP DATA")=$P(KMPV0,U,2),KMPVDEF("COLLECTION INTERVAL")=$P(KMPV0,U,3)
 S KMPVDEF("CACHE DAILY TASK")=$P(KMPV0,U,4),KMPVDEF("ALLOW TEST SYSTEM")=$P(KMPV0,U,5)
 S KMPVDEF("TASKMAN SCHEDULE FREQUENCY")=$P(KMPV0,U,6),KMPVDEF("TASKMAN SCHEDULE START")=$P(KMPV0,U,7)
 S KMPVDEF("TASKMAN OPTION")=$P(KMPV0,U,8),KMPVDEF("START PERFMON")=$P(KMPV0,U,9)
 S KMPVDEF("ENCRYPT")=$P(KMPV0,U,10),KMPVDEF("NATIONAL DATA EMAIL ADDRESS")=$P(KMPV1,U)
 S KMPVDEF("NATIONAL SUPPORT EMAIL ADDRESS")=$P(KMPV1,U,2),KMPVDEF("VSM CFG EMAIL ADDRESS")=$P(KMPV1,U,3)
 S KMPVDEF("NATIONAL IP ADDRESS")=$P(KMPV2,U,1),KMPVDEF("NATIONAL FQDN")=$P(KMPV2,U,2)
 S KMPVDEF("NATIONAL PORT")=$P(KMPV2,U,3),KMPVDEF("APIKEY")=$P(KMPV2,U,4)
 Q
 ;
CFGSTR(KMPVMKEY,KMPVFLAG) ; Return configuration in "^" delimited string
 S U="^"
 N KMPVCFG,KMPVIEN,KMPRT,KMPV0,KMPV1,KMPV2,KMPV3
 I $D(^KMPV(8969,"B",KMPVMKEY)) S KMPVIEN=$O(^KMPV(8969,"B",KMPVMKEY,""))
 Q:$G(KMPVIEN)="" ""
 S KMPVCFG=""
 S KMPV0=$G(^KMPV(8969,KMPVIEN,0)),KMPV1=$G(^KMPV(8969,KMPVIEN,1))
 S KMPRT=$S($$GETVAL^KMPVCCFG(KMPVMKEY,"VERSION",8969)>2:1,1:0)
 ; MONITOR KEY^ONOFF^VERSION^VERSION INSTALL DATE^DAYS TO KEEP DATA^COLLECTION INTERVAL^HTTP REQUEST MAX LENGTH^MONITOR START DELAY^ALLOW TEST
 ; ^CACHE DAILY TASK^TASKMAN TASK^REALTIME^START PERFMON^ENCRYPT
 S KMPVCFG=KMPVMKEY_U_$$GETVAL(KMPVMKEY,"ONOFF",8969,$G(KMPVFLAG))_U_$P(KMPV0,U,4)_U_$P(KMPV0,U,5)_U_$P(KMPV1,U,1)_U_$P(KMPV1,U,2)_U
 S KMPVCFG=KMPVCFG_$P(KMPV1,U,5)_U_$P(KMPV1,U,6)_U_$$GETVAL(KMPVMKEY,"ALLOW TEST SYSTEM",8969,$G(KMPVFLAG))_U
 S KMPVCFG=KMPVCFG_$P(KMPV1,U,3)_U_$P(KMPV1,U,7)_U_KMPRT_U_$P(KMPV1,U,8)_U_$P(KMPV1,U,9)
 Q KMPVCFG
 ;
GETVAL(KMPVMKEY,KMPVFLD,KMPVFILE,KMPVFLAG) ; retrieve value from VSM CONFIGURATION or VSM MONITOR DEFAULTS files
 N KMPVIEN
 I KMPVFILE=8969,$D(^KMPV(8969,"B",KMPVMKEY)) S KMPVIEN=$O(^KMPV(8969,"B",KMPVMKEY,""))
 I KMPVFILE=8969.02,$D(^KMPV(8969.02,"B",KMPVMKEY)) S KMPVIEN=$O(^KMPV(8969.02,"B",KMPVMKEY,""))
 Q:$G(KMPVIEN)="" ""
 Q $$GET1^DIQ(KMPVFILE,KMPVIEN,KMPVFLD,$G(KMPVFLAG))
 ;
 ; SETTER FUNCTIONS
 ;
SETONE(KMPVMKEY,KMPVFNAM,KMPVNVAL,KMPVERR) ; set a value into the VSM CONFIGURATION file
 K KMPVERR,KMPVEARR
 N FDA,KMPVIEN,KMPVEARR,KMPVOVAL,KMPVSTAT,KMPVUP
 S KMPVSTAT=0,KMPVLOG=+$G(KMPVLOG)
 S KMPVOVAL=$$GETVAL(KMPVMKEY,KMPVFNAM,8969)
 I KMPVOVAL=KMPVNVAL Q KMPVSTAT
 I $D(^KMPV(8969,"B",KMPVMKEY)) S KMPVIEN=$O(^KMPV(8969,"B",KMPVMKEY,""))
 I $G(KMPVIEN)="" S KMPVSTAT="1^MONITOR TYPE NOT CONFIGURED" Q KMPVSTAT
 S KMPVFNUM=$$FLDNUM^DILFD(8969,KMPVFNAM)
 I +KMPVFNUM=0 S KMPVSTAT="1^FIELD NAME '"_KMPVFNAM_"' DOES NOT EXIST" Q KMPVSTAT
 S FDA($J,8969,KMPVIEN_",",KMPVFNUM)=KMPVNVAL
 D FILE^DIE("ET","FDA($J)","KMPVEARR")
 I $D(KMPVEARR) D  Q KMPVSTAT
 .M KMPVERR=KMPVEARR
 .S KMPVSTAT="1^FILING ERROR"
 Q KMPVSTAT
 ;
SETVALS(KMPVMKEY,KMPVFVAL,KMPVERR,KMPVLOG) ; set multiple values into the VSM CONFIGURATION file
 ; KMPVFVAL(FieldName)=FieldValue,  KMPVERR: Output array if errors
 K KMPVERR,KMPVEARR
 N FDA,KMPVDATA,KMPVIEN,KMVEARR,KMPVFNAM,KMPVFNUM,KMPVSTAT
 S KMPVSTAT=0,KMPVLOG=+$G(KMPVLOG)
 I $D(^KMPV(8969,"B",KMPVMKEY)) S KMPVIEN=$O(^KMPV(8969,"B",KMPVMKEY,""))
 I $G(KMPVIEN)="" S KMPVSTAT="1^MONITOR TYPE NOT CONFIGURED" Q KMPVSTAT
 ;  get field numbers and set FDA array
 S KMPVFNAM=""
 F  S KMPVFNAM=$O(KMPVFVAL(KMPVFNAM)) Q:KMPVFNAM=""  D
 .S KMPVFNUM=$$FLDNUM^DILFD(8969,KMPVFNAM)
 .I KMPVFNUM>0 S FDA($J,8969,KMPVIEN_",",KMPVFNUM)=KMPVFVAL(KMPVFNAM)
 .E  S KMPVEARR(KMPVFNAM)=""
 ; If field name does not exist set error array and quit
 I $D(KMPVEARR) D  Q KMPVSTAT
 .S KMPVSTAT="1^FIELD NAME DOES NOT EXIST"
 .M KMPVERR=KMPVEARR
 D FILE^DIE("ET","FDA($J)","KMPVEARR")
 ; If filing errors set error array
 I $D(KMPVEARR) D  Q KMPVSTAT
 .M KMPVERR=KMPVEARR
 .S KMPVSTAT="1^FILING ERROR"
 Q KMPVSTAT
 ;
 ; OTHER FUNCTIONS
 ;
RESTCFG(KMPVMKEY,KMPUSER,KMPVERR) ; Restore default configuration to VSM CONFIGURATION file
 N KMPVSTAT
 D GETDEF(KMPVMKEY,.KMPVDEF)
 S KMPVSTAT=$$SETVALS(KMPVMKEY,.KMPVDEF,.KMPVERR)
 D CFGMSG^KMPUTLW($G(KMPUSER))
 Q KMPVSTAT
 ;
STRSTP(KMPVMKEY,KMPVSTIME) ; Record run time values
 Q:KMPVMKEY=""
 Q:KMPVSTIME=""
 N %,%H,X,KMPVETFM,KMPVFVAL,KMPVSTAT,KMPVSTFM,KMPVTDIFF
 S %H=KMPVSTIME D YMD^%DTC S KMPVSTFM=X_%
 S %H=$H D YMD^%DTC S KMPVETFM=X_%
 S KMPVTDIFF=$$FMDIFF^XLFDT(KMPVETFM,KMPVSTFM,2)
 S KMPVFVAL("LAST START TIME")=KMPVSTFM
 S KMPVFVAL("LAST STOP TIME")=KMPVETFM
 S KMPVFVAL("LAST RUN TIME")=KMPVTDIFF
 S KMPVSTAT=$$SETVALS(KMPVMKEY,.KMPVFVAL,.KMPVEARR,1)
 Q
 ;
SYSCFG() ; Return system configuration values
 Q $$VERSION^%ZOSV(1)_"^"_$$OS^%ZOSV_"^"_$$VERSION^%ZOSV(0)_"^"_$$PROD() ; IA 10097
 ;
MONSTAT(KMPVTEXT) ; Return status information for all configured monitors
 K KMPVTEXT
 N KMPCNT,KMPI,KMPVBGD,KMPVCDAYS,KMPVCOMP,KMPVDDAYS,KMPVDLY,KMPVENT,KMPVI,KMPVML,KMPVMKEY,KMPVOPT,KMPVTASK,Y
 ;
 D MONLIST^KMPVCBG(.KMPVML)
 S KMPVMKEY=""
 F  S KMPVMKEY=$O(KMPVML(KMPVMKEY)) Q:KMPVMKEY=""  D
 .S KMPVTEXT(KMPVMKEY)=KMPVML(KMPVMKEY)
 .D CFGARR(KMPVMKEY,.KMPVCFG)
 .S KMPVTEXT(KMPVMKEY,"ONOFF")=KMPVCFG("ONOFF")
 .S KMPI="",KMPCNT=0
 .F  S KMPI=$O(^KMPTMP("KMPV",KMPVMKEY,"RETRY",KMPI)) Q:KMPI=""  S KMPCNT=KMPCNT+1
 .S KMPVTEXT(KMPVMKEY,"RETRY")=KMPCNT
 .S KMPVTEXT(KMPVMKEY,"VERSION")=$$GETVAL^KMPVCCFG(KMPVMKEY,"VERSION",8969)
 Q
 ;
USERNAME(KMPVDUZ) ; Return users name from DUZ
 N KMPVNAME,KMPVOUT
 ; IA 10060 for lookup into NEW PERSON file
 I +KMPVDUZ'>0 Q ""
 D FIND^DIC(200,"","","A",KMPVDUZ,"","","","","KMPVOUT")
 S KMPVNAME=$G(KMPVOUT("DILIST",1,1))
 Q KMPVNAME
 ;
PROD() ; Return "prod" if production, "test" otherwise
 N KMPVPROD
 S KMPVPROD=$$PROD^XUPROD() ; IA 4440
 S KMPVPROD=$S(KMPVPROD=1:"prod",1:"test")
 Q KMPVPROD
 ;
SITEINFO() ;
 N KMPVDOM,KMPVSINF,KMPVPROD,KMPVSCD,KMPVSITE
 S KMPVPROD=$$PROD^KMPVCCFG()
 S KMPVDOM=$P($$NETNAME^XMXUTIL(.5),"@",2) ;IA 2734
 D NOW^%DTC
 S KMPVSITE=$$SITE^VASITE($P(%,".")) ;IA 10112
 D GETENV^%ZOSV S KMPVSCD=$P(Y,U,1) ;  IA 10097
 S KMPVSINF=$P(KMPVSITE,U,2)_"^"_$P(KMPVSITE,U,3)_"^"_KMPVDOM_"^"_KMPVPROD_"^"_KMPVSCD
 Q KMPVSINF
 ;
SLOT(KMPTIME,KMPSINT,KMPTFORM) ;
 ; NOTE: code in %ZOSVKR similar. All other VSM monitors call here.
 N X,%T,%H,KMPSSEC,KMPSEC,X,KMPSLOT,KMPSTIME
 S KMPSSEC=KMPSINT*60
 I KMPTFORM="HOROLOG" D
 .S KMPSEC=$P(KMPTIME,",",2)
 I KMPTFORM="FILEMAN" D
 .S X=KMPTIME D H^%DTC S KMPSEC=%T
 .I KMPSEC>86399 S KMPSEC=86399
 S KMPSLOT=KMPSEC\KMPSSEC
 S KMPSTIME=KMPSLOT*KMPSSEC
 Q KMPSTIME
 ;
ISBENODE(KMPNODE) ;
 N RET,KMPINST,KMPNTYP
 S RET=0
 Q:$P(KMPNODE,":",2)="" -1
 S KMPINST=$P(KMPNODE,":",2)
 I $E(KMPINST,7,9)="SVR" S RET=1
 Q RET
