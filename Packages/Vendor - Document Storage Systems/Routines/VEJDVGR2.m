VEJDVGR2 ;DSS/DBB; VISTA GATEWAY - print templates in batch mode
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 K %ZIS S %ZIS="N" D ^%ZIS I POP W !!,*7,"UNABLE TO OPEN DEVICE, TRY AGAIN",! Q
 I IO("HOME")[IO S IO="HOME" K IOP
 S VEJDIOP=IO_";132;999999" ;D ^%ZISC
 F VEJDI=1:1 S VEJDX=$P($T(PT+VEJDI),";",3,4) Q:VEJDX'?.E1";".E  I VEJDX  D
 . U 0 W "FILE #",+VEJDX,", TEMPLATE:",$P(VEJDX,";",2),!
 . D RPT(.AXY,$P(VEJDX,";",2),+VEJDX_";;;@.01;132;999999")
 ;D ^%ZISC
 Q
RPT(AXY,PTEMP,INFO,MAXL) K AXY
 S FILEN=+INFO
 I '$D(^DD(FILEN)) S AXY(0)="FILE #"_FILEN_", DOES NOT EXIST" Q
 S SCREEN="I $P(^(0),U,4)="_FILEN
 S X=$$FIND1^DIC(.4,"","X",PTEMP,"",SCREEN,"VEJDMSG")
 S FLDS="" I 'X,PTEMP?.E1",".E,PTEMP'?.1"."1.5N.E S FLDS=PTEMP G GO
 I 'X S AXY(0)="PRINT TEMPLATE: "_PTEMP_", IN FILE #"_FILEN_", DOES NOT EXIST" Q
GO ;
 S L=0,DIC=$$ROOT^DILFD(FILEN) I FLDS="" S FLDS="["_PTEMP_"]"
 S FR=$P(INFO,";",2),TO=$P(INFO,";",3)
 S BY=$P(INFO,";",4) I BY="" S BY="@.01"
 I $E(BY)'="@",BY?.E1.N.1",".E S BY="@"_BY
 S DHD="",(VPG,IOSL)=999999
 I $D(VEJDIOP) S IOP=VEJDIOP,%ZIS("HFSMODE")="A"
 D EN1^DIP K IOP S %ZIS("HFSMODE")="A"
PT ;;file number;print template
 ;;42;VEJDVG WARDLOC
 ;;44;VEJDVG LOCATION
 ;;49;VEJDVG SERVICE
 ;;50.7;VEJDVG PHARMORD
 ;;51.1;VEJDVG MEDSCHED
 ;;51.2;VEJDVG MEDRT
 ;;60;VEJDVG LAB
 ;;61.2;VEJDVG ETIOLOGY
 ;;62;VEJDVG LAB COLLECTION
 ;;62.06;VEJDVG ANTIBIOTICS
 ;;57;VEJDVG ALLERGY
 ;;80;VEJDVG DIAGNOSIS
 ;;71;VEJDVG RADORD
 ;;101.43;VEJDVG ORDERABLE ITEMS
 ;;200;VEJDVG PROVIDER
 ;;6910.3;VEJDVG DIVISION
