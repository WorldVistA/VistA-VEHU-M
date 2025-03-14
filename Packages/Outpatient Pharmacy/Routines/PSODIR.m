PSODIR ;BHAM ISC/SAB - asks data for rx order entry ;Oct 20, 2022@17:03
 ;;7.0;OUTPATIENT PHARMACY;**37,46,111,117,146,164,211,264,275,391,372,416,422,504,457,572,587,441,682,545**;DEC 1997;Build 270
 ;External reference PSDRUG( supported by DBIA 221
 ;External reference PS(50.7 supported by DBIA 2223
 ;External reference to VA(200 is supported by DBIA 10060
 ; Reference to ^XTV(8991.9) in ICR #7002
 ; Reference to ^VA(200.5321) in ICR #7000
 ;----------------------------------------------------------------
 ;
PROV(PSODIR) ;
PROVEN ; Entry point for failed lookup
 K DIC,X,Y S:$G(PSOFDR)&($G(OR0)) DIC("B")=$P(^VA(200,$P($G(OR0),"^",5),0),"^")
 I '$D(PSODIR("CS")),$D(PSODRUG("DEA")) D
 .N DEA S PSODIR("CS")=0 F DEA=1:1 Q:$E(PSODRUG("DEA"),DEA)=""  I $E(+PSODRUG("DEA"),DEA)>1,$E(+PSODRUG("DEA"),DEA)<6 S PSODIR("CS")=1
 I $G(PSODIR("PROVIDER"))]"" S PSODIR("OLD VAL")=PSODIR("PROVIDER")
 S DIC="^VA(200,",DIC(0)="QEAM",PSODIR("FIELD")=0
 S DIC("W")="W ""     "",$P($G(^(""PS"")),""^"",9)"
 S DIC("A")="PROVIDER: ",DIC("S")="I $D(^(""PS"")),$P(^(""PS""),""^""),$S('$P(^(""PS""),""^"",4):1,1:$P(^(""PS""),""^"",4)'<DT)"
 I $G(PSOTPBFG),$G(PSOFROM)="NEW" S DIC("S")=DIC("S")_",$P($G(^(""TPB"")),""^""),$P($G(^(""TPB"")),""^"",5)=0"
 ;p682 change condition for setting DIC("B"); do not overwrite
 ;S:$G(PSORX("PROVIDER NAME"))]"" DIC("B")=PSORX("PROVIDER NAME")
 S DIC("B")=$S($G(DIC("B"))]"":DIC("B"),1:$G(PSORX("PROVIDER NAME")))
 D ^DIC K DIC
 I X[U,$L(X)>1 D:'$G(PSOEDIT) JUMP G PROVX
 I $D(DTOUT)!$D(DUOUT) S PSODIR("DFLG")=1 G PROVX
 I '$G(SPEED),Y=-1 G PROVEN
 Q:$G(SPEED)&(Y=-1)
 L +^VA(200,+Y):1 I '$T D  G PROVEN ;572
 . N PSOED S PSOED=$P($G(^VA(200,+Y,1)),"^",8)
 . I PSOED W $C(7),!!,"Provider is being edited by "_$P($G(^VA(200,PSOED,0)),"^") Q  ;587
 . W $C(7),!!,"Provider is being edited by an unknown user or has been deleted"
 L -^VA(200,+Y) ;572
 ;PSO*7*211; ADD CHECK FOR DEA# AND VA#
 ;*545; DEA/VA selection
 I $$DETOX^PSSOPKI($G(PSODRUG("IEN"))) N DETX S DETX="" D  G:'$L(DETX) PROVEN
 . S DETX=$$DETOX^XUSER(+Y) I '$L(DETX) W $C(7),!!,"Provider must have a DETOX# to order this drug.",! Q
 . S PSORX("DETX")=DETX
 I $P($G(PSODIR("CS")),"^",1)!($D(CLOZPAT)) N NDEA D  I $L($P($G(NDEA),"^"))<3 G PROVEN
 . N SDEA S SDEA=$$DRGSCH()
 . N PSOPROVD S PSOPROVD=+Y S NDEA=$$SLDEA(PSOPROVD,.PSORX) Q
 . I NDEA=2 W $C(7),!!,"Provider not authorized to write Federal Schedule "_SDEA_" prescriptions." D  Q
 . . W !,"Please contact the provider.",!
 . W $C(7),!!,"Provider must have a valid DEA# or VA# to write prescriptions for this drug.",!
 . Q
 ;PSO*7.0*391; Added check for DETOX#
 I $$DETOX^PSSOPKI($G(PSODRUG("IEN"))),$$DETOX^XUSER(+Y)="" W $C(7),!!,"Provider must have a DETOX# to order this drug.",! G PROVEN
 I $D(CLOZPAT),'$D(^XUSEC("YSCL AUTHORIZED",+Y)) D  G PROVEN
 .W $C(7),!!,$$CLKEYWRN^PSOCLUTL,!  ; PSO*7*457
 I '$G(PSODRUG("IEN")),'$G(PSORENW("DRUG IEN")) G NODRUG
NODRUG S PSODIR("PROVIDER")=+Y
 S (PSODIR("PROVIDER NAME"),PSORX("PROVIDER NAME"))=$P(Y,"^",2)
 I $G(PSODIR("OLD VAL"))'=+Y K PSODIR("GENERIC PROVIDER"),PSODIR("COSIGNING PROVIDER")
 I $G(PSODIR("OLD VAL"))'=$G(PSODIR("PROVIDER")),$P(Y,"^",2)="PROVIDER,OTHER"!($P(Y,"^",2)="PROVIDER,OUTSIDE") D GENERIC
 I $P(^VA(200,PSODIR("PROVIDER"),"PS"),"^",7),$P(^("PS"),"^",8) D COSIGN
 I $G(PSODIR("COSIGNING PROVIDER")),'$P(^VA(200,PSODIR("PROVIDER"),"PS"),"^",7) K PSODIR("COSIGNING PROVIDER")
PROVX K X,Y
 Q
 ;
DRGSCH() ; determine the drug schedule
 N ND3,SCH
 S SCH="",ND3=$P($G(^PSDRUG(PSODRUG("IEN"),"ND")),"^",3) S:+ND3 SCH=$$GET1^DIQ(50.68,ND3,19,"I")
 I +SCH>0!($G(PSODRUG("DEA"))="") Q SCH
 I "^4^5^"[+PSODRUG("DEA") Q +PSODRUG("DEA")
 Q $S($G(PSODRUG("DEA"))["A":+PSODRUG("DEA"),1:+PSODRUG("DEA")_"n")
 ;
GENERIC ;
 K DIR,DIC,PSODIR("GENERIC PROVIDER")
 S DIR(0)="52,30"
 D DIR G:PSODIR("DFLG")!PSODIR("FIELD") GENERICX
 S PSODIR("GENERIC PROVIDER")=Y
GENERICX K X,Y
 Q
 ;
COSIGN ;
 K DIC
 I '$G(PSODIR("COSIGNING PROVIDER")),$P($G(RX3),"^",3) S PSODIR("COSIGNING PROVIDER")=$P(RX3,"^",3) G COSIGN1
 I $P($G(RX3),"^",3),$P($G(RX3),"^",3)'=$P(^VA(200,PSODIR("PROVIDER"),"PS"),"^",8) D
 .W !!,"Previous Co-Signing Provider: "_$P(^VA(200,$P(RX3,"^",3),0),"^")
 .S PSODIR("COSIGNING PROVIDER")=$S($P(RX3,"^",3)'=PSODIR("COSIGNING PROVIDER"):PSODIR("COSIGNING PROVIDER"),1:$P(^VA(200,PSODIR("PROVIDER"),"PS"),"^",8))
COSIGN1 S DIC(0)="QEAM",DIC="^VA(200,",DIC("B")=$S($G(PSODIR("COSIGNING PROVIDER")):$P(^VA(200,PSODIR("COSIGNING PROVIDER"),0),"^"),1:$P(^VA(200,PSODIR("PROVIDER"),"PS"),"^",8))
 S DIC("S")="I $D(^(""PS"")),$P(^(""PS""),""^""),$S('$P(^(""PS""),""^"",4):1,1:$P(^(""PS""),""^"",4)'<DT)"
 S DIC("W")="W ""     "",$P(^(""PS""),""^"",9)",DIC("S")=DIC("S")_",'$P(^(""PS""),""^"",7)"
 S DIC("A")="COSIGNING PROVIDER: " D ^DIC K DIC
 I $D(DTOUT)!$D(DUOUT) S PSODIR("DFLG")=1 G COSIGNX
 S:+Y>0 PSODIR("COSIGNING PROVIDER")=+Y G:Y<0 COSIGN
COSIGNX K X,Y
 Q
DOSE(PSODIR) ;add dosing info
 N PSODOSNW S PSODOSNW=1
 D DOSE1^PSOORED5(.PSODIR)
EX K PSODOSE,PSOSCH,DOSE,DOOR,SCH,VERB,NOUN,DOSEOR,ENT,PSORTE,DRUA,DIR,X,Y,DIRUT,RTE,ERTE,DD,INS1,SINS1
 Q
INS(PSODIR) ;patient instructions
 N DA
 K INS1,DD,DIR,DIRUT S D=0 F  S D=$O(PSODIR("SIG",D)) Q:'D  S DD=$G(DD)+1
 I $G(DD)=1 S PSODIR("INS")=$G(PSODIR("SIG",1)) G INSD
 ;PSO*7*275 remove check for PSOINSFL just check for multi line sig
 I $G(DD)>1 D  G EX
 .K ^TMP($J) S D=0 F  S D=$O(PSODIR("SIG",D)) Q:'D  S ^TMP($J,"SIG",D,0)=PSODIR("SIG",D)
 .S DWPK=2,DWLW=80,DIC="^TMP($J,""SIG""," D EN^DIWE K PSODIR("SIG")
 .S D=0 F  S D=$O(^TMP($J,"SIG",D)) Q:'D  S PSODIR("SIG",D)=^TMP($J,"SIG",D,0)
 .D:'$P($G(^PS(55,PSODFN,"LAN")),"^") INDICAT^PSODIR(.PSODIR)
 .D EN^PSOFSIG(.PSODIR,1) K DWLW,D,DWPK,^TMP($J)
 I $G(PSOINSFL)=0 G INSD
 I $G(PSOFDR),$G(ORD),$P($G(^PS(52.41,+$G(ORD),"EXT")),"^")'="" G INSD
 I $G(PSODIR("INS"))']"",$G(^PS(50.7,PSODRUG("OI"),"INS"))]"",'$D(PSODIR("FLD",114)) S (DIR("B"),PSOOEINS)=^PS(50.7,PSODRUG("OI"),"INS") G INSD  ;*422
 S (DIR("B"),PSOOEINS)=$G(PSODIR("SIG",1))  ;*422
INSD S DIR(0)="52,114" S:$G(PSODIR("INS"))]"" DIR("B")=PSODIR("INS")
 K PSODIR("DFLG")
 D DIR
 I $G(PSODIR("DFLG")) S (PSODIR("INS"),PSODIR("SIG"),PSODIR("SIG",1))=$G(PSOOEINS),PSODIR("SINS")=$G(PSOOSINS) D EN^PSOFSIG(.PSODIR,0)
 G:$G(PSODIR("DFLG"))!(PSODIR("FIELD")) EX
 I X'="",X'="@" S PSODIR("INS")=Y D SIG^PSOHELP G INSD:'$D(X)
 I $G(INS1)]"" D EN^DDIOL($E(INS1,2,9999999)) S (PSODIR("SIG",1),PSODIR("SIG"))=$E(INS1,2,9999999)
 I X="@" S PSODELINS=1 D DELINS^PSOHELP3 I $G(PSODELINS) S (PSODIR("FLD",114),PSODIR("FLD",114.1))="" K PSODIR("INS"),PSODIR("SIG"),PSODIR("SINS")  ;*422
 ;*441 - indication
 I '$P($G(^PS(55,PSODFN,"LAN")),"^") D INDICAT^PSODIR(.PSODIR) K DIRUT,DTOUT,DUOUT,DIROUT
 I '$G(PSOEDIT),$G(PSODIR("DFLG")) G EX
 D EN^PSOFSIG(.PSODIR,1) I $O(SIG(0)) S SIGOK=1
 G EX
 Q
SINS(PSODIR) ;other lang. patient instructions
 K SINS1,DIR
 S DIR(0)="52,114.1" S:$G(PSODIR("SINS"))]"" DIR("B")=PSODIR("SINS")
 I $G(PSODIR("SINS"))']"",$G(^PS(50.7,PSODRUG("OI"),"INS1"))]"",'$D(PSODIR("FLD",114)),$G(PSOOEINS)]"" S (DIR("B"),PSOOSINS)=^PS(50.7,PSODRUG("OI"),"INS1")
 D DIR I $G(PSODIR("DFLG")) S (PSODIR("INS"),PSODIR("SIG"),PSODIR("SIG",1))=$G(PSOOEINS),PSODIR("SINS")=$G(PSOOSINS) D EN^PSOFSIG(.PSODIR,0) G EX
 I X'="",X'="@" S PSODIR("SINS")=Y D SSIG^PSOHELP
 I $G(SINS1)]"" D EN^DDIOL($E(SINS1,2,9999999)) S PSODIR("SINS")=$E(SINS1,2,9999999)
 I X="@" S PSODELINS=2 D DELINS^PSOHELP3 I $G(PSODELINS) S (PSODIR("FLD",114),PSODIR("FLD",114.1))="" K PSODIR("INS"),PSODIR("SIG"),PSODIR("SINS") D EN^PSOFSIG(.PSODIR,1) ;*422
 G EX
 Q
 ;
