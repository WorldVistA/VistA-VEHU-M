PSORLLLI ;AITC/BWF - ONEVA LASER LABELS INITIALIZATION ;10/06/16 9:28am
 ;;7.0;OUTPATIENT PHARMACY;**454,643,728,753**;DEC 1997;Build 53
 ;
 ;DBIAs PSDRUG-221, PS(55-2228, SC-10040, IBARX-125, PSXSRP-2201, %ZIS-3435, DPT-3097, ^TMP($J,"PSNPPIO"-3794
 ;External reference to DRUG^PSSWRNA supported by DBIA 4449
 ;External reference to $$DS^PSSDSAPI supported by DBIA 5425
 ;External reference to ^DIC(5 supported by DBIA 4293
 ;External reference to ^SC( supported by DBIA 2675
 ;External reference to $$DS^PSSDSAPI supported by DBIA 5425
 ;External reference to ^ORD(101 supported by DBIA 872
 ;External reference to ^PS(51 supported by DBIA 2224
 ;External reference to ^PSNDF supported by DBIA 2195
 ;External reference to ^%ZIS(2 supported by DBIA 3435
 ;
 ;*244 remove test for partial fill when testing status > 11
 ;
DQ N PSOBIO,PSOXINT,PSOXMARK S (I,PSOIO)=0 F  S I=$O(^%ZIS(2,IOST(0),55,I)) Q:'I  S X0=$G(^(I,0)) I X0]"" S PSOIO($P(X0,"^"))=^(1),PSOIO=1
 I '$G(PSOHLSV("PATCH INSTALLED FLAG"))!($G(PSOLONLY)) G DQS
 S PSOXINT=$P($G(^PS(59,PSOSITE,1)),"^",30)
 S PSOXMARK=0
 S:+$G(PSOHLSV("L_DRUGIEN")) PSOXMARK=+$G(^PSDRUG(+PSOHLSV("L_DRUGIEN"),6))
 I $S(PSOXINT=1:1,PSOXINT=2:1,PSOXINT=3:PSOXMARK,PSOXINT=4:PSOXMARK,1:0) D OPAI
 I $S(PSOXINT=2:1,PSOXINT=3:PSOXMARK,1:0) G HLEX
DQS I '$D(^%ZIS(2,IOST(0),55,"B","LL")) G HLEX
DQ1 I '$D(RPPL) G HLEX
 I $D(PSOIOS),PSOIOS]"" D DEVBAR^PSOBMST
 K RRXFLX,RXFDAMG S PSOCKHN=","_$G(RPPL),PSRESOLV=+RPPL D CHECK
 S PSOINT=1 F PI=1:1 S RX=$P(RPPL,",",PI) Q:RX=""  D
 .S PSOPDFN=$G(PSODFN),RXY=$G(RX0)
 .K RXP,REPRINT D C
 I 'PSOINT D TRAIL^PSORLLL1
 ;
HLEX K RXPI,PSORX,RXP,PSOIOS,PSOLAPPL,XXX,COPAYVAR,TECH,PHYS,MFG,NURSE,STATE,SIDE,COPIES,EXDT,ISD,PSOINST,RXN,RXY,VADT,DEA,WARN,FDT,QTY,PATST,PDA,PS,PS1,RXP,REPRINT
 K SGY,OSGY,PS2,PSL,PSNP,INRX,RR,XTYPE,SSNP,SSNPN,PNM,ADDR,PSODBQ,PSOLASTF,PSRESOLV,PSOEXREP,PSOSXQ
 K DATE,DR,DRUG,LINE,MW,PRTFL,VRPH,EXPDT,X2,DIFF,DAYS,PSZIP,PSOHZIP,PS55,PS55X,REF
 K ^TMP($J,"PSNPMI"),^TMP($J,"PSOCP",+$G(PSOCPN)),PSOCPN,PSOLBLDR,PSOLBLPS,PSOLBLCP,RRXPR,RXRP,RXRS,PSOCKHN,RXFLX,PSOLAPPL,PSOPDFN,PSDFNFLG,PSOZERO,NEXTRX,PSOBLALL,STA
 ; NEW kill lines for cleanup - OneVA Pharmacy
 K RX0,RX2,RX3,RXSTA,HINFO,RSIG,PSODFN,LOCDRUG,ROR1,RPAR0,RREF0,RFIEN,PARIEN,RIEN,PATST,RRFTYP,RRXFL,RRXPR,RSIG1,RPPL,HINFOST
 K BOTTLBL,CONT,DOB,F8,FILLCONT,FLAG,JJ,L2,L3,L4,L5,LENGTH,MAILCOM,NOBARC,NOR,OFONT,OPSOX,OPSOY,ORS,OUT,PATSTIEN
 K PFM,PI,PIMI,PLANNM,PMIM,PPHYS,PRCOPAY,PSCAP,PSCLN,PSDU,PSMP,PSOBY,PSOBYI,PSOCX,PSODFONT,PSODY,PSOFLAST,PSOFNOW
 K PSOFONT,PSOFY,PSOHFONT,PSOINT,PSOLAN,PSONOW,PSONOWT,PSOQFONT,PSOQY,PSORYI,PSOSITE7,PSOSUREP,PSOSUSPR,PSOTFONT,X0,ZDRUG
 K PSOTRAIL,PSOTY,PSOTYI,PSOYI,PSOYM,PTEXT,Q,EXP,PSLION,PSOBLRX,PSOHYI,PSOIO,SGC,SIG1,SIGDONE,SIGM,SS,ULN,VAADDR1,WARN5,ZY
 I '$G(PSOSUREP),'$G(PSOSUSPR) D ^%ZISC S ZTREQ="@"
 Q
 ;
C N PSOBIO S (I,PSOIO)=0 F  S I=$O(^%ZIS(2,IOST(0),55,I)) Q:'I  S X0=$G(^(I,0)) I X0]"" S PSOIO($P(X0,"^"))=^(1),PSOIO=1
 U IO Q:'$D(RX0)  S RXY=$G(RX0),RX2=$G(RX2),RXSTA=$G(RXSTA),RREF0=$G(RREF0),RPAR0=$G(RPAR0) K SGY,OSGY
 S (SIGM,PFM,PMIM,L2,L3,L4,L5,FILLCONT,BOTTLBL)=0
 K SIGF,PFF,PMIF S (SIGF,PFF,PMIF)=0 F I="DR","T" S (SIGF(I),PFF(I))=1
 F I="A","B","I" S PMIF(I)=1
 D NOW^%DTC S Y=$P(%,"."),PSOFNOW=% X ^DD("DD") S PSONOW=Y,Y=PSOFNOW X ^DD("DD") S PSONOWT=Y
 S:$G(PSOBLALL) PSOBLRX=RX S:$D(RRXPR(RX)) RXP=RRXPR(RX)
 S RXY=$G(RX0),RX2=$G(RX2),RXSTA=$G(RXSTA),RREF0=$G(RREF0),RPAR0=$G(RPAR0),ROR1=$G(ROR1),RSIG=$G(RSIG),RSIG1=$G(RSIG1)
 K ^UTILITY("DIQ1",$J) S DA=$P($$SITE^VASITE(),"^")
 I $G(DA) S DIC=4,DIQ(0)="I",DR="99" D EN^DIQ1 S PSOINST=$G(^UTILITY("DIQ1",$J,4,DA,99,"I")) K ^UTILITY("DIQ1",$J),DA,DR,DIC
 S RXN=$P(RXY,"^"),DFN=$G(PSODFN),PSOLBLPS=+$P(RXY,"^",3),PSOLBLDR=+$G(LOCDRUG)
 S ISD=$P(RXY,"^",13),RXF=0,SIG=$P($G(RSIG),"^"),ISD=$E(ISD,4,5)_"/"_$E(ISD,6,7)_"/"_($E(ISD,1,3)+1700),ZY=0,$P(LINE,"_",28)="_"
 S NURSE=$S($P($G(^DPT(DFN,"NHC")),"^")="Y":1,$P($G(^PS(55,DFN,40)),"^"):1,1:0)
 S FDT=$P(RX2,"^",2),PS=$S($D(^PS(59,PSOSITE,0)):^(0),1:""),PS1=$S($D(^(1)):^(1),1:""),PSOSITE7=$P(^("IB"),"^")
 S PS2=$P($G(HINFO),"^")_"^"_$P($G(HINFO),"^",4)
 S EXPDT=$P(RX2,"^",6),EXDT=$S('EXPDT:"",1:$E(EXPDT,4,5)_"/"_$E(EXPDT,6,7)_"/"_($E(EXPDT,1,3)+1700))
 S COPIES=$S($P(RXY,"^",18)]"":$P(RXY,"^",18),1:1)
 K PSOCKHNX S PSOCKHL=$L(RX),PSOCKHN=$E($G(PSOCKHN),(PSOCKHL+2),999) D  K PSOCKHNX,PSOCKHL,PSOCKHA
 .S PSOCKHA=","_RX_","
 .I PSOCKHN'[PSOCKHA Q
 .S PSOCKHA=$E(PSOCKHA,1,($L(PSOCKHA)-1))
 .S PSOCKHNX=$L(PSOCKHN,PSOCKHA)-1
 .I +$G(PSOCKHNX)>0 D DOUB
 I '$G(RXP) D OSET
 I '$G(RXP) D  G STA
 . I '$G(RRXFL(RX)) S XTYPE=1 D REF
 I $G(RXP) S XTYPE="P" D REF G STA
ORIG S TECH=$P(RXY,"^",16),PHYS=$S($P(RXY,"^",4)'="":$P(RXY,"^",4),1:"UKN")
 S DAYS=$P(RXY,"^",8),QTY=$P(RXY,"^",7)
 D 6^VADPT,PID^VADPT6 S SSNPN=""
STA ;
 S HINFOST=$P($P(HINFO,U,2),"~",4)
 S STATE=$S($G(HINFOST)'="":HINFOST,1:"UKN")
 S DRUG=$$ZZ($G(LOCDRUG)),DEA=$P($G(^PSDRUG(+$G(LOCDRUG),0)),"^",3),WARN=$P($G(^(0)),"^",8)
 S WARN=$$DRUG^PSSWRNA(+$G(LOCDRUG),+$G(DFN))
 I $G(PARIEN) S RXPI=$G(PARIEN) D
 .S RXP=$G(RPAR0)
 .S RXY=$P(RXP,"^")_"^"_$P(RXY,"^",2,6)_"^"_$P(RXP,"^",4)_"^"_$P(RXP,"^",10)_"^"_$P(RXY,"^",9)_"^"_$P($G(RSIG),"^",2)_"^"_$P(RXP,"^",2)_"^"_$P(RXY,"^",12,14)_"^"_$P(RXSTA,"^")_"^"_$P(RXP,"^",7)_"^"_$P(RXY,"^",17,99)
 .S FDT=$P(RXP,"^")
 S MW=$P(RXY,"^",11) I $G(RRXFL(RX))'=0 D:$G(RRXFL(RX))  I '$G(RRXFL(RX)) S RXF=$P(RX0,"^",9) S:'$G(RXP) MW=$P(RREF0,"^",2) S FDT=+$G(RREF0)
 .I $G(RRXFL(RX)),'$L(RREF0) K RRXFL(RX) Q
 .;PSO*7*266
 .S RXF=RRXFL(RX) S:'$G(RXP) MW=$P($G(RREF0),"^",2) S FDT=+$G(RREF0)
 ; always 'W' for oneva pharmacy
 S MW="W"
 ;New mail codes for CMOP
 S MAILCOM=""
 S X=$G(^PS(55,DFN,0)),PSCAP=$P(X,"^",2),PS55=$P(X,"^",3),PS55X=$P(X,"^",5)
 I PS55X]"",PS55>1,PS55X<DT S PS55=0
 I $$GET1^DIQ(52,RX,100.2,"I")]"" S PS55=$$GET1^DIQ(52,RX,100.2,"I"),PS55X="" ;p753
 S MW=$S(MW="M":"REGULAR",MW="R":"CERTIFIED",1:"WINDOW")
 I $G(PSMP(1))="",$G(PS55)=2 S PSMP(1)=$G(SSNPN)
 S DATE=$E(FDT,1,7),REF=$P(RXY,"^",9) S:REF<1 REF=0 D PSOLBL2
 S PSOLASTF=$P(RX3,"^")
 S:$L(PSOLASTF) PSOLASTF=$E(PSOLASTF,4,5)_"/"_$E(PSOLASTF,6,7)_"/"_$E(PSOLASTF,2,3)
 I '$L(PSOLASTF) S PSOLASTF="N/A"
 S (X,PSOFLAST)=$G(PSOLASTF) I X?1N.E D ^%DT X ^DD("DD") S PSOFLAST=Y
 S PATST=$G(PATST)
 I PATST]"",$D(^PS(53,"C",PATST)) S PATSTIEN=$O(^PS(53,"C",PATST,0))
 I $G(PATSTIEN) S PATST=$G(^PS(53,PATSTIEN,0))
 S PRTFL=1 I REF=0 S:('$P(PATST,"^",5))!(DEA["W")!(DEA[1)!(DEA[2) PRTFL=0
 S VRPH=$P(RX2,"^",10),PSCLN=$S($P($G(HINFO),U,5)]"":$P(HINFO,U,5),1:"OneVA")
 S PATST=$P(PATST,"^",2),X1=DT,X2=$P(RXY,"^",8)-10 D C^%DTC:REF I $D(RX2),$P(RX2,"^",6),REF,X'<$P(RX2,"^",6) S REF=0,VRPH=$P(RX2,"^",10)
 I $G(RXP) S COPAYVAR="" G LBL
 I $P(RXSTA,"^")>0,$P(RXSTA,"^")'=2,'$G(PSODBQ) D SNO G LBL
LBL I $G(PSOIO("LLI"))]"" X PSOIO("LLI")
LBL2 S PSOINT=0 G ^PSORLLL1
REF S TECH=$S(XTYPE=1:$P($G(RREF0),"^",7),XTYPE="P":$P($G(RPAR0),"^",7),1:"UNKNOWN")
 S QTY=$S(XTYPE=1:$P(RREF0,U,4),XTYPE="P":$P(RPAR0,U,4),1:"")
 I XTYPE=1 S PHYS=$S($P($G(RREF0),"^",17)]"":$P($G(RREF0),"^",17),1:"UNKNOWN")
 I XTYPE="P" S PHYS=$S($P($G(RPAR0),"^",17)]"":$P($G(RPAR0),"^",17),1:"UNKNOWN")
 S DAYS=$S(XTYPE=1:$P(RREF0,U,10),XTYPE="P":$P(RPAR0,U,10),1:"")
 Q
CHECK ; use DFN from ZTSAVE instead of from RX
 S PSDFNFLG=0,PSOZERO=$P(RPPL,","),PSOPDFN=$G(DFN)
 Q
OSET ;
 N A
 I $G(RRXFL(RX))']""!($G(RRXFL(RX))=0) D  Q
 .S A=$G(RX0)
 .S TECH=$P(A,"^",16),QTY=$P(A,"^",7),PHYS=$S($P(A,"^",4)]"":$P(A,"^",4),1:"UKN") D 6^VADPT,PID^VADPT6 S SSNPN=""
 .S DAYS=$P(A,"^",8)
 I $G(RREF0)']"" K RRXFL(RX) Q
 S A=$G(RREF0)
 S TECH=$S($P(A,"^",7)]"":$P(A,"^",7),1:"UNKNOWN")
 S QTY=$P(A,"^",4),PHYS=$S($P(A,"^",17)]"":$P(A,"^",17),1:"UNKNOWN") D 6^VADPT,PID^VADPT6 S SSNPN=""
 S DAYS=$P(A,"^",10)
 Q
