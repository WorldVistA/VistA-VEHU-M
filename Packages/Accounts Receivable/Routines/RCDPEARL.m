RCDPEARL ;ALB/HRUBOVCAK - Misc. Report utilities for ListMan, etc. ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298,321,332,432**;15 April 2014;Build 16
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IA 594 - ACCOUNTS RECEIVABLE CATEGORY file (#430.2)
 ; IA 1992 - BILL/CLAIMS file (#399)
 ; IA 3822 - RATE TYPE file (#399.3)
 ; IA 4051 - EXPLANATION OF BENEFITS file (#361.1)
 ;
 Q
 ;
ASK(STOP) ; Ask to continue
 ; STOP passed by ref., returned as 1 if timeout or user enters '^'
 Q:'($E(IOST,1,2)="C-")  ; must have user
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A")="Press enter to continue, '^' to exit: "
 S DIR(0)="EA" D ^DIR
 I ($D(DTOUT))!($D(DUOUT))!(Y="^") S STOP=1
 Q
 ;
ASKLM(DEFAULT) ; Extrinsic function, ask for ListMan display using ^DIR
 ; Input:   DEFAULT - 1 - Default 'YES', 0 - Default 'NO'
 ;                    Optional defaults to 0
 ; Returns: 0 - No, 1 - YES, -1 on timeout or '^'
 N DIR,RSLT,X,Y
 S:'$D(DEFAULT) DEFAULT=0 ; PRCA*4.5*332
 S RSLT=0
 S DIR(0)="YA",DIR("A")="Display in List Manager format? (Y/N): "
 S DIR("B")=$S(DEFAULT:"YES",1:"NO") ; PRCA*4.5*332
 D ^DIR S RSLT=$S($D(DUOUT)!$D(DTOUT):-1,1:Y)
 Q RSLT
 ;
CLMCHMPV(RCLMIEN) ; boolean function, returns true if CHAMPVA claim, else false
 ; RCLMIEN - file entry, format: 'file #;ien' (see PTR4302 comments)
 Q $$EVALCLM(RCLMIEN,"CHAMPVA")
 ;
CLMTRICR(RCLMIEN) ; boolean function, returns true if TRICARE claim, else false
 ; RCLMIEN - file entry, format: 'file #;ien' (see PTR4302 comments)
 Q $$EVALCLM(RCLMIEN,"TRICARE")
 ;
ENDORPRT() ; extrinsic variable, formatted for 80 column display
 N A S A="***** END OF REPORT *****" Q $J(" ",80-$L(A)\2)_A
 ;
EVALCLM(RCLMIEN,TRGTXT) ; boolean function, case insensitive
 ; returns 1 if claim has target text, else false (error messages evaluate as false)
 ; RCLMIEN (required) - file entry, format: 'file #;ien' (see PTR4302 comments)
 ; TRGTXT (required) - target text
 Q:($G(RCLMIEN)="")!($G(TRGTXT)="") "^invalid"  ; both required
 N RSLT,F,R,T
 S T=$$UP(TRGTXT),RSLT=0  ; text to uppercase, default to false
 S F=$G(RCLMIEN) Q:'($P(F,";")>1)!'($P(F,";",2)>0) RSLT  ; file must be > 1 and entry > zero
 S R=$$PTR4302(RCLMIEN) Q:'R RSLT  ; no text to check
 ;
 S F=$$UP($P(R,";",2,99))  ; text of entry from ACCOUNTS RECEIVABLE CATEGORY (#430.2)
 S RSLT=F[T  ; boolean result
 Q RSLT
 ;
INCHMPVA() ; function, include CHAMPVA question
 ; returns zero = No, 1 = yes, -1 on timeout or '^'
 N DIR,DTOUT,DUOUT,RSLT,X,Y S RSLT=0
 S DIR(0)="YA",DIR("A")="Include CHAMPVA? (Y/N): ",DIR("B")="YES"
 S DIR("?")="Enter 'NO' to exclude entries related to CHAMPVA from the report."
 D ^DIR S RSLT=$S($D(DUOUT)!$D(DTOUT):-1,1:Y)
 Q RSLT
 ;
INTRICAR() ; function, include TRICARE question
 ; returns zero = No, 1 = yes, -1 on timeout or '^'
 N DIR,DTOUT,DUOUT,RSLT,X,Y S RSLT=0
 S DIR(0)="YA",DIR("A")="Include TRICARE? (Y/N): ",DIR("B")="YES"
 S DIR("?")="Enter 'NO' to exclude entries related to TRICARE from the report."
 D ^DIR S RSLT=$S($D(DUOUT)!$D(DTOUT):-1,1:Y)
 Q RSLT
 ; Begin PRCA*4.5*321
 ;
EXCHMPVA() ; function, exclude CHAMPVA question - EP RCDPEM4
 ; returns zero = No, 1 = yes, -1 on timeout or '^'
 N DIR,DTOUT,DUOUT,RSLT,X,Y S RSLT=0
 S DIR(0)="YA",DIR("A")="Exclude CHAMPVA? (Y/N): ",DIR("B")="NO"
 S DIR("?")="Enter 'Y' to exclude entries related to CHAMPVA from the report."
 D ^DIR S RSLT=$S($D(DUOUT)!$D(DTOUT):-1,1:Y)
 Q RSLT
 ;
EXTRICAR() ; function, exclude TRICARE question - EP RCDPEM4
 ; returns zero = No, 1 = yes, -1 on timeout or '^'
 N DIR,DTOUT,DUOUT,RSLT,X,Y S RSLT=0
 S DIR(0)="YA",DIR("A")="Exclude TRICARE? (Y/N): ",DIR("B")="NO"
 S DIR("?")="Enter 'Y' to exclude entries related to TRICARE from the report."
 D ^DIR S RSLT=$S($D(DUOUT)!$D(DTOUT):-1,1:Y)
 Q RSLT
 ; End PRCA*4.5*321
 ;
HDRLST(RCSTOP,RCHDR) ; write the header in RCHDR
 ; RCSTOP, RCHDR passed by ref.
 Q:RCSTOP  ; nothing to do
 ;
 I $E(IOST,1,2)="C-",'RCDISPTY,RCPGNUM D ASK(.RCSTOP)
 Q:RCSTOP  ; no header needed
 I 'RCDISPTY W @IOF
 X RCHDR("XECUTE")  ; increment page count, insert into header
 N J F J=1:1:RCHDR(0) W !,RCHDR(J)
 Q
 ;
LMEN(LMTMP) ; Invoke ListMan for RCDPE MISC REPORTS list template
 ; Input:   LMTMP       - Name of a different listman template to use
 ;                        Optional, defaults to ""
 N XX
 S XX=$S($G(LMTMP)'="":LMTMP,1:"RCDPE MISC REPORTS") ; PRCA*4.5*332
 D EN^VALM(XX)                                       ; PRCA*4.5*332
 Q
 ;
LMHDR ; ListMan header
 N J S J=0
 F J=1:1 Q:'$D(RCLMHDR(J))  S VALMHDR(J)=RCLMHDR(J)
 S:$G(RCLMHDR("TITLE"))'="" VALM("TITLE")=RCLMHDR("TITLE")
 Q
 ;
LMINIT ; set up ListMan array, invoked from inside List Template
 ;
 N C,J,Y S (J,C)=0
 F  S J=$O(@RCLMND@(J)) Q:'J  S Y=$G(@RCLMND@(J)),C=C+1 D SET^VALM10(C,Y)
 S VALMCNT=C
 Q
 ;
LMHLP ; ListMan help
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
LMEXIT ; performed on exiting ListMan screen
 K @RCLMND  ; delete ListMan data
 D FULL^VALM1  ; reset terminal display
 Q
 ;
LMEXPND ; expand code for ListMan
 Q
 ;
LMRPT(RCLMHDR,RCLMND,LMTMP) ; Generate ListMan display
 ; Input:   RCLMHDR     - Header text, passed by ref. (required)
 ;          RCLMND      - Storage node for ListMan data (required)
 ;          LMTMP       - Name of a listman template to use
 ;                        Optional, defaults to ""
 Q:'$D(RCLMHDR)  Q:($G(RCLMND)="")          ; both required
 S:'$D(LMTMP) LMTMP="" ; PRCA*4.5*332
 D LMEN(LMTMP)         ; PRCA*4.5*332
 Q
 ;
NOW() Q $$FMTE^XLFDT($$NOW^XLFDT,2)  ; extrinsic variable, now as MM/DD/YY@HH:MM:SS
 ;
PAD(TXT,LNGTH) ; function, pad TXT with spaces to LNGTH
 Q $$LJ^XLFSTR(TXT,LNGTH)
 ;
PTR4302(FLNTRY) ; function, returns entry from 430.2 or error message
 ; FLNTRY - file entry (required), format: 'file #;ien'
 ; on success returns 'ien^name' else '^error message'
 ; file number and ien can be from:
 ;  ^PRCA(430.2,0) = ACCOUNTS RECEIVABLE CATEGORY^430.2I
 ;  ^DGCR(399.3,0) = RATE TYPE^399.3I^
 ;  ^DGCR(399,0) = BILL/CLAIMS^399I
 ;  ^IBM(361.1,0) = EXPLANATION OF BENEFITS^361.1PI^
 ;  ^RCY(344.4,0) = ELECTRONIC REMITTANCE ADVICE^344.4I
 ;  ^RCY(344,0) = AR BATCH PAYMENT^344I
 ;
 N F,PF,RCFLNUM,RCIEN,RSLT,X,Y
 ; PF - parent file
 ; RCFLNUM - file number
 ; RCIEN - internal entry number
 ; RSLT - result
 ;
 S RSLT=U,F=$G(FLNTRY),RCFLNUM=+$P(F,";"),RCIEN=+$P(F,";",2)
 Q:'(RCFLNUM>1) U_"invalid file #"
 Q:'(RCIEN>0) U_"invalid IEN"
 ;
 ; default result
 S RSLT="^file "_RCFLNUM_" no entry #"_RCIEN
 ;
 ; ACCOUNTS RECEIVABLE CATEGORY file #430.2
 I RCFLNUM=430.2 D  Q RSLT
 .S X=$G(^PRCA(430.2,RCIEN,0)),Y=$P(X,U) S:Y]"" RSLT=RCIEN_";"_Y
 ;
 ; RATE TYPE file #399.3, (#.06) ACCOUNTS RECEIVABLE CATEGORY [6P:430.2]
 I RCFLNUM=399.3 D  Q RSLT
 .S X=$G(^DGCR(399.3,RCIEN,0)),Y=+$P(X,U,6) Q:'(Y>0)
 .S RSLT=$$PTR4302("430.2;"_Y)
 ;
 ; BILL/CLAIMS file #399, (#.07) RATE TYPE [7P:399.3]
 I RCFLNUM=399 D  Q RSLT
 .S X=$G(^DGCR(399,RCIEN,0)) Q:X=""
 .S PF=399.3,RSLT="^no pointer to "_PF,Y=+$P(X,U,7) Q:'(Y>0)
 .S RSLT=$$PTR4302(PF_";"_Y)
 ;
 ; EXPLANATION OF BENEFITS file #361.1, (#.01) BILL [1P:399]
 I RCFLNUM=361.1 D  Q RSLT
 .S X=$G(^IBM(361.1,RCIEN,0)) Q:X=""
 .S PF=399,RSLT="^no pointer to "_PF,Y=+$P(X,U) Q:'(Y>0)
 .S RSLT=$$PTR4302(PF_";"_Y)
 ;
 ; ELECTRONIC REMITTANCE ADVICE file #344.4
 ;  ERA DETAIL sub-file #344.41, (#.02) EOB DETAIL [2P:361.1]
 I RCFLNUM=344.4 D  Q RSLT
 .S X=$G(^RCY(344.4,RCIEN,0)) Q:X=""  ; top level entry not found
 .S RSLT="^sub-file 344.41 no entries"
 .; take first entry that gives result from file #430.2
 .N J,C S (J,C)=0 F  S J=$O(^RCY(344.4,RCIEN,1,J)) Q:'J!RSLT  S X=$G(^(J,0)) D
 ..S PF=361.1,RSLT="^no pointer to "_PF
 ..S Y=+$P(X,U,2) Q:'(Y>0)  S C=C+1
 ..S RSLT="^sub-file 344.41 total checked "_C,F=$$PTR4302(PF_";"_Y) S:F RSLT=F
 ;
 ; AR BATCH PAYMENT file #344, (#.18) ERA REFERENCE [18P:344.4]
 I RCFLNUM=344 D  Q RSLT
 .S X=$G(^RCY(344,RCIEN,0)) Q:X=""
 .S PF=344.4,Y=+$P(X,U,18),RSLT="^no pointer to "_PF Q:'(Y>0)
 .S RSLT=$$PTR4302(PF_";"_Y)
 ;
 ; finished all checks, valid file number not found
 S RSLT=U_"invalid file #"_RCFLNUM
 ;
 Q RSLT
 ;
SL(T,RCLNCNT,RC2GLBL) ; Set text into global or write line
 ; T = text to output
 ; RCLNCNT = line counter, passed by ref. (optional)
 ; RC2GLBL = if non-null indicates output to global, no writes
 I $G(RC2GLBL)="" W !,T Q
 S RCLNCNT=RCLNCNT+1,^TMP($J,RC2GLBL,RCLNCNT)=T
 Q
 ;
UP(A) ; Returns UPPERCASE
 Q $$UP^XLFSTR(A)
 ;
DEBEFT(RC0) ; Add minus sign for debit amounts PRCA*4.5*432
 ; Input:   RC0    - Initially set to node 0 (zero) of #344.31 entry, EDI THIRD PARTY EFT DETAIL FILE
 ; Output:  RC0    - Add minus sign for negative dollar amounts
 ;                   Piece 7 of RC0, #.07, AMOUNT OF PAYMENT
 ;                   Piece 16 of RC0, #3, DEBIT/CREDIT FLAG
 ;
 I $E($P(RC0,U,7))="-" Q   ;If dollar amount is already preceeded by a minus sign, quit before adding a second minus sign
 I $P(RC0,U,16)="D" S $P(RC0,U,7)="-"_$P(RC0,U,7)  ;Check for debit flag, add minus sign if present
 Q
 ;
