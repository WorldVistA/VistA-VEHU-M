PSNUPE ;BIR/DMA - UPDATE PMI INFORMATION; 16 Oct 97 / 9:27 AM [ 06/11/98  3:24 PM ]
 ;;3.18; NATIONAL DRUG FILE;**3**;12 Jan 98
 ;This is the preinstall for updating links from NDF to PMI
 ;It checks for a valid user and the proper version of ^PSPPI
 ;
 N PSNV,PSNP,PSNJ,PSNPN K XPDQUIT
 I $D(DUZ),$D(DUZ)#2,$D(^VA(200,+DUZ,0)),$D(DUZ(0)),DUZ(0)="@"
 E  D BMES^XPDUTL("You must be a valid user with DUZ(0)=""@""") S XPDQUIT=2
 I $O(^PSPPI(" "),-1)'=2515 D BMES^XPDUTL("You must load the current version of the global ^PSPPI before installing this patch") S XPDQUIT=2
 ;
 ;THE NUMBER AFTER THE '= WILL CHANGE FROM VERSION TO VERSION
 ;
 Q
