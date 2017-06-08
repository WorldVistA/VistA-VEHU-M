AHJZABAC ;557/THM-RUN AUTOMATIC BACKUP TO SHADOW SERVERS [ 10/10/95  5:06 PM ]
 ;;1.0;;
 ;
 W !!,*7,"Can only be run by TaskMan !! ",!!,*7 Q  ;enter properly
 ;
EN I '$D(DT) S X="T" D ^%DT S DT=Y
 S X=DT D DW^%DTC S TODAY=X I TODAY="SATURDAY"!(TODAY="SUNDAY") G EXIT
 ;I ^%ZOSF("VOL")'="PSA" Q  ;only run from PSA or other print server
 ;F X="SSA","SSB","SSC" J AUTO^SSD["MGR",X]::10
 K ^["MGR","SMA"]%ZTSCH("WAIT"),^("RUN") S ^("STOP")=""
 K ^["MGR","SMB"]%ZTSCH("WAIT"),^("RUN") S ^("STOP")=""
 H 60
 J AUTO^SSD["MGR","SMZ"]::10
EXIT K X,TODAY Q
 ;
DOC ;This program will not backup on Sundays unless modified at line
 ; EN+1, which can be commented out.
 ;It will not run from any compute server but PSA or where ever the
 ; TaskManager runs.
 ;It will only backup shadow servers SSA, SSB, and SSC as currently
 ; written.  Modify line EN+3 to add other shadow servers.
 ;Your SSD program must be the current one which has the AUTO line tag.
