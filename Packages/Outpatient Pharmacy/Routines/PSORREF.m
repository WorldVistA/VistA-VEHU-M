PSORREF ;AITC/BWF - Remote RX retrieval API ;12/12/16 3:21pm
 ;;7.0;OUTPATIENT PHARMACY;**454,475,497,643,740**;DEC 1997;Build 18
 ;
 Q
 ; RET    - return data
 ; RXNUM  - RX Number from remote system
 ; FDATE  - Fill Date
 ; MW     - Mail/Window - Default of 'W' for now.
 ; RPHARM - Pharmacist from remote site
 ; RPHONE - Contact number
 ; RSITE  - Filling site number
 ;
REMREF(RET,RXNUM,FDATE,MW,RPHARM,RPHONE,RSITE,RX0,RX2,RXSTA,RPROV,RSIG,RREF0,ROR1,RX3) ;
 ;
 N MSG,BACK,PSOPAR,RRXIEN,PSOSIEN,DSUPP,LASTREF,XTMPLOC,PASSLOC,HFSIEN,FULLPTH,HFSDONE,PTHDAT,PTHPIECE,FOUND,STRT,STATION,FTGOPEN,PPL1,PSOSITE
 N PSOX,PTHFILE,SITENUM,X,X1,X2,HDRUG,CSVAL,PSISSDT,TFILLS,OFFSET,CHKDT,DINACT,DEL,FTGSTRT,PDIR,PFIL,PSODTCUT,PSOEXREP,PSOPHDUZ
 N PSODFDIR,PSOFNAME,PAR,DELARR,RREFIEN
 N PSOBBC,PSOBBC1,PSODIR,PSOMVH,CLOZVAL,NOONEVA
 ; check 3rd party payer rejects. Send message to initiating site if applicable.
 S $ETRAP="D ^%ZTER Q"
 S RET(0)=""
 S RRXIEN=$O(^PSRX("B",RXNUM,0)),PSOSIEN=$$GET1^DIQ(52,RRXIEN,20,"I")
 I '$$GET1^DIQ(59.7,1,101,"I") D  Q
 .S RET(1)="The OneVA pharmacy flag is turned 'OFF' at this facility."
 .S RET(2)="Unable to process refill/partial fill requests."
 .D RET0
 ; PSO*7*497 - trade name block/titration block
 I $$GET1^DIQ(52,RRXIEN,6.5,"E")]"" D  Q
 .D RET0
 .S RET(1)="This prescription cannot be refilled or partial filled because it has a value"
 .S RET(2)="entered in the Rx trade name field.  Please follow local policy for obtaining"
 .S RET(3)="a new prescription."
 I $$TITRX^PSOUTL(RRXIEN)="t" S RET(1)="Cannot refill prescription - type is Titration. You may request a partial fill." D RET0 Q
 ; PSO*7*497 - end trade name/titration block
 S PSOPHDUZ=$$GET1^DIQ(52,RRXIEN,23,"I") I 'PSOPHDUZ S PSOPHDUZ=.5
 S HDRUG=$$GET1^DIQ(52,RRXIEN,6,"I")
 I '$$VALIDDRUG(HDRUG) D RET0 Q  ;Validate entry in file 50
 S PSOPAR=$G(^PS(59,PSOSIEN,1)),PSOSITE=PSOSIEN
 S RPHONE=$G(RPHONE,"")
 ; check to see if this action will throw the prescription into suspense. If so, quit and return a message
 S DSUPP=$$GET1^DIQ(52,RRXIEN,8,"I")
 S X2=-120,X1=DT D C^%DTC S PSODTCUT=X
 S (PSODFN,PSOREF("PSODFN"))=$$GET1^DIQ(52,RRXIEN,2,"I") K PSOSD D ^PSOBUILD
 N RXN K PSORX("FILL DATE") S PSOFROM="REFILL" S PSOREF("DFLG")=0,PSOREF("IRXN")=$O(^PSRX("B",RXNUM,0)),PSOREF("QFLG")=0
 I $$LMREJ^PSOREJU1(RXNUM,,.MSG,.BACK) S RET(1)=MSG D RET0 Q
 S PSORX("FILL DATE")=FDATE
 K PSOID D START^PSORREF1(FDATE) I PSOREF("DFLG") D EOJ Q
 ; check ability to refill given issue date/days supply
 S PSISSDT=$$GET1^DIQ(52,RRXIEN,1,"I")
 S TFILLS=$O(^PSRX(RRXIEN,1,"A"),-1)+1
 S OFFSET=DSUPP*TFILLS,OFFSET=OFFSET-10
 S CHKDT=$$FMADD^XLFDT(PSISSDT,OFFSET)
 I PSORX("FILL DATE")<CHKDT D RET0 S RET(1)="Cannot refill Rx# "_RXNUM_". Next possible fill date is "_$$FMTE^XLFDT(CHKDT,"5D") Q
 I PSORX("FILL DATE")>$$GET1^DIQ(52,RRXIEN,26,"I") D RET0 S RET(1)="Cannot refill Rx# "_RXNUM_".",RET(2)="Cannot refill after expiration date "_$$GET1^DIQ(52,RRXIEN,11,"E") Q
 D PROCESS^PSORREF0(.RET)
 ; make sure not errors are returned
 I $D(RET(1)) D EOJ Q
 I '$D(RET(1)) D
 .; bwf 8/14/14 - set up needed variables for label printing
 .S PSODFN=$P(^PSRX(RRXIEN,0),U,2)
 .S PSORX("IRXN")=RXNUM
 .S PSORX("PSOL",1)=RRXIEN_","
 .S PSORX("MAIL/WINDOW")="WINDOW"
 .S PSORX("NAME")=$$GET1^DIQ(2,PSODFN,.01)
 .S PSORX("QFLG")=0
 .S PSORX("METHOD OF PICKUP")=""
 .S PSOX=$G(^PS(55,PSODFN,"PS")) I PSOX]"" S PSORX("PATIENT STATUS")=$P($G(^PS(53,PSOX,0)),"^")
 .S PPL1=RRXIEN
 .; bwf 8/14/14 - end setup for label printing.
 .S PSODFDIR=$$DEFDIR^%ZISH()
 .S PSOFNAME="PSOLBL_"_RXNUM_"_"_PSOSITE_"_"_DT_".DAT"
 .S FULLPTH=PSODFDIR_PSOFNAME
 .S HFSDONE=0,PTHDAT=""
 .; preserve IO
 .D SAVDEV^%ZISUTL("ONEVAHLIO")
 .S DELARR("PSOLBL_"_RXNUM_"_"_PSOSITE_"_"_DT_".DAT")="" S DEL=$$DEL^%ZISH(PSODFDIR,$NA(DELARR))
 .S PSOEXREP=1
 .; call out to generate label
 .D LABEL^PSORWRAP(RRXIEN,"HFS",PSOSITE,PSOPHDUZ,"",PSOFNAME)
 .S XTMPLOC="^XTMP(""PSORLBL"","_HLINSTN_","_+RXNUM_",1,0)"
 .S PASSLOC="XTMP(""PSORLBL"","_HLINSTN_","_+RXNUM_")"
 .K ^XTMP("PSORLBL",HLINSTN,+RXNUM,0)
 .S ^XTMP("PSORLBL",HLINSTN,+RXNUM,0)=DT_U_$$FMADD^XLFDT(DT,30)
 .; looks like we have to wait a moment before the file shows up.
 .S FTGSTRT=$$NOW^XLFDT,(FOUND,FTGOPEN)=0
 .N PAR S PAR=0
 .F  D  Q:$$NOW^XLFDT>$$FMADD^XLFDT(FTGSTRT,,,,15)!(FOUND)!(FTGOPEN)
 ..S FTGOPEN=$$FTG^%ZISH(PSODFDIR,PSOFNAME,XTMPLOC,4)
 ..I $O(^XTMP("PSORLBL",HLINSTN,+RXNUM,0)) S FOUND=1
 .S DELARR("PSOLBL_"_RXNUM_"_"_PSOSITE_"_"_DT_".DAT")="" S DEL=$$DEL^%ZISH(PSODFDIR,$NA(DELARR))
 .; restore IO
 .D USE^%ZISUTL("ONEVAHLIO"),RMDEV^%ZISUTL("ONEVAHLIO")
 .D UPDREF(.RET,RRXIEN,RPHARM,RPHONE,RSITE,PASSLOC)
 .S RET(1)="Rx # "_RXNUM_" refilled."
 .S RX0=$G(^PSRX(RRXIEN,0)),RX2=$G(^PSRX(RRXIEN,2)),RX3=$G(^PSRX(RRXIEN,3))
 .S RXSTA=$G(^PSRX(RRXIEN,"STA")),RPROV=$$GET1^DIQ(200,$P(RX0,U,4),.01,"E")_U_$$GET1^DIQ(200,$P(RX0,U,16),.01,"E")
 .S RSIG=$G(^PSRX(RRXIEN,"SIG"))
 .S RREFIEN=$O(^PSRX(RRXIEN,1,"A"),-1)
 .I RREFIEN S RREF0=$G(^PSRX(RRXIEN,1,RREFIEN,0))
 .S ROR1=$G(^PSRX(RRXIEN,"OR1"))
 D EOJ
 Q
