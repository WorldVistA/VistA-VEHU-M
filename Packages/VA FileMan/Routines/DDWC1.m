DDWC1 ;SFISC/MKO-CHANGE ;04:37 PM  24 Aug 2002
 ;;22.2;VA FileMan;;Jan 05, 2016;Build 42
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
SETUP ;Setup new scrolling region
 N DDWI
 F DDWI=$$MIN(DDWMR,DDWCNT-DDWA):-1:DDWMR-4 D
 . S DDWSTB=DDWSTB+1,^TMP("DDW1",$J,DDWSTB)=DDWL(DDWI)
 S IOBM=IOBM-5,DDWMR=DDWMR-5
 W:$P(DDGLED,DDGLDEL,2)]"" @$P(DDGLED,DDGLDEL,2)
 ;
 ;Print dialog box
 N DDWR0,DDWR1
 S DDWR1=$P(DDGLVID,DDGLDEL,6),DDWR0=$P(DDGLVID,DDGLDEL,10)
 ;
 D CUP(DDWMR+1,1)
 W $P(DDGLGRA,DDGLDEL)_$TR($J("",IOM)," ",$P(DDGLGRA,DDGLDEL,3))_$P(DDGLGRA,DDGLDEL,2),!
FIND D CUP(DDWMR+2,1) W $P(DDGLCLR,DDGLDEL)_"   "_$$EZBLD^DIALOG(8126) ;**'FIND WHAT:'
 D CUP(DDWMR+3,1) W $P(DDGLCLR,DDGLDEL)_$$EZBLD^DIALOG(8126.1)_$G(DDWCHG) ;**'REPLACE WITH:'
 D CUP(DDWMR+4,1) W $P(DDGLCLR,DDGLDEL)_"      Option:"_$P(DDGLCLR,DDGLDEL)_$J("",20)_DDWR1_"F"_DDWR0_"ind Next   "_DDWR1_"R"_DDWR0_"eplace   Replace "_DDWR1_"A"_DDWR0_"ll   "_DDWR1_"Q"_DDWR0_"uit"
 D CUP(DDWMR+5,1) W $P(DDGLCLR,DDGLDEL)
 Q
 ;
RESTORE ;Restore original scrolling region
 N DDWI
 S IOBM=IOBM+5,DDWMR=DDWMR+5
 W:$P(DDGLED,DDGLDEL,2)]"" @$P(DDGLED,DDGLDEL,2)
 F DDWI=DDWMR-4:1:DDWMR D
 . I DDWI+DDWA'>DDWCNT D
 .. S DDWL(DDWI)=^TMP("DDW1",$J,DDWSTB),DDWSTB=DDWSTB-1
 . E  S DDWL(DDWI)=""
 . D CUP(DDWI,1)
 . W $P(DDGLCLR,DDGLDEL)_$E(DDWL(DDWI),1+DDWOFS,IOM+DDWOFS)
 .
 D POS(DDWRW,DDWC,"RN")
 Q
 ;
MIN(X,Y) ;
 Q $S(X<Y:X,1:Y)
 ;
CUP(Y,X) ;Pos cursor
 S DY=IOTM+Y-2,DX=X-1 X IOXY
 Q
 ;
POS(R,C,F) ;Pos cursor based on char pos C
 N DDWX
 S:$G(C)="E" C=$L($G(DDWL(R)))+1
 S:$G(F)["N" DDWN=$G(DDWL(R))
 S:$G(F)["R" DDWRW=R,DDWC=C
 ;
 S DDWX=C-DDWOFS
 I DDWX>IOM!(DDWX<1) D SHIFT^DDW3(C,.DDWOFS)
 S DY=IOTM+R-2,DX=C-DDWOFS-1 X IOXY
 Q
