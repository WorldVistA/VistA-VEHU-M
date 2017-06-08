DENTVFB ;DSS/KC - RPC CALLS FOR DSS DENTAL ;10/16/2003 15:08
 ;;1.2;DENTAL;**37,38**;Aug 10, 2001
 ;Copyright 1995-2004, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  --------------------------------
 ;  2053      x      ^DIE:  FILE,UPDATE
 ;
ADD(RET,DATA) ;  RPC: DENTV FEE BASIS ADD
 ;  DATA array contains the input parameters
 ;  DATA("DFN") = DFN (pointer to file 2)
 ;  DATA("DIVISION") = division name (.01 field) from file 225
 ;  DATA("CATEGORY") = patient category (pointer to file 220.2)
 ;  DATA("DATE") = date authorized for payment, external format
 ;  DATA("COST") = amount authorized for payment, dollar format
 ;  DATA("IEN") = pointer to 228.5, for Update records only
 ;  RETURN: 1^message if valid
 ;      or -1^message if an error occurs
 ;
 N X,Z,DENT,DENTER,DIERR,EDT,IENS
 S X=$$DFN^DENTVRF0($G(DATA("DFN")),1) I X<0 D ERR(1) Q
 S Z(.04)=$G(DATA("DFN"))
 I $G(DATA("DIVISION"))="" D ERR(2) Q
 S Z(.05)=$O(^DENT(225,"B",DATA("DIVISION"),0))
 I Z(.05)="" D ERR(3) Q
 S Z(.06)=$G(DATA("CATEGORY"))
 D CNVT^DSICDT(.EDT,$G(DATA("DATE")),"E","F") I $P(EDT,U)="ERR"!(EDT="") D ERR(5) Q
 S Z(.07)=EDT
 S Z(.08)=$G(DATA("COST"))
 S IENS=$S($G(DATA("IEN"))>0:$G(DATA("IEN")),1:0)
 I 'IENS S Z(.12)="P"
 ;lock the file and add/update the record       
 L +^DENT(228.5,+IENS):2 E  D ERR(4) Q
 I 'IENS M DENT(228.5,"+1,")=Z S X=1+$P($G(^DENT(228.5,0)),U,3),DENT(228.5,"+1,",.01)=X D UPDATE^DIE(,"DENT",,"DENTER")
 I IENS S IENS=IENS_"," M DENT(228.5,IENS)=Z D FILE^DIE(,"DENT","DENTERR")
 L -^DENT(228.5,+IENS)
 I '$D(DIERR) S RET="1^Record successfully "_$S(IENS=0:"added",1:"updated")
 E  S RET="-1^"_$$MSG^DSICFM01("VE",,,,"DENTER")
 Q
 ;
ERR(X,Y,Z) ;  error messages from this routine - expects X=1,2,3
 ;;Patient not found in Patient file (2)
 ;;Missing station.division name
 ;;Invalid station.division name
 ;;Unable to lock file 228.5 - try again later
 ;;Invalid date authorized
 S X=$P($T(ERR+X),";",3) S:$G(Y)'="" X=X_Y
 I $G(Z) S RET(1)="-1^"_X
 E  S RET="-1^"_X
 Q
 ;
LIST(RET,DATA) ;  RPC: DENTV FEE BASIS LIST
 ;input param DATA is the DFN (required)
 ;FORMAT of valid return array
 ;----------------------
 ;RET(IEN)=0 node of 228.5 global
 ;
 N X,Y,Z,I,DFN
 S X=$$DFN^DENTVRF0($G(DATA)) I X<0 S RET(0)="Patient not found in Patient file (2)" Q
 S Y="",Z="",I=0,DFN=$G(DATA)
 F  S Y=$O(^DENT(228.5,"AC",DFN,Y),-1) Q:Y=""  D
 .F  S Z=$O(^DENT(228.5,"AC",DFN,Y,Z),-1) Q:Z=""  D
 ..S X=$G(^DENT(228.5,Z,0))
 ..;Check for deleted date, format create/auth dates into delphi date
 ..I '$P(X,U,9) S I=I+1,RET(I)=Z_";"_X
 I $D(RET)<10 S RET(0)="No records for this patient"
 Q
