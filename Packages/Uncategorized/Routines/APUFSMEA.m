APUFSMEA ;648/BFD CHKS OK FOR RENEWAL REQUEST TO PROVIDER (ALL PARAMETER) ; 3-27-07
 ;;5.0; PORTLAND,OR APPLICATION
 ;
 ;  VA Utilities for MAudio Care (renewals) 
 ;  INCLUDES CHANGES TO MAKE NEW VEXRX (BAY PINES) WORK
 ;  
 ; called by APUFSMED so it can create Unsigned Notification  
 ;  3-27-07: APUFSMED exceed size limits so split out PCP checks & All provider checks into own rtns
 ;
 ; Following line is my reminder of code that was originally in APUFSMED  
 ;  
 ; I C="A" D ALLIMIT2 I RESULT'=1 G HEYQ
 ;
 ; BFD Notes:  
 ; Provider is piece 3 of node three in 100   (APUPROV)
 ; Signed by is piece 5 of node three in 100  (APUPSIG)
 ; 
 ; General logic if 'provider' and 'signed by' different:  'Provider' is the person communicate with
 ; Also, If 'written on chart,' 'provider' is only field of the two that is populated
 ; 
 ;
 ;Send back results:
 ; RESULT=0  some kind of problem w/order using as template
 ; RESULT=2  status indicates 'human intervention' so tell AudioCare not 'talk' to provider
 ; RESULT=3  "P" parameter & order not from PCP/MHPCP
 ; RESULT=5  Provider(s) on order terminated - no one to send order to
 ;
 ; Note:  3-27-07:  CHKPRO called from within APUFSMEA