DOUB ;
 Q:'$D(RRXFL(RX))
 I +$G(RRXFL(RX))-PSOCKHNX<0 Q
 S RRXFLX(RX)=$G(RRXFL(RX))
 S RRXFL(RX)=$G(RRXFL(RX))-PSOCKHNX
 Q
SNO ;
 S COPAYVAR="NO COPAY"
 Q
ZZ(LDIEN) ; Returns VA print name, Trade Name, Generic Name
 S I50=LDIEN,ZDRUG=$P(^PSDRUG(I50,0),U)
 I $G(ZDRUG)']"" S ZDRUG="DRUG NOT ON FILE ("_I50_")" G END
 I $D(^PSDRUG("AQ",I50)),($D(^PSDRUG(I50,"ND"))) D
 .S Z1=$P($G(^PSDRUG(I50,"ND")),U),Z2=$P($G(^("ND")),U,3)
 .I $G(Z1),($G(Z2)) D
 ..I $T(^PSNAPIS)]"" S PSOXN=$$PROD2^PSNAPIS(Z1,Z2) S ZDRUG=$P($G(PSOXN),"^") K PSOXN Q
 ..S ZDRUG=$P($G(^PSNDF(Z1,5,Z2,2)),"^")
 .K Z1,Z2,I50
END K I50
 Q ZDRUG
 ; copy of PSOLBL2 logic
