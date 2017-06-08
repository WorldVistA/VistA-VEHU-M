ZZSTF01 ;PBB ; STS Text File Deployment Post Installation for ZZHDITFD*1.0*1; 18-NOW-2015
 ;;1.0;HEALTH DATA & INFORMATICS;****;Feb 22, 2005;Build 6
 ;;
 ;
 ;  Check files: 7118.21   7118.29   4
 ;
EN ;
 N X0,X1,X2,X3
 ;Set TFD as prefix of file,..  If not there.
 S X1=$O(^HDISF(7118.29,0))
 S X2=$P($G(^HDISF(7118.29,X1,6)),"^",3) S:'$L(X2) $P(^HDISF(7118.29,X1,6),"^",3)="TFD"
 ; Check if more as one entry in 7118.21 If yes terminate installation
