ADXTUT2 ;523/kc continuation of ^ADXTUT utility functions; 24-may-1993
 ;;1.1;;
 ;
SIZE(X,ADXTMOR) ; return X if melanoma, 10*X if not melanoma
 S ADXTMOR=$E(ADXTMOR,1,4)
 I (ADXTMOR>8719)&(ADXTMOR<8791)&(X'="99.9") Q +X
 Q (10*+X)
 ;
GTOPPOLD(ADXTPID,ADXTDTOP,ADXTDSQ) ; old method to get pointer to ONCOLOGY
 ; PRIMARY file, by lookup of DTOP,PID,DSQ...
 ; output: DA by raw lookup of acc/seq + dtop, 0 if not matched
 N ADXTID,ADXTDA
 S ADXTID=$E(ADXTPID,1,2)_"-"_$E(ADXTPID,4,7)_"/"_ADXTDSQ
 S ADXTDA=0,ADXTDA=$O(^ONCO(165.5,"D",ADXTID,ADXTDA))
 I +ADXTDA Q:$P($G(^ONCO(165.5,ADXTDA,2)),"^",1)=$$GTTP^ADXTUT(ADXTDTOP) ADXTDA
 Q 0
 ;
ZGTSP(X) ; get idco site pointer from DTOP value (OLD METHOD)
 ; input:  "DTOP" value from MRS as X;
 ; ??169??
 ; output: pointer if found in file #164.2, 0 if not found
 ;
 N ADXTDTOP
 S X=$$TRIM^ADXTUT(X) S ADXTDTOP=$$GTTP^ADXTUT(X) Q:'+ADXTDTOP 0
 S ADXTDTOP="C"_$P(ADXTDTOP,"67",2)
 I $L(ADXTDTOP)'=4 Q 0
 Q +$O(^ONCO(164.2,"D",$E(ADXTDTOP,1,3)_"."_$E(ADXTDTOP,4),0))
 ;
GTSPOLD(X) ; old method of getting site pointer
 S X=$$TRIM^ADXTUT(X)
 N ADXTPP
 S ADXTPP=+$O(^ONCO(164.2,"G","T"_$E(X,1,3)_"."_$E(X,4),""))
 I +ADXTPP Q +ADXTPP
 S ADXTPP=+$O(^ONCO(164.2,"F","T"_$E(X,1,3)_"."_$E(X,4),""))
 I +ADXTPP Q +ADXTPP
 Q 0
 ;
XREFDUP(ADXTFNUM,ADXTDA,X) ; built a conversion id cross-ref entry
 N ADXTFLD S ADXTFLD=523008
 Q:(ADXTFNUM'=160)&(ADXTFNUM'=165) -1 ; quit if not wrong file
 Q:'$L(X) -1 ; quit if X null
 Q:'(+ADXTDA>0) -1 ; quit if bogus DA
 Q:'$D(^ONCO(ADXTFNUM,ADXTDA,0)) -1 ; quit if non-existent DA
 I '$D(^ONCO(ADXTFNUM,"A523008",X,ADXTDA)) D ^ADXTMULT ; add xref
 I $D(^ONCO(ADXTFNUM,"A523008",X,ADXTDA)) Q 1 ; if successful
 Q -1 ; if unsuccessful
 ;
KERMOK() ; return 1 if kermit OK, 0 if Kermit not OK
 N ADXTDA,ADXTVER
 S ADXTDA="" S ADXTDA=$O(^DIC(9.4,"B","KERNEL",ADXTDA))
 S ADXTVER=0 I +ADXTDA S ADXTVER=$G(^DIC(9.4,ADXTDA,"VERSION"))
 I +ADXTVER=0 S ADXTVER=0
 I ADXTVER="6.5" Q 1
 I ADXTVER="7.0" Q +($T(XTKERM1+1^XTKERM1)["**10**")
 I +ADXTVER>7.0 Q 1
 Q 0
LOCALOK() ; return 1 if local fields present, 0 if not!
 Q:'$D(^DD(523701)) 0
 ;
 Q:'$D(^DD(160,523000,0)) 0
 Q:'$D(^DD(160,523000.1,0)) 0
 Q:'$D(^DD(160,523001,0)) 0
 Q:'$D(^DD(160,523002,0)) 0
 Q:'$D(^DD(160,523003,0)) 0
 Q:'$D(^DD(160,523004,0)) 0
 Q:'$D(^DD(160,523008,0)) 0
 ;
 Q:'$D(^DD(165,523000,0)) 0
 Q:'$D(^DD(165,523000.1,0)) 0
 Q:'$D(^DD(165,523001,0)) 0
 Q:'$D(^DD(165,523002,0)) 0
 Q:'$D(^DD(165,523003,0)) 0
 Q:'$D(^DD(165,523008,0)) 0
 ;
 Q:'$D(^DD(165.5,523000,0)) 0
 Q:'$D(^DD(165.5,523000.1,0)) 0
 Q:'$D(^DD(165.5,523002,0)) 0
 Q:'$D(^DD(165.5,523004,0)) 0
 Q:'$D(^DD(165.5,523005,0)) 0
 ;
 Q:'$D(^DD(165.2,523001,0)) 0
 ;
 Q 1 ; all fields are present!
