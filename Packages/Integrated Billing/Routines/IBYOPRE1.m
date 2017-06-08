IBYOPRE1 ;ALB/TMP - IB*2*51 PRE-INSTALL ;07-DEC-99 
 ;;2.0;INTEGRATED BILLING;**51**;21-MAR-94
 ;
FIXIT ; Fix dups in file 364.7 
 N Z,Z0,Z1
 S Z=0
 F  S Z=$O(^IBA(364.7,"B",Z)) Q:'Z  S Z0=$O(^IBA(364.7,"B",Z,0)) F  S Z1=$O(^IBA(364.7,"B",Z,Z0)) Q:'Z1  I Z1<10000 D  S Z0=Z1
 . Q:$G(^IBA(364.7,Z1,0))=""
 . S DR=".03////"_$P(^IBA(364.7,Z0,0),U,3)_";1///"_$S($G(^IBA(364.7,Z0,1))'="":^(1),1:"@")
 . K ^IBA(364.7,Z1,3) M ^IBA(364.7,Z1,3)=^IBA(364.7,Z0,3)
 . S DA=Z1,DIE="^IBA(364.7," D ^DIE
 . S DIK="^IBA(364.7,",DA=Z0 D ^DIK
 ;
 ; Fix dups in file 364.6
 N Z,Z0,Z1,Z2,Z3,Z4,Z5,IBSAVE
 S Z=0
 F  S Z=$O(^IBA(364.6,"ASEQ",Z)) Q:'Z  S Z0=0 F  S Z0=$O(^IBA(364.6,"ASEQ",Z,Z0)) Q:'Z0  S Z1=0 F  S Z1=$O(^IBA(364.6,"ASEQ",Z,Z0,Z1)) Q:'Z1  S Z2=0 F  S Z2=$O(^IBA(364.6,"ASEQ",Z,Z0,Z1,Z2)) Q:'Z2  D
 . S Z3=$O(^IBA(364.6,"ASEQ",Z,Z0,Z1,Z2,0)) F  S Z4=$O(^IBA(364.6,"ASEQ",Z,Z0,Z1,Z2,Z3)) Q:'Z4  D  S Z3=Z4
 .. S Z5=0 F  S Z5=$O(^IBA(364.7,"B",Z3,Z5)) Q:'Z5  S IBSAVE(Z5)=""
 .. S DA=Z4,DIE="^IBA(364.6,",DR=".06///"_$$FLD(6)_";.07///"_$$FLD(7)_";.09///"_$$FLD(9)_";.1///"_$$FLD(10)_";.11///"_$$FLD(11)
 .. D ^DIE
 .. S DA=Z3,DIK="^IBA(364.6," D ^DIK
 . I $O(IBSAVE("")) D
 .. S Z5=0 F  S Z5=$O(IBSAVE(Z5)) Q:'Z5  S DIE="^IBA(364.7,",DA=Z5,DR=".01////"_Z3 D ^DIE
 .. K IBSAVE
 Q
 ;
FLD(FLD) ; Function returns piece of global being deleted if data,
 ;             otherwise, "@"
 N Z
 S Z=$P($G(^IBA(364.6,Z3,0)),U,FLD) S:Z="" Z="@"
 Q Z
 ;
