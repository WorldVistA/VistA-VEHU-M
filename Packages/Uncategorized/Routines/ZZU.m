ZU ;SF/GFT - TIE ALL TERMINALS EXCEPT CONSOLE TO THIS ROUTINE!! ;8/13/92  07:40 ;
 ;;7.1;KERNEL;;May 11, 1993
 ;FOR MSM-UNIX
 S $ZT="ERR^ZU"
 G ^XUS
 ;
ERR S $ZT="" L  ;Come here on error.
 I $G(IO)]"",$D(IO(1,IO)),$E($G(IOST))="P" U IO W @$S($D(IOF):IOF,1:"#")
 S %ZTERLGR=$ZR D ^%ZTER
 B 0 X ^%ZOSF("PROGMODE") Q:Y  S $ZT="HALT^ZU"
 I $ZE'["<INRPT>" K ^XMB(3.7,DUZ,100,$I) S XUERF="" G C^XUS
CTRLC I $D(IO)=11 U IO(0) W !,"--Interrupt Acknowledged",!
 S Y=^XUTL("XQ",$J,^XUTL("XQ",$J,"T")-1),Y(0)=$P(Y,"^",2,99),Y=$P(Y,"^",1)
 S $ZT="ERR^ZU" G M1^XQ
 ;
HALT S $ZT="" K ^XUTL("XQ",$J) K:$D(DUZ) ^XMB(3.7,DUZ,100,$I) H
