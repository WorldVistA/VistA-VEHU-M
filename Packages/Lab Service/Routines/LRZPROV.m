LRZPROV ;MJB/ISC-A;REQUESTING PERSON STUFFER [ 07/03/97  12:04 PM ]
 ;1.0; FOR LAB PATCH *128 
 ;
 ; This routine is written so that the REQUESTING PROVIDER field will be stuffed with a know provide of the user's desgression.
 ;
START ; 
 ; USER SELECTS THE PROVIDER TO BE STUFFED
S1 S DIR(0)="P^6:EZ" D ^DIR
 ;
 S MD=Y,MF1=$P(Y,"^",1),START=$P(^DIC(6,0),U,3)
 ;
 ;
63 W !!,"I have the last record number in your provider file and the provider",!,"you want to stuff, now I need to loop down the LAB DATA file.",!
 ;
631 S D0=0 F  S D0=$O(^LR(D0)) Q:'D0  S F1=0 F  S F1=$O(^LR(D0,"CH",F1)) Q:'F1  I $D(^LR(D0,"CH",F1,0))#10  S LRZDOC=$P($G(^(0)),U,10) I LRZDOC>START S $P(^(0),U,10)=$S(LRZDOC<START:LRZDOC,1:MF1) W "." 
 ;.W !!,"I have changed the REQUESTING PERSON field for "_D0
 ;.W !,"For date: "_F1
 ;.W !,"To : "_MF1
 .W !!,"."
 ;
 K F1,DIR,D0,LRZDOC,MD,MF1,START,X,Y
 W !!,"DONE I AM, I AM ......"
 Q
