IBY742PO ;EDE/WCJ - POST INSTALL ROUTINE FOR IB*2.0*742
 ;;2.0;INTEGRATED BILLING;**742**;;Build 36
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
POST ;EP
 S IBA(2)="IB*2*742 Post-Install...",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 D GETRIDDD
 S IBA(2)="IB*2*742 Post-Install Complete.",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 Q
 ;
GETRIDDD ;some sites have a residual DD node so get rid of it (and cite the ICR)
 ;
 ;^DD(399.047,.02,0)="VALUE^FX^^0;2^K:$L(X)>10!($L(X)<1)!'$$FORMCHK^IBCVC(X,.DA) X"
 ;^DD(399.047,.02,.009,1,0)="ENTER FROM 1 TO 10 CHARACTERS OF FREE TEXT"
 ;^DD(399.047,.02,3)=""
 ;^DD(399.047,.02,4)="D HELP^IBCVC"
 ;^DD(399.047,.02,"DT")=3070718
 ;
 Q:$G(^DD(399.047,.02,.009,1,0))=""
 S ^XTMP("IBY742PO",0)=DT_U_$$FMADD^XLFDT(DT,60)
 S ^XTMP("IBY742PO")=$G(^DD(399.047,.02,.009,1,0))
 K ^DD(399.047,.02,.009,1,0)
 Q
