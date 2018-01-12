CUAA ;RJ WILMINGTON DE & LM COLUMBIA SC-MICOM LOADER MENU; 6-9-85
 ;Version 3.6
 S:'$D(DUZ(0)) DUZ(0)="#" S DIK="^DOPT(""CUAA""," G D:$D(^DOPT("CUAA",1)) S ^(0)="Micom Option^1N^" F I=1:1 S X=$E($T(D+I),3,99) Q:X=""  S ^DOPT("CUAA",I,0)=X
 D IXALL^DIK
D S:'$D(DTIME) DTIME=300 S DIC=DIK,DIC(0)="AEQZ" D ^DIC K DIC,DIK Q:Y<0  S X=$P(Y(0),U,2,99) K Y D @X W !! G CUAA
 ;Auto Load Micom^^CUAAUTO
 ;Dialogue Mode^^CUAADIAL
 ;Enter/Edit Auto Load File^^CUAAEDIT
 ;Enter/Edit Contention Devices^^CUAADEV
 ;List Micom's Time and Date^^CUAADATE
 ;Load Micom with CPU Date and Time^^CUAALDDT
 ;Print Contention Devices^^CUAAP
 ;Transparent Mode^^CUAATRAN
 ;Verify/Reset Micom Command Port^^CUAAVR
 ;
