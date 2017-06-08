ANRVIENV ;HCIOFO/NDH - Environment check routine April 17, 1998
 ;;4.0; Visual Impairment Service Team ;**2**;12 JUN 98
START ; Check for existence of VIST PARAMETERS file
 I $O(^ANRV(2041,0))<1  D  Q
 .S X="WARNING! - There is no entry in the VIST PARAMETERS FILE"
 .D BMES^XPDUTL(X)
 .S X="ABORTING Installation.  The Transport Global will remain."
 .D BMES^XPDUTL(X)
 .S XPDQUIT=2
 Q
