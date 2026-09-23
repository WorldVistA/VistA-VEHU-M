DVBAUDUU2 ;ALB/CP - Audited Option User Utilization Print ; 3/28/18 9:17am
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;         $$UP^XLFSTR  ; IA #10104
 Q
 ;
PRINT ; Print the report from the sorted ^TMP global
 ;
 N @($$PRTVARS^DVBAUDPRT1())
 N DVBC1,DVBC2,DVBC3,DVBC4,DVBC5,DVBC6,DVBC7,DVBCNT,DVBGTOT
 N DVBLC1,DVBLC2,DVBLC3,DVBLC4,DVBLC5,DVBLC6,DVBLC7,DVBLIMIT,DVBPREVSORT
 N DVBSORT1,DVBSORT2,DVBSORT3,DVBSORT4,DVBSORT5,DVBSORT6,DVBSORTBY,DVBSTOT
 ; ZEXCEPT: DVBLEGEND,DVBOPTION,DVBQUIT,DVBSORT,U
 ;
 D PRINTINI
 ;
 ; IF  There is not any data found in the ^TMP global
 ;     Force a page break, print the report headers
 ;     and display 'No Data Found'
 ;
 D PAGEBRK^DVBAUDPRT1($T(+0),.DVBPG,0) Q:DVBQUIT
 I '$D(^TMP("AMIE",$J,DVBOPTION)) D  G EXIT
 . D NODATA^DVBAUDPRT1(2)
 ;
 S (DVBPREVSORT,DVBSORT1)=""
 F  S DVBSORT1=$O(^TMP("AMIE",$J,DVBOPTION,DVBSORT1)) Q:DVBSORT1=""!DVBQUIT  D  ;
 . ; ZEXCEPT: DVBFLAG1
 . ;
 . ; Provide a control when sorting by Option (1-4) or Parent Service (7-10)
 . I "^1^2^3^4^7^8^9^10^"[("^"_DVBSORT_"^") D  Q:DVBQUIT  S DVBFLAG1=0
 . . Q:DVBFLAG1  ; Skip the control break on the first record
 . . D STOT
 . . D PAGEBRK^DVBAUDPRT1($T(+0),.DVBPG,1) Q:DVBQUIT
 . . W !
 . S DVBSORT2=""
 . F  S DVBSORT2=$O(^TMP("AMIE",$J,DVBOPTION,DVBSORT1,DVBSORT2)) Q:DVBSORT2=""!DVBQUIT  D  ;
 .. ;
 .. ; Count the number of unique OPTIONS reported
 .. I "^1^2^3^4^"[("^"_DVBSORT_"^") S DVBCNT("OPTS")=DVBCNT("OPTS")+1
 .. I "^7^8^9^10^"[("^"_DVBSORT_"^") S DVBCNT("PSVC")=DVBCNT("PSVC")+1
 .. ;
 .. S DVBSORT3=""
 .. F  S DVBSORT3=$O(^TMP("AMIE",$J,DVBOPTION,DVBSORT1,DVBSORT2,DVBSORT3)) Q:DVBSORT3=""!DVBQUIT  D
 ... S DVBSORT4=""
 ... F  S DVBSORT4=$O(^TMP("AMIE",$J,DVBOPTION,DVBSORT1,DVBSORT2,DVBSORT3,DVBSORT4)) Q:DVBSORT4=""!DVBQUIT  D
 .... S DVBSORT5=""
 .... F  S DVBSORT5=$O(^TMP("AMIE",$J,DVBOPTION,DVBSORT1,DVBSORT2,DVBSORT3,DVBSORT4,DVBSORT5)) Q:DVBSORT5=""!DVBQUIT  D
 ..... S DVBSORT6=""
 ..... F  S DVBSORT6=$O(^TMP("AMIE",$J,DVBOPTION,DVBSORT1,DVBSORT2,DVBSORT3,DVBSORT4,DVBSORT5,DVBSORT6)) Q:DVBSORT6=""!DVBQUIT  D
 ...... N DVBRPTDATA
 ...... ; ZEXCEPT: DVBSTOT
 ...... ;
 ...... S DVBRPTDATA=^TMP("AMIE",$J,DVBOPTION,DVBSORT1,DVBSORT2,DVBSORT3,DVBSORT4,DVBSORT5,DVBSORT6)
 ...... D PAGEBRK^DVBAUDPRT1($T(+0),.DVBPG,1) Q:DVBQUIT
 ...... W !
 ...... ; Suppress repetitive printing of the OPTION name
 ...... W ?DVBC1,$E($P(DVBRPTDATA,U,1),1,DVBLC1) ; OPTION
 ...... W ?DVBC2,$J($P(DVBRPTDATA,U,2),DVBLC2) ;.. USER# pointer to file #200
 ...... W ?DVBC3,$E($P(DVBRPTDATA,U,3),1,DVBLC3) ; USER
 ...... W ?DVBC4,$E($P(DVBRPTDATA,U,4),1,DVBLC4) ; SERVICE
 ...... W ?DVBC5,$E($P(DVBRPTDATA,U,5),1,DVBLC5) ; FIRST TIME OPTION USED
 ...... W ?DVBC6,$E($P(DVBRPTDATA,U,6),1,DVBLC6) ; LAST TIME OPTION USED
 ...... W ?DVBC7,$J($P(DVBRPTDATA,U,7),DVBLC7) ;.. USAGE COUNT
 ...... S DVBCNT("PRINTED")=DVBCNT("PRINTED")+1 ; Count number of Options
 ...... S DVBSTOT("USERS")=DVBSTOT("USERS")+1 ; Number of users
 ...... S DVBSTOT("USAGE")=DVBSTOT("USAGE")+$P(DVBRPTDATA,U,7) ; Usage count
 Q:DVBQUIT
 ;
 D STOT Q:DVBQUIT
 D GTOT
 ;
 I DVBCNT("PRINTED") D  ;
 . I 'DVBQUIT D PAGEBRK^DVBAUDPRT1($T(+0),.DVBPG,1) Q:DVBQUIT
 . W !
 . I 'DVBQUIT D PAGEBRK^DVBAUDPRT1($T(+0),.DVBPG,1) Q:DVBQUIT
 . W !
 . W ?DVBC1,"Number of audit records listed..: ",DVBCNT("PRINTED")
 ;
 I "^1^2^3^4^"[("^"_DVBSORT_"^") D  ;
 . I 'DVBQUIT D PAGEBRK^DVBAUDPRT1($T(+0),.DVBPG,1) Q:DVBQUIT
 . W !
 . W ?DVBC1,"Number of unique options listed.: ",$J(DVBCNT("OPTS"),$L(DVBCNT("PRINTED")))
 ;
 I "^7^8^9^10^"[("^"_DVBSORT_"^") D  ;
 . I 'DVBQUIT D PAGEBRK^DVBAUDPRT1($T(+0),.DVBPG,1) Q:DVBQUIT
 . W !
 . W ?DVBC1,"Number of parent services listed: ",$J(DVBCNT("PSVC"),$L(DVBCNT("PRINTED")))
 ;
 I DVBLEGEND=1 D  ; Print inactive user legend
 . I 'DVBQUIT D PAGEBRK^DVBAUDPRT1($T(+0),.DVBPG,1) Q:DVBQUIT
 . W !
 . W ?DVBC1,"Legend: Inactive users are prefixed with an asterisk (*)."
 ;
EXIT ; Exit PRINT^DVBAUDUU2
 ;
 Q  ; Quit PRINT^DVBAUDU2
 ;
GTOT ; Print grand totals at the end of the report
 ;
 ; ZEXCEPT: DVBGTOT,DVBLC3,DVBLC7,DVBLINED
 ;
 Q:'DVBGTOT("USERS")  ; No totals to print
 ;
 D PAGEBRK^DVBAUDPRT1($T(+0),.DVBPG,1) Q:DVBQUIT
 W !
 W ?DVBC3,$E(DVBLINED,1,DVBLC3)
 W ?DVBC7,$E(DVBLINED,1,DVBLC7)
 ;
 D PAGEBRK^DVBAUDPRT1($T(+0),.DVBPG,1) Q:DVBQUIT
 W !
 W ?DVBC3,$J(DVBGTOT("USERS"),DVBLC3)
 W ?DVBC7,$J(DVBGTOT("USAGE"),DVBLC7)
 ;
GTOTINIT ; Initialize grand totals
 ;
 S DVBGTOT("USERS")=0 ; Number of records
 S DVBGTOT("USAGE")=0 ; Total Usage counts
 ;
 Q  ; Quit DVBGTOT & GTOTINIT
 ;
PRINTHD ; Print report header
 ;
 N DVBCOL
 ; ZEXCEPT: DVBCOORD,IOF,IOM,L,DVBLASTREF
 ; ZEXCEPT" DVBC1,DVBC2,DVBC3,DVBC4,DVBC5,DVBC6,DVBC7,DVBLC1,DVBLC10,DVBLC11,DVBLC2,DVBLC3,DVBLC4,DVBLC5,DVBLC6,DVBLC7
 ; ZEXCEPT: IOF,IOM,IOST,DVBLIMIT,DVBMGNAME,DVBASKDT,DVBDT,DVBDTBEG,DVBDTEND
 ; ZEXCEPT: DVBFLAG1,DVBFTBEG,DVBFTEND,DVBLINED,DVBLINEE,DVBOPT,DVBOPTION
 ; ZEXCEPT: DVBPG,DVBPKG,DVBRPT,DVBREFCNT,DVBSORTBY,DVBTYPE,DVBUSERNAME
 ;
 W:$E(IOST,1,2)="C-" @IOF
 S DVBCOL=(IOM-7)-$L(DVBPG) ;.... Calculate page number column position
 D CENTER^DVBAUDPRT1(DVBOPTION) ; Report title
 ;
 I DVBRPT=1 D  ;
 . I DVBOPT("CNT")=1 D  ; Show the selected option on the header
 . . D CENTER^DVBAUDPRT1("Selected Option: "_$O(DVBOPT("B","")))
 . I DVBOPT("CNT")>3 D  ; DVBTEXT would be too long, make it generic
 . . D CENTER^DVBAUDPRT1("SPECIFIC OPTIONS WERE SELECTED")
 . I DVBOPT("CNT")>1 D  ;
 . . N DVBJ,DVB2OPT,DVBTEXT
 . . S (DVB2OPT,DVBTEXT)=""
 . . F DVBJ=1:1:DVBOPT("CNT") S DVB2OPT=$O(DVBOPT("B",DVB2OPT)) D  ;
 . . . S DVBTEXT=DVBTEXT_$S(DVBJ>1:", ",1:"")_DVB2OPT
 . . D CENTER^DVBAUDPRT1("Options: "_DVBTEXT)
 ;
 I DVBRPT=2 D  ; Report selection is by free DVBTEXT range
 . D CENTER^DVBAUDPRT1("Options: "_DVBFTBEG_" to "_DVBFTEND) ;Display range
 I DVBRPT=3 D  ; Report selection is by package namespace
 . D CENTER^DVBAUDPRT1("Package namespace: "_DVBPKG)
 ;
 I DVBASKDT="NO" D  ; If report is NOT limited by date range
 . D CENTER^DVBAUDPRT1("NO SPECIFIC LAST AUDIT DATE RANGE DVBLIMIT WAS SPECIFIED")
 I DVBASKDT="YES" D  ; If report is limited by date range
 . D CENTER^DVBAUDPRT1("For options LAST USED used from: "_DVB2DTBEG("E")_" to "_DVB2DTEND("E"))
 ;
 D CENTER^DVBAUDPRT1(DVBLIMIT) ;... Include selected user limitation
 W !?DVBC1,DVBDT ;............... Reporting date
 D CENTER^DVBAUDPRT1("Sorted by: "_DVBSORTBY,0) ; Include sorting method
 W ?DVBCOL,"PAGE: ",DVBPG ;...... Display page number
 W !,DVBLINEE ;............... Draw a line before displaying column hdr
 ;
PRINTHD1 ; Print column headers
 ;
 W ! ;....................... Column header line 1
 W ?DVBC5,"FIRST"
 W ?DVBC6,"LAST"
 W ?DVBC7,"USAGE"
 ;
 W ! ;....................... Column header line 2
 W ?DVBC1,"OPTION NAME"
 W ?DVBC2,"DUZ"
 W ?DVBC3,"USER NAME"
 W ?DVBC4,"PARENT SERVICE"
 W ?DVBC5,"USED"
 W ?DVBC6,"USED"
 W ?DVBC7,"COUNT"
 ;
 W ! ;....................... Draw a line under each column header
 W ?DVBC1,$E(DVBLINED,1,DVBLC1)
 W ?DVBC2,$E(DVBLINED,1,DVBLC2)
 W ?DVBC3,$E(DVBLINED,1,DVBLC3)
 W ?DVBC4,$E(DVBLINED,1,DVBLC4)
 W ?DVBC5,$E(DVBLINED,1,DVBLC5)
 W ?DVBC6,$E(DVBLINED,1,DVBLC6)
 W ?DVBC7,$E(DVBLINED,1,DVBLC7)
 ;
 Q  ; Quit PRINTHD & PRINTHD1
 ;
PRINTINI ; Initialize variables, set column positions and length of columns
 ;
 ; ZEXCEPT: DVBC1,DVBC10,DVBC11,DVBC2,DVBC3,DVBC4,DVBC5,DVBC6,DVBC7,DVBCNT
 ; ZEXCEPT: DVBLC1,DVBLC10,DVBLC11,DVBLC2,DVBLC3,DVBLC4,DVBLC5,DVBLC6,DVBLC7
 ; ZEXCEPT: DVBLIMIT,DVBRPT,DVBSORT,DVBULIMIT,DVBSORTBY
 ;
 ; Initialize commonly used printed report variables
 D INITPRT^DVBAUDPRT1
 ;
 ; Init DVBCOL pos's & length
 S DVBC1=1,DVBC2=33,DVBC3=42,DVBC4=73,DVBC5=104,DVBC6=114,DVBC7=124
 S DVBLC1=30,DVBLC2=7,DVBLC3=29,DVBLC4=29,DVBLC5=8,DVBLC6=8,DVBLC7=7
 ;
 S DVBSORTBY=$$UP^XLFSTR(DVBSORT)
 I DVBSORTBY="" S DVBSORTBY=$$UP^XLFSTR(DVBSORT(DVBSORT)) ; Sorted by DVBTEXT in uppercase
 S DVBLIMIT=$$DVBLIMIT(DVBULIMIT) ; DVBLIMIT report to which users?
 S DVBCNT("PRINTED")=0 ; Number of printed records
 S DVBCNT("OPTS")=0 ;... Number of unique printed options (for sort 1-4)
 S DVBCNT("PSVC")=0 ;... Number of unique parent services (for sort 7-10)
 ;
 ; Initialize  sub-totals & grand totals for various control breaks
 D STOTINIT,GTOTINIT
 ;
 Q  ; Quit PRINTINI
 ;
DVBLIMIT(DVBLIMIT) ; Return: Which users were included
 ;
 I DVBLIMIT=1 Q "BOTH ACTIVE AND INACTIVE USERS"
 I DVBLIMIT=2 Q "ONLY ACTIVE USERS"
 I DVBLIMIT=3 Q "ONLY INACTIVE USERS"
 ;
 Q "" ; Quit extrinsic function $$DVBLIMIT
 ;
STOT ; Print subtotals on each control break & accumulate grand totals
 ;
 ; ZEXCEPT: DVBGTOT,DVBLC3,DVBLC7,DVBLINED,DVBSTOT
 ;
 Q:'DVBSTOT("USERS")  ; No totals to print
 ;
 D PAGEBRK^DVBAUDPRT1($T(+0),.DVBPG,1) Q:DVBQUIT
 W !
 W ?DVBC3,$E(DVBLINED,1,DVBLC3)
 W ?DVBC7,$E(DVBLINED,1,DVBLC7)
 ;
 D PAGEBRK^DVBAUDPRT1($T(+0),.DVBPG,1) Q:DVBQUIT
 W !
 W ?DVBC3,$J(DVBSTOT("USERS"),DVBLC3)
 W ?DVBC7,$J(DVBSTOT("USAGE"),DVBLC7)
 ;
 ; Accumlate grand totals
 S DVBGTOT("USERS")=DVBGTOT("USERS")+DVBSTOT("USERS")
 S DVBGTOT("USAGE")=DVBGTOT("USAGE")+DVBSTOT("USAGE")
 I DVBGTOT("USERS")=DVBSTOT("USERS"),DVBGTOT("USAGE")=DVBSTOT("USAGE") D  ;
 . ; Zero out grand totals so they do not print duplicate numbers
 . S (DVBGTOT("USERS"),DVBGTOT("USAGE"))=0
 ;
STOTINIT ; Initialize subtotals
 ;
 S DVBSTOT("USERS")=0 ; Number of records
 S DVBSTOT("USAGE")=0 ; Total Usage counts
 ;
 Q  ; Quit DVBSTOT & STOTINIT