DIR ;
 S PSODIR("FIELD")=0
 G:$G(DIR(0))']"" DIRX
 D ^DIR K DIR,DIE,DIC,DA
 I $D(DUOUT)!($D(DTOUT))!($D(DIROUT)),$L($G(X))'>1 S PSODIR("DFLG")=1 G DIRX
 I X[U,$L(X)>1 D:'$G(PSOEDIT) JUMP
DIRX K DIRUT,DTOUT,DUOUT,DIROUT,PSOX
 Q
 ;
JUMP ;
 I $G(PSOEDIT)!($G(OR0)) S PSODIR("DFLG")=1 Q
 S X=$P(X,"^",2),DIC="^DD(52,",DIC(0)="QM" D ^DIC K DIC
 I Y=-1 S PSODIR("FIELD")=$G(PSODIR("FLD")) G JUMPX
 I $G(PSONEW1)=0 D JUMP^PSONEW1 G JUMPX
 I $G(PSOREF1)=0 D JUMP^PSOREF1 G JUMPX
 I $G(PSONEW3)=0 D JUMP^PSONEW3 G JUMPX
 I $G(PSORENW3)=0 D JUMP^PSORENW3 G JUMPX
JUMPX S X="^"_X
 Q
 ;
INDICAT(PSODIR) ;*441
 N INDLST,DIR,SEL,I,INDCAT,CHK,CNT K DUOUT,DTOUT,DIROUT,DIRUT
 S (CHK,CNT,PSODIR("DFLG"),PSODIR("FIELD"))=0
 D INDCATN^PSS50P7(PSODRUG("OI"),"PSODIND")
 I '$O(^TMP($J,"PSODIND",0)) S Y=99 G INDICAT1
 S (SEL,I)="" F  S I=$O(^TMP($J,"PSODIND",I)) Q:I=""  D
 . S INDCAT=$P($G(^TMP($J,"PSODIND",I)),"^") Q:'$L(INDCAT)
 . I $G(PSODIR("IND"))]"",INDCAT=PSODIR("IND") S CHK=1
 . S CNT=CNT+1,INDLST(CNT)=INDCAT,DIR("L",CNT)="  "_CNT_"   "_INDCAT S:CNT=1 SEL=CNT_":"_INDCAT S:CNT>1 SEL=SEL_";"_CNT_":"_INDCAT
 W !!,"INDICATION:"
 K DIRUT,DTOUT,DUOUT,DIROUT
 S DIR(0)="SO^"_SEL_";99:Free Text entry",DIR("A")="Select INDICATION from the list"
 S DIR("L")="  99  Free Text entry"
 S:CHK DIR("B")=PSODIR("IND") S:'CHK&($G(PSODIR("IND"))]"") DIR("B")=99
 S DIR("?")="Answer must be 3-40 characters in length."
 S DIR("?",1)="This field contains the Indication For Use."
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) S PSODIR("DFLG")=1 Q
 I $G(PSOEDIT)!($G(PSOFDR))!($G(PSOCOPY)),X="" S:$G(PSODIR("IND"))]"" Y=99 G INDICAT1
 I X="@" N KF S KF=0 D:$G(PSOEDIT)!($G(PSOFDR))!($G(PSOCOPY))  K:'KF PSODIR("IND"),PSODIR("INDF"),PSODIR("INDO") Q
 . S PSODELINS=2,KF=1 D DELIND
 . I $G(PSODELINS) S (PSODIR("FLD",128),PSODIR("FLD",129),PSODIR("FLD",130))="" K PSODIR("IND"),PSODIR("INDF"),PSODIR("INDO")
 I Y=99 S:CHK PSODIR("IND")="" G INDICAT1
 I Y S PSODIR("IND")=Y(0) S:$G(PSOEDIT) PSODIR("FLD",128)=Y(0)
