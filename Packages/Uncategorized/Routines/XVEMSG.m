XVEMSG ;DJB,VSHL**Global Loader ; 2/29/16 9:18am
 ;;14.0;VICTORY PROG ENVIRONMENT;;Feb 27, 2017;COPYRIGHT David Bolduc @1993
 ;
 Q
ALL ;Load entire ^XVEMS global
 NEW I,RTN,TAG,TXT
 D INIT
 D SY
 ;
 ;Build System QWIKs
 D ^XVEMSGS
 D ^XVEMSGT
 D ^XVEMSGU
 ;
 ;Load ZOSF nodes
 ;D ^XVEMSGR
 ;
 ;Load Help and other text
 D TEXT^XVEMSGH
 Q
 ;
 ;
 ;
SY ;Use to guarantee unique subscript - $J_$G(^XVEMS("SY"))
 ;Necessary because not all systems support $SY.
 S ^XVEMS("SY")=""
 ;Set error trap to test if vendor supports $SY
 D  ;
 . N $ESTACK,$ETRAP S $ETRAP="S $EC="""""
 . I $SY]"" S ^XVEMS("SY")="-"_$SY
 Q
 ;
INIT ;
 S U="^"
 S ^XVEMS("%")="Scratch area"
 S ^XVEMS("CLH")="Command line history"
 S ^XVEMS("ID")="User IDs"
 S ^XVEMS("PARAM")="Shell parameters"
 Q
 ;
ERROR ;
 Q
