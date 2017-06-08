FBXAIEN ;WIRMFO/SAB- ENVIRONMENTAL CHECK ;9/9/97
 ;;3.5;FEE BASIS;**9**;JAN 30, 1995
 ;
 Q:'$G(XPDENV)  ; only during install package option
 ;
 I '$$PATCH^XPDUTL("PRC*5.0*118") D
 . S XPDQUIT=2
 . W !!,"IFCAP patch PRC*5*118 does not appear to have been installed."
 . W !,"It must be installed before FEE BASIS patch FB*3.5*9."
 . W !!,"Please install patch PRC*5*118 first and then perform the"
 . W !,"installation of this patch (FB*3.5*9).",!
 Q
 ;FBXAIEN
