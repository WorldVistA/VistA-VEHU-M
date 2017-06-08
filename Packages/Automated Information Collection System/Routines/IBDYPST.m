IBDYPST ;ALB/CJM/AAS - ENCOUNTER FORM - ADD NEW PKG INTERFACE;12-AUG-94
 ;;Version 2.0L15 ; INTEGRATED BILLING ;**30**; 21-MAR-94
 ;
 ;; New routine in support of DATA CAPTURE project
 ;
 D SEND,ID
 Q
 ;
SEND ; -- send message to developers
 S X="IBDYINIY" X ^%ZOSF("TEST") I $T D ^IBDYINIY
 Q
 ;
ID K ^DD(357.951,0,"ID")
 S ^DD(357.951,0,"ID","WRITE")="W ""  COL = "",$P($G(^(0)),U,2),""   DISPLAY = "",$P($G(^(0)),U,8)"
 Q
 ;
ADD ; -- add NEW package interface
 N NAME,DIC,DIK,DA,X,Y,IBIFN
 S NAME="DG SELECT VISIT TYPE CPT PROCEDURES"
 Q:$O(^IBE(357.6,"B",$E(NAME,1,30),0))
 W !!,"<<< Adding New Package Interface Entry ",NAME,"."
 ;
 K DO,DD
 S DIC="^IBE(357.6,",DIC(0)="L",DLAYGO=357.6
 S X=NAME D FILE^DICN Q:+Y<1
 S IBIFN=+Y
 ;
 S ^IBE(357.6,IBIFN,0)="DG SELECT VISIT TYPE CPT PROCEDURES^VSIT^IBDFN4^MAS^^3^2^^1^^^1"
 S ^IBE(357.6,IBIFN,1,0)="^^1^1^2941017^^"
 S ^IBE(357.6,IBIFN,1,1,0)="Allows for select of just Visit type CPT codes from the CPT file."
 S ^IBE(357.6,IBIFN,2)="CODE^5^RECOMMENDED TEXT-SHORT NAME^60^RECOMMENDED HEADER^25^^^^^^^^^^^1^1"
 S ^IBE(357.6,60,3)="SELECT TYPE OF VISIT CPT"
 S DIK="^IBE(357.6,",DA=IBIFN D IX1^DIK
 Q
