DGREGRED ;ALB/JAM - Residential Address Edit API ; 23 Feb 2018  1:33 PM
 ;;5.3;Registration;**941,1010**;Aug 13, 1993;Build 2
 ;;
 ;
EN(DFN,FLG) ;Entry point
 ;Input: 
 ;  DFN (required) - Internal Entry # of Patient File (#2)
 ;  FLG (optional) - Flags of 1 or 0; if null, 0 is assumed. Details:
 ;    FLG(1) - if 1 let user edit phone numbers (field #.131 and #.132)
 ;    FLG(2) - if 1 display before & after address (and phone if FLG(1)=1) for user confirmation
 N DGINPUT,DGCMP,ICNTRY,CNTRY,FORGN,PSTR,OLDC,FSTR,BAD
 N I,X,Y
 I $G(DFN)="" Q
 S FLG(1)=$G(FLG(1)),FLG(2)=$G(FLG(2))
RETRY  ; Entry point if address must be re-entered
 D GETOLD(.DGCMP,DFN)
 S CNTRY="",ICNTRY=$S(DFN:$P($G(^DPT(DFN,.115)),"^",10),1:"")
 I ICNTRY="" S ICNTRY=1  ;default country is USA if NULL
 S OLDC=DGCMP("OLD",.11573),FORGN=$$FOREIGN^DGADDUTL(DFN,ICNTRY,2,.11573,.CNTRY) I FORGN=-1 Q
 K FSTR,PSTR S FSTR=$$INPT1(FORGN,.PSTR)      ;set up field string of address prompts
 K DGINPUT S DGINPUT=1 D INPUT(.DGINPUT,DFN,FSTR,CNTRY) I $G(DGINPUT)=-1 Q
 ; initialize valid address flag
 S BAD=0
 ; if flag is set, show old and new address 
 I FLG(2)=1 D COMPARE(.DGINPUT,.DGCMP)
 I '$$CONFIRM("ADDRESS") W !,"Address change aborted." G PHONE    ;Not saving address - go to phone saving process
 ; Validate the address fields and set BAD=1 if not valid
 I DGINPUT(.1151)=""!(DGINPUT(.1154)="") D  S BAD=1
 . I 'FORGN W !!?3,*7,"RESIDENTIAL ADDRESS [LINE 1], ZIP CODE and CITY fields are required."
 . I FORGN W !!?3,*7,"RESIDENTIAL ADDRESS [LINE 1] and CITY fields are required."
 ; If address is valid, next check is for PO Box and General Delivery - 
 ;    Pass in LINE 1, State and Country codes
 I 'BAD I $$POBOXRES^DGREGCP2(DGINPUT(.1151),$P($G(DGINPUT(.1155)),"^",2),$P(DGINPUT(.11573),"^",2)) D  S BAD=1
 . W !!?3,*7,"You cannot enter 'P. O. Box' or 'General Delivery' for a Residential Address."
 ; If all Validations passed - save the address
 I 'BAD D SAVE(.DGINPUT,DFN,FSTR,FORGN)
PHONE ; Process the phone number changes IF FLG(1) = 1
 I $G(FLG(1))=1 D
 . ; if compare flag is set, display old/new values
 . I $G(FLG(2))=1 D COMPAREP(.DGINPUT,.DGCMP)
 . I '$$CONFIRM("PHONE") W !,"Phone changes aborted." D EOP
 . E  D SAVEPH(.DGINPUT,DFN)
 ; Phone number process is completed - go to RETRY if address validation failed
 I BAD G RETRY
 Q
INPUT(DGINPUT,DFN,FSTR,CNTRY) ;Let user input address changes
 ; Output: DGINPUT(field#)=external^internal(if any)
 N DIR,X,Y,DA,DGR,DTOUT,DUOUT,DIROUT,DGN,L
 F L=1:1:$L(FSTR,",") S DGN=$P(FSTR,",",L),DGINPUT(DGN)="" Q:DGINPUT=-1  D
 . I $$SKIP(DGN,.DGINPUT,.FLG) Q
 . I DGN=.1156 D ZIPINP(.DGINPUT,DFN) Q
 . I '$$READ(DFN,DGN,.Y) S DGINPUT=-1 Q
 . S DGINPUT(DGN)=$G(Y)
 I DGINPUT'=-1 S DGINPUT(.11573)=CNTRY_"^"_$O(^HL(779.004,"B",CNTRY,""))
 Q
GETOLD(DGCMP,DFN) ;populate array with existing address info
 K DGCMP
 N CCIEN,DGCURR,CFORGN,CFSTR,L,T,DGCIEN,DGST,DGCNTY,COUNTRY
 S CFORGN=0
 ; get current country
 S CCIEN=$S(DFN:$$GET1^DIQ(2,DFN_",",.11573,"I"),1:"")
 S CFORGN=$$FORIEN^DGADDUTL(CCIEN)
 ; get current address fields and xlate to ^DIQ format
 S CFSTR=$$INPT1(CFORGN),CFSTR=$TR(CFSTR,",",";")
 ; Domestic data needs some extra fields
 I 'CFORGN S CFSTR=CFSTR_";.1154;.1155;.1157"
 I DFN D GETS^DIQ(2,DFN_",",CFSTR,"EI","DGCURR")
 F L=1:1:$L(CFSTR,";") S T=$P(CFSTR,";",L),DGCMP("OLD",T)=$G(DGCURR(2,DFN_",",T,"E"))
 S COUNTRY=$$CNTRYI^DGADDUTL(CCIEN) I COUNTRY=-1 S COUNTRY="UNKNOWN COUNTRY"
 S DGCMP("OLD",.11573)=COUNTRY_"^"_CCIEN
 I 'CFORGN D
 . S DGCIEN=$G(DGCURR(2,DFN_",",.1157,"I"))
 . S DGST=$G(DGCURR(2,DFN_",",.1155,"I"))
 . S DGCNTY=$$CNTY^DGREGAZL(DGST,DGCIEN)
 . I DGCNTY=-1 S DGCNTY=""
 . S DGCMP("OLD",.1157)=$P(DGCNTY,U)_" "_$P(DGCNTY,U,3)
 Q
 ;
COMPARE(DGINPUT,DGCMP) ;Display before & after address fields.
 N DGM,DGCNTY
 M DGCMP("NEW")=DGINPUT
 W !
 F DGM="OLD","NEW" D
 . I DGCMP(DGM,.11573)]"",$$FORIEN^DGADDUTL($P(DGCMP(DGM,.11573),U,2)) D DISPFGN(.DGCMP,DGM) Q
 . I DGM="NEW" D
 . . S DGCNTY=$P($G(DGCMP("NEW",.1157)),U)_" "_$P($G(DGCMP("NEW",.1157)),U,3)
 . . S DGCMP("NEW",.1157)=DGCNTY
 . . I ($L(DGCMP("NEW",.1156))>5)&($P(DGCMP("NEW",.1156),"-",2)="") S DGCMP("NEW",.1156)=$E(DGCMP("NEW",.1156),1,5)_"-"_$E(DGCMP("NEW",.1156),6,9)
 . D DISPUS(.DGCMP,DGM)
 Q
 ;
COMPAREP(DGINPUT,DGCMP) ;Display before & after phone fields.
 N DGM
 M DGCMP("NEW")=DGINPUT
 W !
 F DGM="OLD","NEW" D
 . W !,?2,"[",DGM," PHONE NUMBERS]"
 . W !,?6,"   Phone: ",?16,$P($G(DGCMP(DGM,.131)),U)
 . W !,?6,"  Office: ",?16,$P($G(DGCMP(DGM,.132)),U)
 . W !
 Q
 ;
DISPUS(DGCMP,DGM) ;tag to display US data
 N DGCNTRY
 W !,?2,"[",DGM," RESIDENTIAL ADDRESS]"
 W !?16,$P($G(DGCMP(DGM,.1151)),U)
 I $P($G(DGCMP(DGM,.1152)),U)'="" W !,?16,$P($G(DGCMP(DGM,.1152)),U)
 I $P($G(DGCMP(DGM,.1153)),U)'="" W !,?16,$P($G(DGCMP(DGM,.1153)),U)
 W !,?16,$P($G(DGCMP(DGM,.1154)),U)
 W:($P($G(DGCMP(DGM,.1154)),U)'="")!($P($G(DGCMP(DGM,.1155)),U)'="") ","
 W $P($G(DGCMP(DGM,.1155)),U)
 W " ",$G(DGCMP(DGM,.1156))
 S DGCNTRY=$$CNTRYI^DGADDUTL($P($G(DGCMP(DGM,.11573)),U,2))
 I DGCNTRY]"",(DGCNTRY'=-1) W !?16,DGCNTRY
 I $P($G(DGCMP(DGM,.1157)),U)'="" W !,?6,"  County: ",$P($G(DGCMP(DGM,.1157)),U)
 W !
 Q
 ;
DISPFGN(DGCMP,DGM) ;tag to display Foreign data
 N DGCNTRY
 W !,?2,"[",DGM," RESIDENTIAL ADDRESS]"
 W !?16,$P($G(DGCMP(DGM,.1151)),U)
 I $P($G(DGCMP(DGM,.1152)),U)'="" W !,?16,$P($G(DGCMP(DGM,.1152)),U)
 I $P($G(DGCMP(DGM,.1153)),U)'="" W !,?16,$P($G(DGCMP(DGM,.1153)),U)
 ;W !,?16,$P($G(DGCMP(DGM,.11572)),U)_" "_$P($G(DGCMP(DGM,.1154)),U)_" "_$P($G(DGCMP(DGM,.11571)),U) ;DG*1010 comment out
 W !,?16,$P($G(DGCMP(DGM,.1154)),U)_" "_$P($G(DGCMP(DGM,.11571)),U)_" "_$P($G(DGCMP(DGM,.11572)),U) ;DG*1010 - display postal code last
 S DGCNTRY=$$CNTRYI^DGADDUTL($P($G(DGCMP(DGM,.11573)),U,2))
 S DGCNTRY=$S(DGCNTRY="":"UNSPECIFIED COUNTRY",DGCNTRY=-1:"UNKNOWN COUNTRY",1:DGCNTRY)
 I DGCNTRY]"" W !?16,DGCNTRY
 W !
 Q
 ;
