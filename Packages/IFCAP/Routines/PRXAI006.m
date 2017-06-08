PRXAI006 ; ; 03-APR-1995
V ;;4.0;IFCAP;**27**;SEP 23, 1993
 Q:'DIFQ(440)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
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
 ;;^DD(440,31.5,1,1,"%D",2,0)
 ;;=when a vendor is inactivated.
 ;;^DD(440,31.5,1,1,"%D",3,0)
 ;;=If a vendor is reactivated both fields will be set to null in the KILL
 ;;^DD(440,31.5,1,1,"%D",4,0)
 ;;=statement.
 ;;^DD(440,31.5,1,1,"DT")
 ;;=2930729
 ;;^DD(440,31.5,3)
 ;;=Set to '1' automatically by the option used to inactivate a vendor.
 ;;^DD(440,31.5,21,0)
 ;;=^^2^2^2910516^^
 ;;^DD(440,31.5,21,1,0)
 ;;=This field is set automatically by the option
 ;;^DD(440,31.5,21,2,0)
 ;;=used to inactivate a vendor.
 ;;^DD(440,31.5,"DT")
 ;;=2930729
 ;;^DD(440,32,0)
 ;;=DATE INACTIVATED^D^^10;3^S %DT="E" D ^%DT S X=Y K:Y<1 X
 ;;^DD(440,32,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,32,21,1,0)
 ;;=This is the date the vendor was made inactive.
 ;;^DD(440,32,"DT")
 ;;=2890207
 ;;^DD(440,33,0)
 ;;=INACTIVATED BY^P200'^VA(200,^10;4^Q
 ;;^DD(440,33,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440,33,21,1,0)
 ;;=This is the person who made the vendor inactive.
 ;;^DD(440,33,"DT")
 ;;=2921221
 ;;^DD(440,34,0)
 ;;=FMS VENDOR CODE^RF^^3;4^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>9!($L(X)<1) X
 ;;^DD(440,34,1,0)
 ;;=^.1
 ;;^DD(440,34,1,1,0)
 ;;=440^D
 ;;^DD(440,34,1,1,1)
 ;;=S ^PRC(440,"D",$E(X,1,30),DA)=""
 ;;^DD(440,34,1,1,2)
 ;;=K ^PRC(440,"D",$E(X,1,30),DA)
 ;;^DD(440,34,1,1,"DT")
 ;;=2940304
 ;;^DD(440,34,3)
 ;;=Answer must be 1-9 characters in length.
 ;;^DD(440,34,21,0)
 ;;=^^2^2^2940627^
 ;;^DD(440,34,21,1,0)
 ;;=This is the code that FMS uses to identify a vendor.  It comes from the
 ;;^DD(440,34,21,2,0)
 ;;=SSN/TAX ID NUMBER field in this file.
 ;;^DD(440,34,"DT")
 ;;=2940707
 ;;^DD(440,34.5,0)
 ;;=FMS VENDOR NAME^FI^^3;7^K:$L(X)>30!($L(X)<1) X
 ;;^DD(440,34.5,3)
 ;;=Answer must be 1-30 characters in length.
 ;;^DD(440,34.5,21,0)
 ;;=^^1^1^2940808^^
 ;;^DD(440,34.5,21,1,0)
 ;;=This is the FMS Vendor Name which is entered in the FMS system.
 ;;^DD(440,34.5,"DT")
 ;;=2940808
 ;;^DD(440,35,0)
 ;;=ALT-ADDR-IND^F^^3;5^K:$L(X)>2!($L(X)<1) X
 ;;^DD(440,35,3)
 ;;=
 ;;^DD(440,35,21,0)
 ;;=^^1^1^2940627^
 ;;^DD(440,35,21,1,0)
 ;;=This field allows one VENDOR to have many payment addresses.
 ;;^DD(440,35,"DT")
 ;;=2940127
 ;;^DD(440,36,0)
 ;;=NON-RECURRING/RECURRING VENDOR^S^N:NON-RECURRING VENDOR;R:RECURRING;^3;6^Q
 ;;^DD(440,36,21,0)
 ;;=^^2^2^2940919^^^^
 ;;^DD(440,36,21,1,0)
 ;;=This field having a 'N' will represent that this vendor will be used
 ;;^DD(440,36,21,2,0)
 ;;=only one time.
 ;;^DD(440,36,"DT")
 ;;=2940919
 ;;^DD(440,38,0)
 ;;=TAX ID/SSN^RFX^^3;8^S X=$TR(X,"-") K:$L(X)>9!($L(X)<9)!(X'?9N) X
 ;;^DD(440,38,3)
 ;;=Enter 9 digits with 0 Decimal Digits.
 ;;^DD(440,38,21,0)
 ;;=^^3^3^2940627^
 ;;^DD(440,38,21,1,0)
 ;;=This field will send FMS information that will be used as the FMS
 ;;^DD(440,38,21,2,0)
 ;;=VENDOR CODE.  FMS might use a different FMS VENDOR CODE but that is
 ;;^DD(440,38,21,3,0)
 ;;=normally not done.
 ;;^DD(440,38,"DT")
 ;;=2940712
 ;;^DD(440,39,0)
 ;;=SSN/TAX ID INDICATOR^RS^S:SOCIAL SECURITY NUMBER;T:TAX IDENTIFICATION NUMBER;^3;9^Q
