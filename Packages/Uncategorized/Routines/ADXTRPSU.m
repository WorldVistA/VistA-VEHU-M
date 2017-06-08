ADXTRPSU ;523/KC print subsequent recurrences report ; 06-OCT-1993
 ;;1.1;;
XUP ;
 I '$D(U)!('$D(DUZ))!($G(DUZ(0))'="@")!('+$G(DUZ))
 I  W !!,"Not set up with programmer variables!",! G EXIT
ZIS ;
 I '$D(^TMP("ADXT","FL")) D  G EXIT
 .W !,"FLWFILE.T01 not loaded into ^TMP!!! quitting..."
 S %ZIS="" D ^%ZIS I POP G EXIT
 U IO
 ;
 N ADXTRN,ADXTQUIT,ADXTLN,ADXT,ADXTST,ADXTST1,ADXTI,ADXTPP,ADXTOPP,ADXTPNAM,ADXTPP1,ADXTACC,ADXTSEQ,ADXTSUBT,ADXTPP2,%ZIS,ADXTX1,X,ADXTDOD,ADXTPAG
 S (ADXTPAG,ADXTLN,ADXTQUIT)=0 D HEADER
 ;
 S ADXTRN=0
 F  Q:+ADXTQUIT  S ADXTRN=$O(^TMP("ADXT","FL",ADXTRN)) Q:'+ADXTRN  D
 .D VARS($G(^TMP("ADXT","FL",ADXTRN)))
 .D LINE
 ;
 U IO(0) D ^%ZISC
EXIT ;
 K ADXTRN,ADXTQUIT,ADXTLN,ADXT,ADXTST,ADXTST1,ADXTI,ADXTPP,ADXTOPP,ADXTPNAM,ADXTPP1,ADXTACC,ADXTSEQ,ADXTSUBT,ADXTPP2,%ZIS,ADXTX1,X,ADXTDOD,ADXTPAG
 Q
VARS(ADXTX1) ;
 ; input (ADXTX1) = FLWFILE.T01 record
 ; output: ADXTPP,ADXTOPP,ADXT(),ADXTSUBT
 ;
 D ^ADXTAFL1 ; get vars
 ;
 ; quit if not NEVER DISEASE FREE
 Q:ADXT("FTYPRC")'=4
 ;
 ; ONCO patient number
 S ADXTPP=+$$GTPP^ADXTUT(ADXT("PID"))
 ; primary #
 S ADXTOPP=+$$GTOPP^ADXTUT(ADXT("PID"),ADXT("DTOP"),ADXT("DSQ"))
 ; accession #, seq #
 S (ADXTACC,ADXTSEQ)="" I +ADXTOPP D
 .S ADXTACC=$P($G(^ONCO(165.5,ADXTOPP,0)),"^",5)
 .S ADXTSEQ=$P($G(^ONCO(165.5,ADXTOPP,0)),"^",6)
 ; patient name
 S ADXTPNAM="" I +ADXTPP D
 .S ADXTPP1=$P($G(^ONCO(160,ADXTPP,0)),"^")
 .S ADXTPP2="^"_$P(ADXTPP1,";",2)_$P(ADXTPP1,";")_",0)"
 .S ADXTPNAM=$E($P(@ADXTPP2,"^"),1,19)
 ;
 ; earliest treatment date
 S (ADXTST,ADXTST1)=0,ADXTSUBT="00/00/00"
 F ADXTI="FSRD","FRDD","FCHD","FHMD","FBRD","FOTD" D
 .S X=+$$DTCVT^ADXTUT(ADXT(ADXTI)) I +X S ADXTST=1 D
 ..I (X<ADXTST1)!(ADXTST1=0) S ADXTST1=X
 I +ADXTST D
 .S ADXTSUBT=$E(ADXTST1,2,3)_"/"_$E(ADXTST1,4,5)_"/"_$E(ADXTST1,6,7)
 ;
 ;date of death
 K DIC,DIQ,DR,DA S ADXTDOD=""
 K ^UTILITY("DIQ1",$J) S DIC="^ONCO(160,",DR=29,DA=ADXTPP,DIQ(0)="I"
 D EN^DIQ1 S ADXTDOD=$G(^UTILITY("DIQ1",$J,160,ADXTPP,29,"I"))
 S:+ADXTDOD ADXTDOD=$E(ADXTDOD,2,3)_"/"_$E(ADXTDOD,4,5)_"/"_$E(ADXTDOD,6,7)
 K ^UTILITY("DIQ1",$J)
 ;
 K ADXTST,ADXTST1,ADXTI
 Q
CONT ;
 Q:$E(IOST)'="C"
 W !!,"Press Return to continue, or ^ to quit..."
 R X:DTIME I X["^" S ADXTQUIT=1
 Q
HEADER ;
 W @IOF
 S ADXTPAG=ADXTPAG+1
 W $J("Never Disease Free Recurrences Report (from MRS follow-ups)",70)
 W $J("Page "_ADXTPAG,27),!!
 W "    VA                        VA     VA  VA       MRS       MRS        VA       MRS  MRS       MRS",!
 W "   Pat                     Tumor Access Seq  Followup  Earliest   Date of    Recurr Rec. Dist.Site",!
 W "   Ptr     VA Patient Name   Ptr      #   #      Date Subs.Trt.     Death      Date Type  1  2  3",!
 W " ----- ------------------- ----- ------ --- --------- --------- --------- --------- ---- -- -- --",!
 S ADXTLN=7
 Q
LINE ;
 ; quit if not NEVER DISEASE FREE
 Q:ADXT("FTYPRC")'=4
 ;
 S ADXTLN=ADXTLN+1
 I ADXTLN>(IOSL-4) D CONT Q:+ADXTQUIT  D HEADER
 ;
 W !
 W $J(ADXTPP,6)
 W $J(ADXTPNAM,20)
 W $J(ADXTOPP,6)
 W $J(ADXTACC,7)
 W $J(ADXTSEQ,4)
 W $J(ADXT("FDT"),10)
 W $J(ADXTSUBT,10)
 W $J(ADXTDOD,10)
 W $J(ADXT("FFRC"),10)
 W $J(ADXT("FTYPRC"),5)
 W $J(ADXT("FST1"),3)
 W $J(ADXT("FST2"),3)
 W $J(ADXT("FST3"),3)
 Q
