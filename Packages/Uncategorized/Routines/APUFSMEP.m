APUFSMEP ;648/BFD CHECKS OK FOR RENEWAL REQUEST TO PROVIDER (PCP PARAMETER) ; 3-27-07
 ;;5.0; PORTLAND,OR APPLICATION
 ;
 ;  VA Utilities for MAudio Care (renewals) 
 ;  INCLUDES CHANGES TO MAKE NEW VEXRX (BAY PINES) WORK
 ;
 ; called by APUFSMED so it can create Unsigned Notification  
 ;  APUFSMED exceed size limits so split out PCP checks & All provider checks into own rtns
 ;
 ; Following line is my reminder of code that was originally in APUFSMED  
 ; I C="P" D PCPLIMIT I RESULT'=1 G HEYQ
 ;
 ; Provider is piece 3 of node three in 100   (APUPROV)
 ; Signed by is piece 5 of node three in 100  (APUPSIG)
 ; 
 ; General logic if 'provider' and 'signed by' different:  'Provider' is the person communicate with
 ; Also, If 'written on chart,' 'provider' is only field of the two that is populated
 ; 
 ;
PCPLIMIT ; 3-27-07:  Called from APUFSMED 
 ;If sig & prov, then prov is contact unless terminated 
 ;  (can be same duz depending on how order entered)
 ; Unsigned uses APUSEND for notification message
 ;
 ; Send back results:
 ; RESULT=0  some kind of problem w/order using as template
 ; RESULT=2  status indicates 'human intervention' so tell AudioCare not 'talk' to provider
 ; RESULT=3  "P" parameter & order not from PCP/MHPCP
 ; RESULT=5  Provider(s) on order terminated - no one to send order to
 ;
 ; First check if there is data in both provider and signed by
 ; 
 ; If only provider, check if term or disuse.  
 ; When was only APUPROV and he/she was term plus NOT PCP, sent bk result=5 because term/disuse is 1st chk and not get to PCP/MHPCP chk
 I APUPSIG'>"" D
 .;W !,"at i apusig'>'' so think that means no 2nd sig"
 .S APUSEND=APUPROV
 .S RSF=$$CHKPRO($G(APUSEND)) I RSF>0 S RESULT=5_"^"_APUSEND Q
 .S APUSEND=$S(RPCP=$G(APUPROV):RPCP,RMPCP=$G(APUPROV):RMPCP,1:0)
 .I $G(APUSEND)=0 S APUSEND=APUPROV,RESULT=3_"^"_APUSEND
 .;W !!,"In PCPLIMIT^APUFSMED and result was 3 and APUSEND is "_APUSEND
 .Q
 ;
 ; If prov and signed by are same duz, then not need check both values for PCP/MHPCP & term/disuse
 I APUPSIG>"",APUPSIG=APUPROV D
 . ;W !,"at i apupsig>'' when same prov on both prov & psig lines"
 .S APUSEND=APUPROV
 .S RSF=$$CHKPRO($G(APUSEND)) I RSF>0 S APUSEND=APUPROV,RESULT=5_"^"_APUSEND Q
 .S APUSEND=$S(RPCP=$G(APUPROV):RPCP,RMPCP=$G(APUPROV):RMPCP,1:0) I $G(APUSEND)=0 S APUSEND=APUPROV,RESULT=3_"^"_APUSEND
 .;W !!,"In PCPLIMIT^APUFSMED and result SET TO "_RESULT_" and APUSEND is "_APUSEND
 .Q
 ;
 ; If both provider & signed by have different entries, see if provider is PCP/MHPCP
 ;   If it is, verify if term/disuse
 ;     If PCP/MHPCP (provider) is term/disuse, then communicate w/signed by
 ;    ** chg in logic 11/22: 
 ;    If prov is not PCP/MHPCP, chk if PCP/MHPCP did signed by.  If not, set result=3 and quit.  If yes, send to them because pharmacy will
 ;    
 I APUPSIG>"",APUPSIG'=APUPROV D PROVSIG
 I RESULT'>0 S RESULT=1
 ;W !!,"At bottom of PCPLIMIT^APUFSMED and result set to  ("_RESULT_")"_". what did I set APUSEND ("_APUSEND_")"
 Q
 ;
