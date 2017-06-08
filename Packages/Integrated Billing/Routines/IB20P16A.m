IB20P16A ;ALB/RFJ - IB*2.0*167 Post init cont(loop 350 bills) ;28-11-2001
 ;;2.0;INTEGRATED BILLING;**167**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
350 ;  loop bills on hold in 350 and update the rate
 ;
 D MES^XPDUTL("     -> Looping Bills on hold in IB and updating the rate ...")
 ;
 N IBND,IBRATE,IBSTDA,IBTYPE,IBA,IBREF,IBCNT,IBENC,IBOE,DFN,%,IBCHG,IBCHGSAV,IBDUZ,IBEND,IBJOB,IBSTART,IBSEQNO,IBX,IBZSTDA,IBZTYPE,IBSTFILE,IBOE0
 ;
 I '$D(^IB("AC",20)) D MES^XPDUTL(" You have no charges on hold pending a new rate.") Q
 ;
 ;
 ; - if x-ref is locked, the job must be currently running
 L +^IB("AC",20):5 E  S IBA(1)="",IBA(2)="The list of held charges cannot be accessed -- the job to bill these held",IBA(3)="charges may currently be running.",IBA(4)="" D MES^XPDUTL(.IBA) Q
 ;
 S IBJOB=8,IBDUZ=DUZ,IBSEQNO=1,IBCNT=0
 ;
 ; - record start time
 D NOW^%DTC S IBSTART=$$DAT2^IBOUTL(%)
 ;
 S IBREF=0 F  S IBREF=$O(^IB("AC",20,IBREF)) Q:'IBREF  D
 .   ;
 .   S IBND=$G(^IB(IBREF,0)) I 'IBND K ^IB("AC",20,IBREF) Q
 .   ;
 .   ; set up variables
 .   S DFN=$P(IBND,"^",2),IBOE=$P($P(IBND,"^",4),":",2)
 .   ;
 .   ;  check action type = DG OPT COPAY NEW
 .   I $P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^")'="DG OPT COPAY NEW" Q
 .   ;  check resulting from scheduling check out
 .   I $P($P(IBND,"^",4),":")'=409.68,$P($P(IBND,"^",4),":")'=405 Q
 .   ;
 .   ;  check to see if this is a prior to 12/6/01 bill and use old stuff
 .   I $P(IBND,"^",17)<3011206 D OLD Q
 .   ;
 .   ;  is this observation?  if so bill as specialty
 .   I $P($P(IBND,"^",4),":")=405 S IBTYPE=2 D SEND Q
 .   ;
 .   ;  get the data from scheduling file 409.68 to determine stop code
 .   ;  ibstda will be the ien for file 40.7
 .   S IBZSTDA=$P($G(^SCE(+$P($P(IBND,"^",4),":",2),0)),"^",3)
 .   I 'IBZSTDA S IBZSTDA=+$O(^DIC(40.7,"B","LABORATORY",0))
 .   ;
 .   ;  lookup the billable type from 352.5
 .   ;  pass stop code pointer to file 40.7 and event date
 .   S (IBZTYPE,IBTYPE)=$S(IBZSTDA:$$GETTYPE^IBEMTSCU($$STOP(IBZSTDA),$P(IBND,"^",17)),1:0)
 .   ;
 .   ;  set up some variables
 .   S IBDT=$P(IBND,"^",17),IBX="O"
 .   I 'IBZTYPE S (IBCHG,IBCHGSAV)=0
 .   E  D TYPE^IBAUTL2 S IBCHGSAV=IBCHG
 .   ;
 .   ;  look up all encounters for date and check to see if there is some
 .   ;  thing higher to charge
 .   D SEARCH
 .   S IBENC=0 F  S IBENC=$O(IBENC(IBENC)) Q:'IBENC  S IBSTDA=$P($G(^SCE(IBENC,0)),"^",3) I IBSTDA S IBTYPE=$$GETTYPE^IBEMTSCU($$STOP(IBSTDA),IBDT) I IBTYPE D TYPE^IBAUTL2 I IBCHG>IBCHGSAV S IBCHGSAV=IBCHG,IBOE=IBENC
 .   ;
 .   ; set up variables to one to bill (or not)
 .   S (IBEVT,IBOE)=+$S($G(IBOE):IBOE,1:$P($P(IBND,"^",4),":",2))
 .   S IBOE0=$G(^SCE(IBOE,0))
 .   S IBSTDA=$P(IBOE0,"^",3)
 .   S IBTYPE=$S(IBSTDA:$$GETTYPE^IBEMTSCU($$STOP(IBSTDA),IBDT),1:0)
 .   I IBTYPE D TYPE^IBAUTL2
 .   ;
 .   ; check for non-count clinic
 .   I $P($G(^SC(+$P(IBEVT,"^",4),0)),"^",17)="Y" S IBCHG=0
 .   ;
 .   ; check for non-billable appointment type
 .   I $$IGN^IBEFUNC($P(IBOE0,"^",10),$P(+IBOE0,".")) S IBCHG=0
 .   ;
 .   ; if no billable type cancel and quit
 .   I 'IBCHG S DIE="^IB(",DA=IBREF,DR=".05////10;.1////"_(+$O(^IBE(350.3,"B","BILLED AT HIGHER TIER RATE",0))) D ^DIE Q
 .   ;
 .   ; update encounter info if needed
 .   I IBOE'=$P($P(IBND,"^",4),":",2) S $P(^IB(IBREF,0),"^",4)="409.68:"_IBOE
 .   ;
 .   ; set the stop code in file 350 $p 20
 .   S IBSTFILE=$$GETSC^IBEMTSCU("409.68:"_IBOE,$P(IBND,"^",17)) I IBSTFILE S $P(^IB(IBREF,0),"^",20)=IBSTFILE
 .   ;
 .   ; send off to complete billing
 .   D SEND
 .   ;
 .   ;
 ;
 ;
 ; - unlock x-ref, record end time, and post bulletin
 L -^IB("AC",20)
 D NOW^%DTC S IBEND=$$DAT2^IBOUTL(%)
 D BULL^IBEMTO1
 ;
 S IBA(1)="",IBA(2)="  --> "_IBCNT_" Entries processed with new billing rates",IBA(3)="" D MES^XPDUTL(.IBA)
 ;
 Q
 ;
