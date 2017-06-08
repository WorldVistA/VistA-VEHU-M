DSICTIU1 ;DSS/SGM - GET TIU NOTE TEXT & VAR-PTR NOTE IFNS ;06/09/2004 15:37
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  SUPPORTED  DESCRIPTION
 ; -----  ---------  -------------------------------------
 ;  2944  Cont Sub   TGET^TIUSRVR1
 ;  3536  Cont Sub   GETDOCS^TIUSRVLR
 ; 10103      x      $$FMTE^XLFDT
 ;
LIST(DSIC,DSICVP,SEQ,REC) ;  RPC: DSIC TIU LIST SPECIAL DOCS
 ; NOTES: Only return signed, official notes
 ;        Either DSICVP or REC must be passed
 ; DSICVP - opt - Fileman variable pointer format that identifies the
 ;                record in the requesting application
 ;    SEQ - opt - default value = "D"
 ;                indicates the date order of documents returned
 ;                "A"=ascending (Regular date/time)
 ;                "D"=descending (Reverse date/time)
 ;    REC - opt - the internal entry number from the file that has
 ;                special classes of TIU documents associated with it.
 ;                REC format - <character><^><ien>
 ;                For surgery, it is S^<Surgery case number [#130 ifn])
 ;                NOTE: DSICVP takes precedence over REC
 ;   DSIC - return array - passed by reference
 ;          DSIC = $NA(^TMP("TIULIST",$J))       
 ;   @DSIC@(#) = p1^p2^...^p14  where
 ;    p1 = IFN
 ;    p2 = title
 ;    p3 = Reference date.time (int;ext)
 ;    p4 = Patient Name (LAST i/Last 4)
 ;    p5 = Author (int;ext)
 ;    p6 = Hospital Location
 ;    p7 = Signature Status
 ;    p8 = Visit Date/Time
 ;    p9 = Discharge Date/time
 ;   p10 = Variable Pointer to Request (e.g., Consult)
 ;   p11 = # of Associated Images
 ;   p12 = Subject
 ;   p13 = Has Children
 ;   p14 = IEN of Parent Document
 ;   On error in input, return @DSIC@(1) = -1^message
 ;   See bottom of routine for a surgery example
 N X,Y,DSI,DSICX
 S DSIC=$NA(^TMP("TIULIST",$J)) K @DSIC
 S DSICVP=$G(DSICVP),SEQ=$E($G(SEQ)),REC=$G(REC)
 S SEQ=$S("Dd"[SEQ:SEQ,"Aa"[SEQ:"A",1:"D")
 S X=$$EVAL I X<1 S @DSIC@(1)=X Q
 D GETDOCS^TIUSRVLR(.DSIC,DSICVP,SEQ)
 I '$D(DSIC) S @DSIC@(1)="-1^No TIU documents found for "_DSICVP Q
 F DSI=0:0 S DSI=$O(@DSIC@(DSI)) Q:'DSI  S DSICX=^(DSI) D
 .;  check for signed notes only
 .S X=$P(DSICX,U,7) I X'="completed",X'="amended" Q
 .S X=$P(DSICX,U,3),Y="" S:X Y=$TR($$FMTE^XLFDT(X,"5Z"),"@"," ")
 .I Y'="" S X=$P(DSICX,U,3)_";"_Y,$P(@DSIC@(DSI),U,3)=X
 .Q
 I '$O(@DSIC@(0)) S @DSIC@(1)="-1^No signed TIU documents found for "_DSICVP
 S X="" F  S X=$O(@DSIC@(X)) Q:X=""  K:'X ^(X)
 Q
 ;
TEXT(DSIC,DSIEN,ACTION) ;  RPC: DSIC TIU GET RECORD TEXT
 ;     IEN - required - IFN to file 8925
 ;  ACTION - optional - default to "VIEW" - the action values
 ;           are not well documented, so do not pass a value
 ;    DSIC - return variable - passed by reference
 ;           DSIC = $NA(^TMP("TIUVIEW",$J))
 ;
 N X,Y
 S DSIC=$NA(^TMP("TIUVIEW",$J)) K @DSIC
 S:$G(ACTION)="" ACTION="VIEW"
 I '$G(DSIEN) S @DSIC@(1)="-1^No TIU IFN received"
 D TGET^TIUSRVR1(.DSIC,DSIEN,ACTION)
 I '$D(@DSIC) S @DSIC@(1)="-1^No note text retrieved for IFN "_DSIEN
 Q
 ;
 ;--------------  subroutines  ---------------
EVAL() ;  evaluate IEN as valid input parameter for LIST above
 ;  sets DSICVP if DSICVP="" and IEN is valid
 ;  Returns 1 or -1^message
 N X,X1,X2,Y,DSIFILE,RET,ROOT
 I '$L(DSICVP),'$L(REC) Q "-1^No valid DSICVP nor REC values received"
 I $L(DSICVP) D  Q X
 .S X1=$P(DSICVP,";"),X2=$P(DSICVP,";",2,99),Y=0
 .I +X1'=X1 S Y=1
 .E  I $E(X2)'?1U S Y=1
 .E  S X=$E(X2,$L(X2)) I X'="(",(X'=",") S Y=1
 .S X=$S('Y:1,1:"-1^Invalid DSICVP received: "_DSICVP)
 .Q
 S X1=$P(REC,U),X2=$P(REC,U,2,9)
 S X="-1^Invalid record type character received on REC: "_REC
 I "^S^"'[(U_X1_U) Q X
 S DSIFILE=$S(X1="S":130,1:-1) I DSIFILE=-1 Q -1
 I +X2'=X2 Q "-1^IEN is not a number in REC: "_REC
 K X S X("FILE")=DSIFILE,X("VALUE")=X2,X("TYPE")=1,X("IFN")=1
 I $$V1^DSICFM03(,.X)>0 D  Q 1
 .S ROOT=$$ROOT^DSICFM06(,DSIFILE,,,1),DSICVP=X2_";"_$P(ROOT,U,2)
 .Q
 Q "-1^Record number from REC does not exist: "_REC
 ;
 ;   example of a list return for a surgical case number
 ;^TMP("TIULIST",551061958,2) = 10884649^OPERATION REPORT^
 ;3040514.152;05/14/2004 15:20^GLKHA, ALPUHYJH I (G9944)^
 ;1000007911;ROZALES A SWANSON,M.D.;SWANSON,ROZALES A^
 ;NHCU-C^unsigned^Adm: 04/30/04^Dis: 06/13/04^306242;SRF(^0^
 ;Case #: 306242^^1^
