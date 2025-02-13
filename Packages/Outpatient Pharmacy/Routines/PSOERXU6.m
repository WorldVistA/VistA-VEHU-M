PSOERXU6 ;ALB/BWF - eRx utilities ;Feb 10, 2022@11:04
 ;;7.0;OUTPATIENT PHARMACY;**508,551,581,631,617,672,715,700,746**;DEC 1997;Build 106
 ;
 Q
 ; auto discontinue orders related to cancel request
 ; ERXIEN is the IEN of the cancel request
CANDC(ERXIEN,INST,PSSRET) ;
 N NERXIEN,RXIEN,RELMIEN,NRXOPIEN,NRXPNIEN,REOPIEN,REPNIEN,ACOMACT,ACOMPEND,CANTYPE,NRXVPAT,CNT,ADAT,ARY,ALOOP,DONE
 N PENDIEN,RXIEN,PSSRET,PREVORD,RRRETYPE,RXFAIL,PENFAIL,ARESP,FORORD,PON,VARENEW,LSTMSG,RELIEN,SENDMSG,DELFLG,DELTXT
 S CNT=0
 S NERXIEN=$$RESOLV^PSOERXU2(ERXIEN)
 S NRXVPAT=$$GET1^DIQ(52.49,NERXIEN,.05,"I")
 S NRXOPIEN=$$GET1^DIQ(52.49,NERXIEN,.13,"I")
 S NRXPNIEN=$$GET1^DIQ(52.49,NERXIEN,25.2,"E")
 S CNT=CNT+1,ARY(CNT)=NRXPNIEN_U_NRXOPIEN
 S RELMIEN=0 F  S RELMIEN=$O(^PS(52.49,NERXIEN,201,"B",RELMIEN)) Q:'RELMIEN  D
 .I ",RE,CX,"'[$$GET1^DIQ(52.49,RELMIEN,.08,"I") Q
 .S REOPIEN=$$GET1^DIQ(52.49,RELMIEN,.13,"I")
 .S REPNIEN=$$GET1^DIQ(52.49,RELMIEN,25.2,"E")
 .S CNT=CNT+1,ARY(CNT)=REPNIEN_U_REOPIEN_U_RELMIEN
 ; if there is only one, it is the NewRx
 I CNT=1 D  Q
 .S ADAT=$G(ARY(CNT))
 .S PENDIEN=$P(ADAT,U),RXIEN=$P(ADAT,U,2)
 .; if there is an associated RXIEN, this is active and the pending item no longer exists.
 .I RXIEN D
 ..S ACOMACT=$$CANACT(ERXIEN,RXIEN,INST,.PSSRET)
 ..S FORORD=$$GET1^DIQ(52,RXIEN,39.5,"I")
 ..I FORORD S PON=$$GET1^DIQ(52,FORORD,39.3,"I")
 ..I FORORD,'$$CHKERX^PSOERXU1(FORORD) S VARENEW=1
 .I 'RXIEN,PENDIEN D
 ..I $$GET1^DIQ(52.41,PENDIEN,1,"I")'=NRXVPAT S DONE=1 Q
 ..S ACOMPEND=$$CANPEND(ERXIEN,PENDIEN,INST,.PSSRET)
 .; if either failed, update the status and do not send the response
 .Q:$G(DONE)
 .I $D(ACOMACT),'$P(ACOMACT,U) S RXFAIL=1
 .I $D(ACOMPEND),'$P(ACOMPEND,U) S PENFAIL=1
 .I $G(RXFAIL)!($G(PENFAIL))!($P($G(ACOMACT),U)=2) D  Q
 ..I $G(RXFAIL)!($P($G(ACOMACT),U)=2) S ARESP=$P(ACOMACT,U,2)
 ..I $G(PENFAIL),'$D(ARESP) S ARESP=$P($G(ACOMPEND),U,2)
 ..D UPDSTAT^PSOERXU1(NERXIEN,"CAN",$G(ARESP))
 ..; if this is a 'deleted' rx, update the status, cancel all related and quit.
 ..I $P($G(ACOMACT),U)=2 D  Q
 ...D UPDSTAT^PSOERXU1(ERXIEN,"CAH",$P($G(ACOMACT),U,2)),CANRELHQ(NERXIEN) Q
 ..D UPDSTAT^PSOERXU1(ERXIEN,"CAF",ARESP)
 ..D CANRELHQ(NERXIEN)
 .I $D(ACOMACT),$P(ACOMACT,U) S ARESP=$P(ACOMACT,U,2)
 .I '$L($G(ARESP)),$D(ACOMPEND),$P(ACOMPEND,U) S ARESP=$P(ACOMPEND,U,2)
 .; only send the automated response if the auto-dc was successful, and the rx status is not deleted
 .I '$G(VARENEW) D POST^PSOERXO1(ERXIEN,.PSSRET,,,,3,INST,ARESP)
 .; if there was an error, cancel the related items and quit. we do not want to override the CAX status
 .I $D(PSSRET("errorMessage")) D CANRELHQ(NERXIEN),UPDSTAT^PSOERXU1(NERXIEN,"CAN",ARESP) Q
 .I RXIEN,$$VARENEW(RXIEN) D  Q
 ..D UPDSTAT^PSOERXU1(NERXIEN,"CAN","eRx was renewed within the VA.")
 ..D UPDSTAT^PSOERXU1(ERXIEN,"CAH","eRx was renewed within the VA.")
 ..D CANRELHQ(NERXIEN)
 .D UPDSTAT^PSOERXU1(NERXIEN,"CAN",ARESP)
 .I '$G(FORORD) D UPDSTAT^PSOERXU1(ERXIEN,"CAO",$G(ARESP))
 .I $G(FORORD) D UPDSTAT^PSOERXU1(ERXIEN,"CAH",$G(ARESP))
 .D CANRELHQ(NERXIEN)
 ; if there is more than one, renewals have occured.
 S ALOOP=99999,DONE=0
 F  S ALOOP=$O(ARY(ALOOP),-1) Q:'ALOOP!(DONE)  D
 .S ADAT=$G(ARY(ALOOP))
 .; if there is a pending IEN and no RX IEN, we know this has not yet been processed into a live prescription
 .; and is a renwewal from a previous prescription.
 .S PENDIEN=$P(ADAT,U),RXIEN=$P(ADAT,U,2),RELIEN=$P(ADAT,U,3)
 .I RXIEN D  Q
 ..I $G(PENDIEN),$$GET1^DIQ(52.41,PENDIEN,1,"I")=NRXVPAT D  Q
 ...S ACOMPEND(ALOOP)=$$CANPEND(ERXIEN,PENDIEN,INST,.PSSRET)
 ...S ACOMACT(ALOOP)=$$CANACT(ERXIEN,RXIEN,INST,.PSSRET)
 ...S FORORD=$$GET1^DIQ(52,RXIEN,39.5,"I")
 ...I FORORD S PON=$$GET1^DIQ(52,FORORD,39.3,"I")
 ...I FORORD,'$$CHKERX^PSOERXU1(PON) S VARENEW=1
 ..S ACOMACT(ALOOP)=$$CANACT(ERXIEN,RXIEN,INST,.PSSRET)
 .I PENDIEN,'RXIEN D  Q
 ..; if this pending item is not for the right patient, quit
 ..I $G(PENDIEN),$$GET1^DIQ(52.41,PENDIEN,1,"I")'=NRXVPAT S DONE=1 Q
 ..S PREVORD=$$GET1^DIQ(52.41,PENDIEN,22.1,"E")
 ..I '$G(PREVORD) D  Q
 ...S ACOMPEND(ALOOP)=$$CANPEND(ERXIEN,PENDIEN,INST,.PSSRET)
 ..S ACOMPEND(ALOOP)=$$CANPEND(ERXIEN,PENDIEN,INST,.PSSRET)
 ..S ACOMACT(ALOOP)=$$CANACT(ERXIEN,PREVORD,INST,.PSSRET)
 ; now check all results for failures
 N ACTLP,ACTFL,ACTMSG,PENLP,PENFL,PENMSG
 S (ACTLP,ACTFL)=0 F  S ACTLP=$O(ACOMACT(ACTLP)) Q:'ACTLP  D
 .I $P(ACOMACT(ACTLP),U)=0 S ACTFL=ACTFL+1
 .I $P(ACOMACT(ACTLP),U)=1 S ACTMSG(ACTFL)=$P(ACOMACT(ACTLP),U,2)
 .I $P(ACOMACT(ACTLP),U)=2 S DELFLG=1,DELTXT=$P(ACOMACT(ACTLP),U,2)
 S (PENLP,PENFL)=0 F  S PENLP=$O(ACOMPEND(PENLP)) Q:'PENLP  D
 .I $P(ACOMPEND(PENLP),U)=0 S PENFL=PENFL+1
 .I $P(ACOMPEND(PENLP),U)=1 S PENMSG(PENFL)=$P(ACOMPEND(PENLP),U,2)
 I $G(DELFLG) D  Q
 .D UPDSTAT^PSOERXU1(NERXIEN,"CAN",DELTXT)
 .D UPDSTAT^PSOERXU1(ERXIEN,"CAH",DELTXT)
 .D CANRELHQ(NERXIEN)
 I ACTFL>0!(PENFL>0) D  Q
 .D UPDSTAT^PSOERXU1(NERXIEN,"CAN")
 .D UPDSTAT^PSOERXU1(ERXIEN,"CAF")
 .D CANRELHQ(NERXIEN)
 ; get the last active rx status
 I $D(ACTMSG) D
 .S LSTMSG=$O(ACTMSG(99999),-1)
 .S SENDMSG=$G(ACTMSG(LSTMSG))
 I '$D(SENDMSG) D
 .S LSTMSG=$O(PENMSG(99999),-1)
 .S SENDMSG=$G(PENMSG(LSTMSG))
 I '$G(VARENEW) D POST^PSOERXO1(ERXIEN,.PSSRET,,,,3,INST,SENDMSG)
 I $G(VARENEW) D UPDSTAT^PSOERXU1(NERXIEN,"CAN","eRx was renewed within the VA.")
 I '$G(VARENEW) D UPDSTAT^PSOERXU1(NERXIEN,"CAN",$G(SENDMSG))
 ; if there was an error, cancel the related items and quit. we do not want to override the CAX status
 I $D(PSSRET("errorMessage")) D CANRELHQ(NERXIEN) Q 
 I '$G(VARENEW) D UPDSTAT^PSOERXU1(ERXIEN,"CAO")
 I $G(VARENEW) D UPDSTAT^PSOERXU1(ERXIEN,"CAH","eRx was renewed within the VA.")
 D CANRELHQ(NERXIEN)
 Q
