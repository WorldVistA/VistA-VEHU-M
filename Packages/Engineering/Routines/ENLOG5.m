ENLOG5 ;(WASH ISC)/DH-Find PM # in LOG1 Record ;10-6-91
 ;;;;
 ;CLASS 3 SOFTWARE - Not officially supported by the ISC's
 Q:'$D(^ENZ(6914.5,DA,21))
 S X=^ENZ(6914.5,DA,21) F K=0:0 S X1=$E(X) Q:X1?1N  S X=$E(X,2,20) Q:X=""
 I X[" " S X=$P(X," ",1)
 I X?4N1"-"4N0.1U S $P(^ENZ(6914.5,DA,0),U,2)=X,^ENZ(6914.5,"C",X,DA)=""
 I X?4N0.1U,$D(^ENZ(6914.5,DA,1)) S X=$E($P(^ENZ(6914.5,DA,1),U,6),1,4)_"-"_X S:X?4N1"-"4N0.1U $P(^(0),U,2)=X,^ENZ(6914.5,"C",X,DA)=""
 S X=$P(^ENZ(6914.5,DA,0),U,2) I X]"" S X1=$O(^ENG(6914,"C",X,0)) S:X1]"" $P(^ENZ(6914.5,DA,0),U,3)=X1
 Q:X]""
 S X=^ENZ(6914.5,DA,21) Q:X'["PM"
 S X=$P(X,"PM",2) F K=0:0 S X1=$E(X) Q:X1?1N  S X=$E(X,2,20) Q:X=""
 I X[" " S X=$P(X," ",1)
 I X?4N1"-"0.1U S $P(^ENZ(6914.5,DA,0),U,2)=X,^ENZ(6914.5,"C",X,DA)=""
 I X?4N0.1U,$D(^ENZ(6914.5,DA,1)) S X=$E($P(^ENZ(6914.5,DA,1),U,6),1,4)_"-"_X S:X?4N1"-"4N0.1U $P(^(0),U,2)=X,^ENZ(6914.5,"C",X,DA)=""
 S X=$P(^ENZ(6914.5,DA,0),U,2) I X]"" S X1=$O(^ENG(6914,"C",X,0)) S:X1]"" $P(^ENZ(6914.5,DA,0),U,3)=X1
 Q
 ;ENLOG5
