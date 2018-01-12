AJK1UBTE ;580/MRL - Collections, XMIT Error Processing; 19-Nov-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This routine contains the calls necessary to process errors during
 ;and following, the actual transmission process.  
 ;
ERR(X,K) ; --- process and save errors
 ;             builds on the AJKERR array
 ;             Pass K as:  1 = first call, kill existing AJKERR
 ;                         0 = retrain whatever's in AJKERR already
 ;             Pass X as:  The error number (ET+x)
 ;
 N Y
 K:K AJKERR
 Q:'X
 S Y=$P($T(ET+X),";;",2)
 S AJKERR(+Y)=$P(Y,"^",2)
 Q
 ;
ET ; --- error text
 ;;101^Facility Name missing---check parameters
 ;;102^Client Identifier missing---check parameters
 ;;103^Vendor Identifier missing---check parameters
 ;;201^Transmission file not set up properly---contact IRM
 ;;301^Both Transmission strings invalid/missing---check strings
 ;;302^New Transmission string invalid/missing---check string
 ;;303^Status Update Transmission string invalid/missing---check string
 ;;401^Transmission Mailgroup missing or no members---check parameters
 ;;402^Update Mailgroup missing or no members---check parameters
 ;;403^Report Mailgroup missing or no members---check parameters
 ;;999^Transmission processor has been turned off---check parameters
 ;;501^No Rate Types selected for transmission---flag rate types
 ;;502^No AR Categories selected for transmission---flag categories
 ;;503^No Transaction Types selected for updates---update trans. types
