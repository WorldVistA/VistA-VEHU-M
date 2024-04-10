YTQRCDB2 ;BAL/KTL - MHA CLOUD DATABASE RPC CALLS; 1/25/2017
 ;;5.01;MENTAL HEALTH;**239**;Dec 30, 1994;Build 16
 ;
 ;Reference to VADPT APIs supported by DBIA #10061
 ;Reference to $$SITE^VASITE supported by IA #10112
 ;
 Q
PID2(ARGS,RESULTS) ;Get additional patient demographics
 N DFN,VA,VADM,YSNM,YSDOB,YSAGE,YSSSN,YSSEX,YSSX,YSSIG
 S DFN=$G(ARGS("dfn"))
 I +DFN=0 D SETERROR^YTQRUTL(404,"Bad patient identifier") QUIT
 I '$D(^DPT(DFN,0)) D SETERROR^YTQRUTL(404,"Not Found: "_DFN) QUIT
 D DEM^VADPT,PID^VADPT
 S YSNM=VADM(1)
 S YSDOB=$P(VADM(3),U,2)
 S YSAGE=VADM(4)
 S YSSSN="xxx-xx-"_VA("BID")
 S YSSEX=$P(VADM(5),U,1)
 S YSSX=YSSEX
 S YSSIG=$P($G(VADM(14,5)),U,2)
 S RESULTS("dob")=YSDOB
 S RESULTS("ssn")=YSSSN
 S RESULTS("sex")=YSSEX
 S RESULTS("sigi")=YSSIG
 Q
TZ(ARGS,RESULTS) ;Get timezone
 N HASSITE,SITE,INST,UTC,NN
 S HASSITE=""
 S INST=$$SITE^VASITE,INST=$P(INST,U,3)
 S:+INST'=0 SITE(INST)="",HASSITE=1
 I '$D(SITE) S HASSITE=$$DIV4^XUSER(.SITE,DUZ)
 I 'HASSITE I $G(DUZ(2))]"" S SITE(DUZ(2))=""  ;Use Default site if not explicitly defined.
 I '$D(SITE) D  Q
 . S RESULTS("inst")=""
 . S RESULTS("fileman")=""
 . S RESULTS("external")=""
 . S RESULTS("offset")=""
 . S RESULTS("timezone")=""
 S INST=$O(SITE(""))  ;Use first in list-assume all are in same TZ
 S NN=$$NOW^XLFDT(),UTC=""
 S INST="" F  S INST=$O(SITE(INST)) Q:INST=""!(UTC'="")  D
 . S UTC=$$UTC^DIUTC(NN,,$G(INST),,1)
 . S:UTC<0 UTC=""
 S RESULTS("fileman")=$P(UTC,U)
 S RESULTS("external")=$P(UTC,U,2)
 S RESULTS("offset")=$P(UTC,U,3)
 S RESULTS("timezone")=$P(UTC,U,4)
 Q
