DENTVAU ;DSS/KC - Utilities for Dental Reports;11/17/2003 15:17
 ;;1.2;DENTAL;**38,39,43,47,50,53**;Aug 10, 2001;Build 10
 ;Copyright 1995-2007, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  ------------------------------------------
 ;  2056     x       $$GETS^DIQ
 ;  2051      x      $$FIND1^DIC
 ;  2533   Cont Sub  $$DIV4^XUSER
 ;  
PROV(RET,STN,ACT) ; RPC: DENTV REPORT PROVIDERS
 ; also called by DENTVA1 to get 'ALL' providers for the reports
 ; RETURNS: data(n) = provider name^prov ien^dental prov id^stations assigned
 ;          or        -1^no active providers found
 ; providers are in Dental Provider ID order
 ;  
 N DENT,DENTERR,TMP,IEN,I,SAV,P,PN,STNS,TYP S I=0,P=0,STN=$G(STNS),ACT=$G(ACT)
 ;S PN="" F  S PN=$O(^DENT(220.5,"D",PN)) Q:PN=""  F P=0:0 S P=$O(^DENT(220.5,"D",PN,P)) Q:'P  D
 F  S P=$O(^DENT(220.5,P)) Q:'P  D
 .S IEN=P_"," D GETS^DIQ(220.5,IEN,"**","IE","DENT","DENTERR")
 .K TMP M TMP=DENT(220.5,IEN) K DENT S STNS=$$STN($G(TMP(.01,"I"))),TYP=""
 .I STN,$G(STNS) I ","_STNS_","'[STN Q  ;not in selected station
 .I ACT,$G(TMP(2,"I")) Q  ;only active providers
 .S PN=$S($G(TMP(.04,"I"))]"":$G(TMP(.04,"I")),$G(TMP(1,"E"))]"":$G(TMP(1,"E")),1:0)
 .;I ACT,$L(PN)=8 Q:+$E(PN,3,4)=0  ;only clinicians
 .I $L(PN)=8 S TYP=$$TYPE(PN)
 .I $G(TMP(.01,"E"))]"" D
 ..; order the providers by dental provider id (may not be unique!)
 ..S SAV("X"_PN,P)=$G(TMP(.01,"E"))_U_$G(TMP(.01,"I"))_U_PN_U_STNS_U_TYP
 ..Q
 .Q
 I $O(SAV(""))="" S RET(1)="-1^no active providers found" Q
 S PN="" F  S PN=$O(SAV(PN)) Q:PN=""  F P=0:0 S P=$O(SAV(PN,P)) Q:'P  D
 .S I=I+1,RET(I)=SAV(PN,P)
 .Q
 Q
STN(IEN) ;get divisions assigned
 N DENTP,X,STN,CNT,I,DIVN S X=$$DIV4^XUSER(.DENTP,IEN) Q:'X ""
 S I="",CNT=0,STN=""
 F  S I=$O(DENTP(I)) Q:I=""  S DIVN=$P($$NS^XUAF4(I),U,2),CNT=CNT+1,$P(STN,",",CNT)=DIVN
 Q STN
 ;
TYPE(PID) ;get provider type/specialty
 N X,Y,DESC S DESC=""
 S X=$E(PID,1,2) S X=$$GET1^DIQ(220.51,+X_",",.01) I X]"" S DESC=X
 S X=+$E(PID,3,4),Y=$S(X<6:1,1:2),X=X+Y ;get correct ien for specialty
 S X=$S(X=1:"",1:$$GET1^DIQ(220.52,+X_",",.01)) I X]"" S DESC=DESC_","_X
 Q DESC
PNAM(PN) ; get provider name from 8 digit provider ID
 N DENT,DENTERR,P,IEN S P=0
 I $E(PN)="(" Q PN ;P50 distributed provider
 I 'PN Q "Unknown ("_PN_")" ;P47 send # back to help troubleshoot provider issue
 I $L(PN)=8 S P=$O(^DENT(220.5,"D",PN,P)) Q:'P "Unknown ("_PN_")"
 I $L(PN)=4 S P=$O(^DENT(220.5,"C",PN,P)) Q:'P "Unknown ("_PN_")"
 S IEN=P_"," D GETS^DIQ(220.5,P_",",".01","E","DENT","DENTERR")
 I $D(DENTERR) Q "Unknown ("_PN_")"
 S P=$G(DENT(220.5,IEN,.01,"E"))
 Q $E(P,1,30) ;truncate at 30 characters in case they send to Excel. P50
 Q
 ;
