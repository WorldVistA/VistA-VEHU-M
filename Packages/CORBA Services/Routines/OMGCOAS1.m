OMGCOAS1 ;BIR/RSB-GCPR API for CPRS Remote Data View extracts ; 02 Oct 2000
 ;;1.4;FHIE;;Oct 20, 2003
 ;
 ; Input:  IEN       = Patient's DFN
 ;         DATATYPE  = Type of data being requested:
 ;                       LRO - Lab Orders
 ;                       LRC - Chem & Hem
 ;                       SP  - Surgical Path
 ;                       CY  - Cytology
 ;                       MI  - Microbiology
 ;                       RI  - Radiology Impression
 ;                       RR  - Radiology Report
 ;                       RXA - Active Outpatient RX
 ;                       RXOP- All Outpatient RX
 ;                       ADT - ADT Summary
 ;                       DS  - Discharge Summary
 ;                       ALRG - Allergies
 ;                       CONS - Consult Report
 ;                       SADR - Standard Ambulatory Data
 ;
 ;         BEGDATE   = Beginning search date
 ;         ENDDATE   = Ending search date
 ;         ORMAX     = Max number of entries for report 
 ;
    ;ZZGCPR(IEN,DATATYPE,BEGDATE,ENDDATE,ORMAX)  ;
 ;
 ;D TGCPR Q  ; shortcut for test data ; 
 S ^XTMP("OMGCOAS3",1)=$H_"^"_DATATYPE_"^"_$J
 D FHIE^OMGCOAS3(IEN,DATATYPE,BEGDATE,ENDDATE,ORMAX)
 S ^XTMP("OMGCOAS3",10)=$H_"^"_$J
 Q        ;This line and previos line hits VEHU test data
 S ^XTMP("OMGCOASE",$H,1)=DATATYPE
 ;D ^OMGCOASE(DATATYPE) Q  ; shortcut for error condition samples
 ;
 I BEGDATE>ENDDATE D
 .N BEG,END S BEG=BEGDATE,END=ENDDATE
 .S BEGDATE=END,ENDDATE=BEG
 ; adjust dates for Allergies only
 I DATATYPE="ALRG" S BEGDATE=2800101,ENDDATE=DT
 K ^XTMP("OMG FHIE PER",$J_"|"_$G(DUZ)_"|"_$G(IEN)_"|"_$G(DATATYPE)) S $P(^XTMP("OMG FHIE PER",$J_"|"_$G(DUZ)_"|"_$G(IEN)_"|"_$G(DATATYPE)),"^",1)=$H
 N UMGR D INIT^VESOEX  ; initialize the EsiObjects environment
 S UMGR=$$CREATE^VESOEX("CPRS$Test")
 D INVOKE^VESOEX(UMGR,"NTS",6,IEN,DATATYPE,BEGDATE,ENDDATE,ORMAX,$G(OMGDBG))
 D DESTROY^VESOEX(UMGR)
 S $P(^XTMP("OMG FHIE PER",$J_"|"_$G(DUZ)_"|"_$G(IEN)_"|"_$G(DATATYPE)),"^",5)=$H
 S $P(^XTMP("OMG FHIE PER",$J_"|"_$G(DUZ)_"|"_$G(IEN)_"|"_$G(DATATYPE)),"^",6)=IEN
 ;
 S $P(^XTMP("OMG FHIE PER",$J_"|"_$G(DUZ)_"|"_$G(IEN)_"|"_$G(DATATYPE)),"^",7)=BEGDATE
 S $P(^XTMP("OMG FHIE PER",$J_"|"_$G(DUZ)_"|"_$G(IEN)_"|"_$G(DATATYPE)),"^",8)=ENDDATE
 ; // replaced by call to STORDAT // S ^XTMP("OMG FHIE PER",$H,$J)=$G(^XTMP("OMG FHIE PER",$J_"|"_$G(DUZ)_"|"_$G(IEN)_"|"_$G(DATATYPE)))_"^"_$G(DUZ)_"^"_$G(DATATYPE)_"^"_ORMAX
 D STORDAT("+1",$G(^XTMP("OMG FHIE PER",$J_"|"_$G(DUZ)_"|"_$G(IEN)_"|"_$G(DATATYPE)))_"^"_$G(DUZ)_"^"_$G(DATATYPE)_"^"_ORMAX,$H,1)
 K ^XTMP("OMG FHIE PER",$J_"|"_$G(DUZ)_"|"_$G(IEN)_"|"_$G(DATATYPE))
 Q
 ;
