DVBAUDPRT2  ;ALB/CP - UTL Printing subroutines & extrinsics #2 ; 10/10/18 1:58pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;       $$UP^XLFSTR ; IA #10104
 Q
 ;
BUSYSET  ; Setup the busy indicator
 ;
 SET DVBBUSY=0
 W " [|]"
 ;
 Q  ; BUSYSET
 ;
BUSYSHOW ; Update the busy indicator state
 ;
 S DVBBUSY=$G(DVBBUSY)+1#4
 W @IOBS,@IOBS ; Executes 2 backspaces
 W $S(DVBBUSY=0:"|",DVBBUSY=1:"/",DVBBUSY=2:"-",DVBBUSY=3:"\",1:" "),"]"
 ;
 Q  ; BUSYSHOW
 ;
BUSYKILL ; Break down the busy indicator
 ;
 K DVBBUSY W !
 ;
 Q  ; BUSYKILL
 ;
BUSYTEST ; Test the busy indicator
 ;
 W !,"This is about 20 seconds of a BUSY INDICATOR:"
 D BUSYSET
 N DVBI F DVBI=1:1:20 H 1 D BUSYSHOW
 D BUSYKILL
 ;
 Q  ; BUSYTEST
 ;
DOTS(DVBCURRCNT,DVBDISPCNT) ; Write dots '.....' to the video display every x number
 ;
 S DVBDISPCNT=$G(DVBDISPCNT,100) ;-> Default to every 100 entries
 I DVBCURRCNT#DVBDISPCNT=0,$E(IOST)="C" W "."
 ;
 Q  ; DOTS
 ;
SHOWGOAL(DVBRTN) ; Display the purpose or goal of the routine/menu option
 ;
 N DVBCNT,DVBGOALEND,DVBLINENUM,DVBROUTINE,DVBTEXT
 ; ZEXCEPT: IOF,IOSL
 ;
 S DVBGOALEND="*** END ***"
 S DVBLINENUM=1
 S DVBCNT=0
 S DVBROUTINE="GOAL+"_DVBLINENUM_"^"_DVBRTN
 W !
 F  S DVBTEXT=$P($T(@DVBROUTINE),";;",2,999) Q:DVBTEXT[DVBGOALEND  D  ;
 . I $Y>(IOSL-5) D CONTINUE^DVBAUDPRT1(2,"R") W @IOF
 . W !,DVBTEXT
 . S DVBLINENUM=DVBLINENUM+1
 . S DVBROUTINE="GOAL+"_DVBLINENUM_"^"_DVBRTN
 . S DVBCNT=DVBCNT+1
 ;
 D CONTINUE^DVBAUDPRT1(2,"R") ;............. Press <ENTER> to continue
 W @IOF
 ;
 Q  ; SHOWGOAL
 ;
SHOWOPT(DVBOPTION) ; Display option DVBTEXT.
 ;
 Q:DVBOPTION=""
 W @IOF,!?1,"*** ",$$UP^XLFSTR(DVBOPTION)," ***"
 ;
 Q  ; SHOWOPT
 ;
TRYAGAIN(DVBINPUTVAR) ; Generic user response message to try again or exit.
 ;
 I $A($E(DVBINPUTVAR))>96 W !?6,"Make sure your <CAPS LOCK> key is on.",!
 ;
 ; Generic message always displayed to the user on input errors
 W !?6,"You may try again, or optionally exit this option by pressing"
 W !?6,"<Enter> or entering an up arrow ('^') after returning to the"
 W !?6,"first prompt."
 ;
 D CONTINUE^DVBAUDPRT1(2,"R") ; Press <ENTER> to continue
 S DVBQUIT=1 ; Set output status flag to unsuccessful
 ;
 Q  ; TRYAGAIN
