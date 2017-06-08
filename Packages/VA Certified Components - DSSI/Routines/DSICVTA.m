DSICVTA ;DSS/WLC - Quick Docs for DSIC VISIT APIs ;06/07/2006 13:26
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;10104 $$CJ^XLFSTR
 N I,X,Y,Z
 S Z="",$P(Z,"-",80)=""
 F I=1:1 S X=$T(T+I) Q:X=""  S X=$P($T(T+I),";",3,99) D
 .I X'?1"DSICVT".E W !,"  "_X Q
 .W !,Z,!,$$CJ^XLFSTR("Routine "_X,80),!,Z
 .Q
 Q
T ;
 ;;DSICVT3:
 ;;
 ;;   VS(RETX,DFN,BEG,END,ZLOC,CAT,SCR)
 ;;   This get VISITs only
 ;;   Child visits are excluded: I $P(^AUPNVSIT(ien,0),U,12)
 ;;
 ;;       RETX = $name of global root that stores data [^TMP("DSIC",$J,"VSIT")]
 ;;       DFN  = required - pointer to file 2
 ;;       BEG  = optional - Fileman beginning date/time - default 2500101
 ;;       END  = optional - Fileman ending date/time - default DT+.25
 ;;       ZLOC = optional - used to screen selected locations
 ;;                         passed by reference where ZLOC(ien)=""
 ;;                         ien is pointer to file 44
 ;;                         kept for backward compAtibility, use SCR instead
 ;;       CAT  = optional - default 0 - if 1 then return historical visits
 ;;       SCR - optional - added 7/3/2002 - sgm
 ;;             passed by reference
 ;;             format:  SCR(sub) = code ^ value   where
 ;;                 code = C for hospital location #44
 ;;                        D for medical center division #40.8
 ;;                        S for 3-digit stop code from file 40.7 (not ien)
 ;;                 value = for codes C,D - any unique lookup value or ien
 ;;                         for code S - 3-digit stop code (not ien to 40.7)
 ;;
 ;;      return @RETX@(#) = V ^ ptr to 9000010 ^ ext date.time ^ ext loc ^ 
 ;;                         int date.time ^ int loc
 ;;                         if errors, then return -1^error message
 ;;
 ;;      Documentation Notes
 ;;      ===================
 ;;      SELECTED^VSIT returns ^TMP("VSIT",$J,visitien,#) = p1^p2^p3^p4^p5^p6
 ;;        p1 = visit date.time
 ;;        p2 = file 44 ien ; ext loc name  or
 ;;             if serv cat = "H" then file 9999999.06 ien ; ext name
 ;;        p3 = service category - internal .07 field value
 ;;        p4 = service connected - external 80001 field value
 ;;        p5 = patient status in/out - field 15002 set of codes
 ;;        p6 = clinic stop ien (#40.7) ; external name
 ;;
 ;;      v1.01 - screen out child visits
 ;;
 ;;  ACT(A,B)  : return ien^name^3-digit stop code;ien^name^3-digit stop...
 ;;           ; for active stop codes only.  Return <null> if none found.
 ;;           ; A = ien to file 40.7, B = 3-digit stop code
 ;;           ; 
 ;;
 ;;  SCR(INP,RET)
 ;;  Convert screen entries to array of IENs.  Called as extrinsic function.
 ;;     
 ;;       INP(#) = code ^ value  where
 ;;             code = C [hospital location file #44]
 ;;                    D [medical center division file #40.8]
 ;;                    S [clinic stop code file #40.7]
 ;;             value = .01 name value
 ;;             
 ;;       RETURNS:  RET passed by reference
 ;;             Sets RET(...) array as follows
 ;;                    RET(code,ien) = value  where
 ;;                        code = C,D,S, from above
 ;;                        ien = pointer to appropriate file
 ;;             Note:  RET is not killed so subsequent calls may append to it.
 ;;
 ;;  GV( DFN, DATE)
 ;;  get VISIT for a scheduled appointment
 ;;  
 ;;        DFN = Patient IEN to PATTIENT (#2) file.
 ;;        DATE = Appointment Date
 ;;        
 ;;        RETURNS:  VISIT (#900010) file pointer
 ;;        
