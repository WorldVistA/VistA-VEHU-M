SDEC05 ;ALB/SAT,WTC - VISTA SCHEDULING RPCS ;Feb 12, 2020@15:22
 ;;5.3;Scheduling;**627,694**;Aug 13, 1993;Build 61
 ;
 Q
 ;
 ;
APBLKOV(SDECY,SDECSTART,SDECEND,SDECRES,SDECWI) ;APPT BLOCKS OVERLAP
 ;APBLKOV(SDECY,SDECSTART,SDECEND,SDECRES,SDECWI)  external parameter tag is in SDEC
 ;SDECRES is resource name
 ;SDECWI is for walk-in appointments. 1 - Include walkins, otherwise do not include them.
 ;
 N SDECERR,SDECIEN,SDECDEP,SDECBS,SDECI,SDECNEND,SDECNSTART,SDECPEND,SDECRESD,SDECRESN,SDECS,SDECAD,SDECNOD,SDECPAT
 N %DT,X,Y
 K ^TMP("SDEC",$J)
 S SDECERR=""
 S SDECY="^TMP(""SDEC"","_$J_")",SDECI=0
 S ^TMP("SDEC",$J,SDECI)="D00030START_TIME^D00030END_TIME^I00010PAT_ID^T00030APPTREQTYPE"_$C(30)
 D
 . S SDECBS=0
 . ;
 . ;  Change date/time conversion so midnight is handled properly.  wtc 694 4/24/18
 . ;
 . ;S:SDECSTART["@0000" SDECSTART=$P(SDECSTART,"@")
 . ;S:SDECEND["@0000" SDECEND=$P(SDECEND,"@")
 . ;S %DT="T",X=SDECSTART D ^%DT S SDECSTART=Y
 . S SDECSTART=$$NETTOFM^SDECDATE(SDECSTART,"Y","N") ;
 . I SDECSTART=-1 S ^TMP("SDEC",$J,1)=$C(31) Q
 . ;S %DT="T",X=SDECEND D ^%DT S SDECEND=Y
 . S SDECEND=$$NETTOFM^SDECDATE(SDECEND,"Y","N") ;
 . I SDECEND=-1 S ^TMP("SDEC",$J,1)=$C(31) Q
 . I $L(SDECEND,".")=1 S SDECEND=SDECEND+.9999 ;Go to end of day
 . S SDECRESN=SDECRES
 . Q:SDECRESN=""
 . Q:'$D(^SDEC(409.831,"B",SDECRESN))
 . S SDECRESD=$O(^SDEC(409.831,"B",SDECRESN,0))
 . Q:'+SDECRESD
 . Q:'$D(^SDEC(409.84,"ARSRC",SDECRESD))
 . D STRES(SDECRESD,SDECSTART,SDECEND,$G(SDECWI))
 . Q
 ;
 S ^TMP("SDEC",$J,$G(SDECI,0))=^TMP("SDEC",$J,$G(SDECI,0))_$C(31)
 Q
 ;
APBLKALL(SDECY,SDECSTART,SDECEND) ;List of all appointments for all resources
 ;APBLKALL(SDECY,SDECSTART,SDECEND)  external parameter tag is in SDEC
 ; Input:  SDECSTART - Start Date
 ;         SDECEND   - End Date
 ;
 N SDECDATA,SDECRIEN,SDECRESN,SDECI
 S SDECRIEN=0 F  S SDECRIEN=$O(^SDEC(409.831,SDECRIEN)) Q:'SDECRIEN  D
 .S SDECRESN=$$GET1^DIQ(409.831,SDECRIEN,.01,"E")
 .Q:SDECRESN=""
 .; Call existing API to gather appointments for each resource found
 .K SDECDATA
 .D APBLKOV^SDEC(.SDECDATA,$G(SDECSTART),$G(SDECEND),$G(SDECRESN),1) ;Call tag in ^SDEC
 .D GATHER(SDECDATA,SDECRESN)
 .K ^TMP("SDEC",$J)
 M ^TMP("SDEC",$J)=^TMP("SDEC05",$J)
 K ^TMP("SDEC05",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="D00030START_TIME^D00030END_TIME^I00010PAT_ID^T00030RES_NAME^T00030APPTREQTYPE"_$C(30)
 S SDECI=$O(^TMP("SDEC",$J,""),-1)
 S ^TMP("SDEC",$J,SDECI)=^TMP("SDEC",$J,SDECI)_$C(31)
 Q
 ;
GATHER(SDECDAT,SDECRESN) ;
 ; Called by APBLKBR to retrieve data gathered for each resource.
 N X,SDECADAT,SDECI
 S X=0 F  S X=$O(@SDECDAT@(X)) Q:'X  D
 .S SDECADAT=$G(@SDECDAT@(X)) Q:SDECADAT=$C(31)
 .S SDECI=$O(^TMP("SDEC05",$J,""),-1) S SDECI=$G(SDECI)+1
 .S SDECADAT=$P(SDECADAT,$C(30),1)
 .S ^TMP("SDEC05",$J,SDECI)=$P(SDECADAT,U,1,3)_U_SDECRESN_U_$P(SDECADAT,U,4)_$C(30)
 Q
 ;
STRES(SDECRESD,SDECSTART,SDECEND,SDECWI) ;
 ;$O THRU "ARSRC" XREF OF ^SDEC(409.84,
 ;Start at the beginning of the day -- appts can't overlap days
 S SDECS=$P(SDECSTART,"."),SDECS=SDECS-.0001
 F  S SDECS=$O(^SDEC(409.84,"ARSRC",SDECRESD,SDECS)) Q:'+SDECS  Q:SDECS>SDECEND  D
 . S SDECAD=0 F  S SDECAD=$O(^SDEC(409.84,"ARSRC",SDECRESD,SDECS,SDECAD)) Q:'+SDECAD  D STCOMM(SDECAD,$G(SDECWI)) ;SDECAD Is the AppointmentID
 . Q
 Q
 ;
STCOMM(SDECAD,SDECWI) ;
 N SDAPTYP
 S SDECNEND=0,SDECNSTART=0,SDECPEND=0
 Q:'$D(^SDEC(409.84,SDECAD,0))
 S SDECNOD=^SDEC(409.84,SDECAD,0)
 S SDECPAT=$P(SDECNOD,U,5)
 Q:$P(SDECNOD,U,10)=1  ;NO-SHOW Flag
 Q:$P(SDECNOD,U,12)]""  ;CANCELLED APPT
 I '$G(SDECWI) Q:$P(SDECNOD,U,13)="y"  ;WALKIN
 S SDECNSTART=$P(SDECNOD,U)
 S SDECNEND=$P(SDECNOD,U,2)
 I SDECNEND'>SDECSTART Q  ;End is less than start
 ;
 ;  Change date/time conversion so midnight is handled properly.  wtc 694 4/24/18
 ;
 ;S Y=SDECNSTART X ^DD("DD") S SDECNSTART=$TR(Y,"@"," ")
 S SDECNSTART=$$FMTONET^SDECDATE(SDECNSTART,"Y") ;
 ;S Y=SDECNEND X ^DD("DD") S SDECNEND=$TR(Y,"@"," ")
 S SDECNEND=$$FMTONET^SDECDATE(SDECNEND,"Y") ;
 ;appt request type
 S SDAPTYP=$P($G(^SDEC(409.84,SDECAD,2)),U,1)
 S:SDAPTYP'="" SDAPTYP=$S($P(SDAPTYP,";",2)["SDWL":"E",$P(SDAPTYP,";",2)["GMR":"C",$P(SDAPTYP,";",2)="SD(403.5,":"R",1:"")_"|"_$P(SDAPTYP,";",1)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECNSTART_U_SDECNEND_U_SDECPAT_U_SDAPTYP_$C(30)
 Q
