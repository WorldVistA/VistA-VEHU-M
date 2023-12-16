MAGJUTL3 ;WIRMFO/JHC - VistARad subrtns & RPCs ; 10/17/2022
 ;;3.0;IMAGING;**16,9,22,18,65,76,101,90,120,133,341**;Dec 21, 2022;Build 28
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;; ISI IMAGING;**99,101,102**
 Q
 ;RPC Entry points:
 ; LISTINF--Custom list info
 ; LOGOFF--update session file
 ; CACHEQ--init session data
 ; PINF1--Patient info
 ; USERINF2--P18 inits for the session
 ;Subrtn EPs:
 ; LOG--Upd image access log
 ; MAGJOBNC--inits for non-client sessions
 ; USERKEYS--user key info
 ; USERINF--user info
 ;
LISTINF(MAGGRY) ; RPC: MAGJ CUSTOM LISTS
 ;  get Exam List data
 ; Return in ^TMP($J,"MAGJLSTINF",0:N)
 ;     0)= # Entries below (0:n)
 ;   1:n)= Button Label^List #^Button Hints^List Type
 ;
 ; MAGGRY holds $NA ref to ^TMP for return message
 ;   all refs to MAGGRY use SS indirection
 ;
 ; GLB has $NA ref to ^MAG(2006.631), Custom Lists
 ;   refs to GLB use SS indirection to get data from this file
 ;
 S X="ERR1^MAGJUTL3",@^%ZOSF("TRAP")
 N D0,GLB,INF,MAGLST,NAM,T
 N LSTNUM  ; ISI
 S MAGLST="MAGJLSTINF"
 K MAGGRY S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY S @MAGGRY@(0)=0
 S GLB=$NA(^MAG(2006.631)),NAM=""
 F  S NAM=$O(@GLB@("B",NAM)) Q:NAM=""  S D0="" D
 . S D0=$O(@GLB@("B",NAM,D0)) Q:'D0  D
 . . ;   ISI begin
 . . S X=$G(@GLB@(D0,0)) Q:'$P(X,U,6)  ;  List not Active
 . . S LSTNUM=$P(X,U,2)
 . . I LSTNUM>9900 Q:'$$MGRREV2^ISIJUTL9("CLIENT")   ; ISI System-defined & Rev-2 not enabled; chg 9000 to 9900
 . . I  I LSTNUM'=9992,(LSTNUM'=9993) Q    ;  for Rev-2, these 2 lists move to Custom List tab
 . . I LSTNUM=9820,'($P($G(^MAG(2006.69,1,"ISI")),U,2)="Y") Q  ; Dynamic Query not enabled
 . . I "^9800^9801^9802^9803^"[(U_LSTNUM_U) D  Q:'LSTNUM  ;  Use Assign lists?
 . . . I '($P($G(^MAG(2006.69,1,"ISI")),U,1)="Y") S LSTNUM=0 Q  ; Assign feature not enabled
 . . . I $$MGRREV2^ISIJUTL9("CLIENT") I LSTNUM=9800!(LSTNUM=9801) S LSTNUM=0 Q  ; Rev-2, these 2 lists move to Main tab
 . . . I LSTNUM=9802!(LSTNUM=9803),'$D(MAGJOB("KEYS","ISIJ ASSIGN EXAMS-VIEW ALL")) S LSTNUM=0 Q  ; key needed for this list
 . . . Q  ;  ISI end
 . . S INF="" F I=1:1 S T=$P("7^2^1^3",U,I) Q:T=""  S Y=$P(X,U,T) Q:Y=""  S $P(INF,U,I)=Y
 . . Q:T'=""  ; req'd fields not all there
 . . S T=@MAGGRY@(0)+1,^(0)=T,^(T)=INF ; add entry to reply
 Q
 ;
LOG(ACTION,LOGDATA,PSETLST) ; Log exam access
 ;  ACTION --- Action code string passed in (e.g. VR-VW for vrad view)
 ;  LOGDATA - ^-delimited fields--see code immediately below
 ;  PSETLST -- For Printset exams, has list of Rad Case Numbers included
 ;  
 N PTCT,TXT,RADFN,MAGIEN,NIMGS,REMOTE,PRTSET
 S RADFN=$P(LOGDATA,U),MAGIEN=$P(LOGDATA,U,2),NIMGS=$P(LOGDATA,U,3),REMOTE=$P(LOGDATA,U,4)
 ;
 ; For Printset, append string to TXT
 ;   string= "|VR-PRINTSET~"_CaseNum_~x~y   ; x = nth; y = total PrtSet members
 ;   
 S PSETLST=$G(PSETLST)
 S PRTSET=$L(PSETLST,U)
 I PRTSET>1 D
 . N I,T F I=1:1:PRTSET S T=$P(PSETLST,U,I),T=$P(T,"-",$L(T,"-")),PRTSET(I)="VR-PRINTSET~"_T_"~"_I_"~"_PRTSET
 I ACTION="" S ACTION="UNKNOWN"  ; Should never happen
 S PTCT=RADFN'=$G(MAGJOB("LASTPT",ACTION))
 I PTCT S MAGJOB("LASTPT",ACTION)=RADFN
 S TXT=ACTION_U_RADFN_U_MAGIEN_U_U_U_NIMGS
 S TXT=TXT_U_PTCT_U_$S(+MAGJOB("USER",1):1,1:0)_U_REMOTE
 ;
 ;=== Log to Imaging Windows Sessions file (#2006.82).
 ;  for PRTSET members 2 to N (prevent double-counting):
 ;    set NIMGS = 0
 ;    set PTCT to FALSE
 ;
 I PRTSET>1 N I F I=1:1:PRTSET D
 . I I>1 S $P(TXT,U,6)=0,$P(TXT,U,7)=0
 . D ACTION^MAGGTAU(TXT_"|"_PRTSET(I),1)
 E  D ACTION^MAGGTAU(TXT,1)
 ;
 ;=== Log to Mag Log
 ;  For Printset, add string to new Param-7 prior to calling ENTRY...
 ;    string= s/a above, but no pipe char.
 ;    for PRTSET members 2 to N set NIMGS = 0 to not double-count
 ;
 I REMOTE S ACTION=ACTION_"/REM"
 I PRTSET>1 N I F I=1:1:PRTSET D
 . I I>1 S NIMGS=0
 . D ENTRY^MAGLOG(ACTION,+DUZ,MAGIEN,"VRAD:"_MAGJOB("VRVERSION"),RADFN,NIMGS,PRTSET(I))
 E  D ENTRY^MAGLOG(ACTION,+DUZ,MAGIEN,"VRAD:"_MAGJOB("VRVERSION"),RADFN,NIMGS)
 Q
 ;
LOGOFF(MAGGRY,DATA) ; RPC: MAGJ LOGOFF
 ;
 ;=== Update Imaging Windows Sessions file: logoff time & session entry closed.
 D LOGOFF^MAGGTAU(.MAGGRY)
 Q
 ;
CACHEQ(MAGGRY,DATA) ; RPC: MAGJ CACHELOCATION
 ; some logon inits & get alternate paths for Remote Reading
 ; input in DATA:
 ;  - WSLOC   = WS Loc'n
 ;  - VRADVER = Client Vs -- p32 ONLY
 ;  - OSVER   = Client OS Vs -- p32 ONLY
 ; Return in ^TMP($J,"MAGJCACHE",0:N) (@MAGGRY)
 ;     0)= # Entries below (0:n)
 ;   1:n)= PhysName^Subdirectory^HashFlag^Username^Password^AltPath_IEN
 ;
 ; MAGGRY holds $NA reference to ^TMP for return message
 ;   refs to MAGGRY use SS indirection
 ;
 ; Also builds local array:  p32/p18 compatibility: Some of this is moved to userinf2 below
 ;  MAGJOB("LOC",NetworkLocnIEN)=Site Abbrev
 ;     ("REMOTE")=1/0  (T/F for "User is Remote")
 ;     ("REMOTESCREEN")=0/1  (init User-switchable Remote Screening--P18 use only)
 ;     ("WSLOC")=WS Loc'n String
 ;     ("WSLOCTYP")=WS Loc'n Type
 ;     ("WSNAME")=WS ID
 ;     ("VRVERSION")=VRAD Vs
 ;     ("OSVER")=O/S Vs
 ;     ("ALTPATH")=1/0 ^ 1/0 (T/F Alt Paths are defined 
 ;               ^ Alt Paths Enabled/Disabled for most recent exam)
 ;
 S X="ERR1^MAGJUTL3",@^%ZOSF("TRAP")
 ;
 N I,MAGLST,REPLY,TMP,WSLOC,XX,VRADVER,OSVER,DIQUIET,ALTIEN
 S DIQUIET=1 D DT^DICRW
 S REPLY=0,MAGLST="MAGJCACHE"
 K MAGGRY S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY
 S WSLOC=$$UPCASE($P(DATA,U)),VRADVER=$P(DATA,U,2),OSVER=$P(DATA,U,3)
 I '$D(MAGJOB("OSVER")) D  ; ID p32 initialization
 . S MAGJOB("OSVER")=$S(OSVER]"":OSVER,1:"UNK")
 . S MAGJOB("VRVERSION")=$S(VRADVER]"":VRADVER,1:"UNK")
 . D MAGJOB ; p32 init of VRAD
 ; get alt paths location info
 S MAGJOB("WSLOC")=WSLOC,MAGJOB("REMOTE")=0
 S MAGJOB("REMOTESCREEN")=+$P($G(^MAG(2006.69,1,0)),U,10)
 I WSLOC]"" D
 . S X=$P($G(^MAG(2006.1,+MAGJOB("SITEP"),0)),U,9)
 . I X]"",(X'=WSLOC) S MAGJOB("REMOTE")=1
 . E  Q
 . D LIST^MAGBRTLD(WSLOC,.TMP)
 . I TMP S REPLY=TMP,MAGJOB("ALTPATH")=$G(MAGJOB("ALTPATH"),"1^1") F I=1:1:TMP D
 . . S ALTIEN=$P(TMP(I),U,7)
 . . S XX=$P(TMP(I),U,1,5),X=$P(XX,U,3),$P(XX,U,3)=$S(X="Y":1,1:0)
 . . S X=$P(XX,U,4),$P(XX,U,4)=$P(XX,U,5),$P(XX,U,5)=X,$P(XX,U,6)=ALTIEN
 . . S @MAGGRY@(I)=XX,MAGJOB("LOC",ALTIEN)=$P(TMP(I),U,6)
 I '$D(MAGJOB("ALTPATH")) S MAGJOB("ALTPATH")="0^0"
 S @MAGGRY@(0)=REPLY
CACHEQZ Q
 ;
MAGJOBNC ; EP for Prefetch/Bkgnd calls (NOT a Vrad Client)
 N NOTCLIEN S NOTCLIEN=1
 D MAGJOB
 Q
 ;
MAGJOB ; Init magjob array
 N T,RIST
 I $G(MAGJOB("VRVERSION")) S X=MAGJOB("VRVERSION")
 E  S X="" ; non-client process  ;  ISI
 ;  ISI  remove deprecated logic
 D USERKEYS
 S MAGJOB("CONSOLIDATED")=($G(^MAG(2006.1,"CONSOLIDATED"))="YES")
 S MAGJOB("SITEP")=$$IMGSIT^MAGJUTL1(DUZ(2),1)  ; Site Param ien
 S RIST="" F X="S","R" I $D(^VA(200,"ARC",X,DUZ)) S RIST=X Q
 S RIST=$S(RIST="S":15,RIST="R":12,1:0) ; Staff/Resident/Non rist
 S MAGJOB("USER",1)=RIST_U_$$USERINF(+DUZ,".01;1") ; RIST_Type^NAME^INI
 S X=$P($G(IO("CLNM")),"."),MAGJOB("WSNAME")=$S(X]"":X,1:"VistaradWS")
 K MAGJOB("DIVSCRN") I MAGJOB("CONSOLIDATED") D
 . ; include logon DIV, other DIVs to screen Unread Lists & Locking
 . I $G(DUZ(2))]"" S MAGJOB("DIVSCRN",DUZ(2))=""
 . S DIV=""
 . I DUZ(2)'=$P(MAGJOB("SITEP"),U,3) D  ; Assoc DIV
 . . S IEN=$O(^MAG(2006.1,+MAGJOB("SITEP"),"INSTS","B",DUZ(2),0))
 . . I IEN F  S DIV=$O(^MAG(2006.1,+MAGJOB("SITEP"),"INSTS",IEN,201,"B",DIV)) Q:'DIV  S MAGJOB("DIVSCRN",DIV)=""
 . E  D  ; Parent DIV
 . . F  S DIV=$O(^MAG(2006.1,+MAGJOB("SITEP"),201,"B",DIV)) Q:'DIV  S MAGJOB("DIVSCRN",DIV)=""
 S MAGJOB("WSLOCTYP")=$S(+MAGJOB("USER",1):"RAD",1:"Non-Rad") ; USer is Rist/Not
 I '$D(MAGJOB("WRKSIEN")) D
 . Q:+$G(NOTCLIEN)  ; proceed only if Vrad Client is attached
 . S X=MAGJOB("WSNAME")
 . S $P(X,U,4)=MAGJOB("WSLOCTYP")
 . S $P(X,U,8)=1                     ; StartupMode=Normal.
 . S $P(X,U,9)=MAGJOB("OSVER")
 . S $P(X,U,10)=MAGJOB("VRVERSION")
 . S $P(X,U,17)=MAGJOB("VRBLDDTTM")
 . D UPD^MAGGTAU(.Y,X)
 . D REMLOCK^MAGJEX1B ; put here to only run 1x/ login
 . D REMLOCK^ISIJRPT2 ;  ISI, ditto
 Q
 ;
