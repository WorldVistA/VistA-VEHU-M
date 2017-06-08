APUVEXU  ; 648/BFD RENEWAL ROUTINE CALLED IF U PARAMETER ; 1-12-04
 ;;5.0; PORTLAND,OR APPLICATION
         ;
         ; VA Utilities for MAudio Care (renewals) 
         ;  INCLUDES CHANGES TO MAKE NEW VEXRX (BAY PINES) WORK
         ;  
         ; 7-22-06:  Originally APUVEX was one routine but when tried to packman to
         ; Beta sites, found it was over the SACC limit.  Now split into APUVEX1 (one called
         ; from VEXRX) and APUVEX2 (one called from APUVEX1
         ;
         ; 1-16-07:  Change from APUVEX2 to APUVEXU to document this is the unsigned notification routine
         ;
         ; 3-27-07:  Called by APUVEX1
ROB      ;  Use program written by Rob Felder/Portland
         ;  Parameter set 'U' Send unsigned notification 
         ;  Rob needs old order number (placer field in 52) in order to create new
         ;  Also send drug, PCP ien, MHPCP ien, if 'A' or 'P', generic user IEN
         ;  
         ;  9-14-04 Rob is adding chks for provider on order (so can catch surrogate) so
         ;  don't worry if 'A' or 'P' and don't worry about term/disuse
         ;  
         ; Rob sends back (5 possible results as of 9-14-04): 
         ;     0:Problem w/prev order using as template; 
         ;     1:Communicated w/provider; 
         ;     2:Rx stat no longer exp/act ! been renewed since vet call so not process
         ;     3:Not from PCP/MHPCP; 
         ;     5:Provider terminated
         ;W !!,"Came to ROB^APUVEXU"  
         S PROV=0,DEA4N=0,VRXN=0
         S VRXN=$P(^PSRX(PRESC,0),"^",6),VRX=$P(^PSDRUG(VRXN,0),"^",1),DEA4N=$P(^PSDRUG(VRXN,0),"^",6)
         S ORDERNO=$P(^PSRX(PRESC,"OR1"),"^",2)
         I ORDERNO'>"" S RESULT1=0,FMSG=0 D BLD Q
         N X D RENEW^APUFSMED(.OK,ORDERNO,VRX,USR,RPCP,RMHPCP,PROVP,DEA4N,TYPE)
         ;W !!,"Came back from Rob's and Ok is "_OK
         ; With new signature code checks, found Rob sending back result^DUZ so $P out
         I OK["^" S PROVN=$P(OK,"^",2),PROVNM=$E($P(^VA(200,PROVN,0),"^",1),1,15),OK=$P(OK,"^",1)
         ;W !,"OK is now "_OK
         S RESULT1=OK
         ;W !,"AT ROB+24 (or so ) and RESULT1 is "_RESULT1
         ;W !,"**** next line of code checks if 0, 2, 3, 5 and then 0 out result 1---where is prov talk to set? "
         ;
         I RESULT1=0 S FMSG=4,RESULT1=0 D BLD Q   ; some kind of problem w/order using as template
         I RESULT1=2 S FMSG=3,RESULT1=0 D BLD Q      ; so tell AudioCare not 'talk' to provider
         I RESULT1=3 S FMSG=0,RESULT1=0 D BLD Q   ; "P" parameter & order not from PCP/MHPCP
         I RESULT1=5 S FMSG=2,RESULT1=0 D BLD Q   ; Provider(s) on order terminated - no one to send order to
         ;
         ; If reach this point them communicated with provider so kt if U or N
         ; 
         I TYPE["U" S UNSKTR=UNSKTR+1,PCONT=1
         Q
         ;
BLD      ; 3-27-07:  Called from within APUVEXU.  Code adds request to mail message 
         ;
         ;W !!,"Came to BLD^APUVEXU.  Do I have info as to A or P (PROVP)  "_PROVP
         ;W !,"***** LOOK TO SEE APUSEND IN RESULT ----- FMSG is "_FMSG_" and Result passing back is "_RESULT1
         S DRGN=$P(^PSRX(PRESC,0),"^",6),DRGNM=$E($P(^PSDRUG(DRGN,0),"^",1),1,15)
         ; For 'U' or 'N':  Set provider duz and provider name in ROB
         ; BFD/648 1-29-07 THERE SHOULD BE NO TYPE I IN THIS CODE- SEPARATED OUT SO ; NEXT LINE
         ;I TYPE="I" S PROVN=$P(^PSRX(PRESC,0),"^",4),PROVNM=$E($P(^VA(200,PROVN,0),"^",1),1,15)
         S PTNM=$P(^DPT(DFN,0),"^",1),PTNM=$E(PTNM,1,10),LST4=$E($P(^DPT(DFN,0),"^",9),6,9)
         ;W !!!,"****NEXT SERIES CHKS FMSG=2,1,0,4,3,5,6,7 AND THEN D APPROPRIATE FM#"
         I FMSG=2 D FM2^APUVEXE  ; Provider disabled in vista
         I FMSG=1 D FM1^APUVEXE  ; Patient is in Fee Basis file
         I FMSG=0 D FM0^APUVEXE  ; Parameter set for only PCP/MHPCP & Rx not from either
         I FMSG=4 D FM4^APUVEXE      ; Problem w/previous order so can't create new one using it as template - human needed
         I FMSG=3 D FM3^APUVEXE  ; Human intervention since vet called so not communicate w/provider
         I FMSG=5 D FM5^APUVEXE  ; Patient not have PCP/MHPCP and 'P' parameter is set
         I FMSG=6 D FM6^APUVEXE  ; Drug is inactive - send msg to group so can 'handle'
         I FMSG=7 D FM7^APUVEXE  ; The 'placer order' is no longer in 100 so must put on  mail msg
         S CNT=CNT+1
         S MAFBFD(CNT)="  "
         S CNT=CNT+1
         ;W !,"At bottom of BLD and CNT is "_CNT
         Q
