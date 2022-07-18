IBCOMD1 ;ALB/CMS - GENERATE INSURANCE COMPANY LISTINGS ;03-AUG-98
 ;;2.0;INTEGRATED BILLING;**103,528,602,664**;21-MAR-94;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
BEG ; Queued entry point.
 ;  Input variables:
 ;
 ;  IBCASE(n) = x ^ y ^ z  (Optional), where
 ;     n = 1-4  (1:Name, 2:Street, 3:City, 4:State)
 ;     x = C (Contains), or R (RANGE)
 ;     y = Pointer to the STATE (#5) file, if n=4
 ;         The 'Contains' value, if x = C
 ;         The 'Start From' value, if x = R
 ;     z = The 'Go To' value, if x = R
 ;
 ;  IBFLD(n) = x  (Required), where
 ;     n = 1-4  (1:Name, 2:Street, 3:City, 4:State)
 ;     x = NAME (n=1), STREET (n=2), CITY (n=3), STATE (n=4)
 ;
 ;  IBAIB - Required.   Include Active Insurance
 ;          1= Active Ins.   2= Inactive Ins. 3= Both
 ;  IBOUT - Required.   Output format
 ;          "R"= report format         "E"= Excel format
 ;
 N IBDA,IBDA0,IBDA11,IBDA13,IBI,IBPAGE,IBTMP,IBX,X,Y,IBJ,IBNOT
 ;
 I "^R^E^"'[(U_$G(IBOUT)_U) S IBOUT="R"
 K ^TMP("IBCOMD",$J) S IBPAGE=0
 ;
 ; - must look at all entries in file #36
 S IBDA=0 F  S IBDA=$O(^DIC(36,IBDA)) Q:'IBDA  S IBDA0=$G(^(IBDA,0)) D
 .;
 .; - screen out active/inactive companies
 .I IBAIB=1,$P(IBDA0,U,5) Q
 .I IBAIB=2,'$P(IBDA0,U,5) Q
 .;
 .S IBDA11=$G(^DIC(36,IBDA,.11)),IBDA13=$G(^(.13))
 .;
 .; - screen out entries based on user-selected field screens
 .S (IBJ,IBNOT)=0 F  S IBJ=$O(IBCASE(IBJ)) Q:'IBJ  D  Q:IBNOT
 ..N IBD,VAL S IBD=IBCASE(IBJ)
 ..;
 ..; - check state first
 ..I IBJ=4 S:$P(IBDA11,"^",5)'=$P(IBD,"^",2) IBNOT=1 Q
 ..;
 ..; - find the field value to be evaluated
 ..S VAL=$S(IBJ=1:$P(IBDA0,"^"),1:$P(IBDA11,"^",$S(IBJ=2:1,1:4)))
 ..;
 ..; - check 'contains' values
 ..I $P(IBD,"^")="C" S:VAL'[$P(IBD,"^",2) IBNOT=1 Q
 ..;
 ..; - check 'range' values
 ..I VAL="" S IBNOT=1 Q  ; VAL must have a value in a range
 ..I $P(IBD,"^",2)]VAL S IBNOT=1 Q  ; VAL doesn't follow Start value
 ..I VAL]$P(IBD,"^",3) S IBNOT=1 ;    VAL follows the Go To value
 .;
 .Q:IBNOT  ; entry does not meet criteria
 .;
 .;
 .; - set entry in global
 .S IBTMP=$P(IBDA0,U,1)_U
 .S IBX=$P(IBDA0,U,2) S $P(IBTMP,U,2)=$S(IBX]"":$E($$EXPAND^IBTRE(36,1,IBX),1,20),1:"")_U
 .F IBX=1:1:6 S IBTMP=IBTMP_$P(IBDA11,U,IBX)_U
 .;S IBX=$P(IBTMP,U,7) S $P(IBTMP,U,7)=$S(IBX]"":$$STATE^IBCF2(IBX),1:"")_U
 .;/vd-IB*2.0*664 - Replaced the above line with the following 2 lines.
 .S IBX=$P(IBTMP,U,7) S $P(IBTMP,U,7)=$S(IBX]"":$$STATE^IBCF2(IBX),1:"")
 .S IBX=$P(IBTMP,U,8) S $P(IBTMP,U,8)=$S($L(IBX)=9:$E(IBX,1,5)_"-"_$E(IBX,6,9),1:IBX)
 .;
 .S $P(IBTMP,U,9)=$P(IBDA13,U,1)
 .S ^TMP("IBCOMD",$J,+$P(IBDA0,U,5),$S($P(IBDA0,U,1)]"":$P(IBDA0,U,1),1:"ZZZZ"),+IBDA)=IBTMP
 ;
 I '$D(^TMP("IBCOMD",$J)) D HD W !!,"** NO RECORDS FOUND **" D ASK G QUEQ
 D HD:IBOUT="E",WRT
 ;
 ; Exit clean-UP
QUEQ K IBAIB,IBCASE,IBFLD,IBOUT,IBQUIT,^TMP("IBCOMD",$J)
 I $D(ZTQUEUED) S ZTREQ="@" Q
 W ! D ^%ZISC
 Q
 ;
 ;
