LRZBRX ;MJB/ISC-A;REQUESTING PERSON STUFFER [ 02/07/95  1:38 PM ]
 ;1.0; FOR LAB PATCH *128 
 ;
 ; This routine is written so that the REQUESTING PROVIDER field will be stuffed with a know provide of the user's desgression.
 ;
START W @IOF 
 ;USER SELECTS THE PROVIDER TO BE STUFFED
S1 S DIR(0)="P^6:EZ",DIR("A")="Select your Doctor ",DIR("A",1)="Please select a Dr. Unknown from your PROVIDER file",DIR("A",2)="With properly set A3 and A6 cross references" D ^DIR Q:$D(DIRUT)
 ;
 S MD=Y,MF1=$P(Y,"^",1)
 ;
BAD R !!,"Please enter the Non-Existent value off the exception report: ",LRZBAD:DTIME
 I '$T!(LRZBAD["^") G END
 I LRZBAD["?" W !!,*7,"Please check the Exception Report generated for this value.",! G BAD
 ;
 ;
 W !!,?5,"Ok I'll go look for entries with the "_LRZBAD_" dangling pointer",! 
FOR S D0=0 F  S D0=$O(^LR(D0)) Q:'D0  S F1=0 F  S F1=$O(^LR(D0,"CH",F1)) Q:'F1  I $D(^LR(D0,"CH",F1,0))#10  S LRZDOC=$P($G(^(0)),U,10) I LRZDOC=LRZBAD S $P(^(0),U,10)=MF1  W "." 
 ;
 W !!,"DONE I AM, I AM ......" G END
 ;
END K MD,MF1,LRZBAD,D0,F1,LRZDOC,X,Y
 Q
