ZZSTF00 ;PBB ; STS Text File Deployment Pre  Installation for ZZHDITFD*1.0*1; 18-NOW-2015
 ;;1.0;HEALTH DATA & INFORMATICS;****;Feb 22, 2005;Build 6
 ;;
 ;
 ;  Check files: 7118.21   7118.29   4
 ;
EN ;
 N X0,X1,X2,X3 
 ; Check if it's Test type of account: If not,.. terminate installation
 I $$PROD^XUPROD D  Q
 . D BMES^XPDUTL("It's not Testing environment - INSTALLATION ABORTED")
 . S XPDABORT=1
 ; Check if more as one entry in 7118.29 If yes terminate installation
 S X1=$O(^HDISF(7118.29,0))
 I +$O(^HDISF(7118.29,X1)) D  Q
 . D BMES^XPDUTL("More as one entry in 7118.29 -- HDIS PARAMETER FILE  - INSTALLATION ABORTED")
 . S XPDABORT=1
 ; Check if 7118.29 entry is valid pointer into 7118.21 HDIS SYSTEM FILE
 S X2=$P(^HDISF(7118.29,X1,0),"^")
 I '$D(^HDISF(7118.21,X2,0)) D  Q
 . D BMES^XPDUTL("Broken pointer from 7118.29 -- HDIS PARAMETER FILE into 7118.21 -- HDIS SYSTEM FILE  - INSTALLATION ABORTED")
 . S XPDABORT=1
 ;Set TFD as prefix of file,..  If not there.
 ;S X2=$P($G(^HDISF(7118.29,X1,6)),"^",3) S:'$L(X2) $P(^HDISF(7118.29,X1,6),"^",3)="TFD"
 ; Check if more as one entry in 7118.21 If yes terminate installation