HD ; Write Heading
 S IBPAGE=IBPAGE+1
 ; IB*602/HN ; Add report headers to Excel Spreadsheets
 I IBOUT="E" D  Q
 .W !,"Generate Insurance Company Listings^"_$$FMTE^XLFDT($$NOW^XLFDT,1)
 .W !,"List of ",$S(IBAIB=1:"Active",IBAIB=2:"Inactive",1:"All")," Insurance Companies"
 .;
 .; - display definition of screens
 .I $D(IBCASE) W "^where" D
 ..N I,H
 ..S (H,I)=0 F  S I=$O(IBCASE(I)) Q:'I  D
 ...; IB*664/DW ; update display of filter to remove delimiters between each word
 ...;I H W "^and"
 ...;S H=1 W "^"_IBFLD(I)
 ...;W $S(I=4:"^Equals ",$P(IBCASE(I),"^")="C":"^Contains ",1:"^Between ")
 ...;W $S(I=4:$P($G(^DIC(5,+$P(IBCASE(I),"^",2),0)),"^"),$P(IBCASE(I),"^",2)="":"^'FIRST'",1:$P(IBCASE(I),"^",2))
 ...;I $P(IBCASE(I),"^")="R" W "^and ",$S($P(IBCASE(I),"^",3)="zzzzzz":"^'LAST'",1:$P(IBCASE(I),"^",3)) ; **IB*2.0*602
 ...I H W " and"
 ...S H=1 W " "_IBFLD(I)
 ...W $S(I=4:" Equals ",$P(IBCASE(I),"^")="C":" Contains ",1:" Between ")
 ...W $S(I=4:$P($G(^DIC(5,+$P(IBCASE(I),"^",2),0)),"^"),$P(IBCASE(I),"^",2)="":"'FIRST'",1:$P(IBCASE(I),"^",2))
 ...I $P(IBCASE(I),"^")="R" W " and ",$S($P(IBCASE(I),"^",3)="zzzzzz":"'LAST'",1:$P(IBCASE(I),"^",3))
 ...; IB*664/DW end changes
 .;
 .W !,"Active/Inactive^Insurance Name^Reimburse?^Street Address 1^Street Address 2^Street Address 3^City^State^ZIP^Phone Number"
 ; IB*602/HN end 
 ;
 I IBOUT="E" W:($E(IOST,1,2)["C-") ! W "Active/Inactive^Insurance Name^Reimburse?^Street Address 1^Street Address 2^Street Address 3^City^State^ZIP^Phone Number" Q
 W @IOF,"Generate Insurance Company Listings",?50,$$FMTE^XLFDT($$NOW^XLFDT,"Z"),?70," Page ",IBPAGE
 W !,"List of ",$S(IBAIB=1:"Active",IBAIB=2:"Inactive",1:"All")," Insurance Companies"
 ;
 ; - display definition of screens
 I $D(IBCASE) W ", where" D
 .N I,H
 .S (H,I)=0 F  S I=$O(IBCASE(I)) Q:'I  D
 ..W ! I H W ?3,"and"
 ..S H=1 W ?8,IBFLD(I)," "
 ..W $S(I=4:"Equals ",$P(IBCASE(I),"^")="C":"Contains ",1:"Between ")
 ..W $S(I=4:$P($G(^DIC(5,+$P(IBCASE(I),"^",2),0)),"^"),$P(IBCASE(I),"^",2)="":"'FIRST'",1:$P(IBCASE(I),"^",2))
 ..I $P(IBCASE(I),"^")="R" W " and ",$S($P(IBCASE(I),"^",3)="zzzzzz":"'LAST'",1:$P(IBCASE(I),"^",3))
 ;
 W !,"Insurance Name/Address",?33,"Reimburse?",?56,"Phone Number"
 W ! F IBX=1:1:79 W "="
 Q
 ;
WRT ; Write data lines
 N IBA,IBNA,IBOFF,IBACT,X,Y S IBQUIT=0
 S IBA="" F  S IBA=$O(^TMP("IBCOMD",$J,IBA)) Q:(IBA="")!(IBQUIT=1)  D
 .I IBPAGE,(IBOUT="R") D ASK I IBQUIT=1 Q
 .; Excel Output
 .I IBOUT="E" S IBACT=$S(IBA=1:"Inactive",1:"Active")
 .; Report Output
 .I IBOUT="R" D HD W !,$S(IBA=1:"Inactive Companies",1:"Active Companies"),!
 .S IBNA="" F  S IBNA=$O(^TMP("IBCOMD",$J,IBA,IBNA)) Q:(IBNA="")!(IBQUIT=1)  D
 ..S IBDA="" F  S IBDA=$O(^TMP("IBCOMD",$J,IBA,IBNA,IBDA)) Q:('IBDA)!(IBQUIT=1)  D
 ...S IBTMP=^TMP("IBCOMD",$J,IBA,IBNA,IBDA)
 ...S IBOFF=$S($P(IBTMP,U,4)]""!($P(IBTMP,U,5)]""):7,1:6)
 ...I ($Y+IBOFF)>IOSL,(IBOUT="R") D  I IBQUIT=1 Q
 ....D ASK I IBQUIT=1 Q
 ....D HD
 ...S IBTMP=^TMP("IBCOMD",$J,IBA,IBNA,IBDA)
 ...; Excel Output
 ...I IBOUT="E" W !,IBACT_U_IBTMP Q
 ...; Report Output
 ...W !!,$P(IBTMP,U,1),?33,$P(IBTMP,U,2),?56,$P(IBTMP,U,9)
 ...I $P(IBTMP,U,3)]"" W !,$P(IBTMP,U,3)
 ...I $P(IBTMP,U,4)]""!($P(IBTMP,U,5)]"") W !,$P(IBTMP,U,4) W:$P(IBTMP,U,4)]""&($P(IBTMP,U,5)]"") ", " W $P(IBTMP,U,5)
 ...W !,$P(IBTMP,U,6) W:$P(IBTMP,U,6)]""&($P(IBTMP,U,7)]"") ", " W $P(IBTMP,U,7),"  ",$P(IBTMP,U,8)
 I 'IBQUIT D ASK
 Q
 ;
ASK ; Ask to Continue with display
 ; Returns IBQUIT=1 if user Timed out or entered ^
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IBI,X,Y
 S DIR(0)="E" D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S IBQUIT=1
 Q