CANRELHQ(NERXIEN) ;
 N RELMIEN,RRRETYPE
 ;I $$GET1^DIQ(52.49,NERXIEN,1,"E")'="CAN" Q
 S RELMIEN=0 F  S RELMIEN=$O(^PS(52.49,NERXIEN,201,"B",RELMIEN)) Q:'RELMIEN  D
 .S RRRETYPE=$$GET1^DIQ(52.49,RELMIEN,.08,"I")
 .I RRRETYPE="RE"!(RRRETYPE="RR")!(RRRETYPE="CR")!(RRRETYPE="CX") D
 ..D UPDSTAT^PSOERXU1(RELMIEN,"CAN")
 Q
CANACT(ERXIEN,RXIEN,INST,PSSRET) ;
 N NERXIEN,RXSTAT,UPDRXSTAT,ERXIENS,UPDRXSTA,PSOSITE,PSOSYS,PSODFN,ORN,PSOOPT,VALMSG
 S ERXIENS=ERXIEN_","
 S RXSTAT=$$GET1^DIQ(52,RXIEN,100,"I")
 S NERXIEN=$$RESOLV^PSOERXU2(ERXIEN)
 I (RXSTAT=12)!(RXSTAT=13)!(RXSTAT=14)!(RXSTAT=15) D  Q VALMSG
 .S ERRSEQ=$$ERRSEQ^PSOERXU1(ERXIEN) Q:'ERRSEQ
 .I RXSTAT=13 S VALMSG="2^Prescription is already DELETED at the Pharmacy."
 .I '$D(VALMSG) S VALMSG="1^Prescription is already discontinued at the Pharmacy."
 .D FILERR^PSOERXU1(ERXIENS,ERRSEQ,"PX","V",$G(VALMSG))
 S PSOSITE=$$GET1^DIQ(52,RXIEN,20,"I")
 S PSOSYS=$G(^PS(59.7,1,40.1)) Q:PSOSYS="" ""
 S PSODFN=$$GET1^DIQ(52,RXIEN,2,"I") Q:'PSODFN ""
 S PSOLST(1)=52_U_RXIEN_U_$$GET1^DIQ(52,RXIEN,100,"E")
 S ORN=1
 S PSOOPT=0
 D OERR^PSOCAN3(NERXIEN)
 S UPDRXSTA=$$GET1^DIQ(52,RXIEN,100,"I")
 I UPDRXSTA'=12,(UPDRXSTA'=14),(UPDRXSTA'=15) D  Q VALMSG
 .I UPDRXSTA=13 S VALMSG="2^Prescription has been DELETED at the Pharmacy."
 .S ERRSEQ=$$ERRSEQ^PSOERXU1(ERXIEN) Q:'ERRSEQ
 .I $L($G(VALMSG)) S VALMSG=0_U_$G(VALMSG)
 .I '$L($G(VALMSG)) S VALMSG="0^eRx auto-discontinue failed."
 .D FILERR^PSOERXU1(ERXIENS,ERRSEQ,"PX","V",$G(VALMSG))
 S ACOM=$$BLDRESP(RXIEN),ACOM=1_U_ACOM
 Q ACOM
 ; auto discontinue pending orders related to cancel request
 ; ERXIEN - cancel reqeust IEN
 ; PENDIEN - IEN for the pending order in file 52.41
CANPEND(ERXIEN,PENDIEN,INST,PSSRET) ;
 N ERXIENS,CANTYPE,ERRSEQ,VALMSG,PREVORD,NERXIEN,ORD,ACOM,REFL,TOTFILL,LDDATE,FFILL,PSODFN,PSONOOR,PSODFN,CANTYPEA,ORNUM,PSOPLCK
 S ERXIENS=ERXIEN_","
 Q:'PENDIEN
 Q:'$D(^PS(52.41,PENDIEN,0)) "1^Rx no longer in pending file."
 S NERXIEN=$$RESOLV^PSOERXU2(ERXIEN)
 S PSODFN=$$GET1^DIQ(52.41,PENDIEN,1,"I")
 S PSOPLCK=$$L^PSSLOCK(PSODFN,0)
 I '$G(PSOPLCK) D  Q ACOM
 .D LOCK^PSOORCPY
 .S ACOM=$S($P($G(PSOPLCK),"^",2)'="":"Patient record locked by "_$P($G(PSOPLCK),"^",2)_".",1:"Another person is entering orders for this patient.")
 .K PSOPLCK S ACOM=0_U_ACOM
 S CANTYPE=$$GET1^DIQ(52.41,PENDIEN,2,"I")
 ; if this is already DC'd. update status of the releated messages
 I CANTYPE="DC"!(CANTYPE="DE") D  Q VALMSG
 .S ERRSEQ=$$ERRSEQ^PSOERXU1(ERXIEN) Q:'ERRSEQ
 .S VALMSG="1^Pending Order is already discontinued."
 .D FILERR^PSOERXU1(ERXIENS,ERRSEQ,"PX","V",$G(VALMSG))
 .D UL^PSSLOCK(PSODFN)
 S ACOM="Rx was never dispensed. Canceled at Pharmacy."
 S ORD=PENDIEN
 S PSONOOR="W"
 D DEAD^PSOPTPST
 K ^PS(52.41,"AOR",$P(^PS(52.41,ORD,0),"^",2),+$P($G(^PS(52.41,ORD,"INI")),"^"),ORD),^PS(52.41,"AD",$P(^PS(52.41,ORD,0),"^",12),+$P($G(^PS(52.41,ORD,"INI")),"^"),ORD)
 S $P(^PS(52.41,ORD,0),"^",3)="DC",POERR("PLACER")=$P(^(0),"^"),POERR("STAT")="OC"
 S POERR("COMM")=$S($G(POERR("DEAD")):"Patient died on "_$G(PSOPTPST(2,PSODFN,.351))_".",1:ACOM),$P(^PS(52.41,ORD,4),"^")=POERR("COMM")
 D EN^PSOHLSN(POERR("PLACER"),POERR("STAT"),POERR("COMM"),PSONOOR)
 S CANTYPEA=$$GET1^DIQ(52.41,PENDIEN,2,"I")
 I CANTYPEA'="DC" D  Q VALMSG
 .S ERRSEQ=$$ERRSEQ^PSOERXU1(ERXIEN) Q:'ERRSEQ
 .S VALMSG="0^eRx auto-discontinue failed. Please contact Pharmacy."
 .D FILERR^PSOERXU1(ERXIENS,ERRSEQ,"PX","V",$G(VALMSG))
 .D UL^PSSLOCK(PSODFN)
 K POERR,PSOPTPST
 D UL^PSSLOCK(PSODFN)
 Q 1_U_ACOM
BLDRESP(RXIEN) ;
 N REFL,TOTFILL,LRDATE,FFILL,ACOM
 S (REFL,TOTFILL)=$$GET1^DIQ(52,RXIEN,9,"I"),I=0 F  S I=$O(^PSRX(RXIEN,1,I)) Q:'I  S REFL=REFL-1
 ; p715 Use last release date instead of last dispense date
 S LRDATE=$$RXRLDT^PSOBPSUT(RXIEN),LRDATE=$$FMTE^XLFDT(LRDATE,"2D")
 S FFILL=$$GET1^DIQ(52,RXIEN,22,"I"),FFILL=$$FMTE^XLFDT(FFILL,"2D")
 S ACOM="First Fill:"_FFILL_", Last Fill:"_$S(LRDATE:LRDATE,1:"      ")_", Refills Remaining:"_REFL
 Q ACOM
 ; find the newRx related to a message
FINDNRX(ERXIEN) ;
 N DONE,I,PREVIEN
 S DONE=0,PREVIEN=0
 I '$D(^PS(52.49,ERXIEN,201)) Q 0
 F I=1:1 D  Q:DONE
 .S PREVIEN=$$RESOLV^PSOERXU2(ERXIEN)
 .I 'PREVIEN S DONE=1 Q
 .I PREVIEN S ERXIEN=PREVIEN
 .I $$GET1^DIQ(52.49,PREVIEN,.08,"I")="N" S DONE=1 Q
 Q PREVIEN
JTQ(ERXIEN) ;
 N MEDA,XQY0,DFN,PATVAL,PSOFIN,POERR,PSOSORT,PTNM,PSODFN,PAT,MTYPE,PSOFINY,PSOLST,MTYPE,RESVAL
 N REVLN,HIGHLN,UNDERLN,BLINKLN,HIGUNDLN
 D FULL^VALM1
 S VALMBCK="R"
 I $G(PSOJUMP) S VALMSG="Cannot jump back, please use '^'" W $C(7) Q
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 S RESVAL=$$GET1^DIQ(52.49,ERXIEN,52.1,"I")
 I MTYPE'="N",((MTYPE'="RE")&(RESVAL'="R")),MTYPE'="CX" D  Q
 .W !,"Jumping can only be done on 'NewRx', 'Renewal Response - Replace' and fillable 'RxChange Response' messages." D DIRE^PSOERXX1 Q
 S XQY0="PSO LMOE FINISH"
 I $P($G(PSOPAR),"^",2),'$D(^XUSEC("PSORPH",DUZ)) S PSORX("VERIFY")=1
 S DFN=$$GET1^DIQ(52.49,ERXIEN,.05,"I")
 S PATVAL=$$GET1^DIQ(52.49,ERXIEN,1.14,"I")    ;LAL
 I 'DFN W !,"Vista patient has not been matched. Cannot jump to outpatient." D DIRE^PSOERXX1 Q
 I '$G(PATVAL) W !,"Vista patient has not been validated. Cannot jump to outpatient." D DIRE^PSOERXX1 Q    ;LAL
 S (PSOFIN,POERR)=1
 S PSOSORT="PATIENT"
 S PTNM=$$GET1^DIQ(2,DFN,.01,"E")
 S (PSODFN,PAT)=DFN,PSOFINY=DFN_U_PTNM
 ;PSO*7.0*672: Check for any pending Rx's. Do not restrict based on variable PSNPINST.
 ;I '$D(^PS(52.41,"AOR",PAT)) W !,"Patient has no pending prescriptions." D DIRE^PSOERXX1 Q
 W !,"Patient: "_PTNM,!
 ; new line SPAT2^PSOORFIN has been created to jump right into pending orders with the patient pre-selected
 S PSOJUMP=1
 D SPAT2^PSOORFIN,EX^PSOORFI1
 ;S X=PAT D ULP^PSOORFIN
 K PSORX,PSOJUMP
 Q
 ;
PN(ERXIEN) ; Enter VistA Patient Progress Notes
 ;Input: ERXIEN - Pointer to the ERX HOLDING QUEUE file (#52.49)
 ;
 N PSODFN S VALMBCK="R"
 S PSODFN=$$GET1^DIQ(52.49,ERXIEN,.05,"I")
 I 'PSODFN D  Q
 . S VALMSG="Vista patient has not been matched"
 I '$$GET1^DIQ(52.49,+$G(ERXIEN),1.14,"I") D  Q
 . S VALMSG="Vista patient has not been validated"
 ;
 D PRONTE^PSOORUT3 S VALMBCK="R"
 Q
 ;
VARENEW(OPIEN) ;
 N FORORD,VARENEW,PON
 S VARENEW=0
 S FORORD=$$GET1^DIQ(52,RXIEN,39.5,"I")
 I FORORD S PON=$$GET1^DIQ(52,FORORD,39.3,"I")
 I FORORD,'$$CHKERX^PSOERXU1(PON) S VARENEW=1
 Q VARENEW
SH(ERXIEN) ;
 N SIEN,IENS,F,LINE,SDTTM,ISTAT,ESTAT,EBY,SCOMM,CARY,ALOOP,STDESC,SDAT,UNACC,HFFDT
 D FULL^VALM1 S VALMBCK="R"
 S $P(LINE,"-",80)="" W !,LINE
 S F=52.4919
 I '$O(^PS(52.49,ERXIEN,19,0)) W !,"No Status History Available." D DIRE^PSOERXX1 Q
 S SIEN=0 F  S SIEN=$O(^PS(52.49,ERXIEN,19,SIEN)) Q:'SIEN  D
 .S IENS=SIEN_","_ERXIEN_","
 .D GETS^DIQ(F,IENS,"**","IE","SDAT")
 .S SDTTM=$$GET1^DIQ(52.4919,IENS,.01,"I"),SDTTM=$$FMTE^XLFDT(SDTTM,"2Z")
 .S ISTAT=$G(SDAT(F,IENS,.02,"I"))
 .S ESTAT=$G(SDAT(F,IENS,.02,"E"))
 .S STDESC=$$GET1^DIQ(52.45,ISTAT,.02,"E")
 .S EBY=$G(SDAT(F,IENS,.03,"E"))
 .S UNACC=$G(SDAT(F,IENS,.04,"I"))
 .S HFFDT=$G(SDAT(F,IENS,.05,"E"))
 .S SCOMM=$G(SDAT(F,IENS,1,"E")),SCOMM="Comments: "_SCOMM
 .K CARY
 .D TXT2ARY^PSOERXD1(.CARY,SCOMM,,80)
 .W !,SDTTM,?19,ESTAT,?26,STDESC_$S(UNACC:" (eRx Un-Accepted)",HFFDT'="":" ("_HFFDT_")",1:""),!,"Entered By: "_EBY ;"Comments: "_SCOMM,!
 .S ALOOP=0 F  S ALOOP=$O(CARY(ALOOP)) Q:'ALOOP  D
 ..W !,$G(CARY(ALOOP))
 .W !
 D DIRE^PSOERXX1
 Q
LSIG(SIG) ;
 N P,SGY
 S SGY="" F P=1:1:$L(SIG," ") S X=$P(SIG," ",P) D:X]""  ;
 .N PSOIN S PSOIN=$O(^PS(51,"B",X,0)) I PSOIN,($P(^PS(51,PSOIN,0),"^",4)<2)&($D(^PS(51,"A",X))) S %=^(X),X=$P(%,"^") I $P(%,"^",2)]"" S Y=$P(SIG,"",P-1),Y=$E(Y,$L(Y)) S:Y>1 X=$P(%,"^",2)
 .S SGY=SGY_" "_X
 Q $$UP^XLFSTR(SGY)
