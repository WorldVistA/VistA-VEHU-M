MLIAPPT ;SLC/MLI - Convert orders for patients w/appointments - 10/31/98
 ;;1.0
 ;
 ; This routine will run through patients left to convert and convert
 ; them on the fly if they have an appointment in the next few days.
 ;
 ; Call from top to queue process to run or ENQ to run in direct mode
 ; to watch progress.  If you run in direct mode, make sure you have a
 ; separate terminal or emulator session running.
 ;
EN ; call to setup queuing
 S ZTDESC="Convert orders for patients w/appointments"
 S ZTIO="",ZTRTN="ENQ^MLIAPPT"
 D ^%ZTLOAD
 W !!,$S($G(ZTSK):"Queued as task: "_ZTSK,1:"Aborted")
 K ZTSK,ZTDESC,ZTIO,ZTRTN
 Q
 ;
ENQ ; run through patients left to see if they have an appt next week
 S (DFN,COUNT)=0
 F  S DFN=$O(^ORD(100.99,1,"PTCONV",DFN)) Q:'DFN  D
 .  S X=$O(^DPT(DFN,"S",2981108)) I X>2981114 Q
 .  S COUNT=COUNT+1,X=$$OTF^OR3CONV(DFN,1)
 .  I $G(ZTQUEUED) Q
 .  I '(COUNT#50) W "."
 .  I '(COUNT#500) W !,DFN
 I $G(ZTQUEUED) W !!,"Done!  Orders converted for ",COUNT," patients"
 D MAIL
 Q
 ;
MAIL ; mail message when done
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 S ORTEXT(1)="The job to convert orders for patients with appointments"
 S ORTEXT(2)="in the next week has completed"
 S ORTEXT(3)=" "
 S ORTEXT(4)="It ran to completion on "_$$FMTE^XLFDT($$NOW^XLFDT)
 S ORTEXT(5)="It converted orders for "_COUNT_" patients"
 S XMSUB="Conversion of patients w/appts",XMTEXT="ORTEXT("
 S XMDUZ="OE/RR CONVERSION"
 F I="INSLEY,MARCIA@ISC-SLC",DUZ S XMY(I)=""
 D ^XMD
 Q
