ZZMGSU ; B'ham ISC/CML3 - CREATE GLOBAL LIST ;7/9/91  20:25
 ;;
 ; will not pick up implicit globals
 ; ^UTILITY("ZZMG",0)=number of globals
 W !!,"Creating the UTILITY(""ZZMG"") global list..." K ^UTILITY("ZZMG")
 S (C,GLO)=0 F  S GLO=$O(^UTILITY("GLO",GLO)) Q:GLO=""  W "." I $P(^(GLO),"^",4)\256'=65535,$D(@("^"_GLO)) S C=C+1,^UTILITY("ZZMG",C)=GLO
 S ^UTILITY("ZZMG",0)=C K C,GLO W !,"...DONE!" Q
