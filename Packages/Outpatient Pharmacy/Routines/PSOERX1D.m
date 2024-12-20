PSOERX1D ;ALB/JSG - eRx Utilities ; 11/27/2019 11:02am
 ;;7.0;OUTPATIENT PHARMACY;**581,617,746,769**;DEC 1997;Build 26
 ;
 ;The rule numbers correspond to the last 4 digits of RTC story #'s and are abbreviations
 ;  for the various conditions which control what is printed on the Summary Detail screen or
 ; the Print View
 ;
 ;i.e. 1058 -> 1251058, 1057 -> 1251057, etc.
 ; For Summary/Detail:
 ; 1058    -  MTYPE=CX, RESPVAL=DENIED,              CHGMESRI=G/T/S/OS/D
 ; 1059    -  MTYPE=CX, RESPVAL=APPROVED OR DENIED,  CHGMESRI=P
 ; 1060    -  MTYPE=CX, RESPVAL=DENIED OR VALIDATED, CHGMESRI=U
 ; 1043    -  MTYPE=CR,                              CHGMESRI=G/T/S/OS/D
 ; 1056    -  MTYPE=CR,                              CHGMESRI=P/U
 ;
 ; For Print View:
 ; 1057P   - MTYPE=CR,                               CHMESRI=P
 ; 1057G   - MTYPE=CR,                               CHMESRI=G/T/D/S/OS
 ; 1057U   - MTYPE=CR,                               CHMESRI=U
 ; 1061    - MTYPE=CX,  RESPVAL=DENIED,              CHMESRI=G/T/S/OS/D
 ; 1062PAN - MTYPE=CX,  RESPVAL=APPROVED,            CHMESRI=P,         No 311
 ; 1062PA3 - MTYPE=CX,  RESPVAL=APPROVED,            CHMESRI=P,         311
 ; 1062PDN - MTYPE=CX,  RESPVAL=DENIED,              CHMESRI=P,         No 311
 ; 1062PD3 - MTYPE=CX,  RESPVAL=DENIED,              CHMESRI=P,         311
 ; 1062UDN - MTYPE=CX,  RESPVAL=DENIED,              CHMESRI=U,         No 311
 ; 1062UD3 - MTYPE=CX,  RESPVAL=DENIED,              CHMESRI=U,         311
 ; 1062UVN - MTYPE=CX,  RESPVAL=VALIDATED,           CHMESRI=U,         No 311
 ; 1062UV3 - MTYPE=CX,  RESPVAL=VALIDATED,           CHMESRI=U,         311
 ;
 ; CONTEXT - MTYPE^RESPONSE VALUE^REQUEST TYPE
 ;       EX  CX^V^U  - MEANING CHANGE RESPONSE^VALIDATE^PRIOR AUTHORIZATION??
 ;
