DGYCEN ;MTC/ALB - Identify Census Record that should have a <601>; 10-25-92
 ;;5.2;REGISTRATION;**16**;JUL 29,1992
 ;
EN ;-- entry point
 N DGCEN,DGREC
 W !,">>> Searching for Census Records that need to be re-transmitted."
 D HOME^%ZIS
 S DGCEN=$O(^DG(45.86,"B",2920930,0))
 I DGCEN D LOOP,MSG
 Q
LOOP ;-- loop thru 'ACENSUS' x-ref
 N I,PTF,DGCI,DGCSUF,D0
 S (I,D0)=0 F  S D0=$O(^DG(45.85,"ACENSUS",DGCEN,D0)) Q:'D0  D
 . D FIND^DGPTCO1 Q:X'=3
 . S DGCSUF=$P($G(^DGPT(+DGCI,0)),U,5)
 . I ((DGCSUF="9AA")!(DGCSUF="BU")),$D(^DGPT(+PTF,"P")) D
 .. S I=I+1,DGREC(I)=" Re-open Census record #"_DGCI_" - Patient :"_$P($G(^DPT($P(^DGPT(+PTF,0),U),0)),U)
 I 'I S DGREC(1)="No Census Records need to be re-opened."
 Q
 ;
MSG ;-- generate mailman message containing the Census Records to re-open
 W !!,">>> Sending MailMan message."
 S XMDUZ=.5,XMY(DUZ)="",XMY(.5)="",XMY("CANAVAN@ISC-ALBANY.VA.GOV")="",XMTEXT="DGREC(",XMSUB="Census Records that should be re-opened."
 D ^XMD
 K XMY,XMTEXT,XMSUB,XMDUZ
 Q
