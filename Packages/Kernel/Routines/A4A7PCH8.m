A4A7PCH8 ;sfisc/rwf - New Person Patch ;1/18/95  16:24
 ;;1.01;NEW PERSON;**8**;OCT 25, 1994
 W !,"This Patch will add 'Title' as an Identifier, It also updates the",!,"Phone fields in the New Person file."
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 F DA=.131:.001:.138 S DA(1)=200,DIK="^DD(200,",DIK(1)=.01 D EN^DIK
 I $P($G(^VA(200,0)),"^",2)'["I" S $P(^VA(200,0),"^",2)="200I"
 W !,"Done"
Q Q
 ;;^DD(200,0,"ID","W8")
 ;;S %I=Y,Y=$S('$D(^(0)):"",$D(^DIC(3.1,+$P(^(0),U,9),0))#2:$P(^(0),U,1),1:""),C=$P(^DD(3.1,.01,0),U,2) D Y^DIQ:Y]"" W "   ",Y,@("$E("_DIC_"%I,0),0)") S Y=%I K %I
 ;;^DD(200,.131,0)
 ;;=PHONE (HOME)^F^^.13;1^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>20!($L(X)<4)!'(X?4.20NP) X
 ;;^DD(200,.131,3)
 ;;=Answer must be 4-20 characters in length.
 ;;^DD(200,.131,21,0)
 ;;=^^1^1^2920513^^^
 ;;^DD(200,.131,21,1,0)
 ;;=This is the telephone number for the new person.
 ;;^DD(200,.131,"DT")
 ;;=2941024
 ;;^DD(200,.132,0)
 ;;=OFFICE PHONE^F^^.13;2^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>20!($L(X)<4)!'(X?4.20NP) X
 ;;^DD(200,.132,3)
 ;;=Answer must be 4-20 characters in length.
 ;;^DD(200,.132,21,0)
 ;;=1^^1^1^2920513^
 ;;^DD(200,.132,21,1,0)
 ;;=This is the business/office telephone for the new person.
 ;;^DD(200,.132,"DT")
 ;;=2941024
 ;;^DD(200,.133,0)
 ;;=PHONE #3^F^^.13;3^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>20!($L(X)<4)!'(X?4.20NP) X
 ;;^DD(200,.133,3)
 ;;=Answer must be 4-20 characters in length.
 ;;^DD(200,.133,21,0)
 ;;=^^2^2^2920513^^
 ;;^DD(200,.133,21,1,0)
 ;;=This is an alternate telephone number where the new person might also
 ;;^DD(200,.133,21,2,0)
 ;;=be reached.
 ;;^DD(200,.133,"DT")
 ;;=2941024
 ;;^DD(200,.134,0)
 ;;=PHONE #4^F^^.13;4^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>20!($L(X)<4)!'(X?4.20NP) X
 ;;^DD(200,.134,3)
 ;;=Answer must be 4-20 characters in length.
 ;;^DD(200,.134,21,0)
 ;;=^^2^2^2920513^^
 ;;^DD(200,.134,21,1,0)
 ;;=This is another alternate telephone number where the new person might
 ;;^DD(200,.134,21,2,0)
 ;;=also be reached.
 ;;^DD(200,.134,"DT")
 ;;=2941024
 ;;^DD(200,.135,0)
 ;;=COMMERCIAL PHONE^F^^.13;5^K:$L(X)>20!($L(X)<4)!'(X?4.20NP) X
 ;;^DD(200,.135,3)
 ;;=Answer must be 4-20 characters in length.
 ;;^DD(200,.135,21,0)
 ;;=^^1^1^2941021^
 ;;^DD(200,.135,21,1,0)
 ;;=This is a commercial phone number used by IFCAP.
 ;;^DD(200,.135,"DT")
 ;;=2941024
 ;;^DD(200,.136,0)
 ;;=FAX NUMBER^F^^.13;6^K:$L(X)>15!($L(X)<7) X
 ;;^DD(200,.136,3)
 ;;=Enter the persons FAX phone number.
 ;;^DD(200,.136,21,0)
 ;;=^^3^3^2941024^
 ;;^DD(200,.136,21,1,0)
 ;;=This field holds a phone number for a FAX machine for this user.
 ;;^DD(200,.136,21,2,0)
 ;;=It needs to be a format that can be understood by a sending 
 ;;^DD(200,.136,21,3,0)
 ;;=MODEM.
 ;;^DD(200,.136,"DT")
 ;;=2940121
 ;;^DD(200,.137,0)
 ;;=ANALOG PAGER^F^^.13;7^K:$L(X)>20!($L(X)<4)!'(X?4.20NP) X
 ;;^DD(200,.137,3)
 ;;=Answer must be 4-20 characters in length.
 ;;^DD(200,.137,21,0)
 ;;=^^4^4^2941024^
 ;;^DD(200,.137,21,1,0)
 ;;=This field holds a phone number for an ANALOG PAGER that this person
 ;;^DD(200,.137,21,2,0)
 ;;=carries with them.
 ;;^DD(200,.137,21,3,0)
 ;;=It needs to be a format that can be understood by a sending 
 ;;^DD(200,.137,21,4,0)
 ;;=MODEM.
 ;;^DD(200,.137,"DT")
 ;;=2941024
 ;;^DD(200,.138,0)
 ;;=DIGITAL PAGER^F^^.13;8^K:$L(X)>20!($L(X)<4)!'(X?4.20NP) X
 ;;^DD(200,.138,3)
 ;;=Answer must be 4-20 characters in length.
 ;;^DD(200,.138,21,0)
 ;;=^^4^4^2941024^
 ;;^DD(200,.138,21,1,0)
 ;;=This field holds a phone number for a DIGITAL PAGER that this person
 ;;^DD(200,.138,21,2,0)
 ;;=carries with them.
 ;;^DD(200,.138,21,3,0)
 ;;=It needs to be a format that can be understood by a sending 
 ;;^DD(200,.138,21,4,0)
 ;;=MODEM.
 ;;^DD(200,.138,"DT")
 ;;=2941024
