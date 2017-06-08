DSIFENA3 ;DSS/RED - RPC FOR FEE BASIS ;12/21/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; Routine for API's used in Fee Basis to Enter/edit/delete FB Authorizations, adds entry to fle 161.26 (MRA)
 ;
 ; Integration Agreements
 ;  2716  $$GETSTAT^DGMSTAPI
 ; 10009  FILE^DICN
 ;  2053  FILE^DIE,UPDATE^DIE,WP^DIE
 ; 10013  ^DIK
 ;  5099  $$PAY^FBUCUTL
 ;  5744  $$VCNTR^FBUTL7
 ;  5272  ^FBAAA
 ; 10060  ^VA
 ; 10061  DEM^VADPT
 ;  5107  ^FBAAC
 ;
 ; Input array values (add/edit RPC's)
 ;    (1)=Patient^DFN
 ;    (2)=AuthIEN^IEN of Authorization [supplied for an Edit, null to add new authorization]
 ;    (3)=FromDate^[Supplied in FM Date format]
 ;    (4)=ToDate^[Supplied in FM Date format]
 ;    (5)=Location^IEN [of file #4 (Primary Service area)] 
 ;    (6)=PurposeofVisit^POV IEN [file #161.82]
 ;    (7)=CostRecovery^(1 or 0)
 ;    (8)=Accident Related^(1 or 0)
 ;    (9)=Clerk^IEN [of file 200]
 ;    (10)=TreatmentType^IEN (set of codes)
 ;    (11)=TypeofCare^IEN (set of codes)
 ;    (12)=DX^1^[value]
 ;    (13)=DX^2^[value]
 ;    (14)=DX^3^[value]
 ;    (15)=PatientType^IEN (set of codes, always 10 so far) 
 ;    (16)=Vendor^IEN (of file #161.2)
 ;    (17)=Contract^IEN (of file #161.43)             ;dsif*3.2*2
 ;    (18)=Consult #^IEN
 ;    (19)=RefProv^IEN (referring provider, file 200)
 ;    (50)=Remarks^1^first 80 chars of text
 ;    (51...999999)=Remarks^n^next 80 chars of text
 Q  ; Routine cannot be called directly
 ;
EDIT(DSIFOUT,DSIFARR) ;  RPC: DSIF EDIT AUTH
 ;Edit an existing Authorization #, check for valid data 1st.
 K DSIFOUT N DFN,AUTH,FBAOLD,DSIFREQ,EXCNT,IENS2,DSIFCE S EXCNT=""
 I $G(DTIME)="" S DTIME=30
 S DSIFREQ=0
 I $P($G(DSIFARR(3)),U,2)="@" S DSIFOUT="-1^No Authorization deletion allowed" Q   ;DSIF*3.2*2
 I $G(DSIFARR(1))="" S DSIFOUT="-1^Not a valid Patient" Q
 S DFN=$P($G(DSIFARR(1)),U,2),AUTH=$P($G(DSIFARR(2)),U,2),IENS2=AUTH_","_DFN_","
 D GETS^DIQ(161.01,IENS2,105,"I","EXCNT") S EXCNT=$G(EXCNT(161.01,IENS2,105,"I")),DSIFCE=1
 D DEM^VADPT I VADM(1)="" S DSIFOUT="-1^Not a valid Patient" D KVAR^VADPT Q
 I $G(DSIFARR(2))="" S DSIFOUT="-1^Not a valid authorization number" Q
 I '$D(^FBAAA(DFN,1,AUTH)) S DSIFOUT="-1^Not a valid authorization number" Q
 ;DSIF*3.2*2 (as per FB*3.5*108)
 I $G(DSIFARR(17))>0,'$$VCNTR^FBUTL7($P(DSIFARR(16),"^",2),$P(DSIFARR(17),"^",2)) S DSIFOUT="-1^Invalid contract for this vendor" Q
 I EXCNT S DSIFCE=$$EDCNTRA^FBUTL7(DFN,AUTH)
 I $G(DSIFCE)=0 S DSIFOUT="-1^Cannot edit Contract" Q
 I $G(DSIFARR(17))'="@",'DSIFCE,$G(DSIFARR(17))>0,+$G(EXCNT)'=$G(DSIFARR(17)) S AXY="-1^"_$P(DSIFCE,U,2) Q
 I $G(DSIFARR(17))="@",'DSIFCE S AXY="-1^"_$P(DSIFCE,U,2) Q
 ;     Verify key variables before proceeding, then set variables and file them accordingly
 D REQFLD Q:DSIFREQ
 S IENS=AUTH_","_DFN_","
 S FBAOLD=$G(^FBAAA(DFN,1,AUTH,0))
 ; Fall through to update, also used in Add an Authorization
UPDATE ; 
 N MSG,IENS,FILE,DSIF,WP,I,FLAG,FBFDC,OLD,HID,NID,FBANEW,FBAALT,FBMST,FBTTYPE,POVIEN,FBPRG S FLAG=0
 I $P(DSIFARR(7),U,2)=0 S $P(DSIFARR(7),U,2)="N" ; Cost recovery
 I $P(DSIFARR(7),U,2)=1 S $P(DSIFARR(7),U,2)="Y" ; Cost recovery
 I $P(DSIFARR(8),U,2)=0 S $P(DSIFARR(8),U,2)="N" ; Accident related
 I $P(DSIFARR(8),U,2)=1 S $P(DSIFARR(8),U,2)="Y" ; Accident related
 I '$D(^VA(200,$P($G(DSIFARR(9)),U,2),0)) S DSIFOUT="-1^Invalid clerk, quitting (nothing filed)" Q
 I AUTH="" S DSIFOUT="-1^No Authorization number, quitting (nothing filed)" Q
 I $P($G(DSIFARR(3)),U,2)="" S DSIFOUT="-1^No Authorization 'From date', quitting" Q
 I $P($G(DSIFARR(19)),U,2)]"",$P($G(DSIFARR(19)),U,2)'="@",'$D(^VA(200,$P(DSIFARR(19),U,2))) S DSIFOUT="-1^Invalid Referring provider entered." Q
 S POVIEN=$P(DSIFARR(6),U,2) I POVIEN=""!('$D(^FBAA(161.82,POVIEN))) S DSIFOUT="-1^Invalid POV code entered" Q
 S FBAALT=$S($P(FBAOLD,"^",13)=2:"Y",$P(FBAOLD,"^",13)=3:"Y",1:""),FBPRG=$P(FBAOLD,"^",3)
 S HID=$S($D(^FBAAA($P(DSIFARR(1),U,2),4)):$P(^(4),"^"),1:"") ;Existing Fee ID Card # ;future enhancement
 S FILE=161.01,IENS=AUTH_","_DFN_","
 S:$G(DSIFARR(3))]"" DSIF(FILE,IENS,.01)=$P(DSIFARR(3),U,2)                   ;from date
 S:$P($G(DSIFARR(4)),U,2)]"" DSIF(FILE,IENS,.02)=$P(DSIFARR(4),U,2)        ;to date
 S:$P($G(DSIFARR(5)),U,2)]"" DSIF(FILE,IENS,101)=$P(DSIFARR(5),U,2)       ;primary service area
 I POVIEN=55 D  I FLAG Q                                              ;Sexual trauma check 
 . I $P($$GETSTAT^DGMSTAPI(DFN),U,2)'="Y" S FLAG=1,DSIFOUT="-1^MST POV can't be selected because veteran's MST status is not YES" Q
 S:$P($G(DSIFARR(6)),U,2)]"" DSIF(FILE,IENS,.07)=POVIEN                        ;purpose of visit IEN  
 S:$P($G(DSIFARR(7)),U,2)]"" DSIF(FILE,IENS,.097)=$P(DSIFARR(7),U,2)      ;cost recovery case
 S:$P($G(DSIFARR(8)),U,2)]"" DSIF(FILE,IENS,.096)=$P(DSIFARR(8),U,2)      ;accident related
 S:$P($G(DSIFARR(9)),U,2)]"" DSIF(FILE,IENS,100)=$P(DSIFARR(9),U,2)       ;clerk
 S:$P($G(DSIFARR(10)),U,2)]"" DSIF(FILE,IENS,.095)=$P(DSIFARR(10),U,2)   ;treatment type
 S:$P($G(DSIFARR(11)),U,2)]"" DSIF(FILE,IENS,2)=$P(DSIFARR(11),U,2)       ;type of care
 S:$P($G(DSIFARR(12)),U,2)]"" DSIF(FILE,IENS,.08)=$P(DSIFARR(12),U,3)     ;dx line 1
 S:$P($G(DSIFARR(13)),U,2)]"" DSIF(FILE,IENS,.085)=$P(DSIFARR(13),U,3)   ;dx line 2
 S:$P($G(DSIFARR(14)),U,2)]"" DSIF(FILE,IENS,.086)=$P(DSIFARR(14),U,3)   ;dx line 3
 S:$P($G(DSIFARR(15)),U,2)]"" DSIF(FILE,IENS,.065)=$P(DSIFARR(15),U,2)   ;patient type
 S:$P($G(DSIFARR(16)),U,2)]"" DSIF(FILE,IENS,.04)=$P(DSIFARR(16),U,2)    ;Vendor IEN
 S:$P($G(DSIFARR(17)),U,2)]"" DSIF(FILE,IENS,105)=$P(DSIFARR(17),U,2)   ;Contract IEN dsif*3.2*2
 S:$P($G(DSIFARR(19)),U,2)]"" DSIF(FILE,IENS,104)=$P(DSIFARR(19),U,2)    ;Referring Provider (IEN file 200) 
 S DSIF(FILE,IENS,.03)=2                                                                      ;Fee program, always 2 for now
 L +^FBAAA(DFN):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S DSIFOUT="-1^Please try again later, file in use" Q
 D FILE^DIE("U","DSIF")   ;Use fileman to edit the entry
 I $D(IENROOT(1)) S DSIFOUT=AUTH_"^Entry number added successfully"
 E  S DSIFOUT=AUTH_"^Entry number updated successfully"
 S FBANEW=$G(^FBAAA(DFN,1,AUTH,0))
 I $P(DSIFARR(10),U,2)=2 S $P(FBAOLD,U,13)=2,$P(FBAOLD,"^",3)=2
 ;Data processing fields, Loop through array entries #18-n build the WP array for FM (wordprocessing)
 I $D(DSIFARR(50)) S FILE=161.01 D
 . S I=49 F  S I=$O(DSIFARR(I)) Q:I=""  S WP(I)=$P($G(DSIFARR(I)),U,3)
 . D WP^DIE(FILE,IENS,".021","K","WP","MSG")  ;Use fileman to add word processing fields
 . I $D(MSG) S DSIFOUT="-1^Error in processing word processing fields, all other data fields were filed" S FLAG=1
 D UNLOCK
 ;FBFDC = Auth from date changed flag 1=yes 2=(NULL)
 S FBFDC=$S($P(FBAOLD,"^")'=$P(FBANEW,"^"):1,1:"")
 S NID=$S($D(^FBAAA($P(DSIFARR(1),U,2),4)):$P(^(4),"^"),1:"")  ; **New ID Card Number, future enhancement
 ; HID=OLD FEE ID CARD #, NID=NEW ID CARD #
 ; Check for MRA record change
 S FBAALT=$S($P(DSIFARR(10),U,2)=2:"Y",$P(DSIFARR(10),U,2)=3:"Y",1:""),FBPRG=2
 I $D(FBAOLD),FBAOLD'=FBANEW,$D(FBAALT),FBAALT="Y" S FBTTYPE="A",FBMST=$S($P(FBANEW,"^",13)=1:"Y",1:"") D 
 . D MORE
 Q
 ;
MORE ;  Add entry to Fee Basis Patient MRA if Treatment type=2
 S DIC="^FBAA(161.26,",DIC(0)="L",DLAYGO=161.26,X=DFN
 S DIC("DR")="1///^S X=""P"";2///^S X=AUTH;3///^S X=FBTTYPE;5///^S X=FBFDC;6///^S X=FBMST"
 K DD,DO D FILE^DICN K DIC,DLAYGO S DA=+Y
 Q
 ;
ADD(DSIFOUT,DSIFARR) ;   RPC:  DSIF ADD AUTH
 ; Add an Authorization, see array values above
 K DSIFOUT N FDA,MSG,IENROOT,TIME,X,Y,DFN,AUTH,DINUM,FBANEW,FBOLD,DSIFREQ
 I $G(DTIME)="" S DTIME=30
 S DFN=$P(DSIFARR(1),U,2),DSIFREQ=0
 I '$D(^FBAAA(DFN,0)) S DSIFOUT="-1^Not a valid Fee Basis Patient" Q
 D REQFLD Q:DSIFREQ
 I $P($G(DSIFARR(6)),U,2)=55 D  I FLAG Q          ;Sexual trauma check
 . I $P($$GETSTAT^DGMSTAPI($P(DSIFARR(1),U,2)),U,2)'="Y" S FLAG=1,DSIFOUT="-1^MST POV can't be selected because veteran's MST status is not YES" Q
 I $G(DSIFARR(17))>0,'$$VCNTR^FBUTL7($P(DSIFARR(16),"^",2),$P(DSIFARR(17),"^",2)) S DSIFOUT="-1^Invalid contract for this vendor" Q  ;DSIF*3.2*2 Check for valid contract IEN
 L +^FBAAA(DFN):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S DSIFOUT="-1^Please try again later, file in use" Q
 S FDA(161.01,"+1,"_DFN_",",.01)=$P(DSIFARR(3),U,2),IENROOT=""
 D UPDATE^DIE("","FDA","IENROOT","MSG")   ;Use fileman to add an entry to the file
 ; Add entry into FB Payment file (#162)
 I '$D(^FBAAC(DFN,0)) K DD,DO S (X,DINUM)=DFN,DIC(0)="L",DLAYGO=162,DIC="^FBAAC(" D FILE^DICN K DIC,DLAYGO
 I $G(IENROOT(1))'="" S AUTH=IENROOT(1),FBAOLD=^FBAAA(DFN,1,AUTH,0) D UPDATE,UNLOCK Q   ;New entry was added correctly, update file
 S DSIFOUT="-1^Entry not created" D UNLOCK
 Q
 ;
DEL(DSIFOUT,DFN,AUTHIEN) ;  RPC:  DSIF DEL AUTH
 ; Input= DFN: Patient IEN and AUTHIEN: Authorization IEN to be deleted.
 K DSIFOUT N DA,DIK
 I $G(DTIME)="" S DTIME=30
 I $G(DFN)="" S DSIFOUT="-1^No Patient selected" Q
 I $G(AUTHIEN)="" S DSIFOUT="-1^No Authorization entered" Q
 I '$D(^FBAAA(DFN,1,AUTHIEN,0)) S DSIFOUT="-1^Not a valid patient/authorization combinaton (no authorization exists for this Pt)" Q
 S DA(1)=DFN,DA=AUTHIEN
 D CHECK Q:$P($G(DSIFOUT),U)="-1"
 L +^FBAAA(DFN):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S DSIFOUT="-1^Please try again later, file in use" Q
 S DIK="^FBAAA("_DA(1)_",1," D ^DIK  ;Use fileman to delete entry
 D UNLOCK
 S DSIFOUT="1^Authorization #"_AUTHIEN_" deleted successfully"
 I $D(^FBAAA(DFN,1,AUTHIEN)) S DSIFOUT="-1^Authorization #"_AUTHIEN_" deletion failed"
 Q
 ;
UNLOCK ;
  L -^FBAAA(DFN)
  Q
CHECK ; before deleting an Authorization verify payments and 7078/583 entries, if they exist do not delete the Authorization
 ; Logic cloned from DELA^FBUCDD1
 N FBV,FBP,FBI,FBVAR,M
 S M=0,FBV=$P($G(^FBAAA(DFN,1,AUTHIEN,0)),U,4),FBVAR=$P($G(^FBAAA(DFN,1,AUTHIEN,0)),U,9)
 ; If no vendor in the Authorization file, look in payments file
 I '$G(FBV) S FBV=$O(^FBAAC("AF",AUTHIEN,DFN,""))
 I $G(FBV) S FBI=0 F  S FBI=$O(^FBAAC(DFN,1,FBV,1,FBI)) Q:'FBI  S FBI(0)=$G(^FBAAC(DFN,1,FBV,1,FBI,0)) I $P(FBI(0),U,4)=AUTHIEN,$O(^FBAAC(DFN,1,FBV,1,FBI,1,1,0)) S M=1
 I FBVAR]"",$$PAY^FBUCUTL($P(FBVAR,";"),$P(FBVAR,";",2)) S M=1
 I M,FBVAR]"" S M=2
 I M>0 D  Q
 .I M=1 S DSIFOUT="-1^Cannot delete Authorization because payments already exist!" Q
 .I M=2 S DSIFOUT="-1^Cannot delete Authorization because a 7078/583 entry has already been established!" Q
 Q
 ;