INDICAT1 ;
 I Y=99 N I,J,IND,DA D  G:$G(Y)=99 INDICAT1 Q:$G(PSODIR("DFLG"))!(X="")
 . K X,Y,DIRUT,DTOUT,DUOUT,DIROUT,DIR
 . S:$G(PSODIR("IND"))]"" DIR("B")=$G(PSODIR("IND"))
 . S DIR(0)="52,128",DIR("A")="INDICATION" D ^DIR
 . I $D(DUOUT)!($D(DTOUT)) S PSODIR("DFLG")=1 Q
 . I X="" S PSODIR("FLD",128)="" K PSODIR("IND") Q
 . I X="@" N KF S KF=0 D:$G(PSOEDIT)!($G(PSOFDR))!($G(PSOCOPY))  K:'KF PSODIR("IND"),PSODIR("INDF"),PSODIR("INDO") Q
 . . S PSODELINS=2,KF=1 D DELIND
 . . I $G(PSODELINS) S (PSODIR("FLD",128),PSODIR("FLD",129),PSODIR("FLD",130))="" K PSODIR("IND"),PSODIR("INDF"),PSODIR("INDO")
 . I $L(X," ")=1,$L(X)>32 W $C(7),!?5,"MAX OF 32 CHARACTERS ALLOWED WITHOUT SPACES.",! S Y=99 Q
 . S IND="" F I=1:1:$L(X," ") Q:I=""  S J=$P(X," ",I) D  I '$D(X) S Y=99 Q
 . .I $L(J)>32 W $C(7),!?5,"MAX OF 32 CHARACTERS ALLOWED BETWEEN SPACES.",! K X Q
 . .S:J]"" IND=$S($G(IND)]"":IND_" ",1:"")_J
 . Q:$G(Y)=99
 . S IND=$$UPPER^PSOSIG(IND),PSODIR("IND")=IND
 . I $L(IND) S:$G(PSOEDIT) PSODIR("FLD",128)=IND
 I $G(PSODIR("IND"))]"" D
 . W !,PSODIR("IND"),!
 . N DIR,PSOZ S PSOZ=$$GET1^DIQ(59.7,1,96),DIR("B")=$S(PSOZ]"":PSOZ,1:"YES")
 . S DIR(0)="Y",DIR("A")="Copy INDICATION into the Sig" D ^DIR
 . I $G(DIRUT) S PSODIR("DFLG")=1 Q
 . I Y>0 S PSODIR("INDF")=1 S:$G(PSOEDIT) PSODIR("FLD",129)=1
 . I 'Y S PSODIR("INDF")=0 S:$G(PSOEDIT) PSODIR("FLD",129)=""
 Q
 ;
