ZZSTFD01 ;HRN/ART ; STS Text File Deployment -Post install; 19-SEP-2008
 ;;1.0;HEALTH DATA & INFORMATICS;****;Feb 22, 2005;Build 6
 ;;
 ;
 Q
 ;
POS ; Check, if Immunization file definitions are present.
 N I
 F I=920,920.1,920.2,920.3,920.4,920.5 I '$D(^DD(I)) D BMES^XPDUTL("File Definition of ",I," file missing - INSTALLATION ABORTED") S XPDABORT=1
 Q:$G(XPDABORT)
 Q
