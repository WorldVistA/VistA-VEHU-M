MHVUMRPC ;KUM/LB - myHealtheVet Management Utilities ; 6/18/2013
 ;;1.0;My HealtheVet;**11,22,24,29,40**;July 10, 2017;Build 26
 ;;Per VA Directive 6402, this routine should not be modified
 ;
 Q
 ;
 ;  Integration Agreements:
 ;
 ;                5266 : ^SC(D0
 ;                6013 : ^ECD(D0
 ;                2051 : LIST^DIC
 ;                6009 : ^ECJ(D0
 ;                6009 : ^ECJ("AP"
 ;                6010 : Event Capture API $$ELIG^ECUERPC
 ;                6011 : Event Capture API $$PATCLAST^ECUERPC1
 ;                6016 : Event Capture API $$SRCLST^ECUMRPC1
 ;                2701 : $$GETDFN^MPIF001
 ;                1874 : ^EC(725,D0
 ;                1873 : Read File 721
 ;                2741 : OE/RR Calls to GMPLUTL2
 ;                1995 : CPT Code APIs
 ;                3990 : ICD Code APIs
 ;                6155 : Read access to DMMS Units in NEW PERSON File 
 ;               10004 : $$GET1^DIQ
 ;
 Q
DSSUNT(RESULTS,MHVSTRING) ;
 ;
 ;This broker entry point returns DSS units from file 724
 ;        RPC: MHV GETDSSUNIT
 ;INPUTS         MHVARY - Contains the following subscripted elements
 ;                ACLNIEN   - Associated Clinic IEN (required) and PRVDUZ - Provider
 ;               
 ;OUTPUTS        RESULTS - Array of DSS units. Data pieces as follows:-
 ;               PIECE - Description
 ;                 1     IEN of Location
 ;                 2     Name of Location
 ;                 3     IEN of DSS Unit
 ;                 4     Name of DSS Unit
 ;                 5     Inactive flag (1-Yes/0-No)
 ;                 6     Send to PCE flag
 ;
 N MHVLIEN,MHVLNAM,MHVCIEN,MHVDIEN,MHVDNAM,MHVCNT,MHVDIACT,MHVCHKF,MHVDPCE,MHVR1
 N MHVR1E,MHVR1C,MHVDIV,MHVDIVN,MHVPDUZ,FLAG
 S MHVCNT=0
 S MHVDPCE=0
 S FLAG=0
 ;JAZZ#409966-Fix Names with Space in SM queries
 ;S MHVCIEN=+$P(MHVSTRING,"^",1)
 S MHVCIEN=$P(MHVSTRING,"^",1)
 I MHVCIEN='"*" S MHVCIEN=+MHVCIEN
 ;--------------------------------
 S MHVPDUZ=+$P(MHVSTRING,"^",2)
 K ^TMP($J,"MHVDUNT")
 ; Fetch Location IEN and Location Name
 ;JAZZ#409966-Fix Names with Space in SM queries
 ;and more User Fields: Retrieve all (*) User DSS Units
 ;I '$D(^SC(MHVCIEN,0)) S RESULTS(1)="0^DSS1-No clinic for IEN:"_MHVCIEN Q
 I '$D(^SC(MHVCIEN,0)),$G(MHVCIEN)'="*" S RESULTS(1)="0^DSS1-No clinic for IEN:"_MHVCIEN Q
 I $G(MHVCIEN)'="*" S FLAG=$$CLINIC Q:FLAG  ;JAZZ#409966  ;JAZZ#
 ; Fetch DSS Unit IEN from file #200
 D LIST^DIC(200.72,","_MHVPDUZ_",","@","QP","","","","","","","MHVR1","MHVR1E")
 I $G(MHVR1("DILIST",0))'>0 S RESULTS(1)="0^DSS3-No DSS Units found in New Person File" Q
 D:$G(MHVR1("DILIST",0))>0
 . S MHVR1C=0
 . F  S MHVR1C=$O(MHVR1("DILIST",MHVR1C)) Q:MHVR1C'>0  D
 . . S MHVDIEN=$G(MHVR1("DILIST",MHVR1C,0))
 . . I +$G(MHVDIEN)'>0 Q
 . . S MHVDNAM=$$GET1^DIQ(724,+MHVDIEN,.01)
 . . S MHVDIACT=$$GET1^DIQ(724,+MHVDIEN,5,"I")
 . . S MHVDPCE=$$GET1^DIQ(724,+MHVDIEN,13,"I")
 . . D MHVCHK
 . . I ($G(MHVCIEN)="*") Q:((+$G(MHVDIACT)=1)!(MHVCHKF=1))   ;JAZZ#409966
 . . ;I (+$G(MHVDIACT)=1)!(MHVCHKF=1)!('$D(^ECJ("AP",MHVLIEN,MHVDIEN))) Q 
 . . I ($G(MHVCIEN)'="*"),((+$G(MHVDIACT)=1)!(MHVCHKF=1)!('$D(^ECJ("AP",MHVLIEN,MHVDIEN)))) Q 
 . . D MHVRST
 I MHVCNT=0 D
 .I ($G(MHVCIEN)'="*") S RESULTS(1)="0^DSS4-No DSS Units found (Missing Event Code Screen) clinic IEN:"_MHVCIEN Q
 .S RESULTS(1)="0^DSS4-No DSS Units found clinic IEN:"_MHVCIEN Q
 Q
MHVRST ;Populate results array
 S MHVCNT=MHVCNT+1
 S RESULTS(MHVCNT)=$G(MHVLIEN)_"^"_$G(MHVLNAM)_"^"_$G(MHVDIEN)_"^"_$G(MHVDNAM)_"^"_$G(MHVDIACT)_"^"_$G(MHVDPCE)
 Q
MHVCHK ;Check if DSS Unit is already populated in results array  ;JAZZ#
 N MHVI
 S MHVCHKF=0
 S MHVI=0 F  S MHVI=$O(RESULTS(MHVI)) Q:'MHVI!MHVCHKF  D
 . I MHVDIEN=$P(RESULTS(MHVI),"^",3) S MHVCHKF=1
 Q
CLINIC() ;Get clinic
 N FLG
 S FLG=0
 S MHVDIV=$$GET1^DIQ(44,+MHVCIEN,3.5,"I"),MHVDIVN=$$GET1^DIQ(44,+MHVCIEN,3.5,"E")
 I +$G(MHVDIV)=0!($G(MHVDIVN)="") S RESULTS(1)="0^DSS2-No Division found for clinic IEN:"_MHVCIEN,FLG=1 Q FLG
 S MHVLIEN=$$GET1^DIQ(40.8,+MHVDIV,.07,"I"),MHVLNAM=$$GET1^DIQ(40.8,+MHVDIV,.07,"E")
 I MHVLIEN="" S MHVLIEN=$$GET1^DIQ(44,+MHVCIEN,3,"I"),MHVLNAM=$$GET1^DIQ(44,+MHVCIEN,3,"E")
 I +$G(MHVLIEN)=0!($G(MHVLNAM)="") S RESULTS(1)="0^DSS1-No Institution found for clinic IEN:"_MHVCIEN,FLG=1 Q FLG
 Q FLG
PRINTRES ; Print Results
 N I
 S I="" F  S I=$O(@RESULTS@(I)) Q:I=""  D
 . W !,"LOCATIONIEN LOCATIONNAME DSSUNITIEN DSSUNITNAME INACTIVE"
 . W !,@RESULTS@(I)
 Q
DSSPROCS(RESULTS,MHVARY) ; Get Procedures from DSS Unit IEN and Locaiton IEN
 ; MHVARY IS DSS UNIT IEN AND LOCATION IEN
 ; RESULTS = Procedure IEN^Procedure 5 digit code and description^synonym^Active flag
 N MHVLOC,MHVECD,MHVCAT,MHVPX,MHVIEN,MHVNODE,MHVPRO,MHVSYN,MHVPN,MHVSTAT,MHVCNT
 S MHVLOC=+$P(MHVARY,"^",1)
 S MHVECD=+$P(MHVARY,"^",2)
 S MHVCNT=0
 S MHVCAT="" F  S MHVCAT=$O(^ECJ("AP",MHVLOC,MHVECD,MHVCAT)) Q:MHVCAT=""  D
 . S MHVPX="" F  S MHVPX=$O(^ECJ("AP",MHVLOC,MHVECD,MHVCAT,MHVPX)) Q:MHVPX=""  S MHVIEN=0 D
 ..F  S MHVIEN=$O(^ECJ("AP",MHVLOC,MHVECD,MHVCAT,MHVPX,MHVIEN)) Q:'MHVIEN  D
 ...S MHVNODE=$G(^ECJ(MHVIEN,0)) I MHVNODE="" Q
 ...S MHVPRO=$G(^ECJ(MHVIEN,"PRO")),MHVSYN=$P(MHVPRO,U,2),MHVPN=$P($P(MHVPRO,U),";")
 ...I $G(MHVPN)="" Q
 ...I $P(MHVPRO,U)["EC" S MHVPN=$G(^EC(725,MHVPN,0)),MHVPRO=$P(MHVPN,U,2)_" "_$P(MHVPN,U)
 ...E  S MHVPN=$$CPT^ICPTCOD(MHVPN) S MHVPRO=$P(MHVPN,U,2)_" "_$P(MHVPN,U,3)
 ...S MHVSTAT=$S($P(MHVNODE,U,2)'="":"No",1:"Yes")
 ...; STATUS (Y-Active/N-Inactive)
 ...I $G(MHVSTAT)="No" Q
 ...S MHVCNT=MHVCNT+1
 ...S RESULTS(MHVCNT)=$G(MHVPX)_U_$P($G(MHVPN),U)_U_$P($G(MHVPN),U,2)_U_$G(MHVSYN)_U_$G(MHVSTAT)
 I MHVCNT=0 S RESULTS(1)="0^No Procedures found for DSS Unit IEN:"_MHVECD_" and Location IEN:"_MHVLOC Q
 Q
PATECLS(RESULTS,MHVSTRING) ; Get Patient eligibility and Classification data
 ; MHVSTRING IS PATIENT ICN, DSS UNIT IEN, PROCEDURE DATE AND TIME IN FILEMAN FORMAT
 ; RESULTS = PATIENT STATUS ^CLASSIFICATION DATA (AGENT ORANCE, IONIZING RADIATION, SC CONDITION, ENVIRONMENTAL CONTAMINANTS, MILITARY SEXUAL TRUMA
 ; RESULTS(1,2...)=PRIMARY/SECONDARY FLAG (1-PRIMARY,0-SECONDARY)^ELIGIBILITY IEN^ELIGIBILITY DESCRIPTION
 N MHVPIEN,MHVECD,MHVPDT,MHVI,MHVCNT,MHVPICN,ECARY
 ; Get Patient IEN from Patient ICN
 S MHVPICN=+$P(MHVSTRING,"^",1)
 I $G(MHVPICN)'>0 S RESULTS(1)="0^No Patient ICN" Q
 S MHVPIEN=$$GETDFN^MPIF001(MHVPICN)
 I $P($G(MHVPIEN),"^",1)=-1 S RESULTS(1)="0^Patient ICN not in Database" Q
 ;
 S $P(MHVSTRING,"^",1)=MHVPIEN
 S MHVECD=$P(MHVSTRING,"^",2)
 S MHVPDT=$P(MHVSTRING,"^",3)
 ; GET PATIENT ELIGIBILITY
 S ECARY=$G(MHVPIEN)
 D ELIG^ECUERPC(.RESULTS,.ECARY)
 I $G(RESULTS)="" S RESULTS(1)="0^No Eligibility codes found for Patient DFN:"_MHVPIEN Q 
 S MHVCNT=0
 S MHVI="" F  S MHVI=$O(@RESULTS@(MHVI)) Q:MHVI=""  D
 . S MHVCNT=MHVCNT+1
 . S RESULTS(MHVCNT)=@RESULTS@(MHVI)
 I MHVCNT=0 S RESULTS(1)="0^No Eligibility codes found for Patient DFN:"_MHVPIEN Q 
 ; GET PATIENT CLASSIFICATION DATA
 S ECARY=MHVSTRING
 S RESULTS=""
 D PATCLAST^ECUERPC1(.RESULTS,.ECARY)
 S RESULTS(0)=RESULTS
 I RESULTS="" S RESULTS(1)="0^No Classification data found for Patient DFN:"_MHVPIEN Q
 Q
DIAGPL(RESULTS,MHVSTRING) ; Get Patient Diagnosis codes from Patient Probelm list
 ; MHVSTRING IS PATIENT ICN
 ; RESULTS = DIAGNOSIS CODE IEN^DIAGNOSIS CODE^SNOMED-CT DESCRIPTION~ICD-10 DESCRIPTION^ICD CODING SYSTEM 
 N MHVPIEN,MHVPICN,MHVCNT,MHVDCOD,PRB,DCOD
 ; Get Patient IEN from Patient ICN
 S MHVPICN=+$P(MHVSTRING,"^",1)
 I $G(MHVPICN)'>0 S RESULTS(1)="0^No Patient ICN" Q
 S MHVPIEN=$$GETDFN^MPIF001(MHVPICN)
 I $P($G(MHVPIEN),"^",1)=-1 S RESULTS(1)="0^Patient ICN not in Database" Q
 ;
 S $P(MHVSTRING,"^",1)=$G(MHVPIEN)
 K MHVROOTP
 D LIST^GMPLUTL2(.MHVROOTP,MHVPIEN,"A")
 I $G(MHVROOTP(0))<1 S RESULTS(1)="0^No Diagnosis codes found in Patient Problem List" Q
 S MHVCNT=0
 ;Fix for ICD 10 PRODUCTION ISSUE on date switch
 ;Item#2.Story 223914: SM WLC - ICD10 - SNOMED CT Problem List and Encounter Completion and Workload 
 F  S MHVCNT=MHVCNT+1 Q:MHVCNT>$G(MHVROOTP(0))  D
 . S MHVDCOD=$P($P(MHVROOTP(MHVCNT),"^",4),"/",1)
 . S MHVDIEN=$P($$CODEN^ICDCODE(MHVDCOD,80),"~",1)
 . ;Story 272695 Emergency Fix 
 . ;- adding the ICD-10 Description as second " - " piece to Problem SNOMED-CT Description
 . I $P(MHVROOTP(MHVCNT),"^",13)="10D",$L($G(MHVDCOD)) D
 . . S DCOD="757.01^"_$G(MHVDCOD)
 . . D DIAGSRCH(.PRB,.DCOD)
 . . I $L($G(PRB(1))),($P(PRB(1),"^",2)'=0) S $P(MHVROOTP(MHVCNT),"^",3)=$P(MHVROOTP(MHVCNT),"^",3)_" - "_$P($G(PRB(1)),"^",3)
 . .;- end of code for Story 272695 Emergency Fix 
 . S RESULTS(MHVCNT)=$G(MHVDIEN)_"^"_$G(MHVDCOD)_"^"_$P(MHVROOTP(MHVCNT),"^",3)_"^"_$P(MHVROOTP(MHVCNT),"^",13)
 Q
DIAGSRCH(RESULTS,MHVSTRING) ; Get Diagnosis codes and description from Search string
 ; MHVSTRING IS SEARCH STRING AND FILE TO SEARCH
 ; RESULTS = DIAGNOSIS CODE IEN IN FILE 80^DIAGNOSIS CODE^DESCRIPTION
 N MHVSTR,MHVCNT
 K MHVROOT
 ; FILENAME^ICD
 ;S MHVSTR=$P(MHVSTRING,U)_"^ICD|"_$P(MHVSTRING,U,2)_"|DT^"
 ;Fix for ICD 10 PRODUCTION ISSUE on date switch
 ;Item#1.Story 26244 SM WLC - ICD10 - SNOMED CT Problem List and Encounter Completion and Workload 
 S MHVSTR=$P(MHVSTRING,U)_"^ICD|"_$P(MHVSTRING,U,2)_"|"_DT_"^"
 D SRCLST^ECUMRPC1(.MHVROOT,.MHVSTR)
 I $G(MHVROOT)="" S RESULTS(1)="^0^No results found" Q
 S MHVCNT=0
 ;Per Secure Messaging (SM) Change Request (CR)Release 12.15
 ;User Story:  Problem List ICD-10 enhancement:
 ;restrict the number of records returned from VistA to 199 or less
 ;S I="" F  S I=$O(@MHVROOT@(I)) Q:I=""  D
 S I="" F  S I=$O(@MHVROOT@(I)) Q:(I="")!(MHVCNT>199)  D
 . S MHVCNT=MHVCNT+1
 . S RESULTS(I)=@MHVROOT@(I)
 . S RESULTS(I)=$P(RESULTS(I),"^",3)_"^"_$P(RESULTS(I),"^",1)_"^"_$P(RESULTS(I),"^",2)_"^"_$P($P(RESULTS(I),"(",2),")",1)
 I MHVCNT=0 S RESULTS(1)="^0^No results found" Q
 Q
