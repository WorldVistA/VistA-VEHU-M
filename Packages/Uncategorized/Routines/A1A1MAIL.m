A1A1MAIL ;ALB/CAW,PKE - Prescription Practices Extract ;3/31/95 [ 02/20/96  2:25 PM ]
 ;;1.2;Prescription Practices Extract;;MAY 1,1996
MAIL ; Set up header and send mail message
 ;
 N LOOP
 S LOOP=0 F  S LOOP=$O(^TMP("A1RXEXT",$J,LOOP)) Q:'LOOP  D
 .S XMSUB="PRESCRIBING PRACTICES DATA-MSG#"_$J(LOOP,2)
 .S XMN=0,XMTEXT="^TMP(""A1RXEXT"","_$J_","_LOOP_","
 .S XMDUZ=.5
 .S XMY(DUZ)=""
 .S XMY("XXX@Q-OIG.VA.GOV")=""
 .D ^XMD
 .K XMDUZ,XMN,XMSUB,XMTEXT,XMY
 ;
 N LOOP,CNT
 S LOOP=0 F  S LOOP=$O(^TMP("A1RXPROV",$J,LOOP)) Q:'LOOP  D
 .S CNT=$G(CNT)+1
 .S XMSUB="PRESCRIBING PRACTICES PROV-MSG#"_$J(CNT,2)
 .S XMN=0,XMTEXT="^TMP(""A1RXPROV"","_$J_","_LOOP_","
 .S XMDUZ=.5
 .S XMY(DUZ)=""
 .S XMY("XXX@Q-OIG.VA.GOV")=""
 .D ^XMD
 .K XMDUZ,XMN,XMSUB,XMTEXT,XMY
 ;
 S Y=A1FRST D DD^%DT
 S TEXT(1)=" "
 S TEXT(2)="The date for the first prescription found was "_Y_"."
 S TEXT(3)=" "
 S XMSUB="FIRST DATE FOR SITE: "_$P($G(^DG(40.8,+$$PRIM^VASITE(DT),0)),U)
 S XMN=0,XMTEXT="TEXT("
 S XMDUZ=.5
 S XMY(DUZ)=""
 S XMY("XXX@Q-OIG.VA.GOV")=""
 D ^XMD
 K A1FRST,XMDUZ,XMN,XMSUB,XMTEXT,XMY,TEXT
 ;
END ; send status message to user
 ;
 D NOW^%DTC S Y=% D DD^%DT S A1END=Y K %,Y
 S TEXT(1)="The Prescription Practices data extract has successfully completed."
 S TEXT(2)=" "
 S TEXT(3)="        Start Time: "_A1BEG
 S TEXT(4)="          End Time: "_A1END
 S TEXT(5)=" "
 S TEXT(6)="Number of messages:"
 S TEXT(7)="     Prescriptions: "_A1RXMM
 S TEXT(8)="         Providers: "_A1MSG
 S TEXT(9)=" "
 S TEXT(10)="You may now delete routines A1A1* from your systems. Thank you."
BULL S XMTEXT="TEXT(",XMSUB="Prescription Practices Extract"
 S XMDUZ=.5,XMY(DUZ)=""
 D ^XMD
 K XMTEXT,TEXT,XMSUB,XMDUZ,XMY
 Q
