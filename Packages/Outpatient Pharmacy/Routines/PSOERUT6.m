PSOERUT6 ;ALB/MFR - eRx & Pending Order Side-by-Side LM Display - Cont'd; 06/25/2023 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**700,746**;DEC 1997;Build 106
 ;
EN ; Continuation of PSOERUT5 due to routine size limit
 ;
 ; - Provider
 S XE="Provider: "_$$COMPARE^PSOERUT0("LM",$E(ERXPRVNM,1,29),PENDATA("PROVIDER NAME"),11)
 S XV="|"_$S('RENEWORD:"13) ",1:"6) ")_"Provider: "_$$COMPARE^PSOERUT0("LM",$E(PENDATA("PROVIDER NAME"),1,26),ERXPRVNM,$S('RENEWORD:55,1:54))
 S UNDERLN(LINE,41)=$S('RENEWORD:3,1:2)
 D ADDLINE^PSOERUT0("LM",NMSPC,XE,XV)
 S PRVIEN=$S($G(PENDATA("PROVIDER")):PENDATA("PROVIDER"),1:$$GET1^DIQ(52.41,ORDIEN,5,"I"))
 I $G(PKI),+$G(DRUGDATA("DEA"))>1,+$G(DRUGDATA("DEA"))<6 D
 . D CSPRV^PSOERUT4(PRVIEN,+VADRGIEN,$$GET1^DIQ(52.41,ORDIEN,.01,"I"))
 I $$GET1^DIQ(200,PRVIEN,53.7,"I"),$$GET1^DIQ(200,PRVIEN,53.8,"I") D
 . S XV="|Cos-Provider: "_$$COMPARE^PSOERUT0("LM",$$GET1^DIQ(200,PRVIEN,53.8),$$GET1^DIQ(200,PRVIEN,53.8),55)
 . D ADDLINE^PSOERUT0("LM",NMSPC,"",XV)
 D BLANKLN^PSOERUT0("LM")
 ;
 ; - Copies
 S VACLINIC=$$GET1^DIQ(52.41,ORDIEN,1.1)
 S COPIES=$S($G(PENDATA("COPIES")):PENDATA("COPIES"),1:1)
 S XV="|"_$S('RENEWORD:"14) ",1:"7) ")_"Copies: "_$$COMPARE^PSOERUT0("LM",COPIES,COPIES,$S('RENEWORD:53,1:52))
 S UNDERLN(LINE,41)=$S('RENEWORD:3,1:2)
 D ADDLINE^PSOERUT0("LM",NMSPC,"",XV)
 D BLANKLN^PSOERUT0("LM")
 ;
 ; - Remarks
 S VACLINIC=$$GET1^DIQ(52.41,ORDIEN,1.1)
 S XV="|"_$S('RENEWORD:"15) ",1:"8) ")_"Remarks: "
 S UNDERLN(LINE,41)=$S('RENEWORD:3,1:2)
 D ADDLINE^PSOERUT0("LM",NMSPC,"",XV)
 K VARR D WRAP^PSOERUT($G(PSONEW("REMARKS")),38,.VARR)
 F I=1:1 Q:'$D(VARR(I))  D
 . I $G(VARR(I,0))="" Q
 . D ADDLINE^PSOERUT0("LM",NMSPC,"","| "_$$COMPARE^PSOERUT0("LM",VARR(I,0),VARR(I,0),42))
 D BLANKLN^PSOERUT0("LM")
 ; - Diagnostics
 D SETDIAGS^PSOERUT3("LM",NMSPC,ERXIEN)
 ;
 ; - DEA compliance note for eRx CS prescriptions
 I $$GET1^DIQ(52.49,ERXIEN,95.1,"I"),$$CS^PSOERXA0(VADRGIEN) D
 . D BLANKLN^PSOERUT0("LM",1)
 . S XE=" This prescription meets the requirements of the Drug Enforcement Administration"
 . D ADDLINE^PSOERUT0("LM",NMSPC,$$COMPARE^PSOERUT0("LM",XE,XE,2))
 . S XE=" (DEA) electronic prescribing for controlled substances rules (21 CFR Parts"
 . D ADDLINE^PSOERUT0("LM",NMSPC,$$COMPARE^PSOERUT0("LM",XE,XE,2))
 . S XE=" 1300, 1304, 1306, & 1311)."
 . D ADDLINE^PSOERUT0("LM",NMSPC,$$COMPARE^PSOERUT0("LM",XE,XE,2))
 . D BLANKLN^PSOERUT0("LM",1)
 ;
 ; - Entry Accepted by/date/time
 S ACCDTBY=$$ACCDTBY^PSOERUT4(ERXIEN)
 S XX=" eRx Received on "_$P($$FMTE^XLFDT($$GET1^DIQ(52.49,ERXIEN,.03,"I"),"2Y"),":",1,2)
 S XX=XX_" | Accepted by "_$E($P(ACCDTBY,"^",2),1,17)_" on "_$P($P(ACCDTBY,"^",1),":",1,2)
 S XX=$E(XX,1,80),XE="",$E(XE,(80-$L(XX))\2+1)=XX
 D ADDLINE^PSOERUT0("LM",NMSPC,$$COMPARE^PSOERUT0("LM",XE,XE,2))
 Q
 ;
VISTAPAT(ERXIEN) ; Returns the VistA Patient For Responses that pass through the eRx Holding Queue w/out matching/validation
 ; Input: ERXIEN   - Pointer to the ERX HOLDING QUEUE (#52.49)
 ;Output: VISTAPAT - Pointer to the PATIENT file (#2) associated with the eRx
 N VISTAPAT,MTYPE,REQIEN,NEWRXIEN
 S VISTAPAT=+$$GET1^DIQ(52.49,ERXIEN,.05,"I")
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 I 'VISTAPAT,"RR,CA,"[MTYPE D
 . S NEWRXIEN=$$RESOLV^PSOERXU2(ERXIEN)
 . S VISTAPAT=+$$GET1^DIQ(52.49,NEWRXIEN,.05,"I")
 I 'VISTAPAT,"RE,CN,IE,"[MTYPE D
 . S REQIEN=$$RESOLV^PSOERXU2(ERXIEN) Q:'REQIEN
 . S VISTAPAT=+$$GET1^DIQ(52.49,REQIEN,.05,"I") I VISTAPAT Q
 . S NEWRXIEN=$$RESOLV^PSOERXU2(REQIEN)
 . S VISTAPAT=+$$GET1^DIQ(52.49,NEWRXIEN,.05,"I")
 Q VISTAPAT
 ;
CSERX(ORD) ; Check whether a Pending Order is for a CS eRx
 ; Input: ORD - Pointer to OUTPATIENT PENDING ORDER file (#52.41)
 I $$ERXIEN^PSOERXUT(ORD_"P"),$$CSDRG(+$$GET1^DIQ(52.41,+ORD,11,"I")) D  Q 1
 . S VALMSG="Only the 'Routing' field can be edited (CS eRx).",VALMBCK="R" W $C(7)
 Q 0
 ;
CSDRG(DRGIEN) ; Controlled Substance drug?
 ; Input: DRGIEN - Pointer to DRUG file (#50)
 ;Output: $$CS - 1:YES / 0:NO
 N DEA
 Q:'DRGIEN 0
 S DEA=$$GET1^DIQ(50,DRGIEN,3)
 I (DEA'["0"),(DEA'["M"),(DEA["2")!(DEA["3")!(DEA["4")!(DEA["5") Q 1
 Q 0
 ;
VS(ERXIEN,TYPE) ; View Suggestion(s)
 ;Input: ERXIEN - Pointer to ERX HOLDING QUEUE file (#52.49)
 ;       TYPE   - Type of Suggestion("PA": Patient;"PR": Provider;"DR": Drug)
 N ERXPAT,ERXPRV,DRUGHASH
 S VALMBCK="R"
 I TYPE="PR" S ERXPRV=$$GET1^DIQ(52.49,ERXIEN,2.1,"I") I 'ERXPRV
 I TYPE="PR",'$O(^PS(52.49,"APRVVPRV",ERXPRV,0)) D  Q
 . S VALMSG="There are no suggestions for this Provider" W $C(7) Q
 I TYPE="PA" S ERXPAT=+$$GET1^DIQ(52.49,+$G(ERXIEN),.04,"I") I 'ERXPAT Q 0
 I TYPE="PA",'$O(^PS(52.49,"APATVPAT",ERXPAT,0)) D  Q
 . S VALMSG="There are no suggestions for this Patient" W $C(7) Q
 I TYPE="DR" S DRUGHASH=$$DRUGHASH^PSOERUT(ERXIEN)
 I TYPE="DR",'DRUGHASH D  Q
 . S VALMSG="Unable to calculate the hash value for this eRx" W $C(7) Q
 I TYPE="DR",'$O(^PS(52.49,"ADRGVRX",DRUGHASH,0)) D  Q
 . S VALMSG="There are no suggestions for this Drug" W $C(7) Q
 D FULL^VALM1
 I TYPE="PA" D MATCHSUG^PSOERPT1(ERXIEN,1)
 I TYPE="PR" D MATCHSUG^PSOERPV1(ERXIEN,1)
 I TYPE="DR" D MATCHSUG^PSOERUT4(ERXIEN,1)
 Q
 ;
LASTRXST(RXIEN) ; Returns the Rx Last Fill status (For Future Fill Suggestion only)
 ; Input: RXIEN  - pointer to PRESCRIPTION file (#52)
 ;Output: STATUS - Last fill status ("R":Relased;"T":Transmitted;"S":Suspended)
 N LASTFILL,FILLDATE,RELDATE,RXSTS
 S LASTFILL=$$LSTRFL^PSOBPSU1(RXIEN)
 S RELDATE=$$RXRLDT^PSOBPSUT(RXIEN,LASTFILL)\1
 S RXSTS=+$$GET1^DIQ(52,RXIEN,100,"I")
 S FILLDATE=$$RXFLDT^PSOBPSUT(RXIEN,LASTFILL)
 ; Last Fill released, Release Date + Days Supply in the future
 I RELDATE,$$FMADD^XLFDT(RELDATE,$$GET1^DIQ(52,RXIEN,8))>DT Q "R"
 ; Last Fill is not released, is Suspended, Not Transmitted/Printed, Future Fill Date
 I 'RELDATE,(RXSTS=5),FILLDATE>DT Q "S"
 ; Last Fill is not released, is Transmitted or Re-Transmitted to CMOP
 I 'RELDATE,$$CMOPSTS^PSOERUT(RXIEN,LASTFILL)=0!($$CMOPSTS^PSOERUT(RXIEN,LASTFILL)=2) Q "T"
 Q ""
