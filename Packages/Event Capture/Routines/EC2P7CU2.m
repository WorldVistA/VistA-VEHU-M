EC2P7CU2 ;ALB/ESD - Clean up EC Patient (#721) file entries; 24 OCT 1997
 ;;2.0; EVENT CAPTURE ;**7**;8 May 96
 ;
LOCK(ECIEN) ;- Lock EC Patient record
 ;
 ;   Input:            ECIEN = EC Patient record IEN
 ;
 ;  Output:
 ;  Function Value:     1 if record can be locked
 ;                      0 if record cannot be locked
 ;
 I $G(ECIEN) L +^ECH(ECIEN):5
 Q $T
 ;
 ;
UNLOCK(ECIEN) ;- Unlock EC Patient record
 ;
 ;   Input:            ECIEN = EC Patient record IEN
 ;
 ;  Output:            None
 ;
 I $G(ECIEN) L -^ECH(ECIEN)
 Q
 ;
FILPCE(ECIEN,ECARRY) ;- File corrected "PCE" node
 ;
 ;   Input:            ECIEN = EC Patient record IEN
 ;
 ;  Output:           ECARRY = Local array containing EC Patient record
 ;                             fields, passed by reference
 ;  Function value:        1 = successful
 ;                         0 = unsuccessful
 ;
 N DA,DIE,DR,SUCCESS,T
 S SUCCESS=1
 ;
 ;- Drops out if invalid condition found
 D
 . I '$G(ECIEN) S SUCCESS=0 Q
 .;
 .;- Lock main node
 . I '$$LOCK(ECIEN) S SUCCESS=0 Q
 .;
 .;- Set separator used in "PCE" node
 . S T="~"
 . S DA=ECIEN
 . S DIE="^ECH("
 . S DR=ECARRY("PCE","PROCDT")_T_ECARRY("PCE","DFN")_T_ECARRY("PCE","CLIN")_T_ECARRY("PCE","INST")_T_ECARRY("PCE","DSSID")_T_ECARRY("PCE","PROV")_T
 . S DR=DR_ECARRY("PCE","PROV2")_T_ECARRY("PCE","PROV3")_T_ECARRY("PCE","VOL")_T_ECARRY("PCE","CPT")_T_ECARRY("PCE","DX")_T_ECARRY("PCE","AO")_T
 . S DR=DR_ECARRY("PCE","IR")_T_ECARRY("PCE","ENV")_T_ECARRY("PCE","SC")_T_ECARRY("PCE","ECNAT")
 . S DR="30////"_DR
 . D ^DIE
 ;
 ;- Unlock main node
 D UNLOCK(ECIEN)
FILPCEQ Q SUCCESS
 ;
 ;
FILEP(ECIEN,ECARRY) ;- File corrected PCE CPT field on "P" node
 ;
 ;   Input:            ECIEN = EC Patient record IEN
 ;                    ECARRY = Local array containing EC Patient record
 ;                             fields, passed by reference
 ;
 ;  Output:
 ;  Function value:        1 = successful
 ;                         0 = unsuccessful
 ;
 N DA,DIE,DR,SUCCESS
 S SUCCESS=1
 ;
 ;- Drops out if invalid condition found
 D
 . I '$G(ECIEN) S SUCCESS=0 Q
 .;
 .;- Lock main node
 . I '$$LOCK(ECIEN) S SUCCESS=0 Q
 . S DA=ECIEN
 . S DIE="^ECH("
 .;
 .;- Set to null if PCE CPT field in ECARRY is null
 . S DR="19////"_$S(ECARRY("P","PCECPT")="":"@",1:ECARRY("P","PCECPT"))
 . D ^DIE
 ;
 ;- Unlock main node
 D UNLOCK(ECIEN)
FILEPQ Q SUCCESS
 ;
 ;
KILLNOD(ECIEN) ;- Kill "R" node (Reason node)
 ;
 ;   Input:    ECIEN = EC Patient record IEN
 ;
 ;  Output:    None
 ;
 I $G(ECIEN) K ^ECH(ECIEN,"R")
 Q
 ;
 ;
DELFLDS(ECIEN) ;- Delete 'Sent to PCE', 'Visit', and 'Checkout D/T' fields
 ;
 ;   Input:    ECIEN = EC Patient record IEN
 ;
 ;  Output:
 ;  Function value:       1 = successful
 ;                        0 = unsuccessful
 ;
 N DA,DIE,DR,SUCCESS
 S SUCCESS=1
 ;
 ;- Drops out if invalid condition found
 D
 . I '$G(ECIEN) S SUCCESS=0 Q
 .;
 .;- Lock main node
 . I '$$LOCK(ECIEN) S SUCCESS=0 Q
 .;
 .;- Sent to PCE = fld 25, Visit = fld 28, Checkout D/T = fld 32
 . S DA=ECIEN
 . S DIE="^ECH("
 . S DR="25////@;28////@;32////@"
 . D ^DIE
 ;
 ;- Unlock main node
 D UNLOCK(ECIEN)
 Q SUCCESS
 ;
 ;
ADDSND(ECIEN,ECARRY) ;- Add date/time to 'Send to PCE' field
 ;
 ;   Input:    ECIEN = EC Patient record IEN
 ;            ECARRY = Local array containing EC Patient record fields,
 ;                     passed by reference
 ;
 ;  Output:
 ;  Function value:    1 = successful
 ;                     0 = unsuccessful
 ;
 N DA,DIE,DR,SUCCESS
 S SUCCESS=1
 ;
 ;- Drops out if invalid condition found
 D
 . I '$G(ECIEN),'$G(ECARRY("PROCDT")) S SUCCESS=0 Q
 .;
 .;- Lock main node
 . I '$$LOCK(ECIEN) S SUCCESS=0 Q
 .;
 .;- Send to PCE = fld 31
 . S DA=ECIEN
 . S DIE="^ECH("
 . S DR="31////"_ECARRY("PROCDT")
 . D ^DIE
 ;
 ;- Unlock main node
 D UNLOCK(ECIEN)
 Q SUCCESS
 ;
 ;
DELVFIL(ECARRY) ;- Delete Visit file data
 ;
 ;   Input:   ECARRY = Local array containing EC Patient record fields,
 ;                     passed by reference
 ;
 ;  Output:
 ;  Function value:    1 = successful
 ;                     0 = unsuccessful
 ;
 N SUCCESS,VALQUIET
 S (SUCCESS,VALQUIET)=1
 ;
 ;- Drops out if invalid condition found
 D
 . I '$G(ECARRY("VISIT")) S SUCCESS=0 Q
 .;
 .;- Call PCE API to delete Visit data
 . I $$DELVFILE^PXAPI("ALL",$G(ECARRY("VISIT")))
 Q SUCCESS
 ;
CLEAN2 ;- Transmit corrected data to PCE
 ;
 N ECCKDT,ECJJ1,ECOKXMIT,ECPKG,ECPRDT,ECS,ECSNDT,SDIEMM,SDMODE,SDSTPAMB
 K ^TMP("ECPXAPI",$J)
 S (ECJJ1,ECSNDT)=0
 D NOW^%DTC S ECCKDT=+$E(%,1,12)
 S ECPKG=$O(^DIC(9.4,"B","EVENT CAPTURE",0)),ECS="EVENT CAPTURE DATA"
 ;
 ;** Prevent Am-Care Validation checks with SDIEMM
 S SDIEMM=1
 ;
 ;- Loop thru "AD" cross ref to get records to send to PCE
 F  S ECSNDT=$O(^ECH("AD",ECSNDT)) Q:'ECSNDT  D
 . F  S ECJJ1=$O(^ECH("AD",ECSNDT,ECJJ1)) Q:'ECJJ1  D
 ..;
 ..;- Get procedure date/time from EC Patient record zero node
 .. S ECPRDT=$P($G(^ECH(ECJJ1,0)),"^",3)
 ..;
 ..;- Call function to determine if record should be transmitted to the
 ..;- NPCD for workload credit
 .. S ECOKXMIT=+$P($$OKTOXMIT^SCDXFU04(ECPRDT),"^",2)
 ..;
 ..;- Error
 .. Q:ECOKXMIT=-1
 .. I 'ECOKXMIT D
 ...;
 ...;- Record should not be transmitted to NPCD; set Scheduling variable
 ...;- to prevent this
 ... S SDSTPAMB=1
 ...;
 ...;- Set up variables to pass to PCE API
 ... D SET^ECPCEU
 ... K SDSTPAMB
 ..;
 ..;- Record should be transmitted to NPCD; don't set Scheduling variable
 .. I ECOKXMIT D
 ... D SET^ECPCEU
 ;
 ;- Clean up and exit (Note: these kill lines were taken directly from
 ;- routine NITE^ECPCEU)
 K DA,DIE,DR,EC4,EC725,ECAO,ECCPT,ECDT,ECDX,ECHL,ECID,ECIR,ECJJ,ECJJ1,ECL,ECNODE,ECPKG,ECPS,ECS,ECSC,ECU,ECU2,ECU3,ECV,ECVST,ECVV,ECZEC
 K %,%H,%I,ECCKDT
 K ^TMP("ECPXAPI",$J)
 Q
 ;
SNDMSG ;- Send e-mail message
 ;
 ;   Input:   None
 ;
 ;  Output:   None
 ;
 N DIFROM,ECCNT,TEXT,XMDUZ,XMN,XMSUB,XMTEXT,XMY,XMZ
 ;
 ;- Create message
 D CREMSG
 D CREMSG2^EC2P7CU3
 ;
 ;- Set up necessary variables and send
 S XMY(DUZ)=""
 S XMDUZ=.5
 S XMSUB="Results of Event Capture Patch EC*2*7 CleanUp",XMN=0
 S XMTEXT="^TMP(""EC2P7CU-MSG"",$J,"
 D ^XMD
 K ^TMP("EC2P7CU-MSG",$J),ECERRCNT
 Q
 ;
 ;
CREMSG ;- Create e-mail message when clean up has finished
 ;
 ;   Input:   ECERRCNT = Must be set prior to CREMSG and KILLed by
 ;                        calling tag
 ;
 ;  Output:   None
 ;
 S ECCNT=0
 D LINE("                     RESULTS OF PATCH EC*2*7 CLEANUP")
 D LINE("                     ===============================")
 D LINE("")
 D LINE("")
 D LINE("       The number of record(s) entered during FY 98 in the Event Capture")
 D LINE("       Patient file which were corrected in Event Capture and PCE were/was")
 D LINE("")
 D LINE("                              "_ECERRCNT)
 D LINE("")
 D LINE("")
 Q
 ;
 ;
LINE(TEXT) ;- Add text to mail message
 ;
 ;   Input:   TEXT = Line of text to be inserted into message
 ;
 ;  Output:   None
 ;
 S ECCNT=ECCNT+1,^TMP("EC2P7CU-MSG",$J,ECCNT)=TEXT
 Q
