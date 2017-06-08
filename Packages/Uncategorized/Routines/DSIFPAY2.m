DSIFPAY2 ;DSS/RED - RPC FOR FEE BASIS PAYMENTS ;12/31/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**8**;Jun 05, 2009;Build 29
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ; 10018  ^DIE
 ; 10013  ^DIK
 ;  2056  $$GET1^DIQ
 ;  5081  FBCKO^FBAACCB2,PMNT^FBAACCB2
 ;  5085  $$ADJLRA^FBAAFA
 ;  5086  $$RRL^FBAAFR
 ;  5088  CNTTOT^FBAARB
 ;  5089  $$CKSPLIT^FBAARR
 ;  5090  GETNXI^FBAAUTL
 ;  5091  $$CPT^FBAAUTL4,$$MODL^FBAAUTL4
 ;  1995  $$CPT^ICPTCOD
 ; 10103  $$FMTE^XLFDT
 ;  
 Q
EN1(FBOUT,DFN,DA,DSDOS,DSCPT) ; DSIF PAY ALL PAYMENTS DISPLAY
 ; Input:  DFN - Fee Basis Patient IEN, DA - Fee Basis Vendor IEN, DSDOS - Date of Service FM (optional), DSCPT - CPT external (Optional, but date of service must be entered)
 ; Output: FBOUT(0)="1^DFN;VENDOR IEN  [or]  -1^error
 ;            FBOUT(1)="Demog"^Patient Name^SSN^VENDOR^Obligation Number 
 ;            FBOUT(2,CNT)="ID"^ID^FLAGS^SVC DATE^CPT-MOD^REV.CODE^UNITS^PATIENT ACCOUNT NO.^INVOICE #^BATCH #^
 ;                       AMT CLAIMED^AMT PAID^ADJ CODE^ADJ AMOUNT^REMIT REMARK^FPPS Claim ID^FPPS Line Item 
 ;    FLAGS - ('*' Reimb. to Patient  '+' Cancel. Activity   '#' Voided Payment)" 
 ;
 N DSIFERR,FBAARCE,FBADJLA,FBADJLR,FBCSID,FBFPPSC,FBFPPSL,FBRRMKL,FBUNITS,A1,A2,B1,B2,DIC,FBAACPT,FBAADT,FBCAN,FBCPT,FBIN,DSIFCPT
 N FBY2,FBY3,TAMT,CNT,FBAAOUT,FBMODLE,FBST,ID,V,L,ZS K FBOUT
 I '$D(^FBAAC(DFN,1,DA,1)) S FBOUT(0)="-1^Invalid vendor for this patient" Q
 S DSDOS=$G(DSDOS),DSCPT=$G(DSCPT),DSIFCPT="",DSIFERR=0 D DEM^VADPT
 S FBOUT(0)="1^"_DFN_";"_DA_";",FBST=$P(^FBAAV(DA,0),"^",5)
 S FBOUT(1)="Demog"_U_$G(VADM(1))_U_+$G(VADM(2))_U_$P(^FBAAV(DA,0),"^",1)_U_$P(^FBAAV(DA,0),"^",3)_U_$P(^FBAAV(DA,0),"^",4)_", "_$P($G(^DIC(5,+FBST,0)),U)_"   "_$P(^FBAAV(DA,0),"^",6)
 I DSCPT'="",DSDOS="" S FBOUT(1)="-1^Date of service MUST be entered if CPT code is entered" Q
 I DSCPT'="" D  Q:DSIFERR
 . S DSIFCPT=$$CPT^ICPTCOD(DSCPT,DSDOS) I +DSIFCPT=-1 S DSIFERR=1,FBOUT(0)="-1^"_$S(DSIFCPT["NO SUCH":"-1^Invalid CPT Code "_DSCPT_" entered",1:DSCPT) Q
 . I $P(DSIFCPT,U,7)'=1 S DSIFERR=1,FBOUT(0)="-1^CPT code was inactive on date of service: "_$$FMTE^XLFDT(DSDOS) Q
 S CNT=2,FBAAOUT=0
 F B=0:0 S B=$O(^FBAAC(DFN,1,DA,1,B)) Q:'B  D
 . I DSDOS'="",+^FBAAC(DFN,1,DA,1,B,0)'=DSDOS Q
 . S ID=DFN_";"_DA_";"_B,FBOUT(CNT)="ID"_U_ID_U_U_$P(^FBAAC(DFN,1,DA,1,B,0),"^",1)_";"_$$FMTE^XLFDT($P(^FBAAC(DFN,1,DA,1,B,0),"^",1),5)
 . F K=0:0 S K=$O(^FBAAC(DFN,1,DA,1,B,1,K)) Q:'K!(FBAAOUT)  D
 .. I DSIFCPT'="",+^FBAAC(DFN,1,DA,1,B,1,K,0)'=+DSIFCPT Q
 .. S L=^FBAAC(DFN,1,DA,1,B,1,K,0) D MORE,WRT
 K B,K,D,T,L Q
WRT S FBAADT=$P(^FBAAC(DFN,1,DA,1,B,0),"^",1),FBAADT=FBAADT_";"_$$FMTE^XLFDT(FBAADT,5),B1=$P(L,"^",8),B2=$S(B1="":"",$D(^FBAA(161.7,B1,0)):$P(^FBAA(161.7,B1,0),"^",1),1:"")
 S FBMOD="",TAMT=$FN($P(L,U,4),"",2),ID=DFN_";"_DA_";"_B_";"_K
 S A1=$P(L,"^",2)+.0001,A2=$P(L,"^",3)+.0001,A1=$P(A1,".",1)_"."_$E($P(A1,".",2),1,2),A2=$P(A2,".",1)_"."_$E($P(A2,".",2),1,2),FBIN=$P(L,"^",16)
 S FBAACPT=$$CPT^FBAAUTL4($P(L,"^",1))
 S FBUNITS=$P(FBY2,U,14),FBCSID=$P(FBY2,U,16),FBFPPSC=$P(FBY3,U),FBFPPSL=$P(FBY3,U,2)
 D FBCKO^FBAACCB2(DFN,DA,B,K)
 I FBMODLE'="" S FBMOD=$TR(FBMODLE,",",";")
 S FBOUT(CNT)="ID"_U_ID_U_$S(ZS="R":"*",1:"")_$S(V="VP":"#",1:"")_$S($G(FBCAN)]"":"+",1:"")_U_FBAADT_U_FBAACPT_$S($G(FBMOD)]"":"-"_FBMOD,1:"")_U_FBAARCE_U_FBUNITS_U_FBCSID_U_FBIN_U_B2
 S FBOUT(CNT)=FBOUT(CNT)_U_A1_U_A2,FBOUT(CNT)=FBOUT(CNT)_U_$S(FBADJLR]"":FBADJLR,1:T),FBOUT(CNT)=FBOUT(CNT)_U_$S(FBADJLA]"":FBADJLA,1:TAMT)_U_FBRRMKL
 I FBFPPSC]"" S FBOUT(CNT)=FBOUT(CNT)_U_FBFPPSC_U_FBFPPSL
 D PMNT^FBAACCB2 S CNT=CNT+1 Q
