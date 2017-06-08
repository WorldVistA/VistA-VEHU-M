DSICFM01 ;DSS/SGM - COMMON FILEMAN UTILITIES ;01/14/2005 13:26
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;  this contains common Fileman utilities that is often repeated
 ;
 ; DBIA#   SUPPORTED
 ; -----   -----------------------------
 ;  2050   MSG^DIALOG
 ; 10006   ^DIC
 ; 10026   ^DIR
 ;
MSG(FLGS,OUT,WIDTH,LEFT,INPUT) ;
 ;  this api will format the text using the MSG^DIALOG api
 ;
 ;  FLGS - optional - default = "AE"
 ;    FLGS [ A - return results in OUT - passed by ref
 ;           W - write to current device
 ;           S - save ^TMP or INPUT (don't kill)
 ;           E - process error array
 ;           H - process help array
 ;           M - process message array
 ;           B - blank lines suppressed between error msgs
 ;           T - Return Total number of lines in the top level of OUT
 ;           V - don't return OUT, return extrinsic function value
 ;
 ;    OUT - optional/required - local array passed by reference
 ;          to return messages.  See FLGS parameter
 ;  WIDTH - optional - default= 72  max length of each line to return
 ;   LEFT - optional - default=0   pad LEFT spaces to return array
 ;  INPUT - optional - default assumes ^TMP("DIxxx",$J)
 ;          Closed root name of local input array where text resides
 ;
 ;  If FLGS["V", then return value is extrinsic function and parameters
 ;  OUT, WIDTH, LEFT are meaningless.
 ;  If no input array, return error message
 ;
M N I,X,Y,Z,DSIOUT,VFLG
 S FLGS=$G(FLGS,"AE") S:FLGS="V" FLGS="AEV" S:FLGS="" FLGS="AE"
 S VFLG=FLGS["V"
 I VFLG S FLGS=$TR(FLGS,"V") S:FLGS'["B" FLGS=FLGS_"B"
 S:FLGS'["A" FLGS=FLGS_"A"
 S WIDTH=$G(WIDTH) S:'WIDTH WIDTH=72
 S LEFT=+$G(LEFT) S:VFLG LEFT=0
 S Z=$S($G(INPUT)="":0,1:$D(@INPUT)>9)
 I 'Z D
 .I FLGS["E",$D(^TMP("DIERR",$J)) S Z=Z+1
 .I FLGS["H",$D(^TMP("DIHELP",$J)) S Z=Z+1
 .I FLGS["M",$D(^TMP("DIMSG",$J)) S Z=Z+1
 .Q
 I 'Z S OUT(1)="No input array received" G OUT
 D MSG^DIALOG(FLGS,.DSIOUT,WIDTH,LEFT,$G(INPUT))
 K OUT I 'VFLG M OUT=DSIOUT Q
 S OUT="" F I=0:0 S I=$O(DSIOUT(I)) Q:'I  D  I VFLG,$L(OUT)>507 Q
 .S X=$L(OUT),Y=$L(DSIOUT(I))
 .I (X+Y)<508 S OUT=OUT_DSIOUT(I)_" "
 .E  S OUT=OUT_$E(DSIOUT(I),1,508-X)
 .Q
OUT I VFLG Q $S($G(OUT)'="":OUT,$G(OUT(1))'="":OUT(1),1:-1)
 Q
 ;
DIC(A) ;  utility to invoke ^DIC
 ;  pass by reference DIC() array
 ;  Return Y from ^DIC or -1 on ^out or -2 on timeout
 N X,Y,DIC,DTOUT,DUOUT
 M DIC=A K A
 I '$D(DIC) Q -1
 W ! D ^DIC
 S X=$S($D(DUOUT):-1,$D(DTOUT):-2,1:Y)
 K A M A=Y
 Q X
 ;
DIR(DIR) ;  utility to invoke ^DIR
 ;  pass by reference DIR() array
 ;  Return the value of Y from ^DIR
 ;  On up-arrow out or time-out, return -1 for ^-out, -2 for time out
 N X,Y,DIROUT,DIRUT,DTOUT,DUOUT
 I '$D(DIR) Q -1
 W ! D ^DIR
 Q $S($D(DUOUT):-1,$D(DTOUT):-2,1:Y)
