RTIPOST2 ;ISC-ALBANY/PKE-postinit ; 6/26/90 10:00AM
 ;;v 2.0;Record Tracking;;10/22/91 
EN ;
 S RTNP="VA(200,"
 W !!?5,"Changing Borrowers/file entries to New Person pointers",!!
 F Z=0:0 S Z=$O(^RTV(195.9,Z)) Q:'Z  W:Z#500=0 "." I $D(^(Z,0)),$P(^(0),"^",1)["DIC(16" S RTBOR=^(0),RTAPL=+$P(RTBOR,"^",3),RTB=$P(RTBOR,"^") D FIX
 ;
 K RTNB,RTNP,RTBOR,RTB,RTAPL,PN,UN,NPN,Z,A3,RTP
 W !!?5,"..all done ...",!
 Q
 ;
FIX W Z,"  "
 S RTP=+$P(RTB,";",1)
 I $D(^DIC(16,RTP,0)) S PN=$P(^(0),"^",1)
 E  W !,"Borrower IFN = ",Z,"  not found in ^DIC(16,"_RTP,! Q
 I $D(^DIC(16,RTP,"A3")) S A3=+^("A3")
 E  W !,"Borrower IFN = ",Z,"  not found in ^DIC(16,"_RTP_",A3)",! Q
 ;
 I $D(^DIC(3,A3,0)) S UN=$P(^(0),"^",1)
 E  W !,"Borrower IFN = ",Z,"  not found in ^DIC(3,"_A3,! Q
 I $D(^VA(200,A3,0)) S NPN=$P(^(0),"^",1) ;W ?35,^(0),!
 E  W !,"Borrower IFN = ",Z,"  not found in ^VA(200,"_A3,! Q
 I UN=PN
 E  W !,"User name '",UN,"' doesn't match Person Name '",PN,"'"
 E  W " for Borrower IFN =",Z Q
 I UN=NPN
 E  W !,"User name '",UN,"' doesn't match New Person Name '",NPN,"'"
 E  W " for Borrower IFN =",Z Q
 ;
 S RTNB=A3_";"_RTNP
 ;W RTAPL,"   ",RTB," ==> ",RTNB,!
 ;
 L +^RTV(195.9,Z)
 S $P(^RTV(195.9,Z,0),"^",1)=RTNB
 S ^RTV(195.9,"B",RTNB,Z)=""
 S ^RTV(195.9,"ABOR",RTNB,RTAPL,Z)=""
 ;W ! ZW RTV
 ;
 K ^RTV(195.9,"B",RTB,Z)
 K ^RTV(195.9,"ABOR",RTB,RTAPL,Z)
 L -^RTV(195.9,Z)
 Q
