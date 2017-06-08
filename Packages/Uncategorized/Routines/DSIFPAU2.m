DSIFPAU2 ;AISC/DMK,DLF -ENTER PAYMENT FOR CONTRACT HOSPITAL ;8/18/2004
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; Integration Agreements:
 ;   4436  $$CREATE^DGPTFEE
 ;   5273  ^FBAA(161.7                              5275  ^FBAA(161.4
 ;   5277  ^FBAAI("E"                                 5278  ^FBAAV
 ;   5397  ^FB583                                     10103  $$FMDIFF^XLFDT
 ;
 ;INPUT
 ;     DSIFIN1 - Input string, pieces below
 ;       Piece 1 ^ Exempt from pricer (1 - Yes, Null for no)
 ;             2 ^ Medicare ID Number
 ;             3 ^ IEN of Fee Basis Batch File (#161.7)
 ;             4 ^ Vendor's Invoice Date
 ;             5 ^ Patient Control Number
 ;             6 ^ FPPS CLAIM ID for the EDI claim
 ;             7 ^ FPPS LINE ITEM(S), number or a list or range, e.g., 1,3,5 or 2-4,8 or ALL
 ;
 S FBAAPTC="V" K FBAAOUT
RD S FBRESUB="",DSIFIN1=$G(DSIFIN1),DSIFIN=$G(DSIFIN)
 I DFN']"" S DSIFOUT="-1^No Patient selected for Payment to Contract Hospital",DSIFERR=1 G Q
 S FBPROG="I $P(^(0),U,3)=6,($P(^(0),U,9)'[""FB583"")" D GETAUTH^DSIFPAU1
 I DSIFERR!FTP']"" S DSIFOUT="-1^No Authorization for Payment for Contract Hospital",DSIFERR=1 Q
 I FB583="" S DSIFOUT="-1^No 583 on file for this authorization.",DSIFERR=1 Q
 S FBI583=FB583_";FB583("
 S FBAAVID=$P(DSIFIN1,U,4),FBAAID=$P(DSIFIN,U,6),FBAADT=$P(DSIFIN,U,12)
 ; Verify invoice number
 I $D(^FBAAI("E",FBI583)),$O(^FBAAI("E",FBI583,0))'=FBAAIN S DSIFOUT="-1^Invoice number mismatch",DSIFERR=1 Q
 ;
SETINV S FBZ(0)=^FB583(FB583,0),FBVET=$P(FBZ(0),"^",4),FBVEN=$P(FBZ(0),"^",3)
 ; Verify 583 entries
 I FBVEN'=$P(DSIFIN,U,2) S DSIFOUT="-1^Invalid vendor IEN",DSIFERR=1 Q
 I FBVET'=$P(DSIFIN,U) S DSIFOUT="-1^Invalid veteran IEN",DSIFERR=1 Q
 ;
EN583 ;Entry from 583 enter payment cloned from FBCHEP
 I $P($G(^FBAAV(FBVEN,"ADEL")),U)="Y" S DSIFOUT="-1^Vendor is flagged for Austin deletion!",DSIFERR=1 G Q
 D SITEP G Q:FBPOP
 S FBAAMPI=$P(FBSITE("FBNUM"),U,4)
 ;
RDV S FBVE="" S:$D(^FBAAV($P(DSIFIN,U,2),"AMS")) FBVE=$P(^("AMS"),"^",2) S:$G(FBVE)'="Y" FBVE="N"
 I FBVE="Y",$P(DSIFIN1,"^",1)="" S DSIFOUT="-1^Vendor is listed as 'exempt from the pricer'. Do you wish to keep this invoice exempt from the pricer?",DSIFERR=1 Q
 I FBVE="Y",$P(DSIFIN1,U)'="" S FBVE=$S($P(DSIFIN1,U)=0:"N",1:"Y")
 N DSIFTMID,DSIFTMF
 S DSIFTMF=0,DSIFTMID=$P(DSIFIN1,"^",2)
 I $G(FBVE)'="Y",($P($G(^FBAAV(FBVEN,0)),"^",17)']"") D  Q:DSIFTMF
 . I DSIFTMID="" S DSIFOUT="-1^Medicare ID Number is needed for this Vendor!",DSIFERR=1,DSIFTMF=1 Q
 K DSIFTMID,DSIFTMF
 ;
BAT ;
 S FBAABE=$P(DSIFIN1,"^",3) I FBAABE="" S DSIFOUT="-1^No Fee Basis Batch Number",DSIFERR=1 Q
 I '$D(^FBAA(161.7,FBAABE,0)) S DSIFOUT="-1^Invalid Fee Basis Batch Number",DSIFERR=1 Q
 S Y(0)=$G(^FBAA(161.7,FBAABE,0))
 S FBY(0)=Y(0),Z1=$P(FBY(0),"^",11),BO=$P(FBY(0),"^",2),Z2=$P(FBY(0),"^",10),FBSTN=$P(FBY(0),"^",8),FBCHOB=FBSTN_"-"_$P(FBY(0),"^",2),FBEXMPT=$P(FBY(0),"^",18)
 S DSIFERR=0 D CHK I DSIFERR K Y,Y(0) Q
 I $G(FBI583)["FB583(",BO'=$P($P(FBY(0),U,2),".") S DSIFOUT="Obligation number on batch does not match 1358.  Obligation number on batch must be "_$P($P(FBZ(0),U),".")_".",DSIFERR=1 Q
 S FBINC=$S($P(FBY(0),"^",10)="":0,1:$P(FBY(0),"^",10)),FBLN=$S($P(FBY(0),"^",11)="":0,1:$P(FBY(0),"^",11))
 ;
RIN D GETINDT G Q:$G(DSIFERR)
 ; patient control number
 S FBCSID=$P(DSIFIN1,"^",5)
 ; if U/C then get FPPS Claim ID else ask user
 I $D(FB583) S FBFPPSC=$P($G(^FB583(FB583,5)),U) I FBFPPSC,FBFPPSC'=$P(DSIFIN1,U,6) S DSIFOUT="-1^The FPPS Claim ID's do not match",DSIFERR=1 Q
 ; if EDI claim then ask FPPS line item
 I FBFPPSC]"" S FBFPPSL=$P(DSIFIN1,"^",7) I FBFPPSL="" S DSIFOUT="-1^FPPS line item was not entered",DSIFERR=1 Q
 ; compute default Covered Days
 S FBCDAYS=$$FMDIFF^XLFDT(FBAAEDT,FBAABDT)
 I FBCDAYS=0 S FBCDAYS=1
 S FBAAMM=$S(FBAAPTC="R":"",$D(FB583):"",1:1),FBAAMM1=$P(DSIFIN,"^",16)
 S NEW=$P(DSIFIN1,U,8)
 D EN^DSIFPAU3 Q:DSIFOUT<0!(DSIFERR)
 K DIE,DIC,D,DA,DR
  ; reset batch totals
 K Z1,FBINTOT
 I '$D(CHDATA) S $P(^FBAA(161.7,FBAABE,0),"^",11)=$P(^FBAA(161.7,FBAABE,0),"^",11)+1
 S FBINTOT=$P(^FBAA(161.7,FBAABE,0),"^",9)+$G(FBAMTPD),$P(^FBAA(161.7,FBAABE,0),"^",9)=FBINTOT,$P(^FBAA(161.7,FBAABE,0),"^",18)=FBEXMPT
 S Z(0)=^FBAA(161.7,FBAABE,0) D:'FBANC PTF
 Q
Q K BO,CNT,D,DA,DAT,DIC,DIE,DLAYGO,DR,FB583,FBAABDT,FBAAEDT,FBAAID,FBAAPTC,FBDX,FBTT,FBTYPE,FBVEN,FBVET,FBXX,FTP,I,J,FBK,PI,FBPOP,PTYPE,S,FBZ,Z1,FBI,FBPROG,FBRR,FBSW,FBPOV,FBPT,FBY,T,Y,Z1,Z2,ZZ,FBPSA,A,FBI583
 K FBCHOB,FBAUT,FBSEQ,X,FBSITE,F,FBSTN,FBASSOC,FBLOC,DUOUT,PSA,FBCOUNTY,DFN,DIRUT,FBVE,FBEXMPT,FBAAPN,FBAMTC,FBDEL,FBINC,FBLN,FBRESUB
 K FBD1,FBFDC,FBMST,FBTTYPE,FB583,FBCSID,FBFPPSC,FBFPPSL,FBCDAYS,FBAMTP,FBADJ,FBRRMK,FBNOPTF
 K FBCSID,FBFPPSC,FBFPPSL,FBCDAYS,FBAMTP,FBADJ,FBRRMK,FBAAMPI,FBV
 K FBCNTRA   ;Cloned from D GETAUTHK^FBAAUTL1 DSIF*3.2*2
 Q
PTF I $G(FBVET),$G(FBI583)["FB583" S:'$G(DFN) DFN=FBVET D PTFC(DFN,$P(^FB583(FB583,0),U,13))
 Q
PRBT ;Entry point for patient reimbursement option
 ;
 S FBAAPTC="R"
 G RD
CHK ;Check for vendor and batch being exempt from pricer
 I $G(FBVE)'="Y"&($G(FBVE)'="N") S FBVE="N"
 I $G(FBEXMPT)="Y" Q:FBVE="Y"  G OPEN:FBVE="N"
 I $G(FBEXMPT)="N" Q:FBVE="N"  G OPEN:FBVE="Y"
 I '$G(FBEXMPT)&($G(Z2)'>0) S FBEXMPT=FBVE Q
 I '$G(FBEXMPT)&($G(Z2)>0) S $P(^FBAA(161.7,FBAABE,0),"^",18)="N",FBEXMPT="N" Q
 Q
OPEN ;
 S DSIFOUT="-1^This Invoice may not be added to Batch # "_+FBY(0)_".  ***You may not add a "_$S(FBVE="Y":"pricer exempt",1:"non-exempt")_" invoice to a "_$S(FBVE="Y":"non-exempt",1:"pricer exempt")_" batch.***"
 Q
 ;
 ; Cloned from SITEP^FBAAUTL
SITEP ;SET FBSITE(0),FBSITE(1) VARIABLE TO FEE SITE PARAMETERS
 S FBPOP=0,FBSITE(0)=$G(^FBAA(161.4,1,0)) S:FBSITE(0)']"" FBPOP=1
 S FBSITE(1)=$G(^FBAA(161.4,1,1)) S:FBSITE(1)']"" FBPOP=1
 S FBSITE("FBNUM")=$G(^FBAA(161.4,1,"FBNUM")) S:FBSITE("FBNUM")']"" FBPOP=1
 I FBPOP S DSIFOUT="-1^Fee Basis Site Parameters must be entered to proceed",DSIFERR=1
 Q
 ;
 ;Cloned from GETINDT^FBAACO1
GETINDT ;get invoice dates
 ;input requires FBAABDT (authorization from date)
 K FBAAOUT
 S FBAAID=$P(DSIFIN,"^",6)
 I '$G(FBCNP) I FBAAID<FBAABDT S DSIFOUT="-1^Invoice date is earlier than Patient's Authorization date!!",DSIFERR=1 Q
GETIND1 ;
 I FBAAVID>FBAAID S DSIFOUT="-1^Vendor's invoice date is later than the date you received it!!",DSIFERR=1 Q
 Q
 ;
 ;Cloned from ^FBUTL6
PTFC(DFN,FBDT) ; Create Non-VA PTF Record
 ; Input
 ;   DFN  - IEN of entry in PATIENT (#2) file
 ;   FBDT - Admission Date/Time, FileMan internal format, time optional
 N FBX
 I $G(DFN),$G(FBDT) S FBX=$$CREATE^DGPTFEE(DFN,FBDT,1)
 I $G(FBX)<1 S DSIFOUT="-1^Unable to create Non-VA PTF Record.",DSIFERR=1 Q
 Q
