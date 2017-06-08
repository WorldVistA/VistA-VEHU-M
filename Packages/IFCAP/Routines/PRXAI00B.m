PRXAI00B ; ; 31-OCT-1994
 ;;4.0;IFCAP;**27**;9/23/93
 Q:'DIFQ(440)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(440,4.7,21,1,0)
 ;;=This is the appropriate county for the given state
 ;;^DD(440,4.7,21,2,0)
 ;;=of the vendor ordering address.
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
 ;;=Enter 'YES' if this vendor is located in a labor surplus area.
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
