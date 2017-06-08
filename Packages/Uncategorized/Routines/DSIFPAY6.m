DSIFPAY6 ;DSS/RED - RPC FOR FEE BASIS PAYMENTS ;12/31/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,8**;Jun 05, 2009;Build 29
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ; 10009  FILE^DICN
 ; 10005  DT^DICRW
 ;  2053  FILE^DIE
 ;  5081  FBCKO^FBAACCB2,PMNT^FBAACCB2
 ;  5085  $$ADJLRA^FBAAFA
 ;  5090  $$SSN^FBAAUTL,GETNXB^FBAAUTL,GETNXI^FBAAUTL
 ;  5091  $$CPT^FBAAUTL4,$$MODL^FBAAUTL4
 ;  5277  ^FBAAI("AH",B,ID)
 ; 10103  $$FMTE^XLFDT
 ;
 Q    ;no direct calls to the routine
 ;
GETREJ(FBOUT) ; RPC: DSIF PAY GET REJECT ITEMS
 ; Output:  ^TMP($J,"DSIFPAY6",BIEN,0)="Batch"^IEN of Batch^Batch number^Control Point^Batch #^Voucher Date^ Vendor Name^
 ;                                         Vendor ID^Invoice #^Date Rec'd.
 ;             ^TMP($J,"DSIFPAY6,BIEN,CNT,1)="Patient"^Line count")"^Patient name^SSN^Batch IEN;Batch number^Date received^Vendor Name^
 ;                                         Vendor ID^Invoice #^Date Rec'd.^Record ID^Service date^CPT Modifiers^Service Provided^
 ;                                         FPPS claim^FPPS line
 ;             ^TMP($J,"DSIFPAY6,BIEN,CNT,"REJ")="Reject"^Reject reason^Old batch #
 K FBOUT,^TMP($J,"DSIFPAY6")
 N FLAG,CNT,B,J,N,TAMT,C,CPTDESC,D,DIRUT,DLAYGO,ERR,FBAACP,FBAACPT,A1,A2,FBIN,DFN
 S FBOUT=$NA(^TMP($J,"DSIFPAY6")),(C,T,CNT,FLAG,FBINTOT)=0
 N I F B=0:0 S B=$O(^FBAA(161.7,B)) Q:B<1  D
 . S FLAG=0 I $G(^FBAA(161.7,B,"ST"))="V",($P(^FBAA(161.7,B,0),U,17)]"") S FLAG=1
 . S FZ=^FBAA(161.7,B,0),FBTYPE=$P(FZ,U,3)
 . I FLAG S @FBOUT@(B,0)="Batch"_U_B_";"_$P(^FBAA(161.7,B,0),U)_U_$P(^FBAA(161.7,B,0),U,2)_U_$P(^FBAA(161.7,B,0),U,10) D
 . F J=0:0 S J=$O(^FBAAC("AH",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AH",B,J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AH",B,J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AH",B,J,K,L,M)) Q:M'>0  D
 . . D SET,WRT:FBTYPE'="B2",WRTT:FBTYPE="B2" S FBRR=$P(^FBAAC(J,1,K,1,L,1,M,"FBREJ"),U,2) S @FBOUT@(B,CNT,"REJ")="Reject"_U_FBRR_U_$S($D(^FBAA(161.7,+$P(^("FBREJ"),U,3),0)):$P(^(0),U),1:"") Q
 I '$D(^TMP($J,"DSIFPAY6")) S @FBOUT@(0)="-1^No rejects found"
 Q
SET N FBADJLA,FBADJLR,FBFPPSC,FBFPPSL,FBX,FBY3,DFN S (FBADJLA,FBADJLR)="",TAMT=0
 S DFN=J D DEM^VADPT
 S N=$S(VADM(1)'="":VADM(1),1:""),S=$S(VADM(2)'="":VADM(2),1:""),V=$S($D(^FBAAV(K,0)):$P(^FBAAV(K,0),U,1),1:""),VID=$S(V]"":$P(^(0),U,2),1:"")
 S D=+$G(^FBAAC(J,1,K,1,L,0)) Q:'D
 S Y=$G(^FBAAC(J,1,K,1,L,1,M,0)) Q:Y']""
 S FBY3=$G(^FBAAC(J,1,K,1,L,1,M,3)) I FBY3 S FBFPPSC=$P(FBY3,U),FBFPPSL=$P(FBY3,U,2)
 S FBX=$$ADJLRA^FBAAFA(M_","_L_","_K_","_J_","),FBADJLR=$P(FBX,U),FBADJLA=$P(FBX,U,2)
 S T=$P(Y,U,5),FBIN=$P(Y,U,16),ZS=$P(Y,U,20),TAMT=$FN($P(Y,U,4),"",2),FBVP=$S($P(Y,U,21)="VP":"#",1:"")
 S FBAACPT=$$CPT^FBAAUTL4($P(Y,U)),CPTDESC=$$CPT^FBAAUTL4($P(Y,U),1,D),FBVCHDT=$P(Y,U,6),FBIN(1)=$P(Y,U,15) D FBCKO^FBAACCB2(J,K,L,M)
 S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_J_",1,"_K_",1,"_L_",1,"_M_",""M"")","E")
 S A1=$P(Y,U,2)+.0001,A2=$P(Y,U,3)+.0001,A1=$P(A1,".",1)_"."_$E($P(A1,".",2),1,2),A2=$P(A2,".",1)_"."_$E($P(A2,".",2),1,2),FBINTOT=FBINTOT+A2
 S Y(0)=$G(^FBAAC(J,1,K,1,L,1,M,0)),FBIN=$P(Y(0),U,16) I $P(Y(0),U,3)>0 S T=T+$P(Y(0),U,3),C=C+1
 D KVAR^VADPT Q
