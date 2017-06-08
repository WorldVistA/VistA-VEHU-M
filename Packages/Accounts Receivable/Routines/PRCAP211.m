PRCAP211 ;ALB/CXW - PATCH PRCA*4.5*211 ENVIRONMENT CHECK
 ;;4.5;Accounts Receivable;**211,196,214,212**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
ENV ;
 ;this is the environment check routine
 I $$PATCH^XPDUTL("PRCA*4.5*175") D
 . W "You are a test site for a CoreFLS version (patch PRCA*4.5*175) of Accounts",!
 . W "Receivable. This patch has a conflict with the AR-CoreFLS test software.",!
 . W "It must NOT be installed unless an accompanying update is made to the",!
 . W "AR-CoreFLS software immediately after installation of this patch.",!!
 . N DIR,DTOUT,DUOUT,Y
 . S DIR(0)="YA"
 . S DIR("A")="Do you have the corresponding update to the AR-CoreFLS software that is associated with this patch? (Note: Entering ""No"" here will stop the installation of this patch) Y/N//"
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT)!(Y'=1) W !,"Installation of this patch has been stopped!" S XPDQUIT=1 Q
 . W !,"OK to install!"
 Q
