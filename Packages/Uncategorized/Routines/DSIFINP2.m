DSIFINP2 ;DSS/RED - RPC FOR FEE BASIS, INPATIENT ;8/27/2007 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; Routine for API's used in Fee Basis to Enter/edit FB Inpt Authorizations, adds entry to file 161.26 (MRA)
 ; 
 ; Integration Agreements
 ;  2716  $$GETSTAT^DGMSTAPI
 ; 10009  FILE^DICN
 ;  2053  FILE^DIE,UPDATE^DIE,WP^DIE
 ;
 ; Input array values (add/edit RPC's)
 ;    (1)=Patient^DFN - REQ
 ;    (2)=AuthIEN^IEN of Authorization [supplied for an Edit, null to add new authorization] - REQ
 ;    (3)=FromDate^[Supplied in FM Date format] - REQ
 ;    (4)=ToDate^[Supplied in FM Date format]
 ;    (5)=Location^IEN [of file #4 (Primary Service area)] 
 ;    (6)=PurposeofVisit^POV IEN [file #161.82] - REQ
 ;    (7)=CostRecovery^(1 or 0)
 ;    (8)=Accident Related^(1 or 0)
 ;    (9)=Clerk^IEN [of file 200] - REQ
 ;    (10)=TreatmentType^IEN (set of codes)
 ;    (11)=TypeofCare^IEN (set of codes)
 ;    (12)=DX^1^[value]
 ;    (13)=DX^2^[value]
 ;    (14)=DX^3^[value]
 ;    (15)=PatientType^IEN (set of codes) 
 ;    (16)=Vendor^IEN (of file #161.2)
 ;    (17)=*DELETED - NOT USED
 ;    (18)=Consult #^IEN
 ;    (19)=Fee^(Fee program IEN file #161.8) - REQ
 ;    (20)=7078^Associated 7078 IEN - REQ
 ;    (21)=Discharge type^type (Optional, but if entered it MUST be 1-4 only)
 ;    (50)=Remarks^1^first 80 chars of text
 ;    (51...999999)=Remarks^n^next 80 chars of text
 Q  ; Routine cannot be called directly, must use calling points
 ;
EDIT(FBOUT,DSIFARR) ;  RPC: DSIF INP EDIT AUTH
 ;Edit an existing Authorization #, check for valid data 1st.
 K FBOUT N DFN,AUTH,FBAOLD I $G(U)="" S U="^"
 I $G(DTIME)="" S DTIME=30
 I $G(DSIFARR(1))="" S FBOUT="-1^Not a valid Patient" Q
 S DFN=$P($G(DSIFARR(1)),U,2),AUTH=$P($G(DSIFARR(2)),U,2)
 D DEM^VADPT I VADM(1)="" S FBOUT="-1^Not a valid Patient" D KVAR^VADPT Q
 I $G(DSIFARR(2))="" S FBOUT="-1^Not a valid authorization number" Q
 I '$D(^FBAAA(DFN,1,AUTH)) S FBOUT="-1^Not a valid authorization number" Q
 S IENS=AUTH_","_DFN_","
 S FBAOLD=$G(^FBAAA(DFN,1,AUTH,0))
 I $P(DSIFARR(3),U,2)="" S FBOUT="-1^Missing from date, quitting (nothing filed)" Q
 ; Fall through to update, also used in Add an Authorization
UPDATE ; 
 N MSG,IENS,FILE,DSIF,WP,I,FLAG,FBFDC,OLD,HID,NID,FBANEW,FBAALT,FBMST,FBTTYPE,POVIEN S FLAG=0
 ;     Verify key variables before proceeding, then set variables and file them accordingly
 I '$D(^VA(200,$P($G(DSIFARR(9)),U,2),0)) S FBOUT="-1^Invalid clerk, quitting (nothing filed)" Q
 I AUTH="" S FBOUT="-1^No Authorization number, quitting (nothing filed)" Q
 I $P($G(DSIFARR(6)),U,2)="" S FBOUT="-1^No Purpose of visit entered, quitting" Q
 I $P($G(DSIFARR(3)),U,2)="" S FBOUT="-1^No Authorization 'From date', quitting" Q
 I $P($G(DSIFARR(19)),U,2)="" S FBOUT="-1^No Fee Program entered, quitting" Q
 I '$D(^FBAA(161.8,$P($G(DSIFARR(19)),U,2),0)) S FBOUT="-1^Invalid Fee Program entered, quitting" Q
 ; DSIF 3.2 moved the line of code to verify Discharge type from EDIT to the line below.
 I $G(DSIFARR(21))'="",$P(DSIFARR(21),U,2)=""!(1234'[$P(DSIFARR(21),U,2)) S FBOUT="-1^Discharge type entered is not valid!" Q
 S $P(DSIFARR(3),U,2)=$P($P(DSIFARR(3),U,2),".")  ;Remove time if passed by GUI
 S POVIEN=$P(DSIFARR(6),U,2) I POVIEN=""!('$D(^FBAA(161.82,POVIEN))) S FBOUT="-1^Invalid POV code entered" Q
 S FBAALT=$S($P(FBAOLD,"^",13)=2:"Y",$P(FBAOLD,"^",13)=3:"Y",1:""),FBPRG=$P(FBAOLD,"^",3)
 S HID=$S($D(^FBAAA($P(DSIFARR(1),U,2),4)):$P(^(4),"^"),1:"") ;Existing Fee ID Card # ;future enhancement
 I $P(DSIFARR(7),U,2)=0 S $P(DSIFARR(7),U,2)=""
 I $P(DSIFARR(7),U,2)=1 S $P(DSIFARR(7),U,2)="Y" ; Cost recovery
 I $P(DSIFARR(8),U,2)=0 S $P(DSIFARR(8),U,2)=""
 I $P(DSIFARR(8),U,2)=1 S $P(DSIFARR(8),U,2)="Y"  ; Accident related
 S FILE=161.01,IENS=AUTH_","_DFN_","
 S:$G(DSIFARR(3))]"" DSIF(FILE,IENS,.01)=+$P(DSIFARR(3),U,2)                   ;from date
 S:$P($G(DSIFARR(4)),U,2)]"" DSIF(FILE,IENS,.02)=$P(DSIFARR(4),U,2)        ;to date
 S:$P($G(DSIFARR(5)),U,2)]"" DSIF(FILE,IENS,101)=$P(DSIFARR(5),U,2)       ;primary service area
 I $P($G(DSIFARR(6)),U,2)=55 D  I FLAG Q                                              ;Sexual trauma check 
 . I $P($$GETSTAT^DGMSTAPI(DFN),U,2)'="Y" S FLAG=1,FBOUT="-1^MST POV can't be selected because veteran's MST status is not YES" Q
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
 S:$P($G(DSIFARR(19)),U,2)]"" DSIF(FILE,IENS,.03)=$P(DSIFARR(19),U,2)    ;FEE program
 I $P($G(DSIFARR(20)),U,2)]"" S FLAG=0 D  Q:FLAG
 . I '$D(^FB7078($P(DSIFARR(20),U,2),0)) S FBOUT="-1^Invalid or missing 7078" Q
 . S DSIF(FILE,IENS,.055)=$P(DSIFARR(20),U,2)    ;7078 pointer
 S:$P($G(DSIFARR(21)),U,2)]"" DSIF(FILE,IENS,.06)=$P(DSIFARR(21),U,2)    ;Discharge Type
 L +^FBAAA(DFN):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S FBOUT="-1^Please try again later, file in use" Q
 D FILE^DIE("U","DSIF")   ;Use fileman to edit the entry
 I $D(IENROOT(1)) S FBOUT=AUTH_"^Entry number added successfully"
 E  S FBOUT=AUTH_"^Entry number updated successfully"
 S FBANEW=$G(^FBAAA(DFN,1,AUTH,0))
 I $P(DSIFARR(10),U,2)=2 S $P(FBAOLD,U,13)=2,$P(FBAOLD,"^",3)=2
 ;Data processing fields, Loop through array entries #18-n build the WP array for FM (wordprocessing)
 I $D(DSIFARR(50)) S FILE=161.01 D
 . S I=49 F  S I=$O(DSIFARR(I)) Q:I=""  S WP(I)=$P($G(DSIFARR(I)),U,3)
 . D WP^DIE(FILE,IENS,".021","K","WP","MSG")  ;Use fileman to add word processing fields
 . I $D(MSG) S FBOUT="-1^Error in processing word processing fields, all other data fields were filed" S FLAG=1
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
ADD(FBOUT,DSIFARR) ;   RPC:  DSIF INP ADD AUTH
 ; Add an Authorization, see array values above
 K FBOUT N FDA,MSG,IENROOT,TIME,X,Y,DFN,AUTH,DINUM,FBANEW,FBOLD
 I $G(U)']"" S U="^"
 I $G(DTIME)="" S DTIME=30
 S DFN=$P(DSIFARR(1),U,2)
 I $P($G(DSIFARR(3)),U,2)="" S FBOUT="-1^No Authorization 'From date', quitting" Q
 S $P(DSIFARR(3),U,2)=$P($P(DSIFARR(3),U,2),".")  ;Remove time if passed by GUI
 I '$D(^FBAAA(DFN,0)) S FBOUT="-1^Not a valid Fee Basis Patient" Q
 L +^FBAAA(DFN):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S FBOUT="-1^Please try again later, file in use" Q
 S FDA(161.01,"+1,"_DFN_",",.01)=$P(DSIFARR(3),U,2),IENROOT=""
 D UPDATE^DIE("","FDA","IENROOT","MSG")   ;Use fileman to add an entry to the file
 ; Add entry into FB Payment file (#162)
 I '$D(^FBAAC(DFN,0)) K DD,DO S (X,DINUM)=DFN,DIC(0)="L",DLAYGO=162,DIC="^FBAAC(" D FILE^DICN K DIC,DLAYGO
 I $G(IENROOT(1))'="" S AUTH=IENROOT(1),FBAOLD=^FBAAA(DFN,1,AUTH,0) D UPDATE,UNLOCK Q   ;New entry was added correctly, update file
 S FBOUT="-1^Entry not created" D UNLOCK
 Q
UNLOCK ;
 L -^FBAAA(DFN)
 Q
