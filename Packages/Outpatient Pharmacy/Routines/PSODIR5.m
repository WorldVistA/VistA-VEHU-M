PSODIR5 ;DAL/JCH - ASK FOR DEA RX DATA ;11/08/21 4:03pm
 ;;7.0;OUTPATIENT PHARMACY;**545,731,743**;DEC 1997;Build 24
 ;External reference PSDRUG( supported by DBIA 221
 ;External reference PS(50.7 supported by DBIA 2223
 ;External reference to VA(200 is supported by DBIA 10060
 ;External reference to DEA NUMBERS file (#8991.9) is supported by DBIA 7002
 ;External reference to sub-file NEW DEA #'S (#200.5321) is supported by DBIA 7000
 ;----------------------------------------------------------------
 ;
FAILOVER(DEARY,VA,SDEA) ;check failover flag, if expired DEA, use VA schedule
 N FLOV,NDEA,DCNT
 S FLOV=$$GET^XPAR("SYS","PSOEPCS EXPIRED DEA FAILOVER",1,"I"),DCNT=0
 I 'FLOV D WM2,DISPONLY(.DEARY) Q ""
 S NDEA=$$SDEA^XUSER(FLOV,PROVIEN,SDEA)
 I NDEA=1!(NDEA=2)!(+NDEA=4) D WM2,DISPONLY(.DEARY) Q ""
 S DCNT=DCNT+1 W !,""_DCNT_". "_VA_"    (VA#)" S DEARY(DCNT)=NDEA
 I $D(DEARY(1)) S DLOOP=0 F  S DLOOP=$O(DEARY(1,DLOOP)) Q:'DLOOP  D
 .W !,"* "_$P($G(DEARY(1,DLOOP)),U,2) W:$L($P($G(DEARY(1,DLOOP)),U,3)) "-"_$P($G(DEARY(1,DLOOP)),U,3) W "   "_$P($G(DEARY(1,DLOOP)),U,4)_"    Expired: "_$P($G(DEARY(1,DLOOP)),U,6)
 Q $$DDIR^PSODIR5(DCNT)
 ;
DISP3(IEN,ARYSEL,PSORX) ;displays dea#,detox#,address 
 N DA,DIC,DR,DISPFLD,DISPVAL,DISPTXT,RES,DERR,ARYSEL
 S DA=IEN,ARYSEL=Y
 S DIC="^XTV(8991.9,"
 S DR=".01"_$S($$GET1^DIQ(50,PSODRUG("IEN"),.01,"E")["BUPREN":";.03",1:"")_";1.2:1.7"
 K ^UTILITY("DIQ1",$J)
 D EN^DIQ1
 W !
 I $D(^UTILITY("DIQ1",$J)) D
 . S DISPFLD=0 F  S DISPFLD=$O(^UTILITY("DIQ1",$J,8991.9,DA,DISPFLD)) Q:'DISPFLD  I DISPFLD'=.03 D  ;P731 detox/x-waiver removal
 .. S DISPVAL=$G(^UTILITY("DIQ1",$J,8991.9,DA,DISPFLD))
 .. I DISPFLD=.01,$P(DEARY(2,ARYSEL),U,3)]"" S DISPVAL=DISPVAL_"-"_$P(DEARY(2,ARYSEL),U,3)
 .. I DISPFLD=.03 S DISPVAL=$$DETOX^XUSER(PROVIEN)
 .. K RES,DERR
 .. D FIELD^DID(8991.9,DISPFLD,"","LABEL","RES","DERR")
 .. I '$D(RES) Q
 .. S DISPTXT=$G(RES("LABEL"))_": "_DISPVAL
 .. W !," "_DISPTXT
 ;W ! I $G(PSOEDIT)!($G(ZZCOPY)) W !,"Press Return to continue: ",$C(7) R X:$S($D(DTIME):DTIME,1:300)
 W !!!!,"Press Return to continue: ",$C(7) R X:$S($D(DTIME):DTIME,1:300)
 S PSORX("RXDEA")=$P(DEARY(2,ARYSEL),U,2)
 S:$P(DEARY(2,ARYSEL),U,3)]"" PSORX("RXDEA")=PSORX("RXDEA")_"-"_$P(DEARY(2,ARYSEL),U,3)
 S DEASEL=PSORX("RXDEA")
 Q DEASEL
 ;
USEVA(PROVIEN,VA,PSORX) ;Use VA# only when provider has no dea#
 N INN,IN,XUEXDT,DEASEL,NODEA,NVA
 S DEASEL=""
 S NVA=+$G(^VA(200,PROVIEN,"TPB"))
 S NODEA=$G(^VA(200,PROVIEN,"PS"))
 I "34"[+$P(NODEA,U,6)!NVA D WM1 Q DEASEL
 I '$L($P(NODEA,U,3)) D WM1 Q DEASEL
 S NODEA=$G(^VA(200,PROVIEN,"PS3"))
 S IN=$S(SDEA=2:1,SDEA="2n":2,SDEA=3:3,SDEA="3n":4,SDEA="4":5,1:6)
 I '$P(NODEA,U,IN) D WM3(SDEA) Q DEASEL
 S INN=$S($G(PSOPINST):+$G(PSOPINST),1:+DUZ(2)),IN=$P($G(^DIC(4,INN,"DEA")),U) ;signed-in Inst.
 I '$L(IN) D
 . N XU1 D PARENT^XUAF4("XU1","`"_INN,"PARENT FACILITY")
 . S INN=$O(XU1("P","")) I INN S IN=$P($G(^DIC(4,INN,"DEA")),U)
 . Q
 I INN S XUEXDT=$P($G(^DIC(4,INN,"DEA")),U,2) ;check FACILITY DEA EXPIRATION DATE
 S XUEXDT=$G(XUEXDT)
 I $L(VA),$L(IN),$L(XUEXDT),XUEXDT'<DT S (DEARY,DEASEL)=IN_"-"_VA
 I DEASEL="" D WM1 Q DEASEL
 D INDISP(PROVIEN,DEARY,.PSORX)
 S DEASEL=PSORX("RXDEA")
 Q DEASEL
 ;
WM1 ;warning message
 W !!,"Provider must have a current DEA# or VA# to write prescriptions for this drug.",!
 Q
 ;
WM2 ; Warning message
 W !!,"The provider's DEA# on file has Expired and must be updated.",!
 Q
WM3(SCHED) ; Warning message
 W $C(7),!!,"Provider not authorized to write Federal Schedule "_SCHED_" prescriptions.",!
 Q
 ;
INDISP(PROVIEN,DEARY,PSORX) ;displays institutional dea#va#, address of institution
 W !!,"DEA NUMBER: "_DEARY
 ;I $G(PSORX("DETX"))]"" W !,"DETOX NUMBER: "_PSORX("DETX") ;P731 detox/x-waiver removal
 N MADD1,MADD2,MCITY,MSTATE,MZIP
 S MADD1=$$GET1^DIQ(4,DUZ(2),1.01),MADD2=$$GET1^DIQ(4,DUZ(2),1.02)
 S MCITY=$$GET1^DIQ(4,DUZ(2),1.03),MSTATE=$$GET1^DIQ(4,DUZ(2),.02)
 S MZIP=$$GET1^DIQ(4,DUZ(2),1.04)
 W !,"STREET ADDRESS 1:",MADD1
 w !,"STREET ADDRESS 2:",MADD2
 W !,"CITY:",MCITY
 W !,"STATE:",MSTATE
 W !,"ZIP CODE:",MZIP
 W ! I $G(PSOEDIT)!($G(ZZCOPY)) W !,"Press Return to continue: ",$C(7) R X:$S($D(DTIME):DTIME,1:300)
 S (DEASEL,PSORX("RXDEA"))=DEARY
 Q DEASEL
 ;
DEALIST(RET,NPIEN,SDEA)  ; -- returns the DEA list
 ; INPUT:  NPIEN - NEW PERSON FILE #200 INTERNAL ENTRY NUMBER
 ;
 ; OUTPUT: RET - A STRING OF DEA INFORMATION DELIMITED BY THE "^".
 ;         RET ***** KILLED BY THIS RPC *****
 ;         RET(0)=TOTCNT^NEXPCNT^EXPCNT - Count of DEA Numbers for a provider, count of expired DEA numbers for provider.
 ;         RET(1,n) - Expired DEA Numbers
 ;         RET(2,n) - Active DEA Numbers
 ;         RET(3,n) - Not allowed to write that schedule
 ;           1 - DEA IEN
 ;           2 - DEA NUMBER
 ;           3 - INDIVIDUAL DEA SUFFIX
 ;           4 - STATE
 ;           5 - DETOX NUMBER
 ;           6 - EXPIRATION DATE EXTERNAL: FROM THE DEA NUMBERS FILE (#8991.9), FIELD EXPIRATION DATE (#.04)
 ;           7 - EXPIRATION DATE INTERNAL: FROM THE DEA NUMBERS FILE (#8991.9), FIELD EXPIRATION DATE (#.04)
 ;
 N CNT,DNDEADAT,DNDEAIEN,FAIL,IENS,NPDEADAT,NPDEAIEN,EXPDATEI,EXPCNT,NODE1,DIFF,DNDEANUM,EXPFLG,DEASUFX
 K RET S EXPCNT=0
 S CNT(1)=0,CNT(2)=0,CNT(3)=0
 S NPDEAIEN=0 F CNT=1:1 S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'+NPDEAIEN  D
 . S EXPFLG=0
 . S IENS=NPDEAIEN_","_NPIEN_","
 . K NPDEADAT D GETS^DIQ(200.5321,IENS,"**","","NPDEADAT") Q:'$D(NPDEADAT)
 . S DNDEAIEN=$$GET1^DIQ(200.5321,IENS,.03,"I") Q:'DNDEAIEN
 . K DNDEADAT D GETS^DIQ(8991.9,DNDEAIEN,"**","","DNDEADAT") Q:'$D(DNDEADAT)
 . ;
 . S EXPDATEI=$$GET1^DIQ(8991.9,DNDEAIEN,.04,"I"),DIFF=$$FMDIFF^XLFDT(DT,EXPDATEI,1)
 . I DIFF>366 S EXPCNT=EXPCNT+1,CNT(1)=CNT(1)+1 Q
 . I EXPDATEI,EXPDATEI<DT S EXPCNT=EXPCNT+1,NODE1=1,CNT(1)=CNT(1)+1,EXPFLG=1              ; Expired DEA Counter
 . S DNDEANUM=$$GET1^DIQ(200.5321,IENS,.01,"E")
 . I $$GET1^DIQ(8991.9,DNDEAIEN,.07,"I")=1 S DEASUFX=$$GET1^DIQ(200.5321,IENS,.02,"E") I $L(DEASUFX)>2 S DNDEANUM=DNDEANUM_"-"_DEASUFX
 . S NDEA=$$SDEA^XUSER($$GET^XPAR("SYS","PSOEPCS EXPIRED DEA FAILOVER",1,"I"),NPIEN,SDEA,,DNDEANUM)                                             ; Check to verify schedule permissions
 . I EXPFLG'=1!(NDEA=2) S NODE1=3,CNT(3)=CNT(3)+1
 . I EXPDATEI,'(EXPDATEI<DT),(NDEA'=2),(NDEA'=1),(EXPFLG'=1) S NODE1=2,CNT(2)=CNT(2)+1
 . S RET(NODE1,CNT(NODE1))=""
 . S RET(NODE1,CNT(NODE1))=RET(NODE1,CNT(NODE1))_DNDEAIEN_"^"                             ; DEA IEN
 . S RET(NODE1,CNT(NODE1))=RET(NODE1,CNT(NODE1))_NPDEADAT(200.5321,IENS,.01)_"^"          ; NEW PERSON DEA NUMBER
 . S RET(NODE1,CNT(NODE1))=RET(NODE1,CNT(NODE1))_NPDEADAT(200.5321,IENS,.02)_"^"          ; INDIVIDUAL DEA SUFFIX
 . S RET(NODE1,CNT(NODE1))=RET(NODE1,CNT(NODE1))_DNDEADAT(8991.9,DNDEAIEN_",",1.6)_"^"    ; STATE
 . S RET(NODE1,CNT(NODE1))=RET(NODE1,CNT(NODE1))_""_"^"                                   ; DETOX NUMBER  ;P731 detox/x-waiver removal
 . S RET(NODE1,CNT(NODE1))=RET(NODE1,CNT(NODE1))_DNDEADAT(8991.9,DNDEAIEN_",",.04)_"^"    ; EXPIRATION DATE EXTERNAL
 . S RET(NODE1,CNT(NODE1))=RET(NODE1,CNT(NODE1))_EXPDATEI_"^"                             ; EXPIRATION DATE INTERNAL
 S RET(0)=(CNT-1)_"^"_(CNT(2)+CNT(3))_"^"_CNT(1)
 Q
 ;
DISPONLY(DEARY) ; Display only
 I $D(DEARY(1)) S DLOOP=0 F  S DLOOP=$O(DEARY(1,DLOOP)) Q:'DLOOP  D
 . W !,"*  "_$P($G(DEARY(1,DLOOP)),U,2) W:$L($P($G(DEARY(1,DLOOP)),U,3)) "-"_$P($G(DEARY(1,DLOOP)),U,3) W "   "_$P($G(DEARY(1,DLOOP)),U,4)_"    Expired: "_$P($G(DEARY(1,DLOOP)),U,6)
 I $D(DEARY(3)) S DLOOP=0 F  S DLOOP=$O(DEARY(3,DLOOP)) Q:'DLOOP  D
 . W !,"*  "_$P($G(DEARY(3,DLOOP)),U,2) W:$L($P($G(DEARY(3,DLOOP)),U,3)) "-"_$P($G(DEARY(3,DLOOP)),U,3)
 . W "   "_$P($G(DEARY(3,DLOOP)),U,4)_"     Not Valid for Schedule: "_SDEA
 S (DCNT,DLOOP)=0 F  S DLOOP=$O(DEARY(2,DLOOP)) Q:'DLOOP  D
 . S DCNT=DCNT+1 W !,DCNT_". "_$P($G(DEARY(2,DLOOP)),U,2) W:$L($P($G(DEARY(2,DLOOP)),U,3)) "-"_$P($G(DEARY(2,DLOOP)),U,3) W "   "_$P($G(DEARY(2,DLOOP)),U,4)
 Q
 ;
 ;*545; DEA selection
SLDEA(PROVIEN,PSORX,DFLTDEA,PSODRIEN) ;
 N DA,SDEA,VA,NDEA,DCNT,DLOOP,DEARY,Y,DEASEL,DFLTSEL,DL S DEASEL=""
 I '$D(PSODRUG("IEN")),$G(PSODRIEN) D
 . N PSOY S PSOY=+$G(PSODRIEN),PSOY(0)=^PSDRUG(PSOY,0) D SET^PSODRG
 S DA(1)=PROVIEN,SDEA=$$DRGSCH^PSODIR(),VA=$P($G(^VA(200,PROVIEN,"PS")),U,3)
 D DEALIST(.DEARY,PROVIEN,SDEA)
 ;no DEA#/VA#
 I $P(DEARY(0),U)=0&(('$L(VA))!'$$VAPROV(PROVIEN)) D WM1 Q ""
 ;no DEA# then use VA#
 I ($P(DEARY(0),U)=0)&($L(VA))&$$VAPROV(PROVIEN) Q $$USEVA(PROVIEN,VA,.PSORX)
 ;DEA# is expired, check Failover flag.
 I $P(DEARY(0),U)=$P(DEARY(0),U,3)&('$L(VA)!'$$VAPROV(PROVIEN)) D WM2,DISPONLY(.DEARY) Q DEASEL
 I $P(DEARY(0),U)=$P(DEARY(0),U,3)&($$VAPROV(PROVIEN)) S DEASEL=$$FAILOVER(.DEARY,VA,SDEA) Q DEASEL
 I $P(DEARY(0),U)=1&($P(DEARY(0),U,2))=1&($D(DEARY(2))) S Y=1 D DISP3($P(DEARY(2,1),U),Y,.PSORX) Q PSORX("RXDEA")
 I $D(DEARY(3))&('$D(DEARY(2))) D  Q ""
 . W !,"Provider not authorized to write Federal Schedule "_SDEA_" prescriptions."
 . W !,"Please contact the provider.",!
 . D DISPONLY(.DEARY)
 ;743 - One active DEA# with valid schedule and another DEA# that expired more than a year ago
 I '$D(DEARY(1)),('$D(DEARY(3))),($O(DEARY(2,""))=$O(DEARY(2,""),-1)) S Y=1 Q $$DISP3($P(DEARY(2,1),U),Y,.PSORX)
 I $P(DEARY(0),U,1)>1 D
 . Q:$D(DEARY(3))&('$D(DEARY(2)))
 . W !!,"This provider has multiple DEA registrations." W !,"Please select the correct DEA number for the prescription being entered"
 I $D(DEARY(1)) S DLOOP=0 F  S DLOOP=$O(DEARY(1,DLOOP)) Q:'DLOOP  D
 . W !,"*  "_$P($G(DEARY(1,DLOOP)),U,2) W:$L($P($G(DEARY(1,DLOOP)),U,3)) "-"_$P($G(DEARY(1,DLOOP)),U,3) W "   "_$P($G(DEARY(1,DLOOP)),U,4)_"    Expired: "_$P($G(DEARY(1,DLOOP)),U,6)
 I $D(DEARY(3)) S DLOOP=0 F  S DLOOP=$O(DEARY(3,DLOOP)) Q:'DLOOP  D
 . W !,"*  "_$P($G(DEARY(3,DLOOP)),U,2) W:$L($P($G(DEARY(3,DLOOP)),U,3)) "-"_$P($G(DEARY(3,DLOOP)),U,3)
 . W "   "_$P($G(DEARY(3,DLOOP)),U,4)_"     Not Valid for Schedule: "_SDEA
 S (DCNT,DLOOP)=0 F  S DLOOP=$O(DEARY(2,DLOOP)) Q:'DLOOP  D
 . S DCNT=DCNT+1 W !,DCNT_". "_$P($G(DEARY(2,DLOOP)),U,2) W:$L($P($G(DEARY(2,DLOOP)),U,3)) "-"_$P($G(DEARY(2,DLOOP)),U,3) W "   "_$P($G(DEARY(2,DLOOP)),U,4)
 I $G(DCNT)=0 Q ""
 I $L($G(DFLTDEA)) S DL=0 F  Q:$G(DFLTSEL)  S DL=$O(DEARY(2,DL)) Q:'DL  I $P(DEARY(2,DL),U,2)=DFLTDEA S DFLTSEL=DL
 S DEASEL=$$DDIR(DCNT,$G(DFLTSEL))
 Q DEASEL
 ;
DDIR(DCNT,DFLT) ;
 N DIR,Y,DEASEL
 S:$G(DFLT) DIR("B")=DFLT
 K DIRUT S DIR(0)="NO^1:"_DCNT,DIR("A")="Choose",DIR("?",1)="Select a choice from the list above"  D ^DIR K DIR
 I $D(DIRUT)!(Y<1) K DIRUT,DTOUT,DUOUT Q ""
 I $G(FLOV)=1 D INDISP(PROVIEN,DEARY(Y),.PSORX) Q DEASEL
 S DEASEL=$P(DEARY(2,Y),U,1)
 D DISP3($P(DEARY(2,Y),U,1),Y,.PSORX)
 Q DEASEL
 ;
VAPROV(PROVIEN) ; Is PROVIEN a VA Provider? (NON-VA PRESCRIBER=NO, PROVIDER TYPE=FULL TIME, PART TIME, or HOUSE STAFF)
 ; INPUT: PROVIEN = Provider DUZ
 N NONVA,PRVTYP
 Q:'$G(PROVIEN)
 I '$L($$GET1^DIQ(200,PROVIEN,.01)) Q ""
 S PRVTYP=$$GET1^DIQ(200,PROVIEN,53.6,"I") I (PRVTYP=3)!(PRVTYP=4) Q 0
 S NONVA=$$GET1^DIQ(200,PROVIEN,53.91,"I") I NONVA Q 0
 Q 1
