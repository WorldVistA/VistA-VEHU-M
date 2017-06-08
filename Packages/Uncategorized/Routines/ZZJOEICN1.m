ZMSTARKICN ;
 
START ;
 ;
 N tempIEN,job,UP,LO,system,tempSELECTICN
 
 s job = $J
 SET UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 SET LO="abcdefghijklmnopqrstuvwxyz"
 S DTIME=9999
 s system = $ZU(110)
 s system = $TR(system,UP,LO)
 ;i system [ "gold" q
 D SELECT Q
 w !,"Choose (I)ndividual patient "
 R X
 i X["^" q
 i X="" q
 s X=$TR(X,LO,UP)
 i $E(X)="I" d SELECT Q
 i $E(X)="L" d LOOP Q
 Q
 
 
SELECT ;
 W !,"ICN change utility.",!
 f  D 
 .W ! S DIC="^DPT(",DIC(0)="AEQMZ" D ^DIC  ; Patient Select utility stores results in Y array
 .I Y<0 Q
 .S tempIEN = $p(Y,"^",1)
 .W !,"Enter new ICN: (everything on the left of the V)" 
 .R X
 .i $l(X)=0 q
 .i X["^" q
 .i X'?1N.N Q
 .s SELECTICN = X
 .W !,"Enter new ICN CKSUM: (everything on the right of the V)" 
 .R X
 .i $l(X)=0 q
 .i X["^" q
 .;i X'?1N.N Q
 .s SELECTCK = X
 .d WORK
 Q
 
LOOP ;
 F  S tempIEN  = $o(^DPT(tempIEN)) q:'tempIEN  d  
 .D WORK
 Q
 
WORK ;
 I tempIEN'?1N.N Q
 D KILLHISTORY(tempIEN)
 D ICN(tempIEN)
 D KILLHISTORY(tempIEN)
 S ^DPT("AICN",$p(^DPT(tempIEN,"MPI"),"^",1),tempIEN)=""
 Q
 
ICN(changeIEN) ;
 N DFN,GMRCPT,OK
 I $l(changeIEN)=0 b  ; q
 S DFN=changeIEN d  
  . W !!,"Trying to set test patient ICN for ",changeIEN
  . S GMRCPT("SS")=$P($G(^DPT(changeIEN,0)),"^",9)
  . ;I $L(GMRCPT("SS"))'=9 W !,"BAD SSN." Q
  . ;I $E(GMRCPT("SS"),1,3)="000" s $e(GMRCPT("SS"),1,3)="666"
  . W !,SELECTICN_" "_DFN
  . ;S GMRCPT("SS")=tempSELECTICN
  . S OK=$$SETICN^MPIF001(DFN,SELECTICN,SELECTCK)
  . w !,OK
  . I 'OK W !!,"Unable to set ICN for ",changeIEN," ",OK Q
  W !!,"  Done.",!
 q
 
KILLHISTORY(killIEN) ;
 n X,Y
 i $l(killIEN)=0 b  ;q
 K ^DPT(killIEN,"MPIFHIS")
 
 s X=0,Y=0
 f  s X=$o(^DPT("AICN",X)) q:'X  d  
 . f  s Y=$o(^DPT("AICN",X,Y)) q:'Y  d  
 . . i Y=killIEN k ^DPT("AICN",X,killIEN) s X=0,Y=0
 q
 
KILLHISTORY1(killIEN) ;
 i $l(killIEN)=0 b  ; q
 K ^DPT(killIEN,"MPIFHIS")
 q
 
 
