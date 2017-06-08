APUVEX2 ; 648/BFD RENEWAL ROUTINE ; 1-12-04
 ;;5.0; PORTLAND,OR APPLICATION
 ;
 ;  VA Utilities for MAudio Care (renewals) 
 ;  INCLUDES CHANGES TO MAKE NEW VEXRX (BAY PINES) WORK
 ;  
 ; 7-22-06:  Originally APUVEX was one routine but when tried to packman to
 ; Beta sites, found it was over the SACC limit.  Now split into APUVEX1 (one called
 ; from VEXRX) and APUVEX2 (one called from APUVEX1
 ;
 ; 1-16-07:  Changed to APUVEXU, APUVEXN, APUVEXI to handle those parameters.  Leave the msg portion as APUVEX2
 ; 3-9-07: XINDEX indicates rtn too large for SACC stds (it is 16006) - remove portions no longer used (apuvex2 original copy)
 ; 3-9-07: Move msg builds to new rtn APUVEXE.  After run today, remove those subsections from here so pass SACC
 ; 3-27-07:  note this routine calls FM line tags in APUVEXE
 ; 3-27-07:  Delete the FM code from APUVEX2 since now in APUVEXE
 ;
BLD ; 3-27-07:  This line tag called by APUVEX1.  Its purpose is to request to mail message 
 S DRGN=$P(^PSRX(PRESC,0),"^",6),DRGNM=$E($P(^PSDRUG(DRGN,0),"^",1),1,15)
 ; For 'U' or 'N':  Set provider duz and provider name in ROB
 I TYPE="I" S PROVN=$P(^PSRX(PRESC,0),"^",4),PROVNM=$E($P(^VA(200,PROVN,0),"^",1),1,15)
 S PTNM=$P(^DPT(DFN,0),"^",1),PTNM=$E(PTNM,1,10),LST4=$E($P(^DPT(DFN,0),"^",9),6,9)
 I FMSG=2 D FM2^APUVEXE  ; Provider disabled in vista
 I FMSG=1 D FM1^APUVEXE  ; Patient is in Fee Basis file
 I FMSG=0 D FM0^APUVEXE  ; Parameter set for only PCP/MHPCP & Rx not from either
 I FMSG=4 D FM4^APUVEXE      ; Problem w/previous order so can't create new one using it as template - human needed
 I FMSG=3 D FM3^APUVEXE  ; Human intervention since vet called so not communicate w/provider
 I FMSG=5 D FM5^APUVEXE  ; Patient not have PCP/MHPCP and 'P' parameter is set
 I FMSG=6 D FM6^APUVEXE  ; Drug is inactive - send msg to group so can 'handle'
 I FMSG=7 D FM7^APUVEXE  ; The 'placer order' is no longer in 100 so must put on mail msg
 S CNT=CNT+1
 S MAFBFD(CNT)="  "
 S CNT=CNT+1
 Q
 ;
MLMSG ; 3-27-07: Now called by VEXRX when does processing all vet calls (so get 1 message)
 ;5-9-06:  Add N line to meet national standard
 N DIFROM,XMDUZ,XMSUB,XMY,XMTEXT,MSG
 I CNT'>10!MMDAT=0 Q     ; If not >10 then not send any vets to mail msg
 S MAFBFD(1)=""
 S MAFBFD(2)=""
 S MAFBFD(3)="Veteran's Renewal Request Not Sent To Provider"
 S MAFBFD(4)=""
 S MAFBFD(5)=""
 S MAFBFD(6)="                                                  "_"PRESCRIBING"
 S MAFBFD(7)="PATIENT         "_"           "_"DRUG"_"                   "_"PROVIDER"
 S MAFBFD(8)="========================================================================="
 S MAFBFD(9)=" "
 S XMDUZ=.5,XMY(DUZ)=""
 S XMY("G.AUDIORENEWAL")=""
 S XMSUB="VET RENEWAL REQUEST - NEED REVIEW",XMN=0
 S XMTEXT="MAFBFD("
 D ^XMD
 Q
 ;
MMKTR(RFY,NRF) ;
 ; 3-27-07: This called by VEXRX 
 ; This sends msg of kts to 'mgr' mail group
 ; Variables: MAFBKT,PU1,PU0,PN1,PN0,PI1,PI0,AU1,AU0,AN0,AN1,AI0,AI1,NRF,RFY
 ;W !,"Came in to 'count' mail msg portion and RFY = "_RFY_" and NRF is "_NRF
 S MKTR=8
 S MAFBKT(1)=""
 S MAFBKT(2)=""
 S MAFBKT(3)="Count of Refills Processed, Refills Not Processed, and Renewals*"
 S MAFBKT(4)="*(Added to mail message if could not reach provider)"
 S MAFBKT(5)=""
 S MAFBKT(6)="========================================================================="
 S MAFBKT(7)=" "
 I (RFY<1),(NRF<1) G MMCHK
 S MAFBKT(MKTR)="** REFILLS **",MKTR=MKTR+1
 I RFY>0 S MAFBKT(MKTR)="Refills Processed:  "_RFY,MKTR=MKTR+1
 I NRF>0 S MAFBKT(MKTR)="Refills 'Not Processed':  "_NRF,MKTR=MKTR+1
 S MAFBKT(MKTR)="",MKTR=MKTR+1,MAFBKT(MKTR)="",MKTR=MKTR+1
MMCHK ; 3-27-07:  Called from within APUVEX2
 ;  NOTE:  Where ; out variable - it was causing crash.
 I MMCONT'>0 G PCHK
 S MAFBKT(MKTR)="** RENEWALS ON MAIL MESSAGE **",MKTR=MKTR+1
 S:FBKTR>0 MAFBKT(MKTR)="Fee Basis Patient:  "_FBKTR,MKTR=MKTR+1
 S:FBKTRDN>0 MAFBKT(MKTR)="Fee Basis Patient w/Drug Not Allowed Auto Renewal):  "_FBKTRDN,MKTR=MKTR+1
 S:PTERM>0 MAFBKT(MKTR)="Provider's Account Inactive:  "_PTERM,MKTR=MKTR+1
 S:PTERMDN>0 MAFBKT(MKTR)="Provider's Account Inactive (and Drug Not Allowed Auto Renewal):  "_PTERMDN,MKTR=MKTR+1
 S:NPCPADN>0 MAFBKT(MKTR)="Patient not have PCP or MHPCP (and Drug Not Allowed Auto Renewal):  "_NPCPADN,MKTR=MKTR+1
 S:NPCPA>0 MAFBKT(MKTR)="Patient not have PCP or MHPCP assigned:  "_NPCPA,MKTR=MKTR+1
 S:NPCP>0 MAFBKT(MKTR)="Not Patient's PCP or MHPCP: "_NPCP,MKTR=MKTR+1
 S:NPCPDN>0 MAFBKT(MKTR)="Not Patient's PCP or MHPCP (and Drug Not Allowed Auto Renewal):  "_NPCPDN,MKTR=MKTR+1
 S:ORDPDN>0 MAFBKT(MKTR)="Trouble w/Order (and Drug Not Allowed Auto Renewal):  "_ORDPDN,MKTR=MKTR+1
 S:ORDP>0 MAFBKT(MKTR)="Trouble w/Order:  "_ORDP,MKTR=MKTR+1
 S:DINACT>0 MAFBKT(MKTR)="Patient Asked to Renew An Inactive Drug:  "_DINACT,MKTR=MKTR+1
 S:NDINACT>0 MAFBKT(MKTR)="Patient Asked to Renew An Inactive Drug (and Drug 'Not Allowed Auto Renewal'):  "_NDINACT,MKTR=MKTR+1
 S:DISDT>0 MAFBKT(MKTR)="Patient Asked to Renew Rx Whose Prev. Order is No Longer On-File:  "_DISDT,MKTR=MKTR+1
 S:NDISDT>0 MAFBKT(MKTR)="Patient Asked to Renew Rx Whose Prev. Order is No Longer On-File (and Drug 'Not Allowed Auto Renewal'):  "_NDISDT,MKTR=MKTR+1
 S MAFBKT(MKTR)="",MKTR=MKTR+1
PCHK ;3-27-07:  Called from within APUVEX2
 I PCONT'>0 G SMGR
 S:PCONT>0 MAFBKT(MKTR)="** RENEWALS COMMUNICATED TO PROVIDER **",MKTR=MKTR+1
 S:UNSKTR>0 MAFBKT(MKTR)="Unsigned Notification:  "_UNSKTR,MKTR=MKTR+1
 S:INFPKTR>0 MAFBKT(MKTR)="Information Alert:  "_INFPKTR,MKTR=MKTR+1
 ; 3-27-07 REMARK OUT FOLLOWING LINE, I HAVE MESSED UP VARIABLE SOMEWHRE & THIS CRASH
 ;S:INFPDNKT>0 MAFBKT(MKTR)="Unsigned Notification (Drug Not Allowed Auto Renewal):  "_INFPDNKT,MKTR=MKTR+1
 S MAFBKT(MKTR)="",MKTR=MKTR+1
SMGR ;
 ; 3-27-07:  Called from within APUVEX2 
 ; 5-9-06:  Add N line to meet national standard
 N DIFROM,XMDUZ,XMSUB,XMY,XMTEXT,MSG
 I HACT>0!HACTDN>0 S MAFBKT(MKTR)="",MKTR=MKTR+1,MAFBKT(MKTR)="** OTHER **",MKTR=MKTR+1
 S:HACT>0 MAFBKT(MKTR)="Prior Human Interaction Prevents 'Auto' Activity:  "_HACT,MKTR=MKTR+1
 S:HACTDN>0 MAFBKT(MKTR)="Prior Human Interaction Prevents 'Auto' Activity (Drug Not Allow Auto Renewal):  "_HACTDN,MKTR=MKTR+1
 S XMDUZ=.5,XMY(DUZ)=""
 S XMY("G.AUDIOCRMGRS")=""
 S XMSUB="AUDIOCARE 'CALLS'",XMN=0
 S XMTEXT="MAFBKT("
 D ^XMD
 Q
