A1BFSRV0 ;EF/NP;ALBANY ISC;10/27/92; Server to store incoming RTM stats
 ;;VERSION 1.0
EN ;
 S U="^",DTIME=30 S %DT="RTX",X="NOW" D ^%DT,DD^%DT S A1BFDT=Y
 G:'$D(XMZ)!('$D(XMFROM)) ERRMSG
 S (A1BFMSG(1),A1BFROM)=XMFROM X XMREC
 G:'$D(XMER) NOMSG
 S A1BFSITE=$P(XMRG,U),A1BFDATE=$P(XMRG,U,2),A1BFRT=$P(XMRG,U,3),A1BFAU=$P(XMRG,U,4),A1BFMU=$P(XMRG,U,5)
 ;NEXT LINE IS INCORRECT - CORRECTED 8DEC92 EF
 ;S A1BFIEN=$O(^A1BF(11603,"B",A1BFSITE,"")) I 'A1BFIEN G NOSITE
 S A1BFIEN=$O(^DIC(4,"D",A1BFSITE,"")) I A1BFIEN="" G NOSITE
ADD ;Add site entry if not present
 S DIC="^A1BF(11603,",DIC(0)="LMZX",X=A1BFIEN,DLAYGO=11603 D ^DIC I +Y<1 G NOADD
 ;SET UP ZERO NODE FOR MULTIPLE FOR THE NEW SITE
 S A1BFSTEN=+Y I $P(Y,U,3)=1 S ^A1BF(11603,A1BFSTEN,1,0)="^11603.01DA^^" K DD,DO,DIC
 ;Now see about adding a new multiple for this site on this date
 S DIC="^A1BF(11603,A1BFSTEN,1,",DA(1)=A1BFSTEN,X=A1BFDATE,DIC(0)="LMQZ",DLAYGO=11603.01 D ^DIC S A1BFDEN=+Y I Y<1 G NODATE
 S DIE="^A1BF(11603,A1BFSTEN,1,",DA(1)=A1BFSTEN,DA=A1BFDEN,DR="1///"_A1BFRT_";2///"_A1BFAU_";3///"_A1BFMU D ^DIE
 K DD,DO,DIE,DA,DIC
 K A1BFAU,A1BFDATE,A1BFRT,A1BFIEN,A1BFMU,DIC,DINUM,XMREC,XMER
 Q
ERRMSG ;
 S XMSUB="R/T SERVER ERROR ON "_A1BFDT
 S ERRMSG(1)="The RTM server was erroneously invoked on "_A1BFDT_"."
 S ERRMSG(2)="The incoming message number was "_$S($D(XMZ):XMZ,1:"not present.")
 S ERRMSG(3)="The originator of the message was "_$S($D(XMFROM):XMFROM,1:"not available.") G SEND
BADLOAD ;
 S XMSUB="R/T SERVER LOAD WAS UNSUCCESSFUL ON "_A1BFDT
 S ERRMSG(1)="The RTM server was unsuccessful in loading data on "_A1BFDT_"."
 S ERRMSG(2)="The incoming message number was "_$S($D(XMZ):XMZ,1:"not present.")
 S ERRMSG(3)="The originator of the message was "_$S($D(XMFROM):XMFROM,1:"not available.")
 S ERRMSG(4)="The message was "_XMRG G SEND
NOMSG ;
 S XMSUB="R/T SERVER HAD NO MESSAGE ON "_A1BFDT
 S ERRMSG(1)="The RTM server sent on "_A1BFDT_" had no data present."
 S ERRMSG(2)="The incoming message number was "_$S($D(XMZ):XMZ,1:"not present")_"."
 S ERRMSG(3)="The originator of the message was "_$S($D(XMFROM):XMFROM,1:"not available")_"." G SEND
NOSITE ;
 S XMSUB="R/T SERVER HAD INVALID SITE NUMBER "_A1BFDT
 S ERRMSG(1)="The RTM server sent on "_A1BFDT_" had invalid site #."
 S ERRMSG(2)="The incoming message number was "_$S($D(XMZ):XMZ,1:"not present")_"."
 S ERRMSG(3)="The originator of the message was "_$S($D(XMFROM):XMFROM,1:"not available")_"." G SEND
SEND ;
 S XMDUZ=.5,XMTEXT="ERRMSG(" F A1BFI=0:0 S A1BFI=$O(^A1BF(11601,1,1,"B",A1BFI)) Q:A1BFI=""  S XMY(A1BFI)=""
 D ^XMD
 K XMSUB,XMTEXT,XMY,XMDUZ,XMFROM,XMREC,XMRG
 Q
NOADD ;Can't add entry for a site
 S XMSUB="R/T SERVER ERROR ON "_A1BFDT
 S ERRMSG(1)="The RTM server failed to add a site entry on "_A1BFDT_"."
 S ERRMSG(2)="The incoming message number was "_$S($D(XMZ):XMZ,1:"not present.")
 S ERRMSG(3)="The originator of the message was "_$S($D(XMFROM):XMFROM,1:"not available.") G SEND
NODATE  ;Can't add entry for a given date
 S XMSUB="R/T SERVER ERROR ON "_A1BFDT
 S ERRMSG(1)="The RTM server failed to add a date entry on "_A1BFDT_"."
 S ERRMSG(2)="The incoming message number was "_$S($D(XMZ):XMZ,1:"not present.")
 S ERRMSG(3)="The originator of the message was "_$S($D(XMFROM):XMFROM,1:"not available.") G SEND
TITLE ;SITE^DATE^AVG. R/T^AVG. USERS^MAX. USERS
