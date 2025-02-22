HBHCXMV ;LR VAMC(IRMS)/MJT - POPULATE HBHC TRANSMIT FILE OR LOG PSEUDO SSN ERRORS; Feb 22, 2021@07:22
 ;;1.0;HOSPITAL BASED HOME CARE;**2,5,6,9,12,15,17,14,19,24,25,32**;NOV 01, 1993;Build 58
 ;
 ;Reference to:
 ;   ^SC supported by ICR #10040
 ;   ^DIC(4 supported by ICR #10090
 ;   ^DG(40.8 supported by ICR #7024
 ;
 D START^HBHCXMV1
LOOP ; Loop thru ^HBHC(632) "AC","N" cross-ref to create nodes in ^HBHC(634) => transmit
 S HBHCDFN="" F  S HBHCDFN=$O(^HBHC(632,"AC","N",HBHCDFN)) Q:HBHCDFN=""  D SETNODE
EXIT ; Exit module
 D EXIT^HBHCXMV1
 Q
SETNODE ; Set node in ^HBHC(634) (Transmit)
 S HBHCINFO=^HBHC(632,HBHCDFN,0),HBHCXMT4=$P(HBHCINFO,U,8),HBHCAPDT=$P(HBHCINFO,U,2),HBHCSSN=$P(^DPT($P(HBHCINFO,U),0),U,9)
 Q:$P(HBHCINFO,U,7)]""  ; cancelled/no show appointment
 Q:HBHCAPDT>HBHCLSDT  ; Visit appointment date > HBHCLSDT (last date to include in transmit set up in ^HBHCFILE)
 I HBHCAPDT<2961001 D PCE^HBHCXMV1 Q
 I HBHCSSN'?9N D PSSN^HBHCXMV1 Q
 S HBHCPRV=+^HBHC(631.4,$P(HBHCINFO,U,4),0)
 ;HBH*1.0*32: pad provider number with leading zeroes instead of trailing spaces
 S:$L(HBHCPRV)'=4 HBHCPRV=$E("000",1,4-$L(HBHCPRV))_HBHCPRV
 ;HBH*1.0*32: HBHCHOSPX = division of visit location
 N HBHCHOSPX
 S HBHCHOSPX=$P(HBHCINFO,U,3)
 I HBHCHOSPX]"" D
 . S HBHCHOSPX=$P($G(^SC(HBHCHOSPX,0)),U,15)
 . Q:HBHCHOSPX=""
 . ;retrieve institution file pointer
 . S HBHCHOSPX=$P($G(^DG(40.8,HBHCHOSPX,0)),"^",7)
 . Q:HBHCHOSPX=""
 . ;retrieve station number
 . S HBHCHOSPX=$P($G(^DIC(4,HBHCHOSPX,99)),U)
 . Q:HBHCHOSPX=""
 . S:$L(HBHCHOSPX)'=7 HBHCHOSPX=HBHCHOSPX_$E(HBHCSP4,1,(7-($L(HBHCHOSPX))))
 ;if for some reason did not retrieve the institution's station number, use default.
 I HBHCHOSPX="" S HBHCHOSPX=HBHCHOSP
 ;HBHC*1.0*32 end
 S HBHCTIME=$P(HBHCAPDT,".",2) S:$L(HBHCTIME)<4 HBHCTIME=HBHCTIME_$E(HBHCZRO4,1,(4-($L(HBHCTIME)))) S:$L(HBHCTIME)>4 HBHCTIME=$E(HBHCTIME,1,4)
 S HBHCDATE=$E(HBHCAPDT,4,5)_$E(HBHCAPDT,6,7)_(1700+$E(HBHCAPDT,1,3))_HBHCTIME
 S HBHCLNME=$P($P(^DPT($P(HBHCINFO,U),0),U),",") S:$L(HBHCLNME)'=11 HBHCLNME=$S($L(HBHCLNME)<11:HBHCLNME_$E(HBHCSP10,1,11-$L(HBHCLNME)),1:$E(HBHCLNME,1,11))
 S HBHCQAI=$S(($L($P(HBHCINFO,U,16))=1)&($E(HBHCINFO,U,16)=""):HBHCSP1_$P(HBHCINFO,U,16),($L($P(HBHCINFO,U,16))=1)&($E(HBHCINFO,U,16)]""):$P(HBHCINFO,U,16)_HBHCSP1,$L($P(HBHCINFO,U,16))=2:$P(HBHCINFO,U,16),1:HBHCSP2)