SIND(PSODIR) ;
 S (PSODONE,PSODELINS)=0
 F  D  Q:PSODONE
 . D INDICAT^PSODIR(.PSODIR)
 . I $G(PSODIR("DFLG")) D  S PSODONE=1 Q
 . . I $G(PSODIR("IND"))="",$G(PSODIR("INDO"))="" Q
 . . I $G(PSODIR("IND"))]"",$G(PSODIR("INDO"))]"" Q
 . . I $G(PSODIR("IND"))]"",$G(PSODIR("INDO"))="" S PSODIR("IND")="" Q
 . . I $G(PSODIR("IND"))="",$G(PSODIR("INDO"))]"" S PSODIR("INDO")=""
 . Q:$G(PSODELINS)
 . D OIND
 . I $G(PSODIR("DFLG")) D  S PSODONE=1 Q
 . . I $G(PSODIR("IND"))="",$G(PSODIR("INDO"))="" Q
 . . I $G(PSODIR("IND"))]"",$G(PSODIR("INDO"))]"" Q
 . . I $G(PSODIR("IND"))]"",$G(PSODIR("INDO"))="" S PSODIR("IND")="" Q
 . . I $G(PSODIR("IND"))="",$G(PSODIR("INDO"))]"" S PSODIR("INDO")=""
 . I $G(PSODIR("IND"))="",$G(PSODIR("INDO"))="" S PSODONE=1 Q
 . I $G(PSODIR("IND"))]"",$G(PSODIR("INDO"))]"" S PSODONE=1 Q
 . I $G(PSODIR("IND"))]"",$G(PSODIR("INDO"))="" W $C(7),!!?5,"OTHER INDICATION REQUIRED",! H 2 Q
 . I $G(PSODIR("IND"))="",$G(PSODIR("INDO"))]"" W $C(7),!!?5,"INDICATION REQUIRED",! H 2
 D EN^PSOFSIG(.PSODIR,1)
 Q
 ;
