ENXYIEN ;WCIOFO/SAB-ENVIRONMENTAL CHECK ;8/4/97
 ;;7.0;ENGINEERING;**44**;Aug 17, 1993
 ;
 Q:'$G(XPDENV)  ; only during install package option
 ;
 S X="ENFAEIL" X ^%ZOSF("TEST") I '$T D
 . S XPDQUIT=2
 . W !!,"Patch EN*7*39 does not appear to have been installed."
 . W !,"It must be installed prior to installation of patch EN*7*44."
 . W !!,"Please install this patch (EN*7*44) immediately after"
 . W !,"installation of patch EN*7*39."
 Q
 ;ENXYIEN
