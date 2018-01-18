A1CGCMP2 ;JSH/TROY;10/29/87;DD COMPARE
 ;Continued from A1CGCMP if user specified DD compare
 ;
EN S SUB1="ERRD" D NOW^%DTC S Y=% U IO W @IOF,?(IOM/2-13),"Data Dictionary Compare Report",!!?(IOM/2-10),"Began: " X ^DD("DD") W Y W !!
 F I=0:0 S I=$N(^UTILITY("A1CGCMP",SUB,I)) Q:I'>0  F II=0:0 S II=$N(^UTILITY("A1CGCMP",SUB,I,II)) Q:II'>0  S GLOB="DD("_II_",",GLEN=$L(GLOB) D LOOP^A1CGCMP1
 W !!?(IOM/2-17),"Comparision finished at " D NOW^%DTC S Y=% X ^DD("DD") W Y W !!
 Q
PRINT U IO
 F I0=0:0 S I0=$N(^UTILITY("A1CGCMP",SUB,"ERRD",I0)) Q:I0'>0  W @IOF,^UTILITY("A1CGCMP",SUB,I0),":" F I1=-1:0 S I1=$N(^UTILITY("A1CGCMP",SUB,"ERRD",I0,I1)) Q:I1=-1  D LP4
 Q
LP4 S I="DD(" F K=0:0 S I=$N(^UTILITY("A1CGCMP",SUB,"ERRD",I0,I1,I)) Q:I=-1  Q:I'?1"DD(".E  W:$Y>(IOSL-4) @IOF W !!,I," ----> " F J=0:0 S J=$N(^UTILITY("A1CGCMP",SUB,"ERRD",I0,I1,I,J)) Q:J'>0  D PRETTY
 Q
PRETTY ;
 F II=0:0 S II=$N(GLO(II)) Q:II'>0  S X=$P(GLO(II),"]")_"]"_I W:$Y>(IOSL-4) @IOF W !?4,X,"=",$S($D(@X):@X,1:"undefined")
