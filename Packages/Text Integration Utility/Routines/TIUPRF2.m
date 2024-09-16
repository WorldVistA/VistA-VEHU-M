TIUPRF2 ;SLC/JMH - RPCs for Patient Record Flags ;May 6, 2024@12:20
 ;;1.0;TEXT INTEGRATION UTILITIES;**184,318**;Jun 20, 1997;Build 120
 ;
 ;
 ; Reference to NS^XUAF4 in ICR #2171
 ; Reference to GETACT^DGPFAPI in ICR #3860
 ; Reference to GETHTIU^DGPFAPI1 in ICR #4383
 ; Reference to STOTIU^DGPFAPI2 in ICR #4384
 ; Reference to SITE^VASITE in ICR #10112
 ;
GETTITLE(TIUY,PTDFN,FLAGID) ; RPC TIU GET PRF TITLE
 ; RPC Gets Note Title associated with FLAGID for PTDFN
 ; INPUT PARAMETERS
 ;   PTDFN - required - pointer to file 2
 ;  FLAGID - required - identifier for particular flag assignment
 ;                      Set as subscript in GETACT^DGPFAPI
 ;                      See GETFLG^ORPRF
 ; RETURN PARAMETER
 ;   .TIUY = passed by ref, TitleIEN^Title
 ;          0 if no title is associated or flag assignment is not active
 ;
 N PRFARR K TIUY S TIUY=0
 Q:'$G(PTDFN)  Q:'$G(FLAGID)
 S TIUY=$$GETACT^DGPFAPI(PTDFN,"PRFARR") ;Get Active flag info
 Q:'TIUY
 S TIUY=$G(PRFARR(FLAGID,"TIUTITLE"))
 I TIUY'>0 S TIUY=0
 Q
 ;
