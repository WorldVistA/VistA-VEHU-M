QAMIPOST ;HISC/DAD-MONITORING SYSTEM POST INIT ;7/8/93  10:06
 ;;1.0;Clinical Monitoring System;;09/13/1993
 S $P(^QA(743,0),"^",3)=0
ASKICD ; *** Load ICD Diag/Proc groups
 W !!,"Do you want to load the ICD Diagnosis/Procedure groups now"
 S %=2 D YN^DICN G:(%=-1)!(%=2) EXIT
 I '% D  G ASKICD
 . W !!?5,"Answer Y(es) to load the ICD Diagnosis and Procedure groups"
 . W !?5,"used by the JCAHO Anesthesia, Trauma, and Cardiovascular"
 . W !?5,"indicator monitors.  Answer N(o) to skip loading these"
 . W !?5,"groups.  The groups may be loaded at a later time by"
 . W !?5,"entering: DO ^QAMGRP1.  Please note, some of these"
 . W !?5,"groups are quite large, over 2000 entries."
 . Q
 D ^QAMGRP1
EXIT ;
 K %
 Q
