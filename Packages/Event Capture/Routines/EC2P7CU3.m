EC2P7CU3 ;ALB/GTS - Clean up EC Patient (#721) file entries; 24 OCT 1997
 ;;2.0; EVENT CAPTURE ;**7**;8 May 96
 ;
UNYCONV(UNYVAL) ;* Convert AO, IR and Env Contaminent indicator to PCE value
 ;
 ;*  Input:           UNYVAL = 'Y', 'N' or 'U' to indicate status
 ;
 ;* Output:           PCEVAL = Converted value to pass to PCE
 ;
 ;*  Function value:       1 = 'Y'
 ;                         0 = 'N'
 ;                      NULL = 'U' (for Unknown)
 ;
 N PCEVAL
 S PCEVAL=$S(UNYVAL="Y":1,UNYVAL="N":0,1:"")
 Q PCEVAL
 ;
UNYERR(ECSOURCE,ECRSLT) ;* Check IR, AO and EC source against result for PCE
 ;
 ;*  Input:         ECSOURCE = The benchmark to compare against
 ;                  ECRSLT   = The value derived from the source input
 ;
 ;* Output:         ERR      = Indicates an error in the comparison
 ;
 ;*  Function value:       1 = Derived value did not match source
 ;                         0 = Derived value did match source
 ;
 N ERR
 S:'$D(ECSOURCE) ECSOURCE=""
 S:'$D(ECRSLT) ECRSLT=""
 S ECSOURCE=$$UNYCONV(ECSOURCE) ;* Change source to respective PCE value
 S ERR=$S(ECSOURCE'=ECRSLT:1,1:0)
 Q ERR
 ;
CHKREC(ECFN) ;** Check for data required to pass to PCE
 N PN,PNP
 I '$D(^ECH(ECFN,0)) Q "1"
 I '$D(^ECH(ECFN,"P")) Q "1"
 S PN=^ECH(ECFN,0),PNP=^ECH(ECFN,"P")
 ;set data pieces
 S ECP3=+$P(PN,"^",3) I ECP3'["." K ECP3 D DELNOD Q "1"
 S ECP2=+$P(PN,"^",2) I 'ECP2 K ECP2 D DELNOD Q "1"
 S ECP19=+$P(PN,"^",19) I 'ECP19 K ECP19 D DELNOD Q "1"
 S ECP4=+$P(PN,"^",4) I 'ECP4 K ECP4 D DELNOD Q "1"
 S ECP20=+$P(PN,"^",20) I 'ECP20 K ECP20 D DELNOD Q "1"
 S ECP11=+$P(PN,"^",11) I 'ECP11 K ECP11 D DELNOD Q "1"
 S ECP10=+$P(PN,"^",10) I 'ECP10 K ECP10 D DELNOD Q "1"
 S ECPP1=+$P(PNP,"^") I 'ECPP1 K ECPP1 D DELNOD Q "1"
 S ECPP2=+$P(PNP,"^",2) I 'ECPP2 K ECPP2 D DELNOD Q "1"
 Q "0"
 ;
DELNOD ;** Delete 'Send' node
 ;
 N DA,DIE,DR
 L +^ECH(ECFN):5 Q:'$T
 S DA=ECFN
 S DIE="^ECH("
 S DR="31////@"
 D ^DIE
 L -^ECH(ECFN)
 Q
 ;
GET(ECIEN,ECARRY) ;- Get EC Patient record fields into local array ECARRY
 ;
 ;   Input:            ECIEN = EC Patient record IEN
 ;
 ;  Output:           ECARRY = Local array containing EC Patient record
 ;                             fields, passed by reference
 ;   Function value:       1 = successful
 ;                         0 = unsuccessful
 ;
 N NODE,SUCCESS
 S SUCCESS=0
 I '$G(ECIEN) G GETQ
 I '$D(^ECH(ECIEN,0)) G GETQ
 K ECARRY
 S ECARRY=""
 ;
 ;- Get zero node fields to validate
 S NODE=$G(^ECH(ECIEN,0))
 S ECARRY("DFN")=$P(NODE,"^",2)
 S ECARRY("PROCDT")=$P(NODE,"^",3)
 S ECARRY("INST")=$P(NODE,"^",4)
 S ECARRY("DSSU")=$P(NODE,"^",7)
 S ECARRY("PROC")=$P(NODE,"^",9)
 S ECARRY("VOL")=$P(NODE,"^",10)
 S ECARRY("PROV")=$P(NODE,"^",11)
 S ECARRY("PROV2")=$P(NODE,"^",15)
 S ECARRY("PROV3")=$P(NODE,"^",17)
 S ECARRY("CLIN")=$P(NODE,"^",19)
 S ECARRY("DSSID")=$P(NODE,"^",20)
 S ECARRY("VISIT")=$P(NODE,"^",21)
 ;
 ;- Get "P" node fields to validate
 S NODE=$G(^ECH(ECIEN,"P"))
 S ECARRY("P","PCECPT")=$P(NODE,"^")
 S ECARRY("P","DX")=$P(NODE,"^",2)
 S ECARRY("P","AO")=$P(NODE,"^",3)
 S ECARRY("P","IR")=$P(NODE,"^",4)
 S ECARRY("P","ENV")=$P(NODE,"^",5)
 S ECARRY("P","SC")=$P(NODE,"^",6)
 ;
 ;- Get "PCE" node fields to validate
 S NODE=$G(^ECH(ECIEN,"PCE"))
 S ECARRY("PCE","PROCDT")=$P(NODE,"~")
 S ECARRY("PCE","DFN")=$P(NODE,"~",2)
 S ECARRY("PCE","CLIN")=$P(NODE,"~",3)
 S ECARRY("PCE","INST")=$P(NODE,"~",4)
 S ECARRY("PCE","DSSID")=$P(NODE,"~",5)
 S ECARRY("PCE","PROV")=$P(NODE,"~",6)
 S ECARRY("PCE","PROV2")=$P(NODE,"~",7)
 S ECARRY("PCE","PROV3")=$P(NODE,"~",8)
 S ECARRY("PCE","VOL")=$P(NODE,"~",9)
 S ECARRY("PCE","CPT")=$P(NODE,"~",10)
 S ECARRY("PCE","DX")=$P(NODE,"~",11)
 S ECARRY("PCE","AO")=$P(NODE,"~",12)
 S ECARRY("PCE","IR")=$P(NODE,"~",13)
 S ECARRY("PCE","ENV")=$P(NODE,"~",14)
 S ECARRY("PCE","SC")=$P(NODE,"~",15)
 S ECARRY("PCE","ECNAT")=$P(NODE,"~",16)
 S SUCCESS=1
GETQ Q SUCCESS
 ;
ADD2TMP2(ECIEN,ECARRY) ;- Add error records to ^TMP array for e-mail message
 ;
 ;   Input:   ECIEN = EC Patient record IEN
 ;           ECARRY = Local array containing EC Patient record fields,
 ;                    passed by reference
 ;
 ;  Output:
 ;  Function value:   1 = successful
 ;                    0 = unsuccessful
 ;
 N ECDSS,ECPAT,ECPR,ECPRDT,SUCCESS
 S SUCCESS=1
 ;
 ;- Drops out if invalid condition
 D
 . I '$G(ECIEN) S SUCCESS=0 Q
 .;
 .;- DSS Unit
 . S ECDSS=$P($G(^ECD(ECARRY("DSSU"),0)),"^")
 .;
 .;- Procedure Date/Time
 . S ECPRDT=$$FMTE^XLFDT(ECARRY("PROCDT"),+2)
 .;
 .;- Procedure
 . S ECPR=$S(ECARRY("PROC")["EC":$P($G(^EC(725,+ECARRY("PROC"),0)),"^"),1:$P($G(^ICPT(+ECARRY("PROC"),0)),"^",2))
 .;
 .;- Patient Name
 . S ECPAT=$P($G(^DPT(+ECARRY("DFN"),0)),"^")
 .;
 .;- Set ^TMP array
 . S ^TMP("EC2P7CU2",$J,ECIEN)=ECDSS_"^"_ECPAT_"^S^"_ECPRDT_"^"_ECPR
 Q SUCCESS
 ;
CREMSG2 ;- Create e-mail message when clean up has finished
 ;
 ;   Input:   None
 ;
 ;  Output:   None
 ;
 N ECBL,ECEXIST,ECLINE,I,X
 S ECBL="",$P(ECBL," ",30)=""
 S (ECEXIST,I)=0
 D LINE^EC2P7CU2("")
 D LINE^EC2P7CU2("")
 D LINE^EC2P7CU2("       This is a listing of all records in the Event Capture Patient")
 D LINE^EC2P7CU2("       file (#721) that were entered since 10/1/97, do not have")
 D LINE^EC2P7CU2("       a complete dataset, and are to be sent to PCE.")
 D LINE^EC2P7CU2("")
 D LINE^EC2P7CU2("")
 D LINE^EC2P7CU2("DSS Unit             Patient Name       Send    Procedure        Procedure")
 D LINE^EC2P7CU2("                                       to PCE     Date")
 D LINE^EC2P7CU2("===============================================================================")
 D LINE^EC2P7CU2("")
 D LINE^EC2P7CU2("")
 F  S I=$O(^TMP("EC2P7CU2",$J,I)) Q:'I  D
 . S ECEXIST=1,X=$G(^TMP("EC2P7CU2",$J,I))
 . S ECLINE=$E($P(X,"^")_ECBL,1,20)_" "_$E($P(X,"^",2)_ECBL,1,20)_" "_$E($P(X,"^",3)_ECBL,1,2)_" "_$E($P(X,"^",4)_ECBL,1,15)_" "_$E($P(X,"^",5)_ECBL,1,18)
 . D LINE^EC2P7CU2(ECLINE)
 ;
 I 'ECEXIST D LINE^EC2P7CU2("          > > > > > >     No records needed correction     < < < < < <")
 K ^TMP("EC2P7CU2",$J)
 Q