CHKPRO(DUZ) ;
 ;W !,"in chkpro and duz = "_DUZ
 ;W !,"TERM PIECE IS "_$P($G(^VA(200,APUSEND,0)),"^",11)
 I $P($G(^VA(200,APUSEND,0)),"^",11)'="" Q 1  ;1=PROVIDER TERMINATED (BFD 11-22-04, CHGD 'DUZ' to APUSEND
 ;W !,"still in checkpro & didn't quit because term piece not 1 "
 I $P($G(^VA(200,APUSEND,0)),"^",7)=1!("Y") Q 2  ;1=PROVIDER DISUSED (BFD 11-22-04, CHGD 'DUZ' to APUSEND
 ;W !,"still in checkpro & didn't quit because disu piece not 2 "
 Q 0
 ;
ALLIMIT2 ; 3-27-07:  Called from within APUFSMEA
 ; for some reason ALLIMIT saves as 0 provider so need to walk through
 ; this is copy of pcp chk, think should be same except try &  ; out pcp chk  code
 ; Provider is piece 3 of node three in 100   (APUPROV)
 ; Signed by is piece 5 of node three in 100  (APUPSIG)
 ; 
 ;
 ;If sig & prov, then prov is contact unless terminated 
 ;  (can be same duz depending on how order entered)
 ; Unsigned uses APUSEND for notification message
 ;
 ; Send back results:
 ; RESULT=0  some kind of problem w/order using as template
 ; RESULT=2  status indicates 'human intervention' so tell AudioCare not 'talk' to provider
 ; RESULT=5  Provider(s) on order terminated - no one to send order to
 ;
 ; First check if there is data in both provider and signed by
 ; 
 ; If only provider, check if term or disuse.  
 ; When was only APUPROV and he/she was term plus NOT PCP, sent bk result=5 because term/disuse is 1st chk and not get to PCP/MHPCP chk
 ;W !,"ALLIMIT2^APUFSMEA"
 I APUPSIG'>"" D
 .S APUSEND=APUPROV
 .S RSF=$$CHKPRO($G(APUSEND)) I RSF>0 S RESULT=5_"^"_APUSEND Q
 .;S APUSEND=$S(RPCP=$G(APUPROV):RPCP,RMPCP=$G(APUPROV):RMPCP,1:0)
 .;I $G(APUSEND)=0 S APUSEND=APUPROV,RESULT=3_"^"_APUSEND W !," SET APUSEND=APUPROV AND RESULT 3 "_RESULT
 .;W !,"at bottom of the apupsig'>'' and prov not terminated.  what is result "_RESULT_"  and what is APUSEND "_APUSEND
 .Q
 ;
 ; If prov and signed by are same duz, then not need check both values for PCP/MHPCP & term/disuse
 I APUPSIG>"",APUPSIG=APUPROV D
 .S APUSEND=APUPROV
 .S RSF=$$CHKPRO($G(APUSEND)) I RSF>0 S APUSEND=APUPROV,RESULT=5_"^"_APUSEND Q
 .;S APUSEND=$S(RPCP=$G(APUPROV):RPCP,RMPCP=$G(APUPROV):RMPCP,1:0) I $G(APUSEND)=0 S APUSEND=APUPROV,RESULT=3_"^"_APUSEND W !,"JUST SET APUSEND=APUPROV & RESULT=3  "_RESULT
 . ;W !,"at bottom of the apupsig>'',apupsig=apuprov and result is "_RESULT_"  and apusend is "_APUSEND
 .Q
 ; 
 ; note 1-18-07;  this is one have to change for ALL because not care if is PCP but do care if prov is term/disuse
 ; If both provider & signed by have different entries, see if provider is PCP/MHPCP
 ;   If it is, verify if term/disuse
 ;     If PCP/MHPCP (provider) is term/disuse, then communicate w/signed by
 ;    ** chg in logic 11/22: 
 ;    If prov is not PCP/MHPCP, chk if PCP/MHPCP did signed by.  If not, set result=3 and quit.  If yes, send to them because pharmacy will
 ;    
 I APUPSIG>"",APUPSIG'=APUPROV D APROVSIG
 I RESULT'>0 S RESULT=1
 Q
 ;
APROVSIG ;  3-27-07:  Called from within APUFSMEA
 ;APUPROV not= APUPSIG.  See if APUPROV PCP/MHPCP and verify active.
 ; if APUPROV is not active chk if APUPSIG is PCP & if yes, communicate otherwise 'PCP message
 ;W !,"IN APROVSIG^APUFSMEA"
 S APUFLG=0
 S APUSEND=APUPROV
 ; note - think next line is one where chk if PCP so ; out & D VALIDP
 ;S APUSEND=$S(RPCP=$G(APUPROV):RPCP,RMPCP=$G(APUPROV):RMPCP,1:0)
 ;I $G(APUSEND)'=0 S APUFLG=1 D VALIDP    ; apuprov was pcp/mhpcp
 ;
 ; note - I don't care if APUPROV is PCP/MHPCP so think set flg to 0 & go VALIDM where chk if APUPROV is valid & compare with APUSIG
 ; note -- set APUFLG=0 so go VALIDM
 ; reason want go AVALIDM - apuprov was not pcp/mhpcp but need verify they are active (if not see if APUPSIG is PCP)
 S APUFLG=0
 I APUFLG=0 D AVALIDM
 Q
 ;
AVALIDM ; 3-27-07:  Called from within APUFSMEA
 ;APUPROV was not PCP/MHPCP - see if active.  If not, see if APUPSIG is PCP/MHPCP
 ; note 1-17-07  if APUPROV is not active, verify if APUSIG is active and send to them
 ; chkpro only verifies no term date and not disused
 ;W !,"In AVALIDM^APUFSMEA and next line APUSEND=APUPROV"
 S APUSEND=APUPROV
 S RSF=$$CHKPRO($G(APUSEND))
 ; note 1-17-07 skip result setting to 3 because not care if PCP. If active, send to prov
 ;I RSF'>0 S RESULT=3_"^"_APUSEND Q     ; APUPROV is active & not PCP/MHPCP
 ; note:  comment for next line of code:  ; note 1-17-07:  APUSEND already set to the provider that info should be sent to so just Q
 I RSF'>0 Q
 ; note 1-17-07 if reach here then the APUPROV is not active so need check if APUSIG is
 ; note 1-17-07 ; out next line cause not care if PCP
 ;S APUSEND=$S(RPCP=$G(APUPSIG):RPCP,RMPCP=$G(APUPSIG):RMPCP,1:0)
 ; note 1-17-07 have to set APUSEND=APUSIG 
 ; note comment for next line of code: ;W !,"STILL IN AVALIDM AND SET APUSEND=APUPSIG"
 S APUSEND=APUPSIG
 S RSF=$$CHKPRO($G(APUSEND))
 ; note comment for next line of code:  ; both APUPROV and APUSIG term/disuse & not one to talk to
 I RSF'>0 S RESULT=5_"^"_APUPROV Q
 ; note comment for next line of code: APUSIG is active so communicate with that person
 S APUSEND=APUPSIG
 Q
