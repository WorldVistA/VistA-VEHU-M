A1BFEX0 ;ALBANY ISC ; ECF ; 17DEC92
 ;;V1.0
EN ;
 D SETUP I OUT D EXIT Q
 D LOOP
 Q
SETUP ;
 S OUT=0
 I '$D(^A1BF(11604)) S OUT=0 Q
 Q
LOOP ;
 S A1BFI=0 F  S A1BFI=$O(^A1BF(11604,1,1,A1BFI)) Q:A1BFI=""  I $D(^(A1BFI,0)) D
 .S ^UTILITY($J,"EXP",A1BFI)=""
 Q
EXIT ;
 K A1BFI
 Q
