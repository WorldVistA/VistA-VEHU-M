IBYXXX ; ALB/TMK - Identify and allow resubmit of bills sent to the wrong payer ;21-AUG-02
 ;;2.0;INTEGRATED BILLING;**193**;21-MAR-94
 ;
ID ; Read file and compare insurance co in batch to what is in VistA
 ; Create a file of the 'bad' bill submissions in ^XTMP("IBRESUBMIT")
 ;
 N DIR,IBQUIT,IBQUIT1,X,Y,Z,IB3,IBBATCH,IBZ,IBX,IBIFN,IBXDATA,IBBILL,IBINSNM,IBFILEP,IBFILEN,IBFILE,POP,IBCT,IB0,IB1
 ;
Q1 S Y=$O(^IBA(364.1,"B","")) Q:Y=""  S DIR("B")=$E(Y,1,3)
 S DIR(0)="NA^100:999"
 S DIR("A")="Enter the first 3 digits of the batch #s for your site: "
 S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1)
 I IBQUIT!(IBQUIT1) D:IBQUIT  Q
 . S DIR(0)="E" S Y=$$DIR(.DIR)
 S IB3=Y
 S Y=$O(^IBA(364.1,"B",IB3))
 I $E(Y,1,3)'=IB3 W !,"NO BATCHES BEGINNING WITH "_IB3_" WERE FOUND ON YOUR SYSTEM!!" S DIR(0)="E" S Y=$$DIR(.DIR) Q
 ;
