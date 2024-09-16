PXUTLVST ;ISL/DEE,PKR - Looks up the visit to see if there is already one ;04/11/2024
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**238**;Aug 12, 1996;Build 3
 ;
 Q
 ;
FINDVISIT(DFN,VDT,HLOC,SVC,DSS,INS,TYPE,ENCTYPE,CSVC,VISITLIST) ;Use the "AET" and "AA" indexes
 ;to search for existing visits. Requires Patient (DFN) and Visit Date and Time (VDT). Hospital Location
 ;is required unless SVC="E". Institution (INS), Type, Encounter Type (ENCTYPE), DSS ID (DSS), and
 ;Service Category (SVC) are optional. If they are passed as "", then they are not
 ;included in the visit matching. If DSS and INS are passed as "NULL" then the match will be
 ;if these fields are NULL in the visit file entry.
 ;
 ;Credit Stop visits are not returned as a match because they are created and managed by
 ;Scheduling.
 ;
 ;DATA2PCE can change the input value of Service Category depending on if the patient was an
 ;inpatient or outpatient on the date of the encounter. It can also change the Service Category
 ;to "T" if the name of  the Clinic Stop contains "TELE". If there is a possibility the input value of
 ;SVC may not be correct pass CSVC=1 to determine if SVC could have been changed and include
 ;the changed value in the matching.
 ;
 I (+DFN'>0)!('$$VFMDATE^PXDATE(VDT,"ST")) S VISITLIST(0)=-1 Q
 I (SVC'="E"),(+HLOC'>0) S VISITLIST(0)=-1 Q
 I (SVC="E"),(HLOC="") S HLOC=0
 ;
 N APPTVST,DATE,DSST,ENCTYP,INP,INVDT,IPM,NFOUND,SVCMATCH,SVCT,TEMP,TESTSVC,TIME
 N VISITIEN,VISITINDEX,VSIT
 S VSIT("VDT")=VDT
 S VSIT("PAT")=DFN
 S VSIT("LOC")=HLOC
 S VSIT("INS")=$G(INS)
 S VSIT("DSS")=$G(DSS)
 S VSIT("TYPE")=$G(TYPE)
 S VSIT("ENCTYPE")=$G(ENCTYPE)
 S VSIT("SVC")=$G(SVC)
 S NFOUND=0
 S TESTSVC=""
 ;
 I ($G(CSVC)=1),(VSIT("SVC")'=""),(VSIT("SVC")'="E"),(VSIT("SVC")'="H") D
 .;Use this special check for inpatient status.
 . S IPM=$$IP^VSITCK1(VDT,DFN)
 . S INP=$S(IPM>0:1,1:0)
 . I (VSIT("DSS")'="NULL"),(+VSIT("DSS")>0) S DSST=VSIT("DSS")
 . I ((VSIT("DSS")="")!(VSIT("DSS")="NULL")),(+VSIT("LOC")>0) S DSST=+$P(^SC(VSIT("LOC"),0),U,7)
 .;If the Stop Code is not in file #150.1, the Service Category cannot be X or D. It will be changed
 .;when EN^PXKCO is called from the protocol event SDAM APPOINTMENT EVENTS. This event is fired
 .;as part of SDAM PCE EVENT (D EN^SDPCE) which in turn is run directly from EVENT^PXKMASC.
 . I DSST>0 D
 .. S SVCT=$S((VSIT("SVC")="X")!(VSIT("SVC")="D")&('$D(^VSIT(150.1,"B",DSST))):"A",1:VSIT("SVC"))
 .. S TESTSVC=$$SVC^PXKCO(SVCT,DSST,INP,VSIT("LOC"))
 ;
 ;When the Service Category is "E" do not try to match the Hospital Location.
 I VSIT("SVC")="E" S VSIT("LOC")=0
 ;
 ;Get the visit for the appointment if there is one.
 S APPTVST=$$APPT2VST^PXUTL1(DFN,VDT,HLOC)
 I APPTVST>0 D
 . S TEMP=$G(^AUPNVSIT(APPTVST,0))
 . S SVCMATCH=0
 . I (VSIT("SVC")'=""),(VSIT("SVC")=$P(TEMP,U,7)) S SVCMATCH=1
 . I (SVCMATCH=0),(TESTSVC'=""),(TESTSVC=$P(TEMP,U,7)) S SVCMATCH=1
 . I SVCMATCH=0 Q
 .;
 . I (VSIT("TYPE")'=""),(VSIT("TYPE")'=$P(TEMP,U,3)) Q
 . I (VSIT("DSS")="NULL"),($P(TEMP,U,8)'="") Q
 . I (VSIT("DSS")'=""),(VSIT("DSS")'="NULL"),(VSIT("DSS")'=$P(TEMP,U,8)) Q
 .;
 . I (VSIT("INS")="NULL"),($P(TEMP,U,6)'="") Q
 . I (VSIT("INS")'=""),(VSIT("INS")'="NULL"),(VSIT("INS")'=$P(TEMP,U,6)) Q
 . S ENCTYP=($P($G(^AUPNVSIT(APPTVST,150)),U,3))
 .;Ignore Credit Stop encounters.
 . I ENCTYP="C" Q
 . I (VSIT("ENCTYPE")'=""),(VSIT("ENCTYPE")'=(ENCTYP)) Q
 . S NFOUND=NFOUND+1,VISITLIST(NFOUND)=APPTVST,VISITLIST(NFOUND,"A")="",VISITINDEX(APPTVST)=""
 ;
 I VSIT("ENCTYPE")'="" D
 . S ENCTYP=""
 . F  S ENCTYP=$O(^AUPNVSIT("AET",DFN,VDT,HLOC,ENCTYP)) Q:ENCTYP=""  D
 ..;Ignore Credit Stop encounters.
 .. I ENCTYP="C" Q
 .. I (VSIT("ENCTYPE")'=ENCTYP) Q
 .. S VISITIEN=""
 .. F  S VISITIEN=$O(^AUPNVSIT("AET",DFN,VDT,HLOC,ENCTYP,VISITIEN)) Q:VISITIEN=""  D
 ... I $D(VISITINDEX(VISITIEN)) Q
 ... S TEMP=$G(^AUPNVSIT(VISITIEN,0))
 ... S SVCMATCH=1
 ... I (VSIT("SVC")'=""),(VSIT("SVC")'=$P(TEMP,U,7)) S SVCMATCH=0
 ... I (SVCMATCH=0),($G(TESTSVC)'=""),(TESTSVC=$P(TEMP,U,7)) S SVCMATCH=1
 ... I SVCMATCH=0 Q
 ...;
 ... I (VSIT("TYPE")'=""),(VSIT("TYPE")'=$P(TEMP,U,3)) Q
 ... I (VSIT("DSS")="NULL"),($P(TEMP,U,8)'="") Q
 ... I (VSIT("DSS")'=""),(VSIT("DSS")'="NULL"),(VSIT("DSS")'=$P(TEMP,U,8)) Q
 ...;
 ... I (VSIT("INS")="NULL"),($P(TEMP,U,6)'="") Q
 ... I (VSIT("INS")'=""),(VSIT("INS")="NULL"),(VSIT("INS")'=$P(TEMP,U,6)) Q
 ... S NFOUND=NFOUND+1,VISITLIST(NFOUND)=VISITIEN,VISITINDEX(VISITIEN)=""
 ;
 S DATE=$P(VDT,".",1),TIME=$P(VDT,".",2)
 S INVDT=(9999999-DATE)
 I TIME'="" S INVDT=INVDT_"."_TIME
 S VISITIEN=0
 F  S VISITIEN=+$O(^AUPNVSIT("AA",DFN,INVDT,VISITIEN)) Q:VISITIEN=0  D
 . I $D(VISITINDEX(VISITIEN)) Q
 . S ENCTYP=$P($G(^AUPNVSIT(VISITIEN,150)),U,3)
 . I ENCTYP="C" Q
 . I (VSIT("ENCTYPE")'=""),(VSIT("ENCTYPE")'=(ENCTYP)) Q
 . S TEMP=$G(^AUPNVSIT(VISITIEN,0))
 . I (VSIT("LOC")'=0),(VSIT("LOC")'=$P(TEMP,U,22)) Q
 . S SVCMATCH=0
 . I (VSIT("SVC")'=""),(VSIT("SVC")=$P(TEMP,U,7)) S SVCMATCH=1
 . I (SVCMATCH=0),(TESTSVC'=""),(TESTSVC=$P(TEMP,U,7)) S SVCMATCH=1
 . I SVCMATCH=0 Q
 .;
 . I (VSIT("TYPE")'=""),(VSIT("TYPE")'=$P(TEMP,U,3)) Q
 . I (VSIT("DSS")="NULL"),($P(TEMP,U,8)'="") Q
 . I (VSIT("DSS")'=""),(VSIT("DSS")'="NULL"),(VSIT("DSS")'=$P(TEMP,U,8)) Q
 .;
 . I (VSIT("INS")="NULL"),($P(TEMP,U,6)'="") Q
 . I (VSIT("INS")'=""),(VSIT("INS")'="NULL"),(VSIT("INS")'=$P(TEMP,U,6)) Q
 . S NFOUND=NFOUND+1,VISITLIST(NFOUND)=VISITIEN
 S VISITLIST(0)=NFOUND
 I NFOUND'>1 Q
 ;
 ;Process multiple matches.
 N APPTIND,DECOUNT,KEEPIEN,KEEPIND,NREFS,NREFSD,NVISITS,TEMPLIST
 S APPTIND=""
 F IND=1:1:NFOUND D
 . I $D(VISITLIST(IND,"A")) S APPTIND=IND
 . S VISITIEN=VISITLIST(IND)
 . S DECOUNT=+$P(^AUPNVSIT(VISITIEN,0),U,9)
 . S NREFSD(DECOUNT,IND)=VISITIEN
 ;Order the list based on dependency count; largest dependency count is first. Remove
 ;visits with no references.
 S NREFS="",NVISITS=0
 F  S NREFS=+$O(NREFSD(NREFS),-1) Q:NREFS=0  D
 . S IND=""
 . F  S IND=$O(NREFSD(NREFS,IND)) Q:IND=""  D
 .. S NVISITS=NVISITS+1,TEMPLIST(NVISITS)=VISITLIST(IND)
 .. I $D(VISITLIST(IND,"A")) S TEMPLIST(IND,"A")=""
 ;If no visits have references return the first one.
 I NVISITS=0 D  Q
 . S KEEPIND=$O(NREFSD(0,""))
 . S KEEPIEN=VISITLIST(KEEPIND)
 . S APPTIND=$S($D(VISITLIST(KEEPIND,"A")):KEEPIND,1:"")
 . K VISITLIST
 . S VISITLIST(0)=1,VISITLIST(1)=KEEPIEN
 . I APPTIND=KEEPIND S VISITLIST(1,"A")=""
 ;
 K VISITLIST
 S VISITLIST(0)=NVISITS
 F IND=1:1:NVISITS D
 . S VISITLIST(IND)=TEMPLIST(IND)
 . I $D(TEMPLIST(IND,"A")) S VISITLIST(IND,"A")=""
 Q
 ;
 ;=========
LOOKVSIT(PAT,VDT,LOC,DSS,INS,TYP) ;Calls visit tracking to see if there is
 ;already a visit.
 ;Get the visit for the appointment is there is one
 N APPTVST
 S APPTVST=$$APPT2VST^PXUTL1(PAT,VDT,LOC)
 I APPTVST>0 Q APPTVST
 ;
 N VSIT,VSITPKG
 S VSIT("IEN")=""
 S VSIT("VDT")=VDT
 S VSIT("PAT")=PAT
 S VSIT("LOC")=LOC
 S VSIT("INS")=$G(INS)
 S VSIT("TYP")=$G(TYP)
 S VSIT("DSS")=$G(DSS)
 I VSIT("DSS")="",$P($G(^SC(+VSIT("LOC"),0)),"^",7)>0 S VSIT("DSS")=$P(^SC(+VSIT("LOC"),0),"^",7)
 S VSITPKG="PX"
 S VSIT(0)="D0EM"
 ;
 ;CALL FOR VSIT
 D ^VSIT
 I '$D(VSIT("IEN"))#2 Q -1
 Q $P(VSIT("IEN"),"^",1)
 ;
