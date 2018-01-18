A1A1OIG1 ;ALB/MLI,MAF - OIG Request for C&P Audit Information :Mail messages ; 15 Jun 94
 ;;Version 2.0
MAIL ; send message to OIG
 ;
 I A1A1CNT=0 Q  ; no inpatients on date
 F A1A1I=0:0 S A1A1I=$O(^TMP("A1A1OIG",$J,"TXT",A1A1I)) Q:'A1A1I  D
 .S XMSUB="OIG REQUEST FROM SITE "_A1A1SITE_" MESSAGE #"_A1A1I_" OF "_A1A1MSG
 .S XMTEXT="^TMP(""A1A1OIG"","_$J_",""TXT"","_A1A1I_",",XMDUZ=.5,XMY(DUZ)=""
 .S XMY("XXX@Q-OIG.VA.GOV")=""
 .D ^XMD
 .K XMDUZ,XMN,XMSUB,XMTEXT,XMY
 ;
 ; send status message to user
 ;
 D NOW^%DTC S A1A1END=%
 S X=$$DATE^A1A1OIG(A1A1ADT) S X=$E(X,1,2)_"/"_$E(X,3,4)_"/"_$E(X,7,8)
 S A1A1TEXT(1)="The OIG inpatient data request has successfully completed for "_X
 S A1A1TEXT(2)=" "
 S A1A1TEXT(3)="Start Time:                   "_A1A1BEG
 S A1A1TEXT(4)="End Time:                     "_A1A1END
 S A1A1TEXT(5)="Number of Transmissions:      "_A1A1CNT
 S A1A1TEXT(6)=" "
 I A1A1X=3 S A1A1TEXT(7)="You may now delete routines A1A1OIG & A1A1OIG1 from your systems. Thank you."
BULL S XMTEXT="A1A1TEXT(",XMSUB="OIG REPORT RUN AT STATION "_A1A1SITE
 S XMDUZ=.5,XMY(DUZ)=""
 D ^XMD
 K XMTEXT,A1A1TEXT,XMSUB,XMDUZ,XMY
 Q
 ;
 ;