GETRULES(PSOIEN,MTYPE,RESPVAL,CHGMESRI,PRTVIEW) ;
 S PRTVIEW=+$G(PRTVIEW)
 N DONE,NO311,RULE
 S (DONE,RULE)=0
 I 'PRTVIEW D
 .I MTYPE="CX" D  Q
 ..I RESPVAL="DENIED" D  Q:DONE
 ...I ",G,T,S,OS,D,"[(","_CHGMESRI_",") S RULE=1058,DONE=1 Q
 ..I RESPVAL?1(1"APPROVED",1"DENIED"),CHGMESRI="P" S RULE=1059,DONE=1 Q
 ..I RESPVAL?1(1"DENIED",1"VALIDATED"),CHGMESRI="U" D
 ...S RULE=1060
 .D:MTYPE="CR"
 ..I ",G,T,S,OS,D,"[(","_CHGMESRI_",") S RULE=1043 Q
 ..I ",P,U,"[(","_CHGMESRI_",") S RULE=1056
 I PRTVIEW D
 .I MTYPE="CR" D  Q
 ..I CHGMESRI="P" S RULE="1057P" Q
 ..I CHGMESRI?1(1"G",1"T",1"D",1"S",1"OS") S RULE="1057G" Q
 ..I CHGMESRI="U" S RULE="1057U"
 .D:MTYPE="CX"
 ..I RESPVAL="DENIED" D
 ...I ",G,T,S,OS,D,"[(","_CHGMESRI_",") S RULE=1061 Q
 ..I CHGMESRI="P" D  Q
 ...S NO311='$D(^PS(52.49,PSOIEN,311))
 ...I RESPVAL="APPROVED" D  Q
 ....S RULE="1062PA"_$S(NO311:"N",1:3)
 ...I RESPVAL="DENIED" D
 ....S RULE="1062PD"_$S(NO311:"N",1:3)
 ..I CHGMESRI="U" D
 ...S NO311='$D(^PS(52.49,PSOIEN,311))
 ...I RESPVAL="DENIED" D  Q
 ....S RULE="1062UD"_$S(NO311:"N",1:3)
 ...I RESPVAL="VALIDATED" D
 ....S RULE="1062UV"_$S(NO311:"N",1:3)
 Q RULE
 ;
SETMRC(PSOIEN,CHGMESRI,CHGMESRQ,RESPVAL,RULE,LINE) ; Set values for MRC variables
 N CHGMESRE,CHMSSUB,I,IENS,NO311,NOTEARY,X,REATXT
 S CHGMESRE=$$GET1^DIQ(52.45,CHGMESRQ,.02,"I")
 I RULE?1(1"1058",1"1059",1"1060",1"1043",1"1056",1"0") D SET(.LINE,"Change Request Type: ",CHGMESRE),CNTRL^VALM10(LINE,22,$L(CHGMESRE),IOINHI,IOINORM)
 I (RULE=1060)!((RULE=1056)&(CHGMESRI="U")!(CHGMESRI="D")) D
 .S IENS=$O(^PS(52.49,PSOIEN,316,0))
 .I IENS D
 ..S IENS=IENS_","_PSOIEN_","
 ..S CHMSSUB=$$GET1^DIQ(52.49316,IENS,1,"I")
 ..S CHMSSUB=$$GET1^DIQ(52.45,CHMSSUB,.02,"E")
 .I 'IENS D
 ..S CHMSSUB=""
 .K NOTEARY
 .D TXT2ARY^PSOERXD1(.NOTEARY,CHMSSUB," ",55)
 .I $D(NOTEARY) D
 ..S I=0
 ..F  S I=$O(NOTEARY(I)) Q:'I  D
 ...S LINE=LINE+1 D SET^VALM10(LINE,$S(I=1:"Change Request Sub Type: ",1:$J("",25))_NOTEARY(I)),CNTRL^VALM10(LINE,26,$L(NOTEARY(I)),IOINHI,IOINORM)
 .I '$D(NOTEARY) D
 ..S LINE=LINE+1 D SET^VALM10(LINE,"Change Request Sub Type: ")
 S X=$$GET1^DIQ(52.49,PSOIEN,317,,"REATXT")
 I $G(REATXT(1))'="" D
 . S X=REATXT(1) K RET D TXT2ARY^PSOERXD1(.RET,X," ",80)
 . S LINE=LINE+1 D SET^VALM10(LINE,"Change Request Reason Text: ")
 . S I=0 F  S I=$O(RET(I)) Q:I=""  S LINE=LINE+1 D SET^VALM10(LINE,RET(I)),CNTRL^VALM10(LINE,1,80,IOINHI,IOINORM)
 I RULE?1(1"1058",1"1059",1"1060") D
 .S NO311='$D(^PS(52.49,PSOIEN,311))
 I RULE'?1(1"1058",1"1059",1"1060") D
 .S NO311=0
 I NO311 D
 .D RESTSMDT(1,PSOIEN,RESPVAL,RULE,.LINE)
 Q NO311
 ;
RESTSMDT(SMALLMP,PSOIEN,RESPVAL,RULE,LINE) ; Print rest of Summary/Details screen for CXD - G/T/S/OS/D
 N CHGMESRQ,FLG,STATUS
 I SMALLMP D
 .D MEDPRES(PSOIEN,RULE,.LINE)
 I 'SMALLMP D:RULE=0!((RESPVAL="VALIDATED")&($$GET1^DIQ(52.49,PSOIEN,.08,"I")="CX"))
 .I $G(SDERXFLG) D DISPRX^PSOERSE3 Q
 .D DISPRX^PSOERX1G
 I RULE?1(1"1059",1"1060",1"1056",1"1062".E) D
 .D PHCHREQ^PSOERX1E(PSOIEN,RULE,.LINE)
 S CHGMESRQ=$$GET1^DIQ(52.49,PSOIEN,315.1,"I")
 D CXRES(PSOIEN,RESPVAL,RULE,"1058,1059,1060,0",.LINE)
 I RULE?1(1"1058",1"1043",1"0") D  ;
 .D MEDREQDR(PSOIEN,RULE,.LINE)
 D CXREQ(PSOIEN,RULE,.LINE)
 D MSGHIS^PSOERXU3(PSOIEN,.LINE)
 Q
 ;
MEDPRES(PSOIEN,RULE,LINE) ; Medication Prescribed
 S LINE=LINE+1 D SET^VALM10(LINE,"                          MEDICATION PRESCRIBED                              ")
 S LINE=LINE+1 D SET^VALM10(LINE,"No Medication information available on the Response.")
 Q
 ;
CXRES(ERXIEN,RESPVAL,RULE,RULES,LINE) ;
 D CXRES^PSOERX1E
 Q
 ;
MEDREQDR(PSOIEN,RULE,LINE) ; Medication Requested section driver
 N CNT,F,I,IENS,REQIEN
 S CNT=0,REQIEN=$S(RULE?1(1"1058",1"1061",1"0"):$$RESOLV^PSOERXU2(PSOIEN),1:PSOIEN)
 W:RULE="1057G" !
 S I=0
 F  S I=$O(^PS(52.49,REQIEN,311,I)) Q:'I  D
 .S F=52.49311,IENS=I_","_REQIEN_","
 .D GETS^DIQ(F,IENS,"**","IE","DDAT")
 .I $G(DDAT(F,IENS,.02,"I"))="R" D  ; Only requested medications
 ..S CNT=CNT+1
 ..D MEDREQ(REQIEN,F,IENS,I,.LINE,CNT)
 .K DDAT
 Q
 ;
MEDREQ(REQIEN,F,IENS,IEN311,LINE,CNT) ; Medication Request section
 N DAYSUP,DRUG,FND,I,LTXT,NOTE,NOTEARY,QTY,QUOM,REFILL,SIG,SUB,TXT,SIGDATA,SIGARY,NDCCODE
 S DRUG=$G(DDAT(F,IENS,.03,"E"))
 S SUB=$G(DDAT(F,IENS,2.7,"I"))
 S SUB=$S(SUB=1:"NO",SUB=0:"YES",1:"")
 S NOTE=$G(DDAT(F,IENS,5,"E"))
 S QTY=$G(DDAT(F,IENS,2.1,"E"))
 S REFILL=$G(DDAT(F,IENS,2.8,"E"))
 S DAYSUP=$G(DDAT(F,IENS,2.4,"E"))
 S QUOM=$G(DDAT(F,IENS,2.3,"I"))
 S QUOM=$$GET1^DIQ(52.45,QUOM,.02,"E")
 ;I '$G(SDERXFLG) S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"****************************MEDICATION REQUESTED "_CNT_"****************************")
 I $G(SDERXFLG) D SET^VALM10(LINE,"                            MEDICATION REQUESTED "_CNT_"                            "),CNTRL^VALM10(LINE,1,80,IOUON_IOINHI,IOUOFF_IOINORM)
 K NOTEARY
 D TXT2ARY^PSOERXD1(.NOTEARY,DRUG_" "_$P($$ERXDRSCH^PSOERXUT(ERXIEN),"^",2)," ",74)
 S I=0 F  S I=$O(NOTEARY(I)) Q:'I  D
 . S LINE=LINE+1
 . D SET^VALM10(LINE,$S(I=1:"Drug: ",1:$J("",6))_NOTEARY(I))
 . D CNTRL^VALM10(LINE,7,$L(NOTEARY(I)),IOINHI,IOINORM)
 S LTXT=""
 S NDCCODE=$G(DDAT(F,IENS,1.1,"I"))
 D ADDITEM^PSOERX1A(.LTXT,"Substitutions: ",SUB,1,22)
 D ADDITEM^PSOERX1A(.LTXT,"NDC: ",NDCCODE,55,80)
 S LINE=LINE+1 D SET^VALM10(LINE,LTXT),CNTRL^VALM10(LINE,16,$L(SUB),IOINHI,IOINORM),CNTRL^VALM10(LINE,61,$L(NDCCODE),IOINHI,IOINORM) ;D SET^VALM10(LINE,"Substitutions: "_SUB),CNTRL^VALM10(LINE,16,$L(SUB),IOINHI,IOINORM)
 D NOTE(NOTE,"Note: ",1,.LINE)
 S LTXT=""
 D ADDITEM^PSOERX1A(.LTXT,"Qty: ",QTY,1,22)
 D ADDITEM^PSOERX1A(.LTXT,"Refills: ",REFILL,23,21)
 D ADDITEM^PSOERX1A(.LTXT,"Days Supply: ",DAYSUP,44,37)
 S LINE=LINE+1 D SET^VALM10(LINE,LTXT)
 D CNTRL^VALM10(LINE,6,$L(QTY),IOINHI,IOINORM)
 D CNTRL^VALM10(LINE,33,$L(REFILL),IOINHI,IOINORM)
 D CNTRL^VALM10(LINE,58,$L(DAYSUP),IOINHI,IOINORM)
 I QUOM="" D
 . S LINE=LINE+1 D SET^VALM10(LINE,"Quantity Unit Of Measure:")
 I QUOM]"" D
 . K NOTEARY
 . D TXT2ARY^PSOERXD1(.NOTEARY,QUOM," ",54)
 . S I=0 F  S I=$O(NOTEARY(I)) Q:'I  D
 . . S TXT=$S(I=1:"Quantity Unit Of Measure: ",1:$J("",26))_NOTEARY(I)
 . . S LINE=LINE+1 D SET^VALM10(LINE,TXT)
 . . D CNTRL^VALM10(LINE,27,$L(NOTEARY(I)),IOINHI,IOINORM)
 S SIGDATA=""
 S I=0 F  S I=$O(^PS(52.49,REQIEN,311,IEN311,8,I)) Q:'I  D
 . S SIGDATA=SIGDATA_^PS(52.49,REQIEN,311,IEN311,8,I,0)_" "
 I $G(SIGDATA)'="" D
 . D TXT2ARY^PSOERXD1(.SIGARY,SIGDATA," ",75)
 . S I=0 F  S I=$O(SIGARY(I)) Q:I=""  D
 . . S LINE=LINE+1
 . . I I=1 D SET^VALM10(LINE,"Sig: "_SIGARY(I)),CNTRL^VALM10(LINE,6,$L(SIGARY(I)),IOINHI,IOINORM) Q
 . . D SET^VALM10(LINE,$J("",5)_SIGARY(I)),CNTRL^VALM10(LINE,6,$L(SIGARY(I)),IOINHI,IOINORM)
 Q
 ; rxchange request information
CXREQ(ERXIEN,RULE,LINE) ;
 N COMM,COMMARY,COMMBY,COMMDTTM,CTXT,I,REQBY,REQDTTM,REQIEN
 ; - the next line of code will actually reference the related message for retrieval of the rxchange request information
 ; - check that this is correct and test.
 S REQIEN=$S(RULE?1(1"1058",1"1059",1"1060",1"1061",1"1062".E,1"0"):$$RESOLV^PSOERXU2(ERXIEN),1:ERXIEN)
 S REQBY=$$GET1^DIQ(52.49,REQIEN,51.1,"E")
 S REQDTTM=$$GET1^DIQ(52.49,REQIEN,.03,"E")
 S COMM=$$GET1^DIQ(52.49,REQIEN,50,"E")
 I $G(@VALMAR@(LINE,0))]""&(RULE'="1057G")&('$G(SDERXFLG)) S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"************************RXCHANGE REQUEST INFORMATION**************************")
 I $G(SDERXFLG) D SET^VALM10(LINE,"                        RXCHANGE REQUEST INFORMATION                          "),CNTRL^VALM10(LINE,1,80,IOUON_IOINHI,IOUOFF_IOINORM)
 D SET^PSOERX1D(.LINE,"Requested By: ",REQBY),CNTRL^VALM10(LINE,15,$L(REQBY),IOINHI,IOINORM)
 D SET^PSOERX1D(.LINE,"Request Date/Time: ",REQDTTM),CNTRL^VALM10(LINE,20,$L(REQDTTM),IOINHI,IOINORM)
 K COMMARY
 D TXT2ARY^PSOERXD1(.COMMARY,COMM," ",53)
 I $D(COMMARY) D
 . S I=0 F  S I=$O(COMMARY(I)) Q:'I  D
 . . S CTXT=$S(I=1:"RxChange Request Comments: ",1:$J("",27))_COMMARY(I)
 . . S LINE=LINE+1 D SET^VALM10(LINE,CTXT)
 . . D CNTRL^VALM10(LINE,28,$L(COMMARY(I)),IOINHI,IOINORM)
 I '$D(COMMARY) D
 . S LINE=LINE+1 D SET^VALM10(LINE,"RxChange Request Comments:")
 S COMMBY=$$GET1^DIQ(52.49,REQIEN,50.1,"E")
 S COMMDTTM=$$GET1^DIQ(52.49,REQIEN,50.2,"E")
 S LINE=LINE+1 D SET^VALM10(LINE,"Comments By: "_COMMBY)
 D CNTRL^VALM10(LINE,14,$L(COMMBY),IOINHI,IOINORM)
 Q
 ;
SET(LINE,TITLE,VAL) ; Add line if there is a value
 I $G(VAL)]"" S LINE=LINE+1 D SET^VALM10(LINE,TITLE_VAL)
 Q
 ;
