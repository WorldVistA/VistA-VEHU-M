PRXAI009 ; ; 03-APR-1995
V ;;4.0;IFCAP;**27**;SEP 23, 1993
 I DSEC F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(440,0,"DD")
 ;;=@
 ;;^DIC(440,0,"DEL")
 ;;=@
 ;;^DIC(440,0,"RD")
 ;;=[
 ;;^DIC(440,0,"WR")
 ;;=]
