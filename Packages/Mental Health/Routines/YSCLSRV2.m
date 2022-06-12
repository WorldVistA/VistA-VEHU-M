YSCLSRV2 ;DALOI/RLM,HEC/hrubovcak - Clozapine data server ;16 Oct 2019 19:31:54
 ;;5.01;MENTAL HEALTH;**69,90,92,154,166**;Dec 30, 1994;Build 19
 ; Reference to ^%ZOSF supported by IA #10096
 ; Reference to ^DPT supported by IA #10035
 ; Reference to ^DD("DD" supported by IA #10017
 ; Reference to ^PS(55 supported by IA #787
 ; Reference to ^PSDRUG supported by IA #25
 ; Reference to ^PSRX supported by IA #780
 ; Reference to ^VA(200 supported by IA #10060
 ; Reference to $$SITE^VASITE supported by IA #10112
 ; Reference to $$FMTE^XLFDT() supported by IA #10103
 ; Reference to ^PSDRUG supported by IA #221
 ; Reference to ^LAB(60 supported by IA #333
 ; 
REPORT ;send report of current registrations to the Clozapine group on Forum
 ;
 S XMRG="",YSCLA=0 F  S YSCLA=$O(^YSCL(603.01,YSCLA)) Q:'YSCLA  S YSCLDTA=$G(^YSCL(603.01,YSCLA,0)) D
  . I YSCLDTA="" S YSCLER="Clozapine Patient List damaged at " D OUT Q
  . N YSDFN,YSDPT0 S YSDFN=+$P(YSCLDTA,U,2),YSDPT0=$G(^DPT(YSDFN,0))
  . I YSCLDTA="" S YSCLER="Clozapine Patient List patient info missing for IEN: "_YSCLA_" at " D OUT Q
  . S YSCLWB=$P(YSCLDTA,U,3),YSCLWB=$S(YSCLWB="M":"Monthly",YSCLWB="W":"Weekly",YSCLWB="B":"Bi-weekly",1:"Unknown")
  . S YSCLER=$P(YSCLDTA,U)_" is assigned to "_$P(YSDPT0,U)_" ("_$P(YSDPT0,U,9)_") "_YSCLWB_" at " D OUT
 D ADD2TXT^YSCLSERV("==========")
 D ADD2TXT^YSCLSERV("  Linked Tests:")
 S YSCLA=0 F  S YSCLA=$O(^YSCL(603.04,1,1,YSCLA)) Q:'YSCLA  D
  . D ADD2TXT^YSCLSERV($P(^LAB(60,$P(^YSCL(603.04,1,1,YSCLA,0),U,1),0),U))
  . S YSCLTYPE=$P(^YSCL(603.04,1,1,YSCLA,0),U,2),YSCLRPT=$P(^YSCL(603.04,1,1,YSCLA,0),U,3)
  . S YSCLTA="  reports  "_$S(YSCLTYPE="W":"WHITE BLOOD COUNT",YSCLTYPE="A":"ABSOLUTE NEUTROPHIL COUNT",YSCLTYPE="N":"NEUTROPHIL PERCENT",YSCLTYPE="S":"SEGS %",YSCLTYPE="B":"BANDS %",YSCLTYPE="T":"BANDS A",YSCLTYPE="C":"SEGS A")
  . D ADD2TXT^YSCLSERV(YSCLTA_"  "_$S(YSCLRPT:"K/units",1:"units"))
 D ADD2TXT^YSCLSERV("==========")
 ;D OPTION^%ZTLOAD("YSCL WEEKLY TRANSMISSION","LIST") D
 ; . S ZTSK="" F  S ZTSK=$O(LIST(ZTSK)) Q:ZTSK=""  D
 ; . . D STAT^%ZTLOAD D ADD2TXT^YSCLSERV("Local Task # "_ZTSK_" is "_$S('ZTSK(0):" not ",1:"")_"defined with a status of "_ZTSK(2)
 D ADD2TXT^YSCLSERV("              Run day is: "_$P(^YSCL(603.03,1,0),U,2))
 D ADD2TXT^YSCLSERV("           Debug Mode is: "_$S($P(^YSCL(603.03,1,0),U,3):"On.",1:"Off."))
 D ADD2TXT^YSCLSERV("Last Run Date (start) is: "_$$FMTE^XLFDT($P(^YSCL(603.03,1,0),U,4)))
 D ADD2TXT^YSCLSERV(" Last Run Date (stop) is: "_$$FMTE^XLFDT($P(^YSCL(603.03,1,0),U,5)))
 D ADD2TXT^YSCLSERV("Last Demographic date is: "_$$FMTE^XLFDT($P(^YSCL(603.03,1,0),U,6)))
 Q
OUT D ADD2TXT^YSCLSERV(XMRG_YSCLER_YSCLST) Q
 ;Build the text for the return message here.
REBUILD ;
 S XMRG="",(YSCLA,YSCLLNT)=1 F  S YSCLA=$O(^PS(55,"ASAND1",YSCLA)) W:'$D(ZTQUEUED) "." Q:YSCLA=""  D
  . S YSCLB=$O(^PS(55,"ASAND1",YSCLA,"")) I YSCLB="" S YSCLER=" record is in error (1) at " D OUT Q
  . I '$D(^PS(55,YSCLB,0)) S YSCLER=" record is in error (2) at " D OUT Q
  . S YSCLB=$P(^PS(55,YSCLB,0),U) I YSCLB="" S YSCLER=" record is in error (3) at " D OUT Q
  . I '$D(^PS(55,YSCLB,"SAND")) S YSCLER=" record is in error (4) at " D OUT Q
  . S DIC="^DPT(",DIC(0)="X",D="SSN",(YSCLSSN,X)=$P(^DPT(YSCLB,0),U,9)
  . I $D(^YSCL(603.01,"B",YSCLA)) S YSCLX=$O(^YSCL(603.01,"B",YSCLA,"")) S:YSCLX]"" YSCLX=$P(^YSCL(603.01,YSCLX,0),U,2),YSCLER=" Clozapine # "_YSCLA_" is in use by "_$P($G(^DPT(YSCLX,0)),U)_" at " D OUT Q
  . D MIX^DIC1 S YSCLPT=+Y I Y=-1 S YSCLER=" could not be added at " D OUT Q
  . K DD S DIC="^YSCL(603.01,",X=YSCLA,DIC("DR")="1////"_YSCLPT K DO D FILE^DICN
  . S YSCLX=$O(^YSCL(603.01,"B",YSCLA,"")) S:YSCLX]"" YSCLX=$P(^YSCL(603.01,YSCLX,0),U,2),YSCLER=","_YSCLSSN_" assigned to "_$P($G(^DPT(YSCLX,0)),U)_" at " D OUT
 Q
OVRRID ;Update record with Monthly, Weekly or Bi-weekly status
 N YSPTMUOK S YSPTMUOK=1
 F  X XMREC Q:XMER<0  S XMRG=$TR(XMRG,"- ","") D
  . I XMRG'?2U5N1","9N1",".E S YSCLER=" is in error and was not added at " D OUT Q
  . I $P(XMRG,",")'?2U5N S YSCLER=" is not a valid Clozapine number format " D OUT Q
  . I $P(XMRG,",",2)'?9N S YSCLER=" An SSN must be 9 numbers " D OUT Q
  . K %DT S X=$P(XMRG,",",3),%DT="F" D ^%DT I Y=-1 S YSCLER=" is an invalid date, over-ride authorization not filed at " D OUT Q
  . S YSCLOVR=Y
  . S YSCLNM=$P(XMRG,","),YSCLSSN=$P(XMRG,",",2),YSCLWB=$P(XMRG,",",3)
  . I '$D(^YSCL(603.01,"B",YSCLNM)) S YSCLER=" does not exist at " D OUT Q
  . S YSCLDA=$O(^DPT("SSN",YSCLSSN,0))
  . I YSCLDA="" S YSCLER=" SSN does not exist at " D OUT Q
  . I $O(^YSCL(603.01,"B",YSCLNM,0))="" S YSCLER=" SSN not in Clozapine file " D OUT Q
  . I $O(^DPT("SSN",YSCLSSN,YSCLDA)) S YSCLER=" SSN has more than one owner " D OUT Q
  . ; JCH - Begin PSO*7*612 Handle multiple Clozapine Numbers for the same patient
  . S YSCLDA1=$O(^YSCL(603.01,"B",YSCLNM,0))  ; IEN from B x-ref for NCCC number
  . ; Check all Clozapine Numbers associated with patient in 603.01, not just the first/oldest entry
  . I YSCLDA1'=$O(^YSCL(603.01,"C",YSCLDA,0)) S YSPTMUOK=0 N YSPTNUM S YSPTNUM=0 F  S YSPTNUM=$O(^YSCL(603.01,"C",YSCLDA,YSPTNUM)) Q:'YSPTNUM!$G(YSPTNUOK)  I YSCLDA1=YSPTNUM S YSPTMUOK=1
  . I '$G(YSPTMUOK) S YSCLER=YSCLNM_" is not assigned to "_" SSN ("_YSCLSSN_","_$P(^DPT(YSCLDA,0),U)_") at " D OUT
  . I YSPTMUOK!($O(^YSCL(603.01,"B",YSCLNM,0))=$O(^YSCL(603.01,"C",YSCLDA,0))) D
  . . ; JCH - End PSO*7*612
  . . S YSCLDA1=$O(^YSCL(603.01,"B",YSCLNM,0)) S $P(^YSCL(603.01,YSCLDA1,0),U,4)=YSCLOVR
  . . S Y=YSCLOVR D DD^%DT S YSCLER=" "_YSCLNM_" ("_$P(^DPT(YSCLDA,0),U)_") authorized for over-ride on "_Y_" at " D OUT
  . . K ^XTMP("PSJ4D-"_+$G(YSCLDA)),^XTMP("PSO4D-"_+$G(YSCLDA))    ; JCH - PSO*7*612. Local Overrides are now obsolete, replaced by NCCC Override.
 G EXIT^YSCLSERV
 ;
CLAPI ;
 F  X XMREC Q:XMER<0  S XMRG=$TR(XMRG,"- ","") D
  . ;Verify that a valid Clozapine number is listed
  . S YSCLDA=$E(XMRG,1,7)
  . I YSCLDA'?2U5N S YSCLER=" is not a valid Clozapine number " D OUT Q
  . S YSCLDA=$O(^YSCL(603.01,"B",YSCLDA,"")),YSCLDA=$P($G(^YSCL(603.01,YSCLDA,0)),U,2)
  . I 'YSCLDA S YSCLER=" is not in the local database." D OUT Q
  . S YSCLNM=$$CL^YSCLTST2(YSCLDA) S YSCLER=" = "_YSCLNM_" at " D OUT
  . Q
  G EXIT^YSCLSERV
CL1API ;
 F  X XMREC Q:XMER<0  S XMRG=$TR(XMRG,"- ","") D
  . ;Verify that a valid Clozapine number is listed
  . S YSA=$P(XMRG,U,1),YSCLDA=$P(XMRG,U,2)
  . I YSCLDA'?2U5N S YSCLER=" is not a valid Clozapine number " D OUT Q
  . S YSCLDA=$O(^YSCL(603.01,"B",YSCLDA,"")),YSCLDA=$P($G(^YSCL(603.01,YSCLDA,0)),U,2)
  . I 'YSCLDA S YSCLER=" is not in the local database." D OUT Q
  . D CL1^YSCLTST2(YSCLDA,YSA) D
  . . S YSCLDA1="" F  S YSCLDA1=$O(^TMP($J,"PSO",YSCLDA1)) Q:'YSCLDA1  S YSCLER=" = "_YSCLDA_"="_(9999999-YSCLDA1)_" = "_^TMP($J,"PSO",YSCLDA1)_" at " D OUT
  . Q
  G EXIT^YSCLSERV
 ;
DCON ;
 F  X XMREC Q:XMER<0  S XMRG=$TR(XMRG,"- ","") D
  . ;Verify that a valid Clozapine number is listed
  . S (YSA,YSCLDA)=$E(XMRG,1,7)
  . I YSCLDA'?2U5N S YSCLER=" is not a valid Clozapine number " D OUT Q
  . S YSCLDA=$O(^YSCL(603.01,"B",YSCLDA,"")),YSCLDA=$P($G(^YSCL(603.01,YSCLDA,0)),U,2)
  . I 'YSCLDA S YSCLER=" is not in the local database." D OUT Q
  . I $P(^PS(55,YSCLDA,"SAND"),U,2)'="D" S YSCLER=YSA_" is not discontinued" D OUT Q
  . S YSCLER=YSA_" was "_$P(^PS(55,YSCLDA,"SAND"),U,2)_" is now ""A""" D OUT
  . S $P(^PS(55,YSCLDA,"SAND"),U,2)="A"
  Q
 ;
