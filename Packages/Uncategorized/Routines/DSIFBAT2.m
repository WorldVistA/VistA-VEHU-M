DSIFBAT2 ;DSS/RED - RPC FOR FEE BASIS BATCHES ;09/13/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,17,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;   Integration Agreements
 ;  2051  FIND^DIC                     10061 DEM^VADPT
 ; 10005  DT^DICRW                     5400        ^FBAA(161.27
 ;  2056  GETS^DIQ                     5275        ^FBAA(161.4  
 ;  5082  SITE^FBAACO                  5273        ^FBAA(161.7
 ;  5088  CNTTOT^FBAARB                5107        ^FBAAC(
 ;  5090  $$DATX^FBAAUTL,$$SSN^FBAAUTL 
 ;  5277  ^FBAAI(
 ;  5096  $$ADJLRA^FBCHFA           5278        ^FBAAV(    
 ;  5097  $$NAME^FBCHREQ2          5274        ^PRC(442
 ; 10103  $$FMTE^XLFDT               10076       ^XUSEC("FBAASUPERVISOR"
 ;  2171 - $$STA^XUAF4 ;
 ;Routine for APIs used in Fee Basis batches. RPC's: DSIF LIST BATCH ITEMS, DSIF RANGE OF BATCH STATUS
 Q
LISTBAT(FBOUT,FBBAT) ; RPC: DSIF BATCH LIST ITEMS
 ; Input: Batch # (IEN, if passed in as "nnn;" DSIF*3.2*1)
 ; Output:
 ;               If Type = B3 (Medical):
 ;   ^TMP($J,"DSIFBAT2",INV,0)="Invoice"^Invoice number^Invoice total
 ;                   INV,CNT,0)="Pat;count"^IEN;Patient Name^SSN (internal and ext)^Batch #^Date correct inv received^Vendor name^Vendor ID^XREF;Invoice^Vendor Invoice date^Adjustment reason number^suspension amount
 ;                   INV,CNT,1)="CPT"^Service Date^Service Provided^Claimed amt^Paid amt^Adj amt^FBID
 ;                   INV,CNT,2)="CPTMod"^CPT-Modifier(s)
 ;
 ;               If Type = B9 (Civil Hospital) 
 ;   ^TMP($J,"DSIFBAT2",CNT,0)=CNT^"ID"^PAT^SSN^Batch^Totals
 ;   ^TMP($J,"DSIFBAT2",CNT,1)=CNT^"Pat"^Vendor^Vendor ID^Invoice^Date Inv Received^Flag 
 ;            FLAG - * Reimbursement to Veteran; + Cancellation Activity; # Voided Payment
 ;   ^TMP($J,"DSIFBAT2",CNT,2)=CNT^"Date"^From date^To date^Amount claimed^Paid^Adjustment Flag^Discharge
 ;   ^TMP($J,"DSIFBAT2",CNT,3)=CNT^"FPPS"^FPPS Claim ID^FPPS Line
 ;   ^TMP($J,"DSIFBAT2",CNT,3+(N))=CNT^"DIAG"^ICD(N)[I];ICD(N)[E]^POA(N)[I];POA(N)[E] ;DSIF*3.2*2 
 ;   ^TMP($J,"DSIFBAT2",CNT,28+(M))=CNT^"Proc"^P(M) ;DSIF*3.2*2 
 ;   ^TMP($J,"DSIFBAT2",CNT,54)=CNT^"Check"^Check #^Date Paid^Interest^Amount paid altered to^Check cancelled on^Reason^Text
 ;   ^R=Check WILL be replaced or C=Check WILL be re-issued or X=Check WILL NOT be replaced ;DSIF*3.2*2 
 ;
 K FBOUT,^TMP($J,"DSIFBAT2")
 N A1,A2,B,CNT,FBAC,FBAACPT,D,CPTDESC,FBAP,FBFD,FBIN,FBINOLD,FBINTOT,FBMODLE,FBPDT,FBSC,FBTD,TAMT,FBERR,FBADJLR
 N FBVCHDT,FBVP,S,T,V,VID,ZS,FBTYPE,I,IENS,N,Y,FBCAN,FBCK,FBCANDT,FBCANR,FBDIS,FBCKDT,FBCKINT,FBID,FBADJLA,J,K,L,M,N
 N FBINPT,FBFPPSL,FBDX,FBFPPSC,FBMODZ,FBAAMPI,DSIFERR,FBLCNT,FBTOTAL,FBINDT,FBMOD
 K FBOUT S FBOUT=$NA(^TMP($J,"DSIFBAT2")) K @FBOUT
 I $G(FBBAT)="" S @FBOUT@(0)="-1^No Batch Number entered, quitting" Q
 D START^DSIFBAT1(.FBBAT) I FLAG S @FBOUT@(0)=FBERR Q
 S FBID="",FBTYPE=$P(Y(0),U,3),B=+Y,CNT=1,FBINOLD=0
 D NOT:FBTYPE="B5",NOT:FBTYPE="B2"
 I FBTYPE="B9" S CHBAT=B D B9^DSIFBAT6 Q
ENM ; @FBOUT@(0) Code remove, code left for future use.
 S (FBIN,FBINDT,FBINOLD)="",(DSIFERR,FBINTOT)=0 F FBIN=0:0 S FBIN=$O(^FBAAC("AJ",B,FBIN)) Q:FBIN=""  F J=0:0 S J=$O(^FBAAC("AJ",B,FBIN,J)) Q:J'>0  D GMORE^DSIFBAT7,INTOT Q:DSIFERR
 I '$D(@FBOUT) S @FBOUT@(0)="-1^No items in batch"
 Q
NOT S @FBOUT@(0)="-1^These Batches: "_FBTYPE_" not supported at this time." Q
SETT S DFN=J D DEM^VADPT S N=VADM(1),S=+VADM(2),A2=$P(Y(0),"^",3),D=$P(Y(0),"^",1) K VA,VADM D FBCKT(J,K),CMORE Q
 Q
FBCKT(J,K) I 'J!('K) S (FBCAN,FBCK,FBCANDT,FBCANR,FBDIS,FBCKDT,FBCKINT)="" Q
 S FBCKIN=$G(^FBAAC(J,3,K,0)),FBCAN=$P(FBCKIN,"^",10),FBCK=$P(FBCKIN,"^",7),FBCANDT=$P(FBCKIN,"^",8),FBCANR=$P(FBCKIN,"^",9),FBDIS=$P(FBCKIN,"^",11),FBCKDT=$P(FBCKIN,"^",6),FBCKINT=$P(FBCKIN,"^",12)
 K FBCKIN Q
INTOT ;
 S @FBOUT@(FBIN,0)="Invoice"_U_FBIN_U_$J(FBINTOT,1,2) S FBINTOT=0 Q
 Q
WRT ;Get external modifier data only
 S FBMOD="",B(1617)=$S(B="":"",$D(^FBAA(161.7,B,0)):$P(^(0),"^"),1:"")
 S @FBOUT@(FBIN,CNT,2)="CPTMod"_U_$TR(FBMODLE,",",U)
 S @FBOUT@(FBIN,CNT,0)="Pat;"_CNT_U_J_";"_N_U_S_";"_$$SSN^FBAAUTL(J)_U_B(1617)_U_$G(FBVCHDT)_";"_$$DATX^FBAAUTL($G(FBVCHDT))_U_K_";"_V_U_VID_U_FBIN_";"_$G(FBINPT)_U_FBIN(1)_";"_$$DATX^FBAAUTL(FBIN(1))
 I FBTYPE="B3" S @FBOUT@(FBIN,CNT,1)="CPT"_U_D_";"_$$DATX^FBAAUTL(D)_U_$G(FBAACPT)_U_$G(CPTDESC)_U_$G(FBFPPSC)_U_$G(FBFPPSL)_U_FBID
 I FBTYPE="B5" S @FBOUT@(FBIN,CNT,1)="CPT"_U_D_";"_$$DATX^FBAAUTL(D)_U_$G(FBAACPT)_U_$G(CPTDESC)_U_$G(FBFPPSC)_U_$G(FBFPPSL)_U_FBID
 S @FBOUT@(FBIN,CNT,0)=@FBOUT@(FBIN,CNT,0)_U_$J(A1,6)_U_$J(A2,6)
 S @FBOUT@(FBIN,CNT,0)=@FBOUT@(FBIN,CNT,0)_U_$S($G(FBADJLR)]"":$G(FBADJLR),1:T)
 S @FBOUT@(FBIN,CNT,0)=@FBOUT@(FBIN,CNT,0)_U_$S($G(FBADJLA)]"":$G(FBADJLA),1:$G(TAMT))
 S FBINOLD=FBIN Q
CMORE N FBFPPSC,FBFPPSL,FBX,FBY3
 S K=$P(Z(0),"^",3),J=$P(Z(0),"^",4) D ENV S N=$$NAME^FBCHREQ2(J),S=$$SSN^FBAAUTL(J),FBIN=I,FBAC=$P(Z(0),"^",8)+.0001,FBAP=$P(Z(0),"^",9)+.0001,FBVP=$P(Z(0),"^",14),ZS=$P(Z(0),"^",13)
 S FBAC=$P(FBAC,".",1)_"."_$E($P(FBAC,".",2),1,2),FBAP=$P(FBAP,".",1)_"."_$E($P(FBAP,".",2),1,2)
 S FBSC=$P(Z(0),"^",11),FBSC=$S(FBSC="":"",$D(^FBAA(161.27,FBSC,0)):$P(^(0),"^",1),1:""),FBFD=$P(Z(0),"^",6),FBTD=$P(Z(0),"^",7) S FBPDT=FBFD D CDAT S FBFD=FBPDT,FBPDT=FBTD D CDAT S FBTD=FBPDT
 S FBY3=$G(^FBAAI(I,3)),FBFPPSC=$P(FBY3,U),FBFPPSL=$P(FBY3,U,2),FBX=$$ADJLRA^FBCHFA(I_","),FBADJLR=$P(FBX,U)
 D FBCKI(I) S B(1617)=$S(B="":"",$D(^FBAA(161.7,B,0)):$P(^(0),"^"),1:""),FBIN(1)=$P(Z(0),"^",2) D WRITC^DSIFBAT3
 Q
CDAT S FBPDT=FBPDT_";"_$E(FBPDT,4,5)_"/"_$S($E(FBPDT,6,7)="00":$E(FBPDT,2,3),1:$E(FBPDT,6,7)_"/"_$E(FBPDT,2,3)) Q
ENV S (V,VID)="" I K]"" S V=$S($D(^FBAAV(K,0)):$P(^(0),"^",1),1:""),VID=$S(V]"":$P(^(0),"^",2),1:"") Q
FBCKI(FBI) I '$G(FBI) S (FBCKDT,FBCK,FBCANDT,FBCANR,FBCAN,FBDIS,FBCKINT)="" Q
 S FBCKIN=$G(^FBAAI(FBI,2))
 S FBCKDT=+FBCKIN,FBCK=$P(FBCKIN,U,4),FBCANDT=$P(FBCKIN,U,5),FBCANR=$P(FBCKIN,U,6),FBCAN=$P(FBCKIN,U,7),FBDIS=$P(FBCKIN,U,8),FBCKINT=$P(FBCKIN,U,9) K FBCKIN
 Q
