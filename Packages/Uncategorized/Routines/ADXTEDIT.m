ADXTEDIT ;523/KC -- module to add a field to a file ;19-SEP-1992
 ;;1.1;;
 ;
 ; INPUT VARIABLES:
 ;
 ; ADXTFNUM: FILE NUMBER OF VA FILE BEING ADDED
 ; ADXTFLD: FIELD NUMBER (TOP LEVEL)
 ; ADXTDA: INTERNAL ENTRY # BEING EDITED (TOP LEVEL)
 ; ADXTSBF : LOWER LEVEL FIELD NUMBER (IF $D(ADXTSBF))
 ; ADXTSBDA : LOWER LEVEL INTERNAL NUMBER (IF $D(ADXTSBDA))
 ;
 ;* ADXT(): ARRAY OF MRS VALUES BEING CONSIDERED
 ;* ADXTLBL : MRS SOURCE FILE (FL,DI,PAT,SCD,or DOC)
 ;* ADXTRN : MRS SOURCE TMP SUBSCRIPT NUMBER
 ;* ADXTLINE: MRS-TO-DHCP CONVERSION FIELD GUIDE, IN FORM:
 ;   1: VA file MRS var to be added into
 ;   2: VA field MRS var to be added into
 ;   3: MRS field to add
 ;   4: 3 or 4 for number of slashes to stuff, W for Word processing
 ;   5-50: input transform
 ;
 U IO
 N ADXTDD,ADXTINPT,ADXTLOC,ADXTLOC0,ADXTLVL,ADXTLVL0,ADXTMETH,ADXTMRS,ADXTPC,ADXTROOT,ADXTSBS,ADXTSTFF,ADXTSUB,DIE,DR,DA,ADXTXSAV,ADXTZ
 D VAR
 I $L(X) X:$L(ADXTINPT) ADXTINPT D:'$D(X) ^ADXTCERR I $D(X) I $L(X) D EDIT
 U IO(0) Q
 ;
EDIT ; actually try to add the field
 S X=$TR(X,";:",",,")
 S ADXTSTFF=X
 I ADXTMETH="W" D WP Q  ; if word-processing, add as a WP field
 I ((ADXTMETH'=3)&(ADXTMETH'=4)) U IO(0) W !,"no stuff method given!!" Q
 S DIE=ADXTROOT
 ;
 I '$D(ADXTSBDA) D  ; set up for a top-level edit if needed
 .S DA=ADXTDA
 .S DR=ADXTFLD_"///"_$S(ADXTMETH=4:"/",1:"")_ADXTSTFF
 ;
 I $D(ADXTSBDA)&$D(ADXTSBF) D  ; set up for a multiple if needed
 .S DA(1)=ADXTDA,DA=ADXTSBDA
 .S ADXTSBS=$P($P(^DD(ADXTFNUM,ADXTFLD,0),"^",4),";",1)
 .I +ADXTSBS'=ADXTSBS S ADXTSBS=""""_ADXTSBS_""""
 .S DIE=DIE_DA(1)_","_ADXTSBS_","
 .S DR=ADXTSBF_"///"_$S(ADXTMETH=4:"/",1:"")_ADXTSTFF
 ;
 ; set error trap for ^DIE call
 S ADXTXSAV=X S X="ERR^ADXTEDIT",@^%ZOSF("TRAP") S X=ADXTXSAV
 ;
 U IO W ADXTFLD,": " D ^DIE
 I ADXTMETH=3 D STFCHK
 G EXIT ;skip err section
ERR ;
 D @^%ZOSF("ERRTN")
EXIT ;
 K ADXTDD,ADXTINPT,ADXTLOC,ADXTLOC0,ADXTLVL,ADXTLVL0,ADXTMETH,ADXTMRS,ADXTPC,ADXTROOT,ADXTSBS,ADXTSTFF,ADXTSUB,DIE,DR,DA,ADXTXSAV,ADXTZ
 Q
