PRXAI00D ; ; 31-OCT-1994
 ;;4.0;IFCAP;**27**;9/23/93
 Q:'DIFQ(440)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(440,16.4,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,16.4,21,1,0)
 ;;=This is the city of the service/return address.
 ;;^DD(440,16.4,"DT")
 ;;=2861122
 ;;^DD(440,16.5,0)
 ;;=SERVICE/RETURN STATE^P5'^DIC(5,^6;6^Q
 ;;^DD(440,16.5,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,16.5,21,1,0)
 ;;=This is the state of the service/return address.
 ;;^DD(440,16.5,"DT")
 ;;=2861122
 ;;^DD(440,16.6,0)
 ;;=SERVICE/RETURN ZIP CODE^FX^^6;7^K:$L(X)<5!(X'?5N.E)!($L(X)>5&(X'?5N1"-"4N)) X
 ;;^DD(440,16.6,3)
 ;;=5 DIGIT ZIP CODE OR 9 DIGIT ZIP CODE IN THIS FORMAT 12345-6789
 ;;^DD(440,16.6,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,16.6,21,1,0)
 ;;=This is the zip code of the service/return address.
 ;;^DD(440,16.6,"DT")
 ;;=2861122
 ;;^DD(440,16.7,0)
 ;;=SERVICE CONTACT PERSON^F^^6;8^K:$L(X)>30!($L(X)<3) X
 ;;^DD(440,16.7,3)
 ;;=ANSWER MUST BE 3-30 CHARACTERS IN LENGTH
 ;;^DD(440,16.7,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,16.7,21,1,0)
 ;;=This is the service contact person.
 ;;^DD(440,16.7,"DT")
 ;;=2861122
 ;;^DD(440,16.8,0)
 ;;=SERVICE PHONE NO.^F^^6;9^K:$L(X)>18!($L(X)<3) X
 ;;^DD(440,16.8,3)
 ;;=ANSWER MUST BE 3-18 CHARACTERS IN LENGTH
 ;;^DD(440,16.8,21,0)
 ;;=^^2^2^2910516^
 ;;^DD(440,16.8,21,1,0)
 ;;=This is the phone number for the service/return
 ;;^DD(440,16.8,21,2,0)
 ;;=contact person.
 ;;^DD(440,16.8,"DT")
 ;;=2861122
 ;;^DD(440,17,0)
 ;;=PAYMENT CONTACT PERSON^F^^7;1^K:$L(X)>30!($L(X)<3) X
 ;;^DD(440,17,3)
 ;;=ANSWER MUST BE 3-30 CHARACTERS IN LENGTH
 ;;^DD(440,17,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,17,21,1,0)
 ;;=This is the payment contact person.
 ;;^DD(440,17,"DT")
 ;;=2861122
 ;;^DD(440,17.2,0)
 ;;=PAYMENT PHONE NO.^F^^7;2^K:$L(X)>18!($L(X)<3) X
 ;;^DD(440,17.2,3)
 ;;=ANSWER MUST BE 3-18 CHARACTERS IN LENGTH
 ;;^DD(440,17.2,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,17.2,21,1,0)
 ;;=This is the phone number for the payment contact person.
 ;;^DD(440,17.2,"DT")
 ;;=2861122
 ;;^DD(440,17.3,0)
 ;;=PAYMENT ADDRESS1^RF^^7;3^K:$L(X)>23!($L(X)<1) X
 ;;^DD(440,17.3,3)
 ;;=Answer must be 1-23 characters in length.
 ;;^DD(440,17.3,21,0)
 ;;=^^1^1^2940711^^^^
 ;;^DD(440,17.3,21,1,0)
 ;;=This is the mailing address, where payment of bill will be sent to. 
 ;;^DD(440,17.3,23,0)
 ;;=^^1^1^2940711^
 ;;^DD(440,17.3,23,1,0)
 ;;=Changed from 33 characters maximum to 23 characters for FMS.
 ;;^DD(440,17.3,"DT")
 ;;=2940711
 ;;^DD(440,17.4,0)
 ;;=PAYMENT ADDRESS2^F^^7;4^K:$L(X)>23!($L(X)<1) X
 ;;^DD(440,17.4,3)
 ;;=Answer must be 1-23 characters in length.
 ;;^DD(440,17.4,21,0)
 ;;=1^^1^1^2940711^^^^
 ;;^DD(440,17.4,21,1,0)
 ;;=This is the mailing address, where payment of bill will be sent to.
 ;;^DD(440,17.4,23,0)
 ;;=^^1^1^2940711^
 ;;^DD(440,17.4,23,1,0)
 ;;=Changed from 33 characters maximum to 23 characters for FMS.
 ;;^DD(440,17.4,"DT")
 ;;=2940711
 ;;^DD(440,17.5,0)
 ;;=PAYMENT ADDRESS3^F^^7;5^K:$L(X)>23!($L(X)<1) X
 ;;^DD(440,17.5,3)
 ;;=Answer must be 1-23 characters in length.
 ;;^DD(440,17.5,21,0)
 ;;=^^1^1^2940711^^^^
 ;;^DD(440,17.5,21,1,0)
 ;;=This is the mailing address, where payment of bill will be sent to.
 ;;^DD(440,17.5,23,0)
 ;;=^^2^2^2940711^
