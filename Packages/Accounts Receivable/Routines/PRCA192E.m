PRCA192E ;BAY-OI/RLC - ENVIRONMENTAL CHECK FOR PATCH 192 ;03/08/04
 ;;4.5;Accounts Receivable;**192**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified
 ;
 ;Environmental check routine for patch 192.  This patch should
 ;not be installed by any sites that have CoreFLS installed.
ENV ;
 I $$PATCH^XPDUTL("PRCA*4.5*175") D
 . W "You are a test site for a CoreFLS version (patch PRCA*4.5*175) of Accounts",!
 . W "Receivable.  This patch has a conflict with the AR-CoreFLS test software.",!
 . W "It must NOT be installed unless an accompanying update is made to the",!
 . W "AR-CoreFLS software immediately after installation of this patch.",!!
 . N DIR,DTOUT,DUOUT,Y
 . S DIR(0)="YA"
 . S DIR("A")="Do you have the corresponding update to the AR-CoreFLS software that is associatied with this patch? (Note: entering ""No"" here will stop the installation of this patch) Y/N // "
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT)!(Y'=1) W !,"Installation of this patch has been stopped!" S XPDQUIT=2 Q
 . W !,"OK to install!"
 . K DIR,DTOUT,DUOUT,Y
 Q
