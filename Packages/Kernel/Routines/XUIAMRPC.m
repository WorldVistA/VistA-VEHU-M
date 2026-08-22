XUIAMRPC ;BIR/JFW - MVI New Person Field Monitor RPC ; 3/18/26 11:24am
 ;;8.0;KERNEL;**844**;Jul 10, 1995;Build 1
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**844 - STORY VAMPI-34805 (jfw) RPC entry point to view/edit
 ;        the NEW PERSON FIELD MONITOR (8933.1) File.
 ;
 ;Reference to ^XWB2HL7 supported by IA #3144
 ;
 ;
 ; This functionality is called by several options from the
 ; [MPIM NEW PERSON FLD MNTR MENU] on the MPI.
 ;
EN(XURET,XUDUZ,XUTYP) ;RPC to interact with NEW PERSON FIELD MONITOR File (#8933.1)
 ; 
 ; called from rpc: XUS MVI NEW PERSON FLD MNTR
 ;
 ; Input:
 ;  XUDUZ - NEW PERSON DUZ  (*Required)
 ;            NOTE: Optional when XUTYP is LST to get first Pending entry...
 ;  XUTYP - LST : View Last Entry for a given DUZ (*Optional)
 ;          FLP : Flip last REQUIRES TRANSMISSION Flag for DUZ Entry 
 ;          ALL : Update all PENDING date entries for DUZ to 0 
 ;          ADD : Add an entry for DUZ today if none already exist
 ;
 ; Output: XURET = ^TMP("XUIAMRPC",$J)
 ;  Success: For View Call
 ;            @XURET@(#) = DUZ^MODIFICATION DATE^REQUIRES TRANSMISSION^LAST TRANSMITTED DATE/TIME^LAST EDITED BY^FIELD(S) MODIFIED
 ;            @XURET@(#) ="EOF" 
 ;           For Update Call
 ;            1
 ;     Fail: -1^<Error Information>
 ;
 K XURET
 N XUGBL
 S XUGBL="^TMP("_"""XUIAMRPC"""_","_$J_")"
 K @XUGBL
 I (($G(XUDUZ)="")&($G(XUTYP)="")) D
 .S @XUGBL@(1)="-1^NEW PERSON DUZ NOT PASSED"
 E  D
 .S XUTYP=$G(XUTYP)
 .D:((XUTYP="")!(XUTYP="LST")) VWRECS($G(XUDUZ),$S(XUTYP="LST":1,1:0))
 .D:((XUTYP="FLP")!(XUTYP="ALL")!(XUTYP="ADD")) UPDT(XUDUZ,$S(XUTYP="FLP":"",1:XUTYP))
 .S:(";;LST;FLP;ALL;ADD;"'[(";"_XUTYP_";")) @XUGBL@(1)="-1^INVALID TYPE PASSED"
 S XURET=$NA(@XUGBL)
 Q
 ;
 ; Input:
 ;  XUDUZ - NEW PERSON DUZ  (*Required)
 ;  XULST - 1 : Return Last Entry for DUZ (*Optional)
 ;
 ; Output: XURET = ^TMP("XUIAMRPC",$J)
 ;  Success:
 ;    @XURET@(#) = DUZ^MODIFICATION DATE^REQUIRES TRANSMISSION^LAST TRANSMITTED DATE/TIME^LAST EDITED BY^FIELD(S) MODIFIED
 ;    @XURET@(#) ="EOF"
 ;
 ;    All FIELDS deliminted by '^'
 ;    FIELD(S) MODIFIED multiple is sub-delimited by ';'
 ;
 ;  Fail:
 ;    "-1^No Data to Retrieve"
 ;
VWRECS(XUDUZ,XULST) ;Retrieve ALL pending, the First pending or the Last entry for DUZ in 8933.1
 N XUREC,XUCNT,XUDTE
 S @XUGBL@(1)="-1^No Data to Retrieve"
 S XUREC=0,XUCNT=1
 ;Get Last Entry Entered for DUZ regardless of Status or First Pending Entry (DUZ="")
 ;Note: ;User can only have 1 entry a day in file
 D:(XULST)
 .I (XUDUZ="") D  Q
 ..;Get First pending entry in queue
 ..N XUTDUZ S XUTDUZ=$O(^XTV(8933.1,"ACXMIT",0))
 ..Q:('+XUTDUZ)
 ..S XUREC=$O(^XTV(8933.1,"ACXMIT",XUTDUZ,""))
 ..S:(XUREC) @XUGBL@(XUCNT)=$$GETDATA(XUREC),XUCNT=XUCNT+1
 .;Get Last Entry in File for DUZ (Regardless of State)
 .S XUREC=0,XUDTE=$O(^XTV(8933.1,"C",XUDUZ,""),-1)
 .S:(XUDTE) XUREC=$O(^XTV(8933.1,"C",XUDUZ,XUDTE,""))
 .S:(XUREC) @XUGBL@(XUCNT)=$$GETDATA(XUREC),XUCNT=XUCNT+1
 ;Get all Pending Entries for DUZ
 D:('XULST)
 .F  S XUREC=$O(^XTV(8933.1,"ACXMIT",XUDUZ,XUREC)) Q:(('+XUREC)!XULST)  D
 ..S @XUGBL@(XUCNT)=$$GETDATA(XUREC),XUCNT=XUCNT+1
 S:(XUCNT'=1) @XUGBL@(XUCNT)="EOF"
 Q
 ;
 ;Input:  XUIEN - NEW PERSON FIELD MONITOR Record IEN
 ;Output: DUZ^MODIFICATION DATE^REQUIRES TRANSMISSION^LAST TRANSMITTED DATE/TIME^LAST EDITED BY^FIELD(S) MODIFIED
GETDATA(XUIEN) ;Get Monitor Data
 N XUDTA,XUFLDS
 S XUDTA=$G(^XTV(8933.1,XUIEN,0))
 S XUFLDS=$G(^XTV(8933.1,XUIEN,1))
 S:(XUFLDS[";") XUFLDS=$P(XUFLDS,";",1,$L(XUFLDS,";")-1)  ;Strip off last semi-colon 
 Q $P(XUDTA,"^",2)_"^"_$P(XUDTA,"^")_"^"_$P(XUDTA,"^",3)_"^"_$P(XUDTA,"^",4)_"^"_$P(XUDTA,"^",5)_"^"_XUFLDS
 ;
 ; Input:
 ;  XUDUZ - NEW PERSON DUZ  (*Required)
 ;  XUTYP - ALL : Update all PENDING date entries for DUZ to 0 
 ;          ADD : Add an entry for DUZ today if non-already exist
 ;
 ; Output: XURET = ^TMP("XUIAMRPC",$J)
 ;  Success: 1
 ;     Fail: "-1^<Error Message>"
 ;
UPDT(XUDUZ,XUTYP) ;Add/Update record(s) in 8933.1
 N XUQ,XUREC,XUDTA
 S @XUGBL@(1)="-1^DUZ does NOT exist at Site ("_$P($$SITE^VASITE,"^",3)_")"
 Q:('$D(^VA(200,XUDUZ,0)))
 S @XUGBL@(1)="-1^DUZ does NOT exist in 8933.1 at Site ("_$P($$SITE^VASITE,"^",3)_")"
 Q:('$D(^XTV(8933.1,"C",XUDUZ))&(XUTYP'="ADD"))
 S @XUGBL@(1)=1,XUREC=0,XUQ=0
 ;If Entry already exists for DUZ today then just ensure Pending Transmission
 ;Else Create a new Entry for DUZ today
 I (XUTYP="ADD") D  Q
 .;Quit if entry exists for Today and is already Pending Transmission
 .I $D(^XTV(8933.1,"C",XUDUZ,DT)) D  Q:(XUQ)
 ..S XUREC=$O(^XTV(8933.1,"C",XUDUZ,DT,"")),XUDTA=$G(^XTV(8933.1,XUREC,0))
 ..S:($P(XUDTA,"^",3)) XUQ=1  ;Pending Entry already exists for Today
 ..;Else Update Flag to Pending if entry exists for Today
 ..S:('$P(XUDTA,"^",3)) @XUGBL@(1)=$$UPTFLG(XUREC),XUQ=1
 .;Otherwise Add new Pending Record in 8933.1 for DUZ for Today
 .S @XUGBL@(1)=$$ADDREC(XUDUZ)
 F  S XUREC=$O(^XTV(8933.1,"ACXMIT",XUDUZ,XUREC)) Q:(('+XUREC)!XUQ)  D
 .I (XUTYP="") D  Q  ;Flip oldest pending entry for DUZ
 ..S @XUGBL@(1)=$$UPTFLG(XUREC)
 ..S XUQ=1
 .D:(XUTYP="ALL")  ;Flip ALL Pending Entries for DUZ
 ..S @XUGBL@(1)=$$UPTFLG(XUREC)  ;Flip Transmission Flag
 ..S:(+@XUGBL@(1)<0) XUQ=1  ;Quit if Error
 Q
 ;
 ;Input: IEN of record in 8933.1
UPTFLG(IEN) ;Flip REQUIRES TRANSMISSION Flag
 N XUFLG,XUFDA
 S XUFLG=$P(^XTV(8933.1,IEN,0),"^",3)  ;Current Flag Value
 S XUFDA(8933.1,IEN_",",.03)='XUFLG
 Q $$UPDTFLE(.XUFDA)
 ;
 ;Input: XUDUZ IEN of User to Add Entry for
ADDREC(XUDUZ) ;Add record for Today for DUZ
 N XUFDA
 S XUFDA(8933.1,"+1,",.01)=DT
 S XUFDA(8933.1,"+1,",.02)=XUDUZ
 S XUFDA(8933.1,"+1,",.03)=1  ;Requires transmission
 S XUFDA(8933.1,"+1,",.05)=DUZ  ;User who Edited Record (Postmaster)
 S XUFDA(8933.1,"+1,",1)="202;"
 Q $$UPDTFLE(.XUFDA)
 ;
 ;Input: XUFDA - FileMan Data Array contents to update file with (*Required/By Ref)
 ;Output: Success: 1
 ;           Fail: -1^<ERROR INFO>
UPDTFLE(XUFDA) ;Update NEW PERSON FIELD MONITOR File #8933.1
 N XUEMSG
 L +^XTV(8933.1,0):15
 Q:('$T) "-1^RECORD LOCKED, TRY AGAIN LATER"
 D UPDATE^DIE("","XUFDA","","XUEMSG")
 L -^XTV(8933.1,0)
 Q:($D(XUEMSG)) "-1^ERROR "_"[#"_XUEMSG("DIERR",1)_": "_XUEMSG("DIERR",1,"TEXT",1)_"]"
 Q 1
