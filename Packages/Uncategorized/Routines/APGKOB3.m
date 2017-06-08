APGKOB3 ;PHOENIX/KLD; 3/15/99; OBJECTS (MICROBIOLOGY); 3/19/99  3:10 PM;; 10/1/99  8:52 AM
ST Q
 ;
MIC(TN) ;Micro tests in a time period - TN=Test name, N=# of results
 ;T=time period (time=nM, nD, or nY)
 N AREA,C,ED,N,SP,T,TEST S C=0,$P(SP," ",50)=""
 S N=$P(TN,U,2),T=$P(TN,U,3),TEST=$O(^LAB(60,"B",$P(TN,U),0))
 I 'TEST D  G ONEQ
 .D K S ^TMP("APGKOB3",$J,1,0)=$P(TN,U)_" - INVALID TEST NAME"
 ;S AREA=$O(^LRO(68,"B","MICROBIOLOGY",0)) ;Get proper accession area
 ;I 'AREA D  G ONEQ
 .D K S ^TMP("APGKOB3",$J,1,0)=$P(TN,U)_" - INVALID ACCESSION AREA"
 D GET
ONEQ Q "~@^TMP(""APGKOB3"","_$J_")"
 ;
GET ;Get data from ^LR(DFN,"MI")
 N ACC,FLAG,GL,I,II,J,N,LRAA,LRAD,LRAN,LRDFN,X D K,NONE,AGO
 F I=3:1 S LRAA=$P($T(LRAA+1),";",I) Q:LRAA=""  S LRAA(LRAA)=""
 S N=1,FLAG=0,LRDFN=$G(^DPT(DFN,"LR")) Q:'LRDFN
 F I=0:0 S I=$o(^LR(LRDFN,"MI",I)) Q:'I!(I>ED)!(N>$P(TN,U,2))  D
 .F II=0,1 S X(II)=$G(^LR(LRDFN,"MI",I,II))
 .S ACC=$P(X(0),U,6),LRAA=$P(ACC," ") Q:LRAA=""
 .S LRAA=$O(^LRO(68,"B",LRAA,0))
 .Q:LRAA'?2N  Q:'$D(LRAA(LRAA))  ;Micro accession areas
 .S LRAD=$P(ACC," ",2),LRAN=$P(ACC," ",3) Q:'LRAA!('LRAD)!('LRAN)
 .S:LRAD?1.2N LRAD=$E($E(DT)_LRAD_"000000",1,7)
 .Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,TEST))  ;Desired test in accession
 .S X=$E("Coll. date: "_$$D($P(X(0),U))_SP,1,40)
 .S X=X_"Coll. Sample: "_$P(^LAB(62,$P(X(0),U,11),0),U) D SET
 .S X=$E("Site/specimen: "_$P(^LAB(61,$P(X(0),U,5),0),U)_SP,1,40)
 .S X=X_"Completed: "_$$D($P(X(1),U)) D SET
 .S X="" S:'$o(^LR(LRDFN,"MI",I,2,0)) X="NONE LISTED"
 .S X="Gram Stain: "_X D SET
 .F II=0:0 S II=$o(^LR(LRDFN,"MI",I,2,II)) Q:'II  S X="  "_^(II,0) D SET
 .I '$o(^LR(LRDFN,"MI",I,3,0)) S X="Organism: NONE LISTED" D SET
 .F II=0:0 S II=$o(^LR(LRDFN,"MI",I,3,II)) Q:'II  S X=^(II,0) D
 ..S X="Organism: "_$P(^LAB(61.2,+X,0),U)_"  ("_$P(X,U,2)_")" D SET
 ..I $P($G(^LR(LRDFN,"MI",I,3,II,1,0)),U,3) S X="Comments:" D SET D
 ...F J=0:0 S J=$o(^LR(LRDFN,"MI",I,3,II,1,J)) Q:'J  D
 ....S X="  "_^(J,0) D SET
 ..S X="Susceptibilities: "
 ..I '$O(^LR(LRDFN,"MI",I,3,II,2)) S X=X_"NONE FOUND" D SET Q
 ..S X=$E(X_SP,1,30)_"SUSC  INTP" D SET
 ..F J=2:0 S J=$o(^LR(LRDFN,"MI",I,3,II,J)) Q:'J  S X=$G(^(J)) D
 ...Q:X=""  S GL=$O(^DD(63.3,"GL",J,1,0)) Q:'GL
 ...S X=$E("  "_$P(^DD(63.3,GL,0),U)_SP,1,30)_"  "_$P(X,U)_"     "_$P(X,U,2) D SET
 .S X="" S:'$o(^LR(LRDFN,"MI",I,4,0)) X="NONE LISTED"
 .S X="Bact Report Remarks: "_X D SET
 .F II=0:0 S II=$o(^LR(LRDFN,"MI",I,4,II)) Q:'II  S X="  "_^(II,0) D SET
 .S X="" S:'$o(^LR(LRDFN,"MI",I,10,0)) X="NONE LISTED"
 .S X="Mycology Report Remarks: "_X D SET
 .F II=0:0 S II=$o(^LR(LRDFN,"MI",I,10,II)) Q:'II  S X="  "_^(II,0) D SET
 .S N=N+1,X="" D SET
 Q
SET S C=C+1,^TMP("APGKOB3",$J,C,0)=X,X="" Q
 ;
AGO S X1=DT,X2=+T,X=$P(T,X2,2),X2=-X2
 S X2=X2*$S(X="M":30,X="W":7,X="D":1,1:365) D C^%DTC S ED=9999999-X Q
 ;
K K ^TMP("APGKOB3",$J) Q
NONE S ^TMP("APGKOB3",$J,1,0)=$P(TN,U)_" - NONE FOUND" Q
D(Y) D DD^%DT Q Y
 ;
LRAA ;Place IENs of accession areas (from file 68) in following line.  The IEN's names are are on the line after that, just as a reference, and are not used by the program
 ;;12;41;42;43
 ;;MICROBIOLOGY;MYCOBACTERIOLOGY;MYCOLOGY;PARASITOLOGY
