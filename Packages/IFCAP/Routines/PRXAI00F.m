PRXAI00F ; ; 31-OCT-1994
 ;;4.0;IFCAP;**27**;9/23/93
 Q:'DIFQ(440)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
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
 ;;^DD(440,22.6,0)
 ;;=BILLING ZIP CODE^F^^.11;6^K:$L(X)>9!($L(X)<5) X
 ;;^DD(440,22.6,3)
 ;;=ANSWER MUST BE 5-9 CHARACTERS IN LENGTH
 ;;^DD(440,22.6,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,22.6,21,1,0)
 ;;=This is the zip code of the billing address.
 ;;^DD(440,22.6,"DT")
 ;;=2870518
 ;;^DD(440,22.7,0)
 ;;=BILLING PHONE NUMBER^F^^.11;7^K:$L(X)>20!($L(X)<3) X
 ;;^DD(440,22.7,3)
 ;;=Answer must be 3-20 characters in length.
 ;;^DD(440,22.7,21,0)
 ;;=^^2^2^2930408^
 ;;^DD(440,22.7,21,1,0)
 ;;= 
 ;;^DD(440,22.7,21,2,0)
 ;;=This is the phone number of the billing address.
 ;;^DD(440,22.7,"DT")
 ;;=2910301
 ;;^DD(440,30,0)
 ;;=DATE VENDOR CREATED^D^^10;1^S %DT="E" D ^%DT S X=Y K:Y<1 X
 ;;^DD(440,30,3)
 ;;=Date Vendor was originally created, or Vendor Name was changed.
 ;;^DD(440,30,21,0)
 ;;=^^2^2^2910516^^
 ;;^DD(440,30,21,1,0)
 ;;=This is the date the vendor was created, or the date the vendor
 ;;^DD(440,30,21,2,0)
 ;;=name changed.
 ;;^DD(440,30,"DT")
 ;;=2890207
 ;;^DD(440,31,0)
 ;;=CREATED BY^P200'^VA(200,^10;2^Q
 ;;^DD(440,31,3)
 ;;=Name of person who added vendor to this file.
 ;;^DD(440,31,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,31,21,1,0)
 ;;=This is the person who created the vendor.
 ;;^DD(440,31,"DT")
 ;;=2921221
 ;;^DD(440,31.5,0)
 ;;=INACTIVATED VENDOR^S^1:INACTIVATED;^10;5^Q
 ;;^DD(440,31.5,1,0)
 ;;=^.1
 ;;^DD(440,31.5,1,1,0)
 ;;=440^AE^MUMPS
 ;;^DD(440,31.5,1,1,1)
 ;;=I '$D(DIU(0)) S:$D(DT) $P(^PRC(440,DA,10),U,3)=DT S:$D(DUZ) $P(^(10),U,4)=DUZ
 ;;^DD(440,31.5,1,1,2)
 ;;=I '$D(DIU(0)) S $P(^PRC(440,DA,10),U,3,4)="^"
 ;;^DD(440,31.5,1,1,"%D",0)
 ;;=^^4^4^2930729^^^
 ;;^DD(440,31.5,1,1,"%D",1,0)
 ;;=This X-REF will SET the DATE INACTIVATED and the INACTIVATED BY fields
