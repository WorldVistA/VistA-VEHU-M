VEJDSRPC        ;AMC - Document Storage Systems
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
PROC ; check for spaces
 N SRBL,SROP,SRFLG S VSRERR=""
 I X="@" Q
 I $E(X)=" " S VSRERR="The first character must not be a space." Q
 I X["@" S VSRERR="The procedure that you have entered contains a '@'." Q
 I X[";" S VSRERR="The procedure cannot contain a semicolon (;)." Q
 I X["^" S VSRERR="The procedure that you have entered contains an up-arrow (^)." Q
 I X?.E1C.E S VSRERR="Your answer contains a control character." Q
 Q:$L(X)<30
 S SROP=X,SRFLG=0 F  D CHECK Q:SRFLG!($L(SROP)'>30)
 I '$D(X) S VSRERR="Answer must contain at least one space in every 31 characters of length." Q
 Q
CHECK S SRBL=$F(SROP," ") I SRBL>32!('SRBL) S SRFLG=1 Q
 S SROP=$E(SROP,SRBL,$L(SROP))
 Q
