DGMTCQ ;ALB/TET - MEANS TEST CONVERSION DRIVER & UTILITY ; 4/22/92
 ;;5.2;REGISTRATION;;JUL 29,1992
 ;Routine checks status of conversion ("MTC" node in file 43).
 ;  If aborted, will resume where it left off
 ;            Piece one of DG(43,1,"MTC")=Last Completed DFN
 ;             Piece two of DG(43,1,"MTC")=Date Conversion Started
 ;           Piece three of DG(43,1,"MTC")=Date Conversion Completed
EN ;entry/restart point for means test conversion
 I '$D(^DG(41.3)) W !!,">>> Means Test global ^DG(41.3 does not exist.  Conversion is not needed." G ENQ
 S DGCK=$G(^DG(43,1,"MTC")) I $P(DGCK,U,3) W !!,">>> Conversion already completed!",*7 G ENQ
 F I=1:1 S X=$P($T(MSG+I),";;",2) Q:X="END"  W !,X
 G SET
 ;
ENQ D EXIT^DGMTC0
 Q
 ;
SET ;set conversion variables
 S (DFN,DGCK)=0,U="^" D NOW^%DTC S DT=X K DGCNVR
 S DGEND=$E(DT,1,3)-3_"0101",DGBEG=DT,DGIBEG=9999998-DGBEG,DGIEND=9999999-DGEND,DGY=$E(DGEND,1,3)-1_"0000",DGLN=0
 D ^IBYMT S DGCK=$G(^DG(43,1,"MTC")) I DGCK]"" D CK G SETQ:$G(DGCNVR)
 G ^DGMTC1:$P(DGCK,U,2)']"",^DGMTC0
SETQ W !,"...conversion is already running!!",!
 D EXIT^DGMTC0
 Q
 ;
CK W !,">>> Checking to see if conversion is already running..."
 F I=1:1:4 W "." H 30 I +$G(^DG(43,1,"MTC"))'=+DGCK S DGCNVR=1 Q
 Q
 ;
ERR ;write new entries with corrupt data
 S DGVAR="DGDA"_$P(DGF,".",2) I $D(@DGVAR) D
 .W !,"     CHECK file ",DGF,"  entry ",@(DGVAR)
 Q
DEL ;delete file 41.3
 S DIU="^DG(41.3,",DIU(0)="DT" D EN^DIU2 K DIU
 Q
 ;
MSG ;text
 ;;
 ;;The conversion of the entries in the Means Test file
 ;;into the new format may take a few hours.
 ;;
 ;;When the conversion has completed, the beginning and
 ;;ending times of the conversion, as well as the number
 ;;of income and means test entries converted will be printed.
 ;;
 ;;Warning messages may also be printed if data in the old Means
 ;;Test file #41.3 is corrupt (internal entry number in 41.3 does
 ;;not equal the pointer value to the Patient file #2), and data
 ;;is converted into the new file(s).
 ;;
 ;;END