USERINF(DUZ,FLDS) ; get data from user file
 I FLDS=""!'DUZ Q ""
 N I,RSL,T S RSL=""
 D GETS^DIQ(200,+DUZ,FLDS,"E","T")
 S T=+DUZ_","
 F I=1:1:$L(FLDS,";") S RSL=RSL_$S(RSL="":"",1:U)_T(200,T,$P(FLDS,";",I),"E")
 Q RSL
 ;
USERKEYS ; Store Security Keys in MagJob
 N I,X,Y
 N MATCH ; ISI
 N MAGKS ; keys to send to XUS KEY CHECK
 N MAGKG ; returned
 K MAGJOB("KEYS")
 S I=0  ; ISI
 F MATCH="MAGJ","ISIJ" S X=MATCH D  ; ISI
 . F  S X=$O(^XUSEC(X)) Q:$E(X,1,4)'=MATCH  D  ; ISI
 . . S I=I+1,MAGKS(I)=X
 I '$D(MAGKS) Q
 D OWNSKEY^XUSRB(.MAGKG,.MAGKS)
 S I=0 F  S I=$O(MAGKG(I)) Q:'I  I MAGKG(I) S MAGJOB("KEYS",MAGKS(I))=""
 Q
 ;
PINF1(MAGGRY,MAGDFN) ;RPC Call MAGJ PT INFO -- Get pt info
 N AGE,DFN,DOB,MAGSSN,X
 S X="ERR3^MAGJUTL3",@^%ZOSF("TRAP")
 S (AGE,MAGSSN)=""
 D INFO^MAGGTPT1(.MAGGRY,MAGDFN_"^1^^^1") ; 1=Don't log to session file; 4-digit yr
 I +MAGGRY D
 . ; calculate Age & SSN/MRN display strings
 . S DOB=$P(MAGGRY,U,5)
 . I DOB D DT^DILF("",DOB,.X,"") S AGE=$$AGECALC(X)
 . S DFN=MAGDFN D PID^VADPT6 S MAGSSN=$S(VAERR:"Unknown",1:VA("PID")) ; IA #10062 (Supported)
 . K VA("PID"),VA("BID"),VAERR
 S MAGGRY=MAGGRY_"|"_AGE_U_MAGSSN
 Q
 ; 
