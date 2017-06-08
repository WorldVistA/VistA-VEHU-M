PRXAI003 ; ; 03-APR-1995
V ;;4.0;IFCAP;**27**;SEP 23, 1993
 Q:'DIFQ(440)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(440,4.7,"DT")
 ;;=2860514
 ;;^DD(440,4.8,0)
 ;;=PROCUREMENT CONTACT PERSON^F^^0;9^K:$L(X)>30!($L(X)<3) X
 ;;^DD(440,4.8,3)
 ;;=ANSWER MUST BE 3-30 CHARACTERS IN LENGTH
 ;;^DD(440,4.8,21,0)
 ;;=^^1^1^2940616^^^
 ;;^DD(440,4.8,21,1,0)
 ;;=This is the name of the procurement contact person.
 ;;^DD(440,4.8,"DT")
 ;;=2850727
 ;;^DD(440,5,0)
 ;;=VENDOR PHONE NUMBER^F^^0;10^K:$L(X)>18!($L(X)<7) X
 ;;^DD(440,5,3)
 ;;=Answer must be 7-18 characters in length.
 ;;^DD(440,5,21,0)
 ;;=^^1^1^2940707^^^^
 ;;^DD(440,5,21,1,0)
 ;;=This is the phone number of the vendor contact person.
 ;;^DD(440,5,21,2,0)
 ;;=person.
 ;;^DD(440,5,"DT")
 ;;=2940707
 ;;^DD(440,5.1,0)
 ;;=ACCOUNT NO.^F^^2;1^K:$L(X)>33!($L(X)<3) X
 ;;^DD(440,5.1,3)
 ;;=ANSWER MUST BE 3-33 CHARACTERS IN LENGTH
 ;;^DD(440,5.1,21,0)
 ;;=^^1^1^2940616^^
 ;;^DD(440,5.1,21,1,0)
 ;;=This is the vendor account number.
 ;;^DD(440,5.2,0)
 ;;=GUARANTEED DELIVERY VENDOR?^S^Y:YES;N:NO;^2;11^Q
 ;;^DD(440,5.2,3)
 ;;=Enter 'Y' if an agreement has been set up with this vendor to guarantee delivery on direct deliveries to patients.
 ;;^DD(440,5.2,21,0)
 ;;=^^1^1^2940616^^^^
 ;;^DD(440,5.2,21,1,0)
 ;;=Enter YES if there is a guaranteed delivery agreement for this vendor.
 ;;^DD(440,5.2,"DT")
 ;;=2890120
 ;;^DD(440,6,0)
 ;;=CONTRACT NUMBER^440.03I^^4;0
 ;;^DD(440,6,21,0)
 ;;=^^1^1^2940616^^^
 ;;^DD(440,6,21,1,0)
 ;;=This is the vendor contract number.
 ;;^DD(440,8,0)
 ;;=LABOR SURPLUS AREA?^S^Y:YES;N:NO;^2;5^Q
 ;;^DD(440,8,3)
 ;;=Emter 'YES' if this vendor is located in a labor surplus area.
 ;;^DD(440,8,21,0)
 ;;=^^1^1^2940616^^^
 ;;^DD(440,8,21,1,0)
 ;;=This indicates whether or not the vendor is located in a labor surplus.
 ;;^DD(440,8,21,2,0)
 ;;=a labor surplus.
 ;;^DD(440,8,"DT")
 ;;=2860219
 ;;^DD(440,8.2,0)
 ;;=BUSINESS TYPE (FPDS-88)^RSX^1:SMALL;2:LARGE;3:STATE/LOCAL/ED./NON-PROFIT;4:OUTSIDE U.S.;5:FEDERAL GOVT. SOURCE;^2;6^Q
 ;;^DD(440,8.2,3)
 ;;=Select one entry from the choices.
 ;;^DD(440,8.2,21,0)
 ;;=^^1^1^2940616^^^^
 ;;^DD(440,8.2,21,1,0)
 ;;=This is the type of business for FY88 FPDS reporting purposes.
 ;;^DD(440,8.2,21,2,0)
 ;;=purposes.
 ;;^DD(440,8.2,"DT")
 ;;=2880825
 ;;^DD(440,8.3,0)
 ;;=BUSINESS TYPE (FPDS)^RS^1:SMALL;2:LARGE;3:OUTSIDE U.S.;4:STATE/LOC/ED/NPF;^2;3^Q
 ;;^DD(440,8.3,3)
 ;;=Enter FPDS Business Type for FPDS reports for FY 1989 or later.
 ;;^DD(440,8.3,21,0)
 ;;=^^1^1^2940616^^^
 ;;^DD(440,8.3,21,1,0)
 ;;=This is the type of business for FY89 FPDS reporting purposes.
 ;;^DD(440,8.3,21,2,0)
 ;;=purposes.
 ;;^DD(440,8.3,"DT")
 ;;=2880825
 ;;^DD(440,9,0)
 ;;=TYPE OF OWNERSHIP (FY88)^440.01PA^^1;0
 ;;^DD(440,9,21,0)
 ;;=^^1^1^2940616^^
 ;;^DD(440,9,21,1,0)
 ;;=This is the type of ownership for FY88 FPDS reporting purposes.
 ;;^DD(440,10,0)
 ;;=SOCIOECONOMIC GROUP (FPDS)^440.05P^^1.1;0
 ;;^DD(440,10,21,0)
 ;;=^^2^2^2940204^^
 ;;^DD(440,10,21,1,0)
 ;;=This is the socioeconomic group of the vendor for the
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