PSOLBL2 ;
 ;I $P($G(SIG),"^",2) K SGY D PSOLBL3 G SIGOLD
 I $P($G(RSIG),"^")]"" S SIG=$P($G(RSIG),"^") D SIG Q
 S SIGDONE=0
 F I=1:1 D  Q:SIGDONE
 .I '$D(RSIG1(I)) S SIGDONE=1 Q
 .I '$L(SIG) S SIG=$G(RSIG1(I)) Q
 .S SIG=$G(SIG)_" "_$G(RSIG1(I))
 D SIG
QUIT K SIG,E,F,S Q
SIG K OT S SGY="" F P=1:1:$L(SIG," ") S X=$P(SIG," ",P) D:X]""
 .I $D(^PS(51,"A",X)) D
 ..;PSO*7*282 Intended use
 ..I $P($G(^PS(55,DFN,"LAN")),"^") S OT=$O(^PS(51,"B",X,0)) I OT,$P($G(^PS(51,OT,0)),"^",4)<2,$P($G(^PS(51,OT,4)),"^")]"" S X=$P(^PS(51,OT,4),"^") K OT Q
 ..S %=^PS(51,"A",X),X=$P(%,"^") I $P(%,"^",2)]"" S Y=$P(SIG," ",P-1),Y=$E(Y,$L(Y)) S:Y>1 X=$P(%,"^",2)
 .S SGY=SGY_X_" "
 S X="",SGC=1 F J=1:1 S Z=$P(SGY," ",J) S:Z="" SGY(SGC)=X Q:Z=""  S:$L(X)+$L(Z)'<$S($P(PSOPAR,"^",28):46,1:34) SGY(SGC)=X,SGC=SGC+1,X="" S X=X_Z_" "
