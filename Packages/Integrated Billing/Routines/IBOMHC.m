IBOMHC ;SAB/EDE -  COMPACT ACT COPAY Review Report ;JUL 12 2021
 ;;2.0;INTEGRATED BILLING;**709**;21-MAR-94;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ICR #5747 - $$CODEC^ICDEX()
 ; 
EN ;
 ;
 N IBSTART,IBEND,IBEXCEL,IBSTOP
 N POP,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 ;Initialze Date fields 
 S (IBSTART,IBEND)="",IBSTOP=0
 ;Get the start and end dates.
 D DATESEL(.IBSTART,.IBEND,"Date Copay Billed")
 Q:IBSTOP
 W !!,"** This report can take a while to run and may be queued to run after hours. **",!
 W !,"Note: Copay displays only if at least one COMPACT diagnosis is hit.",!
 ; export to Excel?
 S IBEXCEL=$$GETEXCEL^IBUCMM() I IBEXCEL<0 Q
 I IBEXCEL D PRTEXCEL^IBUCMM()
 W:'IBEXCEL !!,"Report requires 132 columns.",!
 ;
 ; ask for device
 K IOP,IO("Q")
 S %ZIS="MQ",%ZIS("B")="",POP=0 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q  ; queued report: ask if print queue should be cleared, then queue task
 .S ZTDESC="COMPACT ACT Copay Review Report Report"
 .S ZTRTN="MAIN^IBOMHC"
 .S ZTSAVE("IBSTART")=IBSTART,ZTSAVE("IBEXCEL")=IBEXCEL,ZTSAVE("IBEND")=IBEND,ZTSAVE("ZTREQ")="@"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",!
 .Q
 ;
 D MAIN
 Q
 ;
MAIN ; Main routine to gather and print the report 
 ;
 K ^TMP($J,"IBOMHC"),^TMP($J,"IBOMHCDX")
 D COLLECT
 I 'IBEXCEL D PRINT(IBSTART,IBEND) Q
 D PRINTEX(IBSTART,IBEND)
 Q
 ;
DATESEL(DATESTRT,DATEEND,DESCR) ; prompt for start and end dates
 ;
 ; sets DATESTRT and DATEEND vars to start date and end date respectively, sets IBSTOP=1 on user exit
 ;
 N DIR,DUOUT,DTOUT,DIRUT,X,Y
 N CADT,DT7
 S CADT=$P($G(^IBE(350.9,1,71)),U,2)  ; COMPACT ACT Benefit start date from 350.9/71.02
 S DT7=$$FMADD^XLFDT(DT,-7)  ; today's date - 7 days
 S DIR(0)="DA^"_CADT_":"_DT_":EX"
 S DIR("A")="Start with "_$S($G(DESCR)'="":DESCR_" ",1:"")_": "
 S DIR("B")=$$FMTE^XLFDT($S(DT7<CADT:CADT,1:DT7),"1D")
 S DIR("?",1)="   Please enter a valid start date."
 S DIR("?",2)="   This date must not be in the future."
 S DIR("?")="   It also may not precede COMPACT ACT Benefit start date ("_$$FMTE^XLFDT(CADT)_")"
 D ^DIR
 I $D(DIRUT) S IBSTOP=1 G DATESELX
 S DATESTRT=Y
 ; End date
DATESEL1 ;
 S DIR("A")="  End with "_$S($G(DESCR)'="":DESCR_" ",1:"")_": "
 S DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT),"1D")
 S DIR("?",1)="   Please enter a valid end date."
 S DIR("?")="   This date must not precede the start date entered above."
 D ^DIR
 I $D(DIRUT) S IBSTOP=1 G DATESELX
 I Y<DATESTRT W !,"     End Date must not precede the Start Date." G DATESEL1
 S DATEEND=Y
 W !?5,"***  Selected date range from ",$$FMTE^XLFDT(DATESTRT)," to ",$$FMTE^XLFDT(DATEEND),"  ***"
 ;
DATESELX ; dates prompt exit point
 Q
 ;