RANGEBAT(FBOUT,FBRANGE) ;  RPC:  DSIF BATCH RANGE OF STATUS
 ;Input:  range of batch #, format of n-nnn (or n)  
 ;Output:  ^TMP($J,"DSIFBAT2",0)=1 (or -1^message)  
 ;                                          count)=Batch IEN;Batch #^Obligation #^Fee program^Status
 N LIST,MSG,ADAT,NUM,FLAG,BATCH,FOUND,PO,REF,SITE
 K FBOUT,^TMP($J,"DSIFBAT2") S (NUM,FLAG,FOUND)=0,FBOUT=$NA(^TMP($J,"DSIFBAT2"))
 I $P(FBRANGE,"-",2)="" S FBRANGE=FBRANGE_"-"_FBRANGE
 I FBRANGE'?.N1"-".N!(+FBRANGE<0) S @FBOUT@(0)="-1^Not a valid range of batches" Q
 F NUM=$P(FBRANGE,"-"):1:$P(FBRANGE,"-",2) S IENS=$O(^FBAA(161.7,"B",NUM,"")) D
 . Q:'$D(^FBAA(161.7,"B",NUM))
 . K ADAT,LIST,MSG D GETS^DIQ(161.7,IENS_",",".01;1;2;11","IE","LIST","MSG") S ADAT=$NA(LIST(161.7,IENS_","))
 . I $D(MSG) S FLAG=1,@FBOUT@(0)="-1^File error experienced, with batch: "_IENS Q
 . S @FBOUT@(IENS)=IENS_";"_$G(@ADAT@(.01,"I"))_U_$G(@ADAT@(1,"I"))_U_$G(@ADAT@(2,"E"))_U_$G(@ADAT@(11,"E"))
 . I 'FOUND S FOUND=1
 K ADAT,LIST S:'FOUND @FBOUT@(1)="-1^No Batch numbers found for the range of numbers: "_FBRANGE
 Q
