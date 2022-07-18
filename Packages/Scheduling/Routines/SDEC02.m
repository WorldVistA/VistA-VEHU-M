SDEC02 ;ALB/SAT,PC - VISTA SCHEDULING RPCS ;Feb 12, 2020@15:22
 ;;5.3;Scheduling;**627,642,658,672,722,694**;Aug 13, 1993;Build 61
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;  ICR
 ;  ---
 ;  10035 - #2
 ;  10061 - DEM^VADPT
 ;
 Q
 ;
CRSCHED(SDECY,SDECRES,SDECSTART,SDECEND,SDECWKIN,MAXREC,LASTSUB) ;Create Resource Appointment Schedule   ;alb/sat 672
 ;CRSCHED(SDECY,SDECRES,SDECSTART,SDECEND,SDECWKIN)  external parameter tag is in SDEC
 ;Create Resource Appointment Schedule recordset
 ;On error, returns 0 in APPOINTMENTID field and error text in NOTE field
 ;
 ;$O Thru ^SDEC(409.84,"ARSRC", RESOURCE, STARTTIME, APPTID)
 ;SDECRES   - pipe | delimited list of resource names
 ;SDECSTART - Start date/time in external form
 ;SDECEND   - End Date/time in external form
 ;SDECWKIN  - Include Walk-ins 1=return walkins; 0=skip walk-ins
 ;9-27-2004 Added walkin to returned datatable
 ;TODO: Change SDECRES from names to IDs
 ;RETURN:
 ;  Global Array in which each array entry contains data for the Resource Appointment Schedule separated by ^:
 ; 1. APPOINTMENTID
 ; 2. START_TIME
 ; 3. END_TIME
 ; 4. CHECKIN
 ; 5. AUXTIME
 ; 6. PATIENTID
 ; 7. PATIENTNAME
 ; 8. RESOURCENAME
 ; 9. NOSHOW
 ;10. HRN
 ;11. ACCESSTYPEID
 ;12. WALKIN
 ;13. CHECKOUT
 ;14. VPROVIDER
 ;15. CANCELLED
 ;16. NOTE
 ;17. DAPTDT
 ;18. APPTREQTYPE
 ;19. DIEDON
 ;20. EESTAT - Patient Status  N=NEW  E=ESTABLISHED
 ;21. MULT   - data from MULT APPTS MADE field of SDEC APPT REQUEST separated by pipe   ;alb/sat 642
 ;             each pipe piece contains the following ~ pieces:
 ;             1. MULT APPTS MADE - pointer to SDEC APPOINTMENT
 ;             2. PARENT REQUEST  - pointer to SDEC APPT REQUEST
 ;22. SDPARENT - PARENT REQUEST from SDEC APPT REQUEST. Pointer to SDEC APPT REQUEST.   ;alb/sat 642
 ;
 N SDECERR,SDECIEN,SDECDEPD,SDECDEPN,SDECRESD,SDECI,SDECJ,SDECRESN,SDECS,SDECAD,SDECZ,SDECQ,SDECNOD,SDECTMP
 N SDECPAT,SDECNOT,SDECZPCD,SDECPCD,SDDDT,SDAPTYP
 N SDCNT,SDI   ;alb/sat 672
 N %DT,X,Y
 K ^TMP("SDEC02",$J)
 S SDECERR=""
 S SDCNT=0     ;alb/sat 672
 S SDECY="^TMP(""SDEC02"","_$J_")"
 ;                1                   2                3              4             5             6
 S SDECTMP="I00020APPOINTMENTID^D00030START_TIME^D00030END_TIME^D00030CHECKIN^D00030AUXTIME^I00020PATIENTID^"
 ;                        7                 8                  9            10        11                 12
 S SDECTMP=SDECTMP_"T00030PATIENTNAME^T00030RESOURCENAME^I00005NOSHOW^T00020HRN^I00005ACCESSTYPEID^I00005WALKIN^"
 ;                        13             14              15              16         17           18
 S SDECTMP=SDECTMP_"D00030CHECKOUT^I00020VPROVIDER^T00020CANCELLED^T00250NOTE^T00030DAPTDT^T00030APPTREQTYPE^"
 ;alb/sat 642 added MULT and SDPARENT  ;alb/sat 672 added SLAST,SSN,DOB,SENSITIVE
 S SDECTMP=SDECTMP_"T00030DIEDON^T00030EESTAT^T00250MULT^T00030SDPARENT^T00050SDLAST^T00030SSN^T00030DOB^T00100SENSITIVE"
 S ^TMP("SDEC02",$J,0)=SDECTMP_$C(30)
 ;
 ;
 ;  Change date/time conversion so midnight is handled properly.  wtc 694 4/24/18
 ;
 ;S:SDECSTART["@0000" SDECSTART=$P(SDECSTART,"@")
 ;S:SDECEND["@0000" SDECEND=$P(SDECEND,"@")
 ;S %DT="T",X=SDECSTART D ^%DT S SDECSTART=Y
 S SDECSTART=$$NETTOFM^SDECDATE(SDECSTART,"N") ;
 I SDECSTART=-1 S ^TMP("SDEC02",$J,0)=^TMP("SDEC02",$J,0)_$C(31) Q
 ; need to set the start date back to midnight if no time is sent to us from VSE
 I $P(SDECSTART,".",2)="" S SDECSTART=$$FMADD^XLFDT(SDECSTART,-1)_".24"   ;pwc *694  1/13/2020
 ;S %DT="T",X=SDECEND D ^%DT S SDECEND=Y
 S SDECEND=$$NETTOFM^SDECDATE(SDECEND,"Y") ;
 I SDECEND=-1 S ^TMP("SDEC02",$J,0)=^TMP("SDEC02",$J,0)_$C(31) Q
 S MAXREC=$G(MAXREC) S:'MAXREC MAXREC=9999999   ;alb/sat 672
 S LASTSUB=$G(LASTSUB)   ;alb/sat 672
 ;
 S SDECI=0
 D STRES
 ;
 S ^TMP("SDEC02",$J,SDECI)=^TMP("SDEC02",$J,SDECI)_$C(31)
 Q
 ;
STRES ;
 S SDI=$S($P(LASTSUB,"|",1)'="":$P(LASTSUB,"|",1),1:1)   ;alb/sat 672
 N SDECRESA,SDECRSND,SDECRST,SDCL,NEWRES,SDRSLTS ;*zeb+34 722 1/17/19 include appts for resources that share clinics
 I SDECRES["|" D  I 1
 . S SDECRESA=SDECRES
 E  D
 . S SDECRESA="|"_SDECRES_"|"
 . I '+SDECRES Q:'$D(^SDEC(409.831,"B",SDECRES))
 . I '+SDECRES S SDECRES=$O(^SDEC(409.831,"B",SDECRES,0))
 . S SDECRSND=$G(^SDEC(409.831,SDECRES,0))
 . S SDECRST=$P($P(SDECRSND,U,11),";",2)
 . I SDECRST'="SC(" D  Q
 . . S SDECRESA=SDECRESA_"|"_SDECRES
 . S SDCL=$P(SDECRSND,U,4)
 . S NEWRES=""
 . F  S NEWRES=$O(^SDEC(409.831,"ALOC",SDCL,NEWRES)) Q:NEWRES=""  D
 . . Q:NEWRES=SDECRES
 . . S SDECRESA=SDECRESA_"|"_NEWRES_U_$P(^SDEC(409.831,SDECRES,0),U,1)
 F SDECJ=1:1:$L(SDECRESA,"|") S SDECRESN=$P(SDECRESA,"|",SDECJ) D
 . Q:SDECRESN=""
 . S SDECOVR=""
 . I SDECRESN[U S SDECOVR=$P(SDECRESN,U,2),SDECRESD=$P(SDECRESN,U,1)
 . E  S SDECRESD=SDECRESN
 . ;I +SDECRESN Q:'$D(^SDEC(409.831,+SDECRESN,0))
 . ;I +SDECRESN S SDECRESD=SDECRESN
 . ;I '+SDECRESN Q:'$D(^SDEC(409.831,"B",SDECRESN))
 . ;I '+SDECRESN S SDECRESD=$O(^SDEC(409.831,"B",SDECRESN,0))
 . ;Q:'+SDECRESD
 . S SDECRESN=$P($G(^SDEC(409.831,SDECRESD,0)),U,1)
 . ;Q:'$D(^SDEC(409.84,"ARSRC",SDECRESD))
 . S SDECS=$S($P(LASTSUB,"|",2):$P(LASTSUB,"|",2),1:SDECSTART)-.0001   ;alb/sat 672
 . F  S SDECS=$O(^SDEC(409.84,"ARSRC",SDECRESD,SDECS)) Q:'+SDECS  Q:SDECS>SDECEND  D  Q:SDCNT'<MAXREC   ;alb/sat 672
 . . S SDECAD=$S($P(LASTSUB,"|",3)'="":$P(LASTSUB,"|",3),1:0)   ;alb/sat 672
 . . S LASTSUB=""   ;alb/sat 672
 . . ;alb/sat 672
 . . S:SDECOVR="" SDECOVR=SDECRESN ;*zeb+1 722 1/17/19 allow override of name for resources in same clinic
 . . F  S SDECAD=$O(^SDEC(409.84,"ARSRC",SDECRESD,SDECS,SDECAD)) Q:'+SDECAD  D:'$D(SDRSLTS(SDECAD)) STCOMM(SDECAD,SDECOVR,SDECRESD) S SDRSLTS(SDECAD)=1 Q:SDCNT'<MAXREC
 Q
 ;
STCOMM(SDECAD,SDECRESN,SDRES)      ;
 ;SDECAD is the sdec appointment IEN
 N CHECKIN,SDECC,SDECCAN,SDECCO,SDECQ,SDECZ,SDECSUBC,SDECHRN,SDECPATD,SDECATID,SDECISWK
 N DIEDON,SDECVPRV
 N SDDEMO,SDSENS,SDTMP   ;alb/sat 672
 S SDTMP=""   ;alb/sat 672
 Q:'$D(^SDEC(409.84,SDECAD,0))
 S SDECNOD=^SDEC(409.84,SDECAD,0)
 S SDECCAN=($P(SDECNOD,U,12)]"")  ;CANCELLED flag  1=cancelled; 0=not cancelled
 S SDECISWK=0
 S:$P(SDECNOD,U,13)="y" SDECISWK=1
 I +$G(SDECWKIN) Q:SDECISWK  ;Don't return walkins if appt is WALKIN and SDECWKIN is 1
 S SDECCO=$TR($$FMTE^XLFDT($P(SDECNOD,U,14)),"@"," ") ;APPOINTMENT CHECKOUT TIME
 S SDECVPRV=$P(SDECNOD,U,16) ;POINTER TO V PROVIDER TABLE ^AUPNVPRV
 S SDECZ=SDECAD_"^"
 F SDECQ=1:1:4 D
 . S Y=$P(SDECNOD,U,SDECQ)
 . ;
 . ;  Change date/time conversion so midnight is handled properly.  wtc 694 4/24/18
 . ;
 . ;X ^DD("DD") S Y=$TR(Y,"@"," ")
 . S Y=$$FMTONET^SDECDATE(Y,"Y") ;
 . S Y=$TR(Y,"@"," ")   ;remove the @ and replace with a space between date/time  pwc *694  1/13/2020
 . S SDECZ=SDECZ_Y_"^"
 S SDECPATD=$P(SDECNOD,U,5)
 D PDEMO^SDECU3(.SDDEMO,SDECPATD)
 I $P(SDECZ,U,4)="" S CHECKIN=$$CHECKIN(SDRES,$P(SDECNOD,U,1),SDECPATD,SDECAD) S:CHECKIN'="" $P(SDECZ,U,4)=$P(CHECKIN,U,1),$P(SDECZ,U,5)=$P(CHECKIN,U,2)   ;if no checkin, check appointment checkin
 S $P(SDECZ,"^",6)=SDECPATD ;PATIENT ID
 S SDECPAT=""
 I SDECPATD]"",$D(^DPT(SDECPATD,0)) S SDECPAT=$P(^DPT(SDECPATD,0),U)
 S $P(SDECZ,"^",7)=SDECPAT ;PATIENT NAME
 S $P(SDECZ,"^",8)=SDECRESN ;RESOURCENAME
 S $P(SDECZ,"^",9)=+$P(SDECNOD,U,10) ;NOSHOW
 S SDECHRN=""
 I $D(DUZ(2)),DUZ(2)>0 S SDECHRN=$P($G(^AUPNPAT(SDECPATD,41,DUZ(2),0)),U,2) ;HRN
 S $P(SDECZ,"^",10)=SDECHRN
 S SDECATID=$P(SDECNOD,U,6)
 S:'+SDECATID SDECATID=0 ;UNKNOWN TYPE
 S $P(SDECZ,"^",11)=SDECATID
 S $P(SDECZ,"^",12)=SDECISWK
 S $P(SDECZ,"^",13)=SDECCO  ;CHECKOUT TIME
 S $P(SDECZ,"^",14)=SDECVPRV  ;POINTER TO NEW PERSON
 S $P(SDECZ,"^",15)=SDECCAN   ;CANCELLED
 ;NOTE  [16]
 S SDECNOT="",SDECQ=0 F  S SDECQ=$O(^SDEC(409.84,SDECAD,1,SDECQ)) Q:'+SDECQ  D
 . S SDECNOT=$G(^SDEC(409.84,SDECAD,1,SDECQ,0))
 . S:$E(SDECNOT,$L(SDECNOT)-1,$L(SDECNOT))'=" " SDECNOT=SDECNOT_" "
 . S SDTMP=SDTMP_$S(SDTMP'="":" ",1:"")_$TR(SDECNOT,"^"," ")   ;alb/sat 672
 . ;S SDECI=SDECI+1  ;alb/sat 672 - removed
 . ;S ^TMP("SDEC02",$J,SDECI)=$TR(SDECNOT,"^"," ")  ;alb/sat 658   ;alb/sat 672 - removed
 ;S ^TMP("SDEC02",$J,SDECI)=^TMP("SDEC02",$J,SDECI)_"^"   ;alb/sat 672 - replaced
 S $P(SDECZ,"^",16)=SDTMP   ;alb/sat 672
 ;additional data
 ;S SDECZ=""   ;alb/sat 672 - removed
 S $P(SDECZ,"^",17)=$S($P(SDECNOD,U,20)'="":$$FMTE^XLFDT($P(SDECNOD,U,20)),1:"")   ;alb/sat 672
 ;appt request type
 S SDAPTYP=$P($G(^SDEC(409.84,SDECAD,2)),U,1)
 S:SDAPTYP'="" SDAPTYP=$S($P(SDAPTYP,";",2)["SDWL":"E",$P(SDAPTYP,";",2)["GMR":"C",$P(SDAPTYP,";",2)="SD(403.5,":"R",$P(SDAPTYP,";",2)="SDEC(409.85,":"A",1:"")_"|"_$P(SDAPTYP,";",1)
 S $P(SDECZ,"^",18)=SDAPTYP  ;[18]  ;alb/sat 672
 S DIEDON="" D DIEDON^ORWPT(.DIEDON,SDECPATD)
 S $P(SDECZ,"^",19)=DIEDON  ;[19]  ;alb/sat 672
 S $P(SDECZ,"^",20)=$$GET1^DIQ(409.84,SDECAD_",",.23,"E")  ;[20]  ;alb/sat 672
 I $P(SDAPTYP,"|",1)="A" S $P(SDECZ,"^",21)=$$MULT(SDAPTYP)   ;[21] [22]  alb/sat 642  ;alb/sat 672
 I $P(SDAPTYP,"|",1)="A" S $P(SDECZ,"^",22)=$$GET1^DIQ(409.85,$P(SDAPTYP,"|",2)_",",43.8,"I")  ;[21] [22]  alb/sat 642  ;alb/sat 672
 S $P(SDECZ,"^",24)=$G(SDDEMO("SSN"))  ;[24]   ;alb/sat 672 - added
 S $P(SDECZ,"^",25)=$G(SDDEMO("DOB"))  ;[25]   ;alb/sat 672 - added
 S SDSENS=$$PTSEC^SDECUTL(SDECPATD) S $P(SDECZ,"^",26)=SDSENS  ;[26]  ;alb/sat 672 - added
 S SDCNT=SDCNT+1 I SDCNT'<MAXREC S $P(SDECZ,"^",23)=SDECJ_"|"_SDECS_"|"_SDECAD   ;[23] ;alb/sat 672 - last subscript on last rec
 S SDECI=SDECI+1 S ^TMP("SDEC02",$J,SDECI)=SDECZ_$C(30)  ;alb/sat 672
 Q
CHECKIN(SDRES,SDT,DFN,APPT)  ;alb/sat 642 - if no checkin, check appointment checkin
 ; SDRES    - resource id
 ; SDT      - appointment date/time in external format
 ; DFN - patient ID
 N CHECKIN,ENTERED,SDCL,SDFDA,SDI,SDNOD,Y
 S (CHECKIN,ENTERED)=""
 S SDCL=$$GET1^DIQ(409.831,SDRES_",",.04,"I")
 S SDI=0 F  S SDI=$O(^SC(SDCL,"S",SDT,1,SDI)) Q:SDI'>0  D  Q:CHECKIN'=""
 .S SDNOD=$G(^SC(SDCL,"S",SDT,1,SDI,0))
 .Q:$P(SDNOD,U,1)'=DFN
 .I $D(^SC(SDCL,"S",SDT,1,SDI,"C")) D
 ..S CHECKIN=$P($G(^SC(SDCL,"S",SDT,1,SDI,"C")),U,1)
 ..S ENTERED=$P($G(^SC(SDCL,"S",SDT,1,SDI,"C")),U,5)
 ..S:CHECKIN'="" SDFDA(409.84,APPT_",",.03)=CHECKIN
 ..S:ENTERED'="" SDFDA(409.84,APPT_",",.04)=ENTERED
 ..D:$D(SDFDA) UPDATE^DIE("","SDFDA")
 .. S Y=CHECKIN
 .. ;
 .. ;  Change date/time conversion so midnight is handled properly.  wtc 694 4/24/18
 .. ;
 .. ;X ^DD("DD") S CHECKIN=$TR(Y,"@"," ")
 .. S CHECKIN=$$FMTONET^SDECDATE(CHECKIN,"Y") ;
 .. ;S Y=ENTERED
 .. ;X ^DD("DD") S ENTERED=$TR(Y,"@"," ")
 .. S ENTERED=$$FMTONET^SDECDATE(ENTERED,"Y") ;
 Q CHECKIN_U_ENTERED
MULT(SDAPTYP)  ;get data from MULT APPTS MADE field of SDEC APPT REQUEST file   ;alb/sat 642
 N ARIEN,SDI,MULT1,MULTL
 S MULTL=""
 S ARIEN=$P(SDAPTYP,"|",2)
 S SDI=0 F  S SDI=$O(^SDEC(409.85,ARIEN,2,SDI)) Q:SDI'>0  D
 .S MULT1=$P($G(^SDEC(409.85,ARIEN,2,SDI,0)),"^",1)
 .S MULTL=$S(MULTL'="":MULTL_"|",1:"")_MULT1
 Q MULTL
 ;
ERR(SDECI,SDECERR) ;Error processing
 S SDECI=SDECI+1
 S ^TMP("SDEC02",$J,SDECI)="0^^^^^^^^^^^"_SDECERR_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC02",$J,SDECI)=$C(31)
 Q
 ;
ETRAP ;EP Error trap entry
 D ^%ZTER
 I '$D(SDECI) N SDECI S SDECI=999999
 S SDECI=SDECI+1
 D ERR(SDECI,"SDEC31 Error")
 Q