COLLECT ; review the copays in the specified period for possible COMPACT Act related copays to review
 ;
 N IBERROR,IBN,IBDXARY,IBPTF,IBDATA,IBLP,IBBLNO,IBCT,VADM,IBPM,IBPCE,IBRX,IBVADM,I
 N DFN,DONE,IBBDSC,IBCHTYPE,IBCHRG,IBDOS,IBNM,IBRF,IBRFFL,IBDATA1,IBLPDT,IBSTATNM,IBSTAT,IBSTABR
 S IBCT=0
 S IBLPDT=IBSTART-.001,IBEND=IBEND+.999999
 ;Load list of possible DXs into a TMP array
 D GETDX
 F  S IBLPDT=$O(^IB("D",IBLPDT)) Q:'IBLPDT  Q:IBLPDT>IBEND  D
 .S IBLP=0
 .;Loop through file #350 using the Date Billed field within the Start and end Period
 .F  S IBLP=$O(^IB("D",IBLPDT,IBLP)) Q:'IBLP  D
 ..;kill and re-init arrays
 ..K IBDXARY,IBCPTARY,VADM
 ..S IBDXARY="",IBCPTARY=""
 ..; Get Copay Data
 ..S IBDATA=$G(^IB(IBLP,0)),IBDATA1=$G(^IB(IBLP,1))
 ..S IBSTATNM=$$GET1^DIQ(350,IBLP_",",.05,"E") I "^BILLED^HOLD - RATE^HOLD - REVIEW^ON HOLD^"'[(U_IBSTATNM_U) Q
 ..S DFN=$P(IBDATA,U,2) I '$$ISELIG(DFN) Q
 ..D DEM^VADPT M IBVADM=VADM
 ..;Extract field (.04)[RESULTING FROM]
 ..S IBRF=$P(IBDATA,U,4)
 ..;If no file number or ":" in field, skip and go to the next.
 ..Q:IBRF'[":"
 ..;Extract the file from the 1st ":" piece
 ..S IBRFFL=$P(IBRF,":")
 ..;Extract date of service
 ..S:IBRFFL=52 IBDOS=$P($P(IBDATA1,U,2),".")
 ..S:IBRFFL'=52 IBDOS=$P(IBDATA,U,14)
 ..Q:'IBDOS
 ..S IBNM=IBVADM(1),IBCHTYPE=$P(IBDATA,U,3) Q:IBCHTYPE=""  Q:$D(^TMP($J,"IBOMHC","IDX",IBNM,IBDOS,IBCHTYPE))
 ..Q:$$GET1^DIQ(350.1,IBCHTYPE,.05,"E")'="NEW"
 ..;If file is 45 (PTF), lookup the primary and Secondary diagnoses
 ..I IBRFFL=45 S IBPTF=$P(IBRF,":",2) D GETPTFDX(IBPTF,.IBDXARY)
 ..;If file is 409.68, lookup the diagnoses using OPTDX^IBCSC4D
 ..I IBRFFL=409.68 S IBPCE=$P(IBRF,":",2) D GETPCEDX(IBPCE,.IBDXARY),GETPCECP(IBPCE,.IBCPTARY)
 ..;If file is 405, grab the PTF or Diagnoses Text Strings.
 ..I IBRFFL=405 S IBPM=$P(IBRF,":",2) D GETPMDX(IBPM,.IBDXARY)
 ..;If file is 52, look the prescription to get the diagnosis associated with it
 ..I IBRFFL=52 S IBRX=$P($P(IBRF,":",2),";") D GETRXDX(IBLP,IBRX,.IBDXARY)
 ..;
 ..; else add the bill to the ^TMP global for display
 ..S IBID=$E(IBVADM(1),1)_$P($P(IBVADM(2),U,2),"-",3)
 ..S IBSTAT=$P(IBDATA,U,5)
 ..I IBSTATNM["HOLD" S IBSTABR="HOLD"
 ..I IBSTATNM'["HOLD" S IBSTABR=$E($$GET1^DIQ(350.21,IBSTAT_",",.03,"E"),1,4)
 ..S IBBDSC=$E($$GET1^DIQ(350.1,IBCHTYPE,.01,"E"),1,12)
 ..S IBCHRG=$P(IBDATA,U,7),IBBLNO=$P(IBDATA,U,11)
 ..S DONE=0,I="" F  S I=$O(IBDXARY(I)) Q:I=""  D  Q:DONE
 ...I I'="UNK",'$$CMPDX(I,.IBCPTARY) Q
 ...S IBCT=IBCT+1,DONE=1
 ...S ^TMP($J,"IBOMHC",DFN,IBDOS,IBCT)=IBNM_U_IBID_U_IBBLNO_U_IBSTABR_U_IBBDSC_U_$$FMTE^XLFDT(IBDOS,9)_U_U_U_$S(I="UNK":"",1:I)_U_IBCHRG
 ...S ^TMP($J,"IBOMHC","IDX",IBNM)=DFN,^TMP($J,"IBOMHC","IDX",IBNM,IBDOS,IBCHTYPE)=""
 ...I IBRFFL=52 S $P(^TMP($J,"IBOMHC",DFN,IBDOS,IBCT),U,7,8)=$P(IBDXARY(I),U)_U_$E($P(IBDXARY(I),U,2),1,20)
 ...Q
 ..Q
 .Q
 Q
 ;
ISELIG(DFN) ; check if given patient is COMPACT Act eligible
 ;
 ; DFN - patient's DFN
 ;
 ; returns 1 if patient is COMPACT Act eligible, 0 otherwise
 ;
 N RES,VACOM
 S RES=0 I +$G(DFN)>0 D CAI^VADPT S RES=+$G(VACOM("CAI"))
 Q RES
 ;
GETRXDX(IBN,IBRX,IBDXARY) ;Retrieve Dx's from the PTF file via the Patient Movement file.
 ;
 N IBDFN,IBDOS,NODE,LIST,IBRXN,IBRXNAME
 ;
 S IBDFN=$P($G(^IB(IBN,0)),U,2)
 S IBDOS=$P($P($G(^IB(IBN,1)),U,2),".")
 S NODE=0,LIST="IBOMHCRX"
 ;
 I $D(^TMP($J,"IBOMHC",IBDFN,IBDOS))>0 D
 .D RX^PSO52API(IBDFN,LIST,IBRX,,NODE,,)
 .S IBRXN=$G(^TMP($J,LIST,IBDFN,IBRX,.01))
 .S IBRXNAME=$P($G(^TMP($J,LIST,IBDFN,IBRX,6)),U,2)
 .S IBDXARY("UNK")=IBRXN_U_IBRXNAME
 .Q
 ;
 K ^TMP($J,LIST)
 Q
 ;
GETPMDX(IBPM,IBDXARY) ;Retrieve Dx's from the PTF file via the Patient Movement file.
 ;
 N IBADPM,IBPTF
 ;
 S IBADPM=$$GET1^DIQ(405,IBPM_",",.14,"I")
 S IBPTF=$$GET1^DIQ(405,$S(IBADPM=IBPM:IBPM,1:IBADPM)_",",.16,"I")
 Q:IBPTF=""
 D GETPTFDX(IBPTF,.IBDXARY)
 Q
 ;
GETPTFDX(IBPTF,IBDXARY) ; Retrieve all of the DX codes assigned during an outpatient visit
 ;
 ;INPUT:   IBPTF   - IEN of PTF record in File 45
 ;OUTPUT:  IBDXARY - Array of Diagnoses for the PTF record passed in
 ;       
 N IBCT,IBLP,IBMVTYP,IBDT,IBDXIEN,IBDX,IBPTFD
 ;
 K ^TMP($J,"IBDX")
 ;
 S IBCT=0
 D PTFDX^IBCSC4F(IBPTF)
 S IBMVTYP=""
 F  S IBMVTYP=$O(^TMP($J,"IBDX",IBMVTYP)) Q:IBMVTYP=""  D
 . S IBDT=0
 . F  S IBDT=$O(^TMP($J,"IBDX",IBMVTYP,IBDT)) Q:'IBDT  D
 . . S IBLP=0
 . . F  S IBLP=$O(^TMP($J,"IBDX",IBMVTYP,IBDT,IBLP)) Q:'IBLP  D
 . . . S IBPTFD=$G(^TMP($J,"IBDX",IBMVTYP,IBDT,IBLP))
 . . . S IBDXIEN=$P(IBPTFD,U),IBDX=$$CODEC^ICDEX(80,IBDXIEN)
 . . . I IBDX'="",'$D(IBDXARY(IBDX)) S IBDXARY(IBDX)=""
 ;
 K ^TMP($J,"IBDX")
 Q
 ;
GETPCEDX(IBPCE,IBDXARY)  ; Retrieve the list of diagnoses associated with an Outpatient Encounter
 ;
 N IBDX,IBDXB,IBDXC,IBI,IBPCD,K,IBDT,IBID,IBIFN
 S (IBDX,IBDXB)=""
 ;
 ;Extract the Diagnosis info from the encounter
 D OEDX^IBCU81(IBPCE,.IBDX,.IBDXB)
 ;Loop through the Billable diagnoses and store in IBDXARY for further review
 S IBI=0
 F  S IBI=$O(IBDXB(IBI)) Q:'IBI  D
 .S IBDXC=$$CODEC^ICDEX(80,IBI)
 .I IBDXC'="",'$D(IBDXARY(IBDXC)) S IBDXARY(IBDXC)=""
 .Q
 ;
 Q
 ;
GETPCECP(IBPCE,IBCPTARY)  ; Retrieve the list of CPT Codes associated with an Outpatient Encounter
 ;
 N IBCPT,IBCPTRET,IBERR,IBLP
 S IBCPT="IBCPTRET"
 ;
 ; Call the PCE software to retrieve the CPT code info for the visit in array IBCPTARR via indirection.
 D GETCPT^SDOE(IBPCE,.IBCPT,.IBERR)
 S IBLP=0 F  S IBLP=$O(IBCPTRET(IBLP)) Q:'IBLP  S IBCPTARY($P(IBCPTRET(IBLP),U))=""
 Q
 ;
PRINT(IBSTRT,IBEND) ; Print the results
 N IBI,IBX,IBPAGE,IBLN,QUIT,IBDFN,IBDOS,IBNM
 I $E(IOST,1,2)["C-",'$D(ZTQUEUED) W @IOF
 S IBPAGE=0
 D HDR(IBSTRT,IBEND)
 S IBLN=6
 I '$D(^TMP($J,"IBOMHC")) W !!!,"   There were no copayments within the specified date range that were potentially COMPACT ACT eligible",!!!  D PAUSE Q
 ;
 S IBNM="" F  S IBNM=$O(^TMP($J,"IBOMHC","IDX",IBNM)) Q:IBNM=""  D  Q:$G(QUIT)
 .S IBDFN=^TMP($J,"IBOMHC","IDX",IBNM)
 .S IBDOS=0 F  S IBDOS=$O(^TMP($J,"IBOMHC",IBDFN,IBDOS)) Q:'IBDOS  D  Q:$G(QUIT)
 ..S IBI=0 F  S IBI=$O(^TMP($J,"IBOMHC",IBDFN,IBDOS,IBI)) Q:'IBI  D  Q:$G(QUIT)
 ...S IBDATA=$G(^TMP($J,"IBOMHC",IBDFN,IBDOS,IBI))
 ...W !,$E(IBNM,1,18),?20,$P(IBDATA,U,2),?26,$P(IBDATA,U,3),?39,$P(IBDATA,U,4),?44,$P(IBDATA,U,5),?60,$P(IBDATA,U,6),?74,$P(IBDATA,U,7),?87,$P(IBDATA,U,8),?114,$P(IBDATA,U,9),?120,$J($P(IBDATA,U,10),9,2)
 ...S IBLN=IBLN+1
 ...I IBLN>(IOSL-3) D HDR(IBSTRT,IBEND) S IBLN=6 I $G(QUIT) Q
 ...Q
 ..Q
 .Q
 ;
 ;Immediately Quit if the user indicates exit.
 Q:$G(QUIT)
 ;
 ; Otherwise, pause to let the user review.
 I IBPAGE>0,'$D(ZTQUEUED) D PAUSE W @IOF
 Q
 ;
HDR(IBSTRT,IBEND) ; print header
 ;
 N IBX
 I IBPAGE>0,'$D(ZTQUEUED) D PAUSE W @IOF I $G(QUIT) Q
 S IBPAGE=IBPAGE+1
 W !,"COMPACT ACT Copay Review Report from ",$$FMTE^XLFDT(IBSTRT)," to ",$$FMTE^XLFDT($P(IBEND,".")),?80,"Date of Report: ",?96,$$FMTE^XLFDT($$DT^XLFDT()),?120,"Page: ",IBPAGE
 W !!,"Patient Name",?22,"ID",?26,"Bill Number",?39,"Stat",?44,"Descr.",?60,"Fill/Adm/DOS",?74,"RX Number",?87,"RX Name",?114,"DX",?120,"Amount"
 W ! F IBX=1:1:131 W "-"
 Q
 ;
PAUSE    ;Press Return to Continue
 N DIR,DUOUT,DTOUT,DIRUT
 S DIR(0)="E" D ^DIR
 I $D(DIRUT) S QUIT=1
 W !
 Q
 ;
PRINTEX(IBSTRT,IBEND) ; Print the results
 N IBDFN,IBDOS,IBI,IBDATA,IBNM
 W @IOF
 W !,"COMPACT ACT Copay Review Report from ",$$FMTE^XLFDT(IBSTRT)," to ",$$FMTE^XLFDT($P(IBEND,".")),"   Date of Report: ",$$FMTE^XLFDT($$DT^XLFDT())
 W !,"Patient Name",U,"ID",U,"Bill Number",U,"Stat",U,"Descr.",U,"Fill/Adm/DOS",U,"RX Number",U,"RX Name",U,"DX",U,"Amount"
 S IBNM="" F  S IBNM=$O(^TMP($J,"IBOMHC","IDX",IBNM)) Q:IBNM=""  D
 .S IBDFN=^TMP($J,"IBOMHC","IDX",IBNM)
 .S IBDOS=0 F  S IBDOS=$O(^TMP($J,"IBOMHC",IBDFN,IBDOS)) Q:'IBDOS  D
 ..S IBI=0 F  S IBI=$O(^TMP($J,"IBOMHC",IBDFN,IBDOS,IBI)) Q:'IBI  D
 ...S IBDATA=$G(^TMP($J,"IBOMHC",IBDFN,IBDOS,IBI))
 ...W !,$E(IBNM,1,18),U,$P(IBDATA,U,2,10)
 ...Q
 ..Q
 .Q
 Q
 ;
GETDX() ; Populate the list of DX codes
 ;
 N IBDXD
 ;
 ;Retrieve Specific Diagnosis codes
 F I=1:1 S IBDATA=$T(DXSLIST+I) S IBDXD=$P(IBDATA,";",3) Q:IBDXD="EXIT"  S ^TMP($J,"IBOMHCDX","IBDXS",IBDXD)=+$P(IBDATA,";",4)
 ;
 Q
 ;
CMPDX(IBDX,IBCPTARY) ; Check to see if the diagnosis is a Compact Act related Diagnosis.
 ;
 ; INPUT:  IBDX - ICD-10 DIAGNOSIS CODE
 ; Returns:  0 - Not related  1 COMPACT Act related diagnosis
 ;
 N IBDXGRP,IBFOUND,IBLP,IBCPTN
 ;
 S IBFOUND=0
 ;
 ;If the code matches a specific code related to COMPACT
 I $D(^TMP($J,"IBOMHCDX","IBDXS",IBDX)) D  Q IBFOUND
 .S IBCPTN=+$G(^TMP($J,"IBOMHCDX","IBDXS",IBDX))
 .I 'IBCPTN!($D(IBCPTARY)<10) S IBFOUND=1 Q     ;No CPT Code needed to confirm COMPACT related Diagnosis
 .; Check the CPT temporary array to see if the CPT code associated with the Diagnosis is present in the encounter.
 .I $D(IBCPTARY(IBCPTN)) S IBFOUND=1
 .Q
 ;
 ;Dx code not potentially related to COMPACT Act.
 Q IBFOUND
 ;
DXSLIST ; List of Specific Compact Act Related Diagnosis codes
 ;;T14.91XA;0
 ;;T14.91XD;0
 ;;T14.91XS;0
 ;;R45.851;90839
 ;;EXIT
 Q
 ;