PRTVIEW(PSOIEN,CHGMESRQ,RESPVAL,RULE,NO311) ; Set values for MRC variables
 N CHGMESRE,CMTS,LINE,NOTEARY,RULES,SUBS,XMTYPE
 S CHGMESRE=$$GET1^DIQ(52.45,CHGMESRQ,.02,"I")
 I RULE?1(1"1061".E,1"1062P".E,1"1062U".E),NO311 D
 .W !,"No Medication information available on the Response."
 I RULE?1(1"1061".E,1"1062P".E,1"1062UD".E),NO311 D
 .W !!,"eRx Reference #: ",$$GET1^DIQ(52.49,PSOIEN,.01,"E")
 .W !,"Message ID: ",$$GET1^DIQ(52.49,PSOIEN,25,"E")
 I RULE?1(1"1062P".E,1"1062UD".E),NO311 D
 .S CMTS=$$GET1^DIQ(52.49,PSOIEN,30,"I")
 .S SUBS=$$GET1^DIQ(52.49,PSOIEN,5.8,"I")
 .S SUBS=$S(SUBS=1:"NO",SUBS=0:"YES",1:"")
 .W:SUBS]"" !,"Substitutions?: ",SUBS
 .K NOTEARY
 .D TXT2ARY^PSOERXD1(.NOTEARY,CMTS," ",70)
 .S I=0 F  S I=$O(NOTEARY(I)) Q:'I  D
 ..W !,$S(I=1:"Comments: ",1:$J("",10))_NOTEARY(I)
 I RULE?1(1"1057"1.E,1"1061",1"1062".E,1"0") D
 .W !!,"Change Request Type: ",CHGMESRE
 I (RULE="1057U")!(RULE?1"1062U".E) D
 .I $D(^PS(52.49,PSOIEN,316,1)) D
 ..N IENS
 ..S IENS=$O(^PS(52.49,PSOIEN,316,0))
 ..S IENS=IENS_","_PSOIEN_","
 ..S CHMSSUB=$$GET1^DIQ(52.49316,IENS,1,"I")
 ..S CHMSSUB=$$GET1^DIQ(52.45,CHMSSUB,.02,"E")
 .I '$D(^PS(52.49,PSOIEN,316,1)) D
 ..S CHMSSUB=""
 .W:CHMSSUB]"" !,"Change Request Sub Type: ",CHMSSUB
 I RULE?1(1"1057U",1"1057P",1"1062".E) D
 .D PHCHREQ^PSOERX1E(PSOIEN,RULE,"",1)
 S RULES="1061,1062,0"
 D ARR2PRT("CXRES(PSOIEN,RESPVAL,RULE,RULES,.LINE)",PSOIEN,RESPVAL,RULE,RULES,.LINE)
 I RULE?1(1"1057G",1"1061",1"0") D
 .D ARR2PRT("MEDREQDR(PSOIEN,RULE,.LINE)",PSOIEN,RESPVAL,RULE,RULES,.LINE)
 I RULE?1(1"1057"1A,1"1061",1"1062".E,1"0") D
 .I RULE?1"1057"1(1"U",1"P") D
 ..W !
 .D ARR2PRT("CXREQ(PSOIEN,RULE,.LINE)",PSOIEN,RESPVAL,RULE,RULES,.LINE)
 I RULE?1(1"1057"1A,1"1061",1"1062".E,1"0") D
 .D ARR2PRT("MSGHIS^PSOERXU3(PSOIEN,.LINE)",PSOIEN,RESPVAL,RULE,RULES,.LINE)
 I RULE="1061",NO311 D
 .W !,"*******************************END OF eRx********************************"
 Q
 ;
