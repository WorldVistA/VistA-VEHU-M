DGV52PR ;ALB/MTC - DG PRE-INIT FOR VERSION 5.2 ; 4/3/92 2:55 pm
 ;;5.2;REGISTRATION;;JUL 29,1992
 ;
 D DD
 Q
 ;
DD ; -- clean up dd of bad "IX" nodes
 N FILE,XREF,DD
 W !,">>> Cleaning up 'IX' nodes from file #2 and #42.",!
 F FILE=2,42 D
 .S XREF="" W "."
 .F  S XREF=$O(^DD(FILE,0,"IX",XREF)) Q:XREF=""  S DD=0 F  S DD=$O(^DD(FILE,0,"IX",XREF,DD)) Q:'DD  I '$D(^DD(DD)) W !,XREF,"  ",DD K ^DD(FILE,0,"IX",XREF,DD)
 Q
