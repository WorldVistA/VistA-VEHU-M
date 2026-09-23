RCP455E ;TAS/CJE - ePayment Lockbox Post-Installation Processing ;4 Oct 2018 10:29:18
 ;;4.5;Accounts Receivable;**455**;Oct 4, 2018;Build 19
 ;Per VA Directive 6402, this routine should not be modified.
EN  ; Environmental Check
 K XPDQUIT
 I $$KCHK^XUSRB("XUMGR",+DUZ) Q  ; installer has the key and everything is cool
 ;
 ; ABORT! ABORT! ABORT!
 S XPDQUIT=2  ; Do not install this transport global but leave it in ^XTMP. >S XPDQUIT=2
 W !,"Don't be alarmed but something went awry...",!
 W !,"You need SECURITY KEY - XUMGR to successfully install this patch"
 W !,"which creates Proxy User RCDPETAS,APPLICATION PROXY"
 W !,"Please get the required key or find the closest person that has it"
 W !,"and ask for assistance.",!
 N DIR
 S DIR(0)="E"
 D ^DIR
 Q
