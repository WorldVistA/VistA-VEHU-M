XUCON ;SF/XAK - BUILDS ACCESSIBLE FILE MULTIPLE ;11/26/90  12:50 ;
 ;;6.5;Copyright 1990, DVA;**7**;
 W !!,"Version 6 of the Kernel defines a new multiple-valued field"
 W !,"in the User File called Accessible File.  This conversion"
 W !,"will store file access in this multiple in the following manner:"
 W !!,"Those Users who have a FileMan Access Code (DUZ(0)) which"
 W !,"is not null, i.e., contains some character string,"
 W !,"will have their access string matched to the protection"
 W !,"currently on your files.  For each match between the file"
 W !,"and the user, the file will be listed in the user's"
 W !,"Accessible File multiple as will the type of access"
 W !,"(dictionary, delete, laygo, read, write, audit)."
 W !!,"NOTE: Files with no protection will NOT be assigned to any user.",!
AGN S %=2,U="^" W !!,"Would you like to run the conversion now " D YN^DICN
 G GO:%=1 I %=2!(%<0) W !!,"To run this conversion, D ^XUCON." G KIL
 W !!,"If you are uncertain about your current file protection, it would"
 W !,"be wiser to examine them before running this."
 W !,"If you are not on the CPU which holds the user file, it would"
 W !,"be better to run this conversion on that CPU."
 W !,"If you are short for time, it would be wiser to run this later."
 G AGN
GO W !,"Files " D TIME^XUINEND K ^UTILITY($J) S X="DD^DEL^LAYGO^RD^WR^$$$" K XU
 F I=1.99:0 S I=$N(^DIC(I)) Q:I'>0  W:I#2 "." F J=1:1:6 I $D(^DIC(I,0,$P(X,U,J))),"@"'[^($P(X,U,J)) S %=^($P(X,U,J)) F K=1:1:$L(%) S ^UTILITY($J,$E(%,K),I,J+1)=""
 W !,"Users " D TIME^XUINEND
 F I=0:0 S I=$N(^DIC(3,I)) Q:I'>0  I $D(^(I,0)),'$P(^(0),U,11),$P(^(0),U,3)]"",$P(^(0),U,4)]"" S %=$P(^(0),U,4) D CHECK:%'="@"
 D DISV W !,"Done " D TIME^XUINEND
KIL K ^UTILITY($J),I,J,K Q
 ;
CHECK ;
 W:'(I#10) "."
 F J=1:1:$L(%) F K=0:0 S K=$N(^UTILITY($J,$E(%,J),K)) Q:K'>0  F L=0:0 S L=$N(^UTILITY($J,$E(%,J),K,L)) Q:L'>0  S $P(^DIC(3,I,"FOF",K,0),U,L)=1,$P(^(0),U)=K
 Q
DISV ;
 F I=.5:0 S I=$O(^DISV(I)) Q:+I'=I  I $D(^DIC(3,I,0)),'$P(^(0),U,11),$P(^(0),U,3)]"",$P(^(0),U,4)'="@" S X="" D D1,D2
 Q
D1 ;
 F J=0:0 S X=$O(^DISV(I,X)) Q:X=""  I $E(X)=U,"(,"[$E(X,$L(X)),$L(X,",")<3,X'?1"^DD".E,X'="^DIC(",X'?1"^DOPT".E,$D(@(X_"0)")) S J=+$P(^(0),U,2) I J'<2,'$D(^DIC(3,I,"FOF",J,0)) S ^(0)=J_"^^^^1^"_(J'=3)
 Q
D2 S K=0,%=0 F J=0:0 S J=$N(^DIC(3,I,"FOF",J)) Q:J'>0  S %=J,K=K+1,^DIC(3,I,"FOF","B",J,J)="",^DIC(3,"AFOF",J,I,J)=""
 S ^DIC(3,I,"FOF",0)="^3.032PA^"_%_U_K
 Q