GETNOTES(TIUY,PTDFN,TIUTTL,REVERSE) ; RPC TIU GET LINKED PRF NOTES
 ; RPC gets SIGNED, LINKED PRF
 ; INPUT PARAMETERS
 ;    PTDFN - required - pointer to file 2
 ;   TIUTTL - required - IEN of TIU DOCUMENT DEFINITION (#8925.1) file
 ;  REVERSE - optional - Boolean, 0/1
 ;                       0 - default - sort return chronologically
 ;                       1 - sort return inverse chronological
 ; RETURN PARAMETER
 ;   .TIUY - passed by reference, TIUY=total # of notes
 ;  TIUY(TIUIDATE)=TIUIEN_U_TIUACT_U_TIUEDATE_U_TIUAUTH
 ;       TIUIDATE - FM date of note, or inverse FM date
 ;         TIUIEN - pointer to file 8925
 ;         TIUACT - name of action
 ;       TIUEDATE - external date of note
 ;        TIUAUTH - name of author of note
 ;
 ; Excludes Notes with Entered in Error (EIE) action
 ; Also excludes all notes chronologically prior to EIE action
 ; Only includes notes complete or amended or not cosigned
 ;
 N X,ACTID,ARRAYNM,DTARRAY,HASERR
 K TIUY ; purge return array
 S (TIUY,ACTID)=0
 S ARRAYNM=$NA(^TMP("TIUPRFH",$J)) D KILL
 ;
 ;  Get PRF Assgn Hist info
 S X=$$GETHTIU^DGPFAPI1(PTDFN,TIUTTL,ARRAYNM)
 I 'X G KILL
 ;
 ;  Filter DGPF History records Entered in Error
 ;  HASERR = history ID with EIE status
 ;  all history records with date<EIE are also invalid
 S HASERR=$$HASERR^TIUPRFL(ARRAYNM)
 ;
 F  S ACTID=$O(@ARRAYNM@("HISTORY",ACTID)) Q:'ACTID  D
 . N X,ARRTMP,DIERR,FLDS,IENS,STATUS
 . N TIUACT,TIUAUTH,TIUERR,TIUFLDS,TIUEDATE,TIUIDATE,TIUIEN
 . S ARRTMP=$NA(@ARRAYNM@("HISTORY",ACTID))
 . I ACTID=+HASERR Q
 . I HASERR>0 Q:$$ISERR(ARRAYNM,ACTID,$P(HASERR,U,2))
 . ;
 . ;   ARRAYNM node value may be just ^
 . ;   STATUS - only include complete or amended or not cosigned notes
 . S TIUIEN=+(@ARRTMP@("TIUIEN"))
 . Q:TIUIEN'>0  Q:'$D(^TIU(8925,TIUIEN))
 . D GETS^DIQ(8925,TIUIEN_",",".05;1202;1301","IE","TIUFLDS","TIUERR")
 . M FLDS=TIUFLDS(8925,TIUIEN_",")
 . S TIUIDATE=FLDS(1301,"I")
 . S TIUEDATE=$E(FLDS(1301,"E"),1,18)
 . S TIUAUTH=FLDS(1202,"E")
 . S STATUS=FLDS(.05,"I")
 . I '((STATUS=6)!(STATUS=7)!(STATUS=8)) Q
 . S TIUACT=$P(@ARRTMP@("ACTION"),U,2)
 . ; -- Increment date if there are multiple notes w/ same exact date:
 . S X=0 F  D  Q:X
 . . I $D(DTARRAY(TIUIDATE)) S TIUIDATE=TIUIDATE+.0000001
 . . I '$D(DTARRAY(TIUIDATE)) S DTARRAY(TIUIDATE)="",X=1
 . . Q
 . I $G(REVERSE) S TIUIDATE=9999999-TIUIDATE
 . I TIUEDATE="" S TIUEDATE="No Ref Date"
 . I TIUAUTH="" S TIUAUTH="No Author"
 . S TIUY=TIUY+1
 . S TIUY(TIUIDATE)=TIUIEN_U_TIUACT_U_TIUEDATE_U_TIUAUTH
 . Q
 G KILL
 ;
GETACTS(TIUY,TIUTTL,DFN) ; RPC TIU GET PRF ACTIONS
 ; RPC Gets PRF Action info
 ; Action in PRF is the reason a History (#26.14) record was created
 ;  Input:
 ;      DFN - [Required] IEN of PATIENT (#2) file
 ;   TIUTTL - [Required] IEN of TIU DOCUMENT DEFINITION (#8925.1) file
 ;  RETURN ARRAY
 ;  .TIUY - passed by reference
 ;          see description of return array from GETHTIU^DGPFAPI1
 ;          reformat data for TIU RPC return
 ;          dg*951 brought in p8
 ;   TIUY(ACTID) = p1^p2^p3^p4^p5^p6^p7^p8 where
 ;   p1 = flag name                      p5 = action date, FM internal
 ;   p2 = assignment ien [.001/#26.13]   p6 = action date, external
 ;   p3 = action name [.03/#26.14]       p7 = file 8925 ien
 ;   p4 = action ien                     p8 = originate facility name
 ;
 ; Returns linkable action for Patient DFN and flag assoc w/ TIUTTL
 ;   Action may be currently linked or not
 ;   Excludes UNLINKABLE actions
 ;     Entered in Error actions (EIE)
 ;     Actions taken prior to that EIE action
 ; Prior to DG*5.3*951, return array used ACTID from GETHTIU^DGPFAPI1
 ; DG*5.3*951 sort array by Originating Facility, always lists the
 ;    History records created by the local facility first.
 ;
 N X,ACTID,ARRAYNM,DG951,FLAG,TIUFLG,UNLINKBL
 ;
 S ARRAYNM=$NA(^TMP("TIUPRFH",$J)) D KILL
 S TIUY=1
 S X=$$GETHTIU^DGPFAPI1(DFN,TIUTTL,ARRAYNM)
 I 'X S TIUY="0^"_$P(X,U,2) G KILL
 ;
 ; -- If no unlinked, linkable actions exist, say so but go on:
 I '$$AVAILACT^TIUPRFL(ARRAYNM,,.UNLINKBL) D
 . S TIUY="0^All linkable Flag actions are already linked"
 . Q
 ;
 ; -- Return ALL linkable actions (linked or not)
 ;    Pre DG*3.5*951
 S TIUFLG=$$GETP("FLAG",2)_U_$$GETP("ASSIGNIEN",1)
 S ACTID=0,DG951=$$PATCH^XPDUTL("DG*5.3*951")
 F  S ACTID=$O(@ARRAYNM@("HISTORY",ACTID)) Q:'+ACTID  D
 . Q:$G(UNLINKBL(ACTID))
 . S TIUY(ACTID)=TIUFLG
 . S $P(TIUY(ACTID),U,3)=$$GETPA("ACTION",2)
 . S $P(TIUY(ACTID),U,4)=$$GETPA("HISTIEN",1)
 . S $P(TIUY(ACTID),U,5)=$$GETPA("DATETIME",1)
 . S $P(TIUY(ACTID),U,6)=$$GETPA("DATETIME",2)
 . S $P(TIUY(ACTID),U,7)=$$GETPA("TIUIEN",1)
 . Q
 ;
 ;    If patch DG*5.3*951, resort return array
 I DG951 D
 . N I,X,Y,APPRVBY,HERE,LOC,NAME,ST3
 . S HERE=$$HERE
 . S ACTID=0 F  S ACTID=$O(TIUY(ACTID)) Q:'ACTID  D
 . . S APPRVBY=$$GETPA("APPRVBY",1)
 . . S Y=$$GETPA("ORIGFAC",1)
 . . S X=$$STN(Y,APPRVBY)
 . . S LOC=$P(X,U)
 . . S ST3=$P(X,U,3)
 . . S NAME=$P(X,U,5)
 . . S $P(TIUY(ACTID),U,8)=NAME
 . . S ^TMP($J,LOC,ST3,NAME,ACTID)=TIUY(ACTID)
 . . Q
 . S Y=TIUY K TIUY S TIUY=Y
 . S I=0,X=$NA(^TMP($J))
 . F  S X=$Q(@X) Q:X=""  Q:$QS(X,1)'=$J  S I=I+1,TIUY(I)=@X
 . Q
 ;
 G KILL
 ;
LINK(TIUY,TIUIEN,ASSGNDA,ACTIEN,DFN) ;RPC Link TIU Doc TIUIEN to
 ; the PRF action
 N TIUTTL
 S TIUTTL=+$G(^TIU(8925,TIUIEN,0))
 I 'TIUTTL S TIUY="0^Document does not exist" Q
 ; Remove any links before making new link
 D UNLINK^TIUPRF1(TIUIEN)
 S TIUY=$$STOTIU^DGPFAPI2(DFN,ASSGNDA,ACTIEN,TIUIEN)
 Q
GETSTAT(TIUY,TIUIEN) ;RPC Gets the status of TIU Doc TIUIEN
 ;Returns STATIEN^STATNAME
 N TIUTTL
 S TIUTTL=+$G(^TIU(8925,TIUIEN,0))
 I 'TIUTTL S TIUY="0^Document does not exist" Q
 S TIUY=$P(^TIU(8925,TIUIEN,0),U,5)
 S TIUY=TIUY_U_$P($G(^TIU(8925.6,TIUY,0)),U,1)
 Q
 ;
ISPRFTTL(TIUY,TIUDA) ;RPC Takes as input 8925.1 IEN
 ; and checks if it is a PRF title
 ; Cf ISPFTTL^TIUPRFL. which is a FUNCTION
 N TIUCAT1,TIUCAT2,TIUD1
 S TIUY=0,TIUD1=""
 S TIUCAT1=+$$DDEFIEN^TIUFLF7("PATIENT RECORD FLAG CAT I","DC")
 S TIUCAT2=+$$DDEFIEN^TIUFLF7("PATIENT RECORD FLAG CAT II","DC")
 S TIUD1=$O(^TIU(8925.1,"AD",TIUDA,TIUD1))
 I TIUD1=TIUCAT1!(TIUD1=TIUCAT2) S TIUY=1
 Q
 ;
 ;-----------------------  PRIVATE SUBROUTINES ------------------------
GETP(NODE,P) S:'$G(P) P=1 Q $P($G(@ARRAYNM@(NODE)),U,P)
GETPA(NODE,P) S:'$G(P) P=1 Q $P($G(@ARRAYNM@("HISTORY",ACTID,NODE)),U,P)
 ;
HERE() ;  get facility
 ;  RETURN file_4_ien ^name ^full_site# ^3-digit_site#
 N X S X=$$SITE^VASITE
 Q X_U_$E($P(X,U,3),1,3)
 ;
ISERR(TDAT,ACTID,HASERR) ; is history record prior to EIE status?
 Q $$ISERR^TIUPRFL(TDAT,ACTID,HASERR)
 ;
KILL K @ARRAYNM,^TMP($J) Q
 ;
STN(INST,APPRVBY) ; get station information
 ;  INPUT PARAMETERS:
 ;   INST - optional - ien to file 4
 ;APPRVBY - optional - pointer to the NEW PERSON file (#200)
 ;                     value from the APPROVED BY field in file 26.14
 ;                     if APPRVBY=.5 then this History record was
 ;                        created at another facility.
 ;  EXTRINSIC FUNCTION returns p1^p2^p3^p4^p5 where
 ;    p1 = L:local; R:remote         p4 = institution-name
 ;    p2 = file_4_ien                p5 = station#_" "_institution-name
 ;    p3 = 3-digit station# or UNK
 ;
 N X,FILE4,STNAME,STNUM,STNUM3
 I '$G(HERE) N HERE S HERE=$$HERE
 S INST=$G(INST),APPRVBY=$G(APPRVBY)
 S (FILE4,STNAME,STNUM,STNUM3)=""
 ;   have file_4 pointer (originating facility)
 I INST>0 D
 . S FILE4=INST,X=$$NS^XUAF4(INST)
 . S STNAME=$P(X,U),STNUM=$P(X,U,2),STNUM3=$E(STNUM,1,3)
 . Q
 ;   do not have file_4 pointer
 I INST<1 D
 . I APPRVBY>.9 D
 . . S FILE4=+HERE,STNAME=$P(HERE,U,2)
 . . S STNUM=$P(HERE,U,3),STNUM3=$P(HERE,U,4)
 . . Q
 . E  S FILE4="",STNAME="UNKNOWN",(STNUM,STNUM3)="UNK"
 . Q
 ;
 S X=$S(STNUM3=$P(HERE,U,4):"L",1:"R")
 S X=X_U_FILE4_U_STNUM3_U_STNAME_U_STNAME
 I STNUM3'="UNK" S $P(X,U,5)=STNUM_" "_STNAME
 Q X
