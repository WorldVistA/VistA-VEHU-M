DGPM5VR ;ALB/LDB - CHECK VERSIONS OF INTEGRATED PACKAGES ; 12 APR 91 @9am
 ;;MAS VERSION 4.7;;**25**;
 ;Ensure correct versions of software are running
EN K V F L=1:1 S DGFIL=$T(FILE+L) Q:$T(FILE+L)=""  F K=3:1:5 S L(K)=$P(DGFIL,";",K) D:K=5 VER
 I $D(V) D MSG K DIFQ
 I '$D(V) W !,"All integrated packages have been sufficiently updated.",!
 K DGFIL,K,L,L5,V Q
VER ;
 ;L(3)=node for version check, L(4)=version # or condition checked
 ;L(5)=package name
 Q:'$D(@L(3))&(L>4)
 Q:$D(@L(3))&(L=4)
 I L=4 X L(4) Q:$T
 I $D(@L(3)),L(4)]"",'L(4) X L(4) Q:$T
 I $D(@L(3)),$S(L(4)="":1,'L(4):0,L(4)&(@L(3)'<+L(4)):1,1:0) Q
 I L(4)="",'$D(@L(3)) S L(4)=1.96
 S:L=4 L(4)=4.18
 I L(4)]"",'L(4),$D(@L(3)) S L(4)=$S(L=5:1.06,L=6:4.33,1:2.2)
 S V(L(5))=L(4) Q
MSG ;
 W !,"********************************************************************"
 W !,"********************************************************************"
 W !!," A search of your system has indicated that not all integrated",!," packages have been updated sufficiently."
 W !," The minimum versions of the following packages need to be installed",!," before the installation of MAS v5 can be accomplished."
 W !!," PACKAGE",?30,"MINIMUM VERSION"
 W !," -------",?30,"----------------"
 S L5="" F V=0:0 S L5=$O(V(L5)) Q:L5=""  W !," ",L5,?36,$J(V(L5),4)
 W !!," In order for the installation of MAS version 5 to occur,"
 W !," you MUST INSTALL the minimum versions of the packages listed."
 W !!,"********************************************************************"
 W !,"********************************************************************"
 Q
 ;
FILE ;list of versions necessary for MAS v5
 ;;^DD(3,0,"VR");6.5;KERNEL
 ;;^DD("VERSION");18;FILEMAN
 ;;^ORD(100.99);;ORDER ENTRY
 ;;^YSA(602,1,0);I '$D(^YT)&'$D(^YTP)&'$D(^YI);MENTAL HEALTH
 ;;^DD(513.72);I $D(^QA(740));UTILIZATION REVIEW
 ;;^FH;I $D(^FHEN);DIETETICS
 ;;^DG(43,1,"VERSION");4.7;MAS
 ;;^NURSF(213.8,"B");I $O(^NURSF(213.8,"B",0))=2.2;NURSING
 ;;^LAB("VERSION");5.0;LAB
 ;;^RA("VERSION");3.01;RADIOLOGY
 ;;^SOWK(650.1,1,"VER");2.14;SOCIAL WORK
