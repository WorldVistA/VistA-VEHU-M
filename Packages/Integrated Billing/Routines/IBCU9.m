IBCU9 ;ALB/BI - BILLING UTILITY ROUTINE (CONTINUED) ;01 JUL 2011 11:13
 ;;2.0;INTEGRATED BILLING;**447,592**;01-JUL-2011;Build 58
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
CMAEDALL(IBIEN)  ; Clear all manually edited flags for a claim.
 N IBRCIEN S IBRCIEN=0
 F  S IBRCIEN=$O(^DGCR(399,IBIEN,"RC",IBRCIEN)) Q:+IBRCIEN=0  D
 . D CMAEDIND(IBIEN,IBRCIEN)
 Q
 ;
CMAEDIND(IBIEN,IBRCIEN)  ; Clear individual manually edited flags for a revenue code.
 S $P(^DGCR(399,IBIEN,"RC",IBRCIEN,0),U,16)=""
 Q
 ;
FROMPROC(IBIEN,IBCPIEN,IBFLG)  ; Clear individual manually edited flag if procedures match.
 I $G(IBIEN)="" Q
 I $G(IBCPIEN)="" Q
 I $G(IBFLG)="" Q
 I IBFLG="E",IBCPIEN=$O(^DGCR(399,IBIEN,"CP",0)) D CMAEDALL(IBIEN) Q
 I IBFLG="D",IBCPIEN=$O(^DGCR(399,IBIEN,"CP",0)) D PROC1DEL(IBIEN) Q
 N IBRC0,IBRCPRSP
 N IBRCIEN S IBRCIEN=0
 F  S IBRCIEN=$O(^DGCR(399,IBIEN,"RC",IBRCIEN)) Q:+IBRCIEN=0  D
 . S IBRC0=$G(^DGCR(399,IBIEN,"RC",IBRCIEN,0)),IBRCPRSP=$P(IBRC0,U,11)
 . I IBRCPRSP=IBCPIEN D CMAEDIND(IBIEN,IBRCIEN)
 Q
 ;
PROC1DEL(IBIEN)  ; The first procedure was deleted, determine division change.
 N IBCPIEN1,IBCPIEN2
 S IBCPIEN1=$O(^DGCR(399,IBIEN,"CP",0)) I IBCPIEN1="" Q
 S IBCPIEN2=$O(^DGCR(399,IBIEN,"CP",IBCPIEN1)) I IBCPIEN2="" D CMAEDALL(IBIEN) Q
 I $P($G(^DGCR(399,IBIEN,"CP",IBCPIEN1,0)),U,6)'=$P($G(^DGCR(399,IBIEN,"CP",IBCPIEN2,0)),U,6) D CMAEDALL(IBIEN)
 Q
 ;
 ;JWS;IB*2.0*592;US1109 Dental
FTINPUT(Y) ;SCREEN FOR 399, .19 FORM TYPE
 N Z
 I Y=7,$P($G(^IBE(350.9,1,8)),U,20)=0 Q 0
 S Z=$G(^IBE(353,Y,2)) I $P(Z,U,2)="P",$P(Z,U,4) Q 1
 Q 0
 ;
