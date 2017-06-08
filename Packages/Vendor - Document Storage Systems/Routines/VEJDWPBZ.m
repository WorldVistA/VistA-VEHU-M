VEJDWPBZ ;WPB/CAM routine modified for dental GUI;8/1/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;BIR/MLM-DRUG NAME DISPLAY ; 05 Feb 98 / 1:39 PM
 ;PSJLMUT1;5.0; INPATIENT MEDICATIONS ;**4**;16 DEC 97
 ;
DRGDISP(DFN,ON,NL,GL,NAME,DRUGONLY)       ;
 ;; DRUGONLY = 1/0 - Only the drug name will be returned.
 ;; NL       = The drug name display length
 ;; GL       = The give line display length, total length-6 ("Give: ")
 ;; NAME(X)  = Drug name and give line in displayable format.
 ;; ON       = IEN#_U/P (U=Unit Dose; P=Pending)
 ;
 NEW F,OIND,MARX,MR,NOTGV,SCH,PSGUPDDO,PSGGV,X,PSGX,PSGINS,DRUGNAME
 K NAME S PSGINS=""
 S:ON["U" F="^PS(55,DFN,5,+ON,"
 I ON["P" S F="^PS(53.1,+ON,",X=$G(@(F_".3)")),PSGINS=$S(X]"":X,1:"")
 I $G(@(F_"0)"))="" S NAME(1)="NOT FOUND" Q
 S OIND=$G(@(F_".2)")),PSGUPDDO=$P(OIND,U,2),X=@(F_"0)"),NOTGV=$P(X,U,22),MR=$$ENMRN(+$P(X,U,3))
 I '+OIND,($P(X,U,4)'="U") NEW DRG D GTDRGA F X="AD","SOL" Q:+OIND  F PSGX=0:0 S PSGX=$O(DRG(X,PSGX)) Q:'PSGX  S OIND=$P(DRG(X,PSGX),U,6) Q:+OIND
 S SCH=$P($G(@(F_"2)")),U)
 I +$O(@(F_"1,0)")),'+$O(@(F_"1,1)")),PSGUPDDO="" D DD(F,.DRUGNAME)
 S:($G(DRUGNAME)=""!($G(DRUGNAME)["NOT FOUND")) DRUGNAME=$$OIDF(OIND)
 ;S PSGGV=$S(NOTGV:"*** NOT TO BE GIVEN *** ",1:"")_PSGINS_PSGUPDDO_" "_MR_" "_SCH
 S PSGGV=$S(NOTGV:"*** NOT TO BE GIVEN *** ",1:"")_$S(('$D(PSJPDDDP)&('$L(PSGUPDDO))):PSGINS,1:PSGUPDDO)_" "_MR_" "_SCH
 S PSGX=0 K PSJPDDDP
 D TXT(DRUGNAME,NL) F X=0:0 S X=$O(MARX(X)) Q:'X  S NAME(X)=$S(X>1:"  ",1:"")_MARX(X),PSGX=X
 Q:+DRUGONLY
 D TXT(PSGGV,GL) F X=0:0 S X=$O(MARX(X)) Q:'X  D
 . I X=1 S NAME(PSGX+X)="Give: "_MARX(X) Q
 . S NAME(PSGX+X)=$S(X>1:"      ",1:"")_MARX(X)
 Q
OIDF(OIND)    ; Return Orderable Item name and Dosage form.
 ;; +OIND = orderable item IEN
 NEW X,NAME
 S X=$G(^PS(50.7,+OIND,0))
 S:$P(X,U)]"" NAME=$P(X,U)_" "_$P($G(^PS(50.606,+$P(X,U,2),0)),U)
 Q $S($G(NAME)]"":NAME,1:"NOT FOUND "_+OIND_";PS(50.7")
 ;
