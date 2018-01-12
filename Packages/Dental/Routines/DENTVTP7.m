DENTVTP7 ;DSS/KC - RPCS FOR RESERVED TXNS ;05/11/2004 13:35
 ;;1.2;DENTAL;**39,47,50,57,59,63,66**;Aug 10, 2001;Build 36
 ;Copyright 1995-2013, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  this routine contains all the RPCs needed for reserved txns
 ;  DBIA#  Supported  Description
 ;  -----  ---------  ----------------
 ;   2053      x      ^DIE: UPDATE, WP
 ;  10103      x      $$NOW^XLFDT
 ;  10104      x      $$UP^XLFSTR
 ;  10013      x      ^DIK
 ;   2056      x      GETS^DIQ
 ;  10060      x      FM read of all fields in file 200
 ;
SAVE(DENT,DATA) ;  RPC: DENTV TP FILE RESERVED TXNS
 ;this rpc will allow the addition, update, or deletion of reserved txns
 ;  DATA - required
 ;  DATA(1) = FLG ^ PROV ^ DFN
 ;            if $G(FLG)="",$G(IEN)<1 then default to ADD
 ;            FLG - optional - A add/update new record (DEFAULT)
 ;                             D delete reserved txns
 ;           PROV - required - pointer to the New Person file (#200)
 ;            DFN - required - pointer to the patient file (#2)
 ;            
 ;  DATA(n) = reserved txn data   where n =2,3,4,5,6,...
 ;  Return(n) = 1^message if action successful, else return -1^message
 N X,Y,Z,DEN,DENER,DENIEN,DENX,DFN,DI,FLG,DENTI,PROV,DIERR,SAVE
 S DENTI=$O(DATA("")) I 'DENTI D MSG(1) Q
 S Z="FLG^PROV^DFN"
 F Y=1:1:3 S @$P(Z,U,Y)=$P(DATA(DENTI),U,Y)
 S FLG=$E(FLG) S:FLG?1L FLG=$$UP^XLFSTR(X) I FLG="" S FLG="A"
 I "AD"'[FLG D MSG(2) Q
 S X=$$DPRV^DENTVUTL(PROV) I 'X D MSG(3) Q
 S X=$$DFN^DENTVRF0(DFN,1) I +X=-1 S DENT=X Q
 S DENIEN=$O(^DENT(228.7,"AC",PROV,DFN,0))
 I DENIEN,FLG="A" S FLG="U"
 I FLG="D",'DENIEN D MSG(8) Q
 I FLG="D" D  Q  ;delete record
 .N DA,DD,DO,DIK S DA=DENIEN,DIK="^DENT(228.7," D ^DIK
 .S DENT="1^Reserved transactions deleted"
 .Q
 I $O(DATA(DENTI))="" D MSG(4) Q
 ; set the WP nodes for filing
 N PERIO ; only save 1 perio set of data! P50 (bug in Discus component)
 K DEN S Y=0,PERIO=0 F  S DENTI=$O(DATA(DENTI)) Q:'DENTI  D
 .I PERIO,$E(DATA(DENTI),1,6)="$$PE$$" S PERIO=2 ;another set
 .I PERIO=2,$E(DATA(DENTI),1,4)="$$PE" Q  ;don't save
 .I $E(DATA(DENTI),1,6)="$$PE$$" S PERIO=1 ;first pass, keep these
 .S Y=Y+1,DEN(Y)=DATA(DENTI)
 .Q
 I FLG="A" D  Q  ;add record
 .K DENIEN,DENX S DENX(228.7,"+1,",.01)=DFN
 .S DENX(228.7,"+1,",.02)=PROV
 .S DENX(228.7,"+1,",.03)=DFN
 .S DENX(228.7,"+1,",.04)=$$NOW^XLFDT
 .S DENX(228.7,"+1,",.05)="" ;New inactive flag reset on new save.
 .S DENX(228.7,"+1,",.06)=DUZ
 .S DENX(228.7,"+1,",1)="DEN"
 .S DENIEN(1)=""
 .D UPDATE^DIE(,"DENX","DENIEN","DENER")
 .I '$D(DIERR) S DENT="1^Reserved transactions saved"
 .E  D  Q
 ..S X=$$MSG^DSICFM01("VE",,,,"DENER")
 ..I $G(DENIEN(1))<1 S DENT="-1^"_X
 ..E  S DENT="1^"_X
 ..Q
 .Q
 ;update (wp info only)
 I $D(^DENT(228.7,DENIEN)),FLG="U" N DNTAR S DNTAR(228.7,DENIEN_",",.05)="",DNTAR(228.7,DENIEN_",",.04)=$$NOW^XLFDT D FILE^DIE(,"DNTAR") K DNTAR
 L +^DENT(228.7,DENIEN):2 E  D MSG(9) Q
 D WP^DIE(228.7,DENIEN_",",1,,"DEN","DENER")
 L -^DENT(228.7,DENIEN)
 I '$D(DIERR) S DENT="1^Reserved transactions updated"
 E  S DENT="-1^"_$$MSG^DSICFM01("VE","","","","DENER")
 Q
 ;
GET(DENT,PROV,DFN) ;  RPC: DENTV TP GET RESERVED TXNS
 ;  this will retreive all reserved txns for a provider/patient
 ;  PROV - required - pointer to the New Person file
 ;  DFN - required - pointer to the patient file
 ;  Return: global array ^TMP("DENT",$J,n)=value
 ;    if problems, ^TMP("DENT",$J,1) = -1^message
 ;    format of return of individual records:
 ;    ^TMP("DENT",$J,n) = 1st txn line
 ;                 n+m) = last txn line
 ;
 ; !DO NOT UNCOMMENT UNLESS SIDELOADING SITE DATA!
 ; Debugging code to sideload broker history data
 ;
 ;S X=$$FTG^%ZISH("C:\HFS\","Reserved.txt","^TMP(""DENTVAU"",0)",2,"OVF")
 ;S DENT=$NA(^TMP("DENTVAU")) Q
 ;
 N DENIEN,CNT,DENTAR,I,DENER,ZNODE,ZN,X0,INAC,SAVE,TXNTC,TXNOTC
 S DENT=$NA(^TMP("DENT",$J)) K @DENT
 I '$G(PROV) S @DENT@(1)="-1^No provider received" Q
 I '$G(DFN) S @DENT@(1)="-1^No patient received" Q
 S DENIEN=$O(^DENT(228.7,"AC",PROV,DFN,0))
 I 'DENIEN S @DENT@(1)="-1^No transactions found" Q
 S SAVE=$P($G(^DENT(228.7,DENIEN,0)),U,6)
 K ^TMP("DENTV",$J,"TC") ;P57 for timecounter
 ;Inactive check P59
 D CHKINA(,DENIEN) ;Check whether unfiled data is >8 days, inactivate
 S INAC=$$GET1^DIQ(228.7,DENIEN_",",.05,"I")
 I INAC D  Q
 .S CNT=1,@DENT@(CNT)="$$IEN$$^"_$P(DENIEN,",")
 .S CNT=CNT+1,@DENT@(CNT)="$$INACTIVE$$^"_INAC
 ;
 S DENIEN=DENIEN_"," D GETS^DIQ(228.7,DENIEN,1,"E","DENTAR","DENER")
 I '$D(DENTAR) S @DENT@(1)="-1^No transactions found" Q
 S I=0,CNT=0 F  S I=$O(DENTAR(228.7,DENIEN,1,I)) Q:'I  D
 .S ZNODE=DENTAR(228.7,DENIEN,1,I)
 .I $E(ZNODE,1,6)="$$PE$$" S ZN=$G(DENTAR(228.7,DENIEN,1,I+1)) I $E(ZN,1,7)="$$PED$$" D  Q
 ..S CNT=CNT+1,@DENT@(CNT)=ZNODE ;get the first perio node
 ..S CNT=CNT+1,@DENT@(CNT)="$$PEN$$^" ;P47 fix old perio null issue
 ..S ZN="0",ZN=$TR($J(ZN,200)," ","0") ;force 200 char perionullhex value
 ..S CNT=CNT+1,@DENT@(CNT)="$$PEN$$^"_ZN
 ..Q
 .S TXNOTC(+$G(I))=$P(ZNODE,U,22)
 .I $E(ZNODE,1,6)="$$TX$$" S $P(ZNODE,U,21)=$$CNVT^DSICDT(,DT,"F","E",5,,1) D VALTC ;P57
 .S TXNTC(+$G(I))=$P(ZNODE,U,22)
 .S CNT=CNT+1,@DENT@(CNT)=ZNODE
 .Q
 ;Patch 59 additions : Exam template
 S CNT=CNT+1,@DENT@(CNT)="$$IEN$$^"_$P(DENIEN,",") ;CNT=CNT+1
 S CNT=CNT+1,@DENT@(CNT)="$$SAVE$$^"_$$EXTERNAL^DILFD(228.7,.06,"",SAVE) ;CNT=CNT+1 Return Entered By field
 I '$D(@DENT) S @DENT@(1)="-1^No records found"
 K ^TMP("DENTV",$J,"TC")
 Q
VALTC ;validate the timecounter going back to the GUI P57
 ;This value must be unique for a txn or ranged txn 'set' for the day
 ;another user may have filed data to the patient, so the TC must be reset
 N X,Y S Y=$P(ZNODE,U,22),X=$$CNVT^DSICDT(,$P(ZNODE,U,21),"E","F",,,1) Q:'X  ;not valid dt?
 ;P57
 I $O(^DENT(228.2,"AE",DFN,+X,+Y,0)) D RESET(X) Q
 ;P66 Check unfiled data to maintain sequence and prevent duplicates
 I $P(ZNODE,U,22)<+$G(TXNTC($G(I)-1)) D RESET(X,TXNOTC(I-1)=$P(ZNODE,U,22)) Q
 S ^TMP("DENTV",$J,"TC","LAST")=$P(ZNODE,U,22)
 S ^TMP("DENTV",$J,"TC",+$P(ZNODE,U,22))=$P(ZNODE,U,22)
 Q
RESET(CDAT,GRP) ;reset the timecounter/slightly different than code in DENTVTPC P57
 ;txns may file in any order - grouped txns need the same timecounter, even if reset
 ;because we don't file here and update the "AE" x-ref for each xref,
 ; we update "LAST" node each time we use a new number
 N LAST
 S:$G(GRP)="" GRP=1
 ;P66 Added GRP flag to denote if the timecounter in question is part of a group of transactions
 I +$G(GRP) S LAST=$G(^TMP("DENTV",$J,"TC",+$P(ZNODE,U,22))) I LAST S $P(ZNODE,U,22)=LAST Q
 S LAST=$G(^TMP("DENTV",$J,"TC","LAST")) ;we don't "file", need to update something temporarily
 S:'LAST LAST=$O(^DENT(228.2,"AE",DFN,CDAT,9999),-1) ;get last tc from txn file
 S LAST=LAST+10,^TMP("DENTV",$J,"TC","LAST")=LAST ;add 10 to become "new" last
 ;save in case of grouped txns and update the timecounter field with new tc
 S ^TMP("DENTV",$J,"TC",+$P(ZNODE,U,22))=LAST,$P(ZNODE,U,22)=LAST
 Q
GETUN(DENT,TIEN) ; RPC: DENTV GET UNFILED DETAIL - Added Patch 59
 ;  Input is IEN of record needing to be extracted
 ;  Returns ^TMP("DENT",$J,N) where N is the WP FIELD 1
 ;                 or  ^TMP("DENT",$J,1)='1^Message
 N DENTAR,DENTER,CNT,XX,DENTWP S CNT=0
 S DENT=$NA(^TMP("DENT",$J)) K @DENT
 I 'TIEN S @DENT@(1)="-1^No Transaction selected" Q
 I $D(^DENT(228.7,TIEN))=0 S @DENT@(1)="-1^No Transaction found" Q
 S TIEN=TIEN_"," D GETS^DIQ(228.7,TIEN,"1","I","DENTAR","DENTER")
 I '$D(DENTAR) S @DENT@(1)="-1^No Transactions Found"
 N I S I=0 F  S I=$O(DENTAR(228.7,TIEN,1,I)) Q:'I  D
 .S CNT=CNT+1,@DENT@(CNT)=$G(DENTAR(228.7,TIEN,1,I))
 I '$D(@DENT) S @DENT@(1)="-1^Error returning record"
 Q
CLNSLT(RET,DPAT,ACT) ; RPC: DENTV TP CLEAN SLATE
 ; This RPC will "clean slate" all of the graphics for a specific patient
 ; with a flag (ACT) to determine if we are undoing or doing clean slate.
 ;      ACT=1 ; Process clean slate
 ;      ACT=-1; Undo clean slate
 ; Input is Patient IEN (DPAT)
 ; Patient MUST NOT have unfiled data. If there is unfiled data -1^Error will be returned.
 ; 
 N II,DAT,DENT,UNF,DENPL,DIK,DA,DENTV,TMP S II=0,DENT="",DENPL=""
  I ACT=-1 S ACT=0
 I $D(^DENT(228.2,"C",DPAT))=0 S RET="-1^Patient has no transactions to clean slate." Q
 S II="~" S II=$O(^DENT(228.2,"AD",DPAT,1,II),-1)
 I ACT S DENT=$$GET1^DIQ(228.2,II_",","1.9","I") I DENT S RET="-1^The Patient's transactions have already been clean slated." Q
 S II=0,DENT=""
 I ACT D
 .; First we inactivate unfiled data 
 .D INUF(DPAT,"1")
 .F  S II=$O(^DENT(228.2,"AD",DPAT,1,II)) Q:'II  D
 ..S DENT=$$GET1^DIQ(228.2,II_",",".2","I")
 ..I DENT S DENTV(228.2,II_",",1.9)=$$NOW^XLFDT S DENTV(228.2,II_",",.2)="0" D FILE^DIE(,"DENTV") K DENTV
 .I $D(^DENT(228.2,"AP",DPAT)) D
 ..S II=0 F  S II=$O(^DENT(228.2,"AP",DPAT,II)) Q:'II  D
 ...S DIK="^DENT(228.2,",DA=II D ^DIK
 .S II=0 F  S II=$O(^DENT(228.6,"B",DPAT,II)) Q:'II  D
 ..S TMP=$$GET1^DIQ(228.6,II_",",.04,"I")
 ..I TMP=4 S DIK="^DENT(228.6,",DA=II D ^DIK
 .S RET="1^Clean Slate successful. Planned care deleted."
 I 'ACT D
 .N FLG S FLG=$$CHKCL(DPAT)
 .;S UNF=$$CHKUF(DPAT)
 .D INUF(DPAT,"0")
 .I 'FLG S RET="-1^Clean slate cannot be done. Newer transactions exist." Q
 .S II="~" F  S II=$O(^DENT(228.2,"AD",DPAT,1,II),-1) Q:'II  D
 ..S DAT=$$GET1^DIQ(228.2,II_",","1.9","I")
 ..I DAT'="" S II=0
 .I DAT="" S RET="-1^No clean slate found to undo" Q
 .S II="" F  S II=$O(^DENT(228.2,"AD",DPAT,1,II),-1) Q:'II  D
 ..S DENT=$$GET1^DIQ(228.2,II_",","1.9","I")
 ..I DAT=DENT S DENTV(228.2,II_",",.2)="1" S DENTV(228.2,II_",",1.9)="" D FILE^DIE(,"DENTV") K DENTV
 .S RET="0^Clean Slate undone.^"_DAT
 Q
INUF(DPAT,ACT) ; Inactivate patient unfiled data when processing a clean slate
 ; this will make the data 'read-only' for informative purposes only
 ; DPAT - patient IEN
 ; ACT - action for inactivating unfiled data
 ;       1 inactivate the data
 ;       0 re-activate the data (undoing a clean slate)
 N IEN,DENTV S IEN=0
 I ACT D
 .F  S IEN=$O(^DENT(228.7,"B",DPAT,IEN)) Q:'IEN  D
 ..S DENTV(228.7,IEN_",",.05)=1
 ..D FILE^DIE(,"DENTV",)
 I 'ACT D
 .F  S IEN=$O(^DENT(228.7,"B",DPAT,IEN)) Q:'IEN  D
 ..S DENTV(228.7,IEN_",",.05)=""
 ..D FILE^DIE(,"DENTV")
 Q
CHKCL(DPAT) ; Checks to see if a patient has newer transactions on a clean slate
 ; Returns 1 if undo is possible, 0 if undo cannot be proccessed
 N DENT,TDAT,IENS,DTMP,CTMP,DENTERR S IENS="~",DTMP="",CTMP=""
 ;I $D(^DENT(228.2,"C",DPAT))=0 Q 1 ;No filed data for patient
 F  S IENS=$O(^DENT(228.2,"C",DPAT,IENS),-1) Q:'IENS  D 
 .D GETS^DIQ(228.2,IENS_",",".23;.29;1.01;1.9;","I","DENT","DENTERR")
 .I DTMP="" I DENT(228.2,IENS_",",.23,"I")="0" S DTMP=DENT(228.2,IENS_",",1.01,"I")
 .I DENT(228.2,IENS_",",1.9,"I")'="" S CTMP=DENT(228.2,IENS_",",1.9,"I")
 .I DTMP'="",CTMP'="" S IENS="0"
 ;
 ;I CTMP="" Q 1
 I DTMP>CTMP Q 0
 I DTMP<=CTMP Q 1
GETCSL(DENTV,DPAT) ; RPC - DENTV GET CLEAN SLATE LIST
 ; This rpc will return the most recent date of a clean slate transaction, or -1 if there is none
 ; Input - DPAT - Patient pointer
 ; Output - DENTV(1) = 1^Dates found, 
 ;          DENTV(2+N)=FM date of clean slate
 ;     OR   DENTV(1) = -1^No clean slate present
 N II,DENT,CHK,CNT S DENT="",II="~",CNT=2,DENTV(1)="1^Dates found"
 F  S II=$O(^DENT(228.2,"AD",DPAT,1,II),-1) Q:'II  D
 .S CHK=$$GET1^DIQ(228.2,II_",","1.9","I") I CHK D
 ..I CNT=2 I CHK S DENTV(CNT)=CHK S CNT=CNT+1 Q
 ..I DENTV(CNT-1)'=CHK S DENTV(CNT)=CHK S CNT=CNT+1
 I '$D(DENTV(2)) S DENTV(1)="-1^No clean slate present" Q
 Q
GETFEX(RET,DPAT) ; RPC: DENTV TP GET EXAM TRANSACTIONS
 ; INPUT IS DPAT - PATIENT IEN FOR INFORMATION REQUESTED.
 ;OUTPUT - An array of records returned by group preceded by a $$START^Group name
 ;         for all filed transactions for this patient.
 N I,CNT,FLD,II,TMP,DENT,DENTWP,DENTER,ZZ,XX,YY,X0,PROV,FLG
 S I=0,CNT=1
 I 'DPAT S RET(1)="-1^No patient selected" Q
 I '$D(^DENT(228.2,"AD",DPAT)) S RET(1)="-1^Patient has no transactions to return" Q
 F TMP="OHA","OCC","PAR","PARC","TMJ","TMJC","SOCH","SHDA" S FLG=0 D
 .;.S RET(CNT)="$$START^"_TMP,CNT=CNT+1
 .F  S I=$O(^DENT(228.2,"AD",DPAT,5,I)) Q:'I  D
 ..I $D(^DENT(228.2,I,TMP)) D
 ...I 'FLG S RET(CNT)="$$START^"_TMP,CNT=CNT+1,FLG=1
 ...S PROV=$P(^DENT(228.2,I,0),U,3)
 ...S RET(CNT)=$P($G(^DENT(228.2,I,0)),U)_"^"_$P($G(^DENT(228.2,I,0)),U,13)_"^"_PROV
 ...S $P(RET(CNT),U,4)=$G(^DENT(228.2,I,TMP))
 ...I TMP="OHA" D
 ....S X0=$$GET1^DIQ(200,PROV,1),$P(RET(CNT),U,9)=X0
 ...I TMP="PAR" D   ;Populate the "other" field for PAR,PARC,TMJ,TMJC regarding the WP fields
 ....I $D(^DENT(228.2,I,"PARWP")) S $P(RET(CNT),U,8)=1
 ....E  S $P(RET(CNT),U,8)=0
 ...I TMP="PARC" D
 ....I $D(^DENT(228.2,I,"PARCWP")) S $P(RET(CNT),U,9)=1
 ....E  S $P(RET(CNT),U,9)=0
 ...I TMP="TMJ" D
 ....I $D(^DENT(228.2,I,"TMJWP")) S $P(RET(CNT),U,12)=1
 ....E  S $P(RET(CNT),U,12)=0
 ...I TMP="TMJC" D
 ....I $D(^DENT(228.2,I,"TMJCWP")) S $P(RET(CNT),U,11)=1
 ....E  S $P(RET(CNT),U,11)=0
 ..S CNT=CNT+1
 S I=0
 F TMP="PARWP","PARCWP","TMJWP","TMJCWP","SHWP" S FLG=0 D
 .F  S I=$O(^DENT(228.2,"AD",DPAT,5,I)) Q:'I  D
 ..K DENTWP
 ..S ZZ=$S(TMP="PARWP":6,TMP="PARCWP":7,TMP="TMJWP":8,TMP="TMJCWP":9,TMP="SHWP":10.4)
 ..I $D(^DENT(228.2,I,TMP)) D
 ...I 'FLG S RET(CNT)="$$START^"_TMP,CNT=CNT+1,FLG=1
 ...D GETS^DIQ(228.2,I_",",".01;.03;.13","I","DENT","DENTER")
 ...I $D(^DENT(228.2,I,TMP)) S XX=$$GET1^DIQ(228.2,I_",",ZZ,"","DENTWP")
 ...S YY=0 F  S YY=$O(DENTWP(YY)) Q:'YY  D
 ....S RET(CNT)=$G(DENT(228.2,I_",",.01,"I"))_"^"_$G(DENTWP(YY)),CNT=CNT+1
 I '$D(RET) S RET(1)="0^Patient has no records to return"
 Q
 ;-------------------------  subroutines  -------------------------
MSG(X) ;
 I X=1 S X="No input array received"
 I X=2 S X="Invalid filing flag received: "_FLG
 I X=3 S X="Not a Dental Provider"
 I X=4 S X="No transaction data received"
 I X=8 S X="No record exists to delete"
 I X=9 S X="Unable to lock record #:"_DENIEN_", try again"
 S DENT="-1^"_X
 Q
CHKINA(RET,DENTIEN) ; RPC: DENTV TP RESERVED INACT CHECK
 N DENT,RESDAT,DENTERR,FLAG,DFN,TIEN,PERDAT S FLAG=0,TIEN=""
 I '$D(^DENT(228.7,DENTIEN)) S RET="-1^The IEN "_DENTIEN_" was not found." Q
 S RESDAT=$$GET1^DIQ(228.7,DENTIEN_",",.04,"I")
 I $$FMDIFF^XLFDT(DT,RESDAT,1)>8 S DENT(228.7,DENTIEN_",",.05)=1,FLAG=1 D FILE^DIE(,"DENT","DENTERR")
 I '$D(DENTER),FLAG S RET="1^Reserve Transaction "_DENTIEN_" exceeds the 8 days alotted and has been inactivated."
 S DFN=$P($G(^DENT(228.7,DENTIEN,0)),U,3)
 I 'FLAG S RET="0^Reserve Transaction "_DENTIEN_" does not exceed the alotted 8 days."
 Q
