PSOVCCA ;BIR/JLC,KML - VCC PRESCRIPTION REFILL APIS ; Nov 22, 2023@13:04:43
 ;;7.0;OUTPATIENT PHARMACY;**642,679,712,745**;DEC 1997;Build 23
 ;
 ; Reference to PSOL^PSSLOCK,PSOUL^PSSLOCK in ICR #2789
 Q
AP1(PSORET,PSODFN,PSORX,PSOUSER,PSORFSRC,PSORTFLG) ;ACCEPT REQUEST
 ; Input:  PSODFN     (required) - Patient IEN Number
 ;         PSORX      (required) - Prescription Number
 ;         PSOUSER    (optional) - User requesting refill
 ;         PSORFSRC   (optional) - the source system from which the REFILL
 ;                                 request Originated (e.g., VCC, CPRS, VSE)
 ;         PSORTFLG   (optional) - 1 or empty (null) - the return flag; if = 1 then the RPC will
 ;                                 return the numeric code with the error text; if = null
 ;                                 then the RPC will only return the numeric code (-5, -4, -3, 0, or 1 )
 ; Output: PSORET - Return Value
 ;         See IA# 7313 for description and values
 ;
 ; route processing to appropriate tag
 I $G(PSORTFLG)="" D SIMPLE($G(PSODFN),$G(PSORX),$G(PSOUSER),$G(PSORFSRC)) Q
 D EXPANDED($G(PSODFN),$G(PSORX),$G(PSOUSER),$G(PSORFSRC))
 Q
 ;
SIMPLE(PSODFN,PSORX,PSOUSER,PSORFSRC) ;
 ;NOTE: if no refill source is passed, the assumption will be that
 ;the source is the VAHC-CRM platform (fka VCC). This is to ensure
 ;backwards compatibility until the changes are made to the CRM
 ;system to pass in the source and request the expanded error messages
 N PSRX,PSRXD,IEN,PSORR,PSOICN,SITE,PSOSITE,ERR,PSOITMG
 I $G(PSORFSRC)="" S PSORFSRC="CRM"
 I $G(PSODFN)="" S PSORET(0)=-4 G QUITAP1
 S PSOICN=+$$GETICN^MPIF001(PSODFN)
 I +$G(PSOICN)=-1 S PSORET(0)=-4 G QUITAP1
 I $G(PSORX)="" S PSORET(0)=-3 G QUITAP1
 I $O(^PSRX("B",PSORX,""))="" S PSORET(0)=-3 G QUITAP1
 I '$D(^PSRX("B",PSORX)) S PSORET(0)=-3 G QUITAP1
 S PSRX=$O(^PSRX("B",PSORX,"")),PSRXD=$G(^PSRX(PSRX,0))
 I PSRXD="" S PSORET(0)=-3 G QUITAP1
 I $P(PSRXD,"^",2)'=PSODFN S PSORET(0)=-5 G QUITAP1
 D PSOL^PSSLOCK(PSRX) I '$G(PSOMSG) K PSOMSG S PSORET(0)=-8 G QUITAP1
 D PSOUL^PSSLOCK(PSRX)
 N UNPARK,PSOTIT,ERRMSG S (UNPARK,PSOTIT)=0
 D CHKPARK I $D(ERRMSG) S PSORET(0)=-8 G QUITAP1
 I PSOTIT D  G QUITAP1
 .I PSOTIT=1 S PSORET(0)=-6
 .I PSOTIT=2 S PSORET(0)=-7
 I $G(UNPARK) S PSORET(0)=1 Q  ;*712
 D REF^PSOATRFV(PSRX,PSOUSER,PSORFSRC,.ERR)
 I $D(ERR) S PSORET(0)=0 Q
 S PSORET(0)=1
QUITAP1 Q
 ;
