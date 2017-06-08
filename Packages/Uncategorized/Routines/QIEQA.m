QIEQA ; B'ham ISC/DMA - function for EPRP to look at QA ; 02 Feb 94 / 11:40 AM
 ;;1.0; EPRP ;**2,10**;28 Apr 92
QA(DFN,ADM,DIS) ;
 N V1,V2,V3,V4,V5
 S V5=0 D  Q V5
 .F V1=0:0 S V1=$O(^QA(741,"B",DFN,V1)) Q:'V1  Q:V5  S V2=$P($G(^QA(741,V1,0)),"^",3) I V2'<$P(ADM,"."),V2'>DIS F V3=0:0 S V3=$O(^QA(741,V1,"REVR",V3)) Q:'V3  Q:V5  S V2=$G(^(V3,0)) I $P($G(^QA(741.2,+V2,0)),"^",2)=2 D
 ..I $P($G(^QA(741,V1,0)),"^",11)'=2 S V5=1
 Q