DD(F,NAME)        ; Return Dispense drug name.
 ;; F = "^PS(55,DFN,5,+ON," or "^PS(53.1,+ON,"
 NEW X K NAME
 S X=$O(@(F_"1,0)")),X=$G(@(F_"1,"_+X_",0)"))
 I $P(X,U)]"" S NAME=$P($G(^PSDRUG(+X,0)),U)
 E  S NAME="NOT FOUND "_+X_";PSDRUG"
 I '$O(@(F_"1,1)")),+$P(X,U,2)>1 S PSGUPDDO=+$P(X,U,2)
 S PSJPDDDP=1
 Q
DSPLORDU(PSGP,ON)   ; Display UD order for order check as in the Inpat Profile.
 NEW DRUGNAME,F,NODE0,NODE2,PSJID,PSJX,SCH,SD,STAT,X,Y
 S F=$S(ON["U":"^PS(55,PSGP,5,"_+ON_",",1:"^PS(53.1,"_+ON_",")
 S NODE0=$G(@(F_"0)")),NODE2=$G(@(F_"2)"))
 D DRGDISP(PSGP,ON,39,54,.DRUGNAME,0)
 I ON["P",$P(NODE0,U,4)="F" D DSPLORDV(PSGP,ON) Q
 S SCH=$P(NODE0,U,7)
 S STAT=$P(NODE0,U,9) I STAT="A",$P(NODE0,U,27)="R" S STAT="R"
 I STAT'="P" S PSJID=$E($$ENDTC($P(NODE2,U,2)),1,5),SD=$E($$ENDTC^PSGMI($P(NODE2,U,4)),1,5)
 I STAT="P" S (PSJID,SD)="*****",SCH="?"
 F PSJX=0:0 S PSJX=$O(DRUGNAME(PSJX)) Q:'PSJX  D
 . S:PSJX=1 X=SCH_"  "_PSJID_"  "_SD_"  "_$E(STAT,1)
 . S:PSJX=1 DRUGNAME(1)=$$SETSTR^VALM1(X,$E(DRUGNAME(1),1,40),42,20)
 . S PSJOC(ON,PSJLINE)="        "_DRUGNAME(PSJX)
 . S PSJLINE=PSJLINE+1
 Q
DSPLORDV(DFN,ON)   ; Display IV order for order check as in the Inpat Profile.
 N DRG,DRGI,DRGT,DRGX,FIL,ND,ON55,P,PSJIVFLG,PSJORIFN,TYP,X,Y
 S TYP="?" I ON["V" D
 .S Y=$G(^PS(55,DFN,"IV",+ON,0)) F X=2,3,4,5,8,9,17,23 S P(X)=$P(Y,U,X)
 .S TYP=$S(P(2)=P(3):"O",1:"C"),ON55=ON,P("OT")=$S(P(4)="A":"F",P(4)="H":"H",1:"I") D GTDRG,GTOT(P(4))
 S PSJCT=0,PSJL=""
 I ON'["V" S (P(2),P(3))="",P(17)=$P($G(^PS(53.1,+ON,0)),U,9),Y=$G(^(8)),P(4)=$P(Y,U),P(8)=$P(Y,U,5),P(9)=$P($G(^(2)),U) D GTDRG,GTOT(P(4))
 S PSJIVFLG=1 D PIVAD,SOL
 Q
SOL ;
 S PSJL=$S($G(PSJIVFLG):PSJL,1:"")_"        in"
 S DRG=0 F  S DRG=+$O(DRG("SOL",DRG)) Q:'DRG  D NAME(DRG("SOL",DRG),39,.NAME,0) S DRGX=0 F  S DRGX=$O(NAME(DRGX)) Q:'DRGX  S PSJL=$$SETSTR^VALM1(NAME(DRGX),PSJL,12,60) D:$G(PSJIVFLG) PIV1 D SETTMP S PSJL="      "
 Q
PIVAD ; Print IV Additives.
 F DRG=0:0 S DRG=$O(DRG("AD",DRG)) Q:'DRG  D NAME(DRG("AD",DRG),39,.NAME,1) F DRGX=0:0 S DRGX=$O(NAME(DRGX)) Q:'DRGX  S PSJL=$$SETSTR^VALM1(NAME(DRGX),PSJL,9,60) D:$G(PSJIVFLG) PIV1 D SETTMP
 Q
 ;
PIV1 ; Print Sched type, start/stop dates, and status.
 K PSJIVFLG
 F X=2,3 S P(X)=$E($$ENDTC(P(X)),1,$S($D(PSJEXTP):8,1:5))
 I '$D(PSJEXTP) S PSJL=$$SETSTR^VALM1(TYP,PSJL,50,1),PSJL=$$SETSTR^VALM1(P(2),PSJL,53,7),PSJL=$$SETSTR^VALM1(P(3),PSJL,60,7),PSJL=$$SETSTR^VALM1(P(17),PSJL,67,1)
 E  S PSJL=$$SETSTR^VALM1(TYP,PSJL,50,1),PSJL=$$SETSTR^VALM1(P(2),53,7),PSJL=$$SETSTR^VALM1(P(3),PSJL,63,7),PSJL=$$SETSTR^VALM1(P(17),PSJL,73,1)
 Q
SETTMP ;
 S PSJOC(ON,PSJLINE)=PSJL,PSJLINE=PSJLINE+1
 Q
SETPSJOC ;Set PSJOC array to be displayed later
 NEW PIECE S PIECE=$S(TYPE="DC":4,1:2)
 S X=$$SETSTR^VALM1($P(^TMP($J,TYPE,PSIVX,0),U,PIECE),"",9,40)
 S X=$$SETSTR^VALM1("* EXISTS IN CURRENT ORDER *",X,50,27)
 S PSJOC(ON,PSJLINE)=X,PSJLINE=PSJLINE+1,PSJOC=PSJOC+1
 Q
WRITE(TYPE)        ;Display order check description
 S PSJPDRG=1
 I TYPE="DD" W !!,"This patient is already receiving the following order",$S(PSJOC>1:"s",1:"")," for this drug:",!
 I TYPE="DC" W !!,"This patient is already receiving ",$S(PSJOC>1:"orders",1:"an order")," for the following drug",$S(PSJOC>1:"s",1:"")," in the same",!,"class as the drug selected:",!
 I TYPE="DI" W !!,"This patient is receiving the following medication",$S(PSJOC>1:"s",1:"")," that ha",$S(PSJOC>1:"ve",1:"s")," an interaction",!,"with ",$P($G(^PSDRUG(PSJDD,0)),U),":",!
 Q
PAUSE ;
 K DIR W ! S DIR(0)="EA",DIR("A")="Press Return to continue..." D ^DIR W !
 Q
ENMRN(X) ; med route name  taken from PSGMI
 ; Y - date in FileMan internal format
 I X S Y=$G(^PS(51.2,X,0)),Y=$S($P(Y,"^",3)]"":$P(Y,"^",3),1:$P(Y,"^")) S:Y="" Y=X_";PS(51.2," Q Y
 Q X
ENDTC(X) ; FM internal date/time to user readable, Inpatient style
 ; taken from PSGMI
 ; Y - date in FileMan internal format
 I $G(Y) S Y=Y_$E(".",Y'[".")_"0000" Q $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_"  "_$E(Y,9,10)_":"_$E(Y,11,12)
 Q "********"
GTDRGA ;taken form PSIVORFA
 K DRG F X="AD","SOL" S FIL=$S(X="AD":52.6,1:52.7) F Y=0:0 S Y=$O(^PS(53.1,+ON,X,Y)) Q:'Y  D
 .S (DRGI,DRG(X,0))=$G(DRG(X,0))+1,DRG=$G(^PS(53.1,+ON,X,Y,0)),ND=$G(^PS(FIL,+DRG,0)),DRGN=$P(ND,U),DRG(X,+DRGI)=+DRG_U_$P(ND,U)_U_$P(DRG,U,2)_U_$P(DRG,U,3)_U_$P(ND,U,13)_U_$P(ND,U,11)
 Q
TXT(TXT,LEN) ;taken from PSGMUTL
 ;* Input: TXT = TXT string
 ;*        LEN = format length
 ;* Output: MARX array.
 NEW OLD D SPLIT K MARX
 S X=0,X1=1,Y="" F  S X=$O(OLD(X)) Q:'X  D
 . I $L(Y_OLD(X))>LEN S MARX(X1)=Y,X1=X1+1,Y=""
 . S Y=Y_OLD(X)
 S:Y]"" MARX(X1)=Y
 S MARX=X1
 Q
GTDRG ;taken from PSIVORFB Get drug info and place in DRG(.
 F DRGT="AD","SOL" S FIL=$S(DRGT="AD":52.6,1:52.7) F Y=0:0 S Y=$O(^PS(55,DFN,"IV",+ON55,DRGT,Y)) Q:'Y  D
 .; naked ref below refers to line above
 .S DRG=$G(^(Y,0)),ND=$G(^PS(FIL,+DRG,0)),(DRGI,DRG(DRGT,0))=$G(DRG(DRGT,0))+1,DRG(DRGT,+DRGI)=+DRG_U_$P(ND,U)_U_$P(DRG,U,2)_U_$P(DRG,U,3)_U_$P(ND,U,13)_U_$P(ND,U,11)
 Q
GTOT(Y) ;taken from PSIVUTL Get order type & protocol
 S P("OT")=$S(Y="A":"F",Y="H":"H",1:"I")
 I P("OT")="F" F DRGT="AD","SOL" F DRGI=0:0 S DRGI=$O(DRG(DRGT,DRGI)) Q:'DRGI  I '$P(DRG(DRGT,DRGI),U,5) S P("OT")="I" Q
 Q
NAME(X,L,MARX,AD) ; taken from PSIVUTL Format Additive display.
 ;INPUT : X=DRG("AD",DRG)  L=Display length   AD=for Addtive(1/0)
 ;OUTPUT: AD(X)  if X=2 that means there is a second line to display
 NEW Y S Y=$P(X,U,3) S:(AD&$P(X,U,4)) Y=Y_" ("_$P(X,U,4)_")"
 I 'AD!('$O(DRG("SOL",0))) S Y=Y_" "_$S(P(4)="P"!($G(P(23))="P")!$G(P(5)):P(9),1:$P(P(8),"@"))
 I ($L($P(X,U,2))+$L(Y)+1)>L D TXT^PSGMUTL($P(X,U,2)_" "_Y,L) S:AD MARX(2)="   "_MARX(2) Q
 S MARX(1)=$P(X,U,2)_" "_Y
 Q
SPLIT ;* Split a word string into individual words.
 ;* Output: OLD(X)
 NEW BSD,NEW,X,X1,Y
 S OLD(1)=TXT Q:$L(TXT)<LEN
 F BSD=" ","/","-" S:'$O(OLD(0)) OLD(1)=TXT D:TXT[BSD DELIM(BSD)
 I '$O(OLD(1)),($L(TXT)>LEN) D LEN(1,TXT) K OLD D
 . F X=0:0 S X=$O(NEW(X)) Q:'X  S OLD(X)=NEW(X)
 Q
LEN(X1,OLD) ;;* Wrap word around if it doesn't fit the display lenght.
 NEW X
 Q:$L(OLD)'>LEN
 S X=$E(OLD,1,($L(OLD)-1)) I X["/"!(X["-") Q
 I $L(OLD)>LEN F X=1:1 S NEW(X1)=$E(OLD,((LEN*X)-LEN+1),(LEN*X)),X1=X1+1 Q:($L(OLD)'>(LEN*X))
 Q
DELIM(BSD) ;* BSD=" ","/","-"
 K NEW
 S X=0,X1=0 F  S X=$O(OLD(X)) Q:'X  F Y=1:1:$L(OLD(X),BSD) D
 . S X1=X1+1
 . S NEW(X1)=$P(OLD(X),BSD,Y)
 . I $L(OLD(X),BSD)>1,(Y<$L(OLD(X),BSD)) S NEW(X1)=NEW(X1)_BSD
 . D LEN(.X1,NEW(X1))
 K OLD F X=0:0 S X=$O(NEW(X)) Q:'X  S OLD(X)=NEW(X)
 Q
