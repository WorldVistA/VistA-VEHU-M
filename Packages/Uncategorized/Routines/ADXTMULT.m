ADXTMULT ;523/KC ADD .01 FIELD OF A MULTIPLE
 ;;1.1;;
 ;
 ; INPUT VARIABLES:
 ;  ADXTFNUM: file number of top level file
 ;  ADXTFLD: field number of multiple at top level
 ;  ADXTDA: internal entry number of top level entry
 ;  X: value of .01 field
 ; OUTPUT VARIABLE:
 ;  ADXTSBDA: -1 if didn't add, DA number of added entry if successful
 ;
 N ADXTROOT,ADXTSBS,ADXTZNOD,DA,DIC,Y
 D VAR
 I '$D(@ADXTZNOD) S @ADXTZNOD="^"_$P(^DD(ADXTFNUM,ADXTFLD,0),"^",2)
 K DD,D0 S DIC(0)="L" D FILE^DICN S ADXTSBDA=+Y
ERR ;
 S ADXTMETH=""
 I ADXTSBDA<0 K ADXTSBF D MSG^ADXTCERR
EXIT ;
 K ADXTROOT,ADXTSBS,ADXTZNOD,DA,DIC,Y
 Q
VAR ;
 S DA(1)=ADXTDA
 S ADXTSBS=$P($P(^DD(ADXTFNUM,ADXTFLD,0),"^",4),";",1)
 I +ADXTSBS'=ADXTSBS S ADXTSBS=""""_ADXTSBS_""""
 S ADXTROOT=^DIC(ADXTFNUM,0,"GL")
 S DIC=ADXTROOT_DA(1)_","_ADXTSBS_","
 S ADXTZNOD=DIC_"0)"
 S ADXTSTFF=X
 Q
