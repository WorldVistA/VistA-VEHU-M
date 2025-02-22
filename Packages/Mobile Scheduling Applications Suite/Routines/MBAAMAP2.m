MBAAMAP2 ;OIT-PD/VSL - APPOINTMENT API ;FEB 23, 2017
 ;;1.0;Scheduling Calendar View;**1,4,5,7**;May 5, 2015;Build 16
 ;
 ;Associated ICRs
 ;  ICR#
 ;  5838 SDAMEVT
 ;  6048 SDAMEVT
 ;  6054 MBAA USE OF SDAM2 API get inpatient data
 ;  6049 MBAA SDMANA API USE
 ;  5838 SDAMEVT
 ;
CHKAPP(RETURN,SC,DFN,SD,LEN,LVL) ; Check make appointment Called by RPC MBAA APPOINTMENT MAKE
 N PAT,CLN,VAL,PATT,HOL,TXT,X1,X2,APT,CAPT,FRSTA,SDEDT,SDSOH,%
 K RETURN
 S RETURN=1
 S:'$G(LVL) LVL=7
 D GETPAT^MBAAMDA3(.PAT,DFN,1) ; get patient data
 D GETCLN^MBAAMDA1(.CLN,SC,1) ; get clinic data
 ;check patient, stop code and inactive
 S %=$$CHKAPTU(.RETURN,SC,DFN,SD,.CLN,.PAT) Q:RETURN=0 0
 ;check user permissions
 S VAL=$$CLNRGHT^MBAAMAP1(.RETURN,SC) Q:VAL=0 VAL
 S %=$$SETST^MBAAMAP4(.RETURN,SC,SD) Q:RETURN=0 0
 ;verify that day hasn't been canceled via "SET UP A CLINIC"
 D GETPATT^MBAAMDA1(.PATT,SC,SD) I $G(PATT(0))'["[" S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTCLUV") Q 0
 ;check if schedule on holiday is permited
 D GETHOL^MBAAMDA1(.HOL,$P(SD,"."))
 S SDSOH=$S('$D(CLN(1918.5)):0,CLN(1918.5)']"":0,1:1)
 I $D(HOL(0)),'SDSOH S TXT(1)=$P(HOL(0),U,2) S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTSHOL",.TXT) Q 0
 ;check if exceed max days for future appointment
 S X1=DT,SDEDT=$G(CLN(2002))
 S:SDEDT'>0 SDEDT=365
 S X2=SDEDT D C^%DTC S SDEDT=X
 I $P(SD,".")'<SDEDT S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTEXCD") Q 0
 ;
 ;check if patient has an active appointment on the same time
 ;
 ;WCJ;MBAA*1*7;Need to expand to check for overlaps beyond starting at the exact same time
 ;check if new appointment + LEN crosses an appointment on file (that isn't cancelled) and
 ;check if appointments on file (that isn't cancelled) + duration crosses the appointment we are trying to book
 ;
 ; first, get the appointments for the day
 D GETAPTS^MBAAMDA2(.APT,DFN,$P(SD,"."))
 ;
 ; Then check if new one plus its length crosses another appointment already scheduled.
 ; Add LENgth of new appointment to the starting time of new appoinment to get the appointment end time.
 ; can they have an 60 minute at 8 and another appt at 9 ???
 ; assuming they can for now and subtracting a second will allow that.
 N LOOPSD,APPTEND
 S APPTEND=$$FMADD^XLFDT(SD,0,0,LEN,-1)
 ;
 ; Loop thru appointments on file starting with the start time of the new appointment (minus a second)
 ; Quit when the start time of existing appointment > end time of new one since more overlaps not possible
 ; If there is an appointment in between which is not cancelled, we (royal one) have an issue
 S LOOPSD=$$FMADD^XLFDT(SD,0,0,0,-1)  ; subtract a second to catch ones with exact same start time
 F  S LOOPSD=$O(APT("APT",LOOPSD)) Q:LOOPSD>APPTEND!('+LOOPSD)  I APT("APT",LOOPSD,"STATUS")'["C" D  Q
 . ;MBAA*1*5 - use clinic of existing appointment
 . N SC1 S SC1=$P($G(APT("APT",LOOPSD,"CLINIC")),U) Q:'SC1
 . S %=$$GETSCAP^MBAAMAP1(.CAPT,SC1,DFN,LOOPSD) Q:'$D(CAPT)
 . S TXT(1)="("_CAPT("LENGTH")_" MINUTES)"
 . S RETURN=0
 . D ERRX^MBAAAPIE(.RETURN,"APTPAHA",.TXT,2)
 Q:RETURN=0 0
 ;
 ; Now check if an existing appointment plus its length crosses this new one.
 ; going back 1 day to start.  probably overkill - if max length of an appointment is a thing, we could go back that far.
 S LOOPSD=$$FMADD^XLFDT(SD,-1,0,0,0)
 F  S LOOPSD=$O(APT("APT",LOOPSD)) Q:LOOPSD>APPTEND!('+LOOPSD)  I APT("APT",LOOPSD,"STATUS")'["C" D  Q:RETURN=0
 . ;MBAA*1*5 - use clinic of existing appointment
 . N SC1 S SC1=$P($G(APT("APT",LOOPSD,"CLINIC")),U) Q:'SC1
 . S %=$$GETSCAP^MBAAMAP1(.CAPT,SC1,DFN,LOOPSD)
 . Q:'+$G(CAPT("LENGTH"))  ; can't check for overlaps without length so assume it's cool
 . Q:'($$FMADD^XLFDT(LOOPSD,0,0,+$G(CAPT("LENGTH")),-1)>SD)  ; check if existing start + length - 1 sec > new appt start
 . S TXT(1)="("_CAPT("LENGTH")_" MINUTES)"
 . S RETURN=0
 . D ERRX^MBAAAPIE(.RETURN,"APTPAHA",.TXT,2)
 Q:RETURN=0 0
 ;
 ; left the old check for now, just in case
 ; Check if patient has an appointment that starts exactly at the same time that hasn't been cancelled
 ;I $D(APT),APT("APT",SD,"STATUS")'["C"  D
 ;. ;MBAA*1*5 - use clinic of existing appointment
 ;. N SC1 S SC1=$P($G(APT("APT",SD,"CLINIC")),U) Q:'SC1
 ;. S %=$$GETSCAP^MBAAMAP1(.CAPT,SC1,DFN,SD) Q:'$D(CAPT)
 ;. S TXT(1)="("_CAPT("LENGTH")_" MINUTES)"
 ;. S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTPAHA",.TXT,2)
 ;Q:RETURN=0 0
 ; 
 ;check if patient has an active appointment on the same day
 I LVL>2 D
 . K APT N IDX S IDX=""
 . D GETDAPTS^MBAAMDA2(.APT,DFN,$P(SD,"."))
 . F  S IDX=$O(APT(IDX)) Q:IDX=""  I APT(IDX,2)'["C"  D  Q
 . . K TXT S TXT(1)="(AT "_$E(IDX_0,9,10)_":"_$E(IDX_"000",11,12)_")"
 . . S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTPHSD",.TXT,3)
 Q:RETURN=0 0
 ;
 ;check if patient has an canceled appointment on the same time
 I LVL'<2 D
 . K APT
 . D GETAPTS^MBAAMDA2(.APT,DFN,SD)
 . I $D(APT),APT("APT",SD,"STATUS")["P" D 
 . . S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTPPCP",,2)
 Q:RETURN=0 0
 ;
 ;check if date is prior to patient birth date
 I $P(SD,".",1)<$P(PAT(.03),U,1) S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTPPAB") Q RETURN
 ;
 ;check if date is prior to clinic availability
 S FRSTA=$$GETFSTA^MBAAMDA1(SC) I FRSTA,$P(SD,".",1)<FRSTA S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTPCLA") Q 0
 ;
 ;check overbook
 S %=$$CHKOVB(.RETURN,.CLN,SC,SD,LEN,LVL) Q:RETURN=0 RETURN
 S RETURN=1
 Q RETURN
 ;
CHKOVB(RETURN,CLN,SC,SD,LEN,LVL) ; Check overbook Called by RPC MBAA APPOINTMENT MAKE
 N TXT,ACC,SM,MAXOB,OBNO,PP,KEYS
 S RETURN=1 S:'$G(LVL) LVL=7
 S SM=$$DECAVA(.CLN,SC,SD,LEN,.PP)
 Q:'SM 0
 S KEYS("SDOB")="",KEYS("SDMOB")=""
 D GETXUS^MBAAMDA3(.ACC,.KEYS,DUZ)
 I '$D(ACC("SDOB")) S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTNOST") Q 0
 S MAXOB=CLN(1918)
 S OBNO=$$GETOBNO(SC,SD)
 S TXT(1)=MAXOB,TXT(2)=$S(OBNO>1:"S",1:"")
 I OBNO>MAXOB,'$D(ACC("SDMOB")) S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTOAPD",.TXT) Q 0
 I OBNO>MAXOB,LVL>1 S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTEXOB",,2) Q 0
 I SM=6,LVL>1 S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTOVBK",,2) Q 0
 I SM=7 S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTOVOS",,2) Q 0
 I SM=1 S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTCBCP") Q 0
 Q RETURN
 ;
GETOBNO(SC,SD) ; Called by RPC MBAA APPOINTMENT MAKE
 N IND,CNT,APTS
 S IND="",CNT=0
 D GETDAYA^MBAAMDA1(.APTS,SC,SD)
 F  S IND=$O(APTS(IND)) Q:IND=""  S:APTS(IND,"OB")>0 CNT=CNT+1
 Q CNT
 ;
CHKAPTU(RETURN,SC,DFN,SD,CLN,PAT,UNS) ; Check make unscheduled appointment MBAA RPC: MBAA APPOINTMENT MAKE
 N PAPT,CLN,TXT
 D:'$D(PAT) GETPAT^MBAAMDA3(.PAT,DFN,1) ; get patient data
 D:'$D(CLN) GETCLN^MBAAMDA1(.CLN,SC,1) ; get clinic data
 ;check if patient already has appointment
 S PAPT(.01)="" D GETPAPT^MBAAMDA2(.PAPT,DFN,SD)
 S TXT(1)=$$FTIME^VALM1(SD)  ;ICR#: 10116 VALM1
 I PAPT(.01)>0,$D(UNS) S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTPAHU",.TXT) Q RETURN
 ;check if patient is dead
 I +$G(PAT(.351))>0 S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"PATDIED") Q RETURN
 ;check if clinic is valid (stop code)
 S VAL=$$CLNCK^MBAAMAP1(.RETURN,SC) Q:VAL=0 VAL
 ;check inactive clinic period
 I CLN(2505),$P(SD,".")'<CLN(2505),$S('CLN(2506):1,CLN(2506)>$P(SD,".")!('CLN(2506)):1,1:0) D  Q 0
 . S TXT(1)=$$DTS^MBAAMAPI(CLN(2505))
 . S:CLN(2506) TXT(2)=" and reactivated on "_$$DTS^MBAAMAPI(CLN(2506))
 . S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTCINV",.TXT)
 Q 1
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;MAKEUS(RETURN,DFN,SC,SD,TYP,STYP) ; Make unscheduled appointment
 ; N SCAP,STAT,CHKIN,%
 ; S RETURN=0
 ; S %=$$CHKAPTU(.RETURN,SC,DFN,SD,,,1) Q:RETURN=0 0
 ; S STAT=$$INP^SDAM2(DFN,SD)
 ; D GETCLN^MBAAMDA1(.CLN,SC,1)
 ; D MAKE^MBAAMDA3(DFN,SD,SC,TYP,.STYP,STAT,4,DUZ,DT,"W",0)
 ; D MAKE^MBAAMDA1(SC,SD,DFN,CLN(1912),,DUZ)
 ; S %=$$LOCKST^MBAAMDA1(SC,SD) I '% S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTLOCK") Q 0
 ; S SM=$$DECAVA(.CLN,SC,SD,CLN(1912),.S)
 ; D SETST^MBAAMDA1(SC,SD,S)
 ; D UNLCKST^MBAAMDA1(SC,SD)
 ; S %=$$GETSCAP^MBAAMAP1(.SCAP,SC,DFN,SD)
 ; D MAKE^SDAMEVT(DFN,SD,SC,SCAP("IFN"))
 ; Q 1
 ; ;
MAKE(RETURN,DFN,SC,SD,TYPE,STYP,LEN,SRT,OTHR,CIO,LAB,XRAY,EKG,RQXRAY,CONS,LVL,DESDT) ; Make appointment Called by RPC MBAA APPOINTMENT MAKE
 N %
 ;IF WE NEED TO CHECK FOR DEPARTMENT OF DEFENSE PUT IN THE CODE TO DO THE TASKS BELOW
 ;I DUZ="" THEN SET DUZ FOR DEPARTMENT OF DEFENSE 
 ;S REC=$O(^VA(200,"B","DEPARTMENT OF DEFENSE,USER",""))
 ;I REC'>0 SEND ERROR MESSAGE THAT THE DEPARTMENT OF DEFENSE,USER DOESN'T EXIST ON THE SYSTEM
 ;I REC>0 S DUZ=REC D CLNRGHT^MBAAMRP1(.RETURN,SC) I RETURN(0)=1 S RETURN="0^RESTRICED CLINIC, USER NOT ALLOWED TO BOOK APPTS IN THIS CLINIC" Q
 ;CALL VERIFY CLINIC ACCESS
 ;Q:IF NOT ACCESS 
 S:'$G(LVL) LVL=7
 S RETURN=1
 F I="SC","DFN","SD","LEN" I '$D(@I) S RETURN=0,TXT(1)=I D ERRX^MBAAAPIE(.RETURN,"INVPARAM",.TXT)
 I RETURN=0 Q 0
 S %=$$CHKAPP(.RETURN,SC,DFN,SD,LEN,LVL)
 I RETURN=0,$P(RETURN(0),U,3)'>LVL Q RETURN(0)
 I RETURN=0,$P(RETURN(0),U)="PATDIED" Q RETURN(0)
 ;MBAA*1*5 - RETURN ERROR ON DUPLICATE DATE/TIME - REMOVE CANCEL AND REMAKE
 ;I RETURN=0,$P(RETURN(0),U)="APTPAHA" D
 ;. S %=$$CANCEL(.RETURN,DFN,SC,SD,"C",13,"")
 I RETURN=0,$P(RETURN(0),U)="APTPAHA" Q RETURN(0)
 E  Q:'$G(RETURN)&('$G(LVL)) 0
 N CLN,S,SM,SDY,SCAP,SRT0
 S %=$$LOCKST^MBAAMDA1(SC,SD) I '% S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTLOCK") Q 0
 S %=$$LOCKS^MBAAMDA1(SC,SD) I '% S RETURN=0 D ERRX^MBAAAPIE(.RETURN,"APTLOCK") Q 0
 D GETCLN^MBAAMDA1(.CLN,SC,1)
 S SM=$$DECAVA(.CLN,SC,SD,+LEN,.S)
 D SETST^MBAAMDA1(SC,SD,S)
 D MAKE^MBAAMDA1(SC,SD,DFN,+LEN,SM,DUZ,$G(OTHR),.RQXRAY)
 D UNLCKS^MBAAMDA1(SC,SD)
 D UNLCKST^MBAAMDA1(SC,SD)
 S STAT=$$INP^SDAM2(DFN,SD)  ;ICR#: 6054 MBAA USE OF SDAM2 API get inpatient data
 S:SD<DT SRT="W"
 S SRT0=$$NAVA^SDMANA(SC,SD,.SRT)  ;ICR#: 6049 MBAA SDMANA API USE
 D MAKE^MBAAMDA3(DFN,SD,SC,.TYPE,.STYP,STAT,3,DUZ,DT,SRT,SRT0,.LAB,.XRAY,.EKG,$G(DESDT))
 ;
 ;WCJ;MBAA*1*7;This has previously been commented out.  Took out the set of field 27 (it was set in line above)
 ;and sped up the call to get encounters to make below function useable
 N DATA ; S DATA(27)=DT,
 S DATA(28)=$$PTFU^MBAAMAP1(,DFN,SC)
 D UPDPAPT^MBAAMDA4(.DATA,DFN,SD)
 ;
 S %=$$GETSCAP^MBAAMAP1(.SCAP,SC,DFN,SD)
 I $G(CONS)>0 S DATA(688)=CONS
 D UPDCAPT^MBAAMDA4(.DATA,SC,SD,$G(SCAP("IFN")))
 S:$G(CONS)>0 %=$$EDITCS^MBAAAPI1(.RETURN,CONS,SD,.OTHR,$G(CLN("NAME"))) ;SD/478
 D MAKE^SDAMEVT(DFN,SD,SC,$G(SCAP("IFN")),2) ;ICR#: 6048 SDAMEVT
 ;alb/sat 4 - begin mod to update SDEC files
 N SDAPTYP,SDECAR,SDECR,SDRES,SDRQTYP,SDSTAT
 S CONS=$G(CONS)
 S:'CONS SDECAR=$$SDWLA^SDM1A(DFN,SD,SC,DESDT,TYPE)  ;build SDEC APPT REQUEST entry
 S SDAPTYP=$S(+CONS:"C|"_CONS,1:"A|"_SDECAR)
 S SDRES=$$GETRES^SDECUTL(SC)
 D PCSTGET^SDEC(.SDECR,DFN,SC) S SDSTAT=$P(@SDECR@(1),$C(30,31),1),SDECR=$S($P(SDSTAT,U,2)="YES":"E",1:"N")
 D SDECADD^SDEC07(SD,,DFN,SDRES,0,$G(DESDT),"",SDAPTYP,,SC,$G(OTHR),,SDRES,TYPE,SDECR) ;add SDEC APPOINTMENT entry
 ;alb/sat 4 - end mod
 I $D(CIO),CIO="CI" S %=$$CHECKIN^MBAAMAP2(.CHKIN,DFN,SD,SC,SD)
 K CHKIN,DATA,STAT
 Q 1
 ;
DECAVA(CLN,SC,SD,LEN,PATT) ; Decrease availability Called by RPC MBAA APPOINTMENT MAKE
 N AV,S,SB,X,Y,I,SS,ST,STR,STARTDAY,HSI,SI,SDDIF,SM,CAN,SDNOT
 S SM=0,CAN=0
 D GETPATT^MBAAMDA1(.AV,SC,SD)
 S S=$G(AV(0)),SB=CLN(1914)
 S STARTDAY=$S($L(SB):SB,1:8),SB=STARTDAY-1/100
 S X=CLN(1917),HSI=$S(X=1:X,X:X,1:4),SI=$S(X="":4,X<3:4,X:X,1:4)
 S STR="#@!$* XXWVUTSRQPONMLKJIHGFEDCBA0123456789jklmnopqrstuvwxyz",SDDIF=$S(HSI<3:8/HSI,1:2)
 S I=SD#1-SB*100,ST=I#1*SI\.6+($P(I,".")*SI),SS=LEN*HSI/60*SDDIF+ST+ST
 I SM<7 S %=$F(S,"[",SS-1) S:'%!(CLN(1917)<3) %=999 I $F(S,"]",SS)'<%!(SDDIF=2&$E(S,ST+ST+1,SS-1)["[") S SM=7
 I ST+ST>$L(S),$L(S)<80 S S=S_" "
 S SDNOT=1   ;SD*5.3*490 naked Do added below
 F I=ST+ST:SDDIF:SS-SDDIF S ST=$E(S,I+1) S:ST="" ST=" " S Y=$E(STR,$F(STR,ST)-2) S:S["CAN"!(ST="X"&($D(AV(1)))) CAN=1 Q:CAN  S:Y'?1NL&(SM<6) SM=6 S ST=$E(S,I+2,999) D  S:ST="" ST=" " S S=$E(S,1,I)_Y_ST
 .Q:ST'=""
 .Q:+LEN'>CLN(1912)
 .S ST="   "
 .Q
 S PATT=S
 Q:CAN CAN
 Q SM
 ;
CANCEL(RETURN,DFN,SC,SD,TYP,RSN,RMK) ; Cancel appointment Called by RPC MBAA APPOINTMENT MAKE
 N CDATE,CDT,ERR,ODT,OIFN,OUSR,%
 S RETURN=0
 S %=$$CHKCAN^MBAAMAP3(.RETURN,DFN,SC,SD) Q:RETURN=0 0
 S CDATE=$$NOW^XLFDT  ;ICR#: 10103 XLFDT
 S %=$$GETSCAP^MBAAMAP1(.CAPT,SC,DFN,SD)
 S CIFN=CAPT("IFN")
 S OUSR=CAPT("USER"),ODT=CAPT("DATE")
 N SDATA,SDCPHDL
 S SDCPHDL=$$HANDLE^SDAMEVT(1) ;ICR#: 5838 SDAMEVT
 D BEFORE^SDAMEVT(.SDATA,DFN,SD,SC,CIFN,SDCPHDL) ;ICR#: 5835 SDAMEVT
 S CDT=$$NOW^XLFDT()  ;ICR#: 10103 XLFDT
 D CANCEL^MBAAMDA3(.ERR,DFN,SD,TYP,RSN,RMK,$E(CDT,1,12),DUZ,OUSR,ODT)
 S OIFN=$$COVERB^MBAAMDA1(SC,SD,CIFN)
 S %=$$CANCEL^MBAAAPI1(RETURN,CAPT("CONSULT"),SC,SD,CIFN,RMK,TYP)
 D CANCEL^MBAAMDA1(SC,SD,DFN,CIFN)
 D CANCEL^SDAMEVT(.SDATA,DFN,SD,SC,CIFN,0,SDCPHDL) ;ICR#: 6048 MBAA SDAMEVT API CALLS
 S RETURN=1 K CIFN
 Q RETURN
 ;
CHECKIN(RETURN,DFN,SD,SC,CIDT) ; Check in appointment Called by RPC MBAA APPOINTMENT MAKE
 N CAPT,CI,%
 S CI=DT
 S:$D(CIDT) CI=CIDT
 S %=$$GETSCAP^MBAAMAP1(.CAPT,SC,DFN,SD)
 I $G(CAPT(0))="" D ERRX^MBAAAPIE(.RETURN,"APTWHEN") Q 0
 S CIFN=$G(CAPT("IFN"))
 I 'CIFN D ERRX^MBAAAPIE(.RETURN,"APTWHEN") Q 0
 N SDATA,SDCIHDL,X
 S SDATA=CIFN_U_DFN_U_SD_U_SC,SDCIHDL=$$HANDLE^SDAMEVT(1) ;ICR#: 5835 SDAMEVT
 D BEFORE^SDAMEVT(.SDATA,DFN,SD,SC,CIFN,SDCIHDL) ;ICR#: 5838 SDAMEVT
 S %=$$CHKCIN^MBAAMAP3(.RETURN,DFN,SD,+SDATA("BEFORE","STATUS")) Q:'% 0
 S CD(302)=DUZ,CD(309)=CI
 D UPDCAPT^MBAAMDA4(.CD,SC,SD,CAPT("IFN"))
 D AFTER^SDAMEVT(.SDATA,DFN,SD,SC,CIFN,SDCIHDL) ;ICR#: 5838 SDAMEVT
 M RETURN=SDATA
 I SDATA("BEFORE","STATUS")'=SDATA("AFTER","STATUS") D
 . D EVT^SDAMEVT(.SDATA,4,0,SDCIHDL) ; 4 := ci evt , 0 := interactive mode  ;ICR#: 5838 SDAMEVT
 K CD,CIFN
 Q 1
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;Linetag NOSHOW is not needed until the next enhancement of MBAA
 ;NOSHOW(RETURN,DFN,SC,SD,LVL) ; No-show appointment
 ;N APT0,STATUS,APTSTAT,AUTO,CNSTLNK,NSDA,NSDIE,%
 ;S:'$D(LVL) LVL=7
 ;S APT0=$$GETAPT0^MBAAMDA2(DFN,SD)
 ;S APTSTAT=$P(APT0,U,2)
 ;S STATUS=$$STATUS^SDAM1(DFN,SD,+$G(APT0),$G(APT0))
 ;S RETURN=0
 ;S %=$$CHKNS^MBAAMAP3(.RETURN,APT0,+STATUS,LVL)
 ;I RETURN=0,$P(RETURN(0),U,3)'>LVL Q RETURN
 ;N FDA,CIFN,CAPT
 ;S %=$$GETSCAP^MBAAMAP1(.CAPT,SC,DFN,SD)
 ;S CIFN=CAPT("IFN")
 ;S CNSTLNK=$G(CAPT("CONSULT"))
 ;S RETURN("BEFORE")=STATUS
 ;N SDNSHDL S SDNSHDL=$$HANDLE^SDAMEVT(1)
 ;D BEFORE^SDAMEVT(.SDATA,DFN,SD,SC,CIFN,SDNSHDL)
 ;I APTSTAT=""!(APTSTAT="NT") D
 ;. S FDA(3)="N",FDA(14)=DUZ,FDA(15)=$$NOW^XLFDT()
 ;E  D
 ;. S FDA(3)="@",FDA(14)="@",FDA(15)="@"
 ;D UPDPAPT^MBAAMDA4(.FDA,DFN,SD)
 ;D NOSHOW^SDAMEVT(.SDATA,DFN,SD,SC,CIFN,2,SDNSHDL)
 ;S:+$G(CNSTLNK) %=$$NOSHOW^MBAAAPI1(.RETURN,SC,SD,DFN,CNSTLNK,CIFN)
 ;S APT0=$$GETAPT0^MBAAMDA2(DFN,SD)
 ;S APTSTAT=$P(APT0,U,2)
 ;S STATUS=$$STATUS^SDAM1(DFN,SD,+$G(APT0),$G(APT0))
 ;S RETURN("AFTER")=STATUS
 ;Q 1
