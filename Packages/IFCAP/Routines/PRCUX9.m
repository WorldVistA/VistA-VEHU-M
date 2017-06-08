PRCUX9 ;WISC/PLT-CONVERT FILE POINTER TO 16 TO 200 FOR FILE 442.9 ; 05/18/93  10:50 AM
V ;;4.0;IFCAP;;9/23/93
CVT(X) ;CONVERT RANGE OF RECORDS - X?.N1"-".N
 N BEGIN,END,DA
 S BEGIN=$P(X,"-"),END=$P(X,"-",2)
 S DA=BEGIN-1 L +^PRC(442.9)
 F  S DA=$O(^PRC(442.9,DA)) Q:'DA  Q:DA>END  I $D(^(DA,0)) D ONE(DA) W:DA#1000=0 "."
 L -^PRC(442.9) QUIT
ONE(DA) ;ENTRY POINT TO CONVERT ONE RECORD
  ;convert file 442.9, Field 2 (placed on list by)) to 200 pointer
 ; not rerun able
 NEW RECORD
 S RECORD=$G(^PRC(442.9,DA,0)) QUIT:$P(RECORD,"^",8)=1
 S X=+$P(RECORD,"^",3)
 I X>0 D
 . I '$D(^DIC(16,X,0)) D  QUIT  ;record error when entry in 16 missing
 . . S $P(RECORD,"^",3)=X_",RECORD MISSING IN FILE 16" QUIT
 . . S PARAM="442.9^2^"_LEVEL0_"^^^1^ONE^PRCUX9"
 . . D ERROR^PRCUESIG(PARAM)
 . . QUIT
 . I $G(^DIC(16,X,"A3"))="" D  QUIT  ;record error when xref missing
 . . S $P(RECORD,"^",3)=X_",A3 XREF MISSING FILE 16" QUIT
 . . S PARAM="442.9^2^"_LEVEL0_"^^^2^ONE^PRCUX9"
 . . D ERROR^PRCUESIG(PARAM)
 . . QUIT
 . S $P(RECORD,"^",3)=X
 . QUIT
 S $P(RECORD,"^",8)=1,^PRC(442.9,DA,0)=RECORD
 QUIT
 ;
BUILD ;BUILD ENTRIES IN 443.1 FOR FILE 442.9 CONVERSION
 NEW X,FIRST,LAST,IX,VAR,MSG
 S FIRST=$O(^PRC(442.9,0)) Q:FIRST=""
 S LAST=$P($G(^PRC(442.9,0)),"^",3)
 W !,"Finding Last Entry in 442.9"
 F  S X=$O(^PRC(442.9,LAST)) Q:'X  S LAST=X
 W "   Last Entry = ",LAST
 W !,"Building conversion list for 442.9"
 F IX=FIRST:100:LAST DO
 . S VAR=IX_"-"_(IX+99)
 . D ADD^PRCUPM1("CVT^PRCUX9",VAR,.MSG)
 . W "." K MSG
 . QUIT
 W !,"Conversion list for 442.9 completed.",!
 QUIT