LRO(IEN) D ALL(IEN,"LRO") Q
LRC(IEN) D ALL(IEN,"LRC") Q
SP(IEN) D ALL(IEN,"SP") Q
CY(IEN) D ALL(IEN,"CY") Q
MI(IEN) D ALL(IEN,"MI") Q
RI(IEN) D ALL(IEN,"RI") Q
RR(IEN) D ALL(IEN,"RR") Q
RXA(IEN) D ALL(IEN,"RXOP") Q
RXOP(IEN) D ALL(IEN,"RXOP") Q
ADT(IEN) D ALL(IEN,"ADT") Q
DS(IEN) D ALL(IEN,"DS") Q
ALRG(IEN)       D ALL(IEN,"ALRG") Q
CON(IEN) D ALL(IEN,"CONS") Q
SADR(IEN) D ALL(IEN,"SADR") Q
 ;
ALL(IEN,DATATYPE) ;
 N OMGDBG S OMGDBG=1
 N RSBNUM ; R "HOW MANY OBSERVATIONS: ",RSBNUM:DTIME
 S RSBNUM=100
 D DELETE(IEN) ; clean out cache
 K ^TMP("PSOO"),^TMP("RAE"),^TMP("LRO"),^TMP("LRC"),^TMP("LRA"),^TMP("LRCY"),^TMP("LRM"),^TMP("ORDATA")
 S DUZ=51 ; Randall's entry
 D GCPR(IEN,DATATYPE,DT,2910112,RSBNUM)
 Q
 ;
STORDAT(I,S,T,Q) ; Store data into FHIE USAGE REPORT DATA file 8801.5
 ; Add/modify a record given input data in string
 ; ; I = IEN for this file (e.g. "+1" to add or 1 to modify)
 ; ; S = string containing data
 ; ; T = Time stamp for new entry ($H)
 ; ; Q = Quiet flag (no output)
 N FDA,FIL,MSG
 S FIL=8801.5
 S I=I_","
 S FDA(FIL,I,.01)=$G(T,$H) ; time stamp
 S FDA(FIL,I,101)=$P(S,"^",1) ; FHIE request start
 S FDA(FIL,I,102)=$P(S,"^",2) ; CORBA request sent
 S FDA(FIL,I,103)=$P(S,"^",3) ; CORBA reply received
 S FDA(FIL,I,104)=$P(S,"^",4) ; number of observations received
 S FDA(FIL,I,105)=$P(S,"^",5) ; extraction finished
 S FDA(FIL,I,106)="`"_$P(S,"^",6) ; patient IEN
 S FDA(FIL,I,107)=$P(S,"^",7) ; start date
 S FDA(FIL,I,108)=$P(S,"^",8) ; end date
 S FDA(FIL,I,109)="`"_$P(S,"^",9) ; user ID (DUZ)
 S FDA(FIL,I,110)=$P(S,"^",10) ; datatype
 S FDA(FIL,I,111)=$P(S,"^",11) ; max count
 D:$E(I)="+" UPDATE^DIE("E","FDA","","MSG")
 D:$E(I)'="+" FILE^DIE("E","FDA","MSG")
 Q:$G(Q)
 I $D(MSG("DIERR")) W !,"ERROR: "_$G(MSG("DIERR",1,"TEXT",1))
 E  W !,"OK"
 Q
 ;
PURGDAT(N) ; Purge  FHIE USAGE REPORT DATA file
 ; ; N = number of days to keep.  Default = 365.
 N DATE,FROM,FLDS,OUT,D
 S N=$G(N,365),DATE=$$HTFM^XLFDT($H-N)
 S DIK="^OMGPID(8801.5,"
 S (FLDS,FROM)=""
 F  D LIST^DIC(8801.5,"",FLDS,"I",1,.FROM,"","B","","","OUT") S D=$G(OUT("DILIST",1,1)) Q:'D!(D>DATE)  D  Q:FROM=""
 . S DA=$G(OUT("DILIST",2,1)) Q:'DA
 . D ^DIK
 Q
 ;
