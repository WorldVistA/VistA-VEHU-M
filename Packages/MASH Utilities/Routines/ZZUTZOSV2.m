ZZUTZOSV2 ; VEN/SMH - Unit Tests for GT.M VistA Port;2017-01-09  3:56 PM
 ;;8.0;KERNEL;**10001**;;Build 11
 ; Submitted to OSEHRA in 2017 by Sam Habiel for OSEHRA
 ; Authored by Sam Habiel 2016.
 ;
STARTUP QUIT
 ;
SHUTDOWN ; 
 S $ZSOURCE="ZZUTZOSV"
 QUIT
 ;
NOOP ; @TEST Top doesn't do anything.
 D ^%ZOSV2
 D SUCCEED^%ut
 QUIT
 ;
SAVE1 ; @TEST Save a Routine normal
 N XCN,DIE
 S XCN=0,DIE=$$OREF^DILF($NA(^TMP($J)))
 K ^TMP($J)
 S ^TMP($J,$I(XCN),0)="KBANHELLO ; VEN/SMH - Sample Testing Routine"
 S ^TMP($J,$I(XCN),0)=" ;;"
 S ^TMP($J,$I(XCN),0)=";this is not supposed to be saved"
 S ^TMP($J,$I(XCN),0)=" WRITE ""HELLO WORLD"""
 S ^TMP($J,$I(XCN),0)=" QUIT"
 S XCN=0
 D SAVE^%ZOSV2("KBANHELLO")
 D CHKTF^%ut($T(+1^KBANHELLO)["VEN/SMH")
 D CHKTF^%ut($T(+2^KBANHELLO)[";;")
 D CHKTF^%ut($T(+3^KBANHELLO)["HELLO WORLD")
 D CHKTF^%ut($T(+4^KBANHELLO)["QUIT")
 D CHKTF^%ut($T(+3^KBANHELLO)'[$C(9)) ; no tabs
 D CHKTF^%ut($T(+4^KBANHELLO)'[$C(9)) ; no tabs
 QUIT
 ;
SAVE2 ; @TEST Save a Routine with syntax errors -- should not show.
 N XCN,DIE
 S XCN=0,DIE=$$OREF^DILF($NA(^TMP($J)))
 K ^TMP($J)
 S ^TMP($J,$I(XCN),0)="KBANHELLO ; VEN/SMH - Sample Testing Routine"
 S ^TMP($J,$I(XCN),0)=" ;;"
 S ^TMP($J,$I(XCN),0)=" WROTE ""HELLO WORLD"""
 S ^TMP($J,$I(XCN),0)=" W $P(""TEST"")"
 S ^TMP($J,$I(XCN),0)=" QUIT"
 S XCN=0
 N % S %=$$RETURN^%ZOSV("rm -f /tmp/kbanhello.mje",1)
 ; ZEXCEPT: SAVE,error,%ZOSV2,in,out,PASS
 J SAVE^%ZOSV2("KBANHELLO"):(error="/tmp/kbanhello.mje":in="/dev/null":out="/dev/null":PASS)
 F  H .001  Q:($$RETURN^%ZOSV("stat /tmp/kbanhello.mje",1)=0)
 D CHKTF^%ut(+$$RETURN^%ZOSV("wc -l /tmp/kbanhello.mje")=0)
 QUIT
 ;
LOAD ; @TEST Load Routine
 N XCN,DIE
 S XCN=0,DIE=$$OREF^DILF($NA(^TMP($J)))
 K ^TMP($J)
 S ^TMP($J,$I(XCN),0)="KBANHELLO ; VEN/SMH - Sample Testing Routine"
 S ^TMP($J,$I(XCN),0)=" ;;"
 S ^TMP($J,$I(XCN),0)=";this is not supposed to be saved"
 S ^TMP($J,$I(XCN),0)=" WRITE ""HELLO WORLD"""
 S ^TMP($J,$I(XCN),0)=" QUIT"
 S XCN=0
 D SAVE^%ZOSV2("KBANHELLO")
 N DIF
 K ^TMP($J)
 S DIF=$$OREF^DILF($NA(^TMP($J,"ROU")))
 D LOAD^%ZOSV2("KBANHELLO")
 D CHKTF^%ut(^TMP($J,"ROU",1,0)["KBANHELLO")
 D CHKTF^%ut(^TMP($J,"ROU",4,0)["QUIT")
 QUIT
 ;
RSUM ; @TEST Checksums
 D CHKTF^%ut($$RSUM^%ZOSV2("KBANHELLO"))
 D CHKTF^%ut($$RSUM2^%ZOSV2("KBANHELLO"))
 QUIT
 ;
TESTR ; @TEST Test existence of routine
 D CHKTF^%ut($$TEST^%ZOSV2("KBANHELLO")]"")
 QUIT
 ;
DEL ; @TEST Test Super Duper Deleter
 H .01 ; Necessary so that object deletion would work
 D DEL^%ZOSV2("KBANHELLO")
 D CHKTF^%ut($T(+1^KBANHELLO)="")
 D CHKTF^%ut($$TEST^%ZOSV2("KBANHELLO")="")
 QUIT