WRT ;  TYPE '=B2
 S B(1617)=$S(B="":"",$D(^FBAA(161.7,B,0)):$P(^(0),U),1:""),CNT=CNT+1
 N POINTER S POINTER=J_";"_K_";"_L_";"_M
 S @FBOUT@(B,CNT,0)="Patient"_U_CNT_")"_U_N_U_$$SSN^FBAAUTL(J)_U_B(1617)_U_FBVCHDT_";"_$$FMTE^XLFDT(FBVCHDT,5)_U_V_U_VID_U_FBIN_U_FBIN(1)_";"_$$FMTE^XLFDT(FBIN(1),5)
 S @FBOUT@(B,CNT,0)=@FBOUT@(B,CNT,0)_U_$S($D(QQ):QQ_")",1:"")_$S(ZS="R":"*",1:"")_$S(FBTYPE="B3":FBVP,1:"")_$S(FBTYPE="B5":FBPV,1:"")_$S($G(FBCAN)]"":"+",1:"")_U_POINTER
 I FBTYPE="B3" S @FBOUT@(B,CNT,1)="Line1"_U_D_";"_$$FMTE^XLFDT(D,5)_U_FBAACPT_$S($G(FBMODLE)]"":"-"_$P(FBMODLE,","),1:"")_U_CPTDESC_U_$G(FBFPPSC)_U_$G(FBFPPSL)
 I FBTYPE="B5" S @FBOUT@(B,CNT,1)="Line1"_D_";"_$$FMTE^XLFDT(D,5)_U_FBAACPT_$S($G(FBMODLE)]"":"-"_$P(FBMODLE,","),1:"")_U_CPTDESC_U_FBFPPSC_U_FBFPPSL
 I $P($G(FBMODLE),",",2)]"" D
 . N FBI,FBMOD F FBI=2:1 S FBMOD=$P(FBMODLE,",",FBI) Q:FBMOD=""  S @FBOUT@(B,CNT,1)=@FBOUT@(B,CNT,1)_"-"_FBMOD
 S @FBOUT@(B,CNT,1)=@FBOUT@(B,CNT,1)_U_$J(A1,6)_U_$J(A2,6)_U_$S($G(FBADJLR)]"":FBADJLR,1:T)_U_$S($G(FBADJLA)]"":FBADJLA,1:TAMT) ; write adjustment amounts, if null then write amount suspended
 D PMNT^FBAACCB2 S FBINOLD=FBIN
 Q
