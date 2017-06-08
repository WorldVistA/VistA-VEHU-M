EC2P7CU1 ;ALB/ESD - Clean up EC Patient (#721) file entries; 16 OCT 1997
 ;;2.0; EVENT CAPTURE ;**7**;8 May 96
 ;
EN2 ;- Alternate entry point which will schedule job
 ;
 ;- Explain clean up to user
 D PRTTXT("INTRO")
 ;
 ;- Set up variables to queue job
 N TXT,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK
 S ZTRTN="CLEAN^EC2P7CU1"
 S ZTDESC="Event Capture Patient file (#721) cleanup"
 S ZTDTH=""
 S ZTIO=""
 D ^%ZTLOAD
 ;
 ;- Print task number of job
 S:(+$G(ZTSK)) TXT="Scheduled as task number: "_ZTSK
 S:('$G(ZTSK)) TXT="<<< Unable to schedule cleanup >>>"
 D BMES^XPDUTL(TXT)
EN2Q Q
 ;
 ;
INTRO ;- User text explaining clean up
 ;;  This patch will cleanup entries in the Event Capture Patient file
 ;;  (#721) containing errors which occurred during the editing process.
 ;;  These errors caused incomplete data to be stored in the Event Capture
 ;;  Patient file (#721) and incorrect data to be filed in the Scheduling/PCE
 ;;  files (if the DSS Unit was set to send data to PCE).
 ;;
 ;;  This cleanup will correct errors in file #721 and the Scheduling/PCE
 ;;  files.  Note:  An Event Capture patient procedure will NOT be
 ;;  transmitted to Austin if there is a NPCD database closeout date
 ;;  effective for that procedure's date and time.  The transmission
 ;;  will be stopped even if the associated DSS Unit is defined to send
 ;;  to PCE and the cleanup corrects information transmitted to the
 ;;  NPCD.
 ;;
 ;;  Upon completion of the cleanup, a summary of what was done will
 ;;  be sent to the patch installer in a MailMan message.  Please forward
 ;;  this message to Medical Center personnel responsible for the
 ;;  administration of Event Capture (i.e. the Event Capture ADPAC).
 ;;
 ;;  It is suggested this cleanup be queued to run after normal business
 ;;  hours and be allowed at least 1 hour to complete.
 ;;
 ;;QUIT
 ;
 ;
PRTTXT(TXTTAG) ;- Print user text to screen
 ;
 N I,TEXT
 D MES^XPDUTL(" ")
 F I=1:1 S TEXT=$P($T(@TXTTAG+I),";;",2) Q:TEXT="QUIT"  D
 . S:TEXT="" TEXT=" "
 . D MES^XPDUTL(TEXT)
 Q
 ;
 ;
CLEAN ;- Main entry point for clean up
 ;
 N ECARRY1,ECCNT,ECDSS,ECDSSU,ECIEN,ECIO,ECNODE,ECPCERR,ECPNERR,ECRNUM
 N ECSPCER
 S (ECIEN,ECRNUM,ECERRCNT)=0
 F  S ECRNUM=+$O(^ECH("B",ECRNUM)) Q:'ECRNUM  D
 .;
 .;- Get EC Patient IEN
 . F  S ECIEN=+$O(^ECH("B",ECRNUM,ECIEN)) Q:'ECIEN  D
 .. S ECNODE=$G(^ECH(ECIEN,0))
 .. Q:ECNODE=""
 .. S ECDSS=$P(ECNODE,"^",7)
 .. S ECIO=$P(ECNODE,"^",22)
 ..;
 ..;- Determine if DSS Unit is sending to PCE or not
 .. S ECDSSU=+$$CHKDSS(ECDSS,ECIO) Q:ECDSSU=-1
 ..;
 ..;- Create local array containing EC Patient record fields
 ..I '$$GET^EC2P7CU3(ECIEN,.ECARRY1) Q
 ..I ECDSSU D
 ...;
 ...;- Check for data needed to send to PCE
 ...S ECSPCER=$$CHKREC^EC2P7CU3(ECIEN)
 ...;
 ...I ECSPCER DO  ;** Data required by PCE is missing
 ....;
 ....;Add FY 98 records to completion e-mail message ^TMP global
 ....I +ECARRY1("PROCDT")>2970930.9999999 Q:'$$ADD2TMP2^EC2P7CU3(ECIEN,.ECARRY1)
 ...;
 ...I 'ECSPCER DO  ;** All data required by PCE exists
 ....;- Check/correct PCE and P nodes
 .... S ECPCERR=$$PCE(.ECARRY1)
 .... S ECPNERR=$$PNODE(.ECARRY1)
 ....;
 ....;- If 'PCE' node error, file corrected 'PCE' node
 .... I ECPCERR,('$$FILPCE^EC2P7CU2(ECIEN,.ECARRY1)) Q
 ....;
 ....;- If 'P' node error, file corrected 'P' node
 .... I ECPNERR,('$$FILEP^EC2P7CU2(ECIEN,.ECARRY1)) Q
 ....;- If error on either node, perform record clean up
 .... I (ECPCERR!(ECPNERR)) D
 .....;
 .....;- Kill 'R' node
 ..... D KILLNOD^EC2P7CU2(ECIEN)
 .....;
 .....;- Determine if record should be transmitted to the NPCD for credit
 ..... I '+$P($$OKTOXMIT^SCDXFU04(ECARRY1("PROCDT")),"^",2) S SDSTPAMB=1
 .....;
 .....;- Prepare record for retransmittal to PCE/Scheduling
 ..... Q:'$$DELFLDS^EC2P7CU2(ECIEN)!('$$ADDSND^EC2P7CU2(ECIEN,.ECARRY1))
 ..... I $$DELVFIL^EC2P7CU2(.ECARRY1)
 ..... K SDSTPAMB ;- Set to prevent transmission to the NPCD
 .....;
 .....;- Add FY 98 records to completion e-mail message ^TMP global
 ..... I +ECARRY1("PROCDT")>2970930.9999999 S ECERRCNT=ECERRCNT+1
 ..;
 ..;- If DSS Unit not sending to PCE and error found on 'P' node,
 ..;- correct 'P' node, kill 'R' node, and add error to ^TMP global
 .. I 'ECDSSU,($$PNODE(.ECARRY1)) D
 ... Q:'$$FILEP^EC2P7CU2(ECIEN,.ECARRY1)
 ...;
 ...;** Add FY 98 records to completion e-mail message ^TMP global
 ... I +ECARRY1("PROCDT")>2970930.9999999 S ECERRCNT=ECERRCNT+1
 ... D KILLNOD^EC2P7CU2(ECIEN)
 ;
 ;- Call CLEAN2 to send EC Patient records to PCE
 D CLEAN2^EC2P7CU2
 ;
 ;- Send completion e-mail message
 D SNDMSG^EC2P7CU2
 Q
 ;
 ;
CHKDSS(DSSU,INOUT) ;- Determine if DSS Unit is sending data to PCE
 ;
 ;   Input:        DSSU = DSS Unit IEN
 ;                INOUT = Inpatient or Outpatient
 ;
 ;  Output:
 ;   Function Value: -1 = No DSS Unit or Inpat/Outpat indicator passed in
 ;                    0 = DSS Unit not sending to PCE
 ;                    1 = DSS Unit sending to PCE
 ;
 N ECDSS,ECSEND
 ;
 ;- Drops out if invalid condition
 D
 . I '$G(DSSU),'$G(INOUT) S ECDSS=-1 Q
 .;
 .;- Get 'Send to PCE' field
 . S ECSEND=$P($G(^ECD(+DSSU,0)),"^",14)
 . I ECSEND="A"!(ECSEND="O"&(INOUT="O")) S ECDSS=1
 . E  S ECDSS=0
 Q ECDSS
 ;
 ;
PNODE(ECARRY) ;- Validate/correct "P" node
 ;
 ;   Input:       ECARRY = Local array containing EC Patient record
 ;                         fields, passed by reference
 ;
 ;  Output:
 ;   Function Value:   1 = error found on "P" node
 ;                     0 = no error found on "P" node
 ;
 N ECCPT,ECPROC,ERROR
 S ERROR=0
 ;
 ;- Get CPT code - for EC national procedures, use CPT field (#4) of
 ;- EC National Procedure file to get corresponding CPT code
 S ECCPT=$S(ECARRY("PROC")["EC":$P($G(^EC(725,+ECARRY("PROC"),0)),"^",5),1:$P(ECARRY("PROC"),";"))
 I ECARRY("P","PCECPT")'=ECCPT S ECARRY("P","PCECPT")=ECCPT,ERROR=1
 Q ERROR
 ;
 ;
PCE(ECARRY) ;- Validate/correct "PCE" node
 ;
 ;   Input:      ECARRY = Local array containing EC Patient record
 ;                        fields, passed by reference
 ;
 ;  Output:
 ;   Function Value:  1 = error found on "PCE" node
 ;                    0 = no error found on "PCE" node
 ;
 N ECCPT,ECNAT,ECNNODE,ERROR,I
 S ERROR=0
 ;
 ;- Check/correct "PCE" node fields with fields on the zero node
 I ECARRY("PROCDT")'=ECARRY("PCE","PROCDT") S ECARRY("PCE","PROCDT")=ECARRY("PROCDT"),ERROR=1
 I ECARRY("DFN")'=ECARRY("PCE","DFN") S ECARRY("PCE","DFN")=ECARRY("DFN"),ERROR=1
 I ECARRY("CLIN")'=ECARRY("PCE","CLIN") S ECARRY("PCE","CLIN")=ECARRY("CLIN"),ERROR=1
 I ECARRY("INST")'=ECARRY("PCE","INST") S ECARRY("PCE","INST")=ECARRY("INST"),ERROR=1
 I ECARRY("DSSID")'=ECARRY("PCE","DSSID") S ECARRY("PCE","DSSID")=ECARRY("DSSID"),ERROR=1
 I ECARRY("PROV")'=ECARRY("PCE","PROV") S ECARRY("PCE","PROV")=ECARRY("PROV"),ERROR=1
 I +(ECARRY("PROV2"))'=+(ECARRY("PCE","PROV2")) S ECARRY("PCE","PROV2")=ECARRY("PROV2"),ERROR=1
 I +(ECARRY("PROV3"))'=+(ECARRY("PCE","PROV3")) S ECARRY("PCE","PROV3")=ECARRY("PROV3"),ERROR=1
 I ECARRY("VOL")'=ECARRY("PCE","VOL") S ECARRY("PCE","VOL")=ECARRY("VOL"),ERROR=1
 ;
 ;- Check/correct "PCE" CPT code for procedure
 S ECCPT=$S(ECARRY("PROC")["EC":$P($G(^EC(725,+ECARRY("PROC"),0)),"^",5),1:$P(ECARRY("PROC"),";"))
 I ECCPT'=ECARRY("PCE","CPT") S ECARRY("PCE","CPT")=ECCPT,ERROR=1
 ;
 ;- Check/correct "PCE" node fields with fields on the "P" node
 I ECARRY("P","DX")'=ECARRY("PCE","DX") S ECARRY("PCE","DX")=ECARRY("P","DX"),ERROR=1
 I $$UNYERR^EC2P7CU3(ECARRY("P","AO"),ECARRY("PCE","AO")) DO
 .S ECARRY("PCE","AO")=$$UNYCONV^EC2P7CU3(ECARRY("P","AO")),ERROR=1
 I $$UNYERR^EC2P7CU3(ECARRY("P","IR"),ECARRY("PCE","IR")) DO
 .S ECARRY("PCE","IR")=$$UNYCONV^EC2P7CU3(ECARRY("P","IR")),ERROR=1
 I $$UNYERR^EC2P7CU3(ECARRY("P","ENV"),ECARRY("PCE","ENV")) DO
 .S ECARRY("PCE","ENV")=$$UNYCONV^EC2P7CU3(ECARRY("P","ENV")),ERROR=1
 I $TR(ECARRY("P","SC"),"YN",10)'=ECARRY("PCE","SC") S ECARRY("PCE","SC")=$TR(ECARRY("P","SC"),"YN",10),ERROR=1
 ;
 ;- Check/correct EC national number and name
 I ECARRY("PROC")["EC" D
 . S ECNNODE=$G(^EC(725,+ECARRY("PROC"),0))
 . S ECNAT=$P(ECNNODE,"^",2)_"  "_$P(ECNNODE,"^")
 . F I=1:1:$L(ECNAT) I $E(ECNAT,I)'=$E(ECARRY("PCE","ECNAT"),I) S ECARRY("PCE","ECNAT")=ECNAT,ERROR=1 Q
 ;
 Q ERROR
