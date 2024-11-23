PSOERPV1 ;BIRM/MFR - eRx Provider Supporting API's ;08/29/22
 ;;7.0;OUTPATIENT PHARMACY;**700,746,769**;DEC 1997;Build 26
 ;
MATCHSUG(ERXIEN,VIEW) ; Match Suggestion Prompt
 ; Input: ERXIEN   - Pointer to ERX HOLDING QUEUE file (#52.49)
 ;     (o)VIEW     - View Only Mode (1:YES,0/null: NO)
 ;Output: MATCHSUG - VistA Provider (Pointer to #200) or 0 (Not selected or no suggestion on file)
 ;
 N MATCHSUG,ERXPRV,MATCHCNT,LSTMTCH,LSTERXID,CNT,VPRV,QUIT,ERXID
 I '$G(ERXIEN) Q 0
 S (MATCHSUG,MATCHCNT,CNT,VPRV,QUIT)=0
 S ERXPRV=$$GET1^DIQ(52.49,ERXIEN,2.1,"I") I 'ERXPRV Q 0
 F  S VPRV=$O(^PS(52.49,"APRVVPRV",ERXPRV,VPRV)) Q:'VPRV  S MATCHCNT=MATCHCNT+1
 I MATCHCNT>3 S MATCHCNT=3
 F  S VPRV=$O(^PS(52.49,"APRVVPRV",ERXPRV,VPRV)) Q:'VPRV  D  I MATCHSUG!(CNT>2)!QUIT Q
 . S LSTERXID=0,LSTMTCH=9999999 F  S LSTMTCH=$O(^PS(52.49,"APRVVPRV",ERXPRV,VPRV,LSTMTCH),-1) Q:'LSTMTCH  D  I LSTERXID Q
 . . S ERXID=$O(^PS(52.49,"APRVVPRV",ERXPRV,VPRV,LSTMTCH,0)) Q:(ERXID=ERXIEN)  S LSTERXID=ERXID
 . I 'LSTERXID Q
 . S CNT=CNT+1
 . D CMPPRV(ERXIEN,VPRV,LSTERXID,CNT_"^"_MATCHCNT)
 . K DIR S DIR(0)="SOA^"_$S('$G(VIEW):"A:ACCEPT;",1:"")_$S(MATCHCNT>1&(MATCHCNT'=CNT):"N:NEXT;",1:"")_"F:FORGET;E:EXIT"
 . S DIR("A")="ACTION on SUGGESTION: "_$S('$G(VIEW):"(A)CCEPT  ",1:"")_$S(MATCHCNT>1&(MATCHCNT'=CNT):"(N)EXT  ",1:"")_"(F)ORGET  (E)XIT: "
 . S DIR("B")=$S(MATCHCNT>1&(MATCHCNT'=CNT):"NEXT",1:"EXIT")
 . S II=0
 . I '$G(VIEW) D
 . . S II=II+1,DIR("?",II)="  ACCEPT - Accepts the suggested VistA Provider and matches it to the eRx"
 . I MATCHCNT>1&(MATCHCNT'=CNT) D
 . . S II=II+1,DIR("?",II)="  NEXT   - Ignores this suggested VistA Provider and view the next one"
 . S II=II+1,DIR("?",II)="  FORGET - Forgets this suggested VistA Provider so that it is not presented"
 . S II=II+1,DIR("?",II)="           again in the future to any user"
 . S DIR("?")="  EXIT   - Exit and proceed to match the VistA Provider manually"
 . D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y="E") S QUIT=1 Q
 . I Y="A" S MATCHSUG=VPRV Q
 . I Y="N" W ! Q
 . I Y="F" D
 . . K DIR S DIR(0)="SA^Y:YES;N:NO",DIR("B")="NO"
 . . S DIR("A")="Are you sure this validated match should be forgotten? "
 . . S DIR("?")="This VistA Provider was previously matched and validated as a valid match for this eRx Provider. Once you forget this match it will no longer be suggested as a match for this eRx Provider."
 . . W ! D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y="N") S VPRV=VPRV-1,CNT=CNT-1 W ! Q
 . . W !?50,"Forgetting..." K ^PS(52.49,"APRVVPRV",ERXPRV,VPRV) H 1 W "done." W ! Q
 Q MATCHSUG
 ;
CMPPRV(ERXIEN,VISTAPRV,LSTERXID,COUNTER) ; Display the Comparison Between eRx and VistA Providers
 ;Input: ERXIEN   - Pointer to ERX HOLDING QUEUE file (#52.49)
 ;       VISTAPRV - VistA Provider (Pointer to #2)
 ;    (o)LSTERXID - Last eRx IEN with the Match (Pointer to #52.49)
 ;    (o)COUNTER  - P1: Entry # | P2: Number of Entries
 I '$D(^PS(52.49,+$G(ERXIEN),0))!'$D(^VA(200,+$G(VISTAPRV),0)) Q
 N XX,LINE
 I $G(LSTERXID) D
 . W !?55,"|Sugg. " W $G(IOINHI)_+$G(COUNTER)_$G(IOINORM)_" of "_$G(IOINHI)_$P($G(COUNTER),"^",2)_$G(IOINORM)
 . W " - ",$G(IOINHI)_$$FMTE^XLFDT($$GET1^DIQ(52.49,LSTERXID,1.9,"I")\1,"2Z")_$G(IOINORM),"|"
 W !,$G(IORVON)_"ERX PROVIDER"_$G(IORVOFF),?41,$G(IORVON)_"VISTA PROVIDER"_$G(IORVOFF)
 I $G(LSTERXID) W ?55,"|From eRx#: "_$G(IOINHI)_$$GET1^DIQ(52.49,LSTERXID,.01)_$G(IOINORM),?79,"|"
 S $P(XX,"_",81)="" W !,XX
 D SETPROV^PSOERUT1("RS",ERXIEN,VISTAPRV)
 Q
 Q
 ;
PRVIDS ; Provider Lookup Identifiers Display (set on DIC("W"))
 N Z,Z1,Z2
 S Z=$G(^(.11)),Z1=$G(^("PS")),Z2=$G(^("QAR")) I $P(Z,U,4)'="" W "    ",$P(Z,U,4) I $P(Z,U,5) W ",",$P(^DIC(5,+$P(Z,U,5),0),U,2)
 I $P(Z1,"^",2)'="" W "    DEA#: ",$P(Z1,"^",2) W:$P(Z2,"^",9) " (Exp: "_$$FMTE^XLFDT($P(Z2,"^",9),"2Z")_")"
 Q
