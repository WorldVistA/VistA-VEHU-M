IBMHUT1 ;YMG/EDE - IB Mental Health Utilities ;MAY 15 2023
 ;;2.0;Integrated Billing;**784**;21-MAR-94;Build 8
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
MHVST(IBSDT,IBEDT) ; loop through file 350 and populate file 351.83, as needed
 ;
 ; IBSDT - start date
 ; IBEDT - end date
 ;
 N DFN,IBATYP,IBATYPN,IBCANC,IBDT,IBENC,IBEVDT,IBIEN,IBMHPROC,IBMHTRK,IBOK,IBSTAT,IBSTATN,IENS,N0,Z
 I '+$G(IBSDT)!('+$G(IBEDT)) Q  ; invalid date(s)
 S DFN=0 F  S DFN=$O(^IB("AFDT",DFN)) Q:'DFN  D
 .S IBDT=-(IBEDT+.01) F  S IBDT=$O(^IB("AFDT",DFN,IBDT)) Q:'IBDT!(-IBDT<IBSDT)  D
 ..S IBEVDT=-IBDT
 ..S IBIEN=0 F  S IBIEN=$O(^IB("AFDT",DFN,IBDT,IBIEN)) Q:'IBIEN  D
 ...S N0=$G(^IB(IBIEN,0))  ; file 350 entry, node 0
 ...S IBATYP=$P(N0,U,3) I 'IBATYP Q
 ...S IBATYPN=$P($G(^IBE(350.1,IBATYP,0)),U) I IBATYPN'["OPT" Q  ; not an outpatient charge
 ...S IBSTAT=$P(N0,U,5) I 'IBSTAT Q
 ...S IBSTATN=$P($G(^IBE(350.21,IBSTAT,0)),U)
 ...S IBOK=$S(IBATYPN["CC MH":1,1:0)
 ...I 'IBOK S IBOK=$$ISCDCANC^IBECEAMH(IBIEN)
 ...I 'IBOK S Z=$P($P(N0,U,4),";") Q:$P(Z,":")'="409.68"  S IBENC=$P(Z,":",2),IBOK=$$OECHK^IBECEAMH(IBENC,IBEVDT)
 ...I IBOK D
 ....; eligible for Cleland-Dole
 ....S IBMHTRK=+$O(^IBMH(351.83,"D",IBIEN,"")) ; file 351.83 ien, if entry already exists
 ....I IBSTATN="BILLED"!("^ON HOLD^HOLD - RATE^HOLD - REVIEW^"[(U_IBSTATN_U)),IBMHTRK>0,'$$ISBILLED(IBIEN) D ADDVST^IBECEAMH(DFN,IBEVDT,IBIEN,2)
 ....I IBSTATN="CANCELLED" D
 .....S IBCANC=+$P(N0,U,10) I 'IBCANC Q
 .....S IENS=IBCANC_",",IBMHPROC=$$GET1^DIQ(350.3,IENS,.07,"I") I 'IBMHPROC Q
 .....I '$$GET1^DIQ(350.3,IENS,.08,"I") Q  ; cancellation reason can't cancel C-D charge
 .....I IBMHTRK>0 D UPDVST^IBECEAMH(IBIEN,IBMHPROC) Q
 .....I $P(^IBE(350.3,IBCANC,0),U)="CLELAND-DOLE",$$NUMVSTCK^IBECEAMH(DFN,IBEVDT) D ADDVST^IBECEAMH(DFN,IBEVDT,IBIEN,1,2)
 ....Q
 ...Q
 ..Q
 .Q
 Q
 ;
ISBILLED(IBIEN) ; check if there's a "billed" entry in file 351.83 for a given charge
 ;
 ; IBIEN - file 350 ien
 ;
 ; returns 1 if there's a corresponding entry in file 351.83 with "billed" status, or 0 otherwise.
 ;
 N IBMHIEN,RES
 S (RES,IBMHIEN)=0 F  S IBMHIEN=$O(^IBMH(351.83,"D",IBIEN,IBMHIEN)) Q:'IBMHIEN!RES  I $P(^IBMH(351.83,IBMHIEN,0),U,4)=2 S RES=1
 Q RES
