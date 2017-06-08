ADXTTMP ;523/KC test indexer ;22-feb-1993
 ;;1.0;;
PATINDX(ADXTDA,ADXTPID) ; create prm. index of entries
 K DA,DR,DIC,DD,D0
 S X=ADXTDA,DIC="^DIZ(523701.5,",DIC(0)="AEQMLZ"
 S DIC("DR")="1///"_ADXTPID
 D FILE^DICN
 I '+Y D
 .W !,$C(7),"Error creating permanent index..."
 Q +Y
