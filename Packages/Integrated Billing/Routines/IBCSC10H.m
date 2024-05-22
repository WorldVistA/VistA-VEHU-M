IBCSC10H ;ALB/ARH - MCCR SCREEN 10 (BILL SPECIFIC INFO) CMS-1500 ;4/21/92
 ;;2.0;INTEGRATED BILLING;**432,488,547,592,759**;21-MAR-94;Build 24
 ;;Per VA Directive 6402, this routine should not be modified.
 ; CMS-1500 screen 10
 ;
 ; MAP TO DGCRSC8H
 ;
 ; DEM;432 - Moved IBCSC8* billing screen routines to IBCSC10* billing screen
 ;           routines and created a new billing screen 8 routine IBCSC8.
 ;
EN ;
 N I,IB,Y,Z
 D ^IBCSCU
 ;
 ;WCJ;IB*2.0*547
 ;S IBSR=10,IBSR1="H",IBV1="000000000" S:IBV IBV1="111111111"
 ;
 ;S IBSR=10,IBSR1="H",IBV1="0000000000" S:IBV IBV1="1111111111"
 S IBSR=10,IBSR1="H",IBV1="0000000000"    ; all sections editable on screen
 S:'+$$BBB^IBCSC10(IBIFN) $E(IBV1,8)=1  ;WCJ;IB759; make undeditable if not set up for payer
 S:IBV IBV1="1111111111"   ; uneditable if view only
 ;
 ;JWS;IB*2.0*592 US1108 - Dental form 7
 I $$FT^IBCU3(IBIFN)=7 S IBV1="1001100010" S:IBV IBV1="11111111"
 ;F I="U","U1","UF2","UF3","UF32","U2","M","TX",0,"U3" S IB(I)=$G(^DGCR(399,IBIFN,I))
 F I="U","U1","UF2","UF3","UF32","U2","M","M2","TX",0,"U3" S IB(I)=$G(^DGCR(399,IBIFN,I))
 ;
 N IBZ,IBPRV,IBDATE,IBREQ,IBMRASEC,IBZ1,IBZCNT
 ;
 S IBDATE=$$BDATE^IBACSV(IBIFN) ; Date of service for the bill
 S IBPRV=""
 D GETPRV^IBCEU(IBIFN,"ALL",.IBPRV)
 K IB("PRV")
 S IBZ=0 F  S IBZ=$O(IBPRV(IBZ)) Q:'IBZ  I $O(IBPRV(IBZ,0))!$D(IBPRV(IBZ,"NOTOPT")) M IB("PRV",IBZ)=IBPRV(IBZ)
 ;
 D H^IBCSCU
 ;
 ; Section 1
 S Z=1,IBW=1 X IBWW W " Unable To Work From: " S Y=$P(IB("U"),U,16) X ^DD("DD") W $S(Y'="":Y,1:IBUN)
 W !?4,"Unable To Work To  : " S Y=$P(IB("U"),U,17) X ^DD("DD") W $S(Y'="":Y,1:IBUN)
 ;
 ; Section 2
 S Z=2,IBW=1
 X IBWW I $$INPAT^IBCEF(IBIFN) W " Admitting Dx       : " S IBZ=$$ICD9^IBACSV(+IB("U2"),IBDATE) W $S(IBZ'="":$P(IBZ,U)_" - "_$P(IBZ,U,3),1:IBUN),!
 S IBZCNT=0,IBZ(IBZCNT)=""
 I $P(IB("UF3"),U,4)]"" S IBZ(IBZCNT)="P: "_$P(IB("UF3"),U,4),IBZCNT=IBZCNT+1
 I $P(IB("UF3"),U,5)]"" S IBZ(IBZCNT)="S: "_$P(IB("UF3"),U,5),IBZCNT=IBZCNT+1
 I $P(IB("UF3"),U,6)]"" S IBZ(IBZCNT)="T: "_$P(IB("UF3"),U,6)
 S:IBZ(0)="" IBZ(0)=IBUN
 W ?4,"ICN/DCN(s)         : ",IBZ(0)
 F IBZCNT=1:1 Q:'$D(IBZ(IBZCNT))  W !?25,IBZ(IBZCNT)
 K IBZ
 S IBZ=$$CKPROV^IBCEU(IBIFN,3)
 S IBZCNT=0,IBZ(IBZCNT)=""
 I $P(IB("U"),U,13)]"" S IBZ(IBZCNT)="P: "_$P(IB("U"),U,13),IBZCNT=IBZCNT+1
 I $P(IB("U2"),U,8)'="" S IBZ(IBZCNT)="S: "_$P(IB("U2"),U,8),IBZCNT=IBZCNT+1
 I $P(IB("U2"),U,9)'="" S IBZ(IBZCNT)="T: "_$P(IB("U2"),U,9),IBZCNT=IBZCNT+1
 I $P(IB("UF32"),U,1)'="" S IBZ(IBZCNT)="P: "_$P(IB("UF32"),U,1),IBZCNT=IBZCNT+1
 I $P(IB("UF32"),U,2)'="" S IBZ(IBZCNT)="S: "_$P(IB("UF32"),U,2),IBZCNT=IBZCNT+1
 I $P(IB("UF32"),U,3)'="" S IBZ(IBZCNT)="T: "_$P(IB("UF32"),U,3)
 S:IBZ(0)="" IBZ(0)=IBUN
 W !,?3," Auth/Referral      : ",IBZ(0)
 F IBZCNT=1:1 Q:'$D(IBZ(IBZCNT))  W !?25,IBZ(IBZCNT)
 K IBZ S IBZ=""
 ;
 ; Section 3
 S Z=3,IBW=1 X IBWW
 W " Providers          : ",$S('$O(IB("PRV",0)):IBU,1:"")
 I $D(IB("PRV")) D  ; at least 1 provider found
 . N IBQ,A,A1,IBARR,IBTAX,IBNOTAX,IBSPEC,IBNOSPEC
 . S IBZ=0
 . D DEFSEC^IBCEF74(IBIFN,.IBARR)
 . ; PRXM/KJH - Add Taxonomy code to display for patch 343. Moved secondary IDs slightly (below).
 . S IBTAX=$$PROVTAX^IBCEF73A(IBIFN,.IBNOTAX)
 . S IBSPEC=$$SPECTAX^IBCEF73A(IBIFN,.IBNOSPEC)
 . F  S IBZ=$O(IB("PRV",IBZ)) Q:'IBZ  D
 .. S IBQ=""
 .. W !,?5,"- "
 .. S A=$$EXPAND^IBTRE(399.0222,.01,IBZ)
 .. I $P($G(IB("PRV",IBZ,1)),U,4)'="" S A1=" ("_$E($P(IB("PRV",IBZ,1),U,4),1,3)_")",A=$E(A,1,16-$L(A1))_A1
 .. W $E(A_$J("",16),1,16),": "
 .. I '$P($G(IB("PRV",IBZ,1)),U,3),$P($G(IB("PRV",IBZ,1)),U)="" W IBU Q
 .. I $P($G(IB("PRV",IBZ,1)),U)'="" W:'$G(IB("PRV",IBZ)) $E($P(IB("PRV",IBZ,1),U)_$J("",16),1,16) W:$G(IB("PRV",IBZ)) "(OLD BOX 31 DATA) "_$P(IB("PRV",IBZ,1),U)
 .. I $P($G(IB("PRV",IBZ,1)),U)="",$P($G(IB("PRV",IBZ)),U)'="" W $E($P(IB("PRV",IBZ),U)_$J("",16),1,16)
 .. W "    Taxonomy: ",$S($P(IBTAX,U,IBZ)'="":$P(IBTAX,U,IBZ),1:IBU),$S($P(IBSPEC,U,IBZ)'="":" ("_$P(IBSPEC,U,IBZ)_")",1:"")
 .. F A=1:1:3 I $G(IBARR(IBZ,A))'="" S IBQ=IBQ_"["_$E("PST",A)_"]"_IBARR(IBZ,A)_" "
 .. I $L(IBQ) W !,?30,$E(IBQ,1,49)
 ;
 K IB("PRV")
 ;
 ; Section 4
 S Z=4,IBW=1 X IBWW
 W " Other Facility (VA/non): " S IBZ=$$EXPAND^IBTRE(399,232,+$P(IB("U2"),U,10))
 W $S(IBZ'="":$E(IBZ,1,23),$$PSRV^IBCEU(IBIFN):IBU,1:IBUN)
 I IBZ'="" D
 . ; PRXM/KJH - Add Taxonomy code to display for patch 343.
 . W ?53,"Taxonomy: "
 . S IBZ=$$GET1^DIQ(8932.1,+$P(IB("U3"),U,3),"X12 CODE") W $S(IBZ'="":IBZ,1:IBU)
 . S IBZ=$$GET1^DIQ(8932.1,+$P(IB("U3"),U,3),"SPECIALTY CODE") W $S(IBZ'="":" ("_IBZ_")",1:"")
 . Q
 ;
 ; clia# display - IB patch 320
 S (IBZ,IBZ1)=$P(IB("U2"),U,13)     ; retrieve CLIA# from database
 ;
 I IBZ="" D
 . NEW CLIAREQ,DEFCLIA,DIE,DA,DR
 . S CLIAREQ=$$CLIAREQ^IBCEP8A(IBIFN)
 . I 'CLIAREQ S IBZ1=IBUN Q          ; clia# not needed
 . S DEFCLIA=$$CLIA^IBCEP8A(IBIFN)   ; default clia# for claim
 . I DEFCLIA="" S IBZ1=IBU Q         ; no default found
 . I $G(IBMDOTCN) K IBMDOTCN S IBZ1=IBU Q     ; user @-deleted clia#
 . S IBZ1=DEFCLIA                    ; display and stuff default clia#
 . S DIE=399,DA=IBIFN,DR="235///"_DEFCLIA D ^DIE    ; stuff in default
 . Q
 ;
 W !,?4,"Lab CLIA #         : ",IBZ1
 ;
 ; Mammo# display IB patch 320
 S (IBZ,IBZ1)=$P(IB("U3"),U,1)    ; retrieve mammo# from database
 ;
 ; If mammo# is there, but should not be, then blank it out
 I IBZ'="",'$$XRAY^IBCEP8A(IBIFN) D
 . NEW DIE,DA,DR
 . S IBZ1=IBUN        ; mammo# not needed
 . S DIE=399,DA=IBIFN,DR="242////@" D ^DIE
 . Q
 ;
 I IBZ="" S IBZ1=IBUN
 W !?4,"Mammography Cert # : ",IBZ1
 ;
 ; Section 5
 S Z=5,IBW=1 X IBWW
 W " Chiropractic Data  : " S Y=$P(IB("U3"),U,5) X ^DD("DD") W $S(Y'="":"INITIAL TREATMENT ON "_Y,1:IBUN)
 ;
 ; Section 6  -> changed prompt for *488* : baa
 S Z=6,IBW=1 X IBWW
 ;JWS;IB*2.0*592 US1108 - Dental
 ;IA# 3820
 I $$FT^IBCU3(IBIFN)'=7 W " CMS-1500 Box 19    : " S IBZ=$P($G(^DGCR(399,IBIFN,"UF31")),U,3) W $S(IBZ'="":IBZ,1:IBUN)
 E  D
 . W " Dental Claim Note  : " S IBZ=$$GET1^DIQ(399,IBIFN_",",97)
 . I IBZ="" W IBUN Q
 . N IBNOTE
 . S IBNOTE=$$WRAP(IBZ,53,53,.IBNOTE)
 . W $G(IBNOTE(1)) I $G(IBNOTE(2))'="" W !,?23,": ",IBNOTE(2)
 . Q
 ;end - JWS;IB*2.0*592 US1108 - Dental
 ;/ Beginning of IB*2.0*488 - Moved the following lines of code to IBCSC8 (vd)
 ;I $P(IB("U2"),U,14)'="" W !,?4,"Homebound          : ",$$EXPAND^IBTRE(399,236,$P(IB("U2"),U,14))
 ;I $P(IB("U2"),U,15)'="" W !,?4,"Date Last Seen     : ",$$EXPAND^IBTRE(399,237,$P(IB("U2"),U,15))
 ;I $P(IB("U2"),U,16)'="" W !,?4,"Spec Prog Indicator: " S IBZ=$$EXPAND^IBTRE(399,238,$P(IB("U2"),U,16)) W $S(IBZ'="":IBZ,$$WNRBILL^IBEFUNC(IBIFN):"31",1:"")
 ;/ End of IB*2.0*488 (vd)
 ;
 ; Section 7
 S Z=7,IBW=1 X IBWW
 W " Billing Provider   : "
 K IBZ
 D GETBP^IBCEF79(IBIFN,"",+$$B^IBCEF79(IBIFN),"CMS-1500 SCREEN 8",.IBZ)
 S IBZ=$G(IBZ("CMS-1500 SCREEN 8","NAME"))
 W $S(IBZ'="":IBZ,1:IBU)    ; billing provider name
 W !?3," Taxonomy Code      : "
 S IBZ=$$GET1^DIQ(8932.1,+$P(IB("U3"),U,11),"X12 CODE") W $S(IBZ'="":IBZ,1:IBU)
 S IBZ=$$GET1^DIQ(8932.1,+$P(IB("U3"),U,11),"SPECIALTY CODE") W $S(IBZ'="":" ("_IBZ_")",1:"")
 ;
 ; Section 8
 ;WCJ;IB*2.0*547
 ;Adding ALT PRIMARY IDS and moving sections down to make room
 S Z=8,IBW=1 X IBWW
 W " Alt Prim Payer ID  : "
 K IBZ
 S IBZCNT=0
 I $P(IB("M2"),U,2)]"" S IBZCNT=IBZCNT+1,IBZ(IBZCNT)="P: "_$P(IB("M2"),U,2)
 I $P(IB("M2"),U,4)]"" S IBZCNT=IBZCNT+1,IBZ(IBZCNT)="S: "_$P(IB("M2"),U,4)
 I $P(IB("M2"),U,6)]"" S IBZCNT=IBZCNT+1,IBZ(IBZCNT)="T: "_$P(IB("M2"),U,6)
 I 'IBZCNT W ?23,IBUN
 I IBZCNT F IBZ1=1:1:IBZCNT W ?23,IBZ(IBZ1) W:(IBZ1'=IBZCNT) !
 K IBZ
 ;
 ; Section 9
 S Z=9,IBW=1 X IBWW
 S IBREQ=+$$REQMRA^IBEFUNC(IBIFN) S:IBREQ IBREQ=1
 S IBMRASEC=$$MRASEC^IBCEF4(IBIFN)
 W " ",$S('IBREQ:"Force To Print?    : ",1:"Force MRA Sec Prt? : ")
 S IBZ=$$EXTERNAL^DILFD(399,27+IBREQ,,+$P(IB("TX"),U,8+IBREQ))
 I IBMRASEC,'$P(IB("TX"),U,8),$P(IB("TX"),U,9) S IBZ="FORCED TO PRINT BY MRA PRIMARY",$P(IB("TX"),U,8)=0
 W $S(IBZ'=""&($P(IB("TX"),U,8+IBREQ)'=""):IBZ,'$$TXMT^IBCEF4(IBIFN):"[NOT APPLICABLE - NOT TRANSMITTABLE]",IBREQ:"NO FORCED PRINT",1:IBZ)
 ;
 ; Section 10
 S Z=10,IBW=1 X IBWW
 W " Provider ID Maint  : (Edit Provider ID information)",!
 G ^IBCSCP
Q Q
 ;
WRT1(IBCRED) ; Write credentials mismatch
 W !,*7,"  **Warning** Credentials differ from those found in NEW PERSON or IB NON VA",!,$J("",14),"BILLING PROVIDER file (",$S(IBCRED="":"none",1:IBCRED),")"
 W !,$J("",14),"Changes will print local, but only credentials on file transmit"
 Q
 ;
NSAME(DA) ; Returns 1 if div on bill is not the default billing facility
 Q ($P($G(^IBE(350.9,1,0)),U,2)'=$P($G(^DG(40.8,+$P(^DGCR(399,DA,0),U,22),0)),U,7))
 ;
WRAP(STRING,ROOM,SUBS,IBARY) ; wrap long lines without breaking up words
 ;
 ; STRING = data string to wrap
 ; ROOM = number of characters to break at for line 1
 ; SUBS = number of characters to break at for subsequent lines (may or may not be same as ROOM)
 ; IBARY = (required) subscripted array to return wrapped data in:
 ;  array(1)=first line
 ;  array(2)= 2nd line and so on
 ;
 ; Returns total # of lines in description
 ;
 N START,END,I,C,STOP
 ; if there is enough room for 1 line, no wrapping needed
 I $L(STRING)'>ROOM S IBARY(1)=STRING Q 1
 I $F(STRING," ")=0 D  Q 1
 . N LEN S LEN=$L(STRING)
 . F I=1:1 S IBARY(I)=$E(STRING,1,ROOM),STRING=$E(STRING,ROOM+1,LEN) Q:STRING=""
 . Q
 I $F(STRING," ")>ROOM S IBARY(1)=STRING Q 1
 ; add a space to the end of the string to avoid dropping last character
 S START=1,END=ROOM,STRING=STRING_" "
 F C=1:1 D  Q:$L(STRING)<START  Q:$G(STOP)  ; stop if we have made it to the end of the data string
 .; start at the end and work backwards until you find a blank space, cut the line there and move on to the next line 
 .F I=END:-1:1 I $E(STRING,I)=" " S IBARY(C)=$E(STRING,START,I),START=I+1,END=SUBS+START Q
 .I I=1 S STOP=1 I '$D(IBARY(1)) S IBARY(1)=STRING Q
 Q C
 ;
 ;JWS;IB*2.0*592;only allow either Rendering or Assistant Surgeon on a Dental Claim
FILTERP(IBIEN,TYPE) ;filter input of provider for dental claims
 N OK,IBX1,IBX2
 S OK=1,IBX1=0
 F  S IBX1=$O(^DGCR(399,IBIEN,"CP",IBX1)) Q:'IBX1  D  Q:'OK
 . I TYPE=3,$D(^DGCR(399,IBIEN,"CP",IBX1,"LNPRV","B",6)) D  I 'OK Q
 .. S IBX2=$O(^DGCR(399,IBIEN,"CP",IBX1,"LNPRV","B",6,0)) I IBX2="" Q
 .. I $P($G(^DGCR(399,IBIEN,"CP",IBX1,"LNPRV",IBX2,0)),"^",2)'="" S OK=0 Q
 . I TYPE=6,$D(^DGCR(399,IBIEN,"CP",IBX1,"LNPRV","B",3)) D  I 'OK Q
 .. S IBX2=$O(^DGCR(399,IBIEN,"CP",IBX1,"LNPRV","B",3,0)) I IBX2="" Q
 .. I $P($G(^DGCR(399,IBIEN,"CP",IBX1,"LNPRV",IBX2,0)),"^",2)'="" S OK=0 Q
 I OK,TYPE=3,$D(^DGCR(399,IBIEN,"PRV","B",6)) D
 . S IBX1=$O(^DGCR(399,IBIEN,"PRV","B",6,0)) I IBX1="" Q
 . I $P($G(^DGCR(399,IBIEN,"PRV",IBX1,0)),"^",2)'="" S OK=0
 I OK,TYPE=6,$D(^DGCR(399,IBIEN,"PRV","B",3)) D
 . S IBX1=$O(^DGCR(399,IBIEN,"PRV","B",3,0)) I IBX1="" Q
 . I $P($G(^DGCR(399,IBIEN,"PRV",IBX1,0)),"^",2)'="" S OK=0
 Q OK
 ;
 ;IBCSC10H
