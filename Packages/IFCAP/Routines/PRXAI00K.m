PRXAI00K ; ; 31-OCT-1994
 ;;4.0;IFCAP;**27**;9/23/93
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PKG",48,0)
 ;;=PRXA^PRXA^VENDOR CONVERSION FOR 5.0
 ;;^UTILITY(U,$J,"PKG",48,1,0)
 ;;=^^2^2^2941031^^^^
 ;;^UTILITY(U,$J,"PKG",48,1,1,0)
 ;;=This is the package entry to send out the version 5.0 VENDOR file
 ;;^UTILITY(U,$J,"PKG",48,1,2,0)
 ;;=conversion from FMS.
 ;;^UTILITY(U,$J,"PKG",48,4,0)
 ;;=^9.44PA^3^3
 ;;^UTILITY(U,$J,"PKG",48,4,1,0)
 ;;=440
 ;;^UTILITY(U,$J,"PKG",48,4,1,1,0)
 ;;=^9.45A^^0
 ;;^UTILITY(U,$J,"PKG",48,4,1,222)
 ;;=y^^^n^^^n
 ;;^UTILITY(U,$J,"PKG",48,4,2,0)
 ;;=411.3
 ;;^UTILITY(U,$J,"PKG",48,4,2,222)
 ;;=y^^^n^^^n
 ;;^UTILITY(U,$J,"PKG",48,4,3,0)
 ;;=411.4
 ;;^UTILITY(U,$J,"PKG",48,4,3,222)
 ;;=y^^^n^^^y^o^n
 ;;^UTILITY(U,$J,"PKG",48,4,"B",411.3,2)
 ;;=
 ;;^UTILITY(U,$J,"PKG",48,4,"B",411.4,3)
 ;;=
 ;;^UTILITY(U,$J,"PKG",48,4,"B",440,1)
 ;;=
 ;;^UTILITY(U,$J,"PKG",48,22,0)
 ;;=^9.49I^1^1
 ;;^UTILITY(U,$J,"PKG",48,22,1,0)
 ;;=1^2940914^2940914
 ;;^UTILITY(U,$J,"PKG",48,22,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"PKG",48,"INIT")
 ;;=PRCOVUP3^
 ;;^UTILITY(U,$J,"SBF",411.3,411.3)
 ;;=
 ;;^UTILITY(U,$J,"SBF",411.4,411.4)
 ;;=
 ;;^UTILITY(U,$J,"SBF",411.4,411.41)
 ;;=
 ;;^UTILITY(U,$J,"SBF",440,440)
 ;;=
 ;;^UTILITY(U,$J,"SBF",440,440.01)
 ;;=
 ;;^UTILITY(U,$J,"SBF",440,440.02)
 ;;=
 ;;^UTILITY(U,$J,"SBF",440,440.03)
 ;;=
 ;;^UTILITY(U,$J,"SBF",440,440.04)
 ;;=
 ;;^UTILITY(U,$J,"SBF",440,440.05)
 ;;=
