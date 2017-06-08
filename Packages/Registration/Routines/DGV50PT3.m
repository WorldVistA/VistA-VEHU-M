DGV50PT3 ;ALB/RMO,JLU - DG POST-INIT FOR VERSION 5.0 CONT. (INTEGRATION MISC) ; 20 DEC 90 12:05 pm
 ;;MAS VERSION 5.0;
 ;
 D RT:$D(^RT)&($D(^RTV)) W !!
 D LAB
 Q
 ;
RT ;Update Record Tracking for Ward Location Inactivation Check
 W !!,">>> Updating Record Tracking Variable Pointer in BORROWER File (#195.9)..."
A F X=0:0 S X=$O(^DD(195.9,.01,"V",X)) Q:'X  I +^(X,0)=42 S DA=X Q
A1 I '$D(DA) W !!,*7,"NO WARD LOCATION variable pointer in borrowers file.",!,"No changes made." Q
 S DIE="^DD(195.9,.01,""V"",",DA(1)=.01,DA(2)=195.9
 S DR="1////S DIC(""S"")=""N X,D0 S D0=+Y D WIN^DGPMDDCF I 'X"""
 D ^DIE K DIE,DIC,DA,DR,X Q
 ;
LAB ; -- zsave lab routines for lab version 5.1
 I $S('$D(^LAB("VERSION")):1,1:^("VERSION")<5.1) G LABQ
 W !!,">>> Loading Lab v5.1 routines..."
 F DGYPI=1:1 S DGYPX=$P($T(ROU+DGYPI),";;",2) Q:DGYPX="$END"  S X=$P(DGYPX,"^") D ZL I DGYPY S X=$P(DGYPX,"^",2) D ZS S X=$P(DGYPX,"^") X ^%ZOSF("DEL")
 W !,">>> Done."
LABQ K DGYPY,DGYPI,DGYPX Q
 ;
ZL ; -- load routine into util
 K ^UTILITY($J,"ROU")
 S DGYPY=1 X ^%ZOSF("TEST") I '$T S DGYPY=0 W !,*7,"Routine '",X,"' not found." G ZLQ
 S DIF="^UTILITY($J,""ROU"",",XCNP=0 X ^%ZOSF("LOAD")
ZLQ K DIF,XCNP Q
 ;
ZS ; -- save routine from util
 S DIE="^UTILITY($J,""ROU"",",XCN=0 X ^%ZOSF("SAVE")
 W !,"Routine '",X,"'",?20,"filed."
 K ^UTILITY($J,"ROU"),DIE,XCN Q
 ;
ROU ; -- routines to load
 ;;lracsum^LRACSUM
 ;;lrapqat1^LRAPQAT1
 ;;lrapt^LRAPT
 ;;lraurv^LRAURV
 ;;lrbljpp1^LRBLJPP1
 ;;lrblpc1^LRBLPC1
 ;;lrdpa1^LRDPA1
 ;;lrmipsz1^LRMIPSZ1
 ;;lrmisez1^LRMISEZ1
 ;;lrmitrz1^LRMITRZ1
 ;;lror4^LROR4
 ;;lrua^LRUA
 ;;$END
 ;
