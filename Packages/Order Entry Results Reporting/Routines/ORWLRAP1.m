ORWLRAP1 ;DSS/TFF - LAB ANATOMIC PATHOLOGY CONFIGURATION SUPPORT;Jan 27, 2021@09:24:36;04/19/17  13:21
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**539**;Dec 17, 1997;Build 41
 ;
 ; This routine uses the following ICRs:
 ;  #2428 - COLL^LR7OR3
 ;  #7216 - ^LAB(69.73,
 ;
 Q
 ;
 ; ORDER ELEMENT    Configuration handled after the order element population
 ;          PAGE    Configuration
 ; SPECIMEN LIST    Is populated or a lookup is used independently of this RPC
 ;      SPECIMEN    Configuration happens when the user selects a specimen on the dialog
 ;
CONFIG(RET,TYP,IEN) ; RPC: ORWLRAP1 CONFIG
 ; *This configures the Delphi forms for CPRS aside from the original elements found
 ;  in the Lab order dialog.
 ;
 ; TYP =    O - ORDER ELEMENTS
 ;        OCM - ORDER CHANGE MESSAGE
 ;          P - PAGES
 ;       PG;# - PAGE CONFIGURATION
 ;       SP;# - SPECIMEN
 ;
 N OD,PG,L,W,WL,SP,SPB,BLK,POS,DES,CT
 S IEN=+$G(IEN),RET=$NA(^TMP($J,"CONFIG ORWLRAP1")) K @RET S @RET@(0)=0
 Q:'IEN!($G(TYP)="")
 I '$D(^LAB(69.73,IEN)) D DEFAULT(TYP) Q
 ; *** ORDER ELEMENTS
 ;     O^ID^HIDE(1,0)^REQUIRED(1,0)^DEFAULT_VALUE
 I TYP="O" D  D END Q
 . S OD=0 F  S OD=$O(^LAB(69.73,IEN,1,OD)) Q:'OD  D
 . . S @RET@("O",OD)="O^"_$G(^LAB(69.73,IEN,1,OD,0))
 ; *** ORDER CHANGE MESSAGE
 I TYP="OCM" S @RET@(0)=$G(^LAB(69.73,IEN,4)) Q
 ; *** PAGES
 ;     P^NUMBER^NAME^RESPONSE_ID
 I TYP="P"!(TYP?1"PG;".N) D  D END Q
 . S PG=0 F  S PG=$O(^LAB(69.73,IEN,2,PG)) Q:'PG  D
 . . Q:TYP?1"PG;".N&(PG'=$P(TYP,";",2))
 . . S L=$G(^LAB(69.73,IEN,2,PG,0))
 . . Q:$P(L,U,3)  ; *** HIDE PAGE
 . . I TYP="P" S @RET@("P",PG)="P^"_PG_U_$$NRQ($P(L,U,4),$P(L,U,2))_U_$P(L,U,5) Q
 . . ;   *** PAGE WP BUILDER BLOCK
 . . ;       PWB^PAGE^ID^TITLE^LIST(1,0)^DEFAULT_VALUE
 . . ;       PWV^PAGE^ID^VAL;D-CODE;#|VAL;E;#| (D(ate),E(dit))
 . . ;       PWW^PAGE^TITLE
 . . I $P($G(^LAB(69.73,IEN,2,PG,1,0)),U,4) D
 . . . S W=0 F  S W=$O(^LAB(69.73,IEN,2,PG,1,W)) Q:'W  D
 . . . . S WL=$G(^LAB(69.73,IEN,2,PG,1,W,0))
 . . . . S @RET@("P",PG,W)="PWB^"_PG_U_W_U_$$NRQ($P(WL,U,2),$P(WL,U))_U_$P(WL,U,3)_U_$P(WL,U,4)
 . . . . S @RET@("P",PG,W,"V")="PWV^"_PG_U_W_U_$$VWL(2,PG,W)
 . . S @RET@("P",PG)="PWW^"_PG_U_$P($G(^LAB(69.73,IEN,2,PG,0)),U,6)
 ; *** SPECIMEN
 ;     SPH^SP^HIDE_FROM_DESCRIPTION^POSITION^COLLECTION_SAMPLE_HIDE(1,0)^COLLECTION_SAMPLE_DEFAULT
 ;     SPB^SP^ID^TITLE^HIDE^REQUIRED^DEFAULT_VALUE^POSITION
 ;     SPV^SP^ID^VAL|VAL(;CODE;CD_VALUE)
 I TYP?1"SP;".N S SP=+$P(TYP,";",2) D  D END Q
 . S @RET@("S",0)="SPH^"_SP_U_$P($G(^LAB(69.73,IEN,3,SP,0)),U,2)_U_+$P($G(^LAB(69.73,IEN,3,SP,0)),U,3)_U_$P($G(^LAB(69.73,IEN,3,SP,2)),U,1,2)
 . Q:'$D(^LAB(69.73,IEN,3,SP))
 . S (BLK,SPB)=0 F  S SPB=$O(^LAB(69.73,IEN,3,SP,1,SPB)),BLK=BLK+1 Q:'SPB!(BLK>4)  D
 . . S @RET@("S",SPB)="SPB^"_SP_U_SPB_U_$G(^LAB(69.73,IEN,3,SP,1,SPB,0))
 . . S POS(+$P(@RET@("S",SPB),U,8),SPB)=""
 . . S @RET@("S",SPB,"V")="SPV^"_SP_U_SPB_U_$$VWL(3,SP,SPB)
 . ; *** Fix Specimen Description Positioning
 . S DES(+$P(@RET@("S",0),U,4))=""
 . S CT="" F  S CT=$O(POS(CT)) Q:CT=""  D
 . . S SPB=0  F  S SPB=$O(POS(CT,SPB)) Q:'SPB  D
 . . . I $D(DES(CT)) S DES($O(DES(""),-1)+1)="",$P(@RET@("S",SPB),U,8)=$O(DES(""),-1) Q
 . . . S DES(CT)=""
 Q
 ;
DEFAULT(TYP) ; Set Default Configuration
 ; *RET
 ; *** ORDER ELEMENTS
 ;     O^ID^HIDE(1,0)^REQUIRED(1,0)^DEFAULT_VALUE
 I TYP="O" D  D END Q
 . S @RET@("O",1)="O^OPURG^^1"
 . S @RET@("O",2)="O^OPCDT^^1"
 . S @RET@("O",3)="O^OPCTY^^^WC"
 ; *** PAGES
 ;     P^NUMBER^NAME^RESPONSE_ID
 I TYP="P" D  D END Q
 . S @RET@("P",1)="P^1^*Clinical History^CLINHX"
 . S @RET@("P",2)="P^2^Pre-Operative Diagnosis^PREOPDX"
 . S @RET@("P",3)="P^3^Operative Findings^OPFIND"
 . S @RET@("P",4)="P^4^Post-Operative Findings^POSTOPDX"
 I TYP?1"PG;".N D  D END Q
 . S @RET@("P",$P(TYP,";",2))="PWW^"_$P(TYP,";",2)
 ; *** SPECIMEN
 ;     SPH^SP^HIDE_FROM_DESCRIPTION^POSITION^COLLECTION_SAMPLE_HIDE(1,0)^COLLECTION_SAMPLE_DEFAULT
 I TYP?1"SP;".N D  D END
 . S @RET@("S",0)="SPH^"_$P(TYP,";",2)_"^^0^^"_$$FIND1^DIC(62,,"X","AP SPECIMEN")
 Q
 ;
SPEC(RET,IEN) ; RPC: ORWLRAP1 SPEC
 ; *This returns the default specimen list.
 ;
 ;  RETURN
 ;    0 (1,0)ALLOW_OTHER^(1,0)RESTRICT_MULTIPLE
 ;    # IEN^SPECIMEN_NAME
 ;
 N C,SP
 S IEN=+$G(IEN),RET=$NA(^TMP($J,"SPEC ORWLRAP1")) K @RET S @RET@(0)=0
 Q:'IEN  Q:'$D(^LAB(69.73,IEN))
 S @RET@(0)=+$P($G(^LAB(69.73,IEN,0)),U,2)_U_+$P($G(^LAB(69.73,IEN,0)),U,3) D SPEC1
 Q:'$P($G(^LAB(69.73,IEN,3,0)),U,4)
 S C=$O(@RET@(""),-1)+1
 S SP="" F  S SP=$O(^LAB(69.73,IEN,3,"S",SP)) Q:SP=""  D
 . S @RET@(C)=$O(^LAB(69.73,IEN,3,"S",SP,""))_U_SP,C=C+1
 Q
 ;
SPEC1() ; Lab list of specimens for this test
 N OUT
 D COLL^LR7OR3(+$$GET1^DIQ(101.43,IEN,2),.OUT) Q:'$G(OUT("Specimens"))
 S CT=0 F  S CT=$O(OUT("Specimens",CT)) Q:'CT  D
 . S @RET@(CT)=OUT("Specimens",CT)
 Q
 ;
 ; SUPPORTING APIs ------------------------------------------------------------
 ;
NRQ(RQ,NM) ; Add * to name if required
 Q:RQ "*"_NM
 Q NM
 ;
VWL(ND0,ND1,IENS) ; Add value list as pipe delimited string
 N V,STR
 S V="" F  S V=$O(^LAB(69.73,IEN,ND0,ND1,1,IENS,1,"B",V)) Q:V=""  D
 . S STR=$S($D(STR):STR_"|"_$$EXT(1),1:$$EXT(1))_$S(ND0=2:";"_$$EXT(2)_"-"_$$EXT(4)_";"_$$EXT(3),1:";"_$$EXT(2))
 Q $G(STR)
 ;
EXT(PC) ; Extend Value
 Q:'$G(PC) ""
 N VI S VI=$O(^LAB(69.73,IEN,ND0,ND1,1,IENS,1,"B",V,""))
 Q $P($G(^LAB(69.73,IEN,ND0,ND1,1,IENS,1,+VI,0)),U,PC)
 ;
END ; Clean Up
 I $O(@RET@(""),-1)?.A K @RET@(0) Q
 K:$O(@RET@(""),-1) @RET@(0)
 Q
