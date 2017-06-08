VEJDWPCE ;wpb/gbh - routine modified for dental GUI;8/2/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**13**;Aug 12, 1996
 ;PXRHS02 ;ISL/SBW - PCE Visit data extract subroutines ;8-Nov-96
GETHLOC(PXHLOC) ; Get hospital location abbreviation
 Q $P($G(^SC(+PXHLOC,0)),U,2)
