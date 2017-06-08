FBPCR2 ;ALBISC/DMK,GRR,TET - OUTPATIENT POTENTIAL COST RECOVERY SORT/PRINT ;2/4/93  09:56
 ;;3.0;FEE BASIS;**12**;NOV 26, 1993
EN ;entry point
 S (FBCATC,FBINS,FBPSF)=0
SORT ;sort by date finalized, patient, vendor, treatment ien, service ien
 S I=FBBDATE-.1 F  S I=$O(^FBAAC("AK",I)) Q:'I!(I>FBEDATE)  S J=0 F  S J=$O(^FBAAC("AK",I,J)) Q:'J  D
 .S DFN=J D VET^FBPCR
 .S K=0  F  S K=$O(^FBAAC("AK",I,J,K)) Q:'K  S L=0 F  S L=$O(^FBAAC("AK",I,J,K,L)) Q:'L  D SETTR S M=0 F  S M=$O(^FBAAC("AK",I,J,K,L,M)) Q:'M  D  S (FBCATC,FBINS,FBPSF)=0
 ..D SET Q:'FBPSV&('$D(FBPSV(FBPSF)))  I FBCATC!FBINS D SETTMP
KILL ;kill variables set in this routine
 K A1,A2,A3,D,D2,DFN,FBAACPTC,FBBN,FBCATC,FBCP,FBDOB,FBDOS,FBDT,FBDT1,FBIN,FBINS,FBOB,FBP,FBPAT,FBPCR,FBPDX,FBPDXC,FBPID,FBPNAME,FBPSF,FBSC,FBTA,FBTYPE,FBVEN,FBVID,FBVNAME,FBVP,I,J,K,L,M,T,Y
 Q
SET ;set variables - also entry point from FBPCR67
 N FBPCR
 S Y=$G(^FBAAC(J,1,K,1,L,1,M,0)) Q:'+$P(Y,U,9)!($G(^FBAAC(J,1,K,1,L,1,M,"FBREJ"))]"")
 S FBVNAME=$E($P($G(^FBAAV(K,0)),U),1,35),FBVID=$S(FBVNAME]"":$P(^(0),U,2),1:"")
 S FBP=+$P(Y,U,9),FBSC=$P(Y,U,27),FBPDX=+$P(Y,U,23),FBPSF=+$P(Y,U,12)
 S FBSC=$S(FBSC="Y":"YES",FBSC="N":"NO",1:"-")
 S T=$P(Y,U,5),D2=$P(Y,U,6),FBDOS=D2,D2=$$DATX^FBAAUTL(D2),FBCP=$P(Y,U,18),FBCP=$S(FBCP=1:"(C&P)",1:"")
 Q:FBCP]""!('FBPSV&('$D(FBPSV(FBPSF))))  S FBPCR=+$G(^FBAAC(J,1,K,1,L,0)),FBCATC=$$CATC^FBPCR(DFN,FBPCR),FBINS=$S(FBSC["N":1,1:0) Q:'FBCATC&'FBINS
 S FBAACPTC=$P($G(^ICPT(+Y,0)),U),FBOB=$P(Y,U,10)
 I T]"" S T=$P($G(^FBAA(161.27,+T,0)),U)
 S FBTYPE=$P(Y,U,20),FBVP=$P(Y,U,21),FBIN=$P(Y,U,16),FBBN=$P(Y,U,8),FBBN=$S(FBBN']"":"",$D(^FBAA(161.7,FBBN,0)):$P(^(0),U),1:""),FBBN=$S(FBBN="":"",1:$E("00000",$L(FBBN)+1,5)_FBBN)
 S FBVEN=FBVNAME_";"_FBVID,FBPAT=FBPNAME_";"_DFN
 ;output format
 S A1=$J($P(Y,U,2),6,2),A2=$J($P(Y,U,3),6,2),A3=$J(A3,6,2),FBIN=$J(FBIN,7)
 S FBDT1=$S(FBVP="VP":"#",1:"")_$S(FBTYPE="R":"*",1:" ")_FBDT
 Q
SETTMP ;sort data by primary service facility, patient, fee program, vendor, date
 I $P(Y,U,9)'=FBPI Q
 S ^TMP($J,"FB",FBPSF,FBPAT,FBP,FBVEN,I,L_M)=FBDT1_U_FBAACPTC_FBCP_U_A1_U_A2_U_T_U_FBBN_U_FBIN_U_D2_U_FBSC_U_FBPDX_U_FBOB_U_FBPI_U_FBCATC_U_FBINS
 Q
SETTR S D=$S($D(^FBAAC(J,1,K,1,L,0)):$P(^(0),"^",1),1:""),A3=".00"
 I D]"",$D(^FBAAC(J,3,"AB",D)) S FBTA=$O(^FBAAC(J,3,"AB",D,0)),A3=$S($P(^FBAAC(J,3,FBTA,0),"^",3)]"":$P(^(0),"^",3),1:.0001)
 S FBDT=$$DATX^FBAAUTL(D)
 Q
