SR80ENV ;BIR/ADM - Environment Check for SR*3*80 ; [ 07/14/98  12:50 PM ]
 ;;3.0; Surgery ;**80**;24 Jun 93
 ;environmental check for SR*3*80 to confirm that SR*3*41 is installed
 I '$$PATCH^XPDUTL("SR*3.0*41") D BMES^XPDUTL("Patch SR*3*41 must be installed before installing this patch!") S XPDQUIT=2
 Q
