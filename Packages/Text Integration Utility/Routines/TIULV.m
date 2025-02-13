TIULV ; SLC/JER - Visit/Movement related library ;Jan 26, 2024@07:17
 ;;1.0;TEXT INTEGRATION UTILITIES;**7,30,55,45,52,148,156,152,113,200,362**;Jun 20, 1997;Build 3
 ;
 ; Reference to File ^AUPNVSIT supported by ICR #3580
 ; Reference to File ^VA supported by ICR #10060
 ; Reference to File ^DG(40.8 supported by ICR #1576
 ; Reference to File ^DGPM supported by ICR #4076
 ; Reference to File ^DIC(42 supported by ICR #10039
 ; Reference to File ^DIC(49 supported by ICR #432
 ; Reference to File ^DPT supported by ICR #10035
 ; Reference to File ^SC( supported by ICR #93
 ; Reference to File ^VA supported by ICR #10060
 ; Reference to ^DIC supported by ICR #10006
 ; Reference to $$GET1^DIQ supported by ICR #2056
 ; Reference to *^DIQ1 supported by ICR #10015
 ; Reference to *^VADPT supported by ICR #10061
 ; Reference to *^VASITE supported by ICR #10112
 ;
 Q
PATPN(TIUY,DFN) ; Get minimum demographics for PN Print
 N VADM,VAIP,VAIN,VA,VAPA
 D OERR^VADPT
 S TIUY("PNMP")=$E($G(VADM(1)),1,30)
 S TIUY("SSN")=$G(VA("PID"))
 S TIUY("DOB")="DOB:"_$$DATE^TIULS(+$G(VADM(3)),"MM/DD/CCYY")
 D ADD^VADPT
 I $G(VAPA(8))'="" S TIUY("PH#")="Ph:"_VAPA(8)
 I $G(VAPA(8))="" S TIUY("PH#")="Ph: **UNKNOWN**"
 S TIUY("INTNM")=$$NAME^VASITE ;Integration Name
 S TIUY("SITE")=$P($$SITE^VASITE,U,2)
 S TIUY("LOCP")="Pt Loc: "_$S(VAIN(4)]"":$P(VAIN(4),U,2)_"  "_VAIN(5),1:"OUTPATIENT")
 Q
 ;
PATVADPT(TIUY,DFN,TIUMVN,TIUVSTR,TIUSDC) ; Extract MAS data
 N VA,VADM,VAEL,VAERR,VAIP,TIUI,TIUWARD,X,Y,TIUTYPE,TIUFTS,TIUSS,VAPA
 D DEM^VADPT
 S TIUY("PNM")=$G(VADM(1)),TIUY("SSN")=$G(VA("PID"))
 S TIUY("AGE")=$G(VADM(4)),TIUY("PID")="("_$E(TIUY("PNM"))_VA("BID")_")"
 S TIUY("DOB")=$G(VADM(3))
 D ADD^VADPT
 I $G(VAPA(8))'="" S TIUY("PH#")=VAPA(8)
 I $G(VAPA(8))="" S TIUY("PH#")="**UNKNOWN**"
 S TIUY("SEX")=$G(VADM(5))
 ; Below TIU*148
 I +$G(VADM(12))>0 D
 . F TIUY("NUMRACE")=1:1:VADM(12) S TIUY("RACE",TIUY("NUMRACE"))=$G(VADM(12,TIUY("NUMRACE")))
 S TIUY("RACENO")=+$G(VADM(12))
 I +$G(VADM(12))=0 S TIUY("RACE")=$G(VADM(8))
 I +$G(TIUSDC) S TIUY("STOP")=$G(TIUSDC)
 I +$G(TIUD13(0)) S TIUY("REFDT")=+$G(TIUD13(0))
 I +$G(TIUMVN),$D(^DGPM(+TIUMVN)) D
 . N VLOC,VDT,TIUDIV
 . S VAIP("E")=TIUMVN D 52^VADPT
 . S TIUI=$S(+$G(VAIP(17,1)):17,1:14)
 . S TIUY("CLAIM")=$G(VAEL(7)),TIUY("PMD")=$G(VAIP(TIUI,5))
 . S TIUY("AMD")=$G(VAIP(18)),TIUY("TS")=$G(VAIP(TIUI,6))
 . ; verify FACILITY TREATING SPECIALTY NAME, Field #2 SERVICE when setting "SVC" node *362 ajb
 . N TMPSVC S TMPSVC=+$$GET1^DIQ(45.7,+TIUY("TS"),2,"I",,"ERROR") S:+TMPSVC TIUY("SVC")=TMPSVC ; *362 ajb
 . S:+TMPSVC TIUY("SVC")=TIUY("SVC")_U_$$GET1^DIQ(49,+TIUY("SVC"),.01,"I",,"ERROR") ; *362 ajb
 . S TIUY("WARD")=$$WARD($G(VAIP(17)))
 . S (TIUY("ADDT"),TIUY("EDT"))=$G(VAIP(3))
 . I +TIUY("WARD") S TIUY("LOC")=$G(^DIC(42,+TIUY("WARD"),44))
 . I +$G(TIUY("LOC")) D
 . . S TIUY("LOC")=TIUY("LOC")_U_$P($G(^SC(+TIUY("LOC"),0)),U)
 . S TIUY("ADDX")=$G(VAIP(9)),TIUY("LDT")=$G(VAIP(17,1))
 . S TIUY("AD#")=+$G(VAIP(13)),TIUY("MTYPE")=$G(VAIP(TIUI,3))
 . S TIUDIV=$P($G(^DIC(42,+TIUY("WARD"),0)),U,11)
 . I +TIUDIV S TIUY("DIV")=TIUDIV_U_$P($G(^DG(40.8,+TIUDIV,0)),U)
 . S VDT=+VAIP(3)
 . S VLOC=$G(^DIC(42,+$P($G(VAIP(13,4)),U),44))
 . S TIUY("VSTR")=VLOC_";"_+TIUY("EDT")_";H"
 . S TIUY("VLOC")=VLOC_U_$P($G(^SC(VLOC,0)),U)
 . S:'+$G(TIUY("LOC")) TIUY("LOC")=TIUY("VLOC")
 I $G(TIUVSTR)]"" S TIUY("VSTR")=TIUVSTR D VSIT(.TIUY,TIUVSTR)
 I '+$G(TIUMVN),'+$G(TIUVSTR) D CURRENT(.TIUY,DFN)
 ; D CURRENT(.TIUY,DFN)
 I +$$PROVIDER^TIUPXAP1($S($D(TIUAUTH):+$G(TIUAUTH),1:DUZ),+$G(TIUY("EDT"))) D
 . S TIUY("SVC")=$$PROVSVC(+$S($D(TIUAUTH):+$G(TIUAUTH),1:DUZ))
 I +$G(TIUY("VSTR")),(+$O(^TIU(8925,"AVSTRV",+DFN,$G(TIUY("VSTR")),0))>0) D
 . N TIUVSIT S TIUVSIT=+$O(^TIU(8925,"AVSTRV",+DFN,$G(TIUY("VSTR")),0))
 . I $P($G(^AUPNVSIT(+TIUVSIT,0)),U,5)'=DFN K ^TIU(8925,"AVSTRV",+DFN,$G(TIUY("VSTR")),TIUVSIT) Q
 . S TIUY("VISIT")=+TIUVSIT_U_+$G(^AUPNVSIT(+TIUVSIT,0))
 ; if pt an inpt + doc class is pn- default to current inpt loc
 S TIUTYPE=$S(+$P($G(TIUTYP(1)),U,2)>0:$P($G(TIUTYP(1)),U,2),1:+$G(TIUTYP))
 I +TIUTYPE'>0 S TIUY("INST")=$$DIVISION^TIULC1(+TIUY("LOC")) Q
 I +$G(TIUMVN),$D(^DPT(DFN,.1)),+$$ISPN^TIULX(TIUTYPE) D
 . I $D(VAIP(14,4)) S TIUY("LOC")=$G(^DIC(42,+VAIP(14,4),44))_U_$P(VAIP(14,4),U,2)
 S TIUY("INST")=$$DIVISION^TIULC1(+TIUY("LOC"))
 Q
WARD(DA) ; Compute ward at discharge
 N %,D0,DIC,DIQ,DR,MOVE,X,Y
 I +DA'>0 S Y=$G(VAIP(TIUI,4)) G WARDX
 S DIC="^DGPM(",DIQ(0)="IE",DIQ="MOVE(",DR=200
 D EN^DIQ1
 S X=$G(MOVE(405,DA,200,"E")),DIC=42,DIC(0)="X" D ^DIC
 I +Y'>0 S Y=""
WARDX Q Y
PROVSVC(TIUSER) ; Resolve user's Service
 N TIUY
 S TIUY=$P($G(^VA(200,+TIUSER,5)),U)
 S:+TIUY TIUY=TIUY_U_$P(^DIC(49,+TIUY,0),U)
 Q TIUY
VSIT(TIUY,TIUVSTR) ; Get Visit related info
 N DIC,DIQ,X,Y,DA,DR,VSIT,TIUCT,VAEL,VAERR
 D ELIG^VADPT
 I '$D(TIUY("EDT")) D
 . S TIUY("EDT")=$P(TIUVSTR,";",2)_U_$$DATE^TIULS($P(TIUVSTR,";",2),"AMTH DD, CCYY@HR:MIN")
 S TIUY("LDT")=$G(TIUY("LDT"))
 S TIUCT=$P(TIUVSTR,";",3)
 I TIUCT]"" S TIUY("CAT")=TIUCT_U_$S(TIUCT="A":"AMBULATORY",TIUCT="I":"IN HOSPITAL",TIUCT="H":"HOSPITALIZATION",TIUCT="T":"TELEPHONE",1:"EVENT (HISTORICAL)")
 I TIUCT="E",+$G(TIUVSTR)'>0 Q
 S TIUY("LVL")=$G(TIUY("LVL"))
 S TIUY("ELG")=$G(VAEL(1))
 S TIUY("VLOC")=+$G(TIUVSTR)_U_$P($G(^SC(+$G(TIUVSTR),0)),U)
 I $G(TIUY("LOC"))']"" S TIUY("LOC")=$S($L($G(TIUD12)):$P($G(TIUD12),U,5),+$G(TIUDA):+$P($G(^TIU(8925,+$G(TIUDA),12)),U,5),1:+TIUY("VLOC"))
 S:$P(TIUY("LOC"),U,2)']"" TIUY("LOC")=TIUY("LOC")_U_$P($G(^SC(+TIUY("LOC"),0)),U)
 I '$D(TIUY("DIV")),+$G(TIUY("LOC")) D
 . N TIUDIV,DIC,DR,DA,DIQ,X,Y
 . S DIC=44,DIQ="TIUDIV",DIQ(0)="IE",DA=+TIUY("LOC"),DR="3.5" D EN^DIQ1
 . I '+$G(TIUDIV(44,+DA,3.5,"I")) Q
 . S TIUY("DIV")=TIUDIV(44,+DA,3.5,"I")_U_TIUDIV(44,+DA,3.5,"E")
 I '$D(TIUY("DIV")),'+$G(TIUY("LOC")) D
 . S TIUY("DIV")=+$O(^DG(40.8,"AD",+$G(DUZ(2)),0))
 . S TIUY("DIV")=+TIUY("DIV")_U_$P($G(^DG(40.8,+$G(TIUY("DIV")),0)),U)
 S TIUY("INS")=$G(TIUY("DIV"))
 S TIUY("SC")=$G(TIUY("SC"))
 Q
CURRENT(TIUY,DFN) ; Get current INPATIENT data
 N VAIN D INP^VADPT
 S TIUY("AD#")=$G(VAIN(1)),TIUY("PMD")=$G(VAIN(2))
 S TIUY("TS")=$G(VAIN(3)),TIUY("WARD")=$G(VAIN(4),"0^OUTPATIENT")
 S TIUY("RB")=$G(VAIN(5))
 I +TIUY("WARD") D
 . N DIC,DIQ,DR,DA,TIUDIV,Y
 . S DIC=42,DA=+TIUY("WARD"),DIQ="TIUDIV(",DIQ(0)="IE",DR=".015;44"
 . D EN^DIQ1
 . S TIUY("DIV")=$G(TIUDIV(42,DA,.015,"I"))_U_$G(TIUDIV(42,DA,.015,"E"))
 . S TIUY("LOC")=$G(TIUDIV(42,DA,44,"I"))_U_$G(TIUDIV(42,DA,44,"E"))
 S TIUY("LOC")=$G(TIUY("LOC"))
 I '+$G(TIUY("DIV")) D
 . N DIC,DIQ,DR,DA
 . S DIC=4,DR=".01",DA=+$G(DUZ(2)),DIQ="TIUDIV1"
 . D EN^DIQ1
 . ;TIU*1*152 changed TIUDIV1(4,DUZ(2),.01) to $G(TIUDIV1(4,$G(DUZ(2)),.01)) ; TIU*1*200 Added + to 2nd piece and + to $G(DUZ(2))
 . S TIUY("DIV")=+$G(DUZ(2))_U_+$G(TIUDIV1(4,+$G(DUZ(2)),.01))
 Q