LISTSTAT(DSIFOUT,FBSTAT,FBPRO,STRTDT,ENDDT) ;  RPC: DSIF BATCH LIST BY STATUS
 ;Input:  FBSTAT = (*req)Batch Status, FBRPO = (*req)Prog, STRTDT =  (*opt)Date to start display (default ALL), ENDDT = (*opt)Date to end list (ALL)
 ;Output:  ^TMP($J,"DSIFBAT2",0)="-1^error message"
 ;                                         Status,Batch)=Batch IEN;Batch #^Obligation #^Fee program^Status^User opened^Lines allowed;Lines^FCP
 N I,J,COUNT,IENS,FCP,IEN,LIST,MSG,ADAT,FLAG,NUM,FLAG,BATCH,FBSUP,FBLCNT,FBAAMPI,DSIFST,FBDX,FBSITE,DSIFPO
 K DSIFOUT S DSIFOUT=$NA(^TMP($J,"DSIFBAT2")) K @DSIFOUT
 I $G(DT)="" D DT^DICRW
 I $G(DUZ)="" S @DSIFOUT@(0)="-1^Invalid or undefined user" Q
 S FBSUP=0 I $D(^XUSEC("FBAASUPERVISOR",DUZ)) S FBSUP=1
 S (COUNT,FLAG,IENS)=0,FCP=""
 S:$G(FBPRO)="" FBPRO="*"
 S:$G(STRTDT)="" STRTDT="3000101" S:$G(ENDDT)="" ENDDT=DT_".999999" I ENDDT<STRTDT S @DSIFOUT@(0)="-1^End date must be greater than start date" Q
 S:$P(ENDDT,".",2)="" ENDDT=ENDDT_".9999999"  ;DSIF*3.2*8 fix due to FB*3.5*117
 F I=1:1:$L(FBSTAT,U) I "C^O^S^T^A^V^P^R"'[$P(FBSTAT,U,I) S @DSIFOUT@(0)="-1^"_$P(FBSTAT,U,I)_" Is Not a valid batch status" Q
 D SITE^FBAACO S SITE=$$STA^XUAF4($P($G(FBSITE(1)),U,3)) I SITE="" S @DSIFOUT@(1)="-1^Site parameters not set, no site defined" Q
 S FBAAMPI=$P($G(^FBAA(161.4,1,"FBNUM")),"^",3),FBAAMPI=$S(FBAAMPI]"":FBAAMPI,1:100)
 I $P(FBSTAT,U,2)="" S $P(FBSTAT,U,2)=""
 F J=1:1:$L(FBSTAT,U) Q:$P(FBSTAT,U,J)=""  S IEN=0 F  S IEN=$O(^FBAA(161.7,"AC",$P(FBSTAT,U,J),IEN)) Q:IEN<1!(FLAG)  D
 . S DSIFST=$P(FBSTAT,U,J)
 . N Y,P S Y(0)=$G(^FBAA(161.7,IEN,0)),P=$S(DSIFST="O":4,DSIFST="T":14,DSIFST="V":12,DSIFST="S":6,DSIFST="C":13,1:4)
 . Q:'P
 . I $P(Y(0),U,5)'=DUZ,'FBSUP Q
 . Q:$P(Y(0),U,P)<STRTDT!($P(Y(0),U,P)>ENDDT)
 . S IENS=IEN_",",LIST="^TMP($J,"_"""GETS"""_")"  ; changed to use global nodes
 . K ADAT,^TMP($J,"GETS"),MSG
 . D GETS^DIQ(161.7,IENS,".01;1;2;4;11","IE",.LIST,"MSG") S ADAT=$NA(@LIST@(161.7,IENS))
 . I $D(MSG) S FLAG=1 S @DSIFOUT@($P(FBSTAT,U,J),0)="-1^error message follows for Batch IEN: "_IENS M @DSIFOUT@($P(FBSTAT,U,J),IENS)=MSG Q
 . D CNTTOT^FBAARB(IEN) ;Get number of payments and total
 . I $G(FBPRO)'="*",($G(@ADAT@(2,"I"))'=FBPRO) Q
 . K DSIFPO,^TMP("PO",$J) S DSIFPO=$NA(^TMP("PO",$J))
 . S COUNT=COUNT+1,PO=SITE_"-"_$G(@ADAT@(1,"E"))
 . I $G(PO)="" S PO="N/A"
 . I $D(^PRC(442,"B",PO)) D FIND^DIC(442,"","@;1","",PO,"","B","","",DSIFPO) S FCP=$P($G(DSIFPO("PO",$J,"DILIST","ID",1,1))," ")
 . I $G(FCP)="" S FCP="N/A"
 . S @DSIFOUT@(DSIFST_IEN)=$G(@ADAT@(4,"I"))_";"_$G(@ADAT@(4,"E"))_U_$G(FBAAMPI)_";"_$G(FBLCNT)_U_$G(FCP)
 . S @DSIFOUT@(DSIFST_IEN)=IEN_";"_$G(@ADAT@(.01,"I"))_U_$G(@ADAT@(1,"I"))_U_$G(@ADAT@(2,"I"))_";"_$G(@ADAT@(2,"E"))_U_$G(@ADAT@(11,"E"))
 . S @DSIFOUT@(DSIFST_IEN)=@DSIFOUT@(DSIFST_IEN)_U_$G(@ADAT@(4,"I"))_";"_$G(@ADAT@(4,"E"))_U_$G(FBAAMPI)_";"_$G(FBLCNT)_U_$G(FCP)
 K ADAT,^TMP($J,"GETS") S @DSIFOUT@(0)="1^Record count^"_COUNT
 I 'COUNT D
 . S @DSIFOUT@(1)="-1^No batch(s) found with a status of: '"_$S($P(FBSTAT,U,2)'="":FBSTAT,1:$P(FBSTAT,U))_"'"
 . I STRTDT S @DSIFOUT@(1)=@DSIFOUT@(1)_" from "_$$FMTE^XLFDT(STRTDT,5)
 . I ENDDT S @DSIFOUT@(1)=@DSIFOUT@(1)_" to "_$$FMTE^XLFDT(ENDDT,5)
 Q
