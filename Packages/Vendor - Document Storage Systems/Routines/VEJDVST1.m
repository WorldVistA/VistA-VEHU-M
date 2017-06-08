VEJDVST1 ;DSS/SGM - RPC TO GET SCHEDULED APPTS ;12/14/2001 15:14
 ;;2.11;VEJDCERT RPCS;;Mar 06, 2002
 Q
 ;
APPT(RET,DATA,VECLIN,SCODE,VEDIV) ;
 ;RPC to get scheduled appts for patient
 ;  DBIA10040 (& 908) - supported IA to read field .01, file 44
 ;  RET - $name of global root that stores data [^TMP("VEJD",$J,"APPT")]
 ; DATA -   required - DFN ^ BEG ^ END ^ ALOC ^ FLG
 ;    DFN - required - patient file ien
 ;    BEG - optional - earliest appointment date/time [fm d/t format]
 ;    END - optional - latest appointment date/time [fm d/t format]
 ;   ALOC - optional - clinic name or file 44 ien [if not then get all]
 ;          this preserved for backward compatibility - 8/27/2001 sgm
 ;    FLG - optional - default = 0 - meaning of value
 ;          0 return active/kept/inpatient/no action taken
 ;          1 return future appts only
 ;          2 return both (0 & 1)
 ; VECLIN, SCODE,VEDIV - added 9/11/01 - sgm
 ; VECLIN - optional - passed by reference
 ;        list of clinic names or iens to use as screen
 ;        VECLIN(#)=clinic name or ien
 ;
 ; SCODE - optional - passed by reference
 ;         list of clinic stop codes to use as screen
 ;         SCODE(#)=3-digit stop code (lookup on C xref)
 ;
 ; VEDIV - optional - passed by reference
 ;         list of medical center divisions to use as screen
 ;         VEDIV(#)=division name or ien
 ;
 ;  return @RET@(#) = ext date.time^ext loc^int date.time^file 44 ptr
 ;
 ;if called from VSIT^VEJDVST, [ZLOC,ZDIV,STOPC] optionally defined
 ;    ZLOC(44-ien)=""
 ;
 N:'$D(ZLOC) ZLOC N:'$D(STOPC) STOPC N:'$D(ZDIV) ZDIV
 N I,X,Y,Z,ALOC,BEG,DFN,DIERR,END,ERR,FLG,VASD
 S RET=$NA(^TMP("VEJD",$J,"APPT")) K @RET
 S X=$$DFN^VEJDVST(+$G(DATA)) I $L(X) S @RET@(1)=X Q
 ;
 ;  set up local variables from DATA
 ;
 F I=1:1:5 S @$P("DFN^BEG^END^ALOC^FLG",U,I)=$P(DATA,U,I)
 I 'END S END=$S('FLG:DT+.25,1:9999999)
 I 'BEG S BEG=$S(FLG=1:$$NOW^XLFDT,1:2500101)
 ;
 ;  check to see if need to screen
 D GET
 I ALOC]"" S ALOC=+$$GET^VEJDVST(44,ALOC) S:ALOC>0 ZLOC(ALOC)=""
 I $D(ZLOC) M VASD("C")=ZLOC
 I $D(LOC) M VASD("C")=LOC
 ;
 ;  vasd(f)=from date.time    vasd(t)=to date.time
 ;  vasd(w):  1-active/kept   2-inpatient   9-no action taken
 S VASD("F")=BEG,VASD("T")=END,VASD("W")=129
 K ^UTILITY("VASD",$J),^TMP("VEJDVST1",$J)
 D SDA^VADPT
 S X=0,I="A"
 F  S I=$O(^UTILITY("VASD",$J,I),-1) Q:'I  D
 .;  ext date.time ^ ext loc ^ fm date.time ^ ptr to 44
 .S Z=$P(^UTILITY("VASD",$J,I,"E"),U,1,2)_U_$P(^("I"),U,1,2)
 .;  check for items that to be screened out
 .I $$CK($P(Z,U,4)) S X=X+1,@RET@(X)=Z
 .Q
 K ^UTILITY("VASD",$J),^TMP("VEJDVST1",$J) D KVA^VADPT
 S:'$D(@RET) @RET@(1)="-1^No appointments found"
 Q
 ;
CK(LOCN,NOSC)   ;  screen out locations if appropriate
 ;  DBIA908 - read field 3.5, file 44
 ;  DBIA1482 - read field 8, file 44
 ;  expects local arrays STOPC, ZLOC, ZDIV
 ;  LOC=ien to file 44 - return 0 if location excluded, else return 1
 ;  NOSC - optional - flag to not check for stop code if coming from
 ;                    VS^VEJDVST1
 N I,X,Y,Z,DIERR,ERR,IEN,VAL,VEJD
 S LOCN=+$G(LOCN)_","
 S VAL=$G(^TMP("VEJDVST1",$J,+LOCN)) I VAL?1N Q VAL
 D GETS^DIQ(44,LOCN,"3.5;8","I","VEJD","ERR")
 S VAL=1 I $D(DIERR) S VAL=0
 I $D(ZLOC),'$D(ZLOC(+LOCN)) S VAL=0
 I $D(ZDIV) S Y=VEJD(44,LOCN,3.5,"I") I Y,'$D(ZDIV(Y)) S VAL=0
 I '$G(NOSC),$D(STOPC) S Y=VEJD(44,LOCN,8,"I") I Y,'$D(STOPC(Y)) S VAL=0
 S ^TMP("VEJDVST1",$J,+LOCN)=VAL
 Q VAL
 ;
GET ;  called from above and VEJDVST2
 ;  DBIA10040 (&908) - read field .01, file 44
 ;  DBIA557 - read field 1, file 40.7
 ;  DBIA417 - read field .01, file 40.8
 ;  expects arrays VECLIN, VEDIV, SCODE - converts values to iens
 ;  setup arrays ZLOC(44-ien)=clinic name
 ;               ZDIV(40.7-ien)=division name
 ;              STOPC(40.8-ien)=3-digit stop code
 I $D(VECLIN) D GETM^VEJDVST(.ZLOC,.VECLIN,44)
 I $D(SCODE) D GETM^VEJDVST(.STOPC,.SCODE,40.7,1,"C")
 I $D(VEDIV) D GETM^VEJDVST(.ZDIV,.VEDIV,40.8)
 Q
