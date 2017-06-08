VEJDWPB1 ;wpb/swo routine modified for dental GUI;7.7.98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;3.0;ORDER ENTRY/RESULTS REPORTING;**10**;Dec 17, 1997
 ;ORWPT SLC/KCM - Patient Lookup Functions ;6/2/98@15:42:40
IDINFO(REC,DFN) ; Return identifying information for a patient
 ; PID^DOB^SEX^VET^SC%^WARD^RM-BED^NAME
 N X0,X1,X101,X3,XV  ; name/dob/sex/ssn, ward, room-bed, sc%, vet
 S X0=$G(^DPT(DFN,0)),X1=$G(^(.1)),X101=$G(^(.101)),X3=$G(^(.3)),XV=$G(^("VET"))
 S REC=$P(X0,U,9)_U_$P(X0,U,3)_U_$P(X0,U,2)_U_$P(XV,U)_U_$P(X3,U,2)_U_$P(X1,U)_U_$P(X101,U)_U_$P(X0,U)
 Q
PTINQ(REF,DFN) ; Return formatted pt inquiry report
 K ^TMP("ORDATA",$J,1)
 D DGINQ^VEJDWPB2(DFN)
 S REF=$NA(^TMP("ORDATA",$J,1))
 Q
SCDIS(LST,DFN) ; Return service connected % and rated disabilities
 N VAEL,VAERR,I,ILST,DIS,SC,X
 D ELIG^VADPT
 S LST(1)="Service Connected: "_$S(+VAEL(3):$P(VAEL(3),U,2)_"%",1:"NO")
 I 'VAEL(4),'$P($G(^DG(391,+VAEL(6),0)),U,2) S LST(2)="NOT A VETERAN." Q
 S I=0,ILST=1 F  S I=$O(^DPT(DFN,.372,I)) Q:'I  S X=^(I,0) D
 . S DIS=$P($G(^DIC(31,+X,0)),U) Q:DIS=""
 . S SC=$S($P(X,U,3):"SC",$P(X,U,3)']"":"not specified",1:"NSC")
 . S ILST=ILST+1,LST(ILST)=DIS_" ("_$P(X,U,2)_"% "_SC_")"
 I ILST=1 S LST(2)="Rated Disabilities: NONE STATED"
 Q
SHOW ; temporary - show patient inquiry screen
 N I,Y,DIC S DIC=2,DIC(0)="AEMQ" D ^DIC Q:'Y
 K ^TMP("ORDATA",$J,1)
 D DGINQ^VEJDWPB2(+Y)
 S I=0 F  S I=$O(^TMP("ORDATA",$J,1,I)) Q:'I  W !,^(I)
 K ^TMP("ORDATA",$J,1)
 Q
SELCHK(REC,DFN) ; Check for sensitive pt
 ; SENSITIVE
 S REC=$$EN1^ORQPT2(DFN)
 Q
SELECT(REC,DFN) ; Selects patient & returns key information
 ;  1    2   3   4    5      6    7    8       9       10      11  12
 ; NAME^SEX^DOB^SSN^LOCIEN^LOCNM^RMBD^CWAD^SENSITIVE^ADMITTED^CONV^SC
 N X
 K ^TMP("ORWPCE",$J) ; delete PCE 'cache' when switching patients
 S X=^DPT(DFN,0),REC=$P(X,U,1,3)_U_$P(X,U,9)_U_U_$G(^(.1))_U_$G(^(.101))
 S X=$P(REC,U,6) I $L(X) S $P(REC,U,5)=+$G(^DIC(42,+$O(^DIC(42,"B",X,0)),44))
 S $P(REC,U,8)=$$CWAD^ORQPT2(DFN)_U_$$EN1^ORQPT2(DFN)
 I $P(REC,U,9) D EN2^ORQPT2(DFN)  ;update DG security log
 S X=$G(^DPT(DFN,.105)) I X S $P(REC,U,10)=$P(^DGPM(X,0),U)
 S:'$D(IOST) IOST="P-OTHER"
 S $P(REC,U,11)=$$OTF^OR3CONV(DFN,1)
 D ELIG^VADPT S $P(REC,U,12)=$G(VAEL(3)) K VAEL,VAERR ;VADPT call to kill?
 S ^DISV(DUZ,"^DPT(")=DFN
 Q
SHARE(VAL,IP,HWND,DFN)   ; Set global to share DFN with other applications
 K ^TMP("ORWCHART",$J)
 S ^TMP("ORWCHART",$J,IP,HWND)=DFN
 Q
LAST5(LST,ID) ; Return a list of patients matching A9999 identifiers
 N I,IEN,XREF
 S (I,IEN)=0,XREF=$S($L(ID)=5:"BS5",1:"BS")
 F  S IEN=$O(^DPT(XREF,ID,IEN)) Q:'IEN  D
 . S I=I+1,LST(I)=IEN_U_$P(^DPT(IEN,0),U)
 Q
TOP(LST) ; Return top for all patients list (last selected for now)
 N IEN
 S IEN=$G(^DISV(DUZ,"^DPT("))
 I IEN S LST(1)=IEN_U_$P($G(^DPT(IEN,0)),U)
 Q
ENCTITL(REC,DFN,LOC,PROV) ; Return external values for encounter
 ; LOCNAME^LOCABBR^ROOMBED^PROVNAME
 S $P(REC,U,1)=$P($G(^SC(+LOC,0)),U,1,2)
 S $P(REC,U,3)=$P($G(^DPT(DFN,.101)),U)
 S $P(REC,U,4)=$P($G(^VA(200,+PROV,0)),U)
 Q
LISTALL(Y,FROM,DIR) ; Return a bolus of patient names
 N I,IEN,CNT S CNT=44,I=0
 F  S FROM=$O(^DPT("B",FROM),DIR) Q:FROM=""  D  Q:I=CNT
 . S IEN=0 F  S IEN=$O(^DPT("B",FROM,IEN)) Q:'IEN  D  Q:I=CNT
 . . ; S X1=$G(^DPT(IEN,.1))_" "_$G(^DPT(IEN,.101))
 . . S I=I+1 S Y(I)=IEN_"^"_FROM ;_"^"_X ; _"^"_X1  ;"   ("_X_")"
 Q
APPTLST(LST,DFN) ; return a list of appointments
 ; APPTTIME^LOCIEN^LOCNAME^EXTSTATUS
 N VASD
 S VASD("F")=$$HTFM^XLFDT($H-30,1)
 S VASD("T")=$$HTFM^XLFDT($H+1,1)_".2359"
 S VASD("W")="123456789"
 D SDA^VADPT
 S I=0 F  S I=$O(^UTILITY("VASD",$J,I)) Q:'I  D
 . S LST(I)=$P(^UTILITY("VASD",$J,I,"I"),U,1,2)_U_$P(^("E"),U,2,3)
 K ^UTILITY("VASD",$J)
 Q
ADMITLST(LST,DFN) ; return a list of admissions
 ; MOVETIME^LOCIEN^LOCNAME^TYPE
 N TIM,MOV,X0,Y,MTIM,XTYP,XLOC,HLOC,ILST S ILST=0
 S TIM="" F  S TIM=$O(^DGPM("ATID1",DFN,TIM)) Q:TIM'>0  D
 . S MOV=0  F  S MOV=$O(^DGPM("ATID1",DFN,TIM,MOV)) Q:MOV'>0  D
 . . N VSTR,TIUDA
 . . S X0=^DGPM(MOV,0),MTIM=$P(X0,U)
 . . S XTYP=$P($G(^DG(405.1,+$P(X0,U,4),0)),U,1)
 . . S XLOC=$P($G(^DIC(42,+$P(X0,U,6),0)),U,1),HLOC=+$G(^(44))
 . . S VSTR=HLOC_";"_MTIM_";H",TIUDA=$$HASDS^TIULX(DFN,VSTR)
 . . S ILST=ILST+1,LST(ILST)=MTIM_U_HLOC_U_XLOC_U_XTYP_U_MOV_U_TIUDA
 Q
CLINRNG(LST) ; return date ranges for clinic appointments
 S LST(1)="T;T^Today"
 S LST(2)="T+1;T+1^Tomorrow"
 S LST(3)="T-1;T-1^Yesterday"
 S LST(4)="T-7;T^Past Week"
 S LST(5)="T-31;T^Past Month"
 S LST(6)="S^Specify Date Range..."
 Q
 ;
 N %,%H,X,SUNDAY,START
 S LST(1)=DT_";"_DT_"^Today",X=$$HTFM^XLFDT($H+1,1)
 S LST(2)=X_";"_X_"^Tomorrow"
 S X=+$H F  Q:X#7=3  S X=X-1                        ; $H#7=3 is Sunday
 S LST(3)=$$HTFM^XLFDT(X)_";"_$$HTFM^XLFDT(X+6)_"^This Week"
 S LST(4)=$$HTFM^XLFDT(X+7)_";"_$$HTFM^XLFDT(X+13)_"^Next Week"
 S LST(5)=$E(DT,1,5)_"01;"_$E(DT,1,5)_"31^This Month"
 S X=$E(DT,4,5)+1 S:X=13 X=1 S X=$E(DT,1,3)_$TR($J(X,2)," ",0)
 S LST(6)=X_"01;"_X_"31^Next Month"
 S LST(7)="^Specify Dates"
 Q
DFLTSRC(VAL) ; return default patient list source (T, W, C, P, S)
 N SRV S SRV=+$G(^VA(200,DUZ,5))
 S VAL=""
 Q
SAVDFLT(OK,X) ; save new default patient list settings (X=type^ien^sdt;edt)
 G SAVDFLT^ORWPT1
 ;
DISCHRG(Y,DFN,ADMOV) ; Get discharge movement information
 N VAIP
 S:+$G(ADMOV)=0 ADMOV=$G(^DPT(DFN,.105))
 S VAIP("E")=ADMOV D 52^VADPT
 I +VAIP(17)=0 S Y=0 Q
 S Y=VAIP(17)_U_+VAIP(17,1)
 Q
DISCHRG2(Y,DFN,ADMITDT) ; Get discharge date given admit date
 S Y=+$O(^DGPM("APTT1",DFN,ADMITDT,0))
 S:Y>0 Y=+$P($G(^DGPM(Y,0)),U,17)
 S:Y>0 Y=+$P($G(^DGPM(Y,0)),U,1)
 Q
