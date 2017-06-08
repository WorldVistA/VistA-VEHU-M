VEJDWPB3 ;wpb/swo routine modified for dental GUI;7.7.98 [ 12/28/98  12:47 PM ]
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;3.0;ORDER ENTRY/RESULTS REPORTING;**1,10**;Dec 17, 1997
 ;ORWPR ALB/MJK,dcm Report Calls ;9/18/96  15:02
LIST(LST) ; -- return lists for list boxes
 ;  RPC: ORWRP REPORT LIST
 ;  See RPC definition for details on input and output parameters
 ;
 N EOF,ROOT
 S EOF="$$END",ROOT=$NA(LST)   ;,ROOT=$NA(^TMP($J,"ORPTLIST"))
 K @ROOT
 ;
 ; -- get list of reports
 D GETRPTS(.ROOT,.EOF)
 ; -- get list of health summary types
 D GETHS(.ROOT,.EOF)
 ; -- get list of date ranges
 D GETDT(.ROOT,.EOF)
 ;
 Q
 ;
GETRPTS(ROOT,EOF) ;  -- get list of reports
 N I,X
 D SETITEM(.ROOT,"[REPORT LIST]")
 F I=3:1 S X=$P($T(RPTLIST+I),";",3) D SETITEM(.ROOT,X) Q:X=EOF
 Q
 ;
RPTLIST ; -- list of reports
 ; <ID> ^ <report name> ^ <qualifier type> ^ <right margin>
 ; <qualifier type> = 0:none,1:HSType,2:DateTime,3:Imaging,4:NutrAssess
 ;;1^Health Summary^1^80
 ;;18^Imaging^3^80
 ;;9^Lab Status^2^80
 ;;2^Blood Bank Report^0^80
 ;;20^Anatomic Path Report^0^80
 ;;4^Dietetics Profile^0^80
 ;;17^Nutritional Assessment^4^80
 ;;5^Vitals Cumulative^2^132
 ;;19^Procedures^19^80
 ;;$$END
 ;
GETHS(ROOT,EOF) ; --get list of health summary types
 N I,HSPARM,VEJDLOOP
 ;D GETLST^XPAR(.HSPARM,"SYS","ORWRP HEALTH SUMMARY TYPE LIST","N")
 ;
 ; BLJ 28 DEC 1998 ; Modifications for non-CPRS types.
 S VEJDLOOP=0 F  S VEJDLOOP=$O(^GMT(142,VEJDLOOP)) Q:+VEJDLOOP=0  D
 .S HSPARM(VEJDLOOP)=VEJDLOOP_U_$P($G(^GMT(142,VEJDLOOP,0)),U)
 ; We now return you to your regularly scheduled program.
 D SETITEM(.ROOT,"[HEALTH SUMMARY TYPES]")
 S I=0  F  S I=$O(HSPARM(I)) Q:'I  D SETITEM(.ROOT,"h"_HSPARM(I))
 D SETITEM(.ROOT,EOF)
 Q
 ;
GETDT(ROOT,EOF) ; -- get date range choices
 N I,X
 D SETITEM(.ROOT,"[DATE RANGES]")
 F I=2:1 S X=$P($T(DTLIST+I),";",3) D SETITEM(.ROOT,"d"_X) Q:X=EOF
 Q
 ;
DTLIST ; -- list of date ranges
 ;<number of days>^ <display text>
 ;;0^Today
 ;;7^One Week Back
 ;;14^Two Weeks Back
 ;;30^One Month Back
 ;;180^Six Months Back
 ;;365^One Year Back
 ;;$$END
 ;
SETITEM(ROOT,X) ; -- set item in list
 S @ROOT@($O(@ROOT@(9999),-1)+1)=X
 Q
 ;
