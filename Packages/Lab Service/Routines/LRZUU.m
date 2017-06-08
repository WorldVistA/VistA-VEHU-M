LRZUU ;AVAMC/REG- FIND FIELD FOR A SUBSCRIPT & PIECE ; 9/2/87  09:35 ; [ 07/30/96  8:22 AM ]
 ;;5.1;LAB;;04/11/91 11:06
 S:'$D(DTIME) DTIME=300
 W !!?20,"Enter file/subfile #, subscript and piece",!?30,"separated by commas: "
 R X:DTIME Q:X=""!(X["^")
 F A=1:1:3 S A(A)=$P(X,",",A)
 F A=1:1:3 I A(A)="" W *7,!!,"File, subscript and piece must be entered and separated by commas (',')." G LRZUU
 S X=$O(^DD(A(1),"GL",A(2),A(3),0)) I X="" W *7,!!,"Field not found.  Try again." G LRZUU
 W !!,"FIELD #: ",X,!!,"DESCRIPTION: ",^DD(A(1),X,0) G LRZUU
