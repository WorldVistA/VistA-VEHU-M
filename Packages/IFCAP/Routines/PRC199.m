PRC199 ; FIX & CLEAN UP FILES AND ROUTINES FOR PATCH 199;CC
V ;;5.0;IFCAP;**199**;4/21/95
 ;
 ; This routine is comprised of two subroutines.  Each subroutine
 ; addresses a different NOIS
 ;
 S U="^"
 D ISB ; delete field .001 from file 420.01 for ISB-1298-31738
 D ISL ; delete field .9   from file 421.2  for ISL-0394-50016
 Q
 ;
ISB L +^DD(420.01):2 I $T=0 D
 . W !,"Trying to lock ^DD(420.01)"
 . F I=0:0 L +^DD(421.2):5 Q:$T'=0  W "."
 S DIK="^DD(420.01,",DA=.001,DA(1)=420.01
 D ^DIK
 L -^DD(420.01)
 Q
 ;
ISL ; This routine deletes field .9 after cleaning up the value in
 ; node 0 piece 14.  Field .1 replaced .9 and uses the code 'CLM'
 ; instead of 'CALM'
 ;
 N A,B,DA,DIK,I
 S A=0
ISLA S A=$O(^PRCF(421.2,A)) G ISLB:A'>0
 S B=$G(^PRCF(421.2,A,0)) I $P(B,"^",14)="CALM" D
 . L +^PRCF(421.2,A):2 I $T=0 D
 . . W !,"Trying to lock ^PRCF(421.2,"_A_")"
 . . F I=0:0 L +^PRCF(421.2,A):5 Q:$T'=0  W "."
 . S $P(^PRCF(421.2,A,0),"^",14)="CLM"
 . L -^PRCF(421.2,A)
 G ISLA
 ;
ISLB L +^DD(421.2):2 I $T=0 D
 . W !,"Trying to lock ^DD(421.2)"
 . F I=0:0 L +^DD(421.2):5 Q:$T'=0  W "."
 S DIK="^DD(421.2,",DA=.9,DA(1)=421.2
 D ^DIK
 L -^DD(421.2)
 Q
