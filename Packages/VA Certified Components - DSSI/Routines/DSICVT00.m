DSICVT00 ;DSS/WLC - Quick Docs for DSIC VISIT APIs ;06/07/2006 13:26
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;10104 $$CJ^XLFSTR
 ;
 N I,X,Y,Z
 S Z="",$P(Z,"-",80)=""
 F I=1:1 S X=$T(T+I) Q:X=""  S X=$P($T(T+I),";",3,99) D
 .I X'?1"DSICVT".E W !,"  "_X Q
 .W !,Z,!,$$CJ^XLFSTR("Routine "_X,80),!,Z
 .Q
 D ^DSICVTA
 Q
T ;
 ;;  VSIT(RETV, DATA, SCR)   
 ;;  get visits, appts, and admits
 ;;  only return appointments with no corresponding visit entry
 ;;
 ;;     RETV - $name of global root that stores the data to be returned
 ;;            [^TMP("DSIC",$J,"RET")]
 ;;
 ;;     DATA - required - DFN ^ BEG ^ END ^ ZLOC ^ FLG ^ MODS ^ CAT
 ;;             DFN - required - pointer to file 2
 ;;             BEG - optional - starting Fileman date/time
 ;;             END - optional - ending fileman date/time - default = DT+.5
 ;;             ALOC - optional - clinic, either name or file 44 ien
 ;;                    retained for backwards compatibility
 ;;             FLG - optional - type of appts to return
 ;;                    0 - active/kept appts (past) - default
 ;;                    1 - future appts only
 ;;                    2 - both past and future appts
 ;;             MODS - optional - string of codes to determine which
 ;;                               encounters to return. 
 ;;                               default value = ASV
 ;;                    MODS["A" - return current admission regardless of date
 ;;                    MODS["S" - return schedule appts
 ;;                    MODS["V" - return visit file entries (#9000010)
 ;;             CAT - optional - default value is 0
 ;;                   screen visits by service category
 ;;                    1 - return all visits
 ;;                    0 or <null> - do not return historical type visits
 ;;      SCR - optional - added 7/3/2002 - sgm
 ;;           passed by reference
 ;;           format:  SCR(sub) = code ^ value   where
 ;;                code = C for hospital location #44
 ;;                       D for medical center division #40.8
 ;;                       S for 3-digit stop code from file 40.7 (not ien)
 ;;           value = for codes C,D - any unique lookup value or ien
 ;;                   for code S - 3-digit stop code (not ien to 40.7)
 ;;
 ;;  Returns @RET@(#) = "A,S,V" ^ visit ien ^ ext d/t ^ ext loc ^
 ;;                     int d/t ^ pointer to 44 (int loc)
 ;;            where A = admission; S = appt; V = visit file (9000010)
 ;;            if errors encountered, return @RET@(#)=-1^error messages
 ;;
 ;;DSICVT2:
 ;;
 ;;   VALL(DSIV,IEN,FMY,SUB,FUN,WITHIEN)
 ;;   Get all visit infomation from VSIT API
 ;;      IEN - required - pointer to VISIT file or Visit ID
 ;;      FMT - optional - I, E, or B [B is default]
 ;;      WITHIEN - optional - 1 or 0 [default is 1]
 ;;            if 1 return @retv@(visitien,fld)
 ;;            if 0 return @retv@(fld)
 ;;            if CALL from RPC then WITHIEN ignored and set to 0
 ;;      SUB - optional - if $g(SUB)]"" return that subscript only
 ;;                       else return all VISIT data in RETV
 ;;      FUN - optional - 0 or 1 [default 0]
 ;;                       if FUN = 1 then extrinsic function
 ;;                       else RPC
 ;;    RETURN:
 ;;    
 ;;    Format of @DSIV@() = value [dependent upon FMT]
 ;;                    if FMT="I" value = internal
 ;;                    if FMT="E" value = external
 ;;                    if FMT="B" value = internal ^ external
 ;;
 ;;    If extrinsic function call [i.e., I '$G(FUN)]
 ;;    1. then on error, QUIT -1
 ;;    2. I $G(SUB)="" then QUIT IEN
 ;;    3. I $G(SUB) QUIT p1^p2^p3...  where
 ;;       pn = int val or ext val or (int val ^ ext val) - see FMT
 ;;       a. it is the responsibility of the calling program to make
 ;;          sure that maximum string length is not exceeded
 ;;       b. @DSIV@() will still be set - see WITHIEN
 ;;    
 ;;    If RPC case, then return
 ;;    @DSIV@(1) = -1 if problems encountered
 ;;    @DSIV@(#) = field# ^ internal value ^ external value
 ;;      where # = 1,2,3,4,5,...
 ;;      internal/external values will be present depending upon FMT
 ;;
 ;;Field# Value        Description
 ;;.01     VDT  VISIT/ADMIT DATE&TIME (date) 
 ;;.02     CDT  DATE VISIT CREATED (date) 
 ;;.03     TYP  TYPE (set) 
 ;;.05     PAT  PATIENT NAME (pointer PATIENT file #9000001)
 ;;.06     INS  LOC. OF ENCOUNTER (pointer LOCATION file 
 ;;            #9999999.06) (IHS file DINUMed to INSTITUTION  file #4) 
 ;;.07     SVC  SERVICE CATEGORY (set) 
 ;;.08     DSS  DSS ID (pointer to CLINIC STOP file) 
 ;;.09     CTR  DEPENDENT ENTRY COUNTER (number) 
 ;;.11     DEL  DELETE FLAG (set) 
 ;;.12     LNK  PARENT VISIT LINK (pointer VISIT file #9000010) 
 ;;.13     MDT  DATE LAST MODIFIED (date) 
 ;;.18     COD  CHECK OUT DATE&TIME (date) 
 ;;.21     ELG  ELIGIBILITY (pointer ELIGIBILITY CODE file #8) 
 ;;.22     LOC  HOSPITAL LOCATION (pointer HOSPITAL LOCATION file #44) 
 ;;.23     USR  CREATED BY USER (pointer NEW PERSON file #200) 
 ;;.24     OPT  OPTION USED TO CREATE (pointer OPTION file #19) 
 ;;.25     PRO  PROTOCOL (pointer PROTOCOL file #101) 
 ;;2101    OUT  OUTSIDE LOCATION (free text) 
 ;;80001   SC   SERVICE CONNECTED (set) 
 ;;80002   AO   AGENT ORANGE EXPOSURE (set) 
 ;;80003   IR   IONIZING RADIATION EXPOSURE (set) 
 ;;80004   EC   PERSIAN GULF EXPOSURE (set) 
 ;;80005   MST   MILITARY SEXUAL TRAUMA (set) 
 ;;80006   HNC   HEAD AND NECK CANCER (set) 
 ;;15001   VID  VISIT ID (free text) 
 ;;15002   IO   PATIENT STATUS IN/OUT (set) 
 ;;15003   PRI  ENCOUNTER TYPE (set) 
 ;;81101   COM  COMMENTS 
 ;;81202   PKG  PACKAGE (pointer PACKAGE file #9.4) 
 ;;81203   SOR  DATA SOURCE (pointer PCE DATA SOURCE file (#839.7)
 ;;
 ;;   ADM(DFN)
 ;;   Return current admission data
 ;;      return 1^p2^p3^p4^p5^p6^p7 where
 ;;       p2 = external date.time
 ;;       p3 = external location
 ;;       p4 = internal date.time
 ;;       p5 = internal ptr to 44
 ;;       p6 = external current location
 ;;       p7 = internal current ptr to 44
 ;;       if invalid dfn return -1^error message
 ;;       if not an inpatient, return 0^Not currently admitted
 ;;
 ;;
 ;;
 ;;   APPL(DSIC,SDT,EDT,DATA)
 ;;   get all scheduled appts for one or more clinics.
 ;;   
 ;;      INPUT:
 ;;   
 ;;      SDT:     Start date in FM format, default = TODAY (Optional)
 ;;      EDT:     End date in FMN format, default = TODAY +6 (Optional)
 ;;      DATA():  passed by reference where DATA(n) = code ^ value
 ;;      CODE    VALUE
 ;;      ------  ------------------------------------------------------
 ;;      C       clinic lookup value [name, IFN, or any lookup value]
 ;;              - only exact matches accepted.
 ;;      S       3-digit Stop Code
 ;;      FI      1 or 0, default is 0
 ;;              - if 1, then filter out 'Checked In' appts
 ;;      F0      1 or 0, default is 0
 ;;              - if 1, then filter out 'Checked Out' appts
 ;;            
 ;;      OUTPUT:
 ;;      
 ;;      Return @VEJD@(n) = visit IFN^date.time^loc^patient^ssn^division
 ;;      where P2 - P6 is internal IEN;external value        
 ;;      data will be sorted by location name, then date.time
 ;;  
 ;;  
 ;;  
 ;;       
 ;;   CLST(DSICX,STOP)   ; RPC:   VEJDSD GET LOC BY STOP CODE
 ;;   get list of all HOSPITAL LOCATIONS with certain stop codes
 ;;    
 ;;       STOP - req - array of 3-digit stop codes STOP(n)=3-digit stop
 ;;       Return:  @VEJDX@(n) = ifn ^ p2 ^ p3 ^ p4 ^ p5  where
 ;;                p2 = name   p3 = 3-digit stop code  p4 = ifn;institution name
 ;;                p5 = ifn;medical center division
 ;;       
 ;;   LOC(DSICL,VAL)     ; RPC: VEJDSD GET LOCATION
 ;;   lookup loation in file 44
 ;;   VAL - required - name or IFN in file 44
 ;;   
 ;;   Return DSICX = IFN ^ p2 ^ p3 ^ p4 ^ p5 ^ p6 where:
 ;;             p2 = name
 ;;             p3 = 3-digit stop code
 ;;             p4 = ifn;institution name
 ;;             p5 = ifn;medical center division
 ;;             p6 = active flag [0/1]
 ;;             
 ;;       On error, return -1^error message
 ;;       
 ;;       
 ;;   ERR(A)  ; generate error message for return variable
 ;;      A = number to generate
 ;;      
 ;;   GV(DFN,DATE)       ; get VISIT for a scheduled appointment
 ;;           return <null> if none found
 ;;           
 ;;           INPUT:
 ;;             DFN - IEN to PATIENT (#2) file
 ;;             DATE - Appointment date
 ;;
