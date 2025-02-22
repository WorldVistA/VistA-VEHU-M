PRXAI005 ; ; 03-APR-1995
V ;;4.0;IFCAP;**27**;SEP 23, 1993
 Q:'DIFQ(440)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(440,17.5,"DT")
 ;;=2940711
 ;;^DD(440,17.6,0)
 ;;=PAYMENT ADDRESS4^F^^7;6^K:$L(X)>23!($L(X)<1) X
 ;;^DD(440,17.6,3)
 ;;=Answer must be 1-23 characters in length.
 ;;^DD(440,17.6,21,0)
 ;;=^^1^1^2940711^^^^
 ;;^DD(440,17.6,21,1,0)
 ;;=This is the mailing address, where payment of bill will be sent to.
 ;;^DD(440,17.6,23,0)
 ;;=^^2^2^2940711^
 ;;^DD(440,17.6,23,1,0)
 ;;=Changed from 25 characters maximum to 23 characters to be the same as
 ;;^DD(440,17.6,23,2,0)
 ;;=PAYMENT ADDRESS1 and PAYMENT ADDRESS2.
 ;;^DD(440,17.6,"DT")
 ;;=2940711
 ;;^DD(440,17.7,0)
 ;;=PAYMENT CITY^RF^^7;7^K:$L(X)>20!($L(X)<3) X
 ;;^DD(440,17.7,3)
 ;;=Answer must be 3-20 characters in length.
 ;;^DD(440,17.7,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,17.7,21,1,0)
 ;;=This is the city of payment address.
 ;;^DD(440,17.7,"DT")
 ;;=2940707
 ;;^DD(440,17.8,0)
 ;;=PAYMENT STATE^RP5'^DIC(5,^7;8^Q
 ;;^DD(440,17.8,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,17.8,21,1,0)
 ;;=This is the state of the payment address.
 ;;^DD(440,17.8,"DT")
 ;;=2940707
 ;;^DD(440,17.9,0)
 ;;=PAYMENT ZIP CODE^RFX^^7;9^K:$L(X)<5!(X'?5N.E)!($L(X)>10)!($L(X)>5&(X'?5N1"-"4N)) X
 ;;^DD(440,17.9,3)
 ;;=ENTER 5 DIGIT ZIP CODE OR 9 DIGIT ZIP CODE IN THIS FORMAT 12345-6789
 ;;^DD(440,17.9,21,0)
 ;;=^^1^1^2940804^^
 ;;^DD(440,17.9,21,1,0)
 ;;=This is the zip code for the payment address.
 ;;^DD(440,17.9,23,0)
 ;;=^^4^4^2950403^
 ;;^DD(440,17.9,23,1,0)
 ;;=The input transform checks for a pattern of 5 numerics or
 ;;^DD(440,17.9,23,2,0)
 ;;=5 numerics followed by a dash (-) and 4 numerics.  It also
 ;;^DD(440,17.9,23,3,0)
 ;;=checks for a total length of 10, so fileman will print the
 ;;^DD(440,17.9,23,4,0)
 ;;=zip+4 in outputs.
 ;;^DD(440,17.9,"DT")
 ;;=2950403
 ;;^DD(440,18,0)
 ;;=CALM ID NUMBER^FX^^7;10^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>9!($L(X)<9)!(X'?9UN) X
 ;;^DD(440,18,1,0)
 ;;=^.1
 ;;^DD(440,18,1,1,0)
 ;;=440^AF
 ;;^DD(440,18,1,1,1)
 ;;=S ^PRC(440,"AF",$E(X,1,30),DA)=""
 ;;^DD(440,18,1,1,2)
 ;;=K ^PRC(440,"AF",$E(X,1,30),DA)
 ;;^DD(440,18,1,1,"%D",0)
 ;;=^^2^2^2940615^
 ;;^DD(440,18,1,1,"%D",1,0)
 ;;=This x-ref is used during FMS-VENDOR conversion as one way to find the
 ;;^DD(440,18,1,1,"%D",2,0)
 ;;=vendor record entered in the FMS-CVU document.
 ;;^DD(440,18,1,1,"DT")
 ;;=2940615
 ;;^DD(440,18,3)
 ;;=Answer must be 9 characters in length.
 ;;^DD(440,18,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,18,21,1,0)
 ;;=This is the CALM identification number.
 ;;^DD(440,18,"DT")
 ;;=2940615
 ;;^DD(440,18.2,0)
 ;;=CALM STUB NAME^F^^7;11^K:$L(X)>3!($L(X)<3) X
 ;;^DD(440,18.2,3)
 ;;=ANSWER MUST BE 3 CHARACTERS IN LENGTH
 ;;^DD(440,18.2,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,18.2,21,1,0)
 ;;=This is the CALM stub name.
 ;;^DD(440,18.2,"DT")
 ;;=2870212
 ;;^DD(440,18.3,0)
 ;;=DUN & BRADSTREET #^F^^7;12^K:$L(X)>9!($L(X)<1) X
 ;;^DD(440,18.3,3)
 ;;=ANSWER MUST BE 1-9 CHARACTERS IN LENGTH
 ;;^DD(440,18.3,21,0)
 ;;=^^2^2^2940218^^
 ;;^DD(440,18.3,21,1,0)
 ;;=This is the vendor's Dun & Bradstreet number,
 ;;^DD(440,18.3,21,2,0)
 ;;=if applicable.
 ;;^DD(440,18.3,"DT")
 ;;=2940218
 ;;^DD(440,20,0)
 ;;=SYNONYM^440.02^^5;0
 ;;^DD(440,20,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,20,21,1,0)
 ;;=This is a synonym for the vendor.
 ;;^DD(440,21,0)
 ;;=REMARKS^440.04^^8;0
 ;;^DD(440,21,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,21,21,1,0)
 ;;=These are remarks about the vendor.
 ;;^DD(440,22.1,0)
 ;;=BILLING ADDRESS1^F^^.11;1^K:$L(X)>50!($L(X)<1) X
 ;;^DD(440,22.1,3)
 ;;=ANSWER MUST BE 1-50 CHARACTERS IN LENGTH
 ;;^DD(440,22.1,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,22.1,21,1,0)
 ;;=This is the billing address 1.
 ;;^DD(440,22.1,"DT")
 ;;=2870518
 ;;^DD(440,22.2,0)
 ;;=BILLING ADDRESS2^F^^.11;2^K:$L(X)>50!($L(X)<1) X
 ;;^DD(440,22.2,3)
 ;;=ANSWER MUST BE 1-50 CHARACTERS IN LENGTH
 ;;^DD(440,22.2,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,22.2,21,1,0)
 ;;=This is the billing address 2.
 ;;^DD(440,22.2,"DT")
 ;;=2870518
 ;;^DD(440,22.3,0)
 ;;=BILLING ADDRESS3^F^^.11;3^K:$L(X)>30!($L(X)<2) X
 ;;^DD(440,22.3,3)
 ;;=ANSWER MUST BE 2-30 CHARACTERS IN LENGTH
 ;;^DD(440,22.3,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,22.3,21,1,0)
 ;;=This is the billing address 3.
 ;;^DD(440,22.3,"DT")
 ;;=2870518
 ;;^DD(440,22.4,0)
 ;;=BILLING CITY^F^^.11;4^K:$L(X)>30!($L(X)<2) X
 ;;^DD(440,22.4,3)
 ;;=ANSWER MUST BE 2-30 CHARACTERS IN LENGTH
 ;;^DD(440,22.4,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,22.4,21,1,0)
 ;;=This is the city of the billing address.
 ;;^DD(440,22.4,"DT")
 ;;=2870518
 ;;^DD(440,22.5,0)
 ;;=BILLING STATE^P5'^DIC(5,^.11;5^Q
 ;;^DD(440,22.5,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,22.5,21,1,0)
 ;;=This is the state of the billing address.
 ;;^DD(440,22.5,"DT")
 ;;=2871125
