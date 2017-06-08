DSICPX1 ;DSS/SGM - PCE RELATED RPCS ;03/05/2004 00:48
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;
 ; This routine has several RPC calls to PCE
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  ----------------------------------------
 ;  1239  Cont Sub   IMMUN^PXRHS03
 ;
IMMLIST(DSIC,DFN) ; RPC: DSIC PX IMMUN LIST
 ;  return pt's immunization list
 ;  DFN - required - pointer to the patient file
 ;  Return DSIC() = IFN^p2^p3^p4^p5
 ;     p1 = ifn (#9000010.11)
 ;     p2 = immunization name
 ;     p3 = event/visit/admit fileman date.time
 ;     p4 = reaction
 ;     p5 = inverse event/visit/admit date.time
 ;  On error, return -1^message
 I $L($T(IMMUN^PXRHS03))<1 S DSIC(1)="-1^Immunizations not available." Q
 N I,X,Y,Z,IEN,IMM,IVDT,ROOT,STOP
 S X=$$GET^DSICDPT1($G(DFN)) I X<1 S DSIC(1)=X Q
 K ^TMP("PXI",$J) D IMMUN^PXRHS03(DFN)
 S I=0,ROOT=$NA(^TMP("PXI",$J)),STOP=$E(ROOT,1,$L(ROOT)-1)
 F  S ROOT=$Q(@ROOT) Q:ROOT'[STOP  S X=@ROOT I X'="",$QS(ROOT,6)=0 D
 .S IMM=$QS(ROOT,3) ; immunization name
 .S IVDT=$QS(ROOT,4) ; inverse fileman d/t of event or visit
 .S IEN=$QS(ROOT,5) ; ifn to vitals file
 .S I=I+1,DSIC(I)=IEN_U_IMM_U_$P(X,U,3)_U_U_IVDT
 .I $P(X,U,7)=1 S $P(DSIC(I),U,4)=$P(X,U,6)
 .Q
 S:'$D(DSIC) DSIC(1)="-1^No immunizations found"
 K ^TMP("PXI",$J)
 Q
