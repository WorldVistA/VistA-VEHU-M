ADXTADI1 ;523/KC set up variables from MRS diagnosis;10-aug-1992
 ;;1.1;;
EN ;
 ; INPUT VARIABLES: ADXTX1,ADXTX2 (NODES 1 + 2 IN TMP)
 ; OUTPUT VARIABLES: ADXT(), WITH VAR'S STORED AT SUBSCRIPT LEVELS
 ;
 N ADXTCNT,ADXTNOD,ADXTVAR,ADXTSTA,ADXTEND,ADXTI,X
 K ADXT
 F ADXTI=1:1 S X=$P($TEXT(VAR+ADXTI),";;",2) Q:X=""  D
 .S ADXTNOD=$P(X,"^",2)
 .S ADXTVAR=$P(X,"^",3)
 .S ADXTSTA=$P(X,"^",4)
 .S ADXTEND=$P(X,"^",5)
 .I ADXTNOD=1 S ADXT(ADXTVAR)=$E(ADXTX1,ADXTSTA,ADXTEND)
 .I ADXTNOD=2 S ADXT(ADXTVAR)=$E(ADXTX2,ADXTSTA-221,ADXTEND-221)
MAINE ;
 I $G(ADXTGTST)="ME" D
 .S ADXT("DCMM")=$E(ADXTX2,156,233),ADXT("XDTOR")=$E(ADXTX2,141,155)
CT ;
 I $G(ADXTGTST)="CT" D
 .S ADXT("DCMM")=$E(ADXTX2,153,230)
 .S ADXTCNT=0
 .F ADXTI="XDDGVN","XDISTP","XDCHXRY","XDALPH","XDCTSCN","XDBNSCN","XDENDSC","XDGIXRY","XDULSND","XDOTHS","XDESTRC","XDPRORC" D
 ..S ADXTCNT=ADXTCNT+1
 ..S ADXT(ADXTI)=$E(ADXTX2,(140+ADXTCNT))
EXIT ;
 K ADXTCNT,ADXTNOD,ADXTVAR,ADXTSTA,ADXTEND,ADXTI,X
 Q
 ;
 ; Pieces of $TEXT description:
 ; ============================
 ; 1: MRS source file
 ; 2: ^TMP subscript level stored at
 ; 3: MRS field name
 ; 4: MRS offset of start of field
 ; 5: MRS offset of end of field
VAR ;
 ;;Diagnosis^1^PID^1^7^
 ;;Diagnosis^1^DTOP^8^11^
 ;;Diagnosis^1^DSQ^12^13^
 ;;Diagnosis^1^DGR^14^14^
 ;;Diagnosis^1^DMOR^15^19^
 ;;Diagnosis^1^DACSYY^20^21^
 ;;Diagnosis^1^DSTT^22^23^
 ;;Diagnosis^1^DZP1^24^28^
 ;;Diagnosis^1^DCNT^29^31^
 ;;Diagnosis^1^DCSS^32^37^
 ;;Diagnosis^1^DCSST^38^38^
 ;;Diagnosis^1^DID^39^46^
 ;;Diagnosis^1^DAMN^47^54^
 ;;Diagnosis^1^DFT^55^62^
 ;;Diagnosis^1^DDIS^63^70^
 ;;Diagnosis^1^DNF^71^78^
 ;;Diagnosis^1^DLF^79^86^
 ;;Diagnosis^1^DGS^87^87^
 ;;Diagnosis^1^DAJCB^88^88^
 ;;Diagnosis^1^DAJCT^89^91^
 ;;Diagnosis^1^DAJCN^92^94^
 ;;Diagnosis^1^DAJCM^95^96^
 ;;Diagnosis^1^DAJCS^97^99^
 ;;Diagnosis^1^DCNFRM^100^100^
 ;;Diagnosis^1^DCLS^101^101^
 ;;Diagnosis^1^DPRORG^102^102^
 ;;Diagnosis^1^DST1^103^103^
 ;;Diagnosis^1^DST2^104^104^
 ;;Diagnosis^1^DST3^105^105^
 ;;Diagnosis^1^DRSN^106^106^
 ;;Diagnosis^1^DSR1^107^108^
 ;;Diagnosis^1^DSR1D^109^116^
 ;;Diagnosis^1^DSR2^117^118^
 ;;Diagnosis^1^DSR2D^119^126^
 ;;Diagnosis^1^DBCN^128^128^
 ;;Diagnosis^1^DSQN^129^129^
 ;;Diagnosis^1^DRD1^131^131^
 ;;Diagnosis^1^DRD1D^132^139^
 ;;Diagnosis^1^DRD2^141^141^
 ;;Diagnosis^1^DRD2D^142^149^
 ;;Diagnosis^1^DCH^151^151^
 ;;Diagnosis^1^DCHD^152^159^
 ;;Diagnosis^1^DHM^161^161^
 ;;Diagnosis^1^DHMD^162^169^
 ;;Diagnosis^1^DBR^171^171^
 ;;Diagnosis^1^DBRD^172^179^
 ;;Diagnosis^1^DOT^181^181^
 ;;Diagnosis^1^DOTD^182^189^
 ;;Diagnosis^1^DRST^190^190^
 ;;Diagnosis^1^DSZT^191^194^
 ;;Diagnosis^1^DNDI^195^196^
 ;;Diagnosis^1^DNDX^197^198^
 ;;Diagnosis^1^DEXT^199^200^
 ;;Diagnosis^1^DLYM^201^201^
 ;;Diagnosis^1^DFRC^202^209^
 ;;Diagnosis^1^DPRE^210^210^
 ;;Diagnosis^1^DCAUS^211^211^
 ;;Diagnosis^1^DICD^212^215^
 ;;Diagnosis^1^DSMD^216^221^
 ;;Diagnosis^2^DAMD^222^227^
 ;;Diagnosis^2^DRMD^228^233^
 ;;Diagnosis^2^DFMD^234^239^
 ;;Diagnosis^2^D2MD^240^245^
 ;;Diagnosis^2^DOP^246^246^
 ;;Diagnosis^2^DRFNM^247^268^
 ;;Diagnosis^2^DRFAD^269^284^
 ;;Diagnosis^2^DRTNM^285^306^
 ;;Diagnosis^2^DRTAD^307^322^
 ;;Diagnosis^2^DATOP^323^325^
 ;;Diagnosis^2^DAMOR^326^328^
 ;;Diagnosis^2^DAGD^329^331^
 ;;Diagnosis^2^DAGCR^332^334^
 ;;Diagnosis^2^DSRVM^335^337^
 ;;Diagnosis^2^DMRC^338^340^
 ;;Diagnosis^2^DLT^341^344^
 ;;Diagnosis^2^DCRG^345^352^
 ;;Diagnosis^2^XDDA^353^353^
 ;;Diagnosis^2^XDPS^354^354^
 ;;Diagnosis^2^XDTBP^355^355^
 ;;Diagnosis^2^XDASA^356^357^
 ;;Diagnosis^2^XDMISC^358^361^
 ;;Diagnosis^2^DCMM^362^439^