WRTT I A2'=".00" S @FBOUT@(B,M,CNT,0)=$S($D(QQ):QQ_") ",1:"")_$S($G(FBCAN)]"":"+",1:"")_U_N_U_$E(S,1,3)_"-"_$E(S,4,5)_"-"_$E(S,6,10)_U_D_";"_$$FMTE^XLFDT(D,5)_U_"$ "_$J(A2,4,2)  D PMNT^FBAACCB2 Q
NEWBT(FBOUT) ;
 S FBSTN=$P(FZ,U,8),FBDCB=$P(FZ,U,13) D GETNXB^FBAAUTL S FBOUT="1^New Batch for Rejects is: "_FBBN
 S DLAYGO=161.7,X=FBBN,DIC(0)="LQ",DIC("DR")="1///^S X=FBOB;2///^S X=""B9"";3///^S X=DT;4///^S X=DUZ;4.5///^S X=FBDCB;11///^S X=$S(FBEXMPT[""Y"":""O"",1:""A"");16///^S X=FBSTN;17////^S X=""Y"";18///^S X=FBEXMPT"
 K DD,DO D FILE^DICN K DIC S FBNB=+Y
 S FBNUM=$P(FZ,U,1),FBVD=$P(FZ,U,12),FBVDUZ=$P(FZ,U,16),FBNOB=FBOB
 Q
 ;
