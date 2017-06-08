A1CHASK ;ALB/ - INPATIENT/OUTPATIENT MEANS TEST REPORTS ; 27 DEC 88 1146
 ;;V 1.0
 S U="^",%=1 I ($D(^UTILITY("A1CH","O"))>0)&($D(^UTILITY("A1CH","I"))>0) D RVW Q:%=2
 K ^UTILITY("A1CH")
 K:($D(^UTILITY("A1CH",1))=0)&($D(^(2))=0) ^UTILITY("A1CH") Q:$D(^UTILITY("A1CH"))>0
 S ^UTILITY("A1CH")="",(^("O"),^("I"))="" D LO^DGUTL,ASK Q:DGQ=1  D @X
 K %,%1,%2,%3,%4,%DT(0),DGGE,DGNET,DGQ,DGTOUT,H1,H2,U,X,Z,ZRT,ZQ
 Q
RD S X="" R X:DTIME I X[U!('$T) S DGQ=1 Q
 S X=$E(X) Q
ASK S DGQ="" W !!,"Do you wish (I)npatient,(O)utpatient,or (B)oth reports: BOTH// " S Z=U_"INPATIENT^OUTPATIENT^BOTH" D RD I X="" S X="B" W X
 D IN^DGHELP S X=$S(X="B":"A1CHOP1,^A1CHIP1",X="O":"A1CHOP1",X="I":"A1CHIP1",X[U:U,1:0) W:X=0 !,"Enter I,O,B, or ^ to QUIT" G:X=0 ASK Q:X=U  S X=U_X
 Q
 ;
RVW ;if data exists, review possible - must purge prior to generation
 I (^UTILITY("A1CH","O")=0)!(^("I")=0) S %=2 W !,"If you continue the current report will be lost",!,"OK TO CONTINUE (Y/N): " D YN^DICN I %=1 K ^UTILITY("A1CH") Q
 Q