VALIDDRUG(DRUGIEN) ;
 S DINACT=$$GET1^DIQ(50,DRUGIEN,100,"I")
 I DINACT>0,($$DT^XLFDT>DINACT) S RET(1)="Drug is inactive for Rx# "_RXNUM_". Cannot refill." D RET0 Q 0
 S CSVAL=$$GET1^DIQ(50,DRUGIEN,3,"E"),CSVAL=$E(CSVAL,1)
 I CSVAL,CSVAL>0,CSVAL<6 D RET0 S RET(1)="Rx #"_RXNUM_" cannot be refilled.",RET(2)="The associated drug is considered a controlled substance",RET(3)="at the host facility." Q 0
 S CLOZVAL=$$GET1^DIQ(50,DRUGIEN,17.5)  ; Clozapine Check PSO*7*740
 I CLOZVAL="PSOCLO1" S RET(1)="This is a Clozapine prescription.",RET(2)="Cannot refill Rx # "_RXNUM_"." Q 0
 ;
 S NOONEVA=$$GET1^DIQ(50,DRUGIEN,907)
 I NOONEVA="YES" S RET(1)="Remote Site Drug is restricted from OneVA Pharmacy processing.",RET(2)="Cannot refill Rx # "_RXNUM_"." Q 0
 Q 1
