PRS69ENV ;HISC/REL-Patch PRS*4.0*69 Environment Check ;09/25/01
 ;;4.0;PAID;**69**;Sep 21, 1995
 ;
 ; This Environment Check routine will prohibit patch PRS*4.09*69
 ; from being installed before 10:00 a.m. central time on 10/10/2001.
 ;
LIVE ;
 X ^%ZOSF("UCI") S %=^%ZOSF("PROD")
 S:%'["," Y=$P(Y,",")
 ; If not a production account then quit without setting XPDQUIT
 I Y'=% D  Q
 . W !!," This is not a production account.  Continuing with install ..."
 . W !!
 ;
 W !!," This is a production account.  Checking Date and Time."
 ;
 ; Date/Time APIs are in ^XMXUTIL1 - see MailMan pgmr manual.
 ; Choose the time zone (CDT or CST) from file 4.4
 D ZONEDIFF^XMXUTIL1("CST",.HRS,.MINS) ; difference between site's zone and CST
 S MYNOW=$$NOW^XLFDT
 W !!," The current date and time is:  ",$$FMTE^XLFDT(MYNOW,5)
 W !," Time diff from CST: ",HRS," hours, and ",MINS," minutes."
 S CSTNOW=$$FMADD^XLFDT(MYNOW,,-HRS,-MINS)
 I CSTNOW<3011010.1 D  Q  ; 10:00 a.m. on 10/10/2001
 . ; Don't install this transport global but leave it in ^XTMP
 . S XPDQUIT=2
 . W !!," Patch PRS*4.0*69 can only be installed into a production"
 . W !," account after 10:00 a.m. Central time on 10/10/2001."
 . W !!
 ;
 ; After 10:00 a.m. Central and OK to install
 W !!,"Beginning installation of PRS*4.0*69 ..."
 W !!
 Q
