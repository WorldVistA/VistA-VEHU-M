PSJOCDS ;BIR/MV - SET INPUT DATA FOR DOSING ORDER CHECKS ; Jun 06, 2007@15:37
 ;;5.0;INPATIENT MEDICATIONS;**181,252,257,256,358,423**;16 DEC 97;Build 12
 ;
 ; Reference to ^PS(55 is supported by DBIA #2191.
 ; Reference to ^PS(51.1 is supported by DBIA #2177.
 ; Reference to ^PSSORPH is supported by DBIA #3234.
 ; Reference to ^PSSDSAPI is supported by DBIA #5425.
 ; Reference to ^PSSDSAPD is supported by DBIA #5426.
 ; Reference to FULL^VALM1 and PAUSE^VALM1 is supported by DBIA #10116.
 ;
 ;The Dose API will be processed separately than the DD & DT order checks
 ;
IN(PSJPON,PSJTYPE,PSJDD) ;
 ;PSJPON - Order number
 ;PSJPTYPE - UD/IV
 ;PSJDD - Dispense drug IEN (for UD order only)
 ;
 ;PSJOVR array is defined when OVERLAP^PSGOEF2 is called.
 ;
 NEW PSJDSOFF,PSJCNT
 D FULL^VALM1
 S PSJDSOFF=$$DS^PSSDSAPI()
 I '+PSJDSOFF D DOSEOFF^PSJOCDSD($P(PSJDSOFF,U,2)) Q
 NEW PSJOCDS,PSJFDB,PSJBASE,PSJOVR,PSJOVRLP,PSJX
 K PSJOCDS,PSJFDB
 ;I '$$PING^PSJOC("Maximum Single Dose Check could not be performed") Q
 I '$$PING^PSJOC("Dosing Checks could not be performed.") Q
 K ^TMP($J,"PSJPRE"),^TMP($J,"PSJPRE1")
 S PSJBASE(1)="PSJPRE",PSJBASE(3)="PSJPRE1"
 ;
 ;;**** Commented out complex dosing
 ;;PSJOCDSC("CX","PSJCOM") is to flag if dosing checks needs to handle complex orders.
 ;;*I '$D(PSJOCDSC("CX","PSJCOM")) D
 ;;*. I $G(PSJCOM),$$CONJ^PSJOCDSC() S PSJOCDSC("CX","PSJCOM")=1
 ;;*I $G(PSJOCDSC("CX","PSJCOM")),'$D(PSJOCDSC("CX","ACX")) D SETLST^PSJOCDSC(PSJPON)
 ;;*I PSJTYPE="UD" D UD I $G(PSJOCDSC("CX","PSJCOM")) D COMPLEX^PSJOCDSC Q
 ;;*I PSJTYPE="IV" D IN^PSIVOCDS("PSJPRE") D:$G(PSJOCDSC("CX","PSJCOM")) IV^PSJOCDSC(PSJPON),UPDLST^PSJOCDSC(PSJPON,2)
 ;;**** End Complex dosing
 ;
 ;;****To be removed when complex dosing is ready
 I PSJTYPE="UD" D UD
 I PSJTYPE="IV" D IN^PSIVOCDS("PSJPRE")
 ;;****END
 ;
 I '$D(PSJFDB) Q
 ;;*If complex order then set conjunction to "Then" so low dose warning is screened out.
 ;;*I $G(PSJCOM),$$ALLTHEN^PSJOCDSC() D
 ;;*. F PSJX=0:0 S PSJX=$O(PSJOCDS(PSJX)) Q:'PSJX  S PSJOCDS(PSJX,"CONJ")="T"
 D DOSE^PSSDSAPD(.PSJBASE,DFN,.PSJOCDS,.PSJFDB)
 I $G(PSJFDB(1,"ROUTE"))["CONTINUOUS" D DELSING  ; Remove single dose message for continuous infusions
 D DISPLAY^PSJOCDSD
 ;I '$G(PSGORQF),(PSJTYPE="IV"),$G(PSJOCDSC("CX","PSJCOM")) D NODAILY^PSJOCDSP(PSJPON)
 K ^TMP($J,"PSJPRE"),^TMP($J,"PSJPRE1")
 Q
UD ;Process data from a UD order
 NEW PSJDS,PSJFREQ,X
 ;At this state a dispense drug should be selected already.  But just incase...
 Q:'+PSJDD
 K PSJOCDS,PSJFDB
 ;If the drug is to be exempted then exclude it from the dose check
 Q:$$EXMT^PSSDSAPI(PSJDD)
 S PSJCNT=1
 S PSJDS=""
 ;
 S PSJOCDS("CONTEXT")="IP-UD"
 S X=$$DOSE()
 S PSJOCDS(PSJCNT,"DRG_AMT")=$P(X,U)
 S PSJOCDS(PSJCNT,"DRG_UNIT")=$P(X,U,2)
 S PSJOCDS(PSJCNT,"DO")=$P(X,U,3)
 ;
 S X=$$DATES(PSJPON)
 S X=$$DURATION($P(X,U),$P(X,U,2))
 ;S X=$$DURATION($G(PSGSD),$G(PSGFD))
 S PSJOCDS(PSJCNT,"DRATE")=$S(+X:X_"M",1:"")
 ;S PSJOCDS(PSJCNT,"DUR")=X
 ;S PSJOCDS(PSJCNT,"DUR_RT")=$S(+X:"MINUTE",1:"")
 S PSJOCDS(PSJCNT,"MR_IEN")=$G(PSGMR)
 S PSJOCDS(PSJCNT,"SCHEDULE")=$G(PSGSCH)
 D FDBDATA
 ;D LITER
 Q
FDBDATA ;Set data needed by FDB's Dose API
 ;Use the OI + Dosage form when display drug name.  If OI IEN doesn't exist, use DD name
 NEW PSJOINM,PSJXSCH,X,PSJSFFG
 S PSJFDB(PSJCNT,"RX_NUM")="I;"_PSJPON_";PROSPECTIVE;"_PSJCNT
 S PSJFDB(PSJCNT,"DRUG_IEN")=PSJDD
 S PSJOINM="",PSJSFFG=0
 ; ^PS(53.45 nodes are not set for speed renew at this point.
 I +$G(PSJSPEED),($G(PSGOEE)="R"),(PSJPON["P") S PSJOINM=$$OINM(PSJPON),PSJSFFG=1
 I 'PSJSFFG S PSJOINM=$$DRGNM^PSGSICHK()
 S PSJFDB(PSJCNT,"DRUG_NM")=$S(PSJOINM]"":PSJOINM,1:$$DN^PSJMISC(+PSJDD))
 I PSJOCDS(PSJCNT,"DO")=(PSJOCDS(PSJCNT,"DRG_AMT")_PSJOCDS(PSJCNT,"DRG_UNIT")) D
 . Q:PSJOCDS(PSJCNT,"DO")=""
 .;Strip off leading zero otherwise FDB triggers an "Invalid or Undefined Dose"
 . S X=PSJOCDS(PSJCNT,"DRG_AMT")
 . S PSJFDB(PSJCNT,"DOSE_AMT")=$S(+X=0:X,1:+X)
 . S PSJFDB(PSJCNT,"DOSE_UNIT")=$$UNIT^PSSDSAPI(PSJOCDS(PSJCNT,"DRG_UNIT"))
 S PSJFDB(PSJCNT,"DOSE_RATE")="DAY"
 ;
 S X="",PSJXSCH=PSGSCH
 I $G(PSGS0XT)="" S PSGS0XT=$$DOW^PSJAPIDS(PSGSCH)
 ;"I $G(PSGS0XT)="D,$G(PSGS0Y)]"" S $P(PSJXSCH,"@",2)=$G(PSGS0Y)
 I $G(PSGS0XT)="D" S PSJXSCH=$$DOWCHK(PSJXSCH,$G(PSGS0Y))
 I $G(PSGSCH)]"" S X=$P($$FRQ^PSSDSAPI(PSJXSCH,$G(PSGS0XT),"I",,PSJDD),U)
 I X="" S X=1 S PSJFDB(PSJCNT,"FRQ_ERROR")=""
 S PSJFDB(PSJCNT,"FREQ")=X
 S PSJFDB(PSJCNT,"DURATION")=1
 S PSJFDB(PSJCNT,"DURATION_RT")="DAY"
 S PSJFDB(PSJCNT,"ROUTE")=$P($$MRT^PSSDSAPI($G(PSGMR)),U,2)
 S PSJFDB(PSJCNT,"DOSE_TYPE")="MAINTENANCE"
 S PSJFDB(PSJCNT,"SPECIFIC")=1
 ;Set data for onetime or <24 hours order
 ;PSJ*5*358
 S PSJXSCH=$G(PSJXSCH)
 I ($G(PSGSCH)[" PRN"),'$D(^PS(51.1,"APPSJ",PSGSCH)) S PSJXSCH=$P(PSGSCH," PRN",1)
 S X=$$ONE^PSJORPOE($G(PSJXSCH))
 I +X!($G(PSGST)="O")!+$$ONCALL^PSJMISC($G(PSJXSCH),$G(PSGST)) D  Q
 . K PSJFDB(PSJCNT,"FRQ_ERROR")
 . S PSJFDB(PSJCNT,"DOSE_TYPE")="SINGLE DOSE"
 . S PSJFDB(PSJCNT,"DURATION")=1
 . S PSJFDB(PSJCNT,"DURATION_RT")=PSJFDB(PSJCNT,"DURATION_RT")
 . S PSJFDB(PSJCNT,"FREQ")=1
 I +PSJOCDS(PSJCNT,"DRATE") D UND24HRS(+PSJOCDS(PSJCNT,"DRATE"),$G(PSGAT),$G(PSGS0XT),PSGSD,PSGFD,PSGSCH)
 Q
DOWCHK(PSJSCHD,PSJADM) ;Append the admin times to the schedule if it's not defined in 51.1
 ;Assuming the shedule is day of the week
 ;PSJSCHD - the schedule from the order
 ;PSJADM - the admin times from the order
 ;Output - the schedule name (as entered or appended to the schedule)
 I $G(PSJSCHD)="" Q ""
 I $D(^PS(51.1,"B",PSJSCHD)) Q PSJSCHD
 I $G(PSJADM)]"" S $P(PSJSCHD,"@",2)=PSJADM Q PSJSCHD
 Q PSJSCHD
LITER ;FDB requires "L" instead of ML for the particular conditions below
 ;PSJ*5*252 (6/29/11)- This module is longer called since FDB handles either "ML" or "L" now.
 NEW PSJXDO
 Q:'$G(PSJDD)
 Q:$G(PSJFDB(1,"ROUTE"))'="INTRAVENOUS"
 Q:$G(PSGST)'="R"
 Q:$$VAGEN^PSJMISC(PSJDD)'["POTASSIUM"
 Q:$$CLASS^PSJMISC(PSJDD)'="TN102"
 S PSJXDO=PSJOCDS(PSJCNT,"DO")
 I PSJXDO["ML" D
 . Q:'+PSJXDO
 . S (PSJOCDS(PSJCNT,"DRG_AMT"),PSJFDB(PSJCNT,"DOSE_AMT"))=+(+PSJXDO/1000)
 . S (PSJOCDS(1,"DRG_UNIT"),PSJFDB(PSJCNT,"DOSE_UNIT"))="L"
 Q
UND24HRS(PSJDUR,PSGAT,PSGS0XT,PSGSD,PSGFD,PSGSCH) ;
 ;*** This line tag is called by ^PSIVOCDS also ***
 ;PSJDUR - order duration in minutes
 ;PSGAT - admin times
 ;PSGS0XT - Order Frequency
 NEW PSJNDOSE,PSJFRQ1,PSJFRQX,PSJX
 Q:'+$G(PSJDUR)
 ; Set frequency to # of amdin times
 I ($G(PSGAT)]"") D  Q
 . S PSJX=$$DATES(PSJPON)
 . S PSJNDOSE=$$CNTDOSE($P(PSJX,U),$P(PSJX,U,2))
 . I PSJNDOSE S PSJFDB(PSJCNT,"FREQ")=PSJNDOSE Q
 ; Set frequency based on frequency(51.1)
 ; NUMB^PSSDSAPI is removed for MOCHA 2.1. Need to make sure PSJFRQ1 is in numeric value
 ;;S PSJFRQ2=$P($$FRQ^PSSDSAPI($G(PSGSCH),$G(PSGS0XT),"I",PSJDUR_"M",PSJDD),U)
 S PSJFRQ1=$P($$FRQ^PSSDSAPI($G(PSGSCH),$G(PSGS0XT),"I",PSJDUR_"M",PSJDD),U)
 ;;I PSJFRQ2?1"Q"1N.N1"H" S PSJFRQ2=1440/(+$E(PSJFRQ2,2,$L(PSJFRQ2))*60)
 ;;I PSJFRQ2?1"X"1N.N1"D" S PSJFRQ2=+$E(PSJFRQ2,2,$L(PSJFRQ2))
 ;;I +PSJFRQ2 S PSJFRQ1=(PSJFRQ2/24)*(+PSJDUR/60)
 ; If no value returned from FRQ^PSSDSAPI and frequency is there then set freq = duration in min / freq in min
 I '+$G(PSJFRQ1),+$G(PSGS0XT) S PSJFRQ1=(+PSJDUR)/PSGS0XT
 ; Calculate freq from number of dose admin per day (round up)
 S PSJFDB(PSJCNT,"FREQ")=$S(PSJFRQ1?.N:PSJFRQ1,1:$J((+$G(PSJFRQ1)+.5),0,0))
 I PSJFDB(PSJCNT,"FREQ")'=0 Q
 ; If no admin times or frequency(51.1) set error
 S PSJFDB(PSJCNT,"FREQ")=1
 S PSJFDB(PSJCNT,"FRQ_ERROR")=""
 Q
CNTDOSE(PSGSD,PSGFD) ;Count # of admins to set the Freq to
 ;only do this if the start & stop dates are within 24 hours.
 NEW PSJX,PSJADMIN,PSJCNT,PSJSTRTM,PSJSTPTM,PSJDTFLG
 I $G(PSGAT)="" Q 0
 I $G(PSGSD)="" Q 0
 I $G(PSGFD)="" Q 0
 I ($$FMDIFF^XLFDT(PSGFD,PSGSD,2)/60)>1440 Q 0
 S PSJCNT=0
 S PSJSTRTM=$E($P(PSGSD,".",2)_"0000",1,4)
 S PSJSTPTM=$E($P(PSGFD,".",2)_"0000",1,4)
 S PSJDTFLG=0
 I $P(PSGSD,".")=$P(PSGFD,".") S PSJDTFLG=1
 F PSJX=1:1 S PSJADMIN=$P(PSGAT,"-",PSJX) Q:PSJADMIN=""  D
 . S PSJADMIN=$E($P(PSGAT,"-",PSJX)_"0000",1,4)
 . I PSJDTFLG D  Q
 .. I (PSJSTRTM'>PSJADMIN),(PSJADMIN<PSJSTPTM) S PSJCNT=PSJCNT+1
 . I (PSJSTRTM'>PSJADMIN) S PSJCNT=PSJCNT+1
 . I (PSJSTPTM>PSJADMIN) S PSJCNT=PSJCNT+1
 Q PSJCNT
DURATION(PSGSD,PSGFD) ;Figure out the duration from the start, stop dates
 ;Return the diff between Stop - Start date in minutes.  If > 1 day then return null
 NEW PSJDIFF
 I '$D(PSGFD)!'$D(PSGSD) Q ""
 S PSJDIFF=$$FMDIFF^XLFDT(PSGFD,PSGSD,2)/60
 I (PSJDIFF<1440) Q PSJDIFF
 Q ""
DOSE() ;Figure out the dose, unit, & dosage Ordered
 ;Return 3 pieces: Numeric Dose ^ Unit ^ Dosage Ordered
 NEW PSJDS,PSJND0,PSJND2,X,PSJX,PSJXDOX,PSJNDS,PSJALLGY
 S PSJDS=""
 ;Subsequence orders in the Complex order has the PSGDO from the first order. Get new PSGDO
 I $G(PSJPON)["U",$S($G(PSJCOM):1,$G(PSGRENEW):1,1:0) S PSGDO=$P($G(^PS(55,DFN,5,+PSJPON,.2)),U,2)
 ;If the dose & unit exist use them
 I +$G(PSJDOSE("DO"))_$P($G(PSJDOSE("DO")),U,2)=$G(PSGDO) Q PSJDOSE("DO")_U_$G(PSGDO)
 ;Get dd, dose, unit from the order
 I $G(PSGORD)]"",'+$G(PSJDD) D
 . I PSGORD["P" S PSJND2=$G(^PS(53.1,+PSGORD,.2)),PSJDD=$O(^PS(53.1,+PSGORD,1,"B",0))
 . I PSGORD["U" S PSJND2=$G(^PS(55,DFN,5,+PSGORD,.2)),PSJDD=$O(^PS(55,+DFN,5,+PSGORD,1,"B",0))
 ;If no numeric dose and there is a dosage ordered then get dose & unit from the order
 I $D(PSGORD),$G(PSGDO)]"" D
 . S PSJDS=$P($G(PSJND2),U,5,6)
 Q:+PSJDS PSJDS_U_$G(PSGDO)
 ;Get dispense unit per dose and figure out numeric and unit
 I +$G(PSJDD),($G(PSGDO)]"") D
 . S PSJDS=$$DOSE1()
 . I $P($G(PSJXDOX(1)),U,11)=$$UP^XLFSTR(PSGDO) Q:+PSJDS
 . S PSJDS=""
 . S PSJX=$G(PSJXDOX(1))
 . I +PSJX S X=+PSGDO/+PSJX S PSJDS=$$DOSE1(X)
 . I $P($G(PSJXDOX(1)),U,11)=$$UP^XLFSTR(PSGDO) Q:+PSJDS
 . S PSJDS=""
 Q:+PSJDS PSJDS
 I +$G(PSJDD),($G(PSGDO)=""),($G(PSGORD)="") D
 . S PSJDS=$$DOSE1($S(+$G(PSGUD):PSGUD,1:1))
 Q:+PSJDS PSJDS
 ;Figure out dose & unit from the dispense drug.  Dosage Ordered is required for multiple dispense drugs
 I $G(PSGDO)="" D
 . S PSJND0=$$DD53P45^PSJMISC()
 . I PSJND0="" S PSJND0=$G(PSGDRG)
 . S X=+$P(PSJND0,U,2) S PSJDS=$$DOSE1($S(X:X,1:1))
 Q:+PSJDS PSJDS
 Q "^^"_$G(PSGDO)
DOSE1(PSJDUP) ;
 ;PSJDUP - Dispense unit per dose
 NEW PSJDS
 Q:'+$G(PSJDD)
 K PSJXDOX
 S PSJDS=""
 D DOSE^PSSORPH(.PSJXDOX,+PSJDD,"U",,$G(PSJDUP))
 S:$G(PSJXDOX(1)) PSJDS=$P(PSJXDOX(1),U,1,2)_U_$P(PSJXDOX(1),U)_$P(PSJXDOX(1),U,2)
 Q PSJDS
DATES(PSJPON) ;Check the correct Start, Stop dates to use
 ;PSJOCDSC("CX",PSGsd/PSGfd,on)=default PSGsd/PSGfd date _^_ PSGsd/PSGfd _^_PSJFLG
 ;PSJP1 = Start date; PSJP2 = Stop date; PSJFLG = 1 if start or stop date has changed.
 ;For some reasons, PSGSD redefined to cal start date for Complex order (one with duration),
 ; PSGFD redefined to cal stop date.  These 2 fields reflect the default start, stop dates if they
 ; were edited.
 ;
 NEW PSJXSD,PSJXFD,PSJP1,PSJP2,PSJFLG,X
 I '+$G(PSJPON) Q $G(PSGSD)_U_$G(PSGFD)_U_0
 S PSJFLG=0
 S PSJP1=$G(PSGSD),PSJP2=$G(PSGFD)
 I $D(PSJOCDSC("CX","PSGSD")) D
 . S PSJXSD=$G(PSJOCDSC("CX","PSGSD",+PSJPON))
 . S PSJXFD=$G(PSJOCDSC("CX","PSGFD",+PSJPON))
 . I PSGSD=$P(PSJXSD,U,2) S PSJP1=$P(PSJXSD,U)
 .;
 . I $P(PSJXFD,U,2)]"",(PSGFD=$P(PSJXFD,U,2)) S PSJP2=$P(PSJXFD,U)
 . I $P(PSJXFD,U,2)="" S $P(PSJXFD,U,2)=PSGFD,PSJP2=PSGFD
 .;
 .; I $P(PSJXFD,U,2)="" S $P(PSJXFD,U,2)=PSGFD
 .; I PSGFD=$P(PSJXFD,U,2) S PSJP2=$P(PSJXFD,U)
 . I (PSJXSD]"")!(PSJXFD]"") D
 .. I $S($G(PSGSD)'=$P(PSJXSD,U,2):1,$G(PSGFD)'=$P(PSJXFD,U,2):1,1:0) S PSJFLG=1
 . S X=$G(^PS(53.1,+PSJPON,2.5))
 . ;Reset PSJP1 & PSJP2 from the order is needed when complex order defaulted to IV but FN as UD,
 . ; the calc Start/stop dates were used therefore the duration was not considered.
 . I (PSJPON["P"),(PSJFLG=0),($P(X,U,2)]"") S PSJP1=$P(X,U,1),PSJP2=$P(X,U,3)
 Q PSJP1_U_PSJP2_U_PSJFLG
OINM(PSJPON) ;For speed renew, returns OI name if order has multiple DD else returns null
 NEW PSJCNT,PSJDD,PSJOINM,PSJOI
 I $G(PSJPON)'["P" Q
 S PSJCNT=0
 F PSJDD=0:0 S PSJDD=$O(^PS(53.1,+PSJPON,1,PSJDD)) Q:'PSJDD  S PSJCNT=PSJCNT+1
 I PSJCNT>1 S PSJOI=+$G(^PS(53.1,+PSJPON,.2)) S PSJOINM=$$OIDF^PSJLMUT1(+PSJOI)
 Q $G(PSJOINM)
 ;
DELSING ; Find and delete single dose message on continuous IV orders
 ;  ^TMP(9980,"PSJPRE1","OUT",1,"I;55V;PROSPECTIVE;1","MESSAGE","1_SINGLE",1609)
 ;  
 N MSGL,MTYPE
 S MSGL=""
 F  S MSGL=$O(^TMP($J,PSJBASE(3),"OUT",1,MSGL)) Q:MSGL=""  D
 .  S MTYPE=""
 .  F  S MTYPE=$O(^TMP($J,PSJBASE(3),"OUT",1,MSGL,"MESSAGE",MTYPE)) Q:MTYPE=""  D
 .  .  I MTYPE["_SINGLE_" D RESETI Q
 .  .  I MTYPE["SINGLE" K ^TMP($J,PSJBASE(3),"OUT",1,MSGL,"MESSAGE",MTYPE)
 .  .  Q
 .  Q
 Q
 ;
RESETI ; Change subscript for ITEM from SINGLE_RANGE to _RANGE
 N CNT,I,NITM,X
 S NITM=""
 F I=1:1:$L(MTYPE,"_") S X=$P(MTYPE,"_",I) I X'="SINGLE" S $P(NITM,"_",$I(CNT))=$P(MTYPE,"_",I)
 I NITM'="" D
 . M ^TMP($J,PSJBASE(3),"OUT",1,MSGL,"MESSAGE",NITM)=^TMP($J,PSJBASE(3),"OUT",1,MSGL,"MESSAGE",MTYPE)
 . K ^TMP($J,PSJBASE(3),"OUT",1,MSGL,"MESSAGE",MTYPE)
 Q