EOJ ;
 D RET0
 K PSOMSG,PSOREF,PSORX("BAR CODE"),PSOLIST,LFD,MAX,MIN,NODE,PS,PSOERR,REF,RF,RXO,RXN,RXP,RXS,SD,VAERR,PSORX("FILL DATE")
 K PSOFROM,PSODFN,PSORX
 Q
 ; build ret(0) if needed
RET0 ;
 I '$L(RET(0)) S RET(0)=0_U_RXNUM_U_RRXIEN_U_U_FDATE,$P(RET(0),U,15)=$G(RPHARM),$P(RET(0),U,16)=$G(RPHONE),$P(RET(0),U,17)=$G(RSITE)
 Q
 ;
ULK ;
 Q
 ; successful refill. Update data, and build response
UPDREF(PSOMSG,PSOIEN,RPHARM,RPHONE,RSITE,PASSLOC) ;
 N REFIEN,REFIENS,REFDATA,FIL,RXNUM,RFILLDT,QTY,DSUPP,CLERK,LOGDATE,IDIV,EDIV,DISPDT,NDC,FDA,DNAME,DIEN,DAT
 S FIL=52.1
 ; get last refill data node
 S REFIEN=$O(^PSRX(PSOIEN,1,"B",DT,""),-1)
 S RXNUM=$$GET1^DIQ(52,PSOIEN,.01,"E")
 S DNAME=$$GET1^DIQ(52,PSOIEN,6,"E")
 S DIEN=$$GET1^DIQ(52,PSOIEN,6,"I")
 S REFIENS=REFIEN_","_PSOIEN_","
 ; first, set in the remote pharmacist data
 S FDA(FIL,REFIENS,91)=RSITE
 S FDA(FIL,REFIENS,92)=RPHARM
 S FDA(FIL,REFIENS,93)=RPHONE
 D FILE^DIE(,"FDA") K FDA
 ; now query data and build RET(0) holding accurate information from the refill multiple
 D GETS^DIQ(FIL,REFIENS,"**","IE","REFDATA")
 S RFILLDT=$G(REFDATA(FIL,REFIENS,.01,"I"))
 S QTY=$G(REFDATA(FIL,REFIENS,1,"I"))
 S DSUPP=$G(REFDATA(FIL,REFIENS,1.1,"I"))
 S CLERK=$G(REFDATA(FIL,REFIENS,6,"E"))
 S LOGDATE=$G(REFDATA(FIL,REFIENS,7,"I"))
 ; internal division number (IEN to PSO SITE file)
 S IDIV=$G(REFDATA(FIL,REFIENS,8,"I"))
 S EDIV=$G(REFDATA(FIL,REFIENS,8,"E"))
 S DISPDT=$G(REFDATA(FIL,REFIENS,10.1,"I"))
 S NDC=$G(REFDATA(FIL,REFIENS,11,"E"))
 S RSITE=$G(REFDATA(FIL,REFIENS,91,"I"))
 S RPHARM=$G(REFDATA(FIL,REFIENS,92,"E"))
 S RPHONE=$G(REFDATA(FIL,REFIENS,93,"E"))
 S $P(DAT(1),U,3)=RXNUM,$P(DAT(1),U,4)=RSITE,$P(DAT(1),U,7)=QTY,$P(DAT(1),U,8)=DISPDT,$P(DAT(1),U,9)=DNAME,$P(DAT(1),U,10)=DSUPP,$P(DAT(1),U,11)=RPHARM,$P(DAT(1),U,12)=RFILLDT
 D LOGDATA^PSORWRAP($NA(DAT),"OR",,,PSOIEN,REFIEN)
 S PSOMSG(0)=1_U_RXNUM_U_PSOIEN_U_REFIEN_U_RFILLDT_U_DNAME_U_QTY_U_DSUPP_U_CLERK_U_LOGDATE_U_IDIV_U_EDIV_U_DISPDT_U_NDC_U_RPHARM_U_RPHONE_U_RSITE_U_PASSLOC
 Q
 ;
