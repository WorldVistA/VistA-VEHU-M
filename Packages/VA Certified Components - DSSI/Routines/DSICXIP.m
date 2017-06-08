DSICXIP ;DSS/DBB - ZIP CODE UTILITY ;04/29/2003 14:10
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 Q
 ;  DBIA#  SUPPORTED  External References
 ;  -----  ---------  -------------------------------------------
 ;   3618      x      POSTAL^XIPUTIL
 ;  10056      x      Entire STATE file supported for READ access
 ;
ZIPCODE(AXY,PCODE,ACTDATE,FUN) ;  RPC: DSIC XIP
 ;    PCODE - required - 5 or 9 digit zip code
 ;  ACTDATE - optional - Fileman date for which the zip code must have
 ;            been active - default is to return all and ignore date
 ;            screen
 ;    FUN - optional - I $G(FUN) then called as extrinsic vs RPC
 ;  RETURN: on error return -1^error message
 ;          else return p1^p2^p3^p4^p5^p6^p7^p8  where
 ;          p1 = inputted zip code     p5 = FIPS county code
 ;          p2 = city                  p6 = state abbreviation
 ;          p3 = state (full name)     p7 = ptr to STATE file (#5)
 ;          p4 = county (full name)    p8 = ptr to COUNTY CODE file (#5.13)
 ;
 ; return value is for the primary location associated with the ZIP code
 N X,Y,Z,DIERR,DSICERR,DSICXIP,ST
 I $G(PCODE)="" S AXY="-1^No zipcode received" G OUT
 D POSTAL^XIPUTIL(PCODE,.DSICXIP)
 I $D(DSICXIP("ERROR")) S AXY="-1^"_DSICXIP("ERROR") G OUT
 S X=DSICXIP("INACTIVE DATE") S:X Y=$$FMTE^XLFDT(X)
 I X,$G(ACTDATE),ACTDATE'<X S AXY="-1^"_PCODE_" inactive as of "_Y G OUT
 S X=DSICXIP("STATE POINTER"),ST=""
 I X S ST=$$GET1^DIQ(5,X_",",1,,,"DSICERR") S:$D(DSICERR) ST=""
 S AXY=PCODE
 F Z="CITY","STATE","COUNTY","FIPS CODE" S AXY=AXY_U_DSICXIP(Z)
 S $P(AXY,U,6)=ST_U_DSICXIP("STATE POINTER")_U_DSICXIP("COUNTY POINTER")
 ;
OUT ;  common exit - expects return value = AXY - I $G(FUN) then extrinsic
 Q:$G(FUN) AXY Q
