SD53128A ;ALB/JRP - POST INIT MODULES FOR PATCH 128;24-JUL-97
 ;;5.3;Scheduling;**128**;AUG 13, 1993
 ;
SEEDHIST(BEGDATE) ;Seed ACRP Transmission History file (#409.77) with
 ; information currently contained in Transmitted Outpatient Encounter
 ; file (#409.73)
 ;
 ;Input  : BEGDATE - Transmission date to begin seeding from
 ;                 - FileMan format
 ;                 - Defaults to 1-Oct-1996 (OPC to ACRP cut-over date)
 ;Output : COUNT - Number of entries created
 ;Notes  : An entry in the history file will not be created if a
 ;         transmission date, message ID, and batch ID are not on file
 ;         (they're required info in the history file)
 ;       : If an acknowledgement date is on file and an acknowledgement
 ;         code is not, an acknowledgement code of 'E' (error) will be
 ;         used
 ;       : Acknowledgement data will not be stored if an acknowledgement
 ;         data is not on file
 ;
 ;Check input
 S BEGDATE=+$P($G(BEGDATE),".",1)
 S:(BEGDATE<2961001) BEGDATE=2961001
 ;Declare variables
 N XMITPTR,XMITDATE,MSGID,BTCHID,ACKDATE,ACKCODE
 N NODE,HISTPTR,XPDIDTOT,COUNT
 ;Get rough estimate for total number of entries in transmission file
 S XPDIDTOT=+$O(^SD(409.73,"A"),-1)
 ;Initialize counter
 S COUNT=0
 ;Use 'AACLST' x-ref to loop through transmission file
 S XMITDATE=$$FMADD^XLFDT(BEGDATE,-1)+.999999
 F  S XMITDATE=+$O(^SD(409.73,"AACLST",XMITDATE)) Q:('XMITDATE)  D
 .S XMITPTR=0
 .F  S XMITPTR=+$O(^SD(409.73,"AACLST",XMITDATE,XMITPTR)) Q:('XMITPTR)  D
 ..;Get node containing xmit/ack data
 ..S NODE=$G(^SD(409.73,XMITPTR,1))
 ..;Get Message ID
 ..S MSGID=$P(NODE,"^",2)
 ..;Don't have last Message ID - quit
 ..Q:(MSGID="")
 ..;Get Batch ID
 ..S BTCHID=$P(NODE,"^",3)
 ..;Don't have last Batch ID - quit
 ..Q:(BTCHID="")
 ..;Get last ack date
 ..S ACKDATE=$P(NODE,"^",4)
 ..;Get last ack code
 ..S ACKCODE=$P(NODE,"^",5)
 ..;Convert ack code to E (error) if not on file and have an ack date
 ..I (ACKDATE) S:(ACKCODE="") ACKCODE="E"
 ..;Create entry in history file
 ..S HISTPTR=$$CRTHIST^SCDXFU10(XMITPTR,XMITDATE,MSGID,BTCHID)
 ..Q:(HISTPTR<0)
 ..;If acked, store acknowledgement info
 ..D:(ACKDATE) ACKHIST^SCDXFU10(HISTPTR,ACKDATE,ACKCODE)
 ..;Increment counter
 ..S COUNT=COUNT+1
 ..;If KIDS install, show progress through status bar
 ..I (COUNT#100) D:($G(XPDNM)'="") UPDATE^XPDID(COUNT)
 ;If KIDS install, show completion in status bar
 D:($G(XPDNM)'="") UPDATE^XPDID(XPDIDTOT)
 ;Done - return number of entries created
 Q COUNT
