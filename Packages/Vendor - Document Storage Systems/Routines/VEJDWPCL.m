VEJDWPCL ;wpb/gbh - routine modified for dental GUI;8/2/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;5.0;Radiology/Nuclear Medicine;**1**;Mar 16, 1998
 ;RAO7PC1 ;HISC/GJC-Procedure Call utilities. ;11/18/97  12:43
EN1(RADFN,RABDT,RAEDT,RAEXN) ; Return non-cancelled exam list
 ; Input: RADFN-> Patient IEN        RABDT-> beginning date
 ;        RAEDT-> ending date        RAEXN-> max # of exams
 ;
 ; Output:
 ; ^TMP($J,"RAE1",Patient IEN,Exam ID)=Procedure name^Case number^
 ;       Report status^Abnormal alert flag^Report ien^
 ;       Exam status order #~Exam status name^
 ;       Imaging location name^Imaging type abbr~
 ;       Imaging type name^abnormal results flag^CPT Code
 ;       ^CPRS Order ien
 ;
 ; Note: It is possible for the ^TMP global data returned to contain
 ;       'No Report' and a Report file ien for the same exam.  This is
 ;       because Imaging can create a report stub in the Report file,
 ;       but no report interpretation exists and no status is assigned
 ;       to the report record.
 ;
 ; Exam ID: exam date/time (inverse) concatenated with the case IEN
 ; Abnormal alert flag:  Y or blank
 ; Abnormal results flag:  Y or blank, may be turned on even if
 ;     abnormal alert flag is not
 ;
 Q:'RADFN!('RABDT)!('RAEDT)
 Q:RABDT>RAEDT  ; quit if ending date before beginning date
 K ^TMP($J,"RAE1") S RAEXN=+$G(RAEXN)
 S:$P(RABDT,".",2) RABDT=RABDT\1 S:$P(RAEDT,".",2) RAEDT=RAEDT\1
 N RABNOR,RACNST,RACNT,RACPT,RACSE,RADIAG,RAIBDT,RAIEDT,RAILOC,RAITY
 N RANO,RAPRC,RAREX,RARPT,RARPTST,RAXAM,RAXID,RAXIT,RAXSTAT,RABNORMR
 S RACNST=9999999.9999
 S RAIBDT=RACNST-(RAEDT+.9999),RAIEDT=RACNST-(RABDT-.0001)
 S (RACNT,RAXIT)=0
 F  S RAIBDT=$O(^RADPT(RADFN,"DT",RAIBDT)) Q:RAIBDT'>0!(RAIBDT>RAIEDT)  D  Q:RAXIT
 . D SETDATA^VEJDWPCM ; obtain exam data, set ^TMP($J,"RAE1",Patient IEN,Exam ID)
 . Q
 Q
EN2(RADFN) ; Return last 7 days of non-cancelled exams
 ; Input: RADFN-> Patient IEN
 ;
 ; Output:
 ; ^TMP($J,"RAE7",Patient IEN,Exam ID)=procedure name^case number^
 ;       report status^imaging location IEN^imaging location name^
 ;       m(edia) OR b(ARIUM) OR c(holecystogram)
 ;
 ; Exam ID: exam date/time (inverse) concatenated with the case IEN
 ;
 Q:'RADFN  D EN2^RAO7PC1A Q
 ;
EN3(X) ; Return narrative text for exam(s)
 ; Input:
 ; X-> Exam id in one of two forms:
 ;   1) Pat. DFN^inv. exam date^Case IEN
 ;      Retrieves a single report for a single exam
 ;   2) Pat. DFN^inv. exam date^
 ;      Retrieves all reports for a set of exams ordered on one order
 ;
 ; Note:  Input delimiter can be any of the following: ^~\&;-
 ;        a delimiter may be a single space i.e, " "
 ;
 ; Output:
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name)=report status^
 ; abnormal alert flag^CPRS Order ien
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"D",n)=diagnostic
 ; code (n=1, this is the primary code)
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"H",n)=clin history
 ; (a line of text)
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"I",n)=impression
 ; (a line of text)
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"M",n)=modifier
 ; (external format)
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"R",n)=report
 ; (a line of text)
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"V",n)=verifier IEN
 ; ^signature block name
 ; ^TMP($J,"RAE2",Patient IEN,"PRINT_SET")=null (IFF this is a printset)
 ; ^TMP($J,"RAE2",Patient IEN,"ORD")=name of ordered procedure for
 ;  examsets and printsets
 ; ^TMP($J,"RAE2",Patient IEN,"ORD",case IEN)=name of ordered procedure
 ;  for that case; not part of an examset or printset
 ;
 K RAU,^TMP($J,"RAE2") S RAU=$$DEL(X)
 I RAU="" K RAU Q
 Q:'$P(X,RAU)!('$P(X,RAU,2))  ; Quit if no Pat. DFN -or- no inv. exam DT
 N RACIEN,RADFN,RAINVXDT,RAPSET,Y S RAPSET=0
 S RADFN=$P(X,RAU),RAINVXDT=$P(X,RAU,2),RACIEN=+$P(X,RAU,3)
 K RAU Q:'($D(^RADPT(RADFN,"DT",RAINVXDT,0))#2)
 I RACIEN D CASE^VEJDWPCN(RACIEN) Q
 S Y=0
 F  S Y=$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y)) Q:Y'>0  D
 . D CASE^VEJDWPCN(Y) S RAPSET=0
 . Q
 Q