MORE N FBX S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_DFN_",1,"_DA_",1,"_B_",1,"_K_",""M"")","E")
 S T=$P(L,"^",5),T=$S(T>9:$P(^FBAA(161.27,T,0),"^"),1:T),ZS=$P(L,"^",20),V=$P(L,"^",21)
 S FBY2=$G(^FBAAC(DFN,1,DA,1,B,1,K,2)),FBY3=$G(^FBAAC(DFN,1,DA,1,B,1,K,3))
 S FBX=$$ADJLRA^FBAAFA(K_","_B_","_DA_","_DFN_","),FBADJLR=$P(FBX,U),FBADJLA=$P(FBX,U,2)
 S FBRRMKL=$$RRL^FBAAFR(K_","_B_","_DA_","_DFN_","),FBAARCE=$$GET1^DIQ(162.03,K_","_B_","_DA_","_DFN_",",48)
 Q
 ;
NEWINV(FBOUT) ;RPC:  DSIF PAY CREATE INVOICE
 K FBOUT N FBAAIN D GETNXI^FBAAUTL I $G(FBAAIN) S FBOUT="Invoice # "_U_FBAAIN
 E  S FBOUT="-1^No invoice assigned"
 Q
 ;
DELPAY(FBOUT,FBID) ;  RPC: DSIF PAY DELETE PAYMENT
 ;Input:  FBID=IEN of Fee Basis Patient file:(1)^IEN of fee basis vendor:(2)^IEN of Initial treatment date:(3)^IEN of service provided:(4)^Batch number:(5)
 N DFN,FBV,FBSERV,DIK,DIRUT,FBAABE,FBAACPI,FBAAOPA,FBAAOBN,FBAAODUZ,FBAAOPA,FBSD,FY,Y K FBOUT
 S DFN=$P(FBID,U),FBV=$P(FBID,U,2),FBSD=$P(FBID,U,3),FBCPT=$P(FBID,U,4),FBAABE=$P(FBID,U,5)
 I DFN="" S FBOUT="-1^Patient number not entered" Q
 I '$D(^FBAAC(DFN,FBV,"AD")) S FBOUT="-1^Vendor has no prior claims" Q
 I FBSD="" S FBOUT="-1^No service provided date entered" Q
 I FBCPT="" S FBOUT="-1^No CPT service provided entered" Q
 I FBAABE="" S FBOUT="-1^No batch number entered, quitting" Q
 I '$D(^FBAA(161.7,FBAABE,0))!($P($G(^FBAAC(DFN,1,FBV,1,FBSD,1,FBCPT,0)),U,8)'=FBAABE) S FBOUT="-1^Invalid batch number entered" Q
 I '$D(^FBAAC(DFN,1,FBV,1,FBSD,1,FBCPT)) S FBOUT="-1^Invalid record entry, cannot delete" Q
 S DIC="^FBAAC("_DFN_",1,"_FBV_",1,"_FBSD_",1,",DA(3)=DFN,DA(2)=FBV,DA(1)=FBSD,(FBAACPI,DA)=FBCPT,Y=FBCPT_U_FBSD,Y(0)=DIC_FBCPT_",0)" D
 . S FBAAOPA=$S($P(Y,"^",3)=1:0,$D(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,0)):$P(@Y(0),"^",3),1:0),FBAAODUZ=$P(@Y(0),"^",7),FBAAOBN=$P(@Y(0),"^",8)
 . ;S FY=$E(FBAADT,1,3)+1700+$S($E(FBAADT,4,5)>9:1,1:0)
 I DUZ'=FBAAODUZ&('$D(^XUSEC("FBAASUPERVISOR",DUZ))) S FBOUT="-1^Supervisor key is required" Q
 I FBAABE,FBAABE'=FBAAOBN S FBOUT="-1^Sorry, that payment is not in the Batch you selected!" Q
 S DIK=DIC D ^DIK D  K B,J,K
 . S (FBLCNT,FBTOTAL)=0
 . I +$G(FBAABE) D CNTTOT^FBAARB(+FBAABE) D
 ..S DA=+FBAABE,DIE="^FBAA(161.7,",DR="10////^S X=FBLCNT;8////^S X=FBTOTAL;S:FBLCNT!(FBTOTAL) Y="""";9///@" D ^DIE K DIE,DR
 ..S:FBTOTAL=0 $P(^FBAA(161.7,+FBAABE,0),U,9)=""
 ..S:FBLCNT=0 $P(^FBAA(161.7,+FBAABE,0),U,11)=""
 S FBOUT="1^Payment record Deleted!"
 Q 
ALLMEDR(FBOUT,FBOLDB,FBNEWB) ;  RPC: DSIF PAY FIX REJ LINE ITEMS
 ; Input:  FBOLDB = Old batch IEN, FBNEWB = New Batch IEN
 ; Outut: ^TMP($J,"DSIFPAY6",FBIN[Old invoice #],0)="Split"^Split message
 ;                                        FBIN,2)="Void"^void invoice message
 ;                                        "Z")="Status"^all items except noted were re-initiated
 ;                                 0)="-1"^error message
 K FBILM,FBOUT,^TMP($J,"DSIFPAY6") N CNT,FBNB,FBRJV,FZ,M,TM1,TM2
 S CNT=0,FZ=$G(^FBAA(161.7,FBOLDB,0)),FBOUT=$NA(^TMP($J,"DSIFPAY6"))
 S B=$G(FBOLDB),FBNB=$G(FBNEWB) I 'FBOLDB,('FBNEWB) S @FBOUT@(0)="-1^No Batch selected, old: "_$G(FBOLDB)_" New Batch: "_$G(FBNEWB) Q 
 I '$D(^FBAAC("AH",B))!('$D(^FBAAC(FBNB))) S @FBOUT@(0)="-1^Invalid Batch selected" Q
 S (TM1,TM2)=0 F J=0:0 S J=$O(^FBAAC("AH",B,J)) Q:'J  F K=0:0 S K=$O(^FBAAC("AH",B,J,K)) Q:'K  F L=0:0 S L=$O(^FBAAC("AH",B,J,K,L)) Q:'L  F M=0:0 S M=$O(^FBAAC("AH",B,J,K,L,M)) Q:'M  D REJM
 I $$CKSPLIT^FBAARR(B,.FBILM) S @FBOUT@(FBIN,0)="Split^Some items were split"
ADONE S $P(FZ,U,9)=($P(FZ,U,9)+TM1),$P(FZ,U,11)=($P(FZ,U,11)+TM2),^FBAA(161.7,FBNB,0)=FZ I '$G(FBRJV) S $P(^FBAA(161.7,B,0),U,17)="" W !!,"All rejected items have been re-initiated!" Q
 I $G(FBRJV) S @FBOUT@("Z")="Status^All rejected items (except for voided payments) have been re-initiated!" Q
REJM I $P(^FBAAC(J,1,K,1,L,1,M,0),U,21)="VP" S FBIN=+$P(^(0),U,16) D VOID(FBIN) S FBRJV=1 D END Q
 S $P(^FBAAC(J,1,K,1,L,1,M,0),U,8)=FBNB,FBIN=+$P(^(0),U,16),^FBAAC("AC",FBNB,J,K,L,M)="" K ^FBAAC("AH",B,J,K,L,M),^FBAAC(J,1,K,1,L,1,M,"FBREJ")
 S FBILM(FBIN,M_","_L_","_K_","_J_",")="",TM1=TM1+$P(^FBAAC(J,1,K,1,L,1,M,0),U,3),TM2=TM2+1
 S ^FBAAC("AJ",FBNB,FBIN,J,K,L,M)=""
 Q
VOID(IEN) S CNT=CNT+1,@FBOUT@(IEN,2)="Void^"_FBIN_U_"Invoice #: "_FBIN_" has a status of VOID.  Please delete the VOID before re-initiating this rejected payment."
END I '$D(^FBAAC("AH",B)) S $P(^FBAA(161.7,B,0),U,17)="" I $$CKSPLIT^DSIFPAY6(B,.FBILM) S @FBOUT@(FBIN,0)="Split^Some items were split"
 Q
BATPAY(FBOUT,BATCH) ;RPC: DSIF BATCH PAYMENTS DISPLAY
 ;Input:  Batch IEN  Output:  ^TMP($J,"DSIFPAY2",0) = "Batch"^Batch IEN;Batch number^Items count  (or error message)
 ;                           ,ID,0) = "ID"^ID^Obligation Number [ID is Patient IEN;Vendor IEN;Date of service IEN;Service provided IEN]
 ;                             ,1) = "Demog"^Patient Name^SSN^Vendor name^Vendor ID^Invoice #^Voucher date
 ;                            ,1,n) = "Data"^FLAGS^SVC DATE^CPT^Service provided^FPPS Claim ID^FPPS Line #^UNITS^PATIENT ACCOUNT NO.
 ;                            ^INVOICE #^BATCH #^AMT CLAIMED^AMT PAID^ADJ CODE^ADJ AMOUNT^REMIT REMARK^FPPS Claim ID^FPPS Line Item                                     
 K FBOUT,^TMP($J,"DSIFPAY2") S FBOUT=$NA(^TMP($J,"DSIFPAY2"))
 N DFN,DA,B,K,CNT,FLAG,L,TCNT S (TCNT,FLAG)=0
 S DFN="" F  S DFN=$O(^FBAAC("AC",BATCH,DFN)) Q:'DFN  D
 . S FLAG=1 F DA=0:0 S DA=$O(^FBAAC("AC",BATCH,DFN,DA)) Q:'DA  D
 . . F B=0:0 S B=$O(^FBAAC("AC",BATCH,DFN,DA,B)) Q:'B  D
 . . . S CNT=1 F K=0:0 S K=$O(^FBAAC("AC",BATCH,DFN,DA,B,K)) Q:'K  S L=$G(^FBAAC(DFN,1,DA,1,B,1,K,0)) D MORE,OUTPUT
 I TCNT S @FBOUT@(0)="Batch^"_BATCH_";"_$P(^FBAA(161.7,BATCH,0),U)_U_TCNT
 I 'TCNT S @FBOUT@(0)="-1^None found for batch: "_BATCH Q
 Q
OUTPUT S FBST=$P(^FBAAV(DA,0),"^",5)
 D DEM^VADPT
 S ID=DFN_";"_DA_";"_B_";"_K,@FBOUT@(ID,0)="ID^"_ID_U_$P(^FBAAC(DFN,1,DA,1,B,1,K,0),"^",10)
 S FBAADT=$P(^FBAAC(DFN,1,DA,1,B,0),"^",1),FBAADT=FBAADT_";"_$$FMTE^XLFDT(FBAADT,5),B1=$P(L,"^",8),B2=$S(B1="":"",$D(^FBAA(161.7,B1,0)):$P(^FBAA(161.7,B1,0),"^",1),1:"")
 S TAMT=$FN($P(L,U,4),"",2),A1=$P(L,"^",2)+.0001,A2=$P(L,"^",3)+.0001,A1=$P(A1,".",1)_"."_$E($P(A1,".",2),1,2),A2=$P(A2,".",1)_"."_$E($P(A2,".",2),1,2),FBIN=$P(L,"^",16)
 S FBAACPT=$$CPT^FBAAUTL4($P(L,"^",1)),FBUNITS=$P(FBY2,U,14),FBCSID=$P(FBY2,U,16),FBFPPSC=$P(FBY3,U),FBFPPSL=$P(FBY3,U,2)
 S @FBOUT@(ID,1)="Demog"_U_$G(VADM(1))_U_+$G(VADM(2))_U_$P(^FBAAV(DA,0),"^",1)_U_$P(^FBAAV(DA,0),"^",2)_U_FBIN_U_$P(^FBAAC(DFN,1,DA,1,B,0),"^")_";"_$$FMTE^XLFDT($P(^FBAAC(DFN,1,DA,1,B,0),"^"),5)
 D FBCKO^FBAACCB2(DFN,DA,B,K)
 S @FBOUT@(ID,1,CNT)="Data^"_$S(ZS="R":"*",1:"")_$S(V="VP":"#",1:"")_$S($G(FBCAN)]"":"+",1:"")_U_FBAADT_U_FBAACPT_U_$P($$CPT^ICPTCOD(FBAACPT),U,3)_U_$P($G(^FBAAC(DFN,1,DA,1,B,1,K,3)),"^",1)_U_$P($G(^FBAAC(DFN,1,DA,1,B,1,K,3)),"^",2)
 S @FBOUT@(ID,1,CNT)=@FBOUT@(ID,1,CNT)_U_A1_U_A2_U_$S(FBADJLR]"":FBADJLR,1:T)
 S @FBOUT@(ID,1,CNT)=@FBOUT@(ID,1,CNT)_U_$S(FBADJLA]"":FBADJLA,1:TAMT)_U_FBRRMKL
 I FBFPPSC]"" S @FBOUT@(ID,1,CNT)=@FBOUT@(ID,1,CNT)_U_FBFPPSC_U_FBFPPSL
 D PMNT^FBAACCB2 S CNT=CNT+1,TCNT=TCNT+1
 D KVAR^VADPT
 Q