CONFIRM(TYPE) ;Confirm if user wants to save the changes 
 ; TYPE - used for the query message displayed to the user: "address" or "phone number"
 N DIR,X,Y,DTOUT,DUOUT,DIROUT
 S DIR(0)="Y"
 S DIR("A")="Are you sure that you want to save the "_TYPE_" changes"
 S DIR("?")="Please answer Y for YES or N for NO."
 D ^DIR
 I $D(DTOUT)!($G(Y)=0) Q 0
 I $D(DUOUT)!$D(DIROUT) Q 0
 Q 1
 ;
SAVE(DGINPUT,DFN,FSTR,FORGN) ;Save changes
 N DGN,DGER,DGM,L,DATA
 S DGER=0
 ; need to get the country code into the DGINPUT array
 ; if it's a domestic address, we have to add in CITY,STATE & COUNTY
 S FSTR=FSTR_$S('FORGN:",.1154,.1155,.1157,.11573",1:",.11573")
 F L=1:1:$L(FSTR,",") S DGN=$P(FSTR,",",L) D
 . ; Phone numbers saved separately - skip over here
 . I (DGN=.131)!(DGN=.132) Q
 . N DGCODE,DGNAME,FDA,MSG
 . S DGCODE=$P($G(DGINPUT(DGN)),U,2)
 . S DGNAME=$P($G(DGINPUT(DGN)),U)
 . S FDA(2,DFN_",",DGN)=$S(DGCODE:DGCODE,1:DGNAME)
 . D FILE^DIE($S(DGCODE:"",1:"E"),"FDA","MSG")
 . I $D(MSG) D
 .. S DGM="",DGER=1
 .. W !,"Please review the saved changes!!",!
 .. F  S DGM=$O(MSG("DIERR",1,"TEXT",DGM)) Q:DGM=""  D
 ... W $G(MSG("DIERR",1,"TEXT",DGM))
 I $G(DGER)=0 W !,"Change saved." D
 . ; Set the CASS IND field 
 . S DATA(.1159)="NC"
 . I $$UPD^DGENDBS(2,DFN,.DATA)
 D EOP
 Q
 ;
SAVEPH(DGINPUT,DFN) ;Save phone changes
 N DGN,DGER,DGM,DATA
 S DGER=0
 F DGN=.131,.132 D
 . N DGCODE,DGNAME,FDA,MSG
 . S DGCODE=$P($G(DGINPUT(DGN)),U,2)
 . S DGNAME=$P($G(DGINPUT(DGN)),U)
 . S FDA(2,DFN_",",DGN)=$S(DGCODE:DGCODE,1:DGNAME)
 . D FILE^DIE($S(DGCODE:"",1:"E"),"FDA","MSG")
 . I $D(MSG) D
 .. S DGM="",DGER=1
 .. W !,"Please review the saved changes!!",!
 .. F  S DGM=$O(MSG("DIERR",1,"TEXT",DGM)) Q:DGM=""  D
 ... W $G(MSG("DIERR",1,"TEXT",DGM))
 I $G(DGER)=0 W !,"Change saved."
 D EOP
 Q
 ;
READ(DFN,DGN,Y) ;Read input, return success
 N SUCCESS,DIR,DA,DTOUT,DUOUT,DIROUT,L,POP
 S SUCCESS=1,POP=0
 F L=0:0 D  Q:POP
 . S DIR(0)=2_","_DGN
 . I DFN S DA=DFN
 . D ^DIR
 . I $D(DTOUT) S POP=1,SUCCESS=0 Q
 . I $D(DUOUT)!$D(DIROUT) D UPCT Q
 . S POP=1
 Q SUCCESS
INPT1(FORGN,PSTR) ; first address input prompts
 N FSTR
 ; PSTR is the full set of fields domestic & foreign combined
 ; FSTR is the set of fields depending on Country code
 S PSTR=".1151,.1152,.1153,.1154,.1155,.1157,.1156,.11571,.11572,.11573,.131,.132"
 S FSTR=".1151,.1152,.1153,.1156,.131,.132"
 I FORGN S FSTR=".1151,.1152,.1153,.1154,.11571,.11572,.131,.132"
 Q FSTR
ZIPINP(DGINPUT,DFN) ; get ZIP+4 input
 ; This subroutine calls existing code to prompt for zip code and return corresponding city, state and county
 ; DFN must be the patient internal ID.  
 ; DGINPUT - passed by reference - the array containing the resulting county, city, and state for the zipcode.
 N FCITY,FZIP,FSTATE,FCOUNTY,TYPE,DGR
 ; Set the necessary variables for the Residential Address
 ; The variable TYPE is used for Confidential and temporary address types. 
 ; Here for the Residential Address we clear this variable.
 S FZIP=".1156",FCITY=".1154",FSTATE=".1155",FCOUNTY=".1157",TYPE=""
 D EN^DGREGTZL(.DGR,DFN)
 M DGINPUT=DGR
 Q
SKIP(DGN,DGINPUT,FLG) ; determine whether or not to skip this step
 N SKIP
 S SKIP=0
 I ($G(DGINPUT(.1151))="")&((DGN=.1152)!(DGN=.1153)) S SKIP=1
 I ($G(DGINPUT(.1152))="")&(DGN=.1153) S SKIP=1
 I ($G(FLG(1))'=1)&((DGN=.131)!(DGN=.132)) S SKIP=1
 Q SKIP
EOP ;End of page prompt
 N DIR,DTOUT,DUOUT,DIROUT,X,Y
 S DIR(0)="E"
 S DIR("A")="Press ENTER to continue"
 D ^DIR
 Q
UPCT ;Indicate "^" or "^^" are unacceptable inputs.
 W !,"EXIT NOT ALLOWED"
 Q
