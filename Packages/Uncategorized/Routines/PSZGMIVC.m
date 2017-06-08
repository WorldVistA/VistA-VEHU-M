PSZGMIVC ;LOCAL MOD FOR CONT IV MARS DCN/BUF 29 MAR 95
PSGMMIVC ;BIR/MV-PRT MULT DAYS MAR C ORDERS(IV) ; 25 Aug 94 / 12:07 PM
 ;;4.5; Inpatient Medications ;;7 Oct 94
PRT ;*** Print IV orders.
 K P,DRG,PSGMARTS,PSGMARGD,PSGLFFD,TS N ON55 S TS=1,PSGMARGD=""
 S ON=$P(DAO,U,2),DFN=$P(PN,U,2) D GT55^PSIVORFB  D:P(9)]"" OS S PSGLSSD=P(2),PSGLFFD=P(3)
 F X="LOG",2,3 S:P(X) P(X)=$$ENDTC^PSGMI(P(X))
 S PSGLRPH="" S:$D(^XUSEC("PSJ RPHARM",+P("CLRK"))) PSGLRPH=$P($G(^VA(200,+P("CLRK"),0)),U,2)
 S PSGST=$S(P(9)["PRN":"P",P(2)=P(3):"O",1:"C")
 S X=($L(P("OPI"))>29)+1+(P("OPI")]""&(P(4)="C"))
 S X=($G(DRG("AD",0))+$G(DRG("SOL",0))+X+2) S X=$S(X<6:1,1:((X-6)\5)+2)
 S LN=$S(TS/6>X:TS/6,1:X)
 D PRTIV
 Q
 ;
OS ; order record set
 S FD=P(3),PSGOES="",X=P(9),SD=P(2) D EN^PSGS0 S T=PSGS0XT
 S QQ="" I QST["C" D DTS^PSGMMAR0(P(9)) S SD=$P(SD,"."),QQ="" F X=0:0 S X=$O(PSGD(X)) Q:'X  S QQ=QQ_$S(X<SD:"",X>FD:"",'S:$P(PSGD(X),U),$D(S(X)):$P(PSGD(X),U),1:"")
 I T="D",P(11)="" S P(11)=$E($P(P(2),".",2)_"0000",1,4)
 S PSGMARTS=P(11),PSGMARGD=QQ
 ;* K TS S TS=$L(PSGMARTS,"-"),X=0,(TS(1),TS(2),TS(3),TS(4),TS(5),TS(6))="" I TS=1 S (X,Y)=PSGMARTS S:$L(X)=2 X=X_"00" S TS(X/400+.9999\1)=Y
 K TS D TS^PSGMAR3(P(11))
 ;* I TS>1 F Q=1:1:TS S X=X+1,TS(X)=$P(PSGMARTS,"-",Q) S:TS<4 X=X+1,TS(X)=""
 Q
 ;
PRTIV ;*** Print IV order on MAR
 I PSGMAROC,(PSGMAROC+LN)>5 D BOT^PSZGMAR2,HEADER^PSZGMAR2
 S PSGMAROC=PSGMAROC+1 W !?7,"|",?15,"|",?48,"| ",$G(TS(1)) D CELL(1,0)
 W !?1,$E(P("LOG"),1,5)," | ",$E(P(2),1,5)," | ",P(3),?48,"| ",$G(TS(2)) D CELL(2,0) S L=3
 F X=0:0 S X=$O(DRG("AD",X)) Q:'X  W !?1,$$WRTDRG^PSIVUTL(DRG("AD",X),47) W:L=3 ?47,PSGST W ?48,"| ",$G(TS(L)) D CELL(L,'(L#6)) D L(1)
 W:$G(DRG("SOL",0)) !?1,"in " F X=0:0 S X=$O(DRG("SOL",X)) Q:'X  W:X>1 ! W ?4,$$WRTDRG^PSIVUTL(DRG("SOL",X),47) W:L=3 ?47,PSGST W ?48,"| ",$G(TS(L)) D CELL(L,'(L#6)) D L(1)
 W !?1,$P(P("MR"),U,2)," ",P(9)," ",P(8) W ?48,"| ",$G(TS(L)) D CELL(L,'(L#6)) D
 . I P(4)="C",'(L#5),P("OPI")="" W !?1,"*CAUTION-CHEMOTHERAPY*" S L=L+1 Q
 . I P(4)="C" D L(1) W !?1,"*CAUTION-CHEMOTHERAPY*",?48,"| ",$G(TS(L)) D CELL(L,'(L#6))
 . W:P("OPI")=""&(TS<7) !
 . ;* I (L#5)=0,$L(P("OPI"))<30 S L=L+1 Q
 . I (L#5)=0,($L(P("OPI"))<30),(TS<7) S L=L+1 Q
 . D L(1)
 I P("OPI")'="" W !?1 F Y=1:1:$L(P("OPI")," ") S Y1=$P(P("OPI")," ",Y) D  W Y1," "
 . I ($X+$L(Y1))>47 W ?48,"| ",$G(TS(L)) D CELL(L,'(L#6)) W !?1 S L=L+1
 I L>TS,(L#6) W ?48,"| ",$G(TS(L)) D CELL(L,'(L#6)) S L=L+1 W:L#6=0 !
 I (TS-1)>L W ?48,"| ",$G(TS(L)) D CELL(L,'(L#6)) D
 . F L=L+1:1:TS-1 D L(0) W !?48,"| ",$G(TS(L)) D CELL(L,'(L#6))
 . S L=L+1
 I L#6>0 W ! F  Q:L#6=0  W ?48,"| ",$G(TS(L)) D CELL(L,'(L#6)) S L=L+1 W !
 W ?30,"RPH:",$S(PSGLRPH]"":PSGLRPH,1:"_____"),?39," RN:_____",?48,"|  ",$G(TS(L))
 ;D CELL(L,'(L#6))
 W ?55 D ASTERS^PSZGMAR2
 W:PSGMAROC<5 !?7,LN2
 Q
 ;
L(X) ;***Check to see if a new block if needed.
 S L=L+X
 I L#6=0,PSGMAROC<6 W !?1,"See next label for continuation",?48,"| ",$G(TS(L)) D CELL(L,'(L#6)) D  ;* W:L'=6 LN7 D
 . W:PSGMAROC<5 !?7,LN2 S PSGMAROC=PSGMAROC+1,L=L+1 D
 . . I LN>6,(PSGMAROC>5) S MSG1="*** CONTINUE ON NEXT PAGE ***" D BOT^PSZGMAR2,HEADER^PSZGMAR2 S PSGMAROC=1
 Q
LN(L) ;*** Print lines within block.
 N X S X=$S(L#6:LN4,1:LN7)
 Q X
CELL(X,X1)         ;
 I TS=1,'$G(P(11)),(X=6) W ?55 D ASTERS^PSZGMAR2 Q
 ;* I TS=1,'$G(TS(1)) W ?55,$$LN(X) Q
 I TS=1,'$G(P(11)) W ?55,$$LN(X) Q
 D CELL^PSZGMAR2(X,X1)
 Q