OIND ;
 I '$D(^TMP($J,"PSODIND","OTH")) S Y=99 G OINDI1
 N SEL,I,INDCAT,CHK,CNT
 S (CHK,CNT,PSODIR("DFLG"))=0
 S (SEL,I)="" F  S I=$O(^TMP($J,"PSODIND","OTH",I)) Q:I=""  D
 . S INDCAT=$P($G(^TMP($J,"PSODIND","OTH",I)),"^") Q:'$L(INDCAT)
 . I $G(PSODIR("INDO"))]"",INDCAT=PSODIR("INDO") S CHK=1
 . S CNT=CNT+1,INDLST(CNT)=INDCAT,DIR("L",CNT)="  "_CNT_"   "_INDCAT S:CNT=1 SEL=CNT_":"_INDCAT S:CNT>1 SEL=SEL_";"_CNT_":"_INDCAT
 W !!,"OTHER LANGUAGE INDICATION:"
 K DIRUT,DTOUT,DUOUT,DIROUT
 S DIR(0)="SO^"_SEL_";99:Free Text entry",DIR("A")="Select OTHER LANGUAGE INDICATION from the list"
 S DIR("L")="  99  Free Text entry"
 S:CHK DIR("B")=PSODIR("INDO") S:'CHK&($G(PSODIR("INDO"))]"") DIR("B")=99
 S DIR("?")="Answer must be 3-40 characters in length."
 S DIR("?",1)="This field contains the Other Language Indication For Use."
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) S PSODIR("DFLG")=1 Q
 I '$G(PSOEDIT),X="" Q
 I $G(PSOEDIT),X="" S:$G(PSODIR("INDO"))]"" Y=99 G OINDI1
 I X="@" D:$G(PSOEDIT)!($G(PSOFDR))!($G(PSOCOPY))  Q  ;K:'$G(PSOEDIT) PSODIR("IND"),PSODIR("INDF"),PSODIR("INDO") Q
 . S PSODELINS=1 D DELIND
 . I $G(PSODELINS) S (PSODIR("FLD",128),PSODIR("FLD",129),PSODIR("FLD",130))="" K PSODIR("IND"),PSODIR("INDF"),PSODIR("INDO")
 I Y=99 S:CHK PSODIR("INDO")="" G OINDI1
 I Y S PSODIR("INDO")=Y(0) S:$G(PSOEDIT) PSODIR("FLD",130)=Y(0)
