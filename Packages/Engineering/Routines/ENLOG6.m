ENLOG6 ;(WASH ISC)/DH ;Match Records by NXRN ;10-23-91
 ;;;;
 ;CLASS 3 SOFTWARE - Not officially supported by the ISC's
 S U="^"
 F DA=0:0 S DA=$O(^ENZ(6914.5,DA)) Q:DA'>0  D:$P(^ENZ(6914.5,DA,0),U,3)="" NXRN W:'(DA#50) "."
 K DA,ENNXRN
 Q
 ;
NXRN S ENNXRN=$P(^ENZ(6914.5,DA,0),U)
 I $D(^ENG(6914,"I",ENNXRN)) S ENNXRN(0)=$O(^ENG(6914,"I",ENNXRN,0)) S:ENNXRN(0)>0 $P(^ENZ(6914.5,DA,0),U,3)=ENNXRN(0)
 Q
 ;ENLOG6
