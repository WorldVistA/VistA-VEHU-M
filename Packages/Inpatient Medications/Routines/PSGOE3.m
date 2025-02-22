PSGOE3 ;BIR/CML3-ABBREV/WARD ORDER ENTRY ;09 JAN 97 / 10:42 AM
 ;;5.0;INPATIENT MEDICATIONS;**58,81,315,366**;16 DEC 97;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; Reference to ^DD(53.1 is supported by DBIA 2256.
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ;
 K PSGFOK S F1=53.1,PSGPR=$S($D(PSGOERR):PSJORPV,1:PSGOEPR),PSGMR=$S($P(PSGNEDFD,"^",2):$P(PSGNEDFD,"^",2),1:PSGOEDMR),PSGSCH=$P(PSGNEDFD,"^",4),(PSGOROE1,PSGSI,SDT,PSGMRN,PSGSM,PSGHSM,PSGUD)=""
 S:PSGMR PSGMRN=$S('$P(PSGNEDFD,"^",2):"ORAL",'$D(^PS(51.2,PSGMR,0)):PSGMR,$P(^(0),"^")]"":$P(^(0),"^"),1:PSGMR) I PSGPR S PSGPRN=$P($G(^VA(200,PSGPR,0)),"^") S:PSGPRN="" PSGPRN=PSGPR
 S PSGST=$S($P(PSGNEDFD,"^",3)]"":$P(PSGNEDFD,"^",3),1:"C"),PSGSTN=$$ENSTN^PSGMI(PSGST),F1=53.1 K PSGFOK S PSGFOK(2)=""
 S:$P(PSJSYSU,";",4) PSGFOK(2)="" K ^PS(53.45,PSJSYSP,1),^(2) I PSGDRG S ^(2,0)="^53.4502P^"_PSGDRG_"^1",^(1,0)=PSGDRG,^PS(53.45,PSJSYSP,2,"B",PSGDRG,1)=""
 ;
GTFIELD ; Call ^PSGOE4 for the rest of the data to complete order entry
 ; PSGOE3 is set only if user is using the ABBREV/WARD ORDER ENTRY.
 NEW PSGOE3 S PSGOE3=1
 D 109^PSGOE4 Q:PSGOROE1
 D 3^PSGOE4 Q:PSGOROE1
 D 26^PSGOE4 Q:PSGOROE1
 D 8^PSGOE41 Q:PSGOROE1
 D 10^PSGOE41 Q:PSGOROE1
 ; Setup stop date.
 S PSGOES=1 D ENFD^PSGNE3(PSGDT) K PSGOES
 ;*315 drp ask for Duration of Administration
 K PSGDUR,PSGRMV,PSGRMVT,PSGRF
 D PSGDUR^PSGOE41 Q:PSGOROE1
 D ^PSGOE42
 ;I $S($P(PSJSYSW0,"^",24):1,+PSJSYSU=3:1,$P(PSJSYSU,";",2):0,$D(PSJOERR):0,1:PSGOEORF) G ^PSGOE31
 Q 
 ;