ACT(PSORTYPE,PSORIEN,PSORFILL) ;
 ;Add activity log entry at Host Site for Dispensing Site OPAI send
 N PSOJ,PSOIR
 S PSOIR=0 F PSOJ=0:0 S PSOJ=$O(^PSRX(PSORIEN,"A",PSOJ)) Q:'PSOJ  S PSOIR=PSOJ
 S PSOIR=PSOIR+1,^PSRX(PSORIEN,"A",0)="^52.3DA^"_PSOIR_"^"_PSOIR
 S ^PSRX(PSORIEN,"A",PSOIR,0)=DT_"^"_"X^^"_PSORFILL_"^"_$S(PSORTYPE="R":"Refill",1:"Partial")_" sent to external interface."
 Q
 ;
ACTD(PSOREASN,PSOMSG) ;Update Activity log at host site for OPAI Dispensed Fill, called from PSORLLLI 
 ;PSOREASN - the actvity log reason (N - FOR DISPENSE COMPLETION or X - FOR INTERFACE)
 N PSOJ,PSOIR
 S PSOIR=0 F PSOJ=0:0 S PSOJ=$O(^PSRX(PSOHIENR,"A",PSOJ)) Q:'PSOJ  S PSOIR=PSOJ
 S PSOIR=PSOIR+1,^PSRX(PSOHIENR,"A",0)="^52.3DA^"_PSOIR_"^"_PSOIR
 S ^PSRX(PSOHIENR,"A",PSOIR,0)=DT_"^"_$G(PSOREASN)_"^^"_$S(PSOHTPE="RF":PSOHSUBR,1:6)_"^"_$G(PSOMSG)
 Q
 ;
UPDH ;continue update of Dispensing Information at Host Site, called from PSORLLLI
 I PSOHTPE="RF" D  Q
 .Q:'$D(^PSRX(PSOHIENR,1,PSOHSUB,0))
 .S $P(^PSRX(PSOHIENR,1,PSOHSUB,"RF"),"^",5)=$G(PSOHCHEK)
 .S $P(^PSRX(PSOHIENR,1,PSOHSUB,"RF"),"^",6)=$G(PSOHFILL)
 .S $P(^PSRX(PSOHIENR,1,PSOHSUB,0),"^",6)=$G(PSOHFLOT)
 .S $P(^PSRX(PSOHIENR,1,PSOHSUB,0),"^",14)=$G(PSOHSMAN)
 .S $P(^PSRX(PSOHIENR,1,PSOHSUB,0),"^",15)=$G(PSOHSEXP)
 Q:'$D(^PSRX(PSOHIENR,"P",PSOHSUB,0))
 S $P(^PSRX(PSOHIENR,"P",PSOHSUB,"PF"),"^",5)=$G(PSOHCHEK)
 S $P(^PSRX(PSOHIENR,"P",PSOHSUB,"PF"),"^",6)=$G(PSOHFILL)
 S $P(^PSRX(PSOHIENR,"P",PSOHSUB,0),"^",6)=$G(PSOHFLOT)
 S $P(^PSRX(PSOHIENR,"P",PSOHSUB,0),"^",12)=$G(PSOHSNDC)
 S $P(^PSRX(PSOHIENR,"P",PSOHSUB,1),"^")=$G(PSOHSMAN)
 S $P(^PSRX(PSOHIENR,"P",PSOHSUB,1),"^",5)=$G(PSOHSEXP)
 Q
