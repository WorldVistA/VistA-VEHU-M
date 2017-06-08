ECX3P7P1 ;ALB/JAP - National Clinic Update ;May 6, 1998
 ;;3.0;DSS EXTRACTS;**7**;Dec 22, 1997
 ;
ADD ;** Add National Clinic codes
 ;ECXX is in format: CODE^SHORT DESCRIPTION
 N ECX,ECXX,COUNT,DIC,DA,DIK,X,Y,DIR,DIRUT,JJ,SS,DUOUT
 S COUNT=0
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Adding new National Clinic codes to NATIONAL CLINIC File (#728.441)...")
 D MES^XPDUTL(" ")
 F ECX=1:1 S ECXX=$P($T(NEW+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECXDA=ECXDA+1
 .S ^ECX(728.441,ECXDA,0)=ECXX
 .S DA=ECXDA,DIK(1)=".01",DIK="^ECX(728.441,"
 .D EN^DIK,MESS
 .S $P(^ECX(728.441,0),"^",4)=$P(^ECX(728.441,0),"^",4)+1
 .S COUNT=COUNT+1
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Done... "_COUNT_" new entries added to NATIONAL CLINIC File (#728.441).")
 D MES^XPDUTL(" ")
 S $P(^ECX(728.441,0),U,3)=ECXDA
 Q
 ;
MESS ;** Add message
 N ECXADMSG
 S ECXADMSG=" "_$P(ECXX,"^",1)_" - "_$P(ECXX,"^",2)
 D MES^XPDUTL(ECXADMSG)
 S ECXADMSG="     added as record #"_ECXDA_"."
 D MES^XPDUTL(ECXADMSG)
 D MES^XPDUTL(" ")
 Q
 ;
CLEAN ;** Delete any new entries added -- backout patch ECX*3.0*7
 ;
 N ECX,ECXX,ECXDA,COUNT,DIC,DA,DIK,X,Y,DIR,JJ,SS,DIRUT,DUOUT
 S COUNT=0
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" This subroutine will delete only those entries in file #728.441,")
 D MES^XPDUTL(" NATIONAL CLINIC File, which were added by patch ECX*3.0*7.")
 D MES^XPDUTL(" ")
 I $E(IOST)="C" D  Q:'Y
 .S SS=22-$Y F JJ=1:1:SS W !
 .K X,Y
 .S DIR(0)="E" W ! D ^DIR K DIR
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Deleting...")
 D MES^XPDUTL(" ")
 ;
 F ECX=1:1 S ECXX=$P($T(NEW+ECX),";;",2) Q:ECXX="QUIT"  D
 .S DIC="^ECX(728.441,",DIC(0)="X",X=$P(ECXX,"^",1) D ^DIC
 .I +Y>112 D
 ..S DIK=DIC,DA=+Y D ^DIK S COUNT=COUNT+1
 ..D MES^XPDUTL(" Entry #"_DA_" deleted...") K Y
 S JJ=$O(^ECX(728.441,999),-1),$P(^ECX(728.441,0),U,3)=JJ
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Done... "_COUNT_" entries deleted from NATIONAL CLINIC File (#728.441).")
 D MES^XPDUTL(" ")
 Q
 ;
NEW ;National Clinic codes to add;;CODE^SHORT DESCRIPTION
 ;;AAAA^General Purpose 1 - assign own use
 ;;BBBB^General Purpose 2 - assign own use
 ;;XXXX^General Purpose 3 - assign own use
 ;;YYYY^General Purpose 4 - assign own use
 ;;IACT^Feeder key inactive before start of current year
 ;;MDPA^Physician Assistant
 ;;NONC^Noncount for DSS (usually point to Stats;AC6)
 ;;OPTC^Ophthalmology Technician
 ;;PHRM^Clinical Pharmacy
 ;;RECR^Recreation Therapy
 ;;KTIN^KT Individual
 ;;KTGR^KT Group
 ;;MATI^MAT Individual
 ;;MATG^MAT Group
 ;;OTIN^OT Individual
 ;;OTGR^OT Group
 ;;PTIN^PT Individual
 ;;PTGR^PT Group
 ;;SATP^Substance Abuse Treatment Program
 ;;STAT^Point to Statistics in DSS
 ;;XREC^Feeder key to create more complete encounter
 ;;ZZZZ^No Longer Active
 ;;IOTH^I Other
 ;;JOTH^J Other
 ;;KOTH^K Other
 ;;LOTH^L Other
 ;;MOTH^M Other
 ;;NOTH^N Other
 ;;OOTH^O Other
 ;;POTH^P Other
 ;;QOTH^Q Other
 ;;ROTH^R Other
 ;;SOTH^S Other
 ;;TOTH^T Other
 ;;UOTH^U Other
 ;;VOTH^V Other
 ;;WOTH^W Other
 ;;XOTH^X Other
 ;;YOTH^Y Other
 ;;ZOTH^Z Other
 ;;ITEM^I Team
 ;;JTEM^J Team
 ;;KTEM^K Team
 ;;LTEM^L Team
 ;;MTEM^M Team
 ;;NTEM^N Team
 ;;OTEM^O Team
 ;;PTEM^P Team
 ;;QTEM^Q Team
 ;;RTEM^R Team
 ;;STEM^S Team
 ;;TTEM^T Team
 ;;UTEM^U Team
 ;;VTEM^V Team
 ;;WTEM^W Team
 ;;XTEM^X Team
 ;;YTEM^Y Team
 ;;ZTEM^Z Team
 ;;APRI^A Primary Care
 ;;BPRI^B Primary Care
 ;;CPRI^C Primary Care
 ;;DPRI^D Primary Care
 ;;EPRI^E Primary Care
 ;;FPRI^F Primary Care
 ;;GPRI^G Primary Care
 ;;HPRI^H Primary Care
 ;;IPRI^I Primary Care
 ;;JPRI^J Primary Care
 ;;KPRI^K Primary Care
 ;;LPRI^L Primary Care
 ;;MPRI^M Primary Care
 ;;NPRI^N Primary Care
 ;;OPRI^O Primary Care
 ;;PPRI^P Primary Care
 ;;QPRI^Q Primary Care
 ;;RPRI^R Primary Care
 ;;SPRI^S Primary Care
 ;;TPRI^T Primary Care
 ;;UPRI^U Primary Care
 ;;VPRI^V Primary Care
 ;;WPRI^W Primary Care
 ;;XPRI^X Primary Care
 ;;YPRI^Y Primary Care
 ;;ZPRI^Z Primary Care
 ;;ASAT^Satellite A
 ;;BSAT^Satellite B
 ;;CSAT^Satellite C
 ;;DSAT^Satellite D
 ;;ESAT^Satellite E
 ;;FSAT^Satellite F
 ;;GSAT^Satellite G
 ;;HSAT^Satellite H
 ;;ISAT^Satellite I
 ;;JSAT^Satellite J
 ;;KSAT^Satellite K
 ;;LSAT^Satellite L
 ;;MSAT^Satellite M
 ;;NSAT^Satellite N
 ;;OSAT^Satellite O
 ;;PSAT^Satellite P
 ;;QSAT^Satellite Q
 ;;RSAT^Satellite R
 ;;SSAT^Satellite S
 ;;TSAT^Satellite T
 ;;USAT^Satellite U
 ;;VSAT^Satellite V
 ;;WSAT^Satellite W
 ;;XSAT^Satellite X
 ;;YSAT^Satellite Y
 ;;ZSAT^Satellite Z
 ;;ACBC^CBC A
 ;;BCBC^CBC B
 ;;CCBC^CBC C
 ;;DCBC^CBC D
 ;;ECBC^CBC E
 ;;FCBC^CBC F
 ;;GCBC^CBC G
 ;;HCBC^CBC H
 ;;ANUR^RN managed clinic A
 ;;BNUR^RN managed clinic B
 ;;CNUR^RN managed clinic C
 ;;DNUR^RN managed clinic D
 ;;ENUR^RN managed clinic E
 ;;FNUR^RN managed clinic F
 ;;GNUR^RN managed clinic G
 ;;HNUR^RN managed clinic H
 ;;ACPX^C & P clinic profile A
 ;;BCPX^C & P clinic profile B
 ;;CCPX^C & P clinic profile C
 ;;DCPX^C & P clinic profile D
 ;;ECPX^C & P clinic profile E
 ;;FCPX^C & P clinic profile F
 ;;GCPX^C & P clinic profile G
 ;;HCPX^C & P clinic profile H
 ;;ARED^Red Team A
 ;;BRED^Red Team B
 ;;CRED^Red Team C
 ;;DRED^Red Team D
 ;;ERED^Red Team E
 ;;FRED^Red Team F
 ;;GRED^Red Team G
 ;;HRED^Red Team H
 ;;ABLU^Blue Team A
 ;;BBLU^Blue Team B
 ;;CBLU^Blue Team C
 ;;DBLU^Blue Team D
 ;;EBLU^Blue Team E
 ;;FBLU^Blue Team F
 ;;GBLU^Blue Team G
 ;;HBLU^Blue Team H
 ;;AYEL^Yellow Team A
 ;;BYEL^Yellow Team B
 ;;CYEL^Yellow Team C
 ;;DYEL^Yellow Team D
 ;;EYEL^Yellow Team E
 ;;FYEL^Yellow Team F
 ;;GYEL^Yellow Team G
 ;;HYEL^Yellow Team H
 ;;QUIT
