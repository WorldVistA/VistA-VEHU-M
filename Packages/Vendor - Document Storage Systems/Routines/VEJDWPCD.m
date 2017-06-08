VEJDWPCD ;wpb/gbh - routine modified for dental GUI;8/2/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 ;PXRHS01 ; SLC/SBW - PCE Visit data extract main routine ;6/7/96
 ; Extract returns visit data with associated ICD-9, CPT, and
 ; Provider data.
 ;
HSDATE() ; $$() -> switch date
 Q $P(^PX(815,1,0),U,3)
