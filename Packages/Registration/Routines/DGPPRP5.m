DGPPRP5 ;LIB/MKN - PRESUMPTIVE PSYCHOSIS FISCAL YEAR REPORT ;08/15/2019
 ;;5.3;Registration;**977**August 02, 2019;;Build 177
 ;
 ;IA's
 ; 10003 Sup ^%DT
 ; 10004 Sup ^DIQ:   $$GET1, GETS
 ; 10026 Sup ^DIR
 ; 10063 Sup ^%ZTLOAD
 ; 10086 Sup ^%ZIS:  HOME
 ; 10089 Sup ^%ZISC
 ; 10103 Sup ^XLFDT: $$FMTE, $$FMADD
 ;
 Q
 ;DGDTDEF
EN ;entry point from Menu Option: PRESUMPTIVE PSYCHOSIS FISCAL YEAR REPORT
 N DFN,DGCAT,DGDEFDT,DGDIV,DGDT,DGDTDEF,DGDTF,DGDTT,DGDTYRS,DGFISCFR,DGFISCTO,DGFISCYR,DGFM,DGHDRDT,DGI,DGINC,DGMTH
 N DGPER,DGQRT,DGSEX,DGSELQ,DGSELMN,DGTEMP,DGTF,DGX,DGY,EXIT,PAGE,POP,X,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS,%DT
SELFY ;Select Fiscal Year(s)
 S DGDTYRS=$$GETFISC("Select Fiscal Years")
 Q:+DGDTYRS=0
 ;S X="10/01/"_($P(DGDT,U,2)-1),%DT="" D ^%DT Q:Y=-1  S (DGDTF,DGSTD)=Y
 ;S X="09/30/"_$P(DGDT,U,3),%DT="" D ^%DT Q:Y=-1  S (DGDTT,DGEND)=Y
 S DGFISCFR=$P(DGDTYRS,U,2),DGFISCTO=$P(DGDTYRS,U,3),PAGE=0
 ;
SELFYQ ;Select Quarters, or complete Fiscal Year
 K DIR S DIR(0)="S^1:FY Quarter 1 (Oct-Nov-Dec);2:FY Quarter 2 (Jan-Feb-Mar);3:FY Quarter 3 (Apr-May-Jun);4:FY Quarter 4 (Jul-Aug-Sep);5:Fiscal Year  (All Quarters)"
 S DIR("A")="Select reporting period",DIR("B")=5 D ^DIR
 Q:$D(DIRUT)
 S DGSELQ=Y,EXIT=0 I DGSELQ=5 S DGSELM=4 D SETPER(.DGPER,DGDTYRS,5,"")
 I DGSELQ<5 D  Q:EXIT
 . S DGX="1:October;2:November;3:December/1:January;2:February;3:March/1:April;2:May;3:June/1:July;2:August;3:September",DGX=$P(DGX,"/",DGSELQ)
 . K DIR S DIR(0)="S^"_DGX_";4:All Months in the Quarter"
 . S DIR("A")="Select the month of the Quarter or All",DIR("B")=4
 . D ^DIR S:$D(DIRUT) EXIT=1
 . S DGSELM=Y,DGX=$P($P(DGX,";",DGSELM),":",2),DGSELMN=$$GETMTH(DGX)
 . D SETPER(.DGPER,DGDTYRS,DGSELQ,Y)
 S DGTEMP=$NA(^TMP("DGPPRP5",$J)) K @DGTEMP
 ;Initialize zero counts for MALE and FEMALE
 S DGYR="" F  S DGYR=$O(DGPER(DGYR)) Q:DGYR=""  D
 . S DGDT1="" F  S DGDT1=$O(DGPER(DGYR,DGDT1)) Q:DGDT1=""  D
 .. S DGDT2="" F  S DGDT2=$O(DGPER(DGYR,DGDT1,DGDT2)) Q:DGDT2=""  D
 ... S DGQRT=DGPER(DGYR,DGDT1,DGDT2)
 ... F DGMTH=+$E(DGDT1,4,5):1:+$E(DGDT2,4,5) F DGFM="F","M" S @DGTEMP@(DGYR,DGQRT,DGMTH,DGFM)=0
 ; Allow queueing
 K IOP,IO("Q") S %ZIS="MQ",%ZIS("B")="",POP=0 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D  Q   ;Queued report settings
 .S ZTDESC="Presumptive Psychosis Fiscal Year Report",ZTRTN="DQ^DGPPRP5"
 .S ZTSAVE("DGRTYP")="",ZTSAVE("DGDTFRMT")="",ZTSAVE("DGDTFRM")="",ZTSAVE("ZTREQ")="@",ZTSAVE("DGDTTO")=""
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! K DIR S DIR(0)="E" D ^DIR K DIR
DQ ;
 N DGQSEL,DGYR,DGDT1,DGDT2,EN3312
 S DGYR="" F  S DGYR=$O(DGPER(DGYR)) Q:DGYR=""  D
 . S DGDT1="" F  S DGDT1=$O(DGPER(DGYR,DGDT1)) Q:DGDT1=""  D
 .. S DGDT2="" F  S DGDT2=$O(DGPER(DGYR,DGDT1,DGDT2)) Q:DGDT2=""  D DQ1
 D PRINT,OUT
 Q
 ;