FILL ; Populate the FHIE USAGE REPORT DATA file with entries from ^XTMP("OMG FHIE PER")
 N TS,J,STR 
 S TS=0
 F  S TS=$O(^XTMP("OMG FHIE PER",TS)) Q:TS=""  D:TS'["|"
 . S J="" F  S J=$O(^XTMP("OMG FHIE PER",TS,J)) Q:J=""  D
 . . S STR=^XTMP("OMG FHIE PER",TS,J)
 . . D STORDAT("+1",STR,TS,1)
 Q
 ;
TGCPR ;
 ; just for testing with Cary Malmrose
 N DH S DH=$H
 ; S ^XTMP("OMG FHIE TEST",$J,DH)=$G(DUZ)_"^"_IEN_"^"_DATATYPE_"^"_BEGDATE_"^"_ENDDATE_"^"_ORMAX
 ;
 If DATATYPE="SADR" D SADR2 Q  ; //
 I DATATYPE="DS" D DIS Q
 I DATATYPE="ADT" D ADT2 Q
 I DATATYPE="ALRG" D ALRG2 Q
 I DATATYPE="CONS" D CONS2 Q
 I DATATYPE="SADR" D SADR2 Q
 ;
 ;SET ONE JUST FOR TESTING
 S ^TMP("LRC",$J,6989297.989795,1)="9/12/2001 12:00^Blood^Blood Sugar^1^low^gm/ml^2^3"
 S ^TMP("LRC",$J,6989297.989795,"C",1)="For Test: Blood Sugar - comments on the blood sugar reading..."
 S ^TMP("LRC",$J,6989297.989795,"C",2)="For Test: Blood Sugar - interpretation comments"
 S ^TMP("LRC",$J,6989297.989795,1,"facility")="DoD facility1;100"
 ;
 S ^TMP("LRC",$J,6989297.989793,1)="9/11/2001 12:00^Blood^Blood Sugar!^1^low^gm/ml^2^3"
 S ^TMP("LRC",$J,6989297.989793,"C",1)="For Test: Blood Sugar - commentson the blood sugar reading..."
 S ^TMP("LRC",$J,6989297.989793,1,"facility")="DoD facility1;100"
 S ^TMP("LRC",$J,6989297.989793,"C",2)="For Test: Blood Sugar - commentson the blood sugar reading...!!!"
 ;
 S ^TMP("LRO",$J,6989297.989795,1)="Dec 10, 2003^;Blood Sugar^;Blood^ROUTINE^COMPLETED^;Marcus Welby MD^Dec 9, 2003^1^Dec 12, 2003^"
 S ^TMP("LRO",$J,6989297.989795,1,"facility")="DoD facility1;100"
 S ^TMP("LRO",$J,6989297.989795,2)="Dec 10, 2003^;Blood Sugar^;Blood^ROUTINE^COMPLETED^;Marcus Welby MD^Dec 9, 2003^1^Dec 13, 2003^"
 S ^TMP("LRO",$J,6989297.989795,2,"facility")="DoD facility1;100"
 S ^TMP("LRO",$J,6989297.989793,1)="Dec 6, 2003^;Potassium^;Blood^ROUTINE^COMPLETED^;Donald Auschlander MD^Dec 5, 2003^1^Dec 7, 2003^"
 S ^TMP("LRO",$J,6989297.989793,1,"facility")="DoD facility1;100"
 ;
 S ^TMP("PSOO",$J,6998787,0)="3010912^3001203^4601;AMPICILLIN 250MG^1274;FROMMATER,RANDY^E;EXPIRED^340^10^0^468^.33^3001210"
 S ^TMP("PSOO",$J,6998787,1,0)="Take 1 cap by mouth every day-BEST03"
 S ^TMP("PSOO",$J,6998787,2,0)="second line SIG"
 S ^TMP("PSOO",$J,6998787,"facility")="DoD Facility2;200"
 ;
 S ^TMP("RAE",$J,6989374.8989,1,0)="3010625.101^ECHOGRAM THYROID B-SCAN &/OR REAL TIME^WAITING FOR EXAM^VERIFIED^MACIMPOSTER,CARY^WELBY,MARCUS^76536^^66"
 S ^TMP("RAE",$J,6989374.8989,1,"D",1)="MAJOR ABNORMALITY, NO ATTN. NEEDED"
 S ^TMP("RAE",$J,6989374.8989,1,"I",1)="good impression of marketing ploy"
 S ^TMP("RAE",$J,6989374.8989,1,"facility")="DoD Facility3;300"
 ; CYTOLOGY
 S ^TMP("LRCY",$J,6989686.000022,0)="3/12/2001^010314 P 7990"
 S ^TMP("LRCY",$J,6989686.000022,1)="Site/Specimen^3010315.050752"
 S ^TMP("LRCY",$J,6989686.000022,1,1)="UNKNOWN/PAP SMEAR 1"
 S ^TMP("LRCY",$J,6989686.000022,1,2)="UNKNOWN/PAP SMEAR 2"
 S ^TMP("LRCY",$J,6989686.000022,"NDX",1)="AND PARTIALLY OBSCURING BLOOD."
 S ^TMP("LRCY",$J,6989686.000022,"facility")="MARTIN ACH FT BENNING GA;A1311"
 S ^TMP("LRCY",$J,6989686.000023,0)="3/12/2001^010314 P 7990"
 S ^TMP("LRCY",$J,6989686.000023,1)="Site/Specimen^3010315.050752"
 S ^TMP("LRCY",$J,6989686.000023,1,1)="UNKNOWN/PAP SMEAR"
 S ^TMP("LRCY",$J,6989686.000023,"NDX",1)="  NEGATIVE FOR MALIGNANT OR DYSPLASTIC CELLS."
 S ^TMP("LRCY",$J,6989686.000023,"facility")="MARTIN ACH FT BENNING GA;A1311"
 ; S ^XTMP("OMG FHIE PER",$J,DH)=^XTMP("OMG FHIE PER",$J,DH)_"| FINISHED"
 ;
 ; surgical pathology test observation
 S ^TMP("LRA",$J,7009679.9999,0)="Mar 19, 1999@00:01^990322 SP 2643"
 S ^TMP("LRA",$J,7009679.9999,.1)="Site/Specimen^2990323.154914"
 S ^TMP("LRA",$J,7009679.9999,.1,1)="SPECIMEN 1"
 S ^TMP("LRA",$J,7009679.9999,.1,2)="SPECIMEN 2"
 S ^TMP("LRA",$J,7009679.9999,1.4,1)="SURGICAL PATHOLOGY:"
 S ^TMP("LRA",$J,7009679.9999,1.4,2)="LINE TWO"
 S ^TMP("LRA",$J,7009679.9999,"facility")="HP0125;HP0125"
 ;
 ; microbiology
 S ^TMP("LRM",$J,6989374.8989,"Stool")="12/06/2003^010709 MI 286^the usual place^Stool^Bacteria^Final Result"
 S ^TMP("LRM",$J,6989374.8989,"Stool","facility")="Maynard test lab;123"
 S ^TMP("LRM",$J,6989374.8989,"Stool","RPT",1)="Tiny little life forms^Herbert^5"
 S ^TMP("LRM",$J,6989374.8989,"Stool","REPORT",1)="Line 1"
 S ^TMP("LRM",$J,6989374.8989,"Stool","REPORT",2)="Line 2"
 Q
 ;
