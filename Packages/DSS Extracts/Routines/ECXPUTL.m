ECXPUTL ;ALB/GTS - Utilities for DSS Prosthetics Extract ;July 15, 1998
 ;;3.0;DSS EXTRACTS;**9**;Dec 22, 1997
 ;
PDIV() ; Prompt the user for a division and return its IEN
 ;
 ; Output:
 ;  ECXDIV
 ;     Successful  - Institution file IEN for the selected division
 ;   Unsuccessful  - 0
 ;
 N ECXDIV,ECTMP,ECDIVCT,ECDIVSXS,ECDIVLP
 S ECXDIV=0
 S ECDIVSXS=$$DIV4^XUSER(.ECTMP,DUZ) ;**Set up array of user divisions
 ;
 ;** If the user doesn't have divisions setup
 I 'ECDIVSXS DO
 .S DIR(0)="FAO^1:1"
 .S DIR("A",1)="You do not have any divisions defined in your user set up."
 .S DIR("A",2)="Contact an ADPAC or IRM for assistance."
 .S DIR("A")="Hit Return to continue."
 .D ^DIR K DIR,X,Y
 ;
 ;** If the user does have divisions setup
 I ECDIVSXS DO
 .S (ECDIVCT,ECDIVLP)=0
 .F  S ECDIVLP=$O(ECTMP(ECDIVLP)) Q:(+ECDIVLP=0)  DO
 ..I $D(^RMPR(669.9,"C",ECDIVLP)) S ECDIVCT=ECDIVCT+1
 ..I '$D(^RMPR(669.9,"C",ECDIVLP)) K ECTMP(ECDIVLP)
 .I 'ECDIVCT DO
 ..S DIR(0)="FAO^1:1"
 ..S DIR("A",1)="Your division is not set up as a prosthetic division."
 ..S DIR("A")="Hit Return to continue."
 ..D ^DIR K DIR,X,Y
 .I ECDIVCT=1 DO
 ..S ECXDIV=$O(ECTMP(""))
 ..K ECXDIC S DA=ECXDIV,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 ..D EN^DIQ1 S ECXSNUM=$G(ECXDIC(4,DA,99,"I"))
 ..S ECXSNAME=$G(ECXDIC(4,DA,.01,"I"))
 ..K DIC,DIQ,DA,DR,ECXDIC
 ..I $L(ECXSNUM)>3 DO
 ...K ECTMP(ECXDIV)
 ...S DIR(0)="FAO^1:1"
 ...S DIR("A",1)="Your division ("_ECXSNUM_") is not a prosthetic primary division."
 ...S DIR("A",2)="Note that the Station Number ("_ECXSNUM_") is longer than 3 characters"
 ...S DIR("A",3)=" for the Station "_ECXSNAME_"."
 ...S DIR("A",4)="Check with IRM to identify the primary division and add it to your New Person"
 ...S DIR("A",5)=" file entry."
 ...S DIR("A")="Hit Return to continue."
 ...D ^DIR K DIR,X,Y
 ...S ECXDIV=0
 ..K ECXSNUM,ECXSNAME
 .I ECDIVCT>1 DO
 ..S DIC("A")="Select Prosthetic Division: ",DIC(0)="AEQM",DIC="^DIC(4,"
 ..S DIC("S")="I $D(ECTMP(+Y))&(+$L($P($G(^DIC(4,+Y,99)),""^"",1))=3)" D ^DIC
 ..I '$D(DTOUT),'$D(DUOUT),Y>0 S ECXDIV=+Y
 ..I $D(DTOUT)!($D(DUOUT))!(Y<1) DO
 ...S DIR(0)="FAO^1:1"
 ...S DIR("A",1)="You did not select a prosthetic division."
 ...S DIR("A")="Hit Return to continue."
 ...D ^DIR K DIR,X,Y
 ...S ECXDIV=0
 Q ECXDIV
