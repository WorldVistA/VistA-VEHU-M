ASFPSODM ; Albany/XAK,MJK - PATIENT DEMOGRAPHICS ; 03/20/92 14:45
 ;;5.6;Outpatient Pharmacy;**46**; MODIFIED GDM LINES 'RE' AND 'MA+2:6' TO DISPLAY FEE CARD AND OTHER ELIGIBILITIES- LABEL 'OTHEL' ADDED-LOCAL COPY OF PSODEM
GET S DFN=DA
 S Y(0)=^DPT(DFN,0),Y(.11)=$S($D(^(.11)):^(.11),1:""),Y(.13)=$S($D(^(.13)):^(.13),1:""),I=+$P(Y(0),U,3)
 S TEMP="" I $D(^DPT(DFN,.121)),$P(^(.121),"^",1)]"" S TMPDT=$S($P(^(.121),"^",8):$P(^(.121),"^",8),$P(^(.121),"^",7):9999999,1:0) I DT'<$P(^(.121),"^",7),DT'>TMPDT S TEMP=1,Y(.11)=^(.121)
 W #!,$P(Y(0),U,1),?40,"SSN:   ",$P(Y(0),U,9)
 I TEMP S Y=$S($P(^DPT(DFN,.121),"^",7):$P(^(.121),"^",7),1:"UNKNOWN") X:Y ^DD("DD") W !?5,"(TEMP ADDRESS from "_Y S Y=$S($P(^DPT(DFN,.121),"^",8):$P(^(.121),"^",8),1:"UNKNOWN") X:Y ^DD("DD") W " till "_Y_")"
 W !,$P(Y(.11),U,1),?40,"DOB:   ",$S(I:$E(I,4,5)_"-"_$E(I,6,7)_"-"_(1700+$E(I,1,3)),1:"UNKNOWN")
 W !,$P(Y(.11),U,4),?40,"PHONE: " S I=$P(Y(.13),"^",1) W I I I?3N W "-",$P(Y(.13),"^",2)
 W !,$S($D(^DIC(5,+$P(Y(.11),U,5),0)):$P(^(0),U,1),1:"")
 W "  ",$P(Y(.11),U,6),?40,"ELIG:  " I $D(^DPT(DFN,.36)),$D(^DIC(8,+^(.36),0)) S SC=$P(^(0),"^",1) W SC
 I $D(^PS(55,DFN,0)),+$P(^(0),"^",2) W !,"CANNOT USE SAFETY CAPS." I +$P(^(0),"^",4) W ?40,"DIALYSIS PATIENT."
 I $D(^(1)),^(1)]"" S X=^(1) W !!?5,"Pharmacy narrative: " F I=1:1 Q:$P(X," ",I,99)=""  W $P(X," ",I)," " W:$X>75 !
RE S (PSLC,ZFCRD)=0 G MA:'$D(^DPT(DFN,.17)) G MA:$P(^(.17),"^",2)'="I" S ZFCRD=1
 I '$D(SC),$D(^DPT(DFN,.36)),$D(^DIC(8,+^(.36),0)) S SC=$P(^(0),"^",1) W !!,"ELIGIBILITY: ",SC S PSLC=PSLC+2
MA K SC W !,"DISABILITIES: " S PSLC=PSLC+2
 F I=0:0 S I=$N(^DPT(DFN,.372,I)) Q:I'>0  S I1=$S($D(^(I,0)):^(0),1:""),PSDIS=$S($D(^DIC(31,+I1,0)):$P(^(0),"^",1),1:""),PSCNT=$P(I1,"^",2) X:($X+$L(PSDIS)+7)>72 "W !?10 S PSLC=PSLC+1" W PSDIS,"-",PSCNT,"% (",$S($P(I1,"^",3):"SC",1:"NSC"),"), "
 D ^ASFSHOTF
 S PI="",LMI=$S($D(^DPT(DFN,"PI")):^("PI"),1:0),LMI=(LMI="Y"!LMI) W ! W:ZFCRD ?50,"**** FEE CARD ISSUED ****" D OTHEL ;W !,"REACTIONS: ",$S(LMI=1:"",1:"UNKNOWN") S PSLC=PSLC+1 G END:'LMI,MF:'$D(^DPT(DFN,"PA"))
 ;S I1=0 F I=1:1 S I1=$N(^DPT(DFN,"PA",I1)) Q:I1'>0  S AL=^DIC(57,I1,0) X:$X+$L(AL)>75 "W !?5 S PSLC=PSLC+1" W AL,", "
 X "N X S X=""GMRADPT"" X ^%ZOSF(""TEST"") Q" I $T D GMRA G Q
MF I $D(^DPT(DFN,"PF")) S I1=0 F I=1:1 S I1=$N(^DPT(DFN,"PF",I1)) Q:I1'>0  I $D(^PS(50.5,I1,0)) S AL=$P(^(0),"^",1) X:$X+$L(AL)>75 "W !?5 S PSLC=PSLC+1" W AL,", "
MG G END:'$D(^DPT(DFN,"PG")) S I1=0 F I=1:1 S I1=$N(^DPT(DFN,"PG",I1)) Q:I1'>0  S AL=$P(^PSDRUG(I1,0),U,1) X:$X+$L(AL)>75 "W !?5 S PSLC=PSLC+1" D:$Y>21 END G Q:PI="^" W AL,", "
END Q:$D(FN)  W !!,"PRESS '^' TO HALT: " R PI:DTIME S:'$T PI="^" S PSLC=0 W #!
Q K SC,Y,LMI,TEMP,TMPDT Q
GMRA W !!,"REACTIONS: " D ^GMRADPT S I1=0 F I=0:0 S I=$O(GMRAL(I)) Q:I'>0  W:I1 ", " S AL=$P(GMRAL(I),U,2) W:$X+$L(AL)>75 !?5 W AL S I1=1
 K GMRA,GMRAL Q
OTHEL W !,"Other Eligibilities: " S ASFEL="" F I=0:0 S ASFEL=$O(^DPT("AEL",DFN,ASFEL)) Q:ASFEL=""  W "    ",$P(^DIC(8,ASFEL,0),"^",1)
 K ASFEL Q