Q2 S DIR(0)="FA^1:60"
 S DIR("A")="FILE NAME PATH: ",DIR("B")=$$PWD^%ZISH
 S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1)
 I IBQUIT Q
 I IBQUIT1 G Q1
 S IBFILEP=$P(Y,U)
 ;
 S DIR(0)="FA^1:60",DIR("B")="IBCL_"_IB3_".DAT"
 S DIR("A")="FILE NAME: "
 S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1)
 I IBQUIT S DIR(0)="E" S Y=$$DIR(.DIR) Q
 I IBQUIT1 G Q2
 S IBFILEN=$P(Y,U)
 ;
 D OPEN^%ZISH("IBINFILE",IBFILEP,IBFILEN,"R")
 I POP W !,"FILE ",IBFILEP,IBFILEN," COULD NOT BE FOUND OR COULD NOT BE OPENED",! S DIR(0)="E" S Y=$$DIR(.DIR) Q
 S IBFILE=IO
 ;
 D READFILE(IBFILE,IB3)
 I '$D(^TMP($J)) W !,"NO RECORDS MATCHING YOUR BATCH PREFIX WERE FOUND IN THE FILE!!" S DIR(0)="E" S Y=$$DIR(.DIR) D CLOSE Q
 ;
 I $O(^XTMP("IBRESUBMIT",0))'="" D  I IBQUIT D CLOSE Q
 . S DIR(0)="YA",DIR("B")="NO"
 . S DIR("A",1)="THIS LIST HAS ALREADY BEEN BUILT.  RERUNNING IT WILL DELETE PRIOR RESULTS",DIR("A")="ARE YOU SURE YOU WANT TO RERUN IT?: "
 . S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1)
 . I Y'=1 S IBQUIT=1
 ;
 K ^XTMP("IBRESUBMIT")
 S ^XTMP("IBRESUBMIT",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^BILLS SUBMITTED TO WRONG PAYER "_$$HTE^XLFDT($H)
 ;
 S IBCT=0
 S IBBATCH="" F  S IBBATCH=$O(^TMP($J,IBBATCH)) Q:IBBATCH=""  D
 . S IBZ=+$O(^IBA(364.1,"B",IBBATCH,0)) I 'IBZ Q
 . ; Find all the bills reported in the batch
 . S IBBILL="" F  S IBBILL=$O(^TMP($J,IBBATCH,IBBILL)) Q:IBBILL=""  D
 .. S IBIFN=+$O(^DGCR(399,"B",$P(IBBILL,"-",2),0)),IB0=$G(^DGCR(399,IBIFN,0))
 .. I $P(IB0,U,13)=7 Q  ; Bill was cancelled
 .. ; Find the transmit bill entry
 .. S (IB1,IBX)=0 F  S IB1=$O(^IBA(364,"C",IBZ,IB1)) Q:'IB1  I $P($G(^IBA(364,IB1,0)),U)=IBIFN S IBX=IB1 Q
 .. ;
 .. Q:'IBX
 .. ;
 .. K IBXDATA
 .. D F^IBCEF("N-CURR INSURANCE MAILING NAME",,,IBIFN)
 .. S IBINSNM=$E($G(IBXDATA),1,30)
 .. ; If the current ins co name is the same as the ins co it went to, it
 .. ; went to the correct payer ... ignore the record
 .. I $G(^TMP($J,IBBATCH,IBBILL))=IBINSNM Q
 .. ;
 .. ; If it's not the same, check to see if the bill was resubmitted
 .. ; If it was and the batch doesn't appear in the list from the FSC,
 .. ; we can assume it was resubmitted correctly and will ignore it
 .. ; If the new batch was sent to PAYID, ignore it for now
 .. ; as it will be picked up in a later loop when the batch it was
 .. ; resubmitted in is checked as it may have gone to the correct
 .. ; payer in a later batch
 .. S Z=$$LAST364^IBCEF4(IBIFN)
 .. I Z'=IBX Q
 .. ;
 .. ; ("IBRESUBMIT",bill ien,tx bill ien)=right name^wrong (sent to) name
 .. S ^XTMP("IBRESUBMIT",IBIFN,IBX)=IBINSNM_U_$G(^TMP($J,IBBATCH,IBBILL))
 .. S IBCT=IBCT+1
 ;
 I 'IBCT W !,"NO BILLS WERE FOUND THAT WERE MISROUTED FOR YOUR SITE" S DIR(0)="E" S Y=$$DIR(.DIR)
 I IBCT D
 . S ^XTMP("IBRESUBMIT","CT")=IBCT
 . S DIR(0)="YA"
 . S DIR("A",1)="There were "_IBCT_" bills found that may have been misrouted",DIR("A")="DO YOU WANT TO PRINT A LIST OF THESE BILLS NOW?: ",DIR("B")="YES"
 . S Y=$$DIR(.DIR)
 . I Y=1 D PRINT
 K ^TMP($J)
 Q
 ;
READFILE(IBFILE,IB3) ; Read records from file and store them in ^TMP global
 ;
 N IBDONE,IBQUIT,X
 K ^TMP($J)
 U IBFILE
 S (IBDONE,IBQUIT)=0
 F  R X:DTIME Q:X=""!(X="ENDFILE")  S ^TMP($J,$E(X,1,10),$E(X,41,51))=$$STRIP($E(X,11,40))
 D CLOSE
 Q
 ;
CLOSE D CLOSE^%ZISH("IBINFILE")
 U IO(0)
 Q
 ;
STRIP(X) ; Strips the spaces off the right end of the insurance co name
 N Z,Z0
 S Z0=$L(X)
 F Z=$L(X):-1:1 Q:$E(X,Z)'=" "  S Z0=Z-1
 S Z0=$E(X,1,Z0)
 Q Z0
 ;
PRINT ;
 D PRINT1(0)
 Q
 ;
PRINT1(IBEXC) ; Prints the list of bills in the 'bad bill' array
 ;
 I '$D(^XTMP("IBRESUBMIT")) D  Q
 . W !,"THERE ARE NO BILLS IDENTIFIED TO BE RESUBMITTED - NO PRINT!!"
 . S DIR(0)="E" S Y=$$DIR(.DIR)
 ; Choose device, allow to queue
 N %ZIS,ZTSAVE,ZTRTN,ZTDESC,POP
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") D  Q
 . S ZTRTN="PR1^IBYXXX("_+$G(IBEXC)_")"
 . S ZTDESC="Bills possibly sent to wrong payer report" D ^%ZTLOAD K ZTSK D HOME^%ZIS
 U IO
 D PR1($G(IBEXC))
 Q
 ;
PR1(IBEXC) ; Queued job entry point
 ; IBEXC = 0 if not excluding bills flagged as DONE or NOT
 N IB,IBX,IBSTOP,IBPAGE,IBBDT,Z,Z0,Z1,Z2
 S (IBSTOP,IBPAGE)=0
 K ^TMP($J),^TMP("IBNO",$J),^TMP("IBDONE",$J)
 W:$E(IOST,1,2)["C-" @IOF ;Only initial form feed for print to screen
 ;
 D HDR(.IBPAGE)
 S Z=0 F  S Z=$O(^XTMP("IBRESUBMIT",Z)) Q:'Z  S Z0=0 F  S Z0=$O(^XTMP("IBRESUBMIT",Z,Z0)) Q:'Z0  S Z1=$G(^(Z0)) D
 . S IB=$P($G(^IBA(364.1,+$P($G(^IBA(364,Z0,0)),U,2),0)),U),IB=+$E(IB,4,10),IBX=$$BN1^PRCAFN(Z)
 . I $G(^XTMP("IBRESUBMIT",Z,Z0,"NO")) Q:$G(IBEXC)  S ^TMP("IBNO",$J,IBX,IB)=1
 . I $G(^XTMP("IBRESUBMIT",Z,Z0,"DONE")) Q:$G(IBEXC)  S ^TMP("IBDONE",$J,IBX,IB)=^XTMP("IBRESUBMIT",Z,Z0,"DONE")
 . S ^TMP($J,IBX,IB)=Z0,^TMP($J,IBX,IB,1)=Z1
 S Z="" F  S Z=$O(^TMP($J,Z)) Q:Z=""!(IBSTOP)  S Z0=0 F  S Z0=$O(^TMP($J,Z,Z0)) Q:'Z0  S Z2=$G(^(Z0)),Z1=^(Z0,1) D  Q:IBSTOP
 . I $G(^TMP("IBDONE",$J,Z,Z0)) S Z2=$$LAST364^IBCEF4(+$G(^IBA(364,+Z2,0)))
 . S IBBDT=$P($G(^IBA(364.1,+$P($G(^IBA(364,+Z2,0)),U,2),1)),U,3)
 . W !,$E(Z_"/"_Z0_$J("",18),1,18),$E($P(Z1,U,2)_$J("",32),1,32),$P(Z1,U)
 . W !,?18,"LAST SENT: "_$$DAT1^IBOUTL(IBBDT,1)
 . W:$G(^TMP("IBNO",$J,Z,Z0)) ?49,"***SELECTED NOT TO RESUBMIT***"
 . I $G(^TMP("IBDONE",$J,Z,Z0)) D
 .. N IBZ
 .. S IBZ=$P($G(^IBA(364,+^TMP("IBDONE",$J,Z,Z0),0)),U,2),IBZ=$P($G(^IBA(364.1,+IBZ,0)),U)
 .. W ?49,"***RESUBMITTED*** "_IBZ
 . I ($Y+5)>IOSL D HDR(.IBPAGE,.IBSTOP)
 ;
 K ^TMP($J),^TMP("IBNO",$J),^TMP("IBDONE",$J)
 I 'IBSTOP,$E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR
 I $D(ZTQUEUED) S ZTREQ="@" Q
 W ! D ^%ZISC
 Q
 ;
HDR(IBPAGE,IBSTOP) ; Print header for list
 I IBPAGE D  Q:IBSTOP
 . I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR S IBSTOP=('Y) Q:IBSTOP
 . W @IOF
 S IBPAGE=IBPAGE+1
 W !,?17,"LIST OF BILLS POSSIBLY SENT TO THE WRONG PAYER",?70,"PAGE: ",IBPAGE,!,?45,"RUN DATE: ",$$HTE^XLFDT($H,"2"),!
 W !!,"BILL #/BATCH#",?18,"SENT TO INSURANCE CO",?50,"CORRECT INSURANCE CO"
 W !,$TR($J("",80)," ","-")
 Q
 ;
DIR(DIR,IBQUIT,IBQUIT1,X,IBW1,IBW2) ; Standard call to ^DIR
 ;  Inputs DIR array
 ;  Returns IBQUIT,IBQUIT1,X if passed by reference
 ;    AND
 ;      FUNCTION returns the value of Y
 ;  IBW1 = 1 if initial write ! should be done
 ;  IBW2 = 1 if last write ! should be done
 N DIROUT,DTOUT,DUOUT,DA
 W:$G(IBW1) ! D ^DIR K DIR W:$G(IBW2) !
 S (IBQUIT,IBQUIT1)=0
 I $D(DIROUT) S (IBQUIT,IBQUIT1)=1 ;(2 up-arrows entered)
 I $D(DTOUT)!$D(DUOUT) S IBQUIT1=1 ;(one up-arrow entered or time out)
 Q Y
 ;
RUN ; Menu driver for routines
 N X,Y,IBQUIT,IBQUIT1,IBDONE,DIR
 S IBDONE=0
 F  D  Q:IBDONE
 . D CLEAR^VALM1
 . S DIR(0)="SM^E:EXTRACT LIST;P:PRINT LIST;R:RESUBMIT BILLS;X:EXIT"
 . S DIR("A")="ENTER THE FUNCTION YOU WANT TO PERFORM",DIR("B")="X"
 . S DIR("?",1)="  EXTRACT LIST: Creates the list of bills submitted by your site from the",DIR("?",2)=$J("",17)_"national file.  Must be run before the other functions."
 . S DIR("?",3)="    PRINT LIST: Prints a list of bills extracted.  These are the bills",DIR("?",4)=$J("",17)_"that can be resubmitted with the RESUBMIT BILLS function."
 . S DIR("?",5)="RESUBMIT BILLS: Allows you to remove bills from the list and resubmit the",DIR("?")=$J("",17)_"rest automatically."
 . W !,"FUNCTIONS FOR IDENTIFYING AND RESUBMITTING BILLS SENT TO THE WRONG PAYER"
 . S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1)
 . I Y="" Q
 . I IBQUIT!IBQUIT1 S IBDONE=1 Q
 . I Y="E" D  Q
 .. N IBQUIT,IBQUIT1
 .. D ID
 . I Y="P" D  Q
 .. N IBQUIT,IBQUIT1
 .. D PRINT
 . I Y="R" D  Q
 .. N IBQUIT,IBQUIT1
 .. D RESUB^IBYXXX1
 . I Y="X" S IBDONE=1 Q
 Q
 ;
