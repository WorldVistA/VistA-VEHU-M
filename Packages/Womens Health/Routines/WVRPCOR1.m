WVRPCOR1 ;ISP/RFR - CPRS RPCS CONTINUED ;Oct 19, 2020@14:42
 ;;1.0;WOMEN'S HEALTH;**24,26**;Sep 30, 1998;Build 624
 Q
EIE(WVRETURN,WVRECID,WVREASON) ;MARK DATA AS ENTERED IN ERROR
 ;RPC: WVRPCOR EIE
 ;WVRECID=790_GLOBAL_NODE_#;IENS
 N WVFDA,WVERROR,WVFNUMS,WVFILE,WVIENS,WVTYPES,WVEXTERNAL,WVNODE,WVCNT,WVCUR,WVDFN
 I $G(WVRECID)="" S WVRETURN=-1_U_"No record ID specified." Q
 I $D(WVREASON)<10 S WVRETURN=-1_U_"No reason(s) specified." Q
 S WVDFN=$P($P(WVRECID,";",2),",",2)
 D SETUP^WVRPCOR
 S WVRETURN=0_U,WVFNUMS(790.05)=790.15,WVFNUMS(790.16)=790.18
 S WVNODE=$P(WVRECID,";",1)
 I WVNODE="" S WVRETURN=-1_U_"Invalid record ID specified: "_WVRECID Q
 I '$D(WVTYPES(WVNODE)) S WVRETURN=-1_U_"Invalid record ID specified: "_WVRECID Q
 S WVFILE=$P(WVTYPES(WVNODE),U,2),WVIENS=$P(WVRECID,";",2)
 I +$P(WVIENS,",")<1 S WVRETURN=-1_U_"Invalid record ID specified: "_WVRECID Q
 I $P($G(^WV(790,$P(WVIENS,",",2),WVNODE,$P(WVIENS,","),0)),U,6) D  Q
 .S WVRETURN=-1_U_"That record is already marked as entered in error. Please refresh the Women's Health panel before continuing."
 I '$D(WVOVRIDE) D  Q:+WVRETURN=-1
 .S WVCUR=+$$GETLREC^WVUTL11($P(WVIENS,",",2),WVNODE)
 .I 'WVCUR S WVRETURN=-1_U_"There is no current status record. Please refresh the Women's Health panel before continuing." Q
 .I $P(WVIENS,",")'=WVCUR S WVRETURN=-1_U_"A newer status record exists. Please refresh the Women's Health panel before continuing." Q
 S WVFDA(WVFILE,WVIENS,6)="1"
 D FILE^DIE(,"WVFDA","WVERROR")
 I $D(WVERROR) S WVRETURN=-1_U_$$FMERROR^WVUTL11(.WVERROR) Q
 I '$D(WVERROR) S WVRETURN=1_U
 S WVREASON="" F  S WVREASON=$O(WVREASON(WVREASON)) Q:WVREASON=""  D
 .S WVCNT=1+$G(WVCNT),WVFDA(WVFNUMS(WVFILE),"+"_WVCNT_","_WVIENS,.01)=WVREASON(WVREASON)
 D UPDATE^DIE(,"WVFDA",,"WVERROR")
 I $D(WVERROR) S WVRETURN=-1_U_$$FMERROR^WVUTL11(.WVERROR) Q
 Q
REASONS(WVRETURN) ;RETURN A LIST OF PRE-DEFINED REASONS FOR USE IN MARKING A
 ;                STATUS AS ENTERED IN ERROR
 ;RPC: WVRPCOR REASONS
 N WVSEQ,WVIEN,WVSITE,WVIDX,WVDATA,WVERROR,WVREASON
 ;SITE-SPECIFIC REASONS
 I $G(DUZ(2))?1.N D
 .S WVSITE=DUZ(2),WVIDX=0
 .S WVSEQ="" F  S WVSEQ=$O(^WV(790.02,WVSITE,43,"B",WVSEQ)) Q:WVSEQ=""  D
 ..S WVIEN=0 F  S WVIEN=$O(^WV(790.02,WVSITE,43,"B",WVSEQ,WVIEN)) Q:'+WVIEN  D
 ...S WVIDX=WVIDX+1,WVRETURN(WVIDX)=$P($G(^WV(790.02,WVSITE,43,WVIEN,0)),U,2)
 ;PACKAGE-SPECIFIC REASONS
 D GETLST^XPAR(.WVDATA,"PKG","WV ENTERED IN ERROR REASONS","Q",.WVERROR)
 F WVREASON=1:1:WVDATA  S WVIDX=WVIDX+1,WVRETURN(WVIDX)=$P(WVDATA(WVREASON),U,2)
 Q
SITES(WVRETURN) ;RETURN A LIST OF WEB SITES FOR DISPLAY ON THE COVER SHEET
 ;RPC: WVRPCOR SITES
 D GETLST^XPAR(.WVRETURN,"ALL","WV COVER SHEET WEBSITES","Q")
 S WVRETURN(0)="Informational Web Sites"
 Q
CONSAVE(WVRETURN,WVDFN) ;DETERMINE WHETHER TO PROMPT USER TO CONFIRM SAVING DATA
 ;RPC: WVRPCOR1 CONSAVE
 N WVTYPES,WVEXTERNAL,WVAPPL,WVNODE,WVWARN,WVDELIM,WVITEM,WVRIEN
 D SETUP^WVRPCOR
 S WVRETURN(0)=""
 S WVNODE=0 F  S WVNODE=$O(WVTYPES(WVNODE)) Q:'+WVNODE!(+$G(WVAPPL)=-1)  D
 .S WVAPPL=$$APPL^WVRPCOR(WVDFN,WVNODE) Q:+WVAPPL=-1
 .I '+WVAPPL S WVWARN=1+$G(WVWARN),WVWARN(WVWARN)=$P(WVTYPES(WVNODE),U,4) I WVWARN>1 S WVWARN(WVWARN)=$$LOW^XLFSTR(WVWARN(WVWARN))
 I +$G(WVAPPL)=-1 S WVRETURN(0)=WVAPPL Q
 S WVDELIM=", ",WVITEM=0 F  S WVITEM=$O(WVWARN(WVITEM)) Q:'+WVITEM  D
 .I WVITEM=WVWARN-1 S WVDELIM=" and "
 .S WVRETURN(0)=$S(WVRETURN(0)'="":WVRETURN(0)_WVDELIM,1:"")_WVWARN(WVITEM)
 S WVRIEN=$O(^PXRMD(801.41,"B","VA-WH TD PREGNANCY STATUS YES LMPD",""))
 S WVRETURN(1)="datesCal"_U_WVRIEN
 I WVRETURN(0)="" S WVRETURN(0)=0_U Q
 S WVRETURN(0)=1_U_WVRETURN(0)_" data "_$S(WVWARN<2:"is",1:"are")_" not required for this patient. Do you want to continue updating data for this patient?"
 Q
