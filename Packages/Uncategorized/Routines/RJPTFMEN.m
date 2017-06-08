RJPTFMEN ;RJ WILM DE -PTF MENU; 12-12-85
 ;;4.0
 D:'$D(DUZ) DT^DICRW S DIK="^DOPT(""RJPTF""," G D:$D(^DOPT("RJPTF",1)) S ^(0)="Wilmington PTF Option^1N^" F I=1:1 S X=$E($T(D+I),3,99) Q:X=""  S ^DOPT("RJPTF",I,0)=X
 D IXALL^DIK
D D 1 W !!! S:'$D(DTIME) DTIME=300 S DIC=DIK,DIC(0)="AEQZ" D ^DIC K DIC,DIK Q:Y<0  S X=$P(Y(0),U,3,99),Z=$P(Y(0),U,2) K Y X Z D @X W !! G RJPTFMEN
 ;Archive PTF Data^^^RJPTFARN
 ;Austin Acceptance^^^RJPTFAA
 ;Austin EAL Error^^^RJPTFEAL
 ;Check CENSUS Patient Records^^^RJPTFCP
 ;Check PTF file for missing data^^^RJPTFXXX
 ;Create CENSUS Code Sheets^S RJSTORE=1^^RJPTFCP
 ;Create Code Sheets^S RJSTORE=1^^RJPTFXXX
 ;DRG Calculator^^^RJPTFDRG
 ;Enter/Edit Patient File^^^RJPTFPT1
 ;Enter/Edit PTF File^^^RJPTFPTF
 ;Find PTF Number^S A=""^^RJPTFNUM
 ;List CHECKED but UNCLOSED Patients^^^RJPTFL1
 ;List Patients not run through Checker^^^RJPTFL2
 ;List Patients RELEASED to AUSTIN^^^RJPTFL3
 ;Listing of CLOSED but UNRELEASED Patients^^^RJPTFL4
 ;Listing of CLOSED but UNRELEASED Patients (Not Discharge Date Order)^^^RJPTFL6
 ;List PTF Patients by Number^^^RJPTFLIS
 ;Manager's Stats^^^RJPTFMGR
 ;Mark Census Record^^^RJPTFCE
 ;Output DRG Funding^^^RJPTFOUT
 ;Output Record Statistics^^^RJPTFGL1
 ;Output Status of PTF Patients^^^RJPTFRA1
 ;Print Code Sheet^^^RJPTFXMP
 ;RAM Report^^^RJPTFRAM
 ;Site Specific Variables^^^RJPTFVAR
 ;Single Patient Status^^^RJPTFSPS
 ;State and County Statistics^^^RJPTFSC
 ;Statistical Count of Record Status^^^RJPTFCNT
 ;Status of Checked Patients^^^RJPTFL5
 ;Transmit PTF data by MCTS^^^RJPTFXMT
 ;Who Coded a Record^^^RJPTFCL
 ;
1 W !,?25,"W I L M I N G T O N   P T F   M E N U" S V=$E($T(RJPTFMEN+1),4,99) Q:V=""  W !!,?35,"Version: ",V Q
