XUMFENV ;CIOFO-SF/RAM - ENVIRONMENT INIT ROUTINE ;06/28/00
 ;;8.0;KERNEL;**206**;Jul 10, 1995
 ;
 ;
EN ; -- enivornment check
 ;
 N I
 ;
 ;check STATE (#5) file
 F I=1,2,4,5,6 S:'$D(^DIC(5,+I)) XPDQUIT=2
 F I=8:1:13 S:'$D(^DIC(5,+I)) XPDQUIT=2
 F I=15:1:42 S:'$D(^DIC(5,+I)) XPDQUIT=2
 F I=44:1:51 S:'$D(^DIC(5,+I)) XPDQUIT=2
 F I=53:1:56 S:'$D(^DIC(5,+I)) XPDQUIT=2
 ;
 Q:'$G(XPDQUIT)
 ;
 W !,"Your STATE (#5) file is missing required entries!"
 W !,"You must fix the STATE (#5) file BEFORE installing this patch."
 ;
 Q
 ;
