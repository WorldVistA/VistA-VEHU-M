ECINPRE ;BIR/CML,JPW-Pre Init for Event Capture ;21 Mar 96
 ;;2.0; EVENT CAPTURE ;;8 May 96
 I $D(DUZ),$D(DUZ)#2,$D(^VA(200,+DUZ,0)),$D(DUZ(0)),DUZ(0)="@" S (XQABT1,XQABT2,XQABT3)=$H Q
 W !!,"You must be a defined user with DUZ(0)=""@""",! K DIFQ Q