DX ; Dx
 D INIT,DX^HBHCUTL3
 S HBHCL=0
 F  S HBHCL=$O(HBHCDX(HBHCL)) Q:HBHCL'>0  D
 . S HBHCDX=$P(HBHCDX(HBHCL),"  ")
 . S HBHCDX=$P(HBHCDX,".")_$P(HBHCDX,".",2)
 . S HBHCDX(HBHCL)=$S($L(HBHCDX)'=8:HBHCDX_$E(HBHCSP8,1,8-$L(HBHCDX)),1:HBHCDX)
 ; Note:  HBHCI initialized here vs in CPT loop, since need HBHCI to continue for each 10 CPT code iteration
 S (HBHCFLAG,HBHCI,HBHCL)=0 F  S HBHCL=$O(HBHCDX(HBHCL)) Q:HBHCL'>0  S HBHCCNT1=HBHCCNT1+1,@("HBHCDX"_HBHCCNT1)=HBHCDX(HBHCL) D:(HBHCCNT1=5)&('HBHCFLAG) CPT D:HBHCCNT1=5 WRITE
 F  D:'HBHCFLAG CPT D WRITE Q:HBHCFLAG
 Q
CPT ; CPT Codes
 F HBHCCNT=1:1:10 S HBHCI=$O(^HBHC(632,HBHCDFN,2,HBHCI)) Q:HBHCI'>0  S HBHCNOD2=^HBHC(632,HBHCDFN,2,HBHCI,0) D SET
 S:HBHCI'>0 HBHCFLAG=1
 Q
SET ; Set CPT variables
 I HBHCCNT<10 S @("HBHCCPT"_HBHCCNT)=$S($P(HBHCNOD2,U)]"":$E($P($G(^ICPT($P(HBHCNOD2,U),0)),U),1,5),1:HBHCSP5) S:$L(@("HBHCCPT"_HBHCCNT))'=5 @("HBHCCPT"_HBHCCNT)=@("HBHCCPT"_HBHCCNT)_$E(HBHCSP5,1,5-$L(@("HBHCCPT"_HBHCCNT)))
 I HBHCCNT=10 S HBHCCP10=$S($P(HBHCNOD2,U)]"":$E($P($G(^ICPT($P(HBHCNOD2,U),0)),U),1,5),1:HBHCSP5) S:$L(HBHCCP10)'=5 HBHCCP10=HBHCCP10_$E(HBHCSP5,1,5-$L(HBHCCP10))
 Q
WRITE ; Write transmit record, separate records containing max 5 DX & 10 CPTs each are generated for same visit if > 5 DX or > 10 CPTs exist
 Q:(HBHCDX1=HBHCSP8)&(HBHCCPT1=HBHCSP5)
 L +^HBHC(634,0):$S($D(DILOCKTM):DILOCKTM,1:3) Q:'$T  S HBHCNDX1=$P(^HBHC(634,0),U,3)+1 F  Q:'$D(^HBHC(634,HBHCNDX1))  S HBHCNDX1=HBHCNDX1+1
 S $P(^HBHC(634,0),U,3)=HBHCNDX1,$P(^HBHC(634,0),U,4)=$P(^HBHC(634,0),U,4)+1 L -^HBHC(634,0)
 ;HBH*1.0*32 variable HBHCHOSP replaced by HBHCHOSPX
 S HBHCREC=HBHCFORM_HBHCHOSPX_HBHCSSN_HBHCDATE_HBHCPRV_HBHCLNME_HBHCQAI_HBHCDX1_HBHCDX2_HBHCDX3_HBHCDX4_HBHCDX5_HBHCCPT1_HBHCCPT2_HBHCCPT3_HBHCCPT4_HBHCCPT5_HBHCCPT6_HBHCCPT7_HBHCCPT8_HBHCCPT9_HBHCCP10_HBHCSP64
 S ^HBHC(634,HBHCNDX1,0)=HBHCREC,^HBHC(634,"B",$E(HBHCREC,1,30),HBHCNDX1)=""
 ; Flag record as filed
 L +^HBHC(632,HBHCDFN,0):$S($D(DILOCKTM):DILOCKTM,1:3) Q:'$T  K:HBHCXMT4]"" ^HBHC(632,"AC",HBHCXMT4,HBHCDFN) S $P(^HBHC(632,HBHCDFN,0),U,8)="F",^HBHC(632,"AC","F",HBHCDFN)="",$P(^HBHC(632,HBHCDFN,0),U,9)=HBHCTDY L -^HBHC(632,HBHCDFN,0)
 ; Initialize QAI, DX & CPT fields to spaces after 1st record written to avoid multiple count(s) of same data when > 5 DX or > 10 CPTs exist
 S HBHCQAI=HBHCSP2
INIT ; Initialize variables
 F HBHCK=1:1:5 S @("HBHCDX"_HBHCK)=HBHCSP8
 S (HBHCCNT,HBHCCNT1)=0,HBHCCP10=HBHCSP5
 F HBHCJ=1:1:9 S @("HBHCCPT"_HBHCJ)=HBHCSP5
 Q