DQ1 ;
 N DGDT,IEN331
 S DGDT=$$FMADD^XLFDT(DGDT1,-1)_".2399"
 F  S DGDT=$O(^DGPP(33.1,"AC",DGDT)) Q:'DGDT!(DGDT>DGDT2)  D
 . S DGMTH=+$$FMTE^XLFDT(DGDT,"5PZ"),DGQRT=$$GETQUART(DGMTH)
 . S DGCAT="" F  S DGCAT=$O(^DGPP(33.1,"AC",DGDT,DGCAT)) Q:DGCAT=""  D
 .. S IEN331=0 F  S IEN331=$O(^DGPP(33.1,"AC",DGDT,DGCAT,IEN331)) Q:'IEN331  D
 ... S DFN=$$GET1^DIQ(33.1,IEN331_",",.01,"I") Q:'DFN
 ... S DGSEX=$$GET1^DIQ(2,DFN_",",.02,"I") Q:DGSEX=""
 ... S @DGTEMP@(0)=$G(@DGTEMP@(0))+1 ;,@DGTEMP@(DGYR)=DGDT1_U_DGDT2
 ... S @DGTEMP@(DGYR,DGQRT,DGMTH,DGSEX)=$G(@DGTEMP@(DGYR,DGQRT,DGMTH,DGSEX))+1
 Q
 ;
FMYR(YR) ;
 Q ($E(YR,1,2)-18+1)_$E(YR,3,4)
 ;
GETQM(YR,QRT,MTH) ;
 N QRT1,Y
 I MTH="" Q $S(QRT=1:"1001^1231",QRT=2:"0101^0331",QRT=3:"0401^0630",1:"0701^0930")
 S QRT1=$S(QRT=1:"1001^1031/1101^1130/1201^1231/",QRT=2:"0101^0131/0201^0228/0301^0331",QRT=3:"0401^0430/0501^0531/0601^0630",1:"0701^0731/0801^0831/0901^0930")
 I MTH<4 S QRT1=$P(QRT1,"/",MTH) D  Q QRT1
 . I QRT1?1"0201".E I (YR/4)=(YR\4) S $P(QRT1,U,2)="0229"
 ;MTH is 4 = All months
 S QRT1=$P(QRT1,U)_U_$P(QRT1,U,$L(QRT1,U))
 Q QRT1
 ;
SETPER(DGPER,DGYRS,DGQRT,DGMTH) ;
 ;DGYRS="1^YYYY^YYYY"  Ex: "1^2018^2019"
 ;DGQRT=5 All quarters  (DGMTH will be "")
 ;DGQRT<5 A specific quarter
 ;DGMTH=1-3 A calendar month Ex: Quarter 4 Month 1=July
 ;DGMTH=4   All months in the quarter
 N DGM1,DGM2,DGQ,DGQRT1,DGQRT2,DGX,DGY,DGY1
 S:DGQRT=5 DGQRT1=1,DGQRT2=4 S:DGQRT<5 (DGQRT1,DGQRT2)=DGQRT
 F DGY=$P(DGYRS,U,2):1:$P(DGYRS,U,3) D
 . ;get fiscal yr 3181010^3181231, 3190101^3190331, etc
 . F DGQ=DGQRT1:1:DGQRT2 D
 .. S DGY1=$$FMYR(DGY) S:DGQ=1 DGY1=$$FMYR(DGY)-1
 .. S DGX=$$GETQM(DGY,DGQ,DGMTH)
 .. S DGPER(DGY,DGY1_$P(DGX,U),DGY1_$P(DGX,U,2))=DGQ Q
 Q
 ;
