ACKQITMP ;BIR/PTD-Environment Check Routine Distributed with QUASAR Patch #2 ; 11/13/96 10:00
V ;;2.0;QUASAR;**2**;JUN 5,1996
 S Y=$$VERSION^XPDUTL("EC") I Y'="2.0" W !!,"You must have Event Capture version 2.0 installed." G ABORT
 ;Required software is present. OK to continue.
 W !!,"Environment check is ok.",! K Y
 Q
 ;
ABORT ;Abort install and delete transport global.
 S XPDQUIT=1 K Y
 Q