PROVSIG ;  3-27-07:  Called from within APUFSMEP
 ;APUPROV not= APUPSIG.  See if APUPROV PCP/MHPCP and verify active.
 ; if APUPROV is not active chk if APUPSIG is PCP & if yes, communicate otherwise 'PCP message
 ;W !,"at provsig"
 S APUFLG=0
 S APUSEND=APUPROV
 S APUSEND=$S(RPCP=$G(APUPROV):RPCP,RMPCP=$G(APUPROV):RMPCP,1:0)
 I $G(APUSEND)'=0 S APUFLG=1 D VALIDP    ; apuprov was pcp/mhpcp
 I APUFLG=0 D VALIDM     ; apuprov was not pcp/mhpcp but need verify they are active (if not see if APUPSIG is PCP)
 ;W !,"BOTTOM of PROVSIG^APUFSMED"
 Q
 ;
VALIDP ; 3-27-07:  Called from within APUFSMEP
 ;Check if APUPROV is valid and then go into checking APUPSIG if necessary
 ;W !!,"VALIDP^APUFSMEP"
 S RSF=$$CHKPRO($G(APUSEND))
 I RSF>0 D VALIDP2
 ;W !!,"LEAVING VALIDP^APUFSMED.  WHAT IS APUSEND "_APUSEND
 Q
 ;
VALIDP2 ; 3-27-07:  Called from within APUFSMEP
 ;W !,"VALIDP2^APUFSMEP"
 S APUSEND=APUPSIG,RSF=$$CHKPRO($G(APUSEND))
 I RSF>0 S APUSEND=APUPROV,RESULT=5_"^"_APUSEND
 ;W !!,"LEAVING VALIDP2 - WHAT IS RESULT AND APUSEND "_RESULT_"  "_APUSEND
 Q
 ;
VALIDM ; 3-27-07:  Called from within APUFSMEP
 ;APUPROV was not PCP/MHPCP - see if active.  If not, see if APUPSIG is PCP/MHPCP
 ;W !,"VALIDM^APUFSMEP"
 S APUSEND=APUPROV
 S RSF=$$CHKPRO($G(APUSEND))
 ; note for next line of code: ; APUPROV is active & not PCP/MHPCP
 I RSF'>0 S RESULT=3_"^"_APUSEND Q
 S APUSEND=$S(RPCP=$G(APUPSIG):RPCP,RMPCP=$G(APUPSIG):RMPCP,1:0)
 I $G(APUSEND)'>0 S APUSEND=APUPSIG,RESULT=3_"^"_APUSEND Q
 ; note for next line of code:  ; APUPSIG is PCP/MHPCP & APUPROV not active so communicate w/APUPSIG
 I $G(APUSEND)>0 S APUSEND=APUPSIG
 ;W !,"BOTTOM OF VALIDM^APUFSMEP.  WHAT IS RESULT AND APUSEND "_RESULT_"  "_APUSEND
 Q
 ; 3-27-07:  CHECKPRO called from within APUFSMEP
CHKPRO(DUZ) ;
 ;W !,"in chkpro and duz = "_DUZ
 ;W !,"TERM PIECE IS "_$P($G(^VA(200,APUSEND,0)),"^",11)
 I $P($G(^VA(200,APUSEND,0)),"^",11)'="" Q 1  ;1=PROVIDER TERMINATED (BFD 11-22-04, CHGD 'DUZ' to APUSEND
 ;W !,"still in checkpro & didn't quit because term piece not 1 "
 I $P($G(^VA(200,APUSEND,0)),"^",7)=1!("Y") Q 2  ;1=PROVIDER DISUSED (BFD 11-22-04, CHGD 'DUZ' to APUSEND
 ;W !,"still in checkpro & didn't quit because disu piece not 2 "
 Q 0
 ;
