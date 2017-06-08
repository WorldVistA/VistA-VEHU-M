%RO ;GFT/SF ; 5JUN1986 2:36 PM; FOR DSM-- SENDS ROUTINES SO ISM CAN READ THEM
 ;;5.01;
 W !!,"Routine Save",! S %ZERS=$ZE,$ZE="%ERR^%RO" I %ZERS?1"<".E S %ZERS=""
 K ^UTILITY($J)
%ST S %QTY=2 K %DEF D ^%IOS S:'$D(%MTM) %MTM="" G:'$D(%IOD) %EXIT
 I "MT,TRM,SDP,LP,SC"'[%DTY W !,?5,*7,"Improper device selection" G %DONE
 G %HEAD:%DTY'["MT"
 U %IOD I @(%MTON_"=0") U 0 W !?5,*7,"Drive not ready" G %DONE
 I @%MTWLK U 0 W !?5,*7,"Tape is write protected" G %DONE
 I @(%MTBOT_"=0") U 0 D %REW^%IOS I '$D(%REW) G %DONE
%HEAD U 0 R !,"Header comment... ",%HEAD:$S($D(DTIME):DTIME,1:60) G:'$T %DONE G:%HEAD="^" %DONE
 I %HEAD="?" W !,?5,"Enter free text to be used as heading" D %Q G %HEAD
%RSEL D ^%RSEL G:'$D(%GO) %HEAD G:'%GO %HEAD
 S %NAM="",%CT=0 I $ZS(^UTILITY($J,%NAM))="" G %DONE
 D INT^%D,INT^%T U %IOD
%CNT I %DTY="SDP"!(%DTY="MT") W %DAT1_"     "_%TIM D AVL W %HEAD D AVL G %G2
 W #,!,"Routine listing ",%DAT1,"     ",%TIM,!,%HEAD,!!
%G1 S %NAM=$ZS(^UTILITY($J,%NAM)) I %NAM="" S %CT=0 W #,! G %G2
 W:'(%CT#8) ! W ?(%CT#8*10),%NAM S %CT=%CT+1 G %G1
%G2 S %NAM=$ZS(^UTILITY($J,%NAM)) I %NAM="" U %IOD W:%DTY'="MT" "",! G %DONE
 U %IOD I %DTY["MT",@%MTEOT G EOT
%G2A S PPP="F JJJ=1:1 Q:$T(+JJJ)=""""  W $T(+JJJ)" X "ZL @%NAM U %IOD W %NAM W:'((%DTY=""MT"")&(%MTM[""V"")) ! X PPP W ! S %ZA=$ZA W:%DTY=""TRM""!(%DTY=""LP"")!(%DTY=""SC"") #,! U 0 I %IOD'=$I W:'(%CT#8) ! W ?(%CT#8*10),%NAM"
 I %IOD>58,%IOD<63 I %ZA<0 W !!?5,*7,"End of SDP space encountered." G %RO
 S %CT=%CT+1 G %G2
AVL W:'((%DTY="MT")&(%MTM["V")) ! Q
%Q W !?5,"Enter ^ to return to previous question" Q
%DONE U 0 K ^UTILITY($J) I $D(%IOD),%IOD'=$I U %IOD S ZA=$ZA,ZB=$ZB C %IOD U 0 I %DTY="SDP" W !,"Stopped at block #",ZA,",byte #",ZB,!
 G %ST
%EXIT U 0 I $D(%IOD) C:%IOD'=$I %IOD
 K %MTBOT,%MTEOT,%MTLER,%MTON,%MTPIP,%MTTMK,%MTTYP,%MTWLK,%MTM
 K ^UTILITY($J),%HEAD,%CT,%DAT,%DAT1,%DTY,%GO,%IOD,%NAM,%REW,%RST,%TIM,%ZA S $ZE=%ZERS K %ZERS Q
%ERR S ZA=$ZA,ZE=$ZE,$ZT="%ERR^%RO" I ZE?1"<INRPT".E U 0 W !?5,*7,"Unexpected interrupt",! G %EXIT
 I ZE["<PGMOV>"!(ZE["<STORE>") U 0 W #!,*7,%NAM," is too large for this partition, and will not be saved.",!!,*7,# G %G2
 I ZE["<NOPGM>",$D(%NAM) U 0 W #!,*7,%NAM,?12,"has been deleted since creation of your list.  Continuing...",*7,!# G %G2
 I %DTY="LP" I $ZA\16#2 U 0 W !,"Line printer not ready",! S $ZE="%ERR^%RS" G %ST
 G:ZE'["<MTERR>" %E2 S $ZE="%ERR^%RS" I @(%MTTMK_"=1") G %DONE
EOT ;
 U 0 W !!?5,*7,"** End of tape detected **",!?5,"After current tape rewinds, mount next tape"
 U %IOD W *5 U 0 W !?5,"Type <CR> to continue, ^ to abort " R %GO:$S($D(DTIME):DTIME,1:60),! G:'$T %DONE G:%GO="^" %DONE
 U %IOD W %DAT1,"     ",%TIM,!,%HEAD,! G %G2A
%E2 U 0 W !,ZE,"   $ZA = ",ZA C:(($D(%IOD))&(%IOD'=$I)) %IOD G %RO
