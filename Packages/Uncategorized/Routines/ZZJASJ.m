ZZJASJ ;isa\jas        routine to capture job totals
 F J=1:1:8 S ^ZZJASJ(J)=0 D
 . F I=1:1:60 X ^%ZOSF("ACTJ") S ^ZZJASJ(J)=^ZZJASJ(J)+Y H 60
 Q
OUTPUT ;
 S XMSUB="Average Number of Jobs"
 S XMY("Jerry.Sicard@med.va.gov")=""
 D NOW^%DTC S Y=X D DD^%DT
 S XMTEXT(1)="  Average Number of Job Per Hour on "_Y_" at "_$P(^DIC(4.2,$P(^XTV(8989.3,1,0),"^",1),0),"^",1)
 S XMTEXT(2)=""
 S XMTEXT(3)=""
 S XMTEXT(4)="  08:00 to 09:00           "_(^ZZJASJ(1)\60)
 S XMTEXT(5)="  09:00 to 10:00           "_(^ZZJASJ(2)\60)
 S XMTEXT(6)="  10:00 to 11:00           "_(^ZZJASJ(3)\60)
 S XMTEXT(7)="  11:00 to 12:00           "_(^ZZJASJ(4)\60)
 S XMTEXT(8)="  12:00 to 13:00           "_(^ZZJASJ(5)\60)
 S XMTEXT(9)="  13:00 to 14:00           "_(^ZZJASJ(6)\60)
 S XMTEXT(10)="  14:00 to 15:00           "_(^ZZJASJ(7)\60)
 S XMTEXT(11)="  15:00 to 16:00           "_(^ZZJASJ(8)\60)
 S XMTEXT="XMTEXT("
 S XMCHAN=1
 D ^XMD
 Q
  
  
