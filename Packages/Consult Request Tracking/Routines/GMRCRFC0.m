GMRCRFC0 ;EHRM/JCH - Process IFC HL7 Messages; Jun 30, 2022@08:17:08
 ;;3.0;CONSULT/REQUEST TRACKING;**154,184**;DEC 27, 1997;Build 22
 ;
 Q
EN(HLNEXT,HLQUIT) ;process IFC responses
 ;load message in ^TMP
 K ^TMP("RMPRIF",$J)
 N HLNODE,SEG,I
 N %,RMPR123,RMPR123A,RMPR123I,RMPRISIT,RMPRST,RMPRSITIEN,RMPRSTA
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D
 .I $P(HLNODE,"|")="OBX" D
 ..S ^TMP("RMPRIF",$J,"OBX",$P(HLNODE,"|",2),$P(HLNODE,"|",5))=$E(HLNODE,5,999)
 .I $P(HLNODE,"|")="NTE" D
 ..S ^TMP("RMPRIF",$J,"NTE",$P(HLNODE,"|",2))=$E(HLNODE,5,999)
 .I "OBXNTE"'[$P(HLNODE,"|") D
 ..S ^TMP("RMPRIF",$J,$P(HLNODE,"|"))=$E(HLNODE,5,999)
 ;
CHK ;
 ;is it a NW or DC order?
 I '$D(^TMP("RMPRIF",$J,"ORC")) G EXIT
 S RMPRST=$P(^TMP("RMPRIF",$J,"ORC"),"|",1)
 I RMPRST="OD" S RMPRST=$P(^TMP("RMPRIF",$J,"ORC"),"|",5)
 I (RMPRST'="NW")&(RMPRST'="DC") D EXIT Q
 ;
 I $P($G(^TMP("RMPRIF",$J,"OBR")),"|",4)'["PROSTHETICS IFC" D EXIT Q
 ;
 ;is it a discontinued order? does it have a consult ien?
 ;is there a local consult ien? has it already been filed in 668?
 I RMPRST="NW" D
 .S RMPR123=$P(^TMP("RMPRIF",$J,"OBR"),"|",2)
 .S RMPR123I=$P(RMPR123,U,1),RMPRISIT=$P(RMPR123,U,2)
 ;
 I RMPRST="DC" D
 .S RMPR123=$P(^TMP("RMPRIF",$J,"ORC"),"|",3)
 .S RMPR123I=$P(RMPR123,U,1),RMPRISIT=$P(RMPR123,U,2)
 .S RMPR123A=RMPR123I
TST ;
 ;Consult IEN
 D FIND^DIC(4,,99,,RMPRISIT,1,"D",,,"RMPRSTA")
 S RMPRSITIEN=$G(RMPRSTA("DILIST",2,1)) ;RMPR*3.0*198 sets the institution IEN for discontinued and new consults
 I RMPRST="NW" D
 .S RMPR123A=$O(^GMR(123,"AIFC",RMPRSITIEN,RMPR123I,0))
 ;
 I RMPR123A="" G EXIT
 ;When HL7 link is down possible to get mult NW msg
 I RMPRST="NW" I $D(^RMPR(668,"D",RMPR123A)) D EXIT Q  ; ICR #7131
 S ^TMP("RMPRIF",$J,"GOODTOGO")="OKAY"
 I RMPRST="DC" D  Q
 .N RMPRORC2,RMPRORC3,RMPROBR4
 .S RMPRORC2=$P($G(^TMP("RMPRIF",$J,"ORC")),"|",2)
 .S RMPRORC3=$P($G(^TMP("RMPRIF",$J,"ORC")),"|",3)
 .S RMPROBR4=$P($G(^TMP("RMPRIF",$J,"OBR")),"|",4)
 .I ($P(RMPRORC2,U,2)=$P(RMPRORC3,U,2)),((RMPROBR4["PROSTHETICS IFC")!(RMPROBR4["PSAS")),$$IEN^XUAF4($P(RMPRORC2,U,2))=$$KSP^XUPARAM("INST"),$D(^GMR(123,+RMPRORC3,0)) D
 ..N RMPRDCIN
 ..S RMPRDCIN="" F  S RMPRDCIN=$O(^RMPR(668,"D",RMPR123A,RMPRDCIN)) Q:RMPRDCIN=""  D  ; ICR #7131
 ...D CANCEL(RMPRDCIN)
 .D EXIT
 ;
 ;  Strip off NPI from OBR-16.  wtc 6/29/2022 p184
 ;
 N OBR16 S OBR16=$P($G(^TMP("RMPRIF",$J,"OBR")),"|",16) I $L(OBR16,U)>2,$P(OBR16,U,1)?10N S OBR16=$P(OBR16,U,2,99),$P(^TMP("RMPRIF",$J,"OBR"),"|",16)=OBR16 ;
 ;
 I RMPRST="NW" D EN^RMPRFC4 Q  ; Use Prosthetics to file New Order
 Q
 ;
EXIT ;common exit point
 K ^TMP("RMPRIF",$J)
 D EXIT^RMPRFC4
 Q
 ;
CANCEL(DA) ;cancel suspense (EHRM)
 ;set status to X and cancelled by to duz, date/time.
 ;
 N RMPRERR,RMPRDA,RMPREODT
 I '$G(^RMPR(668,+$G(DA),0)) Q  ; ICR #7131
 I $P(^RMPR(668,DA,0),U,5)'="" Q  ; ICR #7131
 S RMPRDA=DA_","
 D NOW^%DTC S RMPREODT=%
 N FDA,RESULT
 S FDA(668,RMPRDA,14)="X"
 S FDA(668,RMPRDA,17)=.5
 S FDA(668,RMPRDA,18)=RMPREODT
 S FDA(668,RMPRDA,9)=9
 D FILE^DIE("","FDA","RESULT") ; ICR #7131
 L -^RMPR(668,DA)
 Q