EN1 ;entry point to set variables, called by fbpcr67, anc
 N FBVEN,FBPAT,FBDT1
 D SETTR,SET
 Q
PRINT ;write output
 D HDR1 S FBVI="" F  S FBVI=$O(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI)) Q:FBVI']""!(FBOUT)  D SH Q:FBOUT  D  Q:FBOUT
 .S FBDT=0 F  S FBDT=$O(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT)) Q:'FBDT  S M=0 F  S M=$O(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,M)) Q:'M  D  Q:FBOUT
 ..I ($Y+4)>IOSL D PAGE Q:FBOUT
 ..S FBDATA=^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,M),FBCATC=$P(FBDATA,U,13),FBINS=$P(FBDATA,U,14)
 ..S FBLOC=1_U_12_U_23_U_33_U_47_U_57_U_63_U_71
 ..W ! F I=1:1:8 W ?$P(FBLOC,U,I),$P(FBDATA,U,I)
 ..S FBPDX=$P(FBDATA,U,10),FBPDXC=$P($G(^ICD9(FBPDX,0)),U),$P(FBDATA,U,10)=$E($P($G(^ICD9(FBPDX,0)),U,3),1,19),FBPDXC=$S(FBPDXC="":"",1:" ("_FBPDXC_")")
 ..W !?3,"Primary Dx: ",$P(FBDATA,U,10),FBPDXC,?45,"S/C Condition? ",$P(FBDATA,U,9) W ?66,"Obl.#: ",$P(FBDATA,U,11)
 ..I FBCATC!FBINS W !?5,">>> Cost recover from "_$S(FBCATC:"means testing",FBINS:"insurance",1:"") W:FBCATC&FBINS " and insurance" W "."
 ..S A3=".00"
 Q
HDR ;main header
 D HDR^FBPCR Q:FBOUT
HDR1 W !!?(IOM-(13+$L(FBXPROG))/2),"FEE PROGRAM: ",FBXPROG
 W !!,?2,"Svc Date",?11,"CPT Code",?23,"Amount",?33," Amount",?42,"Susp",?49,"Travel",?57,"Batch",?63,"Invoice",?71,"Voucher"
 W !,?23,"Claimed",?35,"Paid",?42,"Code",?50,"Paid",?58,"Num",?64,"Num",?72,"Date",!,FBDASH
 Q
SH ;subheader - vendor, prints when name changed
 I ($Y+6)>IOSL D HDR Q:FBOUT
 W !!,"Vendor: ",$P(FBVI,";"),?41,"Vendor ID: ",$P(FBVI,";",2)
 Q
CR ;read for display
 S DIR(0)="E" W ! D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) FBOUT=1
 Q
PAGE ;new page
 D HDR Q:FBOUT  D SH
 Q
