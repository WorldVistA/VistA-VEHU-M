IBMHRPT ;EDE/YMG - Mental Health Copay Exemption Report; 05/04/2023
 ;;2.0;INTEGRATED BILLING;**784**;21-MAR-94;Build 8
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
EN ; entry point
 N IBCANC,IBDIVS,IBEDT,IBEXCEL,IBFREE,IBSDT,IBSORT,Z
 N POP,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 K ^TMP("IBMHRPT",$J)
 I '$$ASKDIV(.IBDIVS) Q  ; filter by division
 S Z=$$ASKDT() I 'Z Q  ; date range
 S IBSDT=$P(Z,U),IBEDT=$P(Z,U,2)
 S IBCANC=$$ASKCANC() I IBCANC=-1 Q
 S IBFREE=$$ASKFREE() I IBFREE=-1 Q
 S IBSORT=$$ASKSORT() I IBSORT=-1 Q
 S IBEXCEL=$$GETEXCEL^IBUCMM() I IBEXCEL<0 Q
 I IBEXCEL D PRTEXCEL^IBUCMM()
 I 'IBEXCEL W !!,"This report requires 132 column display.",!
 ; ask for device
 K IOP,IO("Q")
 S %ZIS="MQ",%ZIS("B")="",POP=0 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q  ; queued report
 .S ZTDESC="Mental Health Copay Exemption Report",ZTRTN="COMPILE^IBMHRPT"
 .S (ZTSAVE("IBCANC"),ZTSAVE("IBDIVS"),ZTSAVE("IBSDT"),ZTSAVE("IBEDT"),ZTSAVE("IBEXCEL"),ZTSAVE("IBFREE"),ZTSAVE("IBSORT"))=""
 .S ZTSAVE("ZTREQ")="@"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! D PAUSE
 .Q
 D COMPILE
 K ^TMP("IBMHRPT",$J)
 D ^%ZISC
 Q
 ;
