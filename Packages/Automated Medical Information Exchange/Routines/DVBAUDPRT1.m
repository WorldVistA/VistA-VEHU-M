DVBAUDPRT1  ;ALB/CP - UTL Printing subroutines & extrinsics #1 ; 10/31/18 2:00pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;           ^%DT    ; IA #10003
 ;       GETS^DIQ    ; IA # 2056
 ;   ^%ZOSF("RM"     ; IA #10096
 ;   $$FMDIFF^XLFDT  ; IA #10103
 ;      $$NOW^XLFDT  ; IA #10103
 ;
 Q 
 ;
CENTER(DVBTEXT,DVBLF,DVBRM,DVBRVIDEO) ;
 ;
 N DVBCNTLF ; Count of line feeds
 ; ZEXCEPT: IOM
 ;
 Q:$G(DVBTEXT)=""
 S DVBLF=$G(DVBLF,1)
 S DVBRM=$G(DVBRM,IOM)
 S DVBRVIDEO=$G(DVBRVIDEO,0)
 I DVBLF>0 F DVBCNTLF=1:1:DVBLF W !
 W ?(DVBRM-$L(DVBTEXT))\2
 D:DVBRVIDEO REVVIDEO("ON")
 W DVBTEXT
 D:DVBRVIDEO REVVIDEO("OFF")
 ;
 Q  ; CENTER
 ;
CONTINUE(DVBLF,DVBTYPE) ; Variations of Press <ENTER> to continue.
 ;
 N DVBCNT,DVBREAD,DVBDTIME
 ; ZEXCEPT: DTIME,IOST,DVBQUIT
 ;
 Q:$E($G(IOST),1,2)'="C-"
 S DVBLF=$G(DVBLF,2) ; Default to two line feeds
 S DVBDTIME=$S($G(DTIME)>0:DTIME,1:300)
 S:$G(DVBTYPE)="" DVBTYPE="R"
 ;
 F DVBCNT=1:1:+$G(DVBLF) W !
 ;
 I DVBTYPE="R" D  Q
 . W "Press <ENTER> to continue: "
 . R DVBREAD:DVBDTIME
 ;
 I DVBTYPE="Q" D  Q
 . S DVBQUIT=0 ; Initialize output status flag to successful
 . W "Press <ENTER> to continue, '^' to quit: "
 . R DVBREAD:DVBDTIME
 . S:'$T DVBREAD="^" I DVBREAD["^" SET DVBQUIT=1 ; User entered '^', quit
 Q:DVBQUIT
 ;
 Q  ; CONTINUE
 ;
INITPRT  ; Initialize printed report variables
 ; Count, Page Number, and Quit Flag
 S (DVBCNT,DVBPG,DVBQUIT)=0
 ;
 S DVBDT=$$DATE^DVBAUDDT1($$NOW^XLFDT(),1,0,1) ; mm/dd/yy hh:mm
 S $P(DVBLINED,"-",IOM+1)="" ;.............. Line of dashes
 S $P(DVBLINEE,"=",IOM+1)="" ;.............. Line of equal signs
 S $P(DVBLINEP,".",IOM+1)="" ;.............. Line of periods
 S $P(DVBLINEU,"_",IOM+1)="" ;.............. Line of underscores
 S DVBFLAG1=1 ;............................. 1st_time_flag
 ;
 Q  ; INITPRT
 ;
LINEWRAP(DVBVALUE) ; Turn line wrapping off or on ; Used for data extraction
 ;
 N X
 ; ZEXCEPT: IOM
 ;
 S X=$S(DVBVALUE="ON":IOM,1:0) ; 0=Turns wrapping off
 X ^%ZOSF("RM") ; Turn wrapping off or reset right margin/turn wrap on
 ;
 Q  ; LINEWRAP
 ;
NODATA(DVBLF) ; Use for printouts when no data is in ^TMP global
 ;
 S DVBLF=$G(DVBLF,2)
 D CENTER("No data was found for the requested input criteria.",DVBLF)
 D CONTINUE(2,"R")
 ;
 Q  ; NODATA
 ;
PAGEBRK(DVBRTN,DVBPG,DVBCHKSL,DVBNEWPG) ; Generic page break logic
 ;
 S DVBNEWPG=$G(DVBNEWPG,0) ;.... Default, does NOT force a page break
 S DVBCHKSL=$G(DVBCHKSL,1) ;.... Default, check for page break
 I DVBCHKSL,$Y'>(IOSL-5) Q  ;.. If it's not time for a page break, quit
 ;
 I DVBPG D CONTINUE(2,"Q") Q:DVBQUIT  ;. Quit on user '^'
 I DVBPG!DVBNEWPG!($E(IOST)="C") W @IOF ;Issue form feed
 S DVBPG=DVBPG+1 ;...................... Increment page number
 ;
 D @("PRINTHD^"_DVBRTN) ;.............. Prt rpt header from calling rtn
 ;
 Q  ; PAGEBRK
 ;
PRTVARS() ; Extrinsic function news standard variables used in printed reports
 ;
 QUIT "DVBCNT,DVBDT,DVBFLAG1,DVBLINED,DVBLINEE,DVBLINEP,DVBLINEU,DVBPG,DVBQUIT" ;Extrinsic PRTVARS 
 ;
PROCTIME(DVBTIMEBEG,DVBTIMEEND) ; Display the amount of processing time for the rpt
 ;
 N %,DVBDAYS,DVBDIFF,DVBHRS,DVBMINS,DVBSECS
 N @($$%DT^DVBAUDNEW1())
 ; ZEXCEPT: %DT,X,Y
 ;
 S DVBTIMEEND=$G(DVBTIMEEND,$$NOW^XLFDT())
 ;
 S %DT="ST"
 S X=DVBTIMEBEG
 K Y D ^%DT I Y=-1!($P(DVBTIMEBEG,".")'?7N) Q
 S X=DVBTIMEEND
 K Y D ^%DT I Y=-1!($P(DVBTIMEEND,".")'?7N) Q
 ;
 S DVBDIFF=$$FMDIFF^XLFDT(DVBTIMEEND,DVBTIMEBEG,3) ; Returns: DD HH:MM:SS
 ;
 ;
 S DVBDAYS=$P(DVBDIFF," ")
 S DVBHRS=$P($P(DVBDIFF," ",2),":")
 S DVBMINS=$P($P(DVBDIFF," ",2),":",2)
 S DVBSECS=$P($P(DVBDIFF," ",2),":",3)
 S:DVBSECS="" DVBSECS=1
 W !!," PROCESSING TIME:"
 W:DVBDAYS " DAYS: ",DVBDAYS
 W:DVBHRS "  HOURS: ",DVBHRS
 W:DVBMINS "  MINS: ",DVBMINS
 W:DVBSECS "  SECS: ",DVBSECS
 ;
 W "  (",$$DATE^DVBAUDDT1($$NOW^XLFDT(),1),")" ; Display end time
 ;
 Q  ; PROCTIME
 ;
REVVIDEO(DVBVALUE) ; Turn REVERSE VIDEO on or off depending upon ENVALUE
 ;
 N DIERR,DVBIENS,DVBQUIT,DVBTT,DVBRVDOFF,DVBRVDON
 ; ZEXCEPT: IOST
 ;
 S DVBIENS=+$G(IOST(0))_"," Q:$P(DVBIENS,",")'>0
 D GETS^DIQ(3.2,DVBIENS,"14;15","E","DVBTT")
 D DIERR^DVBAUDDILG1(60,5,"DVBERROR","REVVIDEO^"_$T(+0)) Q:DVBQUIT
 S DVBRVDON=DVBTT(3.2,DVBIENS,14,"E")
 S DVBRVDOFF=DVBTT(3.2,DVBIENS,15,"E")
 ;
 I DVBVALUE="ON",DVBRVDON]"" W @(DVBRVDON) Q
 I DVBVALUE="OFF",DVBRVDOFF]"" W @(DVBRVDOFF) Q
 ;
 Q  ; REVVIDEO
