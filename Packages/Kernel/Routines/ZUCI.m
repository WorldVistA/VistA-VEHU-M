%DJM ;NEW PROGRAM [ 03/03/92  12:04 AM ]
 N I,J,U,V
PROMPT R !,"UCI: ",U:180 Q:U=""  G:U="^L"!(U="^l")!(U="?") LIST
 S U=$TR(U,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I U'?3U&(U'?3U1","3U) W *7," ..must be: UCI or UCI,SYS" G PROMPT
 I U?3U1","3U F I=0:1:7 F J=1:1:32 G:U=$ZU(J,I) GOTUV
 I U?3U F I=0:1:7 F J=1:1:32 G:U=$P($ZU(J,I),",") GOTUV
 W *7," ..not found" G PROMPT
GOTUV ;
 I $D(^%)&$D(^%E) ;CLEAR NAKED
 V 2:$J:I*32+J:2
 I U?3U1","3U W " ..Switched.",! Q
 W "  ..Switched to: ",$ZU(0) Q
 ;
LIST ;
 W !,"Available UCI,SYS entries:",!,?4
 F I=0:1:7 F J=1:1:32 S V=$ZU(J,I) I V'="" W:$X>70 !,?5 W V," "
 G PROMPT