OLD ; performs edit, checks on old bills (prior to 12/6/01)
 I '$$OLDCHKS D SEARCH,ANOTHER Q
 S IBTYPE=1 D SEND
 Q
 ;
SEARCH ; will look up all encounters for a date and try to find one that
 ; is billable, if so, I will bill
 ;
 N IBVAL,IBFILTER,IBOE,IBCBK K IBENC
 ;
 ; set up variables
 S IBVAL("DFN")=+$P(IBND,"^",2),IBFILTER=""
 ;
 ; check for non-count clinic, appt type included and children before set
 S IBCBK="I $P($G(^SC(+$P(Y0,U,4),0)),U,17)'=""Y"",'$$IGN^IBEFUNC($P(Y0,U,10),$P(+Y0,""."")),'$P(Y0,U,6) S IBENC(Y)=Y0"
 ;
 S IBVAL("BDT")=$P(IBND,"^",17),IBVAL("EDT")=$P(IBND,"^",17)_".999999"
 ;
 ; look for other visits
 D SCAN^IBSDU("PATIENT/DATE",.IBVAL,IBFILTER,IBCBK,1)
 ;
 Q
ANOTHER ; check out the other visits
 N DA,DIE,DR,X,Y
 ;
 S IBOE=0 F  S IBOE=$O(IBENC(IBOE)) Q:IBOE<1!($$OLDCHKS)
 ;
 ; either cancel or update the charge if something found
 I IBOE S $P(^IB(IBREF,0),"^",4)="409.68:"_IBOE,IBTYPE=1 D SEND Q
 S DA=IBREF,DIE="^IB("
 S DR=".05////10;.1////"_(+$O(^IBE(350.3,"B","BILLED AT HIGHER TIER RATE",0)))
 D ^DIE
 ;
 Q
 ;
SEND ; sends bills off to be billed
 ;
 N IBNOS
 D MES^XPDUTL("      Now billing 350 ref. # "_+IBND)
 ;
 ;  set up billing paramaters needed
 S IBDT=$P(IBND,"^",17),IBX="O" D TYPE^IBAUTL2
 ;
 ;  update the billing rate in 350
 S $P(^IB(IBREF,0),"^",7)=IBCHG,IBSEQNO=1,DFN=+$P(IBND,"^",2)
 ;
 ; now lets bill
 S IBNOS=IBREF D ^IBR S:Y>0 IBCNT=IBCNT+1
 ;
 Q
 ;
OLDCHKS() ; set up the variables to perform the OLD checks
 ; assumes IBOE is the outpatient encounter IEN
 N IBEVT,IBAPTY,IBDAT,IBDT,IBORG,IBDISP
 S IBEVT=$G(^SCE(+IBOE,0)) I 'IBEVT Q 0
 S IBAPTY=$P(IBEVT,"^",10)
 S IBDAT=$P(+IBEVT,".")
 S IBDT=+IBEVT
 S IBORG=$P(IBEVT,"^",8)
 S:IBORG=3 IBDISP=$P($$DISND^IBSDU(IBEVT),"^",7)
 Q $$CHKS^IBAMTS1
 ;
STOP(X) ; returns the stop code number from file 40.7
 Q $P($G(^DIC(40.7,+$G(X),0)),"^",2)
 ;
