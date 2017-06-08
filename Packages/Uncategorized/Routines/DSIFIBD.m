DSIFIBD ;DSS/AMC - RPC VERSION OF DGIBDSP ;06/16/2004
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;  4419  $$INSUR^IBBAPI
 ; 10103  $$FMTE^XLFDT
 ;
 Q
 ;
DISP ;-Display all insurance company information
 ;  -input DFN
 ;  -input DGSTAT [optional] Defaults to "RAB" if not defined.
 N DGDTIN,XX S XX=""
 ;
 N X,DGINS,DGX,DGRTN,DGERR,DGY
 ;
 I '$D(DGSTAT) S DGSTAT="RAB"
 S DGX=$$INSUR^IBBAPI(DFN,"",DGSTAT,.DGRTN,"*")
 S:DGX<0 DGERR=$O(DGRTN("IBBAPI","INSUR","ERROR",0))
 ;
 D HDR
 I $G(DGERR) S YY=YY+1,$E(XX,6)=DGRTN("IBBAPI","INSUR","ERROR",DGERR) D LN G DISPQ
 I 'DGX S YY=YY+1,XX="    No Insurance Information" D LN G DISPQ
 ;
 M DGINS=DGRTN("IBBAPI","INSUR")
 S DGY=0
 F  S DGY=$O(DGINS(DGY)) Q:'DGY  D D1(DGY)
 ;
DISPQ ;
 I $D(DGRTN("BUFFER")) D
 .I DGRTN("BUFFER")>0 S YY=YY+1,$E(XX,17)="*** Patient has Insurance Buffer entries ***" D LN
 K DGSTAT
 Q
 ;
HDR ; -- print standard header
 D HDR1("=",IOM-$S($G(DGDTIN):1,1:4))
 Q
 ;
HDR1(CHAR,LENG) ; -- print header, specify character
 N OFF
 S OFF=$S($G(DGDTIN):0,1:2)
 S $E(XX,1+OFF)="Insurance",$E(XX,13+OFF)="COB",$E(XX,17+OFF)="Subscriber ID",$E(XX,35+OFF)="Group",$E(XX,47+OFF)="Holder",$E(XX,55+OFF)="Effect"_$S('OFF:"",1:"i")_"ve",$E(XX,65+OFF+$S('OFF:0,1:1))="Expires" S:'OFF $E(XX,75)="Only" D LN
 I $G(CHAR)'="",LENG S X="",$P(X,CHAR,LENG)="" S $E(XX,1+OFF)=X D LN
 Q
 ;
D1(DGVAL) ; 
 N DGX,DGY,DGZ,CAT,OFF
 ;
 Q:'$D(DGINS)
 S OFF=$S($G(DGDTIN):0,1:2)
 S $E(XX,1+OFF)=$S($D(DGINS(DGVAL,1)):$E($P(DGINS(DGVAL,1),U,2),1,10),1:"UNKNOWN")
 S X=+DGINS(DGVAL,7) I X'="" S X=$S(X=1:"p",X=2:"s",X=3:"t",1:"")
 S $E(XX,14+OFF)=X
 S $E(XX,17+OFF)=$E(DGINS(DGVAL,14),1,16)
 S $E(XX,35+OFF)=$E(DGINS(DGVAL,18),1,10)
 S DGX=$P(DGINS(DGVAL,12),U,1)
 S $E(XX,47+OFF)=$S(DGX="P":"SELF",DGX="S":"SPOUSE",1:"OTHER")
 S $E(XX,55+OFF)=$TR($$FMTE^XLFDT(DGINS(DGVAL,10),"2DF")," ","0"),$E(XX,65+OFF+$S(OFF:1,1:0))=$TR($$FMTE^XLFDT(DGINS(DGVAL,11),"2DF")," ","0")
 I 'OFF D
 .I $P(DGINS(DGVAL,9),U,2)="NO" S $E(XX,75)="*WNR*" Q
 D LN
 Q
LN ;
 S YY=YY+1,@AXY@(YY)=XX,XX=""
 Q
