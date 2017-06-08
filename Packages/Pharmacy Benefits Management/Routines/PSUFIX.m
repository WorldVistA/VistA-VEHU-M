PSUFIX ;BHM ISC/DEB - Fix VERSION node in PACKAGE file;1JUL94
 ;;1.0; D&PPM ;**2**;11 MAY 94
 W !!,"When the inits for D&PPM Version 1.0 were executed the following statement ",!,"was made:",!!,"""This version (#1.0V2) of 'PUSINIT' was created on 17-MAR-1994."""
 W !!,"Therefore the CURRENT VERSION field in the PACKAGE file, was set to '1.0V2'."
 W !,"The correct entry should be 1.0, this routine will correct this",!,"problem, by updating the D&PPM entry."
 G NODPPM:'$D(^DIC(9.4,"B","D&PPM")) S PSU1=$O(^DIC(9.4,"B","D&PPM",0)) S DIE="^DIC(9.4,",DA=PSU1,DR="13///"_"1.0" D ^DIE K DR,DIE,DA
 K PSU1 W !,?40,*7,*7,"CURRENT VERSION field updated.",! G Q
NODPPM W !!,"The D&PPM package is not listed in your PACKAGE file.",!,"No updating has occurred.",!
 ;
Q Q
