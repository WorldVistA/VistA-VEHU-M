EC725E4 ;BIR/JPW-Environment Check for Updates to File 725 ;3 Dec 96
 ;;2.0; EVENT CAPTURE ;**4**;8 May 96
ACCESS ;check user access
 I $D(DUZ),$D(DUZ)#2,$D(^VA(200,+DUZ,0)),$D(DUZ(0)),DUZ(0)="@" Q
 D MES^XPDUTL("You must be a defined user with DUZ(0)=""@""") S XPDQUIT=2
 Q
