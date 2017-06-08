ADXTPCO8 ;523/KC cloned beta 1 ONCOTN routine ;29-DEC-1992
 ;;1.0;;
ONCOTN ;WASH ISC/SRR-STANDARD TN CODES, NOHELP ;10/25/92  19:35
 ;;2.0;ONCO;**1**;SEPT 25,1992
 ;
CK ;CHECK AJCC TNM-Eliminate Lymphomas => Stage #38
 S Y=37.1,S=$P(^ONCO(165.5,D0,0),U),ONCOT=$P($G(^(2)),U) D YR:'$D(ONCOYR)
 I S=54 S Y=69 Q
 I S=62!(S=63)!(S=40) W !!?5,"No TNM coding!",! S Y=38 Q
 I S=35!(S>65&(S<71)) W !!?5,"SYSTEMIC Disease - No AJCC coding",! S Y=39 Q
 I $E(ONCOT,1,4)=6769 S L=$E(ONCOT,5) I L=0!(L=5)!(L=6) S Y="@4" Q
 I ONCOT="" W !!?5,"Topography not Defined!!",! S Y=20 Q
 G NO4:$P(^ONCO(164,ONCOT,0),U,11)="" I 'ONCOYR G NO3:ONCOT>67169&(ONCOT<67180),NO3:ONCOT=67384
 Q
 ;NO AJCC messages
NO3 W !!?5,"NO AJCC TNM Coding Schema in 3rd Edition",!! S Y=39 Q
NO4 W !!?5,"NO AJCC TNM Coding Schema as yet",!! S Y=39 Q
 ;
CN ;Check before N-code
 S S=$P(^ONCO(165.5,D0,0),U),ONCOT=+$G(^(2))
 S Y=$S(X="":39,'$D(ONCOT):20,(ONCOT<67700!(ONCOT>67719)):37.2,1:37.3) I Y=37.3 W !,"N-code: Not Applicable (no nodes)"
 Q
 ;
AST ;AUTOMATIC STAGING:COMPUTED FIELD
ES ;Enter Staging
 S ST=$P(^ONCO(165.5,D0,0),U),XX=$G(^(2)) G EX:XX="" S T=$P(XX,U,25),N=$P(XX,U,26),M=$P(XX,U,27)
 S XN=N I N="X" S N=0
 I M=1 S SG=4 G SG
 I T="" W !?5,"No 'T-code' has been assigned" S SG=9 G SG
 I N="",ST'=58 W !?5,"No 'N-code' has been assigned" S SG=9 G SG
 I M="" W !?5,"No 'M-code' has been assigned" S SG=9 G SG
 I T="X" S SG=9 G SG
G S G=$P(XX,U,5),TX=$P(XX,U),SP=$P($G(^ONCO(164,+TX,0)),U,11) G ERD:SP="" I ST'=39!(ST'=40) S AG=$P(^(0),U,12) G AG
 S TX=$E(TX,3,5),AG=$S(ST=40:46,$E(TX,1,2)=44:22,TX=690:39,TX=693!(TX=694):40,1:"") G ERD:AG=""
AG S C=$S($L(AG)=1:0,1:$E(AG)) G ERD:C="" D @(AG_"^ONCOTN"_C)
 I SG="C" S SG=$S(+T=3:3,+T=2:2,+T:1,'T&'N:0,1:"E")
END I SG="E" W !!?5,"Cannot Stage with given T,N,M coding",!! S SG=9
NS ;NO STAGE
N I SG="" W !!?5,"No stage grouping is presently recommended for "_$P(^ONCO(164.33,AG,0),U),! S Y="@4" G EX ;**523/KC R !,"=>",X:DTIME G EX
SG ;COMPUTED STAGE from T,N,M input
 S $P(^ONCO(165.5,D0,2),U,20)=SG,X=SG,Z=$E(SG),XSG=$S(Z=1:"I",Z=2:"II",Z=3:"III",Z=4:"IV",Z=9:"U",1:Z),XSG=XSG_$E(SG,2)
 S SG=$S(XSG="":"Not Applicable",XSG="U":"Unknown/Unstaged",1:XSG_" (T"_T) I ST=54,$P(^ONCO(165.5,D0,2),U,31)="Y" S SG=SG_"(m)"
 I SG["T" S N=XN S:N'="" SG=SG_" N"_N S SG=SG_" M"_M_")"
W W !!?12,"Computed AJCC SUMMARY STAGE: ",SG,!
XR I SG'="" D KSG^ONCOCRC,SSG^ONCOCRC
 ;
OS ;Check for Other Staging #39 (Colon,Digest,Rectum,Melanoma,Prostate)
 S RY=$S(ST=14:39,ST=17:39,ST=18:39,ST=39:39,ST=50:39,1:"@4")
CD ;Check Data
 N DIR,DP,DQ
 ;**523/KC S DIR("A")="     Data Ok",DIR(0)="Y",DIR("B")="Y" W ! D ^DIR S Y=$S(Y=1:RY,Y=0:"@3",1:"") W:Y=39 !
 Q
 ;
YR ;check switch AJCC
 I '$D(ONCOYR) S YR=$P(^ONCO(165.5,D0,0),U,7),ONCOYR=$G(^ONCO(160.1,"AJ")),ONCOYR=$S(ONCOYR="":1,YR'<^ONCO(160.1,"AJ"):1,1:0)
 Q
EX ;EXIT ROUTINES
 K NX
 Q
ERR ;ERROR
 ;W !!?5,"Cannot Stage - error in coding??",! S SG="Unstaged/Unknown" q
ERD ;ERROR CODING SCHEMA
 W !!?5,"ERROR IN CODING SCHEME - Cannot Stage, CALL your ISC",!! Q
M ;Check Morphology
 S H=$P(XX,U,3),SG="" Q:H=87203  W !?5,"Staging Schema not applicable for Morphplogy: "_$E(H,1,4)_"/"_$E(H,5),! S SG="U" Q
UNS ;UNSTAGED
 S SG="Unknown/Unstaged" Q  ;S $P(^ONCO(165.5,D0,2),U,20)=9,$P(^(2),U,28)="U"
 Q
AS ;ANATOMICAL SITE