SIGOLD I '$P(PSOPAR,"^",28) D  K NHC
 .K DIC,DR,DIQ,NHC S DIC=2,DA=DFN,DR=148,DIQ="NHC",DIQ(0)="I"
 .D EN^DIQ1 K DIC,DR,DIQ
 .I NHC(2,DFN,148,"I")="Y"!($P($G(^PS(55,DFN,40)),"^")) S SGC=SGC+1,SGY(SGC)="Expiration:________ Mfg:_________"
 ;
DPT S X=$S($D(^DPT(DFN,0))#2:^(0),1:""),DOB=$P(X,"^",3),L=$E(X,1)
 S Y=$P(X,"^",9),PNM=$P(X,"^") D PID^VADPT S SS="",SSNP=""
 I $P(PSOPAR,"^",28) K SIG,E,F,S Q
 Q
 ;--- end PSOLBL2 LOGIC
PSOLBL3 ;
 N CTCT,FFFF,LLIM,LLLL,LVAR,LVAR1,PPP,PPPP,SGCT,SIG9,OSIG,ZZZZ,PSLONG,PPPP
 S PSLONG=$S($P(PSOPAR,"^",28):46,1:34)
 ; NEXT LINE IF SIG IS MOVED BACK TO MULTIPLE
 S PPPP=1 F PPP=0:0 S PPP=$O(RSIG1(PPP)) Q:'PPP  I $G(RSIG1(PPP))'="" S SIG9(PPPP)=$G(SIG1("SIG1",PPP)) S PPPP=PPPP+1
 ;NEXT LINE IF 1ST FRONT DOOR SIG LINE LIVES IN BACK DOOR SPOT
 ;S SIG9(1)=$P($G(^PSRX(RX,"SIG")),"^") S PPP=2 F PPPP=0:0 S PPPP=$O(^PSRX(RX,"SIG1",PPPP)) Q:'PPPP  I $G(^(PPPP,0))'="" S SIG9(PPP)=$G(^(0)),PPP=PPP+1
FMSIG S (LVAR,LVAR1)="",LLLL=1
 F FFFF=0:0 S FFFF=$O(SIG9(FFFF)) Q:'FFFF  S SGCT=0 F ZZZZ=1:1:$L(SIG9(FFFF)) I $E(SIG9(FFFF),ZZZZ)=" "!($L(SIG9(FFFF))=ZZZZ) S SGCT=SGCT+1 D  I $L(LVAR)>PSLONG S SGY(LLLL)=LLIM_" ",LLLL=LLLL+1,LVAR=LVAR1
 .S LVAR1=$P(SIG9(FFFF)," ",(SGCT))
 .S LLIM=LVAR
 .S LVAR=$S(LVAR="":LVAR1,1:LVAR_" "_LVAR1)
 I $G(LVAR)'="" S SGY(LLLL)=LVAR
 I '$P(PSOPAR,"^",28) S SGC=0 F CTCT=0:0 S CTCT=$O(SGY(CTCT)) Q:'CTCT  S SGC=SGC+1
 I $O(OSGY(0)) D
 .F I=0:0 S I=$O(SGY(I)) Q:'I  I $G(OSGY(I))']"" S OSGY(I)=" "
 .F I=0:0 S I=$O(OSGY(I)) Q:'I  I $G(SGY(I))']"" S SGY(I)=" "
 Q
 ;
