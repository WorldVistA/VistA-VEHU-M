PRXAI00C ; ; 31-OCT-1994
 ;;4.0;IFCAP;**27**;9/23/93
 Q:'DIFQ(440)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(440,10,21,2,0)
 ;;=current year.
 ;;^DD(440,11,0)
 ;;=SPECIAL FACTORS^F^^3;1^K:$L(X)>50!($L(X)<3) X
 ;;^DD(440,11,3)
 ;;=ANSWER MUST BE 3-50 CHARACTERS IN LENGTH
 ;;^DD(440,11,21,0)
 ;;=^^2^2^2910516^
 ;;^DD(440,11,21,1,0)
 ;;=These are the special factors to be considered when ordering
 ;;^DD(440,11,21,2,0)
 ;;=from this vendor.
 ;;^DD(440,12.4,0)
 ;;=AUSTIN DELETED?^S^Y:YES;N:NO;^2;9^Q
 ;;^DD(440,12.4,21,0)
 ;;=^^3^3^2910516^
 ;;^DD(440,12.4,21,1,0)
 ;;=This indicates whether or not the vendor has
 ;;^DD(440,12.4,21,2,0)
 ;;=been deleted from the Austin DPC
 ;;^DD(440,12.4,21,3,0)
 ;;=vendor file.
 ;;^DD(440,12.4,"DT")
 ;;=2860513
 ;;^DD(440,12.5,0)
 ;;=FEE VENDOR^S^Y:YES;N:NO;^2;10^Q
 ;;^DD(440,12.5,21,0)
 ;;=^^2^2^2910516^
 ;;^DD(440,12.5,21,1,0)
 ;;=This indicates whether or not this vendor is a 
 ;;^DD(440,12.5,21,2,0)
 ;;=fee basis vendor.
 ;;^DD(440,12.5,"DT")
 ;;=2860513
 ;;^DD(440,13,0)
 ;;=IS A SF129 ON FILE?^S^Y:YES;N:NO;NA:NOT APPLICABLE;^2;7^Q
 ;;^DD(440,13,21,0)
 ;;=^^1^1^2930204^^
 ;;^DD(440,13,21,1,0)
 ;;=This indicates whether or not a Standard Form 129 is on file.
 ;;^DD(440,13,"DT")
 ;;=2860329
 ;;^DD(440,14,0)
 ;;=DATE OF SF129^RD^^2;8^S %DT="E" D ^%DT S X=Y K:Y<1 X
 ;;^DD(440,14,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,14,21,1,0)
 ;;=This is the date of the Standard Form 129.
 ;;^DD(440,14,"DT")
 ;;=2860329
 ;;^DD(440,15,0)
 ;;=REPLACEMENT VENDOR^*P440'^PRC(440,^9;1^S DIC("S")="I $S('$D(^(10)):1,+$P(^(10),U,5)=0:1,1:0)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(440,15,12)
 ;;=CANNOT CHOOSE AN INACTIVE VENDOR
 ;;^DD(440,15,12.1)
 ;;=S DIC("S")="I $S('$D(^(10)):1,+$P(^(10),U,5)=0:1,1:0)"
 ;;^DD(440,15,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,15,21,1,0)
 ;;=This is the replacement vendor.
 ;;^DD(440,15,"DT")
 ;;=2870225
 ;;^DD(440,16,0)
 ;;=SERVICE/RETURN ADDRESS1^F^^6;1^K:$L(X)>33!($L(X)<1) X
 ;;^DD(440,16,3)
 ;;=ANSWER MUST BE 1-33 CHARACTERS IN LENGTH
 ;;^DD(440,16,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,16,21,1,0)
 ;;=This is the service/return address 1.
 ;;^DD(440,16,"DT")
 ;;=2861122
 ;;^DD(440,16.1,0)
 ;;=SERVICE/RETURN ADDRESS2^F^^6;2^K:$L(X)>33!($L(X)<1) X
 ;;^DD(440,16.1,3)
 ;;=ANSWER MUST BE 1-33 CHARACTERS IN LENGTH
 ;;^DD(440,16.1,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,16.1,21,1,0)
 ;;=This is the service/return address 2.
 ;;^DD(440,16.1,"DT")
 ;;=2861122
 ;;^DD(440,16.2,0)
 ;;=SERVICE/RETURN ADDRESS3^F^^6;3^K:$L(X)>25!($L(X)<1) X
 ;;^DD(440,16.2,3)
 ;;=ANSWER MUST BE 1-25 CHARACTERS IN LENGTH
 ;;^DD(440,16.2,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,16.2,21,1,0)
 ;;=This is the service/return address 3.
 ;;^DD(440,16.2,"DT")
 ;;=2861122
 ;;^DD(440,16.3,0)
 ;;=SERVICE/RETURN ADDRESS4^F^^6;4^K:$L(X)>25!($L(X)<1) X
 ;;^DD(440,16.3,3)
 ;;=ANSWER MUST BE 1-25 CHARACTERS IN LENGTH
 ;;^DD(440,16.3,21,0)
 ;;=^^2^2^2930408^
 ;;^DD(440,16.3,21,1,0)
 ;;= 
 ;;^DD(440,16.3,21,2,0)
 ;;=This is the service/return address 4
 ;;^DD(440,16.3,"DT")
 ;;=2861122
 ;;^DD(440,16.4,0)
 ;;=SERVICE/RETURN CITY^F^^6;5^K:$L(X)>20!($L(X)<3) X
 ;;^DD(440,16.4,3)
 ;;=ANSWER MUST BE 3-20 CHARACTERS IN LENGTH