COMPILE ; compile report
 N CNT,IBATYP,IBBILL,IBDATA,IBDFN,IBDIV,IBDIVNM,IBDT,IBENC,IBEVDT,IBFVSTS,IBIDX,IBIEN,IBOK,IBPATN,IBSTA,IBSTAT,IBSTR,IENS,Z
 S (CNT,IBDFN)=0 F  S IBDFN=$O(^IB("AFDT",IBDFN)) Q:'IBDFN  D
 .S IBDT=-(IBEDT+.01) F  S IBDT=$O(^IB("AFDT",IBDFN,IBDT)) Q:'IBDT!(IBDT>(-IBSDT))  D
 ..S IBEVDT=-IBDT
 ..S IBFVSTS=$$NUMVSTCK^IBECEAMH(IBDFN,IBEVDT)
 ..I 'IBFREE,'IBFVSTS Q  ; skip patients with no free visits remaining
 ..S IBIEN=0 F  S IBIEN=$O(^IB("AFDT",IBDFN,IBDT,IBIEN)) Q:'IBIEN  D
 ...S CNT=CNT+1 I '$D(ZTQUEUED),'(CNT#100) W "."
 ...S IENS=IBIEN_"," D GETS^DIQ(350,IENS,".02:.05;.07;.11;.13;.17;.2","IE","IBDATA")
 ...S IBDIV=+IBDATA(350,IENS,.13,"I")
 ...I 'IBDIVS,$G(IBDIVS(IBDIV))="" Q  ; not selected division
 ...S IBATYP=IBDATA(350,IENS,.03,"E") I IBATYP'["OPT" Q  ; not an outpatient charge
 ...S IBSTAT=IBDATA(350,IENS,.05,"E") I 'IBCANC,IBSTAT="CANCELLED" Q  ; skip cancelled bills
 ...S IBOK=$$ISCDCANC^IBECEAMH(IBIEN)
 ...I 'IBOK S Z=$P(IBDATA(350,IENS,.04,"I"),";") S:$P(Z,":")="409.68" IBENC=$P(Z,":",2),IBOK=$$OECHK^IBECEAMH(IBENC,IBEVDT)
 ...I 'IBOK Q  ; not eligible for Cleland-Dole
 ...S IBSTA=$$STA^XUAF4(IBDIV) I $L(+IBSTA)=$L(IBSTA) S IBSTA=IBSTA_" "
 ...S IBDIVNM=$$NAME^XUAF4(IBDIV)
 ...S IBBILL=IBDATA(350,IENS,.11,"E")
 ...S IBPATN=IBDATA(350,IENS,.02,"E")
 ...S IBSTR=IBSTA_" "_IBDIVNM_U_IBPATN_U_IBEVDT_U_IBBILL_U_IBATYP_U_IBSTAT_U_IBDATA(350,IENS,.2,"E")
 ...S IBSTR=IBSTR_U_IBDATA(350,IENS,.07,"E")_U_$S(IBFVSTS:"Y",1:"N")
 ...S ^TMP("IBMHRPT",$J,CNT)=IBSTR
 ...S IBIDX=$S(IBSORT="P":IBPATN,IBSORT="S":IBEVDT,1:IBSTA)
 ...S ^TMP("IBMHRPT",$J,"IDX",IBIDX,CNT)=""
 ...Q
 ..Q
 .Q
 D PRINT
 Q
 ;
PRINT ; print report
 N EXTDT,LN,IBDATA,IBEVDT,IBIDX,PAGE,QUIT
 U IO
 S (PAGE,QUIT)=0
 S EXTDT=$$FMTE^XLFDT(DT)
 I IBEXCEL D
 .W !,"Mental Health Copay Exemption Report^",EXTDT
 .W !,$$FLTRSTR(),U,$$SORTSTR()
 .W !,"Div^Patient Name^Date Of Service^Bill #^Copay Type^IB Status^Stop^Amt^Free?"
 .Q
 I 'IBEXCEL D
 .I $E(IOST,1,2)["C-",'$D(ZTQUEUED) W @IOF
 .D HDR
 .Q
 I '$D(^TMP("IBMHRPT",$J)) D  Q
 .I IBEXCEL W !!,"No records found." Q
 .W !!,$$CJ^XLFSTR("No records found.",132)
 .Q
 S IBIDX="" F  S IBIDX=$O(^TMP("IBMHRPT",$J,"IDX",IBIDX)) Q:IBIDX=""  D  Q:$G(QUIT)
 .S CNT=0 F  S CNT=$O(^TMP("IBMHRPT",$J,"IDX",IBIDX,CNT)) Q:'CNT  D  Q:$G(QUIT)
 ..S IBDATA=^TMP("IBMHRPT",$J,CNT)
 ..S IBEVDT=$$FMTE^XLFDT($P(IBDATA,U,3),"2DZ")
 ..I IBEXCEL D  Q
 ...W !,$P(IBDATA,U),U,$P(IBDATA,U,2),U,IBEVDT,U,$P(IBDATA,U,4),U,$P(IBDATA,U,5),U,$P(IBDATA,U,6),U,$P(IBDATA,U,7),U,"$",$FN($P(IBDATA,U,8),"",0),U,$P(IBDATA,U,9)
 ...Q
 ..S LN=LN+1
 ..W !,$E($P(IBDATA,U),1,20),?21,$P(IBDATA,U,2),?52,IBEVDT,?61,$P(IBDATA,U,4),?75,$E($P(IBDATA,U,5),1,20),?96,$E($P(IBDATA,U,6),1,20),?117,$P(IBDATA,U,7),?121
 ..W "$",$FN($P(IBDATA,U,8),"",0),?130,$P(IBDATA,U,9)
 ..I LN>(IOSL-3) D HDR
 ..Q
 .Q
 I '$G(QUIT),'$D(ZTQUEUED),'IBEXCEL W !!,$$CJ^XLFSTR("End of report.",132) D PAUSE
 Q
 ;
HDR ; print header
 N DASH
 I PAGE>0,'$D(ZTQUEUED) D PAUSE W @IOF I $G(QUIT) Q
 S $P(DASH,"-",133)=""
 S PAGE=PAGE+1,LN=4
 W !,"Mental Health Copay Exemption Report",?66,EXTDT,?120,"Page: ",PAGE
 W !,$$FLTRSTR(),";",$$SORTSTR()
 W !,"Div                  Patient Name                   DoS      Bill #        Type                 Status              Stop Amt    Free"
 W !,DASH
 Q
 ;
ASKDT() ; prompt for start and end dates
 ;
 ; returns "start date^end date" on success, 0 on user exit / timeout
 ;
 N MHSDT,SDT
 N DIR,DUOUT,DTOUT,DIROUT,DIRUT,X,Y
 ;
 S MHSDT=$$GET1^DIQ(350.9,"1,",71.03,"I")
 S DIR(0)="DA^"_MHSDT_":"_DT_":EX"
 S DIR("A")="Start with Date of Service: "
 S DIR("?",1)="   Please enter a valid starting date of service."
 S DIR("?",2)="   This date must not be in the future."
 S DIR("?")="   This date must not precede "_$$EXTERNAL^DILFD(350.9,71.03,,MHSDT)_"."
 D ^DIR I $D(DIRUT)!$D(DIROUT) Q 0
 S SDT=Y
 ; End date
 S DIR(0)="DA^"_SDT_"::EX"
 S DIR("A")="  End with Date of Service: "
 S DIR("?",1)="   Please enter a valid ending date of service."
 S DIR("?")="   This date must not precede the starting date entered above."
 D ^DIR I $D(DIRUT)!$D(DIROUT) Q 0
 Q SDT_U_Y
 ;
ASKDIV(DIVS) ; prompt for division(s)
 ;
 ; DIVS - array of selected divisions, passed by reference
 ;
 ; returns 1 on success, 0 on user exit / timeout
 ;
 ; sets DIVS = 1 for all divisions, 0 for selected divisions
 ;      DIVS(file 4 ien) = division name (only for selected divisions)
 ;
 N DIC,VAUTDV,VAUTNI,VAUTSTR,VAUTVB
 S DIC=4,VAUTNI=0,VAUTSTR="division",VAUTVB="VAUTDV" D FIRST^VAUTOMA
 I 'VAUTDV,$O(VAUTDV(""))="" Q 0
 M DIVS=VAUTDV
 Q 1
 ;
ASKSORT() ; display "sort by" prompt
 ;
 ; returns P for patient, S for date of service, D for division, -1 for user exit / timeout
 ;
 N DIR,DUOUT,DTOUT,DIROUT,DIRUT,X,Y
 S DIR(0)="SA^P:Patient;S:Date of Service;D:Division"
 S DIR("A")="Sort By (P)atient, Date of (S)ervice or (D)ivision: "
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q Y
 ;
FLTRSTR() ; returns "Filtered by" string to print
 Q "Filtered by: "_$S('IBDIVS:"Division",1:"No filter")
 ;
SORTSTR() ; returns "Sorted by" string to print
 Q "Sorted by: "_$S(IBSORT="P":"Patient",IBSORT="S":"Date of Service",1:"Division")
 ;
PAUSE ; "Press Return to Continue" prompt
 N DIR,DUOUT,DTOUT,DIROUT,DIRUT,X,Y
 W !
 S DIR(0)="E" D ^DIR
 I $D(DIRUT) S QUIT=1
 W !
 Q
 ;
ASKCANC() ; display "include cancelled bills" prompt
 ;
 ; returns 1 for "yes", 0 for "no", or -1 for user exit / timeout
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 W !
 S DIR("A")="Do you want to include cancelled bills? (Y/N): "
 S DIR(0)="YA"
 D ^DIR
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q $S(+Y=1:1,1:0)
 ;
ASKFREE() ; display "include free visits" prompt
 ;
 ; returns 1 for "yes", 0 for "no", or -1 for user exit / timeout
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 W !
 S DIR("A")="Do you want to include patients with no remaining free MH visits? (Y/N): "
 S DIR(0)="YA"
 D ^DIR
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q $S(+Y=1:1,1:0)
