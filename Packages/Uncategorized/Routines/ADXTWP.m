ADXTWP ;523/KC -- encapsulate adding line to WP field;14-MAY-93
 ;;1.1;;
 ;
WP(ADXTFNUM,ADXTFLD,ADXTDA,ADXTX) ; 
 ;
 ;  ADXTFNUM  = FILE NUMBER OF FILE ADDING LINE TO WP FIELD OF
 ;  ADXTFLD   = FIELD NUMBER OF WP FIELD (MUST BE ON TOP LEVEL!)
 ;  ADXTDA    = DA OF ENTRY TO ADD TO
 ;  ADXTX         = LINE TO ADD TO WP FIELD
 ; 
 ; VERIFY IT'S A WP FIELD?
 ;
 S ADXTROOT=^DIC(ADXTFNUM,0,"GL")
 S ADXTSUB=$P($G(^DD(ADXTFNUM,ADXTFLD,0)),"^",4)
 S ADXTSUB=$P(ADXTSUB,";")
 ;
 I '$D(@(ADXTROOT_ADXTDA_",0)")) Q 0 ; quit if no DA
 ;
 ; do stuff for a WP field (single subscript worth)
 ;
 S ADXTZNOD=ADXTROOT_ADXTDA_","_ADXTSUB_",0)"
 I '$D(@ADXTZNOD) D NOW^%DTC S @ADXTZNOD="^^0^0^"_X_"^" ;header node
 ;
 ; get what will become last subs., then reset header node
 S ADXTLOC0=$E(ADXTZNOD,1,($L(ADXTZNOD)-2))_"ADXTLVL)"
 S ADXTLVL="" F  S ADXTLVL=$O(@ADXTLOC0) Q:ADXTLVL=""  S ADXTLVL0=ADXTLVL
 S ADXTLOC=$E(ADXTZNOD,1,($L(ADXTZNOD)-2))_(ADXTLVL0+1)_",0)"
 S $P(@ADXTZNOD,"^",3)=ADXTLVL0+1,$P(@ADXTZNOD,"^",4)=ADXTLVL0+1
 ;
 S @ADXTLOC=ADXTX ; set data value
 Q 1
