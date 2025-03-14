MBAARPC4 ;OIT-PD/RB - Scheduling RPCs;08/27/2014
 ;;1.0;Scheduling Calendar View;;Aug 27, 2014;Build 52
 ;This routine has multiple RPCs created to support the mobile order entry apps
 ;Associated ICRs:
 ;  ICR#
 ;  10103 XLFDT
 ;  6052 GMR(123
 ;  6053 VA(200
 ;  2739 GMR(123
 ;  6063 MBAA RPC REGISTRATION
 ;  2638 ORD(101.01 
 ;
CSLTNP(ORY,ORSDT,OREDT,ORSERV,ORSTATUS,ORPROV)  ;List consults without patient context MBAA RPC: MBAA NO PATIENT CSLT LOOKUP
 ; ORY:      RETURN ARRAY
 ; ORSDT:    START DATE - Optional CYYMMDD, Default = Today - 90 days
 ; OREDT:    END DATE - Optional CYYMMDD, Default to current date.time (NOW)
 ; ORSERV:   CONSULTING SERVICE IEN
 ;             Optional if ORDERING (SENDING) PROVIDER DUZ
 ;             Otherwise required
 ; ORSTATUS: CONSULT STATUS IEN (Required)
 ; ORPROV:   ORDERING (SENDING)PROVIDER DUZ - Optional
 ;
 N ARRAY,DIFF,I,J,ORLOC,ORSRV,S,S1,SEQ,SITE,STATUS
 S J=1,SEQ=""
 S:'$L($G(ORSDT)) ORSDT=$$HTFM^XLFDT(+$H-90)  ;ICR#: 10103 XLFDT
 S:'$L($G(OREDT)) OREDT=""
 S:'$L($G(ORPROV)) ORPROV=""
 K ^TMP("MBAACR",$J)
 S ORY=$NA(^TMP("MBAACN",$J,"CS"))
 I 'ORPROV,('$L($G(ORSERV))!(+$G(ORSERV)=0)) S @ORY@(1)="0^Service not selected" G END  ; Error Condition
 I '$L($G(ORSTATUS)) S @ORY@(1)="0^Status not selected" G END  ; Error Condition
 S STATUS=""
 F S=1:1 S S1=$P(ORSTATUS,",",S) Q:S1=""  S STATUS(S1)=""
 D LOOKUP
END ; MBAA RPC: MBAA NO PATIENT CSLT LOOKUP
 M @ORY=^TMP("MBAACR",$J,"CS")
 K ^TMP("MBAACN",$J,"SORT")
 K @ORY@(0)
 K ^TMP("MBAACR",$J)
 Q 
 ;
LOOKUP ; MBAA RPC: MBAA NO PATIENT CSLT LOOKUP
 ;
 N CONIEN,CSTAT,ORCNT,ORNEXT,SERVICE,QUIT,X
 ;
 ;LOOK UP BY DATE (Reverse chronological order)
 ;Use OREDTE for seed and ORSDT as the max date limiter.
 ;CONIEN = consult IEN
 ;
 S QUIT=0,CONCNT=""
 F  S OREDT=$O(^GMR(123,"E",OREDT),-1) Q:OREDT=""!(QUIT)  D  ;ICR#: 6052 GMR(123
 . I OREDT<ORSDT S QUIT=1 Q
 . S CONIEN="" F  S CONIEN=$O(^GMR(123,"E",OREDT,CONIEN)) Q:CONIEN=""  D  ;ICR#: 6052 GMR(123
 . . S CSTAT="" F  S CSTAT=$O(STATUS(CSTAT)) Q:CSTAT=""  D
 . . . Q:'$$CKSTAT()  ; CHECK STATUS
 . . . I ORSERV'="" D
 . . . . I '$D(^GMR(123,"C",ORSERV,CONIEN)) Q  ;ICR#: 6052 GMR(123
 . . . . I ORPROV'="",'$D(^GMR(123,"G",ORPROV,CONIEN)) Q  ;ICR#: 6052 GMR(123
 . . . . S CONCNT=$G(CONCNT)+1
 . . . . D CSLTDAT(ORSERV,OREDT,CONIEN,ORPROV,CONCNT)
 . . . I ORSERV="",ORPROV'="" D
 . . . . F  S ORSERV=$O(^GMR(123,"C",ORSERV)) Q:ORSERV=""  D  ;ICR#: 6052 GMR(123
 . . . . . I '$D(^GMR(123,"C",ORSERV,CONIEN)) Q  ;ICR#: 6052 GMR(123
 . . . . . I '$D(^GMR(123,"G",ORPROV,CONIEN)) Q  ;ICR#: 6052 GMR(123
 . . . . . S CONCNT=$G(CONCNT)+1
 . . . . . D CSLTDAT(ORSERV,OREDT,CONIEN,ORPROV,CONCNT)
 S ORCNT=0,ORSERV=""
 F  S ORSERV=$O(^TMP("MBAACN",$J,"SORT",ORSERV)) Q:ORSERV=""  D
 . S ORNEXT="",CSLTDAT=""
 . F  S ORNEXT=$O(^TMP("MBAACN",$J,"SORT",ORSERV,ORNEXT)) Q:ORNEXT=""  D
 . . S ORCNT=ORCNT+1
 . . S CSLTDAT=$G(^TMP("MBAACN",$J,"SORT",ORSERV,ORNEXT))
 . . S ^TMP("MBAACR",$J,"CS",ORCNT)=CSLTDAT
 Q
 ;
CKSTAT() ; MBAA RPC: MBAA NO PATIENT CSLT LOOKUP
 ;
 N OK
 S OK=0
 I $D(^GMR(123,"D",CSTAT,CONIEN)) S OK=1  ;ICR#: 6052 GMR(123
 Q OK
 ;
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;CKSERV(ORSERV,ORPROV,CONIEN) ; CHECK SERVICE
 ;
 ;I ORSERV'="" D
 ;. I '$D(^GMR(123,"C",ORSERV,CONIEN)) Q
 ;. I ORPROV'="",'$D(^GMR(123,"G",ORPROV,CONIEN)) Q
 ;I ORSERV="",ORPROV'="" D
 ;. F  S ORSERV=$O(^GMR(123,"C",ORSERV)) Q:ORSERV=""  D
 ;. . I '$D(^GMR(123,"C",ORSERV,CONIEN)) Q
 ;. . I '$D(^GMR(123,"G",ORPROV,CONIEN)) Q
 ;Q
 ;
CSLTDAT(ORSERV,OREDT,CONIEN,ORPROV,CONCNT) ;  FORMAT DATA MBAA RPC: MBAA NO PATIENT CSLT LOOKUP
 ;
 N CONSTAT,CSLTDAT,CSTATNAM,DFN,NODE,PROVDX,PRVNAME,PTNAME,VADM
 S NODE=$G(^GMR(123,CONIEN,0))  ;ICR#: 6052 GMR(123
 S:ORPROV="" ORPROV=$P(NODE,U,14)
 N JX S JX=$$GET1^DIQ(200,$G(ORPROV),.01)  ;ICR#: 6053 VA(200
 ;S PRVNAME=$S(ORPROV="":"",1:$P(^VA(200,ORPROV,0),U,1))
 S PRVNAME=$S(ORPROV="":"",1:$G(JX)) K JX
 S DFN=$P(NODE,U,2),CONSTAT=$P(NODE,U,12),CSTATNAM=$P(^ORD(100.01,CONSTAT,0),U,1)  ;ICR#: 2638 ORD(101.01
 S PROVDX=$P($G(^GMR(123,CONIEN,30)),U,1)  ;ICR#: 6052 GMR(123
 D DEM^VADPT  ;ICR#: 10061 VADPT
 S PTNAME=$G(VADM(1))
 S SERVICE=$P(^GMR(123.5,ORSERV,0),U,1)  ;ICR#: 2739 GMR(123
 S CSLTDAT=CONIEN_U_OREDT_U_CSTATNAM_U_ORSERV_U_SERVICE_U_DFN_U_PTNAME_U_ORPROV_U_PRVNAME_U_PROVDX
 S ^TMP("MBAACN",$J,"SORT",SERVICE,CONCNT)=CSLTDAT
 Q
