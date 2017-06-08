ZZU13708 ; SEB - Environment Check and Post-Installation routines for US13708 KIDS packages
 ;;;;;;Build 20
ENV ; Environment Check / pre-processing
 S DIK="^GMR(120.8," F DA=998:1:1000 D IX2^DIK
 S DIK="^GMR(120.86," F DA=100157,100158 D IX2^DIK
 S DIK="^OR(100," F DA=39311,39312 D IX2^DIK
 Q
 ;
US13708(DEMOGIEN) ; Reindex allergies and orders for TWOHUNDREDELEVEN & TWOHUNDREDTWELVE
 S DIK="^GMR(120.8," F DA=998:1:1000 D IX^DIK
 S DIK="^GMR(120.86," F DA=100157,100158 D IX^DIK
 S DIK="^OR(100," F DA=39311,39312 D IX^DIK
 S DIE="^DPT(",DA=DEMOGIEN,DR=".111///Other Street;.114///Other City" D ^DIE
 S DIE="^DPT(",DA=DEMOGIEN,DR=".131///555-222-8235;.132///555-222-7720" D ^DIE
 Q
 ;
US13708P ; Entry point for Panorama KIDS package for US13708
 D US13708(100157)
 Q
 ;
US13708K ; Entry point for Kodak KIDS package for US13708
 D US13708(100158)
 Q
 ;
