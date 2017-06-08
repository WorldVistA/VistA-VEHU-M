DGYPV1 ;ALB/MTC - Pre MAS v5.3 Routine ;07 JAN 93
 ;;5.2;REGISTRATION;**27**;JUL 29,1992
 ;
 ;
EN1 ;-- Entry Point for check for MAS files
 D HOME^%ZIS S U="^"
 W !,"Inconsistent MAS File Pointers between files #6, #16 and #200 Listing.",!,*7,"This report requires 132 columns."
 D QLIST,^%ZISC
 Q
 ;
QLIST ;-- find out if and where to queue listing
 ;
 S %ZIS="Q" D ^%ZIS I POP D ^%ZISC G QLISTQ
 I $D(IO("Q")) K IO("Q") S ZTDESC="Inconsistent File Pointers in MAS between Files #6, #16 and File #200.",ZTRTN="START^DGYPV1" D ^%ZTLOAD,^%ZISC G QLISTQ
 D START^DGYPV1
QLISTQ Q
 ;
START ;-- Entry to queue report
 ;
 N TAG,DGFC,DGFLAG,DGCNT,FILE,DGPG,NOERR
 S (DGPG,DGFLAG)=0
 U IO
 F TAG=45,457,44,392,411,405,2 S FILE=$$LOAD(TAG) I $D(DGFC("CON")) S NOERR=1 D SEARCH(FILE) D:NOERR NOERR^DGYPV2 Q:DGFLAG
 D TPRN
 Q
 ;
TPRN ;-- routine to print trailer
 N I,LINE,X
 W @IOF
 F I=1:1 S X=$P($T(TAIL+I),";;",2) Q:X="END"  W !,X
 Q
 ;
LOAD(TAG) ;-- This function will load the DGFC("CON") array.
 ;  INPUT - TAG : $T tag to get data
 ;  OOUTPUT - DGFC array
 ;          - File number
 ;
 N X,SEQ,FILE
 K DGFC("CON")
 S FILE=$P($T(@TAG+1),";;",2)
 S SEQ=2 F  S X=$P($T(@TAG+SEQ),";;",2) Q:X="END"  D
 . S SEQ=SEQ+1,DGFC("CON",SEQ)=X
 Q FILE
 ;
SEARCH(FILE) ;-- This routine will search the file entries.
 ;
 N ROOT,NODE,RS,LEVEL,MULT,RECNUM,I
 D HEAD^DGYPV2
 S (RS,ROOT)=$G(^DIC(FILE,0,"GL")) G:ROOT="" SEARQ
 S ROOT=ROOT_"RECNUM)"
 S RECNUM=0 F  S RECNUM=$O(@ROOT) Q:'RECNUM  D  Q:DGFLAG
 . S I=0 F  S I=$O(DGFC("CON",I)) Q:'I  S LEVEL=DGFC("CON",I) D  Q:DGFLAG
 .. S MULT=$P($P(LEVEL,U),";"),NODE=$P($P(LEVEL,U,2),";"),PIE=$P($P(LEVEL,U,2),";",2)
 .. I $P(LEVEL,U)=";" D IN200^DGYPV2($P($G(@ROOT@(NODE)),U,PIE)) Q:DGFLAG
 .. I $P(LEVEL,U)?1E.E1";"1E.E S SEQ=0 F  S SEQ=$O(@ROOT@(MULT,SEQ)) Q:'SEQ  D IN200^DGYPV2($P($G(^(SEQ,NODE)),U,PIE)) Q:DGFLAG
SEARQ ;
 Q
 ;
MASDATA ;--The following data is used to search the MAS data files for
 ;  inconsistent data for the conversion from file #6 to file #200.
 ;  The format of the data of the data lines is as follows:
 ;      Each tag is for a MAS file, each line indicates the
 ;      node and piece the data is found on.
 ;      If the data is contained in a multiple then the first piece
 ;      will contain the multiple designation.
 ;
45 ;-- PTF file (#45)
 ;;45
 ;;;^70;15
 ;;M;0^P;5
 ;;END
2 ;-- Patient file (#2)
 ;;2
 ;;;^.104;1
 ;;;^.1041;1
 ;;END
405 ;-- Patient Movement File (#405)
 ;;405
 ;;;^0;8
 ;;;^0;19
 ;;END
44 ;-- Hospital Location File (#44)
 ;;44
 ;;;^0;13
 ;;END
457 ;-- Facility Treating Specialty File (#45.7)
 ;;45.7
 ;;PRO;0^0;1
 ;;END
392 ;-- Benficiary Travel Claim File (#392)
 ;;392
 ;;;^A;1
 ;;END
411 ;-- Scheduled Admission file (#41.1)
 ;;41.1
 ;;;^0;5
 ;;END
 ;
TAIL ;-- trailer to print after the report is complete
 ;;                        PIMS v5.3 Provider Conversion
 ;;
 ;;During the post init of PIMS v5.3, the Provider Conversion will delete
 ;;any references that cannot be converted. This report will give the entry
 ;;in the file so that they can be reviewed and corrected prior to
 ;;installing PIMS v5.3. The MAS ADPAC should run this option to review the
 ;;listing and make any necessary corrections. No data will be changed as a
 ;;result of running this report. It is the responsibility of the MAS ADPAC
 ;;to review the report and determine if any changes need to be made.
 ;; 
 ;;Most discrepancies can be attributed to entries in the Person file #16 
 ;;that are not contained in the New Person file (#200) or duplicate 
 ;;entries in file #16 or #200.
 ;; 
 ;;Using the following Fileman print, you can identify all entries in the
 ;;Person file that do not have an entry in the User file.
 ;; 
 ;;VA FileMan 19.0
 ;; 
 ;; 
 ;;Select OPTION: 2  PRINT FILE ENTRIES
 ;; 
 ;;OUTPUT FROM WHAT FILE: PERSON// 
 ;;SORT BY: NAME// 
 ;;START WITH NAME: FIRST// 
 ;;FIRST PRINT FIELD: 30.003  USER FILE POINTER  
 ;;THEN PRINT FIELD: .01  NAME  
 ;;THEN PRINT FIELD: 
 ;;HEADING: PERSON LIST// 
 ;;DEVICE:   LAT    RIGHT MARGIN: 80// 
 ;; 
 ;; 
 ;;Once all entries have been resolved between the two files, careful 
 ;;review of all remaining inconsistencies should be performed. If the 
 ;;records are old and the data is not considered critical, then the site 
 ;;does not have to make any further changes. Once the conversion has run, 
 ;;the entries that cannot be converted will be stuffed with a NULL.
 ;; 
 ;;Otherwise, using the appropriate option open/edit the records in 
 ;;question to resolve the inconsistent pointers. Please refer to the MAS 
 ;;Users manual for instructions on entering the correct data.
 ;;END