ARR2PRT(FUN,PSOIEN,RESPVAL,RULE,RULES,LINE) ; Change VALMAR to print
 N ARR,LINE,VALMAR
 S LINE=0,VALMAR="ARR"
 D @FUN
 S LINE=0
 F  S LINE=$O(@VALMAR@(LINE)) Q:'LINE  D
 .W !,@VALMAR@(LINE,0)
 Q
 ;
CHGMTYPE(PSOIEN,MTYPE,RESPVAL,CHGMESRI) ; Check on changing message type
 N FLG,RULE
 D
 .S FLG=0
 .I MTYPE="CX",RESPVAL?1"APPROVED".1" WITH CHANGES",",G,T,S,OS,D,"[(","_CHGMESRI_",") S FLG=1 Q
 .S RULE=$$GETRULES(PSOIEN,MTYPE,RESPVAL,CHGMESRI,0)
 .S FLG=RULE?1(1"1058",1"1059",1"1060",1"1062".E)
 Q FLG
 ;
QTSUMDT1(PSOIEN,MTYPE,CHGMESRI,CHGMESRQ,RESPVAL,LINE) ; Quit Summary Detail early?
 N FLG,NO311,RULE
 D
 .S FLG=0
 .I MTYPE="CX",RESPVAL?1"APPROVED".1" WITH CHANGES",",G,T,S,OS,D,"[(","_CHGMESRI_",") D  Q
 ..S FLG=1,RULE=0
 .S RULE=$$GETRULES(PSOIEN,MTYPE,RESPVAL,CHGMESRI,0)
 .S FLG=(RULE?1(1"1058",1"1059",1"1060",1"1043",1"1056"))
 I FLG D
 .S FLG=$$SETMRC(PSOIEN,CHGMESRI,CHGMESRQ,RESPVAL,RULE,.LINE)
 Q FLG
 ;
QTSUMDT2(PSOIEN,MTYPE,CHGMESRI,RESPVAL,LINE) ; Quit Summary Detail later?
 N FLG,RULE
 D
 .S FLG=0
 .I MTYPE="CX",RESPVAL?1"APPROVED".1" WITH CHANGES",",G,T,S,OS,D,"[(","_CHGMESRI_",") D  Q
 ..S FLG=1,RULE=0
 .S RULE=$$GETRULES(PSOIEN,MTYPE,RESPVAL,CHGMESRI,0)
 .S FLG=RULE?1(1"1058",1"1059",1"1060",1"1043",1"1056")
 I FLG D
 .D RESTSMDT(0,PSOIEN,RESPVAL,RULE,.LINE)
 Q FLG
 ;
ADMDPRLN(PSOIEN,MTYPE,RESPVAL,CHGMESRI,SDSPLAY) ; Add Medication Prescribed Line?
 Q $$CHGMTYPE(PSOIEN,MTYPE,RESPVAL,CHGMESRI)
 ;
SHORTPI(PSOIEN,MTYPE,RESPVAL,CHGMESRI) ; Short Prescription Info section?
 N FLG,RULE
 S RULE=$$GETRULES(PSOIEN,MTYPE,RESPVAL,CHGMESRI,1)
 S FLG=((RULE=1061)&'$D(^PS(52.49,PSOIEN,311)))!(RULE?1"1062"2A1"N")
 D:FLG PRTVIEW(PSOIEN,CHGMESRQ,RESPVAL,RULE,1)
 Q FLG
 ;
CHGEND(PSOIEN,MTYPE,RESPVAL,CHGMESRI) ; Change end of Print View?
 N FLG,RULE
 D
 .S FLG=0
 .I MTYPE="CX",RESPVAL?1"APPROVED".1" WITH CHANGES",",G,T,S,OS,D,"[(","_CHGMESRI_",") D  Q
 ..S FLG=1,RULE=0
 .S RULE=$$GETRULES(PSOIEN,MTYPE,RESPVAL,CHGMESRI,1)
 .S FLG=RULE?1(1"1057"1.E,1"1061",1"1062".E)
 I FLG D PRTVIEW(PSOIEN,CHGMESRQ,RESPVAL,RULE,'$D(^PS(52.49,PSOIEN,311)))
 Q
 ;
NOTE(STR,TITLE,REQUIRED,LINE) ; Print possibly multi-line comment
 N I,LEN,NOTEARY
 S LEN=$L(TITLE)
 D TXT2ARY^PSOERXD1(.NOTEARY,STR," ",80-LEN)
 I $D(NOTEARY) D
 .S I=0 F  S I=$O(NOTEARY(I)) Q:'I  D
 ..S LINE=LINE+1 D SET^VALM10(LINE,$S(I=1:TITLE,1:$J("",LEN))_NOTEARY(I)),CNTRL^VALM10(LINE,7,$L(NOTEARY(I)),IOINHI,IOINORM)
 I '$D(NOTEARY) D:REQUIRED
 .S LINE=LINE+1 D SET^VALM10(LINE,TITLE)
 Q
 ;
PROHIBIT(RESPVAL,CHGMESRI) ; Print prohibit renewal tag?
 Q:(RESPVAL?1"APPROVED".1" WITH CHANGES")&(",G,T,S,OS,D,"[(","_CHGMESRI_",")) 1
 Q $S(RESPVAL="VALIDATED":1,1:0)
