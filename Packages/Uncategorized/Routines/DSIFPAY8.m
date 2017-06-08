DSIFPAY8 ;DSS/DLF - RPC FOR FEE BASIS PAYMENTS ;7/19/2010 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**8**;Jun 05, 2009;Build 29
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;   2056  GETS^DIQ
 ;   3990  $$ICDDX^ICDCODE
 ;   5107  ^FBAAC
 ;
 Q  ;No direct access 
OPCKN(DSIFOUT,DSIFPAR) ;  RPC: DSIF OP CHECK NUMBER LOOKUP DSIF*3.2*8 
 ; INPUT: DSIFPAR (";" deliminted) DSIFINV - Invoice number ; DSIFDT Invoice date ; CPT - external CPT code
 ; OUTPUT:  DSIFOUT= "1"^Check number^Date Paid 
 ;                           or "-1"^Error Message  
 ; 
 N LIST,NUM,MSG,DSIFDFN,DSIFVIEN,NDX,NDX2,DSIFCHK,FIL,IENS,DSIFRTN
 K DSIFOUT
 S DSIFINV=$P(DSIFPAR,";"),DSIFDT=$P(DSIFPAR,";",2),DSIFCPT=$P(DSIFPAR,";",3)
 I DSIFDT="" D INPT Q
 S DSIFDFN="",DSIFDFN=$O(^FBAAC("C",DSIFINV,DSIFDFN))
 I $G(DSIFINV)=""!('$D(^FBAAC("C",DSIFINV))) S DSIFOUT="-1^Invalid or missing Invoice Number" Q
 I $G(DSIFDT)="" S DSIFOUT="-1^Missing vendor Invoice Date" Q
 I $G(DSIFCPT)=""!(+$$CPT^ICPTCOD(DSIFCPT)<1) S DSIFOUT="-1^Invalid or missing CPT code" Q
 S DSIFCPT=$S(DSIFCPT'="":+$$CPT^ICPTCOD(DSIFCPT),1:"")
 S DSIFVIEN="",DSIFVIEN=$O(^FBAAC("C",DSIFINV,DSIFDFN,DSIFVIEN))
 S NDX="",DSIFOUT="-1^Check Number not found"
 F  S NDX=$O(^FBAAC("C",DSIFINV,DSIFDFN,DSIFVIEN,NDX)) Q:NDX=""!(+DSIFOUT>0)  D
 .S NDX2="" F  S NDX2=$O(^FBAAC("C",DSIFINV,DSIFDFN,DSIFVIEN,NDX,NDX2)) Q:NDX2=""!(+DSIFOUT>0)  D
 ..I $P(^FBAAC(DSIFDFN,1,DSIFVIEN,1,NDX,1,NDX2,0),"^")=DSIFCPT  D
 ...S FIL=162.03,IENS=NDX2_","_NDX_","_DSIFVIEN_","_DSIFDFN_"," D GETS^DIQ(FIL,IENS,"35;12","I","DSIFRTN")
 ...S DSIFOUT="1^"_$G(DSIFRTN(FIL,IENS,35,"I"))_U_$G(DSIFRTN(FIL,IENS,12,"I"))
 Q
INPT ; if only Invoice number is passed, assume we are looking for an Inpatient check number
 ;
 I '$D(^FBAAI(DSIFINV,0)) S DSIFOUT="-1^Not a valid Invoice number" Q
 S FIL=162.5,IENS=DSIFINV_"," D GETS^DIQ(FIL,IENS,"48;45","I","DSIFRTN")
 S DSIFOUT="1^"_$G(DSIFRTN(FIL,IENS,48,"I"))_U_$G(DSIFRTN(FIL,IENS,45,"I"))
 Q
