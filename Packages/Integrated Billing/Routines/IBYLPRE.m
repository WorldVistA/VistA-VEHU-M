IBYLPRE ;WAS/RFJ - pre init for patch ib*2*58 ; 15 Mar 96
 ;;Version 2.0 ; INTEGRATED BILLING ;**58**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 I '$G(DUZ)!($G(DUZ(0))'="@") W !!,"DUZ OR DUZ(0) NOT DEFINED." Q
 ;
 ;  remove fields .04, .05, and .12 from file 356.1 and reinstall
 ;  in inits
 S DIK="^DD(356.1,",DA(1)=356.1 F DA=.04,.05,.12 D ^DIK
 Q
