VEJDPXBA ;;AMC - Document Storage Systems;;Checkout Encounter Utility RPC's
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
BEFORE(VIEN)    ;snap shot of visit data before edits
 Q:'$G(VIEN) 0 K ^TMP("HOLD PXKENC",$J)
 N A,SA,NA
 I $D(^TMP("PXKENC",$J)) M ^TMP("HOLD PXKENC",$J)=^TMP("PXKENC",$J)
 D ENCEVENT^PXKENC(VIEN)
 S (SA,A)=$NA(^TMP("PXKENC",$J,VIEN)),SA=$P(SA,")")_","
 F  S A=$Q(@A) Q:A'[SA  S NA="^TMP(""NEW PXKCO"","_$P($P(A,")"),",",2,6)_",""BEFORE"")",@NA=@A
 I $D(^TMP("HOLD PXKENC",$J)) K ^TMP("PXKENC",$J) M ^TMP("PXKENC",$J)=^TMP("HOLD PXKENC",$J) K ^TMP("HOLD PXKENC",$J)
 Q 1
AFTER(VIEN)     ;snap shot of visit data after edits
 Q:'$G(VIEN) 0 K ^TMP("HOLD PXKENC",$J)
 N A,SA,NA
 I $D(^TMP("PXKENC",$J)) M ^TMP("HOLD PXKENC",$J)=^TMP("PXKENC",$J)
 D ENCEVENT^PXKENC(VIEN) S PXKCO("SOR")=+$P($G(^TMP("PXKENC",$J,VIEN,"VST",VIEN,812)),U,2)
 S (SA,A)=$NA(^TMP("PXKENC",$J,VIEN)),SA=$P(SA,")")_","
 F  S A=$Q(@A) Q:A'[SA  S NA="^TMP(""NEW PXKCO"","_$P($P(A,")"),",",2,6)_",""BEFORE"")",@NA=@A
 I $D(^TMP("HOLD PXKENC",$J)) K ^TMP("PXKENC",$J) M ^TMP("PXKENC",$J)=^TMP("HOLD PXKENC",$J) K ^TMP("HOLD PXKENC",$J)
 Q 1