REINIT(FBOUT,FBPAT,FBOLDB,FBNEWB,FBLINES) ; RPC: DSIF PAY FIX SEL REJECTED ITEMS
 ;  Input:  FBPAT= Patient DFN, FBOLDB = Old Batch IEN, FBNEWB= New Batch IEN 
 ;     B3 BATCHES: FBLINES(NUM) = PMT ID (N;N;N;N)           Value of NUM begins with '1' 
 ;                          FBLINES(NUM+n) = PMT ID2 (N;N;N;N)     Changed to an array in DSIF*3.2*8
 ;     B9 BATCHES: FBLINES(NUM) = Invoice IEN
 ;                          FBLINES(NUM+n) = Invoice IEN 2
 ;  Output: ^TMP($J,"DSIFPAY6",FBIN,0)="Split"^FBIN^message regarding split status
 ;                 FBIN,new invoice number)="Message"^FBIN^"Re-initiated lines are being assigned a new invoice number"^New invoice number
 ;                                           FBIN,2)="Void"^FBIN^"Invoice #: "^FBIN^" has a status of VOID
 ;(or)        ^TMP($J,"DSIFPAY6",0)="-1"^error message
 ;  Cloned from FBAARR
 N B,J,DA,K,L,M,HX,QQ,FBIN,FBNB,FBAAP,FBILM,FBAACP,FBBN,FBCAN,FBAACP,FBDCB,FBINOLD,FBINTOT,FBMODLE,FBNOB,DSIFFLAG,NUM
 N FBNUM,FBOB,FBPV,FBRR,FBSTN,FBTYPE,FBVCHDT,FBVD,FBVDUZ,FBVP,FZ,S,T,V,VID,X,Y,ZS,FBAAAP,C,DSIFERR,DSIFOT,DSIFNT,I
 K FBOUT,^TMP($J,"DSIFPAY6") S FBOUT=$NA(^TMP($J,"DSIFPAY6"))
 S FBOLDB=$G(FBOLDB),FBNEWB=$G(FBNEWB),DSIFERR=0
 I 'FBOLDB,'FBNEWB S @FBOUT@(0)="-1^Required data missing" Q
 I $G(FBLINES(1))="" S @FBOUT@(0)="-1^Required data array for rejected lines missing" Q
 S DSIFOT=$P($G(^FBAA(161.7,FBOLDB,0)),U,3),DSIFNT=$P($G(^FBAA(161.7,FBNEWB,0)),U,3)
 I '$D(^FBAA(161.7,FBNEWB,0)) S @FBOUT@(0)="-1^New batch number is invalid" Q
 S B=FBOLDB,(C,DSIFFLAG,FBINTOT)=0 I $G(FBPAT)="" S @FBOUT@(0)="-1^No Patient entered, quitting" Q
 I DSIFOT'=DSIFNT S @FBOUT@(0)="-1^Batch type mismatch, Old batch type = "_DSIFOT_", New type = "_DSIFNT Q
 ;  B3 batches
 I DSIFOT="B3" K QQ S (J,DA)=FBPAT I '$D(^FBAAC("AH",B,J)) S @FBOUT@(0)="-1^No payments in this batch for that patient!" Q
 I DSIFOT="B3" D  Q:DSIFERR   D END   ;(call to END added with DSIF*3.2*1)
 . S QQ=0 F K=0:0 S K=$O(^FBAAC("AH",B,J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AH",B,J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AH",B,J,K,L,M)) Q:M'>0  D
 ..  S QQ=QQ+1,QQ(QQ)=J_U_K_U_L_U_M S CNT=0
 . N RET,ID F NUM=0:0 S NUM=$O(FBLINES(NUM)) Q:'NUM!(DSIFERR)  S ID=$G(FBLINES(NUM)) Q:ID=""  D
 .. S J=$P(ID,";"),K=$P(ID,";",2),L=$P(ID,";",3),M=$P(ID,";",4)
 .. I '$D(^FBAAC(J,1,K,1,L,1,M,0)) S @FBOUT@(NUM,0)="-1^"_ID_U_"Is not a valid line item",DSIFERR=1 Q
 .. I $P(^FBAAC(J,1,K,1,L,1,M,0),U,21)="VP" S FBIN=+$P(^(0),U,16) S @FBOUT@(0)="-1^Invoice #: "_FBIN_" has a status of VOID.  Please delete the VOID before re-initiating this rejected payment.",DSIFERR=1 Q
 .. S $P(^FBAAC(J,1,K,1,L,1,M,0),U,8)=FBNEWB,FBAAAP=+$P(^(0),U,3),FBIN=+$P(^(0),U,16)
 .. S ^FBAAC("AC",FBNEWB,J,K,L,M)="",^FBAAC("AJ",FBNEWB,FBIN,J,K,L,M)="" K ^FBAAC("AH",B,J,K,L,M)
 .. S $P(^FBAA(161.7,FBNEWB,0),U,9)=($P(^FBAA(161.7,FBNEWB,0),U,9)+FBAAAP),$P(^(0),U,11)=($P(^(0),U,11)+1) K ^FBAAC(J,1,K,1,L,1,M,"FBREJ")
 .. S FBILM(FBIN,M_","_L_","_K_","_J_",")=""
 .. I 'DSIFERR S @FBOUT@(NUM,ID)="1^Line:"_ID_" of old batch: "_FBOLDB_" re-initiated to new Batch "_FBNEWB
 .D CKSPLIT(B,.FBILM)
 ;  B9 batches
 I DSIFOT="B9",$P(^FBAA(161.7,B,0),"^",15)="Y"  D  Q:DSIFERR
 . S NUM="",QQ=0
 . N RET,ID F NUM=NUM:NUM S NUM=$O(FBLINES(NUM)) Q:'NUM!(DSIFERR)  S ID=$G(FBLINES(NUM)) Q:ID=""  D
 .. I '$D(^FBAAI("AH",B,ID)) S @FBOUT@(0)="-1^Invalid batch "_+^FBAA(161.7,B,0)_" for Invoice: "_ID,DSIFERR=1 Q
 .. I $D(^FBAAI("AH",B,ID)) S FBRR=$P(^FBAAI(ID,"FBREJ"),U,2) D  S @FBOUT@(NUM,0)="1^Line^"_ID_U_" of old batch: "_FBOLDB_" re-initiated to new Batch "_FBNEWB Q
 ... S I=ID,FBNB=FBNEWB S $P(^FBAAI(I,0),"^",17)=FBNB,FBAAAP=+$P(^(0),"^",9),^FBAAI("AC",FBNB,I)="",^FBAAI("AE",FBNB,$P(^FBAAI(I,0),"^",4),I)="" K ^FBAAI("AH",B,I)
 ... S FZ(0)=^FBAA(161.7,FBNB,0),$P(FZ(0),"^",9)=$P(FZ(0),"^",9)+FBAAAP,$P(FZ(0),"^",10)=$P(FZ(0),"^",10)+1,$P(FZ(0),"^",11)=$P(FZ(0),"^",11)+1,^FBAA(161.7,FBNB,0)=FZ(0),$P(^FBAA(161.7,FBOLDB,0),U,17)="" K ^FBAAI(I,"FBREJ")
 I 'DSIFERR S @FBOUT@(0)=1
 Q