EN30(RAOIFN) ; Return narrative text for exam(s).  To be used with the EN3
 ; entry point above.
 ; Input: RAOIFN -> the ien of Rad/Nuc Med Order
 Q:'RAOIFN  ; order passed in as 0 or null
 Q:'$D(^RAO(75.1,RAOIFN,0))  ; no such order
 Q:'$D(^RADPT("AO",RAOIFN))  ; no exam associated with this order
 N RADFN,RADTI,RACNI,RAXSET
 S RADFN=+$O(^RADPT("AO",RAOIFN,0)) Q:'RADFN
 S RADTI=+$O(^RADPT("AO",RAOIFN,RADFN,0)) Q:'RADTI
 S RAXSET=+$P($G(^RADPT(RADFN,"DT",RADTI,0)),"^",5) ; set if RAXSET=1
 I RAXSET D EN3(RADFN_"^"_RADTI_"^") Q  ; exam set, hit EN3 code
 ; the following code is executed for non-exam set examinations
 S RACNI=+$O(^RADPT("AO",RAOIFN,RADFN,RADTI,0)) Q:'RACNI
 D EN3(RADFN_"^"_RADTI_"^"_RACNI)
 Q
EN4(RABBRV,RAARY) ; Return Imaging Locations
 ; Input: RABBRV-> Abbreviation for I-Type    RAARY-> data storage array
 ;
 ; Output:
 ; array name(location IEN)=File 79.1 IEN^File 44 name^division IEN
 ; ^division name
 ;
 Q:RABBRV']""  ; quit no I-Type abbreviation
 Q:RAARY']""  ;  quit no data storage array
 N RADIV,RAITY,RALOC,RAX
 S RAITY=+$O(^RA(79.2,"C",RABBRV,0)) Q:'RAITY
 S RAX=0 F  S RAX=$O(^RA(79.1,"BIMG",RAITY,RAX)) Q:RAX'>0  D
 . S RADIV(79)=$G(^RA(79.1,RAX,"DIV"))
 . S RALOC(0)=$G(^RA(79.1,RAX,0))
 . Q:$P(RALOC(0),"^",19)]""  ;inactive DT present, can't be a future DT
 . S RALOC=$P($G(^SC(+RALOC(0),0)),U)
 . S RALOC=$S(RALOC]"":RALOC,1:"Unknown")
 . S RADIV=+$P($G(^RA(79,+RADIV(79),0)),U),RADIV(4)=$G(^DIC(4,RADIV,0))
 . S RADIV=$S($P(RADIV(4),U)]"":$P(RADIV(4),U),1:"Unknown")
 . S @(RAARY_"("_RAX_")")=RAX_U_RALOC_U_+RADIV(79)_U_RADIV
 . Q
 Q
CASE(RAOIFN,RARRAY) ; Return the case numbers and the total number of
 ; case numbers associated with a particular order.
 ; Input: RAOIFN-order ien (75.1)
 ;        RARRAY-data storage (local array)
 ; Return: RATTL-n^x where n is the number of cases in the array
 ;               x=PRINTSET if a single report covers many cases.
 ;               -1 if error (invalid order ien)
 ;               -2 no registered case to date -OR- case(s) cancelled
 ;               If -1 or -2, second piece of RATTL gives the reason
 ;         RARRAY-local data array, array_name(case #)
 N RATTL S RATTL="" D CASE^RAO7PC1A
 Q RATTL
DEL(X) ; Determine the delimiter used to seperate the data
 ; Input: 'X'-> data seperated by a delimiter (first & second pieces
 ; will follow null)
 N Y,Z
 F Y="^","~","\","&",";","-"," " S Z=$F(X,Y) I +Z Q
 Q $S(+Z>0:Y,1:"") ; pass back the delimiter used, or null if not found
