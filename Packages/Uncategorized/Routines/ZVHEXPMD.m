ZVHEXPMD	;OIA/AJC - expire old meds	;	4/9/2015
 ;;0.1;no package;no patches; 4/9/2015
 ;
 ; copied from PSOHLEXP ;BIR/RTR-Auto expire prescriptions
 ; REQUIED: Calls EN1^PSOHLEXP
 ;
 ; will expire all medications if their expiration date is before today
 ;
EN N PSOEXRX,PSOEXCOM,PSOEXSTS,SUSD,PSOEXSTA,ZZDT,ZZEDT,IFN,NODE,RF,PIFN,PSUSD,PRFDT,PDA,PSDTEST,ORN,CPRSDC
 ; Check for Production environment, quit if true
 New CHECK Set CHECK=$$PROD^XUPROD(1)
 If CHECK Write "This routine is for TEST systems only!!!",!!,"Goodbye!",!! Quit
 ;
 I '$G(DT) S DT=$$DT^XLFDT
 S X1=DT,X2=-1 D C^%DTC S ZZEDT=X
 ;S ZZDT=$P($G(^PS(59.7,1,49.99)),"^",8) I +ZZDT=0 S X1=DT,X2=-2 D C^%DTC S ZZDT=X
 Set ZZDT="" ; starting from null to get ALL the meds using the AG x-ref
 F  S ZZDT=$O(^PSRX("AG",ZZDT)) Q:ZZDT>ZZEDT  Q:ZZDT=""  D EN1^PSOHLEXP
 ;D FACDEA
 Q