EXPANDED(PSODFN,PSORX,PSOUSER,PSORFSRC) ;
 N PSRX,PSRXD,IEN,PSORR,PSOICN,SITE,PSOSITE,ERR,X1,PSOITMG
 I $G(PSODFN)="" S PSORET(0)="-4 - Missing or Invalid Patient ID" Q
 S PSOICN=+$$GETICN^MPIF001(PSODFN)
 I +$G(PSOICN)=-1 S PSORET(0)="-6 - Patient is not assigned an ICN" Q
 I $G(PSORX)="" S PSORET(0)="-3 - Missing or Invalid Prescription Number" Q
 I $O(^PSRX("B",PSORX,""))="" S PSORET(0)="-3 - Missing or Invalid Prescription Number" Q
 I '$D(^PSRX("B",PSORX)) S PSORET(0)="-3 - Missing or Invalid Prescription Number" Q
 S PSRX=$O(^PSRX("B",PSORX,"")),PSRXD=$G(^PSRX(PSRX,0))
 I PSRXD="" S PSORET(0)="-3 - Missing or Invalid Prescription Number" Q
 I $P(PSRXD,"^",2)'=PSODFN S PSORET(0)="-5 - Prescription Number does not match to the Patient" Q
 D PSOL^PSSLOCK(PSRX) I '$G(PSOMSG) K PSOMSG S PSORET(0)="-8 - Prescription unavailable - try again later" Q
 D PSOUL^PSSLOCK(PSRX)
 N UNPARK,PSOTIT,ERRMSG S (UNPARK,PSOTIT)=0
 D CHKPARK I $D(ERRMSG) S PSORET(0)="-8 - Prescription unavailable - try again later" Q
 I PSOTIT D  Q
 .I PSOTIT=1 S PSORET(0)="-6 -'Titration Rx' cannot be refilled."
 .I PSOTIT=2 S PSORET(0)="-7 - No more refills left."
 I $G(UNPARK) S PSORET(0)="1 - Prescription is unparked and placed in Suspended status" Q  ;*712
 D REF^PSOATRFV(PSRX,PSOUSER,PSORFSRC,.ERR)
 I $D(ERR) S PSORET(0)=0 M PSORET=ERR Q
 S PSORET(0)="1 - Prescription successfully refilled"
 Q
 ;
CHKPARK ; if order is parked and last fill label is not printed, reuse the last fill instead of placing a new refill *712
 N ORRFILL,DA,PSOZF
 S ORRFILL=1,DA=PSRX
 I $G(^PSRX(DA,"STA"))'=0  Q
 I $G(^PSRX(DA,"PARK"))'=1 Q
 ; *712 PAPI - don't quit here if filling original parked titration
 I $$TITRX^PSOUTL(DA)="t",'$$CHKPRKORIG^PSOPRKA(DA) S PSOTIT=1 Q
 I $P(^PSRX(DA,0),"^",9)=0 D  Q:PSOTIT
 .D GETRELDT^PSOPRKA(DA) I RSDT S PSOTIT=2 Q
 .D CHKLBL^PSOPRKA(DA,0) I LBLP S PSOTIT=2 Q
 .D ^PSOCMOPA I $D(PSOCMOP) S PSOTIT=2
 I $P(^PSRX(DA,0),"^",9)>0 D  Q:PSOTIT
 .N NRF S NRF=$P(^PSRX(DA,0),"^",9)
 .S PSOZF=+$O(^PSRX(DA,1,99999),-1) Q:'PSOZF
 .D GETRELDT^PSOPRKA(DA)
 .I RSDT D  Q
 ..I NRF>PSOZF Q
 ..E  S PSOTIT=2 Q
 .D CHKLBL^PSOPRKA(DA,PSOZF)
 .I LBLP D  Q
 ..I NRF>PSOZF Q
 ..E  S PSOTIT=2 Q
 .D ^PSOCMOPA
 .I $D(PSOCMOP) D
 ..I NRF>PSOZF Q
 ..E  S PSOTIT=2 Q
 D UNPARK^PSOPRKA(PSRX,PSODFN,.ERRMSG)
 Q