AGECALC(DOB) ; calculate age from DOB til now
 ; format for age-appropriate display
 ; Input DOB in Fileman format
 ;   Note: assumes a previously validated date is passed in
 N AGE,NDAYS,X,X1,X2
 S AGE="unknown"
 I DOB?7N1"."0.N S DOB=$E(DOB,1,7) ; strip off time value
 I DOB?7N D
 . D NOW^%DTC S X1=X K %I
 . s X2=DOB D ^%DTC S NDAYS=X
 . I NDAYS<0 Q  ; * Invalid DOB later than today --> Unknown
 . I NDAYS<32 S AGE=NDAYS_"d" Q  ; days
 . I NDAYS<365 S AGE=$J(NDAYS\30.5,0,0)_"m" Q  ; months
 . I NDAYS=365 S AGE="1y 0m" Q  ; special case
 . S AGE=NDAYS\365.25_"y"  ; years
 . I AGE<16 S AGE=AGE_" "_(($J(NDAYS#365.25,0,0))\30.5)_"m" Q  ; years & months
 Q AGE
 ; 
 ;+++++ INITIALIZE SESSION (VERSION CHK, DISPLAY RES CHK, COLLECT USER INFO).
 ; RPC: MAGJ USER2
 ; 
 ; MAGGRY      Reference to a variable naming the global to store returned data
 ; 
 ; DATA        Information about the client and its workstation.
 ;               ^01: MAMMORES -- Screen resolution of main viewer display:
 ; 
 ;                       format is X_"x"_Y_","_ColorType (e.g., 2048x2580,GRAY)
 ;                       where X,Y are resolutions & ColorType={GRAY, COLOR}.
 ;                
 ;               ^02: Client Vs ....... Client software version for checking.
 ;               ^03: Client O/S Vs ... Client OS version for logging.
 ;               ^04: ClientBuildDayTime ..... for logging.
 ;
 ; Return Values
 ; =============
 ; 
 ; ^(0)
 ;     |01
 ;        ^01: 1/0 -- Success/Fail flag for version check.
 ;        ^02: 
 ;            ~01: code ... 4=fail.
 ;            ~02: Msg .... Message to display if fail.
 ;     |02
 ;        ^01: DUZ
 ;        ^02: NAME
 ;        ^03: INITIALS
 ;        ^04: REQFLAG .... 1/0 Enable/Disable Requisition for non-rad staff
 ;        ^05: SVERSION ... VistARad Server Version
 ;        ---- Patch MAG*3*101 ----
 ;        ^06: DICTPREF ... 1/0 ENA DICT PREF-YES ALL LOCKED (File 2006.69,13)
 ;        ---- Patch MAG*3*90 ----
 ;        ^07: SSN
 ;        ^08: UserLocalStationNumber
 ;        ^09: LocalPrimaryDivision
 ;        ^10: PrimarySiteStationNumber
 ;        ^11: SiteServiceURL
 ;        ^12: SiteCode       
 ;        ^13: ENABLE MANAGER REV-2? -- Conditionally, only if client is v1.1.1 or higher
 ;        ^14: Place-holder for Coerce Dict (abandoned P108)
 ;        ^15: NOTES ENABLE?  ; ISI P341
 ;        ^16: HL7 SENDING APPLICATION  ; ISI P341
 ;        ^17: ISI Rad Dictation Enable  ; ISI P341
 ;        ^18: Implementation Variant  ; ISI P341
 ; ^(1)
 ;     ^01: UserName ... Network UserName
 ;     ^02: PSW ........ Network Password
 ;     ^03: UserType ... 3=Staff R'ist, 2=Resident R'ist, 1=Rad Tech, 0=Non-Rad
 ;     ^04: SYSADMIN ... 1/0 1=user has System User privileges
 ;     ^05: Production account? 1/0 1=yes
 ;
 ; ^(2:N)   Security Keys
 ; ^(N+1:M) Mammography display message data
 ;
USERINF2(MAGGRY,DATA) ; RPC: MAGJ USER2--get user info
 S X="ERR2^MAGJUTL3",@^%ZOSF("TRAP")
 K MAGGRY S MAGGRY(0)="",MAGGRY(1)=""
 I +$G(DUZ)=0 S MAGGRY(0)="0^4~DUZ Undefined, Null or Zero|" Q
 N I,J,K,Y,REQFLAG,VRADVER,OSVER,RADTECH,PLACE,REPLY,DICTPREF,MAMMORES,ICNT,MSG
 S MAMMORES=$P(DATA,U),VRADVER=$P(DATA,U,2),OSVER=$P(DATA,U,3)
 D CHKVER^MAGJUTL5(.REPLY,VRADVER,.PLACE,.SVERSION)
 I 'REPLY S MAGGRY(0)=REPLY_"|^^^^",MAGGRY(1)="^^^" G USERIN2Z ; Version check or PLACE failed
 S RADTECH=""
 S MAGJOB("OSVER")=$S(OSVER]"":OSVER,1:"UNK")   ; IDs P18 initialization; cf cacheq ep above
 S MAGJOB("VRVERSION")=$S(VRADVER]"":VRADVER,1:"UNK")
 S MAGJOB("VRBLDDTTM")=$P(DATA,U,4)
 S MAGJOB("VSVERSION")=SVERSION
 D MAGJOB
 ;
 ;=== Enable/Disable Requisition if not a radiology user
 S REQFLAG=1
 I 'MAGJOB("USER",1) D  ; not a rist
 . I $D(^VA(200,"ARC","T",+DUZ)) S RADTECH=1 Q  ; Rad Tech OK
 . S X=+$P($G(^MAG(2006.69,1,0)),U,16)
 . I X S REQFLAG=0 ; Disable Req
 S DICTPREF=+$P($G(^MAG(2006.69,1,0)),U,17)
 S MAGGRY(0)=REPLY_"|"_DUZ_U_$$GET1^DIQ(200,DUZ_",",.01)_U_$$GET1^DIQ(200,DUZ_",",1)_U_REQFLAG_U_SVERSION_U_DICTPREF
 ;
 ;=== Add "^"-pieces 7:12 for ViX (MAG*3*90).
 S MAGGRY(0)=MAGGRY(0)_U_$$GET1^DIQ(200,DUZ_",",9) ;...SSN
 S MAGGRY(0)=MAGGRY(0)_U_$$GET1^DIQ(4,DUZ(2),99,"E") ;.UserLocalStationNumber
 S MAGGRY(0)=MAGGRY(0)_U_$P($$SITE^VASITE(),U) ;.......LocalPrimaryDivision  ; ISI correct bug $P-1
 S MAGGRY(0)=MAGGRY(0)_U_$P($$SITE^VASITE(),U,3) ;.....PrimarySiteStationNumber
 ;
 ;=== Lookup SiteServiceURL.
 N SSUNC,VIXPTR
 S VIXPTR=$P($G(^MAG(2006.1,+MAGJOB("SITEP"),"NET")),"^",5)
 ;
 ;=== Return UNC only if OpStatus is 'online'.
 I VIXPTR,+$P($G(^MAG(2005.2,VIXPTR,0)),"^",6) D
 . S SSUNC=$P($G(^MAG(2005.2,VIXPTR,0)),"^",2)
 S MAGGRY(0)=MAGGRY(0)_U_$G(SSUNC) ;...................SiteServiceURL
 S MAGGRY(0)=MAGGRY(0)_U_$P(MAGJOB("SITEP"),U,2) ;.....SiteCode
 ;
 ; ISI begin; 101 -- Rev-2 enabled in v1.1.1
 ; ISI begin P341 -- 
 N IMPLVARIANT,ISIDICTENA,NOTESENA,REV2,SENDAPP,T
 S REV2=0,IMPLVARIANT=2  ; "NOT Jordan" implementation status
 S X=MAGJOB("VRVERSION") I X?1"1.1.".E,($P(X,".",3)>0) S REV2=$$MGRREV2^ISIJUTL9("CLIENT")
 S NOTESENA=+$P($G(^MAG(2006.69,1,"ISI")),U,9)  ; Enable Notes?
 S ISIDICTENA=+$P($G(^MAG(2006.69,1,"ISI")),U,10)  ; Enable ISI Dictation option?
 S SENDAPP="RA-ISIRAD-TCP"
 I $$UJOCHECK^ISIJUTL9() S SENDAPP="RA-PSCRIBE-TCP"  ; HL7 Send Applic for Jordan
 I  S IMPLVARIANT=1  ; "Jordan" implementation status
 S MAGGRY(0)=MAGGRY(0)_U_REV2 ;  Enable Revised Manager Tabs?
 S MAGGRY(0)=MAGGRY(0)_U_0 ; place-holder for Coerce Dict (abandoned P108)
 S MAGGRY(0)=MAGGRY(0)_U_NOTESENA
 S MAGGRY(0)=MAGGRY(0)_U_SENDAPP
 S MAGGRY(0)=MAGGRY(0)_U_ISIDICTENA
 S MAGGRY(0)=MAGGRY(0)_U_IMPLVARIANT
 ; ISI end
 ;
 ;=== Network UserName and PSW
 S MAGGRY(1)=$P($G(^MAG(2006.1,PLACE,"NET")),U,1,2)
 S X=+MAGJOB("USER",1),X=$S(X=15:3,X=12:2,+RADTECH:1,1:0)
 S MAGGRY(1)=MAGGRY(1)_U_X_U_$D(MAGJOB("KEYS","MAGJ SYSTEM USER"))
 S MAGGRY(1)=MAGGRY(1)_U_$S($L($T(PROD^XUPROD)):+$$PROD^XUPROD,1:0)
 S MAGGRY(2)="*KEYS",X="" F ICNT=3:1 S X=$O(MAGJOB("KEYS",X)) Q:X=""  S MAGGRY(ICNT)=X
 S MAGGRY(ICNT)="*END"
 S ICNT=ICNT+1,MAGGRY(ICNT)="*MAMMO"
 S MSG=$$MAMMOCHK(MAMMORES)
 I MSG]"" S ICNT=ICNT+1,MAGGRY(ICNT)=MSG
 S ICNT=ICNT+1,MAGGRY(ICNT)="*END"
USERIN2Z Q
 ;
MAMMOCHK(X) ; P133--now ignoring screen resolution, etc.
 ; note--as of ??/12 there are other sized displaysapproved for mammo
 ; now returns just a single disclaimer message, regardless of display
 ; keeping this structure for possible change in the future
 N MSG
 S MSG="Primary diagnostic interpretation of mammography images may only be performed on medical devices that are cleared for that intended use, and that use display hardware conforming to technical specifications set by the FDA."
 Q:$Q MSG Q
 ;
UPCASE(X) ; strip spaces, and cx to uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz ","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
ERR1 N ERR S ERR=$$EC^%ZOSV S @MAGGRY@(0)="0^4~"_ERR G ERR
ERR2 N ERR S ERR=$$EC^%ZOSV S MAGGRY(0)="0^4~"_ERR G ERR
ERR3 N ERR S ERR=$$EC^%ZOSV S MAGGRY="0^4~"_ERR
ERR D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
END Q  ; 
