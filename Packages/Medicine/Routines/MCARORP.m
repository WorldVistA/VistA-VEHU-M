MCARORP ; GENERATED FROM 'MCRHPHYS1' PRINT TEMPLATE (#2076) ; 07/22/97 ; (FILE 701, MARGIN=80)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(2076,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "Physical Examination"
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "General:"
 D N:$X>39 Q:'DN  W ?39 W "LYMPH NODE ENLARGEMENT:"
 S X=$G(^MCAR(701,D0,2)) D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,16) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "UVEITIS/IRITIS:"
 S X=$G(^MCAR(701,D0,1)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,5) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "MUSCLE TENDERNESS:"
 S X=$G(^MCAR(701,D0,2)) D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,17) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "CONJUNCTIVITIS/EPISCLERITIS:"
 S X=$G(^MCAR(701,D0,1)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,6) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "MUSCLE WEAKNESS-DISTAL:"
 S X=$G(^MCAR(701,D0,2)) D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,18) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "CATARACT:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,7) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "MUSCLE WEAKNESS-PROXIMAL:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,21) W:Y]"" $S($D(DXS(7,Y)):DXS(7,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "ORAL ULCERS:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,9) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "MUSCLE ATROPHY"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,22) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "RALES:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,10) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "PSYCHOSIS:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,23) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "PLEURAL RUB/"
 D N:$X>0 Q:'DN  W ?0 W "CLINICAL PLEURISY:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,11) W:Y]"" $S($D(DXS(12,Y)):DXS(12,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "ORGANIC BRAIN SYNDROME:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,24) W:Y]"" $S($D(DXS(13,Y)):DXS(13,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "PLEURAL EFFUSION:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,12) W:Y]"" $S($D(DXS(14,Y)):DXS(14,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "MOTOR NEUROPATHY:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,25) W:Y]"" $S($D(DXS(15,Y)):DXS(15,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "PERICARDIAL RUB/PERICARDITIS:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,13) W:Y]"" $S($D(DXS(16,Y)):DXS(16,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "SENSORY NEUROPATHY:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,26) W:Y]"" $S($D(DXS(17,Y)):DXS(17,Y),1:Y)
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "Skin:"
 D N:$X>39 Q:'DN  W ?39 W "CUTANEOUS VASCULTITIS:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,38) W:Y]"" $S($D(DXS(18,Y)):DXS(18,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "RASH-MALAR:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,28) W:Y]"" $S($D(DXS(19,Y)):DXS(19,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "PALPABLE PUPURA:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,32) W:Y]"" $S($D(DXS(20,Y)):DXS(20,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "RASH-DISCOID:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,30) W:Y]"" $S($D(DXS(21,Y)):DXS(21,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "SKIN ULCERS:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,44) W:Y]"" $S($D(DXS(22,Y)):DXS(22,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "RASH-JRA:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,31) W:Y]"" $S($D(DXS(23,Y)):DXS(23,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "ERYTHEMA NODOSUM:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,45) W:Y]"" $S($D(DXS(24,Y)):DXS(24,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "RASH-SLE,NON-MALAR:"
 S X=$G(^MCAR(701,D0,1)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,7) W:Y]"" $S($D(DXS(25,Y)):DXS(25,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "PERIUNGAL ERYTHEMA:"
 S X=$G(^MCAR(701,D0,2)) D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,39) W:Y]"" $S($D(DXS(26,Y)):DXS(26,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "RASH-OTHER:"
 G ^MCARORP1
