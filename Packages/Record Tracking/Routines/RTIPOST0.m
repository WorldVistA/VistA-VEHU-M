RTIPOST0 ;ISC-ALBANY/PKE-postinit; 6/26/90 10:00AM
 ;;v 2.0;Record Tracking;;10/22/91 
 W !!?5,"Post-initialization routine running",!
 ;
EN D START,KIL
 D ^RTIPOST1
 D ^RTIPOST2
 D ^RTIPOST4
 D ^RTIPOST3
 D SET
 ;
KIL K RTV,RTX,RTFIL,D0,DA,X,Y,DR,DIC,DIE,RTOLIN,RTO,RTOR Q
 ;
SET ;This will set the institution/station number in the parameter
 W $C(7)
 W !!,"-------------------------------------------------------------"
 W !,"Please enter your Institution in a new field 30 of file 195.4"
 W !,"-------------------------------------------------------------"
 ;getting old value for default
 S RTOLIN=$S($D(^DIC(195.4,1,"SITE")):^("SITE"),$D(^DD("SITE",1)):^(1),1:"")
 S DIE="^DIC(195.4,",DA=1,DR="30R//"_RTOLIN D ^DIE Q
 Q
 ;tag 4=vari-point 4,  s4=screen on 4,   e4=explain screen 4
 ;offset $T(+2) allows direct cut/paste of 1,2,3 fields from inits 
 ;insure that no dr gets bigger than 200 with tst
 ;find Order already present and bump for added variable pointer
 ;
 ; initits have no var pointers
 ; any missing are added in post init
 ;rtipost1 application 195.1 borrower subfile updated
 ;rtipost2 changes entries in file 195.9 from dic(16 to va200
 ;rtipost3 old post init
 ;
W1 W !!?3,"Checking variable pointers in DD of file # ",RTFIL,! Q
 ;
START ;find var pointers and add distributed pointers if not present
 W !?3,"Removing 'post-selection' action from ^DD(195.9,0,""ACT"")"
 K ^DD(195.9,0,"ACT")
 ;
 F RTFIL=190,195.9 F RTV=0:0 S RTV=$O(^DD(RTFIL,.01,"V",RTV)) Q:'RTV  I $D(^(RTV,0)) S RTX=+^(0) S RTV(RTFIL,RTX)=""
 ;
 S RTFIL=190,RTX=2 D W1 I '$D(RTV(RTFIL,RTX)) D LKUP
 ;order of rtx sets order
 S RTFIL=195.9 D W1 F RTX=200,42,44,4 I '$D(RTV(RTFIL,RTX)) D LKUP
 ;
DIK ;remove person variable pointer
 S DIK="^DD(195.9,.01,""V"","
 S DA=$O(^DD(195.9,.01,"V","B",16,0)) Q:'DA
 W !?5,"Removing 'Person/Provider' variable pointer '16'"
 S DA(1)=.01,DA(2)=195.9 D ^DIK K DIK,DA Q
 Q
 ;
LKUP ;
 S (DIE,DIC)="^DD("_RTFIL_",.01,""V"",",DIC(0)="L",X=RTX
 S X=RTX,DA(1)=.01,DA(2)=RTFIL
ADD ;get unique order
 S RTOR=0
 F RTO=0:0 S RTO=$O(^DD(RTFIL,.01,"V","O",RTO)) Q:'RTO  S RTOR=RTO
 S RTOR=RTOR+1
 D ^DIC K DIC
 I +Y<0 W !,?10,"Failed to add variable pointer '",RTX,"' in file #",RTFIL Q
 E  W !,?5,"Added variable pointer '",RTX,"'"
 S DA=+Y
 ;
 D @RTX D ^DIE K DQ,DE,DR S RTX="S"_RTX D @RTX I $D(DR) D ^DIE K DQ,DE,DR S RTX="E"_$E(RTX,2,99) D @RTX I $D(DR) D ^DIE
 K DA,DQ,DE,DR Q
 Q
 ;
2 ; file^name^order^prefix^screen^laygo
 ;;=2^PATIENT^1^P^n^n
 S DR=".02////PATIENT;.03////"_RTOR_";.04////P;.05////n;.06////n;"
 Q
S2 ;
 Q
E2 ;
 Q
44 ; file^name^order^prefix^sreen^laygo
 ;;=44^LOCATION^3^L^y^n
 S DR=".02////LOCATION;.03////"_RTOR_";.04////L;.05////y;.06////n;"
 Q
S44 ;
 ;;^DD(195.9,.01,"V",1,1)
 ;;=S DIC("S")="I ""W""'[$P(^(0),U,3),$S('$D(^(""I"")):1,'^(""I""):1,DT<+^(""I""):1,'$P(^(""I""),U,2):0,1:DT>+$P(^(""I""),U,2))"
 S DR="1////"_$P($T(S44+2),";;=",2)_";"
 Q
E44 ;
 ;;^DD(195.9,.01,"V",1,2)
 ;;=Allows only active hospital locations (excluding wards and file areas).
 S DR="2////"_$P($T(E44+2),";;=",2)_";"
 Q
42 ;file^name^order^prefix^sreen^laygo
 ;;^DD(195.9,.01,"V",3,0)
 ;;=42^WARD^4^W^y^n
 S DR=".02////WARD;.03////"_RTOR_";.04////W;.05////y;.06////n;"
 Q
S42 ;
 ;;^DD(195.9,.01,"V",3,1)
 ;;=S DIC("S")="I $S('$D(^(""I"")):1,$P(^(""I""),U)'=""I"":1,1:0)"
 S DR="1////"_$P($T(S42+2),";;=",2)_";"
 Q
E42 ;
 ;;^DD(195.9,.01,"V",3,2)
 ;;=Allows only active wards.
 S DR="2////"_$P($T(E42+2),";;=",2)_";"
 Q
16 ;file^name^order^prefix^sreen^laygo
 ;;^DD(195.9,.01,"V",5,0)
 ;;=16^PROVIDER/PERSON^1^P^y^n
 S DR=".02////PROVIDER/PERSON;.03////"_RTOR_";.04////P;.05////y;.06////n;"
 Q
S16 ;
 ;;^DD(195.9,.01,"V",5,1)
 ;;=S DIC("S")="I $S('$D(^DIC(6,Y,0)):1,'$D(^(""I"")):1,'^(""I""):1,1:DT'>^(""I""))"
 S DR="1////"_$P($T(S16+2),";;=",2)_";"
 Q
E16 ;
 ;;^DD(195.9,.01,"V",5,2)
 ;;=Allows persons and active providers.
 S DR="2////"_$P($T(E16+2),";;=",2)_";"
 Q
200 ;file^name^order^prefix^sreen^laygo
 ;;^DD(195.9,.01,"V",5,0)
 ;;=200^PROVIDER/NPERSON^1^P^y^n
 S DR=".02////PROVIDER PERSON;.03////"_RTOR_";.04////P;.05////y;.06////n;"
 Q
S200 ;
 ;;^DD(195.9,.01,"V",5,1)
 ;;=S DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,1:DT'>^(""I""))"
 S DR="1////"_$P($T(S200+2),";;=",2)_";"
 Q
E200 ;
 ;;^DD(195.9,.01,"V",5,2)
 ;;=Allows persons and active providers.
 S DR="2////"_$P($T(E200+2),";;=",2)_";"
 Q
 ;
4 ; file^name^order^prefix^sreen^laygo
 ;;^DD(195.9,.01,"V",6,0)
 ;;=4^INSTITUTION^2^I^^n
 S DR=".02////INSTITUTION;.03////"_RTOR_";.04////I;.05////y;.06////n;"
 Q
 ;screen  ... 
S4 ;
 Q
E4 ;
 Q
X44 ;S X=44,DA=44,DA(1)=.01,DA(2)=195.9
 ;S (DIC,DIE)="^DD(195.9,.01,""V"",",DIC(0)="L" D ^DIC K DIC Q:Y<0
 ;S DA=+Y D 44,^DIE Q
 ;
X4 ;S X=4,DA=4,DA(1)=.01,DA(2)=195.9
 ;S (DIC,DIE)="^DD(195.9,.01,""V"",",DIC(0)="L" D ^DIC K DIC Q:Y<0
 ;S DA=+Y D 4,^DIE Q
 ;
TST S RTOR=5
 D 200,W,S200,W,E200,W,44,W,S44,W,E44,W,42,W,S42,W,E42,W,16,W,S16,W,E16,W,4,W,S4,W,E4,W Q
W I $D(DR) W !,$L(DR) W:$L(DR)>240 *7 W !," DR=",DR,!! H 2 K DR Q
 Q