DIS ; Discharge Summary
 S ^TMP("ORDATA",$J,3021108,"WP",1)="1^DOD Facility name;999"
 S ^TMP("ORDATA",$J,3021108,"WP",2)="2^09/04/1998 11:11"
 S ^TMP("ORDATA",$J,3021108,"WP",3)="3^09/17/1998 14:21"
 S ^TMP("ORDATA",$J,3021108,"WP",4)="4^JONES,BILL"
 S ^TMP("ORDATA",$J,3021108,"WP",5)="5^JONES,BOB"
 S ^TMP("ORDATA",$J,3021108,"WP",6)="6^COMPLETED"
 S ^TMP("ORDATA",$J,3021108,"WP",9,1)="9^ TITLE: Discharge Summary text 1"
 S ^TMP("ORDATA",$J,3021108,"WP",9,2)="9^ TITLE: Discharge Summary text 2"
 S ^TMP("ORDATA",$J,3021109,"WP",1)="1^DOD Facility name;999"
 S ^TMP("ORDATA",$J,3021109,"WP",2)="2^09/04/1998 11:11"
 S ^TMP("ORDATA",$J,3021109,"WP",3)="3^09/17/1998 14:21"
 S ^TMP("ORDATA",$J,3021109,"WP",4)="4^JONES,BILL 2"
 S ^TMP("ORDATA",$J,3021109,"WP",5)="5^JONES,BOB 2"
 S ^TMP("ORDATA",$J,3021109,"WP",6)="6^COMPLETED 2"
 S ^TMP("ORDATA",$J,3021109,"WP",9,1)="9^ TITLE: Discharge Summary text 3"
 S ^TMP("ORDATA",$J,3021109,"WP",9,2)="9^ TITLE: Discharge Summary text 4"
 Q