CKSPLIT(B,FBILM) ; Check for/Update split invoice
 ; Input B=ien of original batch before item moved
 ;   FBILM( - array of invoice lines that were moved to a new batch passed by reference
 ;     format FBILM(invoice number,iens)=""
 ;     where invoice number = invoice number, iens = iens of subfile 162.03
 ; Result (0 or 1) 0 if no lines were assigned; 1 if some lines assigned
 ;   May change invoice number of line items in subfile 162.03 and inform user
 N FBAAIN,FBFDA,FBIENS,FBIN,FBINL,FBJ,FBK,FBL,FBM,FBRET,FBSPLT,MSG
 S FBRET=0 S FBIN="" F  S FBIN=$O(FBILM(FBIN)) Q:FBIN=""  D
 . S FBSPLT=0 I $D(^FBAAC("AJ",B,FBIN)) S FBSPLT=1
 . I 'FBSPLT S FBJ=0 F  S FBJ=$O(^FBAAC("AH",B,FBJ)) Q:'FBJ  D  Q:FBSPLT
 . . S FBK=0 F  S FBK=$O(^FBAAC("AH",B,FBJ,FBK)) Q:'FBK  D  Q:FBSPLT
 . . . S FBL=0 F  S FBL=$O(^FBAAC("AH",B,FBJ,FBK,FBL)) Q:'FBL  D  Q:FBSPLT
 . . . . S FBM=0 F  S FBM=$O(^FBAAC("AH",B,FBJ,FBK,FBL,FBM)) Q:'FBM  D  Q:FBSPLT
 . . . . . S FBINL=$P($G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,0)),U,16) I FBINL=FBIN S FBSPLT=1
 . Q:FBSPLT=0
 . S FBRET=1
 . D GETNXI^FBAAUTL
 . K FBFDA S FBIENS="" F  S FBIENS=$O(FBILM(FBIN,FBIENS)) Q:FBIENS=""  D
 . . S FBFDA(162.03,FBIENS,14)=FBAAIN
 . S @FBOUT@(FBIN,0)="FYI: Invoice "_FBIN_" was split since entire invoice did not move to the new batch."
 . S @FBOUT@(FBIN,FBAAIN)="Message^"_FBIN_U_"Re-initiated lines are being assigned a new invoice number"_U_FBAAIN
 . I $D(FBFDA) D FILE^DIE("","FBFDA","MSG") I $D(MSG) M @FBOUT@("MSG")=MSG
 Q FBRET
 ;
 ;DSIF READMAIL deleted in DSIF*3.2*8
LISTMESS(FBOUT,STRTDT,STOPDT) ;RPC:  DSIF INP LIST AUSTIN MESSAGES
 ; No longer supported
 Q
 N ARRAY,MSG,OUT,CNT,I,FBPOP,FIELDS,FILE,FLAGS,FROM,ID,IENS,INDEX,NUMBER,PART,SCREEN,TARGET
 I $G(DT)="" D DT^DICRW
 I $G(STOPDT)="" S STOPDT=DT
 S FBOUT=$NA(^TMP($J,"DSIFPAY6")),I="" K @FBOUT
 S @FBOUT@(0)="-1^Option not available at this time, future use possible"
 Q
 ;
END I '$D(^FBAAC("AH",B)) S $P(^FBAA(161.7,B,0),"^",17)="" Q  ;Added with DSIF*3.2*1