RPT(RET,DATA) ; RPC - DENTV REPORT DATA
 ; DATA array contains the parameters necessary to run the report:
 ; DATA("RPT")  = report to run:
 ;        0 = Provider Summary           1 = Clinic Summary
 ;        2 = Sittings by Provider       3 = Individual Sittings
 ;        4 = Non-Clinical Time          5 = Dental Fee Basis    
 ;        6 = Sittings/Visits report     7 = Provider Planning
 ;        8 = Patient Visit List         9 = Patient Treatment
 ;       10 = Active pts by Provider    11 = Planned Items (list format)
 ;       12 = Unfiled Data              13 = Recare Report
 ; DATA("DFN")  = patient dfn for patient centric reports (8,9)
 ; DATA("STN")  = station (may be null for all stations)
 ; DATA("PROV") = p1^p2^p3^p4 where p1=ALL, or list of prov ids
 ; DATA("START")= start date in external format 11/01/2003
 ; DATA("END")  = end date in external format 11/30/2003
 ; DATA("TTYP") = NNNN = where positions mean findings/planned/complete/obs
 ;                       and where N will be 1 for Yes and 0 for No
 ;              = also used for planning: 0=primary,1=secondary,2=entered by prov
 ; DATA("PTYP") = 0=active,1=inactive (compl/term),2=maintenance,3=all,4=act/maint
 ; DATA("TDEL") = 1 for getting deleted complete txns only
 ; DATA("PROVIDEN") = -1 means use provider name instead of Id#
 ; DATA("DISTPROV") = -1 means include Distributed Provider workload (rpt 0 and 2 only!)
 ; DATA("CATG") = 0=das, 1=ada cat, 2=va-dss pl, 3=ada/cpt code
 ; DATA("DENV") = 0=use Visit date, 1=use Create date
 ; RET = location of report global
 ;
 N RPT,STN,SDT,EDT,ERR,DENERR,PTYP,TTYP,I,X,TDEL,PROVIDEN,DENV,CATG,DOSEC
 S RET=$NA(^TMP("DENT",$J)) K ^TMP("DENT",$J),^TMP("DENTPAT",$J)
 S RPT=$G(DATA("RPT")) I ",0,1,2,3,4,5,6,7,8,9,10,11,12,13,"'[(","_RPT_",") S @RET@(1)="-1^Invalid Report" Q
 S STN=$G(DATA("STN"))
 I STN]"" S STN=$$FIND1^DIC(4,,"MX",STN,,,"DENERR") I 'STN S @RET@(1)="-1^Invalid station" Q
 D CNVT^DSICDT(.SDT,$G(DATA("START")),"E","F")
 I SDT'?7N S @RET@(1)="-1^Invalid start date" Q
 D CNVT^DSICDT(.EDT,$G(DATA("END")),"E","F")
 I EDT'?7N S @RET@(1)="-1^Invalid end date" Q
 S PTYP=+$G(DATA("PTYP")),TTYP=",",DENV=$G(DATA("DENV"))
 I +$G(DATA("TTYP")),RPT<7 D
 .F I=1,2 S X=$E(DATA("TTYP"),I) I X S TTYP=TTYP_"10"_(I+2)_","
 .Q
 S TDEL=+$G(DATA("TDEL")),PROVIDEN=+$G(DATA("PROVIDEN")),CATG=+$G(DATA("CATG"))
 I RPT=0 D:'CATG PROV^DENTVA1(.RET) D:CATG PROV^DENTVA11(.RET) Q
 I RPT=1 D:'CATG CLINIC^DENTVA1(.RET) D:CATG CLINIC^DENTVA11(.RET) Q
 I RPT=2 D PROV^DENTVA21(.RET) Q
 I RPT=3 D SIT^DENTVA21(.RET) Q
 I RPT=4 D ADMIN^DENTVA2(.RET) Q
 I RPT=5 D FEE^DENTVA3(.RET) Q
 I RPT=6 D PSIT^DENTVA3(.RET) Q
 I RPT=7!(RPT=11) S DOSEC=$G(DATA("TTYP")) D PLAN^DENTVA2(.RET) Q
 I RPT=8 D PAT^DENTVA7(.RET) Q  ;P47 new report
 I RPT=10 S DOSEC=$G(DATA("TTYP")) D ACT^DENTVA7(.RET) Q  ;P47 new report
 I RPT=12 D UNF^DENTVA3(.RET) Q  ;P47 new report
 I RPT=13 D REC^DENTVA7(.RET) Q  ;P53 Recare report
 Q