PRINT ;Print out results
 N DGCAT,DGCATL,DGDASH,DGDASH2,DGF,DGHDR,DGM,DGMF,DGMM,DGMTH,DGMTHC,DGN,DGQRT,DGQRTTF,DGQRTTM,DGTTF,DGTM,DGYRTF,DGYRTM
 N DGTOT,DGX,DGYR,EXIT,Y
 S DGDASH="",$P(DGDASH,"-",81)="",DGDASH2="",$P(DGDASH2,"=",81)="",DGTOT=0
 I '$D(@DGTEMP) W !!,"No patients found for the selected criteria" Q
 S EXIT=0
 S (DGTF,DGTM,DGYR)=0 F  S DGYR=$O(@DGTEMP@(DGYR)) Q:'DGYR!(EXIT)  D
 . S (DGHDR,DGYRTF,DGYRTM)=0
 . S (DGQRT,DGQRTTF,DGQRTTM)=0 F DGQRT=1:1:4 D:$D(@DGTEMP@(DGYR,DGQRT))
 .. I 'DGHDR D HDR
 .. S DGMTH=0 F  S DGMTH=$O(@DGTEMP@(DGYR,DGQRT,DGMTH)) Q:'DGMTH!(EXIT)  D
 ... S EXIT=$$CHKPGHDR(1) Q:EXIT  ;Check $Y
 ... S DGMTHC=$P("January/February/March/April/May/June/July/August/September/October/November/December/","/",DGMTH)
 ... I DGSELQ=5,"/1/4/7/10/"[("/"_DGMTH_"/") D PRINT2 Q:EXIT
 ... S DGM=$G(@DGTEMP@(DGYR,DGQRT,DGMTH,"M")),DGF=$G(@DGTEMP@(DGYR,DGQRT,DGMTH,"F"))
 ... I DGM S DGTM=DGTM+DGM,DGYRTM=DGYRTM+DGM,DGQRTTM=DGQRTTM+DGM,DGTOT=DGTOT+DGM
 ... I DGF S DGTF=DGTF+DGF,DGYRTF=DGYRTF+DGF,DGQRTTF=DGQRTTF+DGF,DGTOT=DGTOT+DGF
 ... W !,DGMTHC,?10,$J($FN(DGM,","),10),?22,$J($FN(DGF,","),10)
 ... W ?36,$J($FN(DGM+DGF,","),10)
 .. Q:EXIT
 .. S EXIT=$$CHKPGHDR(2) Q:EXIT  ;Check $Y
 .. W !,DGDASH,!,"TOTAL",?10,$J($FN(DGQRTTM,","),10),?22,$J($FN(DGQRTTF,","),10),?36,$J($FN(DGQRTTM+DGQRTTF,","),10)
 . Q:EXIT
 . S EXIT=$$CHKPGHDR(3) Q:EXIT  ;Check $Y
 . ;Now print Fiscal Year Quarterly summary
 . W !!,"FISCAL YEAR OVERALL SUMMARY:",!?15,$J("MALE",10),?27,$J("FEMALE",10),?41,$J("TOTAL",10)
 . S (DGQRT,EXIT)=0 F  S DGQRT=$O(@DGTEMP@(DGYR,DGQRT)) Q:'DGQRT!(EXIT)  D
 .. S EXIT=$$CHKPGHDR(1,5,1) Q:EXIT  ;Check $Y
 .. S DGM="",(DGMF,DGMM)=0 F  S DGM=$O(@DGTEMP@(DGYR,DGQRT,DGM)) Q:DGM=""  D
 ... S DGMF=DGMF+$G(@DGTEMP@(DGYR,DGQRT,DGM,"F")),DGMM=DGMM+$G(@DGTEMP@(DGYR,DGQRT,DGM,"M"))
 .. W !,DGYR," QUARTER ",DGQRT,?15,$J($FN(DGMM,","),10),?27,$J($FN(DGMF,","),10),?41,$J($FN(DGMM+DGMF,","),10)
 . ;End of Fiscal Year numbers
 . S EXIT=$$CHKPGHDR(3,5,1) Q:EXIT  ;Check $Y
 . W !,DGDASH2,!!,"TOTAL PATIENTS REGISTERED FOR THE YEAR: ",?41,$J($FN(DGYRTM+DGYRTF,","),10)
 . I ($G(IOM)<132)&($E(IOST,1,2)="C-")&(IO=IO(0)) W ! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S EXIT=1
 W:'EXIT !!,"TOTAL PATIENTS REGISTERED: ",?41,$J($FN(DGTOT,","),10)
 I $E(IOST,1,2)="C-",'EXIT R !!?8,"End of the Report...Press Enter to Continue",X:DTIME W @IOF
 ;
 Q
 ;
PRINT2 ;
 S EXIT=$$CHKPGHDR(3) ;Check $Y
 Q:EXIT
 W !!,DGYR," QUARTER ",$$GETQUART(DGMTH),!
 Q
 ; 
CHKPGHDR(LINES,OFFSET,INHIB) ;Check if Page Header needs printing
 N DIRYT,EXIT
 S EXIT=0,OFFSET=+$G(OFFSET),INHIB=+$G(INHIB)
 I $Y+LINES>IOSL I ($E(IOST,1,2)="C-")&(IO=IO(0)) K DIR S DIR(0)="E" D ^DIR K DIR D  Q:EXIT 1
 . I $D(DIRUT) S EXIT=1 Q
 . D HDR(OFFSET,INHIB)
 Q EXIT
 ;
HDR(OFFSET,INHIB) ;
 N DGM,DGDT1,DGDT2
 S DGM=$G(@DGTEMP@(DGYR))
 S OFFSET=+$G(OFFSET),INHIB=+$G(INHIB)
 S DGX=$P(^DD(2,.5601,0),U,3),DGDASH="",$P(DGDASH,"-",81)=""
 S DGDT1=$O(DGPER(DGYR,"")),DGDT2=$O(DGPER(DGYR,""),-1),DGDT2=$O(DGPER(DGYR,DGDT2,""))
 S DGHDRDT="Date Range : "_$$FMTE^XLFDT(DGDT1,"5PZ")_" - "_$$FMTE^XLFDT(DGDT2,"5PZ")
 W @IOF S DGX="Presumptive Psychosis Fiscal Year Report" W $J(" ",80-$L(DGX)\2),DGX
 S DGX="Report Period: "_$S(DGSELQ=5:"Fiscal Year (All Quarters)",1:"Quarter: "_DGSELQ_"  "_$$WHICHMTH(DGSELQ,DGSELM)) W !,$J(" ",80-$L(DGX)\2),DGX
 W !,$J(" ",80-$L(DGHDRDT)\2),DGHDRDT ;Date Range
 S DGX="Date Report Printed: " S Y=DT X ^DD("DD") S DGX=DGX_Y W !,$J(" ",80-$L(DGX)\2),DGX
 S PAGE=PAGE+1
 W ?68,"Page: "_PAGE
 W:'INHIB !,DGDASH,!,"MONTH",?10+OFFSET,$J("MALE",10),?22+OFFSET,$J("FEMALE",10),?36+OFFSET,$J("TOTAL",10),!,DGDASH
 S DGHDR=1
 Q
 ;
WHICHMTH(DGSELQ,DGSELM) ;Heading shows All Months or just the one month
 N DGX
 I DGSELM=4 Q "All Months"
 S DGX=$$GETMTHS(DGSELQ)
 Q $P($P(DGX,";",DGSELM),":",2)
 ;
FY(DATE) ; return a dates Fiscal Year
 N YR,FY,MTH,QRT
 I $G(DATE)?7N.E S YR=$S($E(DATE,4,5)<10:$E(DATE,1,3),1:$E(DATE,1,3)+1),FY=$E(YR,2,3)
 S MTH=$E(DATE,4,5),QRT=$S(MTH<4:2,MTH>3&(MTH<7):3,MTH>6&(MTH<10):4,1:1)
 Q (($E(DATE)-1*1000)+FY)_"Q"_QRT
 ;
GETFISC(PROMPT)  ;Get from and to Fiscal Years
 N DGDEFDA,DGDEFFY,DGDTFRM,DGDTTO,DGFIRST,DTOUT,OUT,DIRUT,Y
 ;INPUT ;   PROMPT - Message to display prior to prompting for dates
 ;OUTPUT:     1^BEGDT^ENDDT - Data found
 ;            0             - User up arrowed or timed out
 ;If they want to show first available date for that set of Status, use this sub
FRMYR ;
 W !
 ;S OUT=0,DGDTDEF=$$GETDEFD^DGPPRP1() I DGDTDEF="" W !!,"There is no record of patch DG*5.3*977 being installed!",!! Q
 S OUT=0,DGDTDEF=3190101
 S DGFIRST=$P($$FY(DGDTDEF),"Q")
 S DGDEFFY=$P($$FY(DT),"Q")
 K DIR S DIR(0)="N^"_DGFIRST_":"_DGDEFFY,DIR("A")="Enter 'From' Fiscal Year",DIR("B")=DGFIRST D ^DIR
 Q:$D(DIRUT) 0
 S DGDTFRM=+Y
TOYR ;
 ;I DGDTFRM=DGDEFFY Q 1_U_DGDTFRM_U_DGDTFRM
 K DIR S DIR(0)="N^"_DGDTFRM_":"_DGDEFFY,DIR("A")="Enter 'To' Fiscal Year",DIR("B")=DGDEFFY D ^DIR
 Q:$D(DIRUT) 0 ;G:$D(DIRUT) FRMYR
 S DGDTTO=+Y,OUT=1_U_DGDTFRM_U_DGDTTO
 Q OUT
 ;T
 ;
INITTEMP(DGFISCFR,DGFISCTO,DGSELQ,DGSELM) ;
 N DGI,DGMTHFR,DGMTHTO,DGSEX,DGX,DGYR
 S:DGSELQ=5 DGMTHFR=1,DGMTHTO=12
 D:DGSELQ<5
 . S DGX=$$GETMTHSN(DGSELQ)
 . I DGSELM=4 S DGMTHFR=$P($P(DGX,";"),":",2),DGMTHTO=$P($P(DGX,";",3),":",2)
 . I DGSELM<4 S (DGMTHFR,DGMTHTO)=$P($P(DGX,";",DGSELM),":",2)
 F DGYR=DGFISCFR:1:DGFISCTO F DGI=DGMTHFR:1:DGMTHTO F DGSEX="F","M" S @DGTEMP@(DGYR,$$GETQUART(DGI),DGI,DGSEX)=0
 Q
 ;
GETMTH(D) ;
 Q $S(D="January":1,D="February":2,D="March":3,D="April":4,D="May":5,D="June":6,D="July":7,D="August":8,D="September":9,D="October":10,D="November":11,1:"December")
 ;
GETQUART(MTH) ;
 Q $P("2/2/2/3/3/3/4/4/4/1/1/1/","/",MTH)
 ;
GETMTHQ(MTH) ;
 Q $P("2/2/2/3/3/3/4/4/4/1/1/1/","/",MTH)
 ;
GETMTHS(DGSELQ) ;
 S DGX="1:October;2:November;3:December/1:January;2:February;3:March/1:April;2:May;3:June/1:July;2:August;3:September"
 Q $P(DGX,"/",DGSELQ)
 ;
GETMTHSN(DGSELQ) ;
 S DGX="1:10;2:11;3:12/1:1;2:2;3:3/1:4;2:5;3:6/1:7;2:8;3:9"
 Q $P(DGX,"/",DGSELQ)
 ;
OUT ; KILL RETURN ARRAY QUIT
 D ^%ZISC
 K @DGTEMP
 Q
