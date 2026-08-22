SR224UTL ;HDSO/DSK - YEARLY CPT EXCLUSION UPDATES; Apr 13, 2026@16:31
 ;;3.0;Surgery;**224**;24 Jun 93;Build 2
 ;
ENV ;
 S SRBACKUP="SR"_$E($T(+1),3,5)_" PRE INSTALL BACKUP"
 I $D(^XTMP(SRBACKUP)) D
 . ;Field test sites will already have a backup, so they can continue the install.
 . N DIR,DTOUT,DUOUT,Y
 . S DIR(0)="YN",DIR("B")="NO"
 . S DIR("A",1)="Backup of the CPT EXCLUSIONS (#137) file has already occurred."
 . S DIR("A",2)="If this site was a field test site for patch SR*3.0*220,"
 . S DIR("A",3)="patch installation may proceed."
 . S DIR("A")="Was this site a field test site"
 . D ^DIR
 . I $D(DUOUT)!($D(DTOUT))!('Y) D
 . . S XPDABORT=1
 . . D BMES^XPDUTL($$CJ^XLFSTR("Submit a ServiceNow ticket for assistance.",80))
 . . K ^XTMP(SRBACKUP,1)
 Q
 ;
PRE ;
 N SRBACKUP
 S SRBACKUP="SR"_$E($T(+1),3,5)_" PRE INSTALL BACKUP"
 ;Do not back up again if field test site already backed the file up.
 I $D(^XTMP(SRBACKUP,1)) D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("Backup of CPT EXCLUSIONS (#137) file not needed",80))
 . D BMES^XPDUTL($$CJ^XLFSTR("if backup was already performed and this is a field test site.",80))
 S ^XTMP(SRBACKUP,0)=$$FMADD^XLFDT(DT,120)_"^"_$G(DT)_"^Backup of file 137 before update"
 D BMES^XPDUTL($$CJ^XLFSTR("Backing up the CPT EXCLUSIONS file (#137) to ^XTMP("""_SRBACKUP_""")",80))
 M ^XTMP(SRBACKUP,137)=^SRO(137) S ^XTMP(SRBACKUP,1)=DT
 D BMES^XPDUTL($$CJ^XLFSTR("Backup complete.",80))
 Q
 ;
POST ; -- post-install process
 N SRI,SRJ,SRLIST,SRX,SRY,DA,X
 F SRJ=1:1 S SRLIST=$P($T(ADDS+SRJ)," ;;",2) Q:SRLIST=""  D
 . F SRI=1:1 S SRX=$P(SRLIST,",",SRI) Q:SRX=""  I $D(^ICPT("B",SRX)) D
 . . S SRY=$O(^ICPT("B",SRX,0)) Q:SRY=""
 . . ;Do not add if code is already in the file.
 . . I '$D(^SRO(137,SRY)) D
 . . . K DA,DIC,DD,DO,DINUM S (DINUM,X)=SRY
 . . . S DIC="^SRO(137,",DIC(0)="L" D FILE^DICN
 D BMES^XPDUTL($$CJ^XLFSTR("  Update of CPT EXCLUSIONS (#137) file completed.",80))
 Q
 ;
BACK ; -- rollback
 N SRBACKUP
 S SRBACKUP="SR"_$E($T(+1),3,5)_" PRE INSTALL BACKUP"
 I '$D(^XTMP(SRBACKUP)) D  Q
 . W !,"Backup file has not been set yet or was set and was deleted after six months."
 I '$D(^SRO(137,0))#2 D  Q
 . W !,"File #137 hasn't been set up yet, so no data to delete."
 W !,"Restoring file 137 from the backup..."
 K ^SRO(137)
 S ^SRO(137,0)="CPT EXCLUSIONS^137P^^0"
 M ^SRO(137)=^XTMP(SRBACKUP,137)
 ;Kill the backup in case the patch needs to be installed again.
 K ^XTMP(SRBACKUP)
 W !!,"Rollback completed."
 Q
 ;
ADDS ;
 ;;0948T,0949T,0950T,0961T,0962T,0963T,0964T,0965T,0966T,0967T
 ;;0972T,0973T,0974T,0975T,0976T,0977T,0981T,0982T,0983T,0984T
 ;;0986T,0988T,0989T,0990T,0991T,0992T,0993T,0996T,0997T,0998T
 ;;0999T,1000T,1001T,1002T,1003T,1004T,1005T,1006T,1007T,1008T
 ;;1009T,1010T,1011T,1012T,1016T,1017T,1018T,1020T,1021T,1022T
 ;;1023T,1024T,1025T,47384,52443,55707,55708,55709,55710,55711
 ;;55712,55713,55714,55715,55877,64567,64654,64655,64656,64657
 ;;64658,64659,64728,70471,70472,70473,75577,77436,77437,77438
 ;;77439,81354,81524,87182,87183,87494,87627,87812,90382,90481
 ;;90482,90483,90484,90593,90612,90613,90631,90635,91124,91125
 ;;91323,92288,92628,92629,92631,92632,92634,92635,92636,92637
 ;;92638,92639,92641,92642,92930,92945,93145,93146,97007,97008
 ;;97009,98979,98984,98985,98986,99445,99470
 Q
 ;
