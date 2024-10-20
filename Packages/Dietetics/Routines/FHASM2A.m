FHASM2A ; HISC/REL - Target Weight - Metropolitan 83 ;Jan 04, 2023@08:31:34
 ;;5.5;DIETETICS;**8,20,27,55**;Jan 28, 2005;Build 7
M ; Metropolitan Height & Weight tables
 ; 1983 Metropolitan Life Insurance Company Height & Weight Tables
 ; as measured with 1" heels and clothes weighing 5# for men and 3# for women.
M1 S OFF=$S(SEX="M":H1-61,1:H1-43),A1=$P($T(MM1+OFF),";",$F("SML",FRM)+2)
 S W1=$P(A1,"-",1),W2=$P(A1,"-",2) G:METH="M" M3
 ; Target Weight for Spinal Cord Patients
 ; Nutrition Assessment of the Spinal Cord Injured Patient by
 ; Suzanne C Peiffer, R.D., Patricia Blust, R.D., and Jose Florante J Leyson
M2 W !!,"Extent of Injury:",!!?7,"P   Paraplegic",!?7,"Q   Quadriplegic"
 W !!,"Select: ",FHSPC,"//" R SP:DTIME I '$T!(SP["^") S FHQUIT=1 Q
 I SP="",FHSPC'="" S SP=FHSPC
 S X=SP D TR^FHASM1 S SP=X
 I SP'="P",SP'="Q" W !?3,*7,"Only P or Q are Valid Choices" G M2
 S FHSPC=SP
 S W1=W1-$S(SP="P":15,1:20),W2=W2-$S(SP="P":20,1:25)