OPAI ; OPAI interface for One-Va prescriptions
 N PSOOLAN,PSOOTLAN,PSOND1,PSOND2,PSOND3,PSOXN2,DDNS,DPORT,OPADD,DFN,PSODFN,PSOLLNM,PAS,PAS3,PSI,HLECH,CS,RS,EC,SCS,DTME,PSODTM,PSOENH,PSOADD,PSONEADS,PSONECT,PSONECTC
 S (DFN,PSODFN)=$G(PSOHLSV("PATIENT DFN")) Q:'PSODFN
 S PSOLDRUG=$G(PSOHLSV("L_DRUGIEN")) I 'PSOLDRUG Q
 S PSOLLNM=$P($G(^PSDRUG(PSOLDRUG,0)),"^")
 S PSOND1=$P($G(^PSDRUG(PSOLDRUG,"ND")),"^"),PSOND2=$P($G(^("ND")),"^",2),PSOND3=$P($G(^("ND")),"^",3)
 I PSOND1,PSOND3 S PSOXN2=$$PROD2^PSNAPIS(PSOND1,PSOND3)
 S PSOOLAN=$P($G(^PS(55,DFN,"LAN")),"^",2),PSOOTLAN="N" I PSOOLAN=2 S PSOOTLAN="Y"
 K PAS,PAS3
 S PSOHLINX=$$GETAPP^HLCS2("PSO VISTA") Q:$P($G(PSOHLINX),"^",2)="i"
 K ^TMP("PSO",$J)
 S PIEN=$O(^ORD(101,"B","PSO EXT SERVER",0)) Q:'PIEN
 S PSI=1,HLPDT=DT D INIT^HLFNC2(PIEN,.HL1) I $G(HL1) Q
 S FS=HL1("FS"),HL1("ECH")="~^\&",HLECH=HL1("ECH"),CS=$E(HL1("ECH")),RS=$E(HL1("ECH"),2),EC=$E(HL1("ECH"),3),SCS=$E(HL1("ECH"),4)
 D NOW^%DTC S (DTME,PSODTM)=%
 S DDNS=$$GET1^DIQ(59,PSOSITE_",",2006)
 ;NO NEED FOR TMP(PSOMID) ONLY STORING IN 52.51
 S PSONECT=1,PSONECTC=0
 S PSOENH=0,^UTILITY($J,"PSOPAI")=IOS D GETDEV^PSOHLDS,ALLADD^PSOHLDS ;sets up OPADD array
 K ^UTILITY($J,"PSOPAI") S PSOADD=""
 I PSOENH S PSONEADS=1 D CHKCAT^PSOHLDS K PSONEADS I PSOADD="" Q
 I PSOADD="" S PSOADD=DDNS
 S PSI=$P(OPADD(PSOADD),"^",2) I PSI="" S PSI=1 K PAS,PAS3
 D PID^PSOHLDS5(.PSI),PV1^PSOHLDS5(.PSI),PV2^PSOHLDS5(.PSI),IAM^PSOHLDS4(.PSI),ORC^PSOHLDS5(.PSI),NTE1^PSOHLDS5(.PSI),NTE2^PSOHLDS5(.PSI),NTE3^PSOHLDS5(.PSI)
 D NTE4^PSOHLDS5(.PSI),RXE^PSOHLDS5(.PSI),RXD^PSOHLDS5(.PSI)
 D NTEPMI^PSOHLDS5(.PSI)
 D NTE9^PSOHLDS2(.PSI)
 D RXR^PSOHLDS5(.PSI)
 D ZZZ^PSOHLDS5(.PSI)
 M ^TMP("PSOADD",$J,PSOADD)=^TMP("PSO",$J) S $P(OPADD(PSOADD),"^",2)=PSI
 I $D(ADDCAT("S")) D STRAGE^PSOHLDS
 K ^TMP("PSO",$J)
 I $D(ADDCAT("S")) D MORSTG^PSOHLDS
 S DDNS="" F  S DDNS=$O(^TMP("PSOADD",$J,DDNS)) Q:DDNS=""  D
 .K ^TMP("HLS",$J)
 .M ^TMP("HLS",$J)=^TMP("PSOADD",$J,DDNS)
 .S DPORT=$P(OPADD(DDNS),"^")
 .K HLP,HLMID,HLERR,HLRESLT
 .S HLP("CONTPTR")="",HLP("SUBSCRIBER")="^^^^~"_DDNS_":"_DPORT_"~DNS"
 .D GENERATE^HLMA(PIEN,"GM",1,.HLRESLT,"",.HLP)
 .K HLL S HLMID=$P($G(HLRESLT),"^"),HLERR=$P($G(HLRESLT),"^",2)
 .I '$G(HLMID)!($P($G(HLERR),"^")'="") D  Q
 ..S XQAMSG="Error transmitting OneVa Rx "_$G(PSOHLSV("RX NUMBER"))_"to external interface"_$S(PSOENH:" TO "_DDNS,1:"") D ALERT^PSOHLDS Q
 .I HLMID'="",$G(PSOHLSV("RX LOG IEN"))'="" D
 ..S $P(^PSRXR(52.09,PSOHLSV("RX LOG IEN"),4),"^")=HLMID
 ..S ^PSRXR(52.09,"F",HLMID,PSOHLSV("RX LOG IEN"))=""
 ..S $P(^PSRXR(52.09,PSOHLSV("RX LOG IEN"),4),"^",3)=$G(OPNAM(DDNS))
 ..S $P(^PSRXR(52.09,PSOHLSV("RX LOG IEN"),4),"^",4)=$G(DDNS)
 ..I PSONECTC>1 S $P(^PSRXR(52.09,PSOHLSV("RX LOG IEN"),4),"^",5)=1
 ;IS ACK+13^PSOHLDS CHECK STILL VALID
 Q
 ;