OINDI1 ;
 I Y=99 N I,J,IND,DA D  G:$G(Y)=99 OINDI1 Q:$G(PSODIR("DFLG"))!(X="")
 . K X,Y,DIRUT,DTOUT,DUOUT,DIROUT,DIR
 . S:$G(PSODIR("INDO"))]"" DIR("B")=PSODIR("INDO")
 . S DIR(0)="52,130",DIR("A")="OTHER LANGUAGE INDICATION" D ^DIR
 . I $D(DUOUT)!($D(DTOUT)) S PSODIR("DFLG")=1 Q
 . I X="" S PSODIR("FLD",130)="" K PSODIR("INDO") Q
 . I X="@" D:$G(PSOEDIT)!($G(PSOCOPY))  K:'$G(PSOEDIT) PSODIR("IND"),PSODIR("INDF"),PSODIR("INDO") Q
 . . S PSODELINS=1 D DELIND
 . . I $G(PSODELINS) S (PSODIR("FLD",128),PSODIR("FLD",129),PSODIR("FLD",130))="" K PSODIR("IND"),PSODIR("INDF"),PSODIR("INDO")
 . I $L(X," ")=1,$L(X)>32 W $C(7),!?5,"MAX OF 32 CHARACTERS ALLOWED WITHOUT SPACES.",! S Y=99 Q
 . S IND="" F I=1:1:$L(X," ") Q:I=""  S J=$P(X," ",I) D  I '$D(X) S Y=99 Q
 . .I $L(J)>32 W $C(7),!?5,"MAX OF 32 CHARACTERS ALLOWED BETWEEN SPACES.",! K X Q
 . .S:J]"" IND=$S($G(IND)]"":IND_" ",1:"")_J
 . Q:$G(Y)=99
 . S IND=$$UPPER^PSOSIG(IND),PSODIR("INDO")=IND
 . I $L(IND) S:$G(PSOEDIT) PSODIR("FLD",130)=IND
 Q
DELIND  ;*441-IND-CONFIRM INDICATION DELETION
 I '$P($G(^PS(55,PSODFN,"LAN")),"^") Q
 N X,Y,DIR,DIRUT
 W $C(7),!!?5,"ANY DATA ENTERED FOR "_$S($G(PSODELINS)=2:"OTHER INDICATION",1:"INDICATION")
 W $C(7),!?5,"WILL ALSO BE DELETED.",!
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Continue with Deletion" D ^DIR
 S:$G(DIRUT) Y=0
 S (PSODONE,PSODELINS)=Y
 Q
 ;
 ;*545; DEA selection
SLDEA(PROVIEN,PSORX,DFLTDEA,PSODRIEN) ; DEA Selection
 Q $$SLDEA^PSODIR5(PROVIEN,.PSORX,$G(DFLTDEA),$G(PSODRIEN))