M3 S W3=+$J(W1+W2/2,0,0),X1=$S(FHU'="M":W1,1:+$J(W1/2.2,0,1)),X2=$S(FHU'="M":W2,1:+$J(W2/2.2,0,1)),X3=$S(FHU'="M":W3,1:+$J(W3/2.2,0,1))
M4 W !!,"Select Target Weight (",X1,"-",X2,") ",X3,$S(FHU'="M":" lb",1:" kg"),"// " R X:DTIME I '$T!(X["^") S FHQUIT=1 Q
 I X="" S IBW=W3 Q
 D WGT^FHASM1 I Y<1 D WGP^FHASM1 G M4
 S IBW=+Y I IBW<W1!(IBW>W2) S METH="E"
 Q
 ;
ALRT ;process nutrition assessment alert.
 Q:'DFN    ;only inpt will have the alert
 Q:'$G(WRD)
 S WARD=$G(^DPT(DFN,.1)) Q:WARD=""
 S:'$G(FHDUZ) FHDUZ=""
 I $G(DT) S DTE=DT
 S FHSDT=DTE
 F FHPDT=FHSDT:0 S FHPDT=$O(^FHPT("E",FHPDT)) Q:FHPDT'>0  I $D(^FHPT("E",FHPDT,FHDFN)) D
 .S FHNAS=$O(^FHPT("E",FHPDT,FHDFN,0))
 .I $P($G(^FHPT(FHDFN,"N",FHNAS,"DI")),U,9)'=""!($P($G(^FHPT(FHDFN,"N",FHNAS,"DI")),U,5)<DTE) Q
 .Q:$P($G(^FHPT(FHDFN,"N",FHNAS,"DI")),U,6)'="C"
 .K XQA,XQAMSG,XQAOPT,XQAROU
 .;S XQAID="FH,"_$J_","_$H
 .S XQAID="FH,"_DFN_","_2 ;P55 use 2 for assessment alert
 .S XQAMSG=$E(FHPTNM,1,9)_" ("_$E(FHPTNM,1,1)_$P(FHSSN,"-",3)_"): "
 .S XQAMSG=XQAMSG_" has Assessment Follow-up Date on "_$E(FHPDT,4,5)_"/"_$E(FHPDT,6,7)_"/"_$E(FHPDT,2,3)
 .F A=0:0 S A=$O(^FH(119.6,WRD,2,A)) Q:A'>0  S TK=$P($G(^FH(119.6,WRD,2,A,0)),U,1),XQA(TK)=""
 .D SETUP^XQALERT
 .S $P(^FHPT(FHDFN,"N",FHNAS,"DI"),U,9)=FHSDT
 K XQA,XQAMSG,XQAOPT,XQAROU,TK,FHSDT,FHPDT,FHNAS,FHNAA
 ;
PHA ;process food/drug classification alert
 I $G(DT) S DTE=DT
 ;call Pharmacy API
 S PX=1 D DRUG^FHASM4
 S FHI9=""
 F  S FHI9=$O(PCLS(FHI9)) Q:FHI9=""  S FHP605=PCLS(FHI9) D
 .D AL1
 .Q:$G(FHALFLG)
 .K XQA,XQAMSG,XQAOPT,XQAROU
 .;S XQAID="FH,"_$J_","_$H
 .S XQAID="FH,"_DFN_","_1 ;P55 use 1 for assessment alert
 .S XQAMSG=$E(FHPTNM,1,9)_" ("_$E(FHPTNM,1,1)_$P(FHSSN,"-",3)_"): "
 .S XQAMSG=XQAMSG_"Food/drug interaction w/ "_FHI9
 .F A=0:0 S A=$O(^FH(119.6,WRD,2,A)) Q:A'>0  D
 ..S TK=$P($G(^FH(119.6,WRD,2,A,0)),U,1),XQA(TK)=""
 .D SETUP^XQALERT
 .S DIC="^FHPT("_FHDFN_",""D"",",DIC(0)="L",X=DT,DA(1)=FHDFN
 .K DD,DO D FILE^DICN I +Y<0 Q
 .S $P(^FHPT(FHDFN,"D",+Y,0),U,2)="S"
 .S $P(^FHPT(FHDFN,"D",+Y,0),U,3)=WRD
 .S $P(^FHPT(FHDFN,"D",+Y,0),U,4)=FHI9
 .K DIC
 K POP,PORD,PSCL605,PSNIEN,PSSTMP2,RMSDF,SCR,PCA,PCAL,PCNS,PCORD
 K FHAL,FHALDAT,FHALFLG,FHALWRD,FHDOB,FHFDNM,FHGMDT,FHI9,FHP605,FHPAL,FHPPA
 K XQA,XQAMSG,XQAOPT,XQAROU,TK,FHSDT,FHPDT,FHNAS,FHNAA,FHPPOR,FHPPNS
 Q
 ;
AL1 S FHALFLG=0
 F FHAL=0:0 S FHAL=$O(^FHPT(FHDFN,"D",FHAL)) Q:FHAL'>0  D
 .S FHALDAT=$G(^FHPT(FHDFN,"D",FHAL,0))
 .S FHFDNM=$P(FHALDAT,U,4),FHALWRD=$P(FHALDAT,U,3)
 .I FHALWRD=WRD,FHFDNM=FHI9 S FHALFLG=1
 Q
MM1 ;;62;128-134;131-141;138-150
 ;;63;130-136;133-143;140-153
 ;;64;132-138;135-145;142-156
 ;;65;134-140;137-148;144-160
 ;;66;136-142;139-151;146-164
 ;;67;138-145;142-154;149-168
 ;;68;140-148;145-157;152-172
 ;;69;142-151;148-160;155-176
 ;;70;144-154;151-163;158-180
 ;;71;146-157;154-166;161-184
 ;;72;149-160;157-170;164-188
 ;;73;152-164;160-174;168-192
 ;;74;155-168;164-178;172-197
 ;;75;158-172;167-182;176-202
 ;;76;162-176;171-187;181-207
MW1 ;;58;102-111;109-121;118-131
 ;;59;103-113;111-123;120-134
 ;;60;104-115;113-126;122-137
 ;;61;106-118;115-129;125-140
 ;;62;108-121;118-132;128-143
 ;;63;111-124;121-135;131-147
 ;;64;114-127;124-138;134-151
 ;;65;117-130;127-141;137-155
 ;;66;120-133;130-144;140-159
 ;;67;123-136;133-147;143-163
 ;;68;126-139;136-150;146-167
 ;;69;129-142;139-153;149-170
 ;;70;132-145;142-156;152-173
 ;;71;135-148;145-159;155-176
 ;;72;138-151;148-162;158-179
