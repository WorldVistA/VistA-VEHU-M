A1ATRAT2 ;TRAVEL PACKAGE ; JCK/ALB ; 8 APRIL 88
 ;This routine will run print routines to calculate travel totals per quarter and print out the trip rationale.
 ;
A1AT2 ;Select Fiscal Quarter to Print
 ;
 K ^UTILITY("A1AT","QUARTER")
 ;
A1AMON S A1ATMON=$E(DT,4,5),A1ATMON1=$P("2^2^2^3^3^3^4^4^4^1^1^1^","^",A1ATMON)
 ;
A1FQ W !,"Select the Fiscal Quarter to Print: "_A1ATMON1_"// " R X:DTIME G QUIT:'$T!(X["^") S:X="" X=A1ATMON1 S A1ATMSAV=X G:X>0&(X<5) A1SEL
 W !!,"Please Choose from Fiscal Quarter 1,2,3 or 4  and then try again ...",!! G A1FQ
 ;
A1SEL S ^UTILITY("A1AT","QUARTER")=A1ATMSAV S A1TEMP=$S(A1ATMSAV=1:"[A1ATFQ12]",A1ATMSAV=2:"[A1ATFQ22]",A1ATMSAV=3:"[A1ATFQ32]",A1ATMSAV=4:"[A1ATFQ42]",1:"[A1ATMSAV]")
 ;
A1PRINT W !!,"Please wait a few seconds ... ",!! S L="0",DIC="^DIZ(11003,",FLDS="[A1ATRATPRINT2]",BY=A1TEMP D EN1^DIP
 ;
QUIT Q
 ;
CPFQ ;Find Fiscal Quarter for CP
 ;
 S A1ATMON=$E(DT,4,5),A1ATMON1=$P("2^2^2^3^3^3^4^4^4^1^1^1^","^",A1ATMON)
 Q