REQFLD ; Check for required fields
 I $P($G(DSIFARR(3)),U,2)="" S DSIFOUT="-1^Missing 'Auth 'From date'",DSIFREQ=1 Q
 I $P($G(DSIFARR(4)),U,2)="" S DSIFOUT="-1^Missing 'Auth 'To date'",DSIFREQ=1 Q
 I $P($G(DSIFARR(5)),U,2)="" S DSIFOUT="-1^Missing 'Primary Service Area'",DSIFREQ=1 Q
 I $P($G(DSIFARR(6)),U,2)="" S DSIFOUT="-1^Missing 'Purpose of visit'",DSIFREQ=1 Q
 I $P($G(DSIFARR(7)),U,2)="" S DSIFOUT="-1^Missing 'Potential Cost Recovery'",DSIFREQ=1 Q
 I $P($G(DSIFARR(8)),U,2)="" S DSIFOUT="-1^Missing 'Accident Related'",DSIFREQ=1 Q   ;DSIF*3.2*2 
 I $P($G(DSIFARR(9)),U,2)="" S DSIFOUT="-1^Missing 'Clerk IEN'",DSIFREQ=1 Q   ;DSIF*3.2*2 
 I $P($G(DSIFARR(10)),U,2)="" S DSIFOUT="-1^Missing 'Treatment type'",DSIFREQ=1 Q
 Q