RPT(ROOT,DFN,RPTID,HSTYPE,DTRANGE,EXAMID,ALPHA,OMEGA) ; -- return report text
 ;ROOT=Where you want it
 ;DFN=Patient DFN
 ;RPTID=Unique identifier for the report
 ;HSTYPE=Health Summary Type
 ;DTRANGE=# of days to go back from today
 ;EXAMID=Radiology exam ID
 ;ALPHA=Start date for report (used in lieu of DTRANGE)
 ;OMEGA=End date for report (used in lieu of DTRANGE)
 ;  RPC: ORWRP REPORT TEXT
 ;  See RPC definition for details on input and output parameters
 ;
 ; -- init output global for close logic of WORKSTATION device
 S ROOT=$NA(^TMP("ORDATA",$J,1))
 ;
 ; -- get report text
 I RPTID=1 D HS^ORWRP1(DFN,HSTYPE) G RPTQ
 I RPTID=2 D BLR^ORWRP1(.ROOT,DFN) G RPTQ ;Used to call BL^ORWRP1(DFN)
 I RPTID=3 D PATH^ORWRP1(DFN) G RPTQ
 I RPTID=20 D AP^ORWRP1(.ROOT,DFN) G RPTQ
 I RPTID=4 D DIET^ORWRP1(.ROOT,DFN) G RPTQ
 I RPTID=5 D VITALS^ORWRP1(DFN,DTRANGE,"VITCUM") G RPTQ
 I RPTID=7 D INTERIM^ORWRP1(DFN,ALPHA,OMEGA) G RPTQ
 I RPTID=8 D GRAPH^ORWRP1(DFN,ALPHA,OMEGA) G RPTQ
 I RPTID=9 D STAT^ORWRP1(DFN,$G(ALPHA),$G(OMEGA),$G(DTRANGE)) G RPTQ
 I RPTID=10 D ORS^ORWRP1(DFN,DTRANGE) G RPTQ
 I RPTID=11 D ORD^ORWRP1(DFN,ALPHA,OMEGA) G RPTQ
 I RPTID=12 D ORP^ORWRP1(DFN,ALPHA,OMEGA) G RPTQ
 I RPTID=13 D PSO^ORWRP1(DFN) G RPTQ
 I RPTID=14 D ORC^ORWRP1(DFN,ALPHA,OMEGA) G RPTQ
 I RPTID=15 D AHS^ORWRP1(DFN,HSTYPE) G RPTQ
 I RPTID=16 D LRGEN^ORWRP1(DFN,ALPHA,OMEGA) G RPTQ
 I RPTID=17 D NUTR^ORWRP1(.ROOT,DFN,EXAMID) G RPTQ
 I RPTID=18 D RPT^ORWRA(.ROOT,DFN,EXAMID) G RPTQ
 I RPTID=19 D MED^ORWRP1(DFN,EXAMID) G RPTQ
 ;
 ; -- basic report if id not found above
 D NOTYET(.ROOT)
RPTQ Q
 ;
NOTYET(ROOT) ; -- standard not available display text
 D SETITEM(.ROOT,"Report not available at this time.")
 Q
 ;
START(RM,GOTO) ;
 ;RM=Right margin
 S:'$G(RM) RM=80
 N ZTQUEUED,ORHFS,ORSUB,ORIO
 S ORHFS=$$HFS(),ORSUB="ORDATA"
 D OPEN(.RM,.ORHFS,"W",.ORIO)
 D @GOTO
 D CLOSE(.ORRM,.ORHFS,.ORSUB,.ORIO)
 Q
HFS() ; -- get hfs file name
 ; -- need to define better unique algorithm
 Q "ORU_"_$J_".DAT"
 ;
OPEN(ORRM,ORHFS,ORMODE,ORIO) ; -- open WORKSTATION device
 ;   ORRM: right margin
 ;  ORHFS: host file name
 ; ORMODE: open file in 'R'ead or 'W'rite mode
 S ZTQUEUED="" K IOPAR
 S IOP="OR WORKSTATION;"_$G(ORRM,80)
 S %ZIS("HFSMODE")=ORMODE,%ZIS("HFSNAME")=ORHFS
 D ^%ZIS K IOP,%ZIS
 U IO S ORIO=IO
 Q
 ;
CLOSE(ORRM,ORHFS,ORSUB,ORIO) ; -- close WORKSTATION device
 ; ORSUB: unique subscript name for output 
 I IO=ORIO D ^%ZISC
 U IO
 D USEHFS
 U IO
 Q
USEHFS ; -- use host file to build global array
 N IO,OROK,SECTION
 S SECTION=0
 D INIT
 S OROK=$$FTG^%ZISH(,ORHFS,$NA(@ROOT@(1)),4) I 'OROK Q
 D STRIP
 N ORARR S ORARR(ORHFS)=""
 S OROK=$$DEL^%ZISH("",$NA(ORARR))
 Q
 ;
INIT ; -- initialize counts and global section
 S (INC,CNT)=0,SECTION=SECTION+1
 S ROOT=$NA(^TMP(ORSUB,$J,SECTION))
 K @ROOT
 Q
 ;
FINAL ; -- set 'x of y' for each section
 N I
 F I=1:1:SECTION S ^TMP(ORSUB,$J,I,.1)=I_U_SECTION
 Q
 ;
STRIP ; -- strip off control chars
 N I,X
 S I=0 F  S I=$O(@ROOT@(I)) Q:'I  S X=^(I) D
 . I X[$C(8) D  ;BS
 .. I $L(X,$C(8))=$L(X,$C(95)) S (X,@ROOT@(I))=$TR(X,$C(8,95),"") Q  ;BS & _
 .. S (X,@ROOT@(I))=$TR(X,$C(8),"")
 . I X[$C(7)!(X[$C(12)) S @ROOT@(I)=$TR(X,$C(7,12),"") ;BEL or FF
 Q
