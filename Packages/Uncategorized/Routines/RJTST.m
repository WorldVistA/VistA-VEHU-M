RJTST ;
 S X=DUZ,DIC(0)="",DIC="^RJT1(" D FILE^DICN
 B
 S $P(^RJT1(DA,0),"^",2)=$P(GMRPDFN,"^",2),$P(^RJT1(DA,0),"^",3)=DT
 Q
