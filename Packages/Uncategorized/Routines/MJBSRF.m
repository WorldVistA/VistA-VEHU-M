MJBSRF ;ISA-BELSCHWINDER  ; Compiled 2000-02-16 08:18AM for M/WNT
 ;LOOP DOWN FILE 130 CHECKING FOR 12 NODE HEADER
 ;
INIT ;
 S X=0 F  S X=$O(^SRF(X)) Q:+X<1  I $D(^SRF(X,12)) I $G(^SRF(X,12,0))="" W !,"File 130 record #: "_X_" has a bad header on the 12 node"         
 Q
