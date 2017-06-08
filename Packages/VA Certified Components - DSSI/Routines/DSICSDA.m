DSICSDA ;DSS/SGM - INTERFACE TO APPT MGMT
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;Main driver for getting appt data from scheduling redesign
 ;this routine will contain all the entry points for accessing scheduling
 ;data for the scheduling redesign package for moving scheduled data from
 ;VistA M to a centralized Oracle database
 ;
 ;The calling M routine or RPC should structure its call to return only
 ;the data it actually needs and not just get everything.  Since this
 ;will be going out to a centralized Oracle database, the time to
 ;retrieve data may be long.  Example, don't get all appts for a year
 ;for 5 or 10 or more clinics.  It would be better for the calling
 ;program to pass in the maximum number of clinics so that all the data
 ;is returned in an acceptable amount of time (say no more than 5 min).
 ;This is needed to avoid broker time-out issues.
 ;
 D DT^DICRW,HOME^%ZIS
 N A,B,I,X,Y,Z
 S I=0,Z(0)="SOM^"
 F Y="APPT","CLIN","GET","NEXT" D
 .S I=I+1,X=$T(@Y),A=$P(X," "),B=$P(X,"; ",2)
 .S X=A_$S(Y="GET":" ",1:"")_" [ "_B_" ]"
 .S Z(0)=Z(0)_I_":"_X_";"
 .Q
 W ! S X=$$DIR^DSICFM01(.Z) Q:X<1
 S Y=$P("APPT^CLIN^GET^NEXT",U,X) W @IOF
 F I=2:1 S Z=$T(@Y+I) Q:Z=""!($P(Z," ",2)'?1";".E)  W !,$P(Z,";",3,99)
 S X=$S(X'=3:"D",1:"DG")
 W ! F I=1:1 S Z=$T(@X+I) Q:Z=""!(Z=" ;;$END")  W !,$P(Z,";",3,99)
 Q
 ;
APPT(DSIC,INPUT) ; RPC - DSIC SD GET ONE PAT APPTS
 ; for documentation, run routine from top or see D below
 ;; This will return appts for a patient depending upon the filters
 ;; passed in.  This will K ^TMP($J) each time it is called.  If you call
 ;; this repetitively, then it is your obligation to store the data elsewhere
 ;; other than in any subtree of ^TMP($J)
 ;;
 ;; Input Code_Names allowed:  patient, FLDS, STATUS, START, END, TYPE
 ;; RETURN: If $G(DSIC)="" S DSIC=$NA(^TMP("DSIC",$J,"PAT"))
 D APPT^DSICSDA1
 Q
 ;
CLIN(DSIC,INPUT) ; RPC - DSIC SD GET CLINIC APPTS
 ; for documentation, run routine from top or see D below
 ;; Return appts for a clinic
 ;; This will K ^TMP($J) each time it is called.  If you call this
 ;; repetitively, then it is your obligation to store the data elsewhere
 ;; other than in any subtree of ^TMP($J)
 ;;
 ;; Input Code_Names allowed: CLINIC, FLDS, STATUS, START, END, TYPE
 ;;   if FLDS does not contain 4 (patient) then always add it
 ;; RETURN: If $G(DSIC)="" S DSIC=$NA(^TMP("DSIC",$J,"CLIN"))
 D CLIN^DSICSDA1
 Q
 ;
GET(DSIC,INPUT) ; RPC - DSIC SD GET
 ; for documentation, run routine from top or see DG below
 ;; This will return appts patient(s) and/or clinic(s) depending
 ;; upon the filters passed in.  This will K ^TMP($J) each time it is
 ;; called.  If you call this repetitively, then it is your obligation to
 ;; store the data elsewhere other than in any subtree of ^TMP($J)
 ;;
 ;; RETURN: DSIC=$NA(^TMP("DSIC",$J)) - the format of the return array
 ;;         depends upon the sort criteria.  See SORT^DSICSDA2
 D GET^DSICSDA2
 Q
 ;
NEXT(DSIC,INPUT) ; RPC - DSIC SD GET NEXT APPT
 ; for documentation, run routine from top or see D below
 ;; return the next scheduled appt for a patient
 ;; This will K ^TMP($J) each time it is called.  If you call this
 ;; repetitively, then it is your obligation to store the data elsewhere
 ;; other than in any subtree of ^TMP($J)
 ;;
 ;; Input Code_Names allowed:  patient, FLDS, STATUS, TYPE
 ;; RETURN: If $G(DSIC)="" S DSIC=$NA(^TMP("DSIC",$J,"NEXT"))
 D NEXT^DSICSDA1
 Q
 ;
 ;---------------  common documentation  ---------------
D ;
 ;;Input parameter:  INPUT(n) = code_name ^ value   where n = 0,1,2,3,4,...
 ;;   Example: INPUT(0) = "DFN^3545"
 ;;            INPUT(1) = "START^JUL 12, 2003"
 ;;            INPUT(2) = "END^3040712.24"
 ;;            INPUT(3) = "TYPE^I"
 ;;
 ;;The only required input parameter is the patient lookup value.  This will
 ;;accept 3 different forms of Code_Name for patient:
 ;;   DFN := pointer to file 2
 ;;   PAT := patient lookup value like name, Lnnnn, etc.
 ;;   SSN := 9 digit social security number
 ;;
 ;;  Req  Code_Name   Value
 ;;  ---  ---------   ------------------------------------------------------------
 ;;   y   [Patient]
 ;;            DFN    pointer to file 2
 ;;            PAT    patient lookup value like name, Lnnnn, etc.
 ;;            SSN    9 digit social security number
 ;;
 ;;   n   FLDS        ';'-delimited string of field IDs for data to be returned
 ;;                   default value: 1;2;3;6;8;9;11;12
 ;;        1 := appt date time - FM format;readable format
 ;;             always returned whether requested or not
 ;;        2 := hospital location ien ; name
 ;;        3 := appt status
 ;;             R := scheduled or kept   C := cancelled
 ;;             N := no show            NT := no action taken
 ;;        4 := patient DFN ; name
 ;;        5 := length of appt in minutes
 ;;        6 := comments - free text
 ;;        7 := overbook - Y:yes; N:no
 ;;        8 := eligibility of Visit ID ; name
 ;;             elig ID is not a pointer to file 8
 ;;        9 := check-in date time - FM format;readable format
 ;;       10 := type of appt ID ; name
 ;;             appt ID is a pointer to file 409.1
 ;;       11 := check-out date time - FM format;external format
 ;;       12 := patient status
 ;;             I:inpatient   O:outpatient  <null>
 ;;               for cancelled, no-show, no action taken always
 ;;               return <null>
 ;;
 ;;        Filters
 ;;   ----------------------------------------------------------------------------
 ;;   n    STATUS - ';'-delimited string of appt status codes
 ;;          only appts of the types included in this will be returned
 ;;          default value: R;NT
 ;;          R := scheduled or kept     C := cancelled
 ;;          N := no show              NT := no action taken
 ;;                      
 ;;   n    START - start date in either FM format or readable format
 ;;          Only appts equal to or greater that START will be returned
 ;;          default: TODAY
 ;;
 ;;   n    END - end date in either FM format or readable format
 ;;          only appts equal to or less than END will be returned
 ;;          default: TODAY@24:00
 ;;
 ;;   n    TYPE - patient type
 ;;          if I then only return inpatient appts
 ;;          if o then only return outpatient appts
 ;;          if undefined (or null) return both
 ;;
 ;;RETURN ARRAY
 ;;If errors return @DSIC@(1) = -1^message
 ;;
 ;;If data found, then return appts in reverse chronological date order
 ;;  @DSIC@(subscript) = p1^p2^p3^...^p12
 ;;    Subscript value only relevant for M-to-M processes
 ;;    Pn - for description of value returned see FLDS Code_Name above
 ;;    Pn will only be returned if Pn is part of the ';'-delimited FLDS string
 ;;$END
 ;
DG ;
 ;; Input Parameters [see routine DSICSDA0 for details]
 ;; Code_names  Req  Description
 ;; ----------  ---  ---------------------------------------------------
 ;; CLINIC           clinic name or ien
 ;; DIV              medical center division name or ien
 ;; END          y   end date for appts
 ;; FLDS             ';'-delimited string of field IDs
 ;;                    default to "1;2;3;4;8;12"
 ;; MAX              maximum number of entries to return
 ;;                    if MAX>0 then return first N appts
 ;;                    if MAX<0 then return last N appts
 ;; SORT             numeric flag indicating sort order of return array
 ;;                    default to 3 - see SORT() below
 ;; START        y   start date for appts
 ;; STATUS           ';'-delimited string of codes
 ;;                    default to "R;I;NT"
 ;; STOP             ';'-delimited string of stop codes
 ;;                    can be 3-digit stop code or stop code ien
 ;;
 ;;There are some contingencies:
 ;;1. Five fields will allow a filter. Only 3 fields can be filtered in
 ;;   one API call. A null/undefined filter will result in all values
 ;;   being returned.
 ;;
 ;;2. If the Max parameter is passed, then only one patient and/or one
 ;;   clinic can be passed.
 ;;
 ;;3. If passing in a patient, that patient must have an ICN
 ;;
 ;;4. At least one of either clinic or patient or both must be passed in.
 ;;
 ;;RETURN DATA for each entry in ^TMP("DSIC",$J)
 ;;  = p1^p2^...^p23 where the field ID will indicate the Pn
 ;;  On error return ^TMP("DISC",$J,1) = -1^message
 ;;  Else return ^TMP("DSIC",$J,sort1,sort2,appt) = data
 ;; Fld  Description
 ;; ---  ----------------------------------------------------
 ;;  1   appt date - Fileman date;human readable
 ;;  2   clinic - ien;name
 ;;  3   appt status - code;name
 ;;        R;Scheduled/Kept           I;Inpatient
 ;;       NS;No-Show                NSR;No-Show & Rescheduled
 ;;       CP;Cancelled by Patient    NT;No Action Taken
 ;;      CPR;Cancelled by Patient & Rescheduled
 ;;       CC;Cancelled by Clinic
 ;;      CCR;Cancelled by Clinic & Rescheduled
 ;;  4   patient - DFN;name
 ;;  5   length of appt in minutes
 ;;  6   comments
 ;;  7   overbook - Y/N
 ;;  8   eligibility of visit ien and name - number;name
 ;;  9   check-in date - fileman;human readable
 ;; 10   appintment type - ien;name
 ;; 11   check-out date - fileman;human readable
 ;; 12   outpatient encounter ien
 ;; 13   primary stop code - ien;3-digit stop code
 ;; 14   credit stop code - ien;3-digit stop code
 ;; 15   workload non-count - Y/N
 ;; 16   date appt made - fileman;human readable
 ;; 17   desired date of appt - fileman;human readable
 ;; 18   purpose of vist - code;short description
 ;;        1;C&P   2;10-10   3;SV   4;UV
 ;; 19   ekg date - fileman;human readable
 ;; 20   x-ray date - fileman;human readable
 ;; 21   lab date - fileman;human readable
 ;; 23   x-ray films required - Y/N
