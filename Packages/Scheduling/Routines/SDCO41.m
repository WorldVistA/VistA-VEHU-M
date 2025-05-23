SDCO41 ;ALB/RMO - Diagnosis Cont. - Check Out;19 MAR 1993 9:15 am
 ;;5.3;Scheduling;**15,351,586**;Aug 13, 1993;Build 29
 ;
 ; Reference to $$IMP^ICDEX supported by ICR #5747
 ; Reference to $$ICDDX^ICDEX supported by ICR #5747
 ; Reference to $$SYS^ICDEX supported by ICR #5747
 ; Reference to $$VLTD^ICDEX supported by ICR #5747
 ;
DXHLP(SDCL) ;Diagnosis Help for Clinic
 ; Input  -- SDCL     Hospital Location file IEN
 ; Output -- Help
 N C,DIRUT,I,SDDXD,SDDXDF,SDICDI
 I '$O(^SC(SDCL,"DX",0)) G DXHLPQ
 W !!,"The following diagnoses are associated with ",$$LOWER^VALM1($P($G(^SC(SDCL,0)),"^")),":"
 W !!,"Default Diagnosis: " S SDDXDF=$$DXDEF(SDCL) W $S(SDDXDF:$P(SDDXDF,"^")_"  "_$P(SDDXDF,"^",2),1:"[None]")
 W !!,"Other diagnoses: "
 S (C,I)=0 F  S I=$O(^SC(SDCL,"DX",I)) Q:'I!($D(DIRUT))  I $D(^(I,0)) S SDICDI=+^(0) I '$D(^SC("ADDX",SDCL,I)) D
 .S C=C+1,SDDXD=$$DX(SDICDI)
 .W:C=1 !
 .D PAUSE^VALM1:'(C#20) Q:$D(DIRUT)  W:(C#2) ! W:'(C#2) ?40
 .W $P(SDDXD,"^"),?($X+(8-$L($P(SDDXD,"^")))),$P(SDDXD,"^",2)
 W:'C "None"
DXHLPQ Q
 ;
DXDEF(SDCL) ;Diagnosis Default for Clinic
 ; Input  -- SDCL     Hospital Location file IEN
 ; Output -- Default
 N Y
 I $D(^SC("ADDX",SDCL)),$D(^SC(SDCL,"DX",+$O(^(SDCL,0)),0)) S Y=$$DX(+^(0))
 Q $G(Y)
 ;
DX(SDICDI,SDDXDT) ;Diagnosis Display Data
 ; Input  -- SDICDI   IDC Diagnosis IEN
 ;        -- SDDXDT   Date to screen against
 ; Output -- Diagnosis Display Data - Code Number^Diagnosis
 N Y,SDXINF,IMPDT,DXTXT
 S SDDXDT=$G(SDDXDT,$G(ICDVDT)),IMPDT=$$IMP^ICDEX(30)
 S SDXINF=$$ICDDX^ICDEX(SDICDI,SDDXDT,+$$SYS^ICDEX("DIAG",SDDXDT,"I"),"I") ;SD*5.3*586
 S DXTXT=$S(SDDXDT<IMPDT:$P(SDXINF,"^",4),1:$$VLTD^ICDEX(SDICDI,SDDXDT))
 S Y=$S(+SDXINF>0:$P(SDXINF,"^",2)_"^"_DXTXT,1:"^Unknown")
 Q $G(Y)
