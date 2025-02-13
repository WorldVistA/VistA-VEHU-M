ECXUD ;ALB/JAP,BIR/DMA,PTD-Extract from UNIT DOSE EXTRACT DATA File (#728.904) ;6/26/19  10:46
 ;;3.0;DSS EXTRACTS;**10,8,24,33,39,46,49,71,84,92,107,105,120,127,144,149,154,161,166,170,174,178,181,184,187**;Dec 22, 1997;Build 163
 ;
 ; Reference to $$LJ^XLFSTR in ICR #10104
 ; Reference to EN^DIQ1 in ICR #10015
 ; Reference to ^DG(40.8,0) in ICR #417
 ; Reference to ^DG(40.8,"AD") in ICR #2817
 ; Reference to ^TMP($J supported by SACC 2.3.2.5.1
 ; Reference to ^DIC(42 in ICR #1848
 ; Reference to $$DSS^PSNAPIS in ICR #2351
 ; Reference to $$NPI^XUSNPI in ICR #4532
 ;
BEG ;entry point from option
 I '$O(^ECX(728.904,"A",0)) W !,"There are no unit dose orders to extract",!! R X:5 K X Q
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ;start package specific extract
 N RERUN,ECXLDT ;149
 S RERUN=0 ;149
 S ECXLDT=+$P($G(^ECX(728,1,ECNODE)),U,ECPIECE) ;149 Get last run date
 I ECXLDT'<ECSD S RERUN=1 ;149
 S QFLG=0
 S ECED=ECED+.3
 F ECD=ECSD1:0 S ECD=$O(^ECX(728.904,"A",ECD)) Q:'ECD  Q:ECD>ECED  Q:QFLG  D
 .S ECXJ=0 F  S ECXJ=$O(^ECX(728.904,"A",ECD,ECXJ)) Q:'ECXJ  Q:QFLG  I $D(^ECX(728.904,ECXJ,0)) D
 ..S DATA=^ECX(728.904,ECXJ,0),^(1)=$P(EC23,U,2),^ECX(728.904,"AC",$P(EC23,U,2),ECXJ)="" D STUFF
 K ^TMP($J,"ECXP")
 I $D(^TMP($J,"ECXUDM")) D SENDMSG^ECXUD1 ;181 - Send messages with list of clinics with NO/Inactive Stop Code
 I 'RERUN D CLEAN(0,$$FMADD^XLFDT(ECSD,-180)) ;149 Remove old log entries
 Q
 ;
STUFF ;get data
 N X,W,OK,P1,P3,PSTAT,PT,ECXPHA,ON,ECDRG,ECXESC,ECXECL,ECXCLST,ECPROIEN,ECXUDDT,ECXUDTM,ECXNEW ;144,149
 N ECXSTANO,ECXASIH,ECXDEA,ECXCLIN  ;166,170,174
 N ECXNMPI,ECXCERN,ECXSIGI ;184
 N ECXDUNIT,ECXPPDU ;187 Add Dispense Unit and Price Per Dispense Unit
 S (ECXNMPI,ECXCERN,ECXSIGI)="" ;184
 S (ECXESC,ECXECL,ECXCLST)="" ;144
 S ECXDFN=$P(DATA,U,2),ECDRG=$P(DATA,U,4)
 ;
 ;get patient specific data
 S ECXERR="" D PAT(ECXDFN,ECD,.ECXERR)
 Q:ECXERR
 ;
 S ECXPRO=$P(DATA,U,7),ECPROIEN=+ECXPRO,ECXPRO=$E($P(ECXPRO,";",2))_$P(ECXPRO,";")
 S ECXPRNPI=$$NPI^XUSNPI("Individual_ID",ECPROIEN,ECD)
 S:+ECXPRNPI'>0 ECXPRNPI="" S ECXPRNPI=$P(ECXPRNPI,U)
 S W=$P(DATA,U,6)
 S ECXW=$S(ECXADM="":"",1:$P($G(^DIC(42,+W,44)),U)) ;154 Ward gets set to null if this is an order for an outpatient
 S ON=$P(DATA,U,10) ;174 Setting of Order Number moved up
 I ECXW S ECXDIV=$P($G(^DIC(42,+W,0)),U,11) ;174 For inpt get division from ward
 I ECXW="" D  ;174 Handle outpt with no ward (clinic order)
 .S ECXCLIN=+$$GET1^DIQ(55.06,ON_","_ECXDFN_",",130,"I") ;174 Get clinic med was given in
 .S ECXDIV=$$GET1^DIQ(44,ECXCLIN,3.5,"I") ;174 Medical center division associated with clinic
 I $$GET1^DIQ(4,+$P($G(^DG(40.8,+ECXDIV,0)),U,7),101,"I")!(ECXDIV="") S ECXDIV=$O(^DG(40.8,"AD",+$G(^ECX(728,1,0)),0)) ;174 If institution is inactive or blank then set division to DSS default
 S ECXSTANO=$$GETDIV^ECXDEPT(ECXDIV) ;166 tjl - Get Patient Division based on Facility
 S ECXUDDT=$$ECXDATE^ECXUTL($P(DATA,U,3),ECXYM)
 S ECXUDTM=$E($P($P(DATA,U,3),".",2)_"000000",1,6)
 S ECXQTY=$P(DATA,U,5),ECXCOST=$P(DATA,U,8) ;174
 ;call pharmacy drug file (#50) api via ecxutl5
 S ECXPHA=$$PHAAPI^ECXUTL5(ECDRG)
 S ECCAT=$P(ECXPHA,U,2),(ECINV,ECXDEA)=$P(ECXPHA,U,4) ;174
 I ECXLOGIC<2014 D  ;New way to calculate cost dea spl hndlg **144
 .S ECINV=$S(ECINV["I":"I",1:"")
 I ECXLOGIC>2013 D
 .S ECINV=$S((+ECINV>0)&(+ECINV<6):+ECINV,ECINV["I":"I",1:"")
 S ECNDC=$P(ECXPHA,U,3)
 S ECNFC=$$RJ^XLFSTR($P(ECNDC,"-"),6,0)_$$RJ^XLFSTR($P(ECNDC,"-",2),4,0)_$$RJ^XLFSTR($P(ECNDC,"-",3),2,0),ECNFC=$TR(ECNFC,"*",0)
 I ECNDC["LCL"!(ECNDC["LCD") S ECNDC="" ;170,174 Reset NDC to null if it's missing from file 50
 S P1=$P(ECXPHA,U,5),P3=$P(ECXPHA,U,6),X="PSNAPIS"
 S ECXDUNIT=$P(ECXPHA,U,8),ECXPPDU=$P(ECXPHA,U,7) ;187
 X ^%ZOSF("TEST") I $T S ECNFC=$$DSS^PSNAPIS(P1,P3,ECXYM)_ECNFC
 I $L(ECNFC)=12 S ECNFC=$$RJ^XLFSTR(P1,4,0)_$$RJ^XLFSTR(P3,3,0)_ECNFC
 ; - Department and National Production Division
 ;- Use of DSS Department postponed [S ECXDSSD=$$UDP^ECXDEPT(ECXDIV)]
 S ECXDSSD=""
 S ECXPDIV=$$GETDIV^ECXDEPT(ECXDIV)
 ;- Observation patient indicator (YES/NO)
 S ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS)
 ;- Ordering Date, Ordering Stop Code
 S ECXORDDT=$TR($$FMTE^XLFDT($P(DATA,U,9),"7DF")," /","0")
 S ECXORDST="" I ECXA="O" D
 .;Get ordering stop code based on FY 2006 logic for outpatient
 .S ECXORDST=$$DOUDO^ECXUTL5(ECXDFN,ON)
 .I $P(ECXORDST,U,2)'="" D  ;181 - No/Inactive Stop Code, default to PHA. Save information to send mail later
 ..D SETTMP(ECXORDST)
 ..S ECXORDST="PHA"
 ;Ordering Provider Person Class
 S ECXOPPC=$$PRVCLASS^ECXUTL($E(ECXPRO,2,999),$P(DATA,U,9))
 S (ECXBCDD,ECXBCDG,ECXBCUA,ECXBCIF)="" ;144 BCMA are place holders now
 ;- Set national patient record flag if exist
 D NPRF^ECXUTL5
 ;149 Determine if script required pharmacist workload
 S ECXNEW=$$NEW ;149
 ;- If no encounter number don't file record
 S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADM,$P(DATA,U,3),ECXTS,ECXOBS,ECHEAD,,)
 I $G(ECXASIH) S ECXA="A" ;170
 D:ECXENC'="" FILE
 Q
 ;
PAT(ECXDFN,ECXDATE,ECXERR) ;get demographics from patient file
 ;init variables
 S (ECXCAT,ECXSTAT,ECXPRIOR,ECXSBGRP,ECXOEF,ECXOEFDT)=""
 ;get patient data if saved
 I $D(^TMP($J,"ECXP",ECXDFN)) D
 .S PT=^TMP($J,"ECXP",ECXDFN),ECXPNM=$P(PT,U),ECXSSN=$P(PT,U,2)
 .S (ECXNMPI,ECXMPI)=$P(PT,U,3),ECXDOB=$P(PT,U,4) ;184 - Added ECXNMPI
 .S ECXELIG=$P(PT,U,5),ECXSEX=$P(PT,U,6)
 .S ECXSTATE=$P(PT,U,7),ECXCNTY=$P(PT,U,8),ECXZIP=$P(PT,U,9)
 .S ECXVET=$P(PT,U,10),ECXPOS=$P(PT,U,11),ECXPST=$P(PT,U,12)
 .S ECXPLOC=$P(PT,U,13),ECXRST=$P(PT,U,14),ECXAST=$P(PT,U,15)
 .S ECXAOL=$P(PT,U,16),ECXPHI=$P(PT,U,17),ECXMST=$P(PT,U,18)
 .S ECXENRL=$P(PT,U,19),ECXCNHU=$P(PT,U,20),ECXCAT=$P(PT,U,21)
 .S ECXSTAT=$P(PT,U,22),ECXPRIOR=$P(PT,U,23),ECXHNCI=$P(PT,U,24)
 .S ECXETH=$P(PT,U,25),ECXRC1=$P(PT,U,26),ECXMTST=$P(PT,U,27)
 .S PT1=$G(^TMP($J,"ECXP",ECXDFN,1)),ECXERI=$P(PT1,U),ECXEST=$P(PT1,U,2),ECXOEF=$P(PT1,U,3),ECXOEFDT=$P(PT1,U,4),ECXCNTRY=$P(PT1,U,5)
 .S ECXSHADI=$P(PT1,U,6),ECXPATCAT=$P(PT1,U,7),ECXCLST=$P(PT1,U,8) ;144
 .S ECXSIGI=$P(PT1,U,11) ;184
 .I $$ENROLLM^ECXUTL2(ECXDFN)
 ;set patient data
 I '$D(^TMP($J,"ECXP",ECXDFN)) D  Q:'OK
 .K ECXPAT S OK=$$PAT^ECXUTL3(ECXDFN,$P(ECXDATE,"."),"1;2;3;5",.ECXPAT)
 .I 'OK K ECXPAT S ECXERR=1 Q
 .S ECXPNM=ECXPAT("NAME"),ECXSSN=ECXPAT("SSN"),(ECXMPI,ECXNMPI)=ECXPAT("MPI") ;184 - field added ECXNMPI
 .S ECXDOB=ECXPAT("DOB"),ECXELIG=ECXPAT("ELIG"),ECXSEX=ECXPAT("SEX")
 .S ECXSTATE=ECXPAT("STATE"),ECXCNTY=ECXPAT("COUNTY")
 .S ECXZIP=ECXPAT("ZIP"),ECXVET=ECXPAT("VET"),ECXCNTRY=ECXPAT("COUNTRY")
 .S ECXPOS=ECXPAT("POS"),ECXPST=ECXPAT("POW STAT")
 .S ECXPLOC=ECXPAT("POW LOC"),ECXRST=ECXPAT("IR STAT")
 .S ECXAST=ECXPAT("AO STAT"),ECXAOL=ECXPAT("AOL")
 .S ECXPHI=ECXPAT("PHI"),ECXMST=ECXPAT("MST STAT")
 .S ECXENRL=ECXPAT("ENROLL LOC"),ECXMTST=ECXPAT("MEANS")
 .S ECXCLST=ECXPAT("CL STAT") ;144
 .S ECXSVCI=ECXPAT("COMBSVCI") ;149 COMBAT SVC IND
 .S ECXSVCL=ECXPAT("COMBSVCL") ;149 COMBAT SVC LOC
 .S ECXSIGI=ECXPAT("SIGI") ;184 Self Identified Gender
 .;OEF/OIF data
 .S ECXOEF=ECXPAT("ECXOEF")
 .S ECXOEFDT=ECXPAT("ECXOEFDT")
 .;get CNHU status
 .S ECXCNHU=$$CNHSTAT^ECXUTL4(ECXDFN)
 .;get enrollment data (category, status and priority)
 .I $$ENROLLM^ECXUTL2(ECXDFN)
 .; - Head and Neck Cancer Indicator
 .S ECXHNCI=$$HNCI^ECXUTL4(ECXDFN)
 .; - Proj. 112/SHAD Indicator
 .S ECXSHADI=$$SHAD^ECXUTL4(ECXDFN)
 . ; ******* - PATCH 127, ADD PATCAT CODE ********
 .S ECXPATCAT=$$PATCAT^ECXUTL(ECXDFN)
 .; - Race and Ethnicity
 .S ECXETH=ECXPAT("ETHNIC")
 .S ECXRC1=ECXPAT("RACE1")
 .;get emergency response indicator (FEMA)
 .S ECXERI=ECXPAT("ERI")
 .S ECXEST=ECXPAT("EC STAT")
 .;save for later
 .S ^TMP($J,"ECXP",ECXDFN)=ECXPNM_U_ECXSSN_U_ECXMPI_U_ECXDOB_U_ECXELIG_U_ECXSEX_U_ECXSTATE_U_ECXCNTY_U_ECXZIP_U_ECXVET_U_ECXPOS_U_ECXPST_U_ECXPLOC_U_ECXRST_U_ECXAST
 .S ^TMP($J,"ECXP",ECXDFN)=^TMP($J,"ECXP",ECXDFN)_U_ECXAOL_U_ECXPHI_U_ECXMST_U_ECXENRL_U_ECXCNHU_U_ECXCAT_U_ECXSTAT_U_ECXPRIOR_U_ECXHNCI_U_ECXETH_U_ECXRC1_U_ECXMTST
 .S ^TMP($J,"ECXP",ECXDFN,1)=ECXERI_U_ECXEST_U_ECXOEF_U_ECXOEFDT_U_ECXCNTRY_U_ECXSHADI_U_ECXPATCAT_U_ECXCLST_U_ECXSVCI_U_ECXSVCL_U_ECXSIGI ;149,184 - Added ECXSIGI
 ;
 ;get inpatient data
 S X=$$INP^ECXUTL2(ECXDFN,ECXDATE),ECXA=$P(X,U),ECXMN=$P(X,U,2)
 S ECXTS=$P(X,U,3),ECXADM=$P(X,U,4),ECXDOM=$P(X,U,10),ECXASIH=$P(X,U,14) ;170
 ;
 ;get primary care data
 S X=$$PRIMARY^ECXUTL2(ECXDFN,$P(ECXDATE,"."))
 S ECPTTM=$P(X,U),ECPTPR=$P(X,U,2),ECCLAS=$P(X,U,3),ECPTNPI=$P(X,U,4)
 S ECASPR=$P(X,U,5),ECCLAS2=$P(X,U,6),ECASNPI=$P(X,U,7)
 Q
 ;
FILE ;file record
 ;node0
 ;facility^dfn^ssn^name^in/out^day^drug category^quantity^ward^
 ;provider^cost^mov #^treat spec^ndc^new feeder key^investigational^
 ;udp time^adm date^adm time
 ;node1
 ;mpi^placeholder^provider npi^dom^observ pat ind^encounter num^
 ;prod div code^means tst^elig^dob^sex^state^county^zip+4^vet^
 ;period of svc^pow stat^pow loc^ir status^ao status^ao loc^
 ;purple heart ind.^mst status^cnh/sh status^enrollment loc^
 ;enrollment cat^enrollment status^enrollment priority^Placehold pc team^
 ;Placehold pc provider^pc provider npi^Placehold pc provider p.class^Placehold assoc. pc provider^
 ;assoc. pc provider npi^Placehold assoc. pc provider p.class
 ;node2
 ;ordering date^ordering stop code^head & neck cancer ind.^Placehold ethnicity^
 ;Placehold race1^bcma drug dispensed^bcma dose given^bcma unit of
 ;administration^bcma icu flag^ordering provider person class^
 ;^enrollment priority ECXPRIOR_enrollment subgroup
 ;ECXSBGRP^user enrollee ECXUESTA^patient type ECXPTYPE^combat vet
 ;elig ECXCVE^combat vet elig end date ECXCVEDT^enc cv eligible
 ;ECXCVENC^national patient record flag ECXNPRFI^emerg resp indic(FEMA) 
 ;ECXERI^environ contamin ECXEST^OEF/OIF ECXOEF^OEF/OIF return date ECXOEFDT^Placehold associate pc provider npi ECASNPI^Placehold primary care provider npi ECPTNPI^provider npi ECXPRNPI
 ;^country ECXCNTRY^PATCAT^Encounter SC ECXESC^Camp Lejeune Status ECXCLST^Encounter Camp Lejeune ECXECL
 ;Combat Service Indicator (ECXSVCI) ^ Combat Service Location (ECXSVCL) ^ New Script (ECXNEW)
 ;^Patient Division (ECXSTANO)
 ;Node 3
 ;Vista DEA Special Hdlg (ECXDEA)
 ;Node 4 ;184
 ;Placehold Cerner (ECXCERN)^
 ;Node 5 ;184
 ;New MPI (ECXNMPI^Self Identified Gender (ECXSIGI)^Price Per Dispense Unit ECXPPDU^Dispense Unit^Dispense UNit
 ;
 ;convert specialty to PTF Code for transmission
 N ECXDATA
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECXTS,.ECXDATA)
 S ECXTS=$G(ECXDATA(7))
 ;done
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 I ECXLOGIC>2018 S (ECXETH,ECXRC1,ECPTTM,ECPTPR,ECCLAS,ECASPR,ECCLAS2,ECASNPI,ECPTNPI)="" ;170 Fields will now be null
 I ECXLOGIC>2020 S ECXMTST="" ;178 Means Test field will now be null
 I ECXLOGIC>2022 S ECXMPI="" ;184 - field retired
 S ECODE=EC7_U_EC23_U_ECXDIV_U_ECXDFN_U_ECXSSN_U_ECXPNM_U_ECXA_U
 S ECODE=ECODE_ECXUDDT_U_ECCAT_U_ECXQTY_U_ECXW_U_ECXPRO_U_ECXCOST_U
 S ECODE=ECODE_ECXMN_U_ECXTS_U_ECNDC_U_ECNFC_U_ECINV_U_ECXUDTM_U
 S ECODE=ECODE_$$ECXDATE^ECXUTL(ECXADM,ECXYM)_U
 S ECODE=ECODE_$$ECXTIME^ECXUTL(ECXADM)_U
 S ECODE1=ECXMPI_U_ECXDSSD_U_U_ECXDOM_U_ECXOBS_U_ECXENC_U
 S ECODE1=ECODE1_ECXPDIV_U_ECXMTST_U_ECXELIG_U_ECXDOB_U_ECXSEX_U
 S ECODE1=ECODE1_ECXSTATE_U_ECXCNTY_U_ECXZIP_U_ECXVET_U_ECXPOS_U
 S ECODE1=ECODE1_ECXPST_U_ECXPLOC_U_ECXRST_U_ECXAST_U
 S ECODE1=ECODE1_ECXAOL_U_ECXPHI_U_ECXMST_U_ECXCNHU_U_ECXENRL_U
 S ECODE1=ECODE1_ECXCAT_U_ECXSTAT_U_$S(ECXLOGIC<2005:ECXPRIOR,ECXLOGIC>2010:ECXSHADI,1:"")_U_ECPTTM_U_ECPTPR_U
 S ECODE1=ECODE1_U_ECCLAS_U_ECASPR_U_U_ECCLAS2_U
 S ECODE2=ECXORDDT_U_ECXORDST_U_ECXHNCI_U_ECXETH_U_ECXRC1
 I ECXLOGIC>2003 S ECODE2=ECODE2_U_ECXBCDD_U_ECXBCDG_U_ECXBCUA_U_ECXBCIF_U_ECXOPPC
 I ECXLOGIC>2004 S ECODE2=ECODE2_U_U_ECXPRIOR_ECXSBGRP_U_ECXUESTA_U_ECXPTYPE_U_ECXCVE_U_ECXCVEDT_U_ECXCVENC_U_ECXNPRFI
 I ECXLOGIC>2006 S ECODE2=ECODE2_U_ECXERI_U_ECXEST
 I ECXLOGIC>2007 S ECODE2=ECODE2_U_ECXOEF_U_ECXOEFDT_U_ECASNPI_U_ECPTNPI_U_ECXPRNPI
 I ECXLOGIC>2009 S ECODE2=ECODE2_U_ECXCNTRY
 I ECXLOGIC>2010 S ECODE2=ECODE2_U_ECXPATCAT ; 127 PATCAT ADDED
 I ECXLOGIC>2013 S ECODE2=ECODE2_U_ECXESC_U_ECXCLST_U_ECXECL ;144
 I ECXLOGIC>2014 S ECODE2=ECODE2_U_ECXSVCI_U_ECXSVCL_U_ECXNEW ;149
 I ECXLOGIC>2017 S ECODE2=ECODE2_U_ECXSTANO_$S(ECXLOGIC>2019:"^",1:"") ;166 tjl,174
 I ECXLOGIC>2019 S ECODE3=ECXDEA_U ;174 ,184 - Added "^"
 I ECXLOGIC>2022 S ECODE4=$G(ECXCERN)_U,ECODE5=ECXNMPI_U_ECXSIGI ;184
 I ECXLOGIC>2023 S ECODE5=ECODE5_U_ECXPPDU_U_ECXDUNIT ;187
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1
 S ^ECX(ECFILE,EC7,2)=ECODE2 S:ECXLOGIC>2019 ^ECX(ECFILE,EC7,3)=ECODE3 ;S ECRN=ECRN+1 ;174,184 - Moved record count to below
 S ^ECX(ECFILE,EC7,4)=$G(ECODE4),^ECX(ECFILE,EC7,5)=$G(ECODE5) ;184
 S ECRN=ECRN+1 ;184 - Moved record count from above
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 I $D(ZTQUEUED),$$S^%ZTLOAD S QFLG=1
 Q
 ;
NEW() ;149 Function added to determine if script had pharmacist involvement
 N ALIEN,ADATE,SCRIPT,VDATE,DONE,IENS
 S SCRIPT="N",VDATE="",DONE=0
 S ALIEN=0 F  S ALIEN=$O(^PS(55,ECXDFN,5,ON,9,ALIEN)) Q:'+ALIEN!(DONE)  S IENS=ALIEN_","_ON_","_ECXDFN_"," D
 .S ADATE=$$GET1^DIQ(55.09,IENS,".01","I")
 .I $P(ADATE,".")>ECD S DONE=1 Q  ;If date of activity is after dispense date then stop
 .I "^VP^VPR^"[("^"_$$GET1^DIQ(55.09,IENS,"2:1")_"^") S VDATE=ADATE ;if activity status is verified by pharmacist or verified by pharmacist renewal
 I VDATE'="" D
 .I '$D(^XTMP("ECXSCRIPT",VDATE,ECXDFN,ON))!($G(^XTMP("ECXSCRIPT",VDATE,ECXDFN,ON))=ECXJ) S SCRIPT="Y"
 .I '$D(^XTMP("ECXSCRIPT",VDATE,ECXDFN,ON)) S ^XTMP("ECXSCRIPT",VDATE,ECXDFN,ON)=ECXJ ;Store first instance of med given
 Q SCRIPT
 ;
CLEAN(START,END) ;149 Section added to delete old log entries
 N DATE,PAT,ON
 S DATE=START F  S DATE=$O(^XTMP("ECXSCRIPT",DATE)) Q:'+DATE!(DATE>END)  S PAT=0 F  S PAT=$O(^XTMP("ECXSCRIPT",DATE,PAT)) Q:'+PAT  S ON=0 F  S ON=$O(^XTMP("ECXSCRIPT",DATE,PAT,ON)) Q:'+ON  K ^XTMP("ECXSCRIPT",DATE,PAT,ON)
 S ^XTMP("ECXSCRIPT",0)=$$FMADD^XLFDT($$DT^XLFDT,365)_"^"_$$DT^XLFDT_"^"_"Log of pharmacy orders that have already been counted"
 Q
 ;
SETUP ;Set required input for ECXTRAC
 S ECHEAD="UDP"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
 ;
QUE ; entry point for the background requeuing handled by ECXTAUTO
 D SETUP,QUE^ECXTAUTO,^ECXKILL
 Q
 ;
SETTMP(STR) ;181 - Set global TMP for Mail Message
 N CLIN,SCODE,DIC,ECXDIC,ECXDICA,ECXNOSC,ECXINVSC,DIQ,DR,DA
 I $P(STR,U,2)="MISSING STOP CODE" D  Q
 .S CLIN=$P(STR,U)
 .I $D(^TMP($J,"ECXUDM","NOSC",CLIN)) Q
 .I '$D(^TMP($J,"ECXUDM","ECXNOSC")) S ^TMP($J,"ECXUDM","ECXNOSC")=0
 .S ECXNOSC=^TMP($J,"ECXUDM","ECXNOSC")+1
 .S DIC="^SC(",DIQ="IE",DIQ="ECXDIC",DR=".01",DA=CLIN D EN^DIQ1
 .S ^TMP($J,"ECXUDM","ECXNOSC",ECXNOSC,0)=$J(CLIN,8)_"  "_$$LJ^XLFSTR(ECXDIC(44,CLIN,.01),32)
 .S ^TMP($J,"ECXUDM","ECXNOSC")=ECXNOSC
 .S ^TMP($J,"ECXUDM","NOSC",CLIN)=""
 I $P(STR,U,2)="INVALID STOP CODE" D
 .S CLIN=$P(STR,U),SCODE=$P(STR,U,3)
 .I $D(^TMP($J,"ECXUDM","INVSC",CLIN)) Q
 .I '$D(^TMP($J,"ECXUDM","ECXINVSC")) S ^TMP($J,"ECXUDM","ECXINVSC")=0
 .S ECXINVSC=^TMP($J,"ECXUDM","ECXINVSC")+1
 .S DIC="^SC(",DIQ="IE",DIQ="ECXDIC",DR=".01",DA=CLIN D EN^DIQ1
 .S DIC="^DIC(40.7,",DIQ(0)="E",DIQ="ECXDICA",DR=".01;1;2",DA=SCODE D EN^DIQ1
 .S ^TMP($J,"ECXUDM","ECXINVSC",ECXINVSC,0)=$J(CLIN,8)_"/"_$$LJ^XLFSTR(ECXDIC(44,CLIN,.01),25)_"  "_$J(ECXDICA(40.7,SCODE,1,"E"),8)_"/"_$$LJ^XLFSTR(ECXDICA(40.7,SCODE,.01,"E"),25)
 .S ^TMP($J,"ECXUDM","ECXINVSC")=ECXINVSC
 .S ^TMP($J,"ECXUDM","INVSC",CLIN)=""
 Q
