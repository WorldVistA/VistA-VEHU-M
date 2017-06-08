MJBLRO ;NEW PROGRAM [ 11/03/94  11:47 AM ]
 ;
 ;
START ;   
 W !,?5,"This routine was written in order to remove bad entries from"
 W !,?5,"the lab accession file"
 ;
AREA R !,?5,"Please enter 45 or 47: ",MJBACC I MJBACC'=45,47 G AREA
 ;
SDT ;
 R !,?5,"Now enter the FIRST date in the global: ",MJBSD
 ;
EDT ;
 R !,?5,"Now enter the last date in the global: ",MJBED
 ;
 W !,"Now we'll execute a FOR loop and blow these puppies away !!"
 ;
 ;
 F I=MJBSD:1:MJBED I $D(^LRO(68,MJBACC,1,I))  K ^LRO(68,MJBACC,1,I) Q:I=""
 ;
CLEAN K MJBACC,MJBSD,MJBED,I
 Q