STFCHK ; check if a 3-/// stuff transpired
 S ADXTDD=1
 I '$D(ADXTSBDA) D  ; not multiple
 .S ADXTSUB=$P($G(^DD(ADXTFNUM,ADXTFLD,0)),"^",4)
 .S ADXTPC=$P(ADXTSUB,";",2),ADXTSUB=$P(ADXTSUB,";")
 .S ADXTLOC=ADXTROOT_ADXTDA_","_ADXTSUB_")"
 I $D(ADXTSBDA)&$D(ADXTSBF) D  ; multiple
 .S ADXTZ=+$P(^DD(ADXTFNUM,ADXTFLD,0),"^",2)
 .S ADXTSUB=$P($G(^DD(ADXTZ,ADXTSBF,0)),"^",4)
 .S ADXTPC=$P(ADXTSUB,";",2),ADXTSUB=$P(ADXTSUB,";")
 .S ADXTLOC=ADXTROOT_ADXTDA_","_ADXTSBS_","_ADXTSBDA_","_ADXTSUB_")"
 I '$L($P($G(@ADXTLOC),"^",ADXTPC)) D ^ADXTCERR
 Q
WP ; do stuff for a WP field (single subscript worth)
 I '$D(ADXTSBDA) D  ; not multiple
 .S ADXTZNOD=ADXTROOT_ADXTDA_","_ADXTSUB_",0)"
 I $D(ADXTSBDA)&$D(ADXTSBF) D  ; multiple
 .S ADXTZNOD=ADXTROOT_ADXTDA_","_ADXTSBS_","_ADXTSBDA_","_ADXTSUB_",0)"
 I '$D(@ADXTZNOD) D NOW^%DTC S @ADXTZNOD="^^0^0^"_X_"^" ;header node
 ;
 ; get 1st avail. subs., reset header node
 S ADXTLOC0=$E(ADXTZNOD,1,($L(ADXTZNOD)-2))_"ADXTLVL)"
 S ADXTLVL="" F  S ADXTLVL=$O(@ADXTLOC0) Q:ADXTLVL=""  S ADXTLVL0=ADXTLVL
 S ADXTLOC=$E(ADXTZNOD,1,($L(ADXTZNOD)-2))_(ADXTLVL0+1)_",0)"
 S $P(@ADXTZNOD,"^",3)=ADXTLVL0+1,$P(@ADXTZNOD,"^",4)=ADXTLVL0+1
 ;
 S @ADXTLOC=ADXTSTFF ; set data value
 Q
VAR ; set up variables from "ADXTLINE" variable
 S ADXTSUB=$P($P($G(^DD(ADXTFNUM,ADXTFLD,0)),"^",4),";")
 S ADXTROOT=^DIC(ADXTFNUM,0,"GL")
 S ADXTMRS=$P(ADXTLINE,"^",3)
 S ADXTMETH=$P(ADXTLINE,"^",4)
 S ADXTINPT=$P(ADXTLINE,"^",5,50)
 S X=$$TRIM^ADXTUT(ADXT(ADXTMRS)) ; changed to trim 5/14/93 kc
 S ADXTDD=0
 S ADXTSBS=$P($P(^DD(ADXTFNUM,ADXTFLD,0),"^",4),";",1)
 I +ADXTSBS'=ADXTSBS S ADXTSBS=""""_ADXTSBS_""""
 I '$D(ADXTSBDA) D  ; not multiple
 .S ADXTSUB=$P($G(^DD(ADXTFNUM,ADXTFLD,0)),"^",4)
 .S ADXTPC=$P(ADXTSUB,";",2),ADXTSUB=$P(ADXTSUB,";")
 I $D(ADXTSBDA)&$D(ADXTSBF) D  ; multiple
 .S ADXTZ=+$P(^DD(ADXTFNUM,ADXTFLD,0),"^",2)
 .S ADXTSUB=$P($G(^DD(ADXTZ,ADXTSBF,0)),"^",4)
 .S ADXTPC=$P(ADXTSUB,";",2),ADXTSUB=$P(ADXTSUB,";")
 I +ADXTSUB'=ADXTSUB S ADXTSUB=""""_ADXTSUB_""""
 Q
