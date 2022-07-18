PSJOE0 ;BIR/CML3-INPATIENT PROFILE AND ORDER ENTRY ;Mar 06, 2020@10:39
 ;;5.0;INPATIENT MEDICATIONS;**47,56,110,133,162,241,267,275,302,366,319**;16 DEC 97;Build 31
 ;
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^VA(200 is supported by DBIA 10060.
 ; Reference to ^DIR is supported by DBIA 10026.
 ;
START ; print orders
 W:X]"" $P("^PROFILE",X,2) D ENL^PSJO3 G:PSJOL="^" DONE Q:PSJOL="N"  K PSJPR S PSGOEAV=0,PSJNARC=1 D ^PSJO I 'PSJON Q
 ;
ENVW ; ask user to select or view any of the orders shown
 S (PSGONC,PSGONR,PSGONV)=0,PSGLMT=PSJON S:$D(PSJPRF) PSGPRF=1 D ENASR^PSGON K PSGPRF
 G:X["^" DONE I X]"" S PSGOEA=""
 K PSJDLW
 I  F PSJOE=1:1:PSGODDD S PSGOE=PSJOE F PSJOE1=1:1:$L(PSGODDD(PSJOE),",")-1 S PSJOE2=$P(PSGODDD(PSJOE),",",PSJOE1),(PSGORD,PSJORD)=^TMP("PSJON",$J,PSJOE2) G:$D(PSJDLW) DONE D
 .I PSJORD=+PSJORD N PSJO,PSJO1 S PSJO=PSJORD,PSJO1=0 F  S PSJO1=$O(^PS(53.1,"ACX",PSJO,PSJO1)) Q:'PSJO1  Q:PSGOEA["^"  Q:$D(PSJDLW)  S PSJORD=PSJO1_"P" D GODO S PSJORD=""
 .Q:PSJORD=""  Q:PSGOEA["^"
 .D GODO Q:PSGOEA["^"
 Q
 ;
LMNEW(PSGP,PSJPROT) ;Entry point for new order entry from listman.
 ; PSGP = DFN
 ; PSJPROT=1:UD ONLY; 2:IV ONLY; 3:BOTH
 ;
 N PSJDEC,PSJCM01,PSJCMF S (PSJCM01,PSJCMF)=0 D CKNEW Q:$G(PSJDEC)  N PSJUDPRF S PSJNEWOE=1
 S PSGPTS=PSJPTS,PSGOEAV=$P(PSJSYSP0,U,9)&PSJSYSU,PSGOEDMR="",PSGOEPR=$S($D(^PS(55,PSGP,5.1)):$P(^(5.1),"^",2),1:0),PSJORQF=0,PSJOEPF=""
 ;*366 - check provider credentials
 I PSGOEPR>0 S PSGOEPR=$S($$ACTPRO^PSGOE1(PSGOEPR):PSGOEPR,1:0)
 S:'PSGOEPR PSGOEPR=PSJPTSP
 S PSJPCAF=$S($G(PSJPCAF):PSJPCAF,1:"1")
 K P("CLIN"),P("APPT") ;P319 clean-up variables
 F PSJOE=0:0 Q:PSJORQF!('$P(PSJPCAF,"^",2)&(PSJPROT'>1)&('PSJCM01))!('(PSJPCAF&(PSJPROT'=2))&(PSJPROT'>1)&('PSJCM01))!(PSJCM01=-1)  D KILL^PSJBCMA5(+$G(PSJSYSP)) D:$G(PSJCMO)!(PSJCM01) CM Q:PSJCM01=-1  D
 .D:(PSJPCAF&($P(PSJPCAF,"^",2))&(PSJPROT'=2))!(($G(PSJCMO)!(PSJCM01))&(PSJPROT'=2)) EN^PSJOE1 K PSGEFN,PSGOEF D:PSJCM01=-1 CMK Q:PSJCM01=-1  I PSJPROT>1 D ENIN^PSIVORE ;D:PSJCM01!$G(PSJCMO) CMK
 K PSJCM01,PSJCMO
 Q
 ;
DONE ;
 K PSG,PSGDL,PSGDLS,PSGDO,PSGDRG,PSGDRGN,PSGFD,PSGHSM,PSGMR,PSGMRN,PSGNEDFD,PSGNEFD,PSGNESD,PSGOES,PSGOPR,PSGORD,PSGOROE1,PSGPR,PSGPRN,PSGS0XT,PSGS0Y,PSGSCH,PSGSD,PSGSI,PSGSM,PSGST,PSGSTN,PSGUD,PSGX,PSJDLW,PSJLM,PSJNARC,PSIVAC
 K P,PSGEFN,PSGOEEF
 Q
CM ; Clinic Medication Order ;*p319
 D CM^PSJOE1
 I PSJCM01=-1 D CMK
 Q
 ;
CMK ; Clean-up CM variables *p319
 K PSJCLAPP,P("CLIN"),P("CLINO"),P("APPT"),P("APPTO"),PSJCMF
 S VALMBCK="Q"
 Q
 ;
CKNEW ;
 K CF,CHK,OD,PSGLMT,PSGODDD,PSGOEA,PSGON,PSGONC,PSGONR,PSGONV,PSGORD,PSJCOM,PSJOE1,PSJOE2 Q:$D(PSJPRF)
 D DEM^VADPT I $G(VADM(6)) W !!?2,"Patient is shown as deceased.  You may not enter orders for this patient." S PSJDEC=1 D CONT Q
 I $G(PSJCMO) S PSJCM01=1 Q
 I 'PSJPCAF D
 .N DIR,X,Y W ! S DIR(0)="Y",DIR("A")="Is this a Clinic Medication order" D ^DIR
 .I Y=0 W !!,"(NOTE: You cannot enter Unit Dose orders for this patient.)" D CONT Q
 .I Y S PSJCM01=1 Q
 .I $D(DIRUT)!'Y S PSJDEC=1
 Q
 ;
CONT ;
 K DIR S DIR(0)="EA",DIR("A")="Press Return to continue..." D ^DIR
 Q
 ;
GODO ;Display selected order.
 S PSIVAC="C" I $S(PSJORD["V":1,PSJORD["P":$P($G(^PS(53.1,+PSJORD,0)),"^",4)="F",1:0) D @$S($D(PSJPRP):"ENINP^PSIVOPT(DFN,PSJORD)",1:"ENIN^PSIVOPT") G GODO1
 I '$D(PSJPRP),(PSJORD["P"),($P($G(^PS(53.1,+PSJORD,0)),U,4)="I") D ASKTYP Q:$D(DIRUT)  I Y="I" D ENIN^PSIVOPT G GODO1
 S PSGORD=PSJORD D EN2^PSGVW,^PSGOE1:'$D(PSJPRF)
GODO1 ;
 I $D(PSJPRP),'PSJPR K DIR S DIR(0)="E" D ^DIR K DIR S:$D(DUOUT)!$D(DTOUT) PSJDLW=1 Q:$D(PSJDLW)  W:$Y @IOF
 Q
 ;
ASKTYP ; Ask if completing as IV or UD.
 Q
 W !! D PIV^PSIVUTL(+PSJORD_"P")
 I $G(PSJPDD) S DIR(0)="E" D ^DIR S Y="I" Q
 W ! K DIR S DIR(0)="SOA^U:Unit Dose;I:IV Medication",DIR("A")="Do you wish to complete this as an IV or Unit Dose order (I/U)? ",DIR("?")="^D PENDIU^PSJO3" D ^DIR
 Q
 ;
OLDCOM(DFN,PSJORD) ;
 Q:$$COMPLEX^PSJOE(DFN,PSJORD)
 N DURFLG S DURFLG=$S($G(PSJORD)["P":$G(^PS(53.1,+PSJORD,2.5)),$G(PSJORD)["V":$G(^PS(55,DFN,"IV",+PSJORD,2.5)),1:$G(^PS(55,DFN,5,+PSJORD,2.5))) I $P(DURFLG,"^",2)]"" D
 . D CLEAR^VALM1 W !!!!!?21," * WARNING * "
 . W !!!?5,"The following order contains a Requested Duration"
 . W !?12,"and may be part of a complex dose!"
 . W !!," Review the entire profile to determine appropriate action(s).",!!!!!!! D PAUSE^VALM1
 Q
AM ;
 W !!?2,"Enter a 'Y' (or press the RETURN key) to enter new INPATIENT orders for this",!,"patient.  Enter an 'N' (or an '^') if there are no new orders for this patient."
 W:'PSJPCAF !!?2,"PLEASE NOTE: The patient selected is NOT shown as currently admitted.",!,"Therefore, you cannot enter Unit Dose orders for this patient.  (You can enter",!,"IV orders.)" Q
