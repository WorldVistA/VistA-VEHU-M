APUVEX1 ; 648/BFD RENEWAL ROUTINE ; 1-12-04
 ;;5.0; PORTLAND,OR APPLICATION
 ;
 ;  VA Utilities for MAudio Care (renewals) 
 ;  INCLUDES CHANGES TO MAKE NEW VEXRX (BAY PINES) WORK
 ;  
 ; 7-22-06:  Originally APUVEX was one routine but when tried to packman to
 ; Beta sites, found it was over the SACC limit.  Now split into APUVEX1 (one called
 ; from VEXRX) and APUVEX2 (one called from APUVEX1)
 ; 
 ; 1-16-07:  Change APUVEX2 to APUVEXN, APUVEXU, APUVEXI to be called based on parameter
 ;  Leave APUVEX2 for message
 ;
 ; 1-16-07:  Remark out the MHPCP call because Portland no longer using that feature
 ;
RENEWAL(PAT,PRESC,TYPE,PROVP,USR,GCNT,RESULT1) ;
 ;U___________Unsigned order
 ;I___________Info alert - Request passed drug file renewal chk & clinic
 ;N___________Info alert - Drug in request is marked not allow renewals in drug file (50)
 ;
 ; JB had XQA but BFD add X or else the date conversions cause trouble in VEXRX
 N XQA,X