VERIFY(DSIFOUT,DFN,AUTHIEN) ; RPC: DSIF AUTH VERIFY AUTH
 ; Input= DFN: Patient IEN and AUTHIEN: Authorization IEN.
 ; Look to see if a patient has a valid authorization and if it has payments against it.
 K DSIFOUT N FBV,FBVAR,FBI,M
 I $G(DTIME)="" S DTIME=30
 I $G(DFN)="" S DSIFOUT="-1^No Patient selected" Q
 I '$D(^FBAAA(DFN)) S DSIFOUT="-1^Invalid FB Patient selected" Q
 I $G(AUTHIEN)="" S DSIFOUT="-1^No Authorization entered" Q
 I '$D(^FBAAA(DFN,1,AUTHIEN,0)) S DSIFOUT="-1^No authorization exists" Q
 I '$D(^FBAAA(DFN,1,AUTHIEN,0)) S DSIFOUT="-1^Not a valid patient/authorization combination (no authorization exists for this Pt)" Q
 S M=0,FBV=$P($G(^FBAAA(DFN,1,AUTHIEN,0)),U,4),FBVAR=$P($G(^FBAAA(DFN,1,AUTHIEN,0)),U,9)
 ; If no vendor in the Authorization file, look in payments file
 I '$G(FBV) S FBV=$O(^FBAAC("AF",AUTHIEN,DFN,""))
 I $G(FBV) S FBI=0 F  S FBI=$O(^FBAAC(DFN,1,FBV,1,FBI)) Q:'FBI  S FBI(0)=$G(^FBAAC(DFN,1,FBV,1,FBI,0)) I $P(FBI(0),U,4)=AUTHIEN,$O(^FBAAC(DFN,1,FBV,1,FBI,1,1,0)) S M=1
 I FBVAR]"",$$PAY^FBUCUTL($P(FBVAR,";"),$P(FBVAR,";",2)) S M=1
 I M=0,FBVAR]"" S M=2
 I M>0 D  Q
 .I M=1 S DSIFOUT="1^Auth has payments" Q
 .I M=2 S DSIFOUT="0^"_$P(FBVAR,"(")_"^exists, but no payments made yet!" Q
 I M=0 S DSIFOUT="0^None yet"
 Q
