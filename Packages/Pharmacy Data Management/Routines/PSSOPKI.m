PSSOPKI ;BHAM ISC/MHA-New API's to CPRS for DEA/PKI Pilot Project ;03/11/02
 ;;1.0;PHARMACY DATA MANAGEMENT;**61,69,166,183,209,219,246,247,261**;9/30/97;Build 3
 ;Reference to ^PSNDF(50.68 supported by DBIA 3735
 ;
OIDEA(PSSXOI,PSSXOIP) ; CPRS Orderable Item call 
 ;returns the CS Federal Schedule code in the VA PRODUCT file (#50.68)
 ;or the DEA Special Hndl code depending on the "ND" node of the 
 ;drugs associated to the Orderable Item, and Usage passed in
 ;1  Sch. I Nar.
 ;2  II
 ;2n II Non-Nar.
 ;3  III
 ;3n III Non-Nar.
 ;4  IV
 ;5  V
 ;0  there are other active drugs
 ;"" no active drugs
 ;
 N PSSXOLP,PSSXOLPD,PSSXOLPX,PSSXNODD,PSSPKLX,PSSI,PSSK,PSSJ,PSSGD
 S (PSSXOLPD,PSSXNODD)=0 I PSSXOIP="X" G OIQ
 I '$G(PSSXOI)!($G(PSSXOIP)="") G OIQ
 S PSSPKLX=$S(PSSXOIP="I":1,PSSXOIP="U":1,1:0)
 F PSSXOLP=0:0 S PSSXOLP=$O(^PSDRUG("ASP",PSSXOI,PSSXOLP)) Q:'PSSXOLP  D
 .I $P($G(^PSDRUG(PSSXOLP,"I")),"^"),$P($G(^("I")),"^")<DT Q
 .I 'PSSPKLX,$P($G(^PSDRUG(PSSXOLP,2)),"^",3)'["O" Q
 .I PSSPKLX I $P($G(^PSDRUG(PSSXOLP,2)),"^",3)'["U",$P($G(^(2)),"^",3)'["I" Q
 .S PSSXNODD=1,PSSJ=($P($G(^PSDRUG(PSSXOLP,0)),"^",3)) S:PSSJ]"" PSSGD(PSSJ)=""
 .I +$P($G(^PSDRUG(PSSXOLP,"ND")),"^",3) S PSSK=$P(^("ND"),"^",3) D
 ..I +$P($G(^PSNDF(50.68,PSSK,7)),"^") S PSSK=$P(^(7),"^"),PSSI($S($E(PSSK,2)="n":$E(PSSK)_".5",1:PSSK))=""
 G:$O(PSSI(""))]"" CSS
 S PSSXOLPX="" F  S PSSXOLPX=$O(PSSGD(PSSXOLPX)) Q:PSSXOLPX=""  D
 .I PSSXOLPX[1 S PSSI(1)="" Q
 .I PSSXOLPX[2,PSSXOLPX'["C" S PSSI(2)="" Q
 .I PSSXOLPX[2,PSSXOLPX["C" S PSSI(2.5)="" Q
 .I PSSXOLPX[3,PSSXOLPX'["C" S PSSI(3)="" Q
 .I PSSXOLPX[3,PSSXOLPX["C" S PSSI(3.5)="" Q
 .I PSSXOLPX[4 S PSSI(4)="" Q
 .I PSSXOLPX[5 S PSSI(5)=""
CSS S PSSK=0 S PSSK=$O(PSSI(PSSK)) I PSSK S PSSXOLPD=$E(PSSK)_$S($L(PSSK)>1:"n",1:"")
OIQ I PSSXOLPD=0 S:'PSSXNODD PSSXOLPD=""
 I +PSSXOLPD=1!(+PSSXOLPD=2) S PSSXOLPD=1_";"_PSSXOLPD
 I +PSSXOLPD=3!(+PSSXOLPD=4)!(+PSSXOLPD=5) S PSSXOLPD=2_";"_PSSXOLPD
 Q PSSXOLPD
 ;
DEAPKI(PSSDIENM) ;Return CS Federal Sch or the DEA Special Hndl for CPRS Dose Call - PKI Project
 Q:'$G(PSSDIENM)
 N PSSDEAX,PSSDEAXV,PSSJ
 I +$P($G(^PSDRUG(PSSDIENM,"ND")),"^",3) S PSSDEAX=$P(^("ND"),"^",3) D
 .I +$P($G(^PSNDF(50.68,PSSDEAX,7)),"^") S PSSDEAXV=$P(^(7),"^"),PSSJ=1
 G:$G(PSSJ) DSET
 S PSSDEAX=$P($G(^PSDRUG(PSSDIENM,0)),"^",3)
 I PSSDEAX[1 S PSSDEAXV=1 G DSET
 I PSSDEAX[2,PSSDEAX'["C" S PSSDEAXV=2 G DSET
 I PSSDEAX[2,PSSDEAX["C" S PSSDEAXV="2n" G DSET
 I PSSDEAX[3,PSSDEAX'["C" S PSSDEAXV=3 G DSET
 I PSSDEAX[3,PSSDEAX["C" S PSSDEAXV="3n" G DSET
 I PSSDEAX[4 S PSSDEAXV=4 G DSET
 I PSSDEAX[5 S PSSDEAXV=5 G DSET
 S PSSDEAXV=0
DSET ;
 I +PSSDEAXV=1!(+PSSDEAXV=2) S PSSDEAXV=1_";"_PSSDEAXV
 I +PSSDEAXV=3!(+PSSDEAXV=4)!(+PSSDEAXV=5) S PSSDEAXV=2_";"_PSSDEAXV
 S PSSX("DD",PSSDIENM)=PSSX("DD",PSSDIENM)_"^"_PSSDEAXV_"^"_$S($D(PSSHLF(PSSDIENM)):1,1:0)
 Q
 ;
DETOX(PSSDIEN) ; BUPREN drug check to determine if drug is a detox medication
 ; Input - PSSDIEN - Drug IEN
 ; Output - returns 1 if the drugs is a Detox medication, otherwise it returns 0
 ;
 Q 0 ;P261 detox/x-waiver removal
 Q:'$G(PSSDIEN) 0
 Q:$P($G(^PSDRUG(PSSDIEN,0)),"^")'["BUPREN" 0
 N PSSJ,PSSY,PSSNDF,PKGLIST,SYSLIST
 S PSSJ=1
 D GETLST^XPAR(.PKGLIST,"PKG","PSS BUPRENORPHINE PAIN VAPRODS","N") D DETINDEX(.PKGLIST)
 D GETLST^XPAR(.SYSLIST,"SYS","PSS BUPRENORPHINE PAIN VAPRODS","N") D DETINDEX(.SYSLIST)
 I +$P($G(^PSDRUG(PSSDIEN,"ND")),"^",3) S PSSNDF=$P(^("ND"),"^",3) D  Q PSSJ
 .S PSSY=$$GET1^DIQ(50.68,PSSNDF,4) I PSSY'="",($D(PKGLIST("B",PSSY))!$D(SYSLIST("B",PSSY))) S PSSJ=0
 Q PSSJ
 ;
DETINDEX(LIST) ;
 N I,IEN
 S I=0 F  S I=$O(LIST(I)) Q:'I  D
 .S IEN=$P(LIST(I),U) S LIST("B",$$GET1^DIQ(50.68,IEN,4))=""
 Q
 ;
OIDETOX(PSSXOI,PSSXOIP) ; CPRS Orderable Item to check a drug is a DETOX or not 
 ;Input - PSSXOI - Orderable Item IEN
 ;      - PSSXOIP - Package
 ;Output - returns 1 if the drugs associated to the Orderable Item contains the text "BUPREN" as part of the name
 ;         otherwise it returns 0
 Q 0 ;P261 detox/x-waiver removal
 N PSSDTOX,PSSLP,PSSDPK
 I '$G(PSSXOI)!($G(PSSXOIP)="")!(PSSXOIP'="O") Q 0
 S (PSSLP,PSSDTOX)=0
 F  S PSSLP=$O(^PSDRUG("ASP",PSSXOI,PSSLP)) Q:'PSSLP!PSSDTOX  D
 .I $P($G(^PSDRUG(PSSLP,"I")),"^"),$P($G(^("I")),"^")<DT Q
 .S PSSDPK=$P($G(^PSDRUG(PSSLP,2)),"^",3)
 .Q:PSSDPK=""!(PSSDPK'["O")
 .I $$DETOX(PSSLP) S PSSDTOX=1 Q
 Q PSSDTOX
 ;
BUPARED ; Manage Buprenorphine Tx of Pain using VA Product file (#50.68)
 D EDITPAR^XPAREDIT("PSS BUPRENORPHINE PAIN VAPRODS")
 Q