ACK ;Process ack from OPAI dispense for a OneVa fill, called from PSOHLDS
 N PSOPAID,PSOAI,PSOORC,PSORXD,PSOPID,PSOFILPR,PSOCHKPH,PSOHLOT,PSODEXP,PSOHMAN,PSOHNDC
 S PSOPAID("IEN")=$O(^PSRXR(52.09,"F",SMID,0)) Q:'$G(PSOPAID("IEN"))
 F PSOAI=0:0 S PSOAI=$O(PSOMSG(PSOAI)) Q:'PSOAI  D
 .I $P(PSOMSG(PSOAI),"|")="PID" S PSOPID=PSOMSG(PSOAI) Q
 .I $P(PSOMSG(PSOAI),"|")="ORC" S PSOORC=PSOMSG(PSOAI) Q
 .I $P(PSOMSG(PSOAI),"|")="RXD" S PSORXD=PSOMSG(PSOAI) Q
 ;
 ;Set data in PSOPAID array
 S PSOPAID("RX")=$P($P($G(PSOORC),"|",3),"^")
 S PSOFILPR=$P($P($G(PSOORC),"|",11),"~"),PSOPAID("PSOFILPR")=$$GET1^DIQ(200,PSOFILPR,.01,"E")
 S PSOPAID("PSOFILPR")=$E(PSOPAID("PSOFILPR"),1,45)
 S PSOCHKPH=$P($P($G(PSOORC),"|",12),"~"),PSOPAID("PSOCHKPH")=$$GET1^DIQ(200,PSOCHKPH,.01,"E")
 S PSOPAID("PSOCHKPH")=$E(PSOPAID("PSOCHKPH"),1,45)
 S PSOHLOT=$P($P($G(PSORXD),"|",19),"^")
 S PSODEXP=$P($P($G(PSORXD),"|",20),"^")
 S PSOHMAN=$P($P($G(PSORXD),"|",21),"^")
 S PSOHMAN=$E(PSOHMAN,1,50)
 S PSOHNDC=$P($P($G(PSORXD),"|",10),"^")
 ;set fields from rxd, and get 52.09 ien, refill or partial, and associated sub-ien, and DOMOVR send back message and process
 D UPD
 D SEND^PSOHLDS5
 D ACKK
 Q
 ;
ACKK ;
 K HL,AACK,DTM,ETN,CMID,MTN,RAN,SAN,VER,EID,EIDS,FS,ORC,PSOMSG,HLQUIT,HLNODR,MSACDE,SMID,ERRMSG,PSOFNHL7
 Q
 ;
UPD ;Update File 52.09 at dispensing site
 S $P(^PSRXR(52.09,PSOPAID("IEN"),0),"^",11)=$G(PSOPAID("PSOFILPR"))
 S $P(^PSRXR(52.09,PSOPAID("IEN"),0),"^",12)=$G(PSOPAID("PSOCHKPH"))
 Q