109 ; dosage ordered
 W !,"THIS IS THE OLD DOSAGE ORDERED PROMPT!!",!
 Q
 W !,"DOSAGE ORDERED: ",$S(PSGDO]"":PSGDO_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 I X="" S X=PSGDO I X="" W $C(7),"  (Required)" G 109
 I X="@" W $C(7),"  (Required)" G 109
 ; I X="@" D DEL G:%'=1 109 S PSGDO="" S PSGFOK(109)="" G 3
 S PSGF2=109 I X?1."?" D ENHLP^PSGOEM(53.1,109) G 109
 I $E(X)="^" D FF G:Y>0 @Y G 109
 I $E(X,$L(X))=" " F  S X=$E(X,1,$L(X)-1) Q:$E(X,$L(X))'=" "
 I $S(X?.E1C.E:1,$L(X)>20:1,X="":1,X["^":1,X?1.P:1,1:X=+X) W $C(7),"  ",$S(X?1.P!(X=""):"(Required)",1:"??") S X="?" D ENHLP^PSGOEM G 109
 S PSGDO=X,PSGFOK(109)=""
 ;
3 ; med route
 W !,"MED ROUTE: ",$S(PSGMR:PSGMRN_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 I X="",PSGMR S X=PSGMRN I PSGMR'=PSGMRN,$D(^PS(51.2,PSGMR,0)) W "  "_$P(^(0),"^",3) S PSGFOK(3)="" G 26
 S PSGF2=3 I $S(X="@":1,X]"":0,1:'PSGMR) W $C(7),"  (Required)" S X="?" D ENHLP^PSGOEM(53.1,3) G 3
 I X?1."?" D ENHLP^PSGOEM(53.1,3)
 I $E(X)="^" D FF G:Y>0 @Y G 3
 K DIC S DIC="^PS(51.2,",DIC(0)="EMQZ",DIC("S")="I $P(^(0),""^"",4)" D ^DIC K DIC I Y'>0 G 3
 S PSGMR=+Y,PSGMRN=$P(Y(0),"^"),PSGFOK(3)=""
 ;
26 ; schedule
 W !,"SCHEDULE: ",$S(PSGSCH]"":PSGSCH_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 S PSGF2=26 S:X="" X=PSGSCH I "@"[X W $C(7),"  (Required)" S X="?" D ENHLP^PSGOEM(53.1,26) G 26
 I X?1."?" D ENHLP^PSGOEM(53.1,26) G 26
 I $E(X)="^" D FF G:Y>0 @Y G 26
 D EN^PSGS0 I '$D(X) W $C(7),"  ??" S X="?" D ENHLP^PSGOEM(53.1,26) G 26
 S PSGSCH=X,PSGST=$S(PSGS0XT="O":"O",PSGST="R":"R",X["PRN":"P",X="ON CALL":"OC",PSGST]"":PSGST,1:"C"),PSGFOK(26)=""
 S $P(PSGNEDFD,"^",3)=PSGST S:PSGSCH=""!(X?1." ") PSGSCH="PRN"
 ;
8 ; special instructions
 W !,"SPECIAL INSTRUCTIONS: "_$S(PSGSI]"":$P(PSGSI,"^")_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 I X="" S X=PSGSI I X="" S PSGFOK(8)="" G 10
 S PSGF2=8 I $E(X)="^" D FF G:Y>0 @Y G 8
 I X="@",PSGSI="" W $C(7),"  ??" S X="?" D ENHLP^PSGOEM(53.1,8) G 8
 I X="@" D DEL G:%'=1 8 S PSGSI="",PSGFOK(8)="" G 10
 I X?1."?" D ENHLP^PSGOEM(53.1,8) G 8
 D ^PSGSICHK I '$D(X) W $C(7)," ??" S X="?" D ENHLP^PSGOEM(53.1,8) G 8
 S PSGSI=X I PSGSI]"" S PSGSI=$$ENBCMA^PSJUTL("U"),PSGFOK(8)=""
 ;
10 ; start date edit
 D ^PSGNE3 S PSGSD=PSGNESDO
A10 ; start date/time edit
 S PSGSDEDT=1 ; This variable indicates a Manual Edit of the Start/Date Time.
 W !,"START DATE/TIME: "_PSGSD_"// " R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 I X="@"!(X?1."?") W:X="@" $C(7),"  (Required)" S:X="@" X="?" D ENHLP^PSGOEM(53.1,10) G A10
 S PSGF2=10 I $E(X)="^" D FF G:Y>0 @Y G A10
 I X="",PSGNESD S X=PSGNESD,PSGFOK(10)="" W "  "_PSGSD G SD
 I X="P" D ENPREV^PSGDL W:'$D(X) $C(7) G:'$D(X) A10 S PSGNESD=+X,PSGSD=$$ENDD^PSGMI(+X),PSGFOK(10)="" W "  ",PSGSD G SD
 NEW TMPX S TMPX=X,X1=PSGDT,X2=-7 D C^%DTC K %DT S %DT="ERTX",%DT(0)=X,X=TMPX D ^%DT K %DT I Y'>0 D ENHLP^PSGOEM G A10
 S PSGNESD=+Y,PSGSD=$$ENDD^PSGMI(PSGNESD),PSGFOK(10)=""
 ;
SD ; stop date
 S PSGOES=1 D ENFD^PSGNE3(PSGDT) K PSGOES
 ;
 I $S($P(PSJSYSW0,"^",24):1,+PSJSYSU=3:1,$P(PSJSYSU,";",2):0,$D(PSJOERR):0,1:PSGOEORF) G ^PSGOE31
 ;
 ;
DONE ;
 I PSGOROE1 K Y W $C(7),"  ...order not entered..."
 K F,F0,F1,PSGF2,F3,PSGFOK,PSGOROE1,PSGSD,SDT Q
 ;
FF ; up-arrow to another field
 S Y=-1 I '$D(PSGFOK) W $C(7),"  ??" Q
 S X=$E(X,2,99) I X=+X S Y=$S($D(PSGFOK(X)):X,1:-1) W "  " W:Y>0 $$CODES2^PSIVUTL(53.1,X) W:Y'>0 $C(7),"??" Q
 K DIC S DIC="^DD(53.1,",DIC(0)="QEM",DIC("S")="I $D(PSGFOK(+Y))" D ^DIC K DIC S Y=+Y I Y>0,Y=1!(Y=2)!(Y=5)!(Y=6) S:Y=2 FB=PSGF2_"^PSGOE3" S Y=Y_"^PSGOE31"
 Q
 ;
DEL ;
 W !?3,"SURE YOU WANT TO DELETE" S %=0 D YN^DICN I %'=1 W "  <NOTHING DELETED>"
 Q
