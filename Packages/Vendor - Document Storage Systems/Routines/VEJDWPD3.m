VEJDWPD3 ;wpb/swo routine modified for dental GUI;8.2.98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ; SLC/KCM - General Utilites for Windows Calls;06:05 PM  3 Jun 1998
 ;ORWU;3.0;ORDER ENTRY/RESULTS REPORTING;**10**;Dec 17, 1997
 ;
DT(Y,X) ; Returns internal Fileman Date/Time
 ; change the '00:00' that could be passed so Fileman doesn't reject
 I $L($P(X,"@",2)),("00000000"[$TR($P(X,"@",2),":","")) S $P(X,"@",2)="00:00:01"
 N %DT S %DT="TS" D ^%DT
 Q
VALDT(Y,X,%DT) ; Validate date/time entry
 S:'$D(%DT) %DT="TX" D ^%DT
 Q
USERINFO(REC) ; return relevant info for current user
 ; return DUZ^NAME^USRCLS^CANSIGN^ISPROVIDER^ORDERROLE^NOORDER^DTIME
 S REC=DUZ_U_$P(^VA(200,DUZ,0),U)
 S $P(REC,U,3)=$S($D(^XUSEC("ORES",DUZ)):3,$D(^XUSEC("ORELSE",DUZ)):2,$D(^XUSEC("OREMAS",DUZ)):1,1:0)
 S $P(REC,U,4)=$D(^XUSEC("ORES",DUZ))&$D(^XUSEC("PROVIDER",DUZ))
 S $P(REC,U,5)=$D(^XUSEC("PROVIDER",DUZ))
 S $P(REC,U,6)=$$ORDROLE
 S $P(REC,U,7)=0
 S $P(REC,U,8)=1800
 I '$P(REC,U,8),$G(DTIME) S $P(REC,U,8)=DTIME
 Q
HASKEY(VAL,KEY) ; returns TRUE if the user possesses the security key
 S VAL=''$D(^XUSEC(KEY,DUZ))
 Q
ORDROLE()    ; returns the role a person takes in ordering
 ; VAL: 0=nokey, 1=clerk, 2=nurse, 3=physician, 4=student, 5=bad keys
 I ($D(^XUSEC("OREMAS",DUZ))+$D(^XUSEC("ORELSE",DUZ))+$D(^XUSEC("ORES",DUZ)))>1 Q 5
 I $D(^XUSEC("OREMAS",DUZ)) Q 1                           ; clerk
 I $D(^XUSEC("ORELSE",DUZ)) Q 2                           ; nurse
 I $D(^XUSEC("ORES",DUZ)),$D(^XUSEC("PROVIDER",DUZ)) Q 3  ; doctor
 I $D(^XUSEC("PROVIDER",DUZ)) Q 4                         ; student
 Q 0
VALIDSIG(ESOK,X) ; returns TRUE if valid electronic signature
 S X=$$DECRYP^XUSRB1(X),ESOK=0                   ; network encrypted
 D HASH^XUSHSHP
 I X=$P($G(^VA(200,+DUZ,20)),U,4) S ESOK=1
 Q
TOOLMENU(LST) ; returns a list of items for the Tools menu
 ;D GETLST^XPAR(.LST,"ALL","ORWT TOOLS MENU","N")
 Q
ACTLOC(LOC) ; Function: returns TRUE if active hospital location
 N D0,X I +$G(^SC(LOC,"OOS")) Q 0                ; screen out OOS entry
 S D0=+$G(^SC(LOC,42)) I D0 D WIN^DGPMDDCF Q 'X  ; chk out of svc wards
 S X=$G(^SC(LOC,"I")) I +X=0 Q 1                 ; no inactivate date
 I DT>$P(X,U)&($P(X,U,2)=""!(DT<$P(X,U,2))) Q 0  ; chk reactivate date
 Q 1                                             ; must still be active
 ;
CLINLOC(Y,FROM,DIR) ; Return a set of clinics from HOSPITAL LOCATION
 ; .Y=returned list, FROM=text to $O from, DIR=$O direction,
 N I,IEN,CNT S I=0,CNT=44
 F  Q:I=CNT  S FROM=$O(^SC("B",FROM),DIR) Q:FROM=""  D
 . S IEN=$O(^SC("B",FROM,0))
 . I ($P($G(^SC(IEN,0)),U,3)'="C")!('$$ACTLOC(IEN)) Q
 . S I=I+1,Y(I)=IEN_"^"_FROM
 Q
HOSPLOC(Y,FROM,DIR) ; Return a set of locations from HOSPITAL LOCATION
 ; .Y=returned list, FROM=text to $O from, DIR=$O direction,
 N I,IEN,CNT S I=0,CNT=44
 F  Q:I=CNT  S FROM=$O(^SC("B",FROM),DIR) Q:FROM=""  D
 . S IEN=$O(^SC("B",FROM,0)) I '$$ACTLOC(IEN) Q
 . S I=I+1,Y(I)=IEN_"^"_FROM
 Q
NEWPERS(Y,FROM,DIR,KEY) ; Return a set of names from the NEW PERSON file
 ; .Y=returned list, FROM=text to $O from, DIR=$O direction,
 ;  KEY=screen users by security key (optional)
 N I,IEN,CNT S I=0,CNT=44,KEY=$G(KEY)
 F  Q:I=CNT  S FROM=$O(^VA(200,"B",FROM),DIR) Q:FROM=""  D
 . S IEN=$O(^VA(200,"B",FROM,0)) I $L(KEY),'$D(^XUSEC(KEY,IEN)) Q
 . S I=I+1,Y(I)=IEN_"^"_FROM
 Q
GENERIC(Y,FROM,DIR,REF) ; Return a set of entries from xref in REF
 ; .Y=returned list, FROM=text to $O from, DIR=$O direction,
 N I,IEN,CNT S I=0,CNT=44
 F  Q:I=CNT  S FROM=$O(@REF@(FROM),DIR) Q:FROM=""  D
 . S IEN=0 F  S IEN=$O(@REF@(FROM,IEN)) Q:'IEN  D
 . . S I=I+1,Y(I)=IEN_"^"_FROM
 Q
EXTNAME(VAL,IEN,FN) ; return external form of pointer
 ; IEN=internal number, FN=file number
 N REF S REF=$G(^DIC(FN,0,"GL")),VAL=""
 I $L(REF),+IEN S VAL=$P($G(@(REF_IEN_",0)")),U)
 Q
DEVICE(Y,FROM,DIR) ; Return a subset of entries from the Device file
 ; .LST(n)=IEN;Name^DisplayName^Location^RMar^PLen
 ; FROM=text to $O from, DIR=$O direction
 N I,IEN,CNT,SHOW,X S I=0,CNT=20
 F  Q:I'<CNT  S FROM=$O(^%ZIS(1,"B",FROM),DIR) Q:FROM=""  D
 . S IEN=0 F  S IEN=$O(^%ZIS(1,"B",FROM,IEN)) Q:'IEN  D
 . . I $E($G(^%ZIS(2,+$G(^%ZIS(1,IEN,"SUBTYPE")),0)))'="P" Q
 . . S X=+$G(^%ZIS(1,IEN,90)) I X,(X'>DT) Q
 . . S X=$G(^%ZIS(1,IEN,0)) I ($P(X,U,2)="0")!($P(X,U,12)=2) Q
 . . S SHOW=$P(X,U) I SHOW'=FROM S SHOW=FROM_"  <"_SHOW_">"
 . . S I=I+1,Y(I)=IEN_";"_$P(X,U)_U_SHOW_U_$P($G(^%ZIS(1,IEN,1)),U)_U_$P($G(^(91)),U)_U_$P($G(^(91)),U,3)
 Q
URGENCY(Y) ; -- retrieve set values from dd for discharge summary urgency
 N ORDD,I,X
 D FIELD^DID(8925,.09,"","POINTER","ORDD")
 F I=1:1 S X=$P(ORDD("POINTER"),";",I) Q:X=""   S Y(I)=$TR(X,":","^")
 Q
PATCH(VAL,X) ; Return 1 if patch X is installed
 S VAL=$$PATCH^XPDUTL(X)
 Q
VERSRV(VAL,X)   ; Return server version of option name
 N IEN S VAL="",IEN=$O(^DIC(19,"B",X,0)) Q:'IEN
 S VAL=$P($P($G(^DIC(19,IEN,0)),U,2),"version ",2)
 Q
  
  