BFD ;
 ;  BFD/LOCAL 2-04 since only sending to PCP/MHPCP, not chk if fee 
 ;  BFD/LOCAL 3-8-04 add code to chk MH PCP
 ;  BFD/LOCAL 3-9-04 For testing unsigned pgm, DO NOT chk if RX by PCP or MHPCP
 ;                   After verify all working, then add that check
 ;  BFD/LOCAL 3-12-04 Start adding in PCP/MHPCP chks & changing code to quit if not one or the other     
 ;  BFD/LOCAL 3-15-04 Info & Unsigned went thru to myself & Rob.  Send to Dr. Douglas for ok
 ;  BFD/LOCAL 4-28-04  Per discussion w/AudioCare (they had not set parameter for sites to indicate U or I)
 ;                    If drug not renewable, they will send code so send info alert to provider
 ;                    They have to decide what codes to send if site chose Unsigned or Info.  
 ;                    I will change programming as appropriate once get their set of codes
 ;  BFD/LOCAL 5-3-04  AudioCare adding site choice.  Codes will be:
 ;                    N:  Drug not renewable (send info alert to provider w/that message
 ;                    I:  Site chose Info Alert & drug renewable
 ;                    U:  Site chose Unsigned Order & drug renewable
 ; BFD 6-2-04:  REMOVE PCP/MHPCP CHK FOR AUDIOCARE TESTING SINCE NOT ENOUGH TEST PT W/PCP THAT I CAN SEE
 ;              Off-and-on during testing would place back check and remove 
 ;              
 ; BFD 6-24-04:  AudioCare agreed to my parameter requests so need to add following VEXHRX piece chks to program
 ;                           Piece 7 - if site uses U, the DUZ of generic AudioCare user for unsigned
 ;                           Piece 8 - indicate if site will accept RX from any provider or limit to PCP/MHPCP
 ;                                      (A - All    P - PCP/MHPCP only)
 ;                           
 ;                           Since found out that VEXHRX global removed almost immediately after run VEXRX, I will add mail
 ;                           message build into this program.  All sites must use same mail group - (still have to create)
 ;                           
 ; BFD 6-28-04:  Add code to deal with provider = all
 ; BFD 7-5-04:  Mail message not work - does one per vet (fixed in July)
 ; BFD 8-04:  Add new mail msg and chg RESULT to RESULT1 so not conflict
 ; BFD 8-29-04:  Added 0 back from Rob's program - placer order not have window or mail
 ; BFD 9-2-04:  Rob fixed his program so will 'stuff' mail.  Left 0 result in case need for other reason but generic msg
 ; BFD 9-8-04:  If Rx status is not 0 (active) or 11 (exp) then send 0 and Q (human activity since vet call)
 ;              If 'human' order has been entered since vet called, Rob's pgm sends 2. 
 ;              I send 0 to VEXHRX but not put on msg & not send to provider
 ; BFD 9-14-04:  Change Q if not PCP to Rob because of surrogates
 ; BFD 11-23-04:  Finish testing of changes made to handle surrogates when 'P' set.  Will go live
 ;               with this and test changes to handle surrogates when 'A' set.  Then, after that goes live,
 ;               will work on testing changes to handle surrogates when site chooses I instead of U.
 ; 
 ; BFD 11-29-04:  Vet requested renewal on Rx whose placer order is no longer in 100.  Add FMSG=7 check
 ; BFD 2-14-05:  Add new fld to find out DEA field so can adjust 'N' message for unsigned until can chg to I
 ; BFD 5-8-06:  Must code around the local MHPCP fields.  Add N DIFROM to XMD sections (patch XM*8*32)
 ; BFD 7-22-06 & 1-17-07:  Changes noted at top of routine
 ;
 ; NOTE:  setting of ktrs and killing of ktrs is done in VEXRX or else zero out every time come from VEXHRX 
 ;
 ;W !!,"In APUVEX1"
 S RESULT1=0,VRX=0,DRGNM=0,DRGN=0,PTNM=0,PROVNM=0,PROVN=0,LST4=0,FMSG=0,TERMD=0,DISD=0,RXSTAT=0,STFLG=0
 S RPCP=0,RMHPCP=0,PLCOR=0
 S DFN=PAT
 I GCNT=10 S CNT=10
 ;
 S RXSTAT=$G(^PSRX(PRESC,"STA"))
 ;W !,"RX ien is PRESC "_PRESC_" and that is RX number "_$P(^PSRX(PRESC,0),"^",1)
 I (RXSTAT'=0)&(RXSTAT'=11) S FMSG=3,RESULT1=0 D BLD^APUVEX2 G QUIT
 ;
 S DRGN=$P(^PSRX(PRESC,0),"^",6) ;W !,"Just drug ien to "_DRGN
 S DRGINACT=$G(^PSDRUG(DRGN,"I"))        ;W !,"Just checked if inactive & DRGINACT is "_DRGINACT
 ; 1st $P of 'OR1' is pharmacy orderable item and 2nd $P is placer order.  Placer is need to communicate auto w/provider
 I DRGINACT'="" S FMSG=6,RESULT1=0 D BLD^APUVEX2 G QUIT
 I $G(^PSRX(PRESC,"OR1"))']"" S FMSG=7,RESULT1=0 D BLD^APUVEX2 G QUIT
 I $P($G(^PSRX(PRESC,"OR1")),"^",2)']"" S FMSG=7,RESULT1=0 D BLD^APUVEX2 G QUIT
 S PLCOR=$P(^PSRX(PRESC,"OR1"),"^",2) I $G(^OR(100,PLCOR,0))']"" S FMSG=7,RESULT1=0 D BLD^APUVEX2 G QUIT
 ; BFD/648 1-29-07:  When comparing A to P, found that an RX w/A, stopped with fee but a P went through.  Change them so both stop if fee
 ; BFD/648 1-29-07:  change the call from APUVEX2 to APUVEXU because working on that routine
 ; BFD/648 3-5-07:  Add 'i provp='a' below because ton of 'fee basis' warning showing up for PCP.  If provider siging order is PCP, should not be
 ;
 I PROVP="A" D FEE I RESULT1'=0 S FMSG=1,RESULT1=0 D BLD^APUVEX2 G QUIT
 ;
 ;W !,"Getting ready check if provp = 'a'"
 I PROVP="A" G ALLP
 ;
 ; note for BFD - following only if PROVP='P'
 D PCMM
 ; BFD/648 1-16-07  Portland no longer using MHPCP field so change Portland to match other sites
 ; Allows Portland to check if local field for MH PCP is populated
 I PSOINST=648 S PMHCP=1
 ;I PSOINST=648 D PMHCP
 ; set to 1 or thinks problem (missing or bad) at non-Portland sites
 I PSOINST'=648 S PMHCP=1
 ;W !!,"In APTVEX and just did PCMM and PMHCP"
 ;W !,?5,"PCP is "_PCP
 ;W !,?5,"PMHCP is "_PMHCP
 ;W !,?5,"+PCP is "_+PCP
 ;W !,?5,"+PMHCP is "_+PMHCP
 ;
 I +PCP<1,+PMHCP<1 S RESULT1=0,FMSG=5 D BLD^APUVEX2 G QUIT
 S RPCP=+PCP,RMHPCP=+PMHCP
 ;
 ;       
 ;   PCPN  -   This is always 1
 ;  +PCP   -   Returns 0 or DUZ
 ;  +PMHCP -   Returns 0 or DUZ
 ;
 ;
ALLP ;
 ; Change FMSG ktrs to BLD^APUVEX2 - not need all of the 'ktr' flags that used before 
 ;
 ;I PROVP="A" D FEE I RESULT1'=0 S FMSG=1,RESULT1=0 D BLD^APUVEX2 G QUIT
 ;W !,"In ALLP and type = "_TYPE
 I TYPE["U" D ROB^APUVEXU     ; site wants send unsigned notifications
 I TYPE["N" D NALERT^APUVEXN       ; DEA handling contains W or 2 (sent unsigned but kt as non-renewable)
 I TYPE["I" D IALERT^APUVEXN     ; site wants info alerts
 ;
 ; 
 ; If reach here then result=1 and communicated with provider
 ;
QUIT ; Clear variables
 ;W !!,"At QUIT^APUVEX1"
 K PROV,PCP,PMHCP,PAT,VRX,DRGNM,DRGN,PTNM,PROVNM,PROVN,LST4,FMSG,TERMD,DISD,RXSTAT,STFLG
 K RPCP,RMHPCP,DEA4N,VRXN
 Q
 ;
FEE ;Check for fee issue date '> today, end date '< today (jeb code)
 N FEE,ISD
 S ISD=0 F  S ISD=$O(^FBAAA(DFN,1,ISD)) Q:'+ISD  S FEE=$$DC($P(^FBAAA(DFN,1,ISD,0),"^",2)) Q:FEE>0
 S RESULT1=$S($G(FEE)>0:1_"F",1:0)
 ;W !,">>>> Bottom of  FEE^APUVEX1 and RESULT1 is "_RESULT
 Q
DC(EDATE) ; This was Jim's code & not sure what does
 S X1=EDATE,X2=DT D ^%DTC
 Q $S(X<0:0,1:X)
 ;
 ; Following 3 sections of code is copied from one of John Thomas' programs
PCMM ; GET PCP FROM PCMM FILE
 N APTL
 S TARGET="ARRAY"
 K ^TMP("SC",$J),TEAM,APTL,PCP,@TARGET
 S APTL=0
 S PCPN=$$GETALL^SCAPMCA(DFN,"","")
 Q:'PCPN  ;not found
 I $G(^TMP("SC",$J,DFN,"PCAP",1)) S PCP=^(1)
 E  S PCP=$G(^TMP("SC",$J,DFN,"PCPR",1))
 S PAGER=$G(^VA(200,+PCP,.13))
 S VALMPCP(1)=$P(PCP,"^")_"^"_$$NAMEFMT^XLFNAME1($P(PCP,"^",2),"G","DM")_"^"_$S($L($P(PAGER,"^",7)):$P(PAGER,"^",7),1:$P(PAGER,"^",8))_"^"
 S $P(VALMPCP(1),"^",2)=$$LNF($P(VALMPCP(1),"^",2))
 ;S $P(VALMPCP(1),"^",2)=$P(VALMPCP(1),"^",2)_", "_$P($P($G(^VA(200,+PCP,20)),"^",3),",")
 ; commented out line above, 12/27/00 JEB
 S VALMPCP(2)=$P(PCP,"^",3,4)
 Q
 ;
PMHCP ;From local source/ PCMM does not do...
 ; BFD/648 1-16-07 no longer used at Portland
 ; BFD 5-9-06  this is a Portland local field so must program around
 S PMHCP=$P($G(^DPT(DFN,648001)),"^",6)
 Q:PMHCP=""  ;jit/jeb
 S PAGER=$G(^VA(200,+PMHCP,.13))
 S VALMPCP(5)=PMHCP_"^"_$$NAMEFMT^XLFNAME1($P(^VA(200,PMHCP,0),"^"),"G","DM")_"^"_$S($L($P(PAGER,"^",7)):$P(PAGER,"^",7),1:$P(PAGER,"^",8))
 S $P(VALMPCP(5),"^",2)=$$LNF($P(VALMPCP(5),"^",2))
 ; COMMENTED OUT LINE BELOW, JIT 2-25-04, TITLE NOT NEEDED
 ; S $P(VALMPCP(5),"^",2)=$P(VALMPCP(5),"^",2)_", "_$P($P($G(^VA(200,+PMHCP,20)),"^",3),",")
 Q
 ;
LNF(X) ;
 N I,NAME
 F I=1,2,3 S NAME(I)=$P(X," ",I)
 I NAME(3)="" S NAME(3)=NAME(2)
 Q $E(NAME(1))_". "_NAME(3)
