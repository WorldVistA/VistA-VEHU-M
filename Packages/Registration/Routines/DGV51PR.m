DGV51PR ;ALB/RMO - DG PRE-INIT FOR VERSION 5.1 ; 2 MAY 90 2:55 pm
 ;;MAS VERSION 5.1;
 ;
 D C1DG5,DD
 Q
C1DG5 ;-- delete v5 temp file
 W !!,">>> Deleting v5.0 temporary file"
 S DIU=405.9,DIU(0)="D" D EN^DIU2
 K DIU
 Q
 ;
DD ;Kill off IRT files for v5.1 test accounts
 F DGDIU=393.1,393.2 I $D(^DD(DGDIU)) S DIU=DGDIU,DIU(0)="" D EN^DIU2
 K DIU
 Q
