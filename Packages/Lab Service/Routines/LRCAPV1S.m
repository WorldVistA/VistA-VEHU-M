LRCAPV1S ;SLC/FHS-SET WKLD CODE INTO LRO(68 PART 2 ; 12/3/1997
 ;;5.2;LAB SERVICE;**42,153,201,221,434**;Sep 27, 1994;Build 2
SET ; From LRCAPV1
 Q:'$D(^LRO(68,+LRAA,1,LRAD,1,LRAN,0))#2
 I '$D(LRTIME) S LRTIME=$$NOW^XLFDT
 I '$P(LRTIME,".",2) S LRTIME=$$NOW^XLFDT
 I '$D(^LRO(68,+LRAA,1,LRAD,1,LRAN,4,LRT,0))#2 D
 .  S LRURGW=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,+$G(LRT("P")),0)),U,2)  ; urgency from parent test
 .  I LRURGW'>0,$G(LRALERT) S LRURGW=LRALERT
 .  S ^LRO(68,+LRAA,1,LRAD,1,LRAN,4,LRT,0)=LRT_U_(50+$G(LRURGW))_U_U_DUZ_U_LRTIME_"^^^"_LRCDEF_U_$P($G(LRT("P")),U)
 .  S $P(^LRO(68,+LRAA,1,LRAD,1,LRAN,4,0),U,3)=LRT,$P(^(0),U,4)=1+$P(^(0),U,4),^LRO(68,+LRAA,1,LRAD,1,LRAN,4,"B",LRT,LRT)=""
 S:'$P(^LRO(68,+LRAA,1,LRAD,1,LRAN,4,LRT,0),U,8) $P(^(0),U,8)=$G(LRCDEF)
 S:'$D(^LRO(68,+LRAA,1,LRAD,1,LRAN,4,LRT,1,0))#2 ^(0)="^68.14P^" S NODE0=^(0),NODE=LRP_U_"^^^^"_LRTIME_U_DUZ_U_DUZ(2)_U_$S($G(LRCAPMS):LRCAPMS,1:+LRAA)_U
 I '$D(^LRO(68,+LRAA,1,LRAD,1,LRAN,4,LRT,1,LRP,0)) S $P(NODE0,U,3)=LRP,$P(NODE0,U,4)=1+$P(NODE0,U,4),^LRO(68,+LRAA,1,LRAD,1,LRAN,4,LRT,1,0)=NODE0,^(LRP,0)=NODE
 S X=^LRO(68,+LRAA,1,LRAD,1,LRAN,4,LRT,1,LRP,0) I '$D(LRADD),$P(X,U,2) Q
 I $D(LRADD) S:'$P(X,U,3) $P(X,U,2)=LRCNT+$P(X,U,2) S:$P(X,U,3) $P(X,U,2)=LRCNT,$P(X,U,3)=0 S ^LRO(68,+LRAA,1,LRAD,1,LRAN,4,LRT,1,LRP,0)=X
 I '$D(LRADD),'$P(X,U,3) S $P(X,U,2)=LRCNT,^LRO(68,+LRAA,1,LRAD,1,LRAN,4,LRT,1,LRP,0)=X
 I $G(LRCSQ),$G(LRCSQQ) D
 . S ^XTMP("LRCAP",LRCSQ,DUZ,0)=$$HTFM^XLFDT($H+30,1)_U_DT_U_"Lab Control workload count"_U_$G(DUZ)
 . S ^XTMP("LRCAP",LRCSQ,DUZ,LRP)=""
 Q