KLF(RET,DATA) ; RPC - DENTV REPORT KLF DATA
 ; DATA array contains the parameters necessary to run the report:
 ; DATA("RPT")  = report(s) to run:
 ;     0 = all    1 - 11 or any combination means KLF tables 1-11
 ; DATA("STN")  = station (optional - if null then entire facility)
 ; DATA("FY")   = fiscal year (optional)
 ; DATA("START")= start date in external format 11/01/2003
 ; DATA("END")  = end date in external format 11/30/2003
 ; DATA("FY")   = fiscal year flag
 ; DATA("PROV") = provider ien^provider ien...'
 ; DATA("PROVIDEN") = -1 means use provider name instead of Id#
 ; DATA("CATG") = 0=das, 1=ada cat, 2=va-dss pl, 3=ada/cpt code
 ; DATA("DENV") = 0=use Visit date, 1=use Create date
 ; RET = location of report global
 ;
 N RPT,STN,SDT,EDT,FY,DENERR,X,PROV,PROVIDEN,RPTS,CATG,I,DENV
 S RET=$NA(^TMP("DENT",$J)) K ^TMP("DENT",$J),^TMP("DENTPAT",$J)
 S RPT=$G(DATA("RPT")),STN=$G(DATA("STN")),DENV=$G(DATA("DENV"))
 ;I RPT'?1N.",".N S @RET@(1)="-1^Invalid report number" Q
 I STN]"" S STN=$$FIND1^DIC(4,,"MX",STN,,,"DENERR") I 'STN S @RET@(1)="-1^Invalid station" Q
 S FY=+$G(DATA("FY")),PROVIDEN=+$G(DATA("PROVIDEN")),CATG=+$G(DATA("CATG"))
 D CNVT^DSICDT(.SDT,$G(DATA("START")),"E","F")
 I SDT'?7N S @RET@(1)="-1^Invalid start date" Q
 D CNVT^DSICDT(.EDT,$G(DATA("END")),"E","F")
 I EDT'?7N S @RET@(1)="-1^Invalid end date" Q
 S PROV=$G(DATA("PROV")) I PROV=0 S @RET@(1)="-1^Invalid Provider" Q
 I PROV'="ALL" S PROV=U_PROV
 I RPT=0 S RPT="1,2,3,4,5,6,7,8,9,10,11"
 S RPTS=","_RPT_","
 F I=RPT S X=I_"^DENTVAU" D @X
 I '$D(@RET) S @RET@(1)="-1^No data for the selected criteria"
 Q
1 D ONE^DENTVA4(RPTS) Q  ;Observations Per Month  (Table 1)
2 D:'CATG TWO^DENTVA5(RPTS) D:CATG TWO^DENTVA51(RPTS) Q  ;Service Profile  (Table 2)
3 D:'$D(@RET@(3))&('CATG) TWO^DENTVA5(RPTS) D:'$D(@RET@(3))&(CATG) TWO^DENTVA51(RPTS) Q  ;Service by Group (Table 3)
4 D FOUR^DENTVA6(RPTS) Q  ;Provider Profile (Table 4)
5 D:'$D(@RET@(5)) FOUR^DENTVA6(RPTS) Q  ;Patients Profile (Table 5)
6 D:'$D(@RET@(6)) ONE^DENTVA4(RPTS) Q  ;Unique Patients by Setting (Table 6)
7 D:'$D(@RET@(7)) FOUR^DENTVA6(RPTS) Q  ;Unique Patients by Eligibility Group (Table 7)
8 D:'$D(@RET@(8)) ONE^DENTVA4(RPTS) Q  ;Unique Patients by Patient Category (Table 8)
9 D:'$D(@RET@(3))&('CATG) TWO^DENTVA5(RPTS) D:'$D(@RET@(3))&(CATG) TWO^DENTVA51(RPTS) Q  ;Outpt Service (Table 9)
10 D:'$D(@RET@(3))&('CATG) TWO^DENTVA5(RPTS) D:'$D(@RET@(3))&(CATG) TWO^DENTVA51(RPTS) Q  ;Inpt Service  (Table 10)
11 D:'$D(@RET@(3))&('CATG) TWO^DENTVA5(RPTS) D:'$D(@RET@(3))&(CATG) TWO^DENTVA51(RPTS) Q  ;All Services (Table 11)
