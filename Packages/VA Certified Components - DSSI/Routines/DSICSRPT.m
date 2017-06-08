DSICSRPT ;DSS/SGM - Release Of Information ;07/09/2004 09:36
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;NOTES: 6/8/20004 - no longer backwardly compatible
 ;       errors used to return nothing and not a -1^message
 ;
 ; DBIA#  SUPPORTED  DESCRIPTION
 ; -----  ---------  -----------------------------------------------
 ;  3533   Cont Sub  LIST^SROESTV
 ; 10103      x      $$FMTE^XLFDT
 ; 10104      x      $$UP^XLFSTR
 ;  waiting for IA in regards to specific note title names
 ;
DETAILSR(DSICX,DSISRTN,FLAG)        ; RPC: DSIC SR DETAIL
 ;  get surgery report for a case DSISRTN
 ;  DSISRTN - req - case number - IFN to file 130
 ;     FLAG - opt - flag(s) indicating which reports to retrieve
 ;                  default to "AO"
 ;                  FLAG["A" - anesthesia report
 ;                  FLAG["O" - operation report
 ;                  FLAG["N" - nurse's intraoperative report
 ;                  FLAG["P" - non-OR report (procedures)
 ;                  FLAG="*" - return all reports
 ;  If error or problems, return DSICX(1)=-1^message
 ;  Else, return DSICX(n)=text of requested report where n=1,2,3,4...
 ;  All reports will start with a header such as:
 ;  ---------------------------------------------------------------
 ;                    <name of surgical report>
 ;  ---------------------------------------------------------------
 N I,L,X,Y,Z,DSI,DSICNT,DSICT,DSIEN,DSIL,DSIPN,DSISP,DSIX,TITLE,TYPE
 S DSICNT=0
 S X=$$PATCH I +X=-1 D SET(X) Q
 S $P(DSIL,"-",77)="",$P(DSISP," ",77)=""
 S DSISRTN=$G(DSISRTN),FLAG=$G(FLAG)
 I '$G(DSISRTN) S DSICX(1)="-1^No surgical case number received" Q
 S:FLAG?.E1L.E FLAG=$$UP^XLFSTR(FLAG)
 S:FLAG="*" FLAG="OPAN"
 S X="" F Y="O","A","N","P" S:FLAG[Y X=X_Y
 S:X="" X="OA" S FLAG=X
 S X=DSISRTN_";SRF("
 D LIST^DSICTIU1(.DSIPN,X)
 S X=$O(@DSIPN@(0)) I +$G(@DSIPN@(X))=-1 M DSICX=@DSIPN K @DSIPN Q
 F DSI=1:1:$L(FLAG) S TYPE=$E(FLAG,DSI) D
 .F DSIX=0:0 S DSIX=$O(@DSIPN@(DSIX)) Q:'DSIX  S X=@DSIPN@(DSIX) D
 ..S TITLE=$P(X,U,2) Q:TITLE=""
 ..S Y=$E(TITLE) S:Y?1L Y=$$UP^XLFSTR(Y) Q:Y'=TYPE
 ..S L=76-$L(TITLE)\2
 ..;  note header
 ..D SET(DSIL),SET($E(DSISP,1,L)_TITLE),SET(DSIL)
 ..D TEXT^DSICTIU1(.DSICT,+X)
 ..F I=0:0 S I=$O(@DSICT@(I)) Q:'I  D SET(@DSICT@(I))
 ..K @DSICT
 ..Q
 .Q
 K @DSIPN
 I '$O(DSICX(0)) D SET("-1^No reports found")
 Q
 ;
 ;
LISTSR(DSICX,DFN,ALPHA,OMEGA)  ; RPC: DSIC SR LIST
 ; List surgery instances for a patient.
 ; Input: DFN : Patient's IFN
 ;        ALPHA: Start date
 ;        OMEGA: End date
 ; Return :
 ;   DSICX(#) = p1^p2^p3^...^p10
 ;     p1 = ien to file 130
 ;     p2 = principal procedure name
 ;     p3 = Fileman date.time of operation
 ;     p4 = external date.time or operation
 ;     p5 = provider DUZ number
 ;     p6 = provider name
 ;     p7 = TIU IEN of operation report
 ;     p8 = TIU IEN of anesthesia report
 ;     p9 = TIU IEN of nurse's report
 ;    p10 = TIU IEN of procedure report (NON-OR)
 ;
 N X,Y,Z,DSI,DSIC,DSICA,DSICNT
 S DFN=$G(DFN),ALPHA=+$G(ALPHA),OMEGA=$G(OMEGA)
 S:'OMEGA OMEGA=DT+.25 S:'ALPHA ALPHA=3000101
 S DSICNT=0
 S X=$$GET^DSICDPT1($G(DFN)) I X<1 D SET(X) Q
 S X=$$PATCH I +X=-1 D SET(X) Q
 D LIST^SROESTV("DSIC",DFN,ALPHA,OMEGA,,1)
 F DSI=0:0 S DSI=$O(DSIC(DSI)) Q:'DSI  D
 .S DSICA=$P(DSIC(DSI),U,1,3),X=$P(DSICA,U,3)
 .I X S $P(DSICA,U,4)=$TR($$FMTE^XLFDT(X,"5Z"),"@"," ")
 .S X=DSIC(DSI) S $P(DSICA,U,5)=$TR($P(X,U,4),";",U)
 .F Y=0:0 S Y=$O(DSIC(DSI,Y)) Q:'Y  S X=DSIC(DSI,Y) D:+X
 ..S Z=$E($P(X,U,2)) S:Z?1L Z=$$UP^XLFSTR(Z)
 ..S Z=$F("OANP",Z)-1 S:Z>0 $P(DSICA,U,Z+6)=+X
 ..Q
 .D SET(DSICA)
 .Q
 I '$D(DSICX) D SET("-1^No cases found")
 Q
 ;
 ;-------------------  subroutines  --------------------
PATCH() ;
 ;;Patch SR*3.0*100 is required to retrieve any surgical report.  
 ;;It also expects that all reports, both recent and historical, 
 ;;are stored as TIU documents.  SR*3.0*100 had a compliance date 
 ;;of June 22, 2004.
 N I,X
 I $$PATCH^DSICXPDU(,"SR*3.0*100",1)=1 Q 1
 S X="-1^" F I=1:1:4 S X=X_$P($T(PATCH+I),";",3)
 Q X
 ;
SET(T) S DSICNT=DSICNT+1,DSICX(DSICNT)=T Q
