IBCOMDT1 ;ALB/CKB - INSURANCE COMPANY MISSING DATA REPORT (COMPILE/PRINT) ; 12-APR-2023
 ;;2.0;INTEGRATED BILLING;**763**;21-MAR-94;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Selected Insurance Company(s):
 ;  ^TMP(IBCOMDT("$J"),"PR",<insurance co name>,<insurance IEN>)=""
 ;
 ;
 ;Print data:
 ;  ^TMP(IBCOMDT("$J"),"PR",<insurance co name>,<insurance IEN>)=DATA
 ;
 ;   DATA=INSURANCE COMPANY ^ ADDRESS ON FILE ^ STREET LINE 1 ^ STREET LINE 2  ^ STREET LINE 3 ^ 
 ;        CITY ^ STATE ^ ZIP+4 ^ TYPE OF COVERAGE ^ FILING TIME FRAME"
 ;
 ; ***Note: the pieces in DATA are set to 'YES' if they are missing data
 ;
 Q
COMPILE(IBCNRTN,IBCOMDT) ; Entry Point called from EN^XUTMDEVQ (indirectly from IBCOMDT).
 ;      IBCNRTN = Routine name for ^TMP(IBCNRTN,IBCOMDT("$J"),...
 ;      IBCOMDT = Array of params
 ; Compile and Print Report
 N ADDRESS,CITY,DATA,FOUND,I,IBCT,IBPGN,INS,INSNM,SL1,SL2,SL3,ST,FTF,TYPCOV,ZIP,ZIP4
 K ^TMP(IBCOMDT("$J"),"PR")
 ;
 S IBCT=0
 S INSNM=0 F  S INSNM=$O(^TMP(IBCNRTN,IBCOMDT("$J"),INSNM)) Q:INSNM=""  D
 . S INS=0 F  S INS=$O(^TMP(IBCNRTN,IBCOMDT("$J"),INSNM,INS)) Q:INS=""  D
 . . ; Write '.' to the screen to keep session alive (logic from BLD^IBCNBLL)
 . . S IBCT=IBCT+1 I '$D(ZTQUEUED),'(IBCT#50) W "."
 . . ; Get Insurance Company field details
 . . S DATA=""
 . . S SL1=$$GET1^DIQ(36,INS_",",.111,"E")
 . . S SL2=$$GET1^DIQ(36,INS_",",.112,"E")
 . . S SL3=$$GET1^DIQ(36,INS_",",.113,"E")
 . . S CITY=$$GET1^DIQ(36,INS_",",.114,"E")
 . . ; Use State 2 digit abbreviation
 . . S ST=$$GET1^DIQ(5,$$GET1^DIQ(36,INS_",",.115,"I")_",",1)
 . . S ZIP=$$GET1^DIQ(36,INS_",",.116,"E"),ZIP4=""
 . . I $L(ZIP)>5 S ZIP4=$P(ZIP,"-",2)
 . . S ADDRESS=""
 . . I SL1'="" S ADDRESS=ADDRESS_SL1
 . . I SL2'="" S ADDRESS=ADDRESS_", "_SL2
 . . I SL3'="" S ADDRESS=ADDRESS_", "_SL3
 . . I CITY'="" S ADDRESS=ADDRESS_", "_CITY
 . . I ST'="" S ADDRESS=ADDRESS_", "_ST
 . . I ZIP'="" S ADDRESS=ADDRESS_", "_ZIP
 . . S TYPCOV=$$GET1^DIQ(36,INS_",",.13,"E")
 . . S FTF=$$FTFIC^IBCNEUT7(INS)
 . . ;
 . . ; Set DATA for Report output (filtered)
 . . I IBCOMDT("IBOUT")="R" S FOUND=0,DATA="" D 
 . . . S $P(DATA,U,1)=ADDRESS
 . . . ; If there is missing data add it to DATA
 . . . I IBCOMDT("IBSL1") I SL1="" S $P(DATA,U,2)="YES"
 . . . I IBCOMDT("IBSL2") I SL2="" S $P(DATA,U,3)="YES"
 . . . I IBCOMDT("IBSL3") I SL3="" S $P(DATA,U,4)="YES"
 . . . I IBCOMDT("IBCTY") I CITY="" S $P(DATA,U,5)="YES"
 . . . I IBCOMDT("IBST") I ST="" S $P(DATA,U,6)="YES"
 . . . I IBCOMDT("IBZIP") I (ZIP4="")!(ZIP4="0000")!(ZIP4="9999") S $P(DATA,U,7)="YES"
 . . . I IBCOMDT("IBCOV") I TYPCOV="" S $P(DATA,U,8)="YES"
 . . . I IBCOMDT("IBFTF") I FTF["UNK" S $P(DATA,U,9)="YES"
 . . . F I=2:1:$L(DATA,U) I $P(DATA,U,I)'="" S FOUND=1
 . . ;
 . . ; Set DATA for Excel output (doesn't filter, includes all 8 fields)
 . . I IBCOMDT("IBOUT")="E" S FOUND=1,DATA="" D
 . . . S $P(DATA,U,1)=ADDRESS
 . . . S $P(DATA,U,2)=$S(SL1="":"YES",1:"NO")
 . . . S $P(DATA,U,3)=$S(SL2="":"YES",1:"NO")
 . . . S $P(DATA,U,4)=$S(SL3="":"YES",1:"NO")
 . . . S $P(DATA,U,5)=$S(CITY="":"YES",1:"NO")
 . . . S $P(DATA,U,6)=$S(ST="":"YES",1:"NO")
 . . . S $P(DATA,U,7)="NO"
 . . . I (ZIP4="")!(ZIP4="0000")!(ZIP4="9999") S $P(DATA,U,7)="YES"
 . . . S $P(DATA,U,8)=$S(TYPCOV="":"YES",1:"NO")
 . . . S $P(DATA,U,9)=$S(FTF["UNK":"YES",1:"NO")
 . . ;
 . . ; Add to ^TMP global for printing if missing data was found or Excel output
 . . I FOUND S ^TMP(IBCOMDT("$J"),"PR",INSNM,INS)=DATA
 . . K DATA
 K ^TMP(IBCNRTN,IBCOMDT("$J"))
 ;
 ; Print Excel or Report output
 D PRINT
 Q
 ;
PRINT ; Print Report
 N CRT,CT,DASHES,DATA,EORMSG,IBHDT,IBPGC,IBQUIT,INS,LCT,NODATA,NONEMSG,MAXCNT,STOP,%
 S EORMSG="*** End of Report ***"
 S NONEMSG="*** NO DATA FOUND ***"
 S HDRNAME="INSURANCE COMPANY MISSING DATA"
 D NOW^%DTC
 S IBHDT=$$DAT2^IBOUTL($E(%,1,12))
 S (IBPGC,IBQUIT,LCT,STOP,ZSTOP)=0
 S $P(DASHES,"-",81)=""
 S MAXCNT=IOSL-2,CRT=1
 I 'IOST["C-" S MAXCNT=IOSL-6,CRT=0
 I IBCOMDT("IBOUT")="E" D EHDR
 I IBCOMDT("IBOUT")="R" D HEADER(HDRNAME,IBHDT)
 I '$D(^TMP(IBCOMDT("$J"),"PR")) W !,NONEMSG,! G PRINTQ     ; NO DATA FOUND
 ;
 ; Loop through ^TMP(IBCOMDT("$J"),"PR") and display report output
 S INS=0 F  S INS=$O(^TMP(IBCOMDT("$J"),"PR",INS)) Q:INS=""!(IBQUIT!$G(ZTSTOP))  D
 . S CT=0 F  S CT=$O(^TMP(IBCOMDT("$J"),"PR",INS,CT)) Q:CT=""!(IBQUIT!$G(ZTSTOP))  D
 . . ; Excel output
 . . I IBCOMDT("IBOUT")="E" D
 . . . S DATA=^TMP(IBCOMDT("$J"),"PR",INS,CT)
 . . . W INS,U,$S($P(DATA,U,1)="":"<no address on file>",1:$P(DATA,U,1)),U
 . . . W $P(DATA,U,2,9),!
 . . ; Report output
 . . I IBCOMDT("IBOUT")="R" D REPORT
 ;
PRINTQ ;
 ; Only display 'End of Report' and PAUSE if User didn't enter a '^' (IBQUIT=1)
 I '(IBQUIT!$G(ZTSTOP)) D
 . W !,EORMSG,!
 . D PAUSE
 I $D(ZTQUEUED) S ZTREQ="@" Q
 ; Close Device
 D ^%ZISC
 Q
 ;
REPORT ; Report output
 N ADDOF,RPT1,RPT2,RPT3,RPT4
 ; Use Line counter (LCT) to keep all Insurance Company data on the same page
 S (RPT1,RPT2,RPT3,RPT4)=""
 S DATA=^TMP(IBCOMDT("$J"),"PR",INS,CT)
 S ADDOF=$P(DATA,U,1)
 ;
 ; Build line 1
 I $P(DATA,U,2)="YES" S RPT1=RPT1_$S(RPT1'="":", ",1:"")_"STREET LINE 1"
 I $P(DATA,U,3)="YES" S RPT1=RPT1_$S(RPT1'="":", ",1:"")_"STREET LINE 2"
 I $P(DATA,U,4)="YES" S RPT1=RPT1_$S(RPT1'="":", ",1:"")_"STREET LINE 3"
 I RPT1'="" S LCT=LCT+1
 ; Build line 2
 I $P(DATA,U,5)="YES" S RPT2=RPT2_$S(RPT2'="":", ",1:"")_"CITY"
 I $P(DATA,U,6)="YES" S RPT2=RPT2_$S(RPT2'="":", ",1:"")_"STATE"
 I $P(DATA,U,7)="YES" S RPT2=RPT2_$S(RPT2'="":", ",1:"")_"ZIP+4"
 I RPT2'="" S LCT=LCT+1
 ; Determine lines 3 and 4
 I $P(DATA,U,8)'="" S RPT3=1,LCT=LCT+1
 I $P(DATA,U,9)'="" S RPT4=1,LCT=LCT+1
 ;
 ;I ($Y+LCT)>MAXCNT D  S LCT=0 Q:(IBQUIT!$G(ZTSTOP))  D HEADER(HDRNAME,IBHDT)
 I ($Y+LCT)>MAXCNT D  S LCT=0 D HEADER(HDRNAME,IBHDT)
 . ;Write blank lines to fill page prior to displaying "Type <Enter> to continue or '^' to exit:"
 . I $E(IOST,1,2)["C-",MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 I IBQUIT!$G(ZSTOP) Q
 ;
 ; Display results
 W !,INS,!
 W $S(ADDOF="":"<no address on file>",1:ADDOF),!
 I RPT1'="" W ?8,RPT1,!
 I RPT2'="" W ?8,RPT2,!
 I RPT3 W ?8,"TYPE OF COVERAGE",!
 I RPT4 W ?8,"FILING TIME FRAME",!
 Q
 ;
 ;
HEADER(HDRNAME,HDRDATE) ; Report header
 N DIR,DTOUT,DUOUT,LIN,OFFSET,X,Y
 I IBPGC>0,$E(IOST,1,2)["C-" D  Q:(IBQUIT!$G(ZTSTOP))
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . D PAUSE
 I $E(IOST,1,2)'["C-",$$S^%ZTLOAD() S ZTSTOP=1 Q
 S IBPGC=IBPGC+1 I IBPGC>1!($E(IOST,1,2)["C-") W @IOF
 ; Excel and Report Header
 I IBCOMDT("IBOUT")="E",IBPGC=1 D EHDR
 I IBCOMDT("IBOUT")="R" D
 . W HDRNAME
 . S HDRDATE=HDRDATE_"   Page: "_+IBPGC,OFFSET=(80-($L(HDRDATE)+1))
 . W ?OFFSET,HDRDATE,!
 . W "Missing Data: ",IBCOMDT("SUBHD"),!,DASHES,!
 Q
 ;
EHDR ; Excel Header
 N EHDR
 S EHDR="INSURANCE COMPANY"_U_"ADDRESS ON FILE"_U_"STREET LINE 1"_U_"STREET LINE 2 "_U_"STREET LINE 3"
 S EHDR=EHDR_U_"CITY"_U_"STATE"_U_"ZIP+4"_U_"TYPE OF COVERAGE"_U_"FILING TIME FRAME"
 W !,HDRNAME,"^",IBHDT,!,"Missing Data: SEARCH ALL",!,"**YES indicates Missing Data**"
 W !!,EHDR,!
 Q
 ; 
PAUSE ; Pause for screen output.
 N DIR,DIRUT,DTOUT,DUOUT
 Q:$E(IOST,1,2)'["C-"
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIR,DIRUT,DTOUT,DUOUT
 Q