ADT2 ; ADT summary
 N X F X=1:1:15 D
 .S ^TMP("ORDATA",$J,3021108.1200,X)=" ADT SUMMARY - LINE "_X
 F X=1:1:15 D
 .S ^TMP("ORDATA",$J,3021107.1200,X)=" ADT SUMMARY - LINE "_X
 Q
 ;
ALRG2 ; Allergy data
 S ^TMP("ORDATA",$J,6988779.896699,"WP",1)="1^EISENHOWER AMC FT. GORDON;0047"
 S ^TMP("ORDATA",$J,6988779.896699,"WP",2)="2^PENICILLINS"
 S ^TMP("ORDATA",$J,6988779.896699,"WP",3)="3^Allergy"
 S ^TMP("ORDATA",$J,6988779.896699,"WP",4)="4^Oct 03, 2001@23:40"
 S ^TMP("ORDATA",$J,6988779.896699,"WP",5)="5^"
 S ^TMP("ORDATA",$J,6988779.896699,"WP",6,1)="6^Comments:"
 S ^TMP("ORDATA",$J,6988779.896699,"WP",6,2)="6^(not found  !!)"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",1)="1^EISENHOWER AMC FT. GORDON;0047"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",2)="2^PENICILLINS 2"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",3)="3^Allergy 2"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",4)="4^Oct 03, 2001@23:40"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",5)="5^"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",6,1)="6^Comments:"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",6,2)="6^(not found !!!)"
 Q
 ;
CONS2 ; Consult report data
 S ^TMP("ORDATA",$J,6988779.8967,"WP",1)="1^EISENHOWER Consult Fac;004 7"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",2)="2^Oct 03, 2001"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",3)="3^Oct 04, 2001@23:40"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",4)="4^DoD Consult service"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",5)="5^Consult status"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",6)="6^Procedure type"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",7,1)="7^First line report"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",7,2)="7^Second line report"
 Q
SADR2 ; Outpatient Encounter for SADR
 S ^TMP("ORDATA",$J,6988779.8967,"WP",1)="09/10/2002    ALASKA VAH     DR. BAYLIS (ANTICOAG)"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",2)="   Diagnosis: 436.-ACUTE, BUT ILL-DEFINED, CEREBROVASCULAR DISEASE; CVA (P)"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",3)="              286.9-OTHER AND UNSPECIFIED COAGULATION DEFECTS; Anticoagulation"
 S ^TMP("ORDATA",$J,6988779.8967,"WP",4)="   Procedure: 99211-OFFICE/OUTPATIENT VISIT, EST; Pharmacy Medication Management (1)" 
 S ^TMP("ORDATA",$J,6988779.8967,"WP",5)="              99213-OFFICE/OUTPATIENT VISIT, EST; Detailed Exam    (1)"
 ;
 S ^TMP("ORDATA",$J,6988779.8999,"WP",1)="ONE"
 S ^TMP("ORDATA",$J,6988779.8999,"WP",2)="TWO"
 S ^TMP("ORDATA",$J,6988779.8999,"WP",3)="THREE"
 S ^TMP("ORDATA",$J,6988779.8999,"WP",4)="FOUR"
 Q
 ;
LIST ; start ORB listener in background
 I $ZV["DSM" D
 .J START^OMGCBS("",""):(OPTION="/LOCAL=32760/SYM=1500000/STACK=124000/SOURCE=65535") W !,"STARTED JOB" Q
 I $ZV["Cache" D
 .J START^OMGCBS()
 Q
 ;
DELETE(IEN) ; Delete an IEN out of the Temporary Database
 S SUB="OMGCOAS TEMP|"_IEN
 I $D(^XTMP(SUB)) K ^XTMP(SUB) ;W "  <IEN: ",IEN," has been DELETED>"
 E  ;W "  <IEN: ",IEN," Does Not Exist in the Temporary Database>"
 Q
