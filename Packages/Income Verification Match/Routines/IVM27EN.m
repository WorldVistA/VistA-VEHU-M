IVM27EN ;ALB/SEK - Environment check for IVM*2.0*7 ; 8-SEP-97
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;**7**; 21-OCT-94
 ;
 ; This enviroment check routine will ensure that IVM*2.0*6 has
 ; been installed prior to installation of this patch.
 ; It will abort if IVM*2.0*6 hasn't been installed.
 ;
EN ; begin processing
 I '$$PATCH^XPDUTL("IVM*2.0*6") W !!,">>> Patch IVM*2.0*6 must be installed first!",!!,">>> Installation aborted." S XPDQUIT=2 Q
 W !!,"IVM*2.0*6 found..."
 I XPDENV W "continuing with installation"
 Q
