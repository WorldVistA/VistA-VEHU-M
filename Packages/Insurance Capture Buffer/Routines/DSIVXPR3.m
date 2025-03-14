DSIVXPR3 ;DSS/AJ - RPCs/APIs FOR PARAMETERS ;4/27/2016 11:52
 ;;2.2;INSURANCE CAPTURE BUFFER;**12**;May 19, 2009;Build 13
 ;Copyright 1995-2016, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;This is only called from DSIVXPR routine
 ;This routine encapsulates the Parameter terminal interactive tools for
 ;editing Kernel Parameters.
 ;
 ;DBIA#  Supported Reference
 ;-----  ---------------------------------------------------------------
 ; 2051  ^DIC: FIND, $$FIND1
 ; 2056  ^DIQ: GETS
 ; 2263  ^XPAREDIT: EDITPAR
 ; 3127  FM read access to all of file 8989.51 [controlled subscription]
 ;
EDIT ; interactive prompt to select parameter then edit 8989.5
 ; P - opt - namespace of parameter to used as a screen
 N X,Y,Z,CNT,DSIVPAR
 Q:'$D(P)  I $D(P)=1,P="" Q
 S CNT=0
 I $G(P)'="" S DSIVPAR(P)="",CNT=1+CNT
 S Y="" F  S Y=$O(P(Y)) Q:Y=""  S DSIVPAR(Y)="",CNT=1+CNT
 F  S X=$$DIC Q:X<1  D  Q:CNT<1
 .S DSIVPAR=$P(X,U,2)
 .F  D  Q:X<1
 ..W @IOF,!!,"Editing Parameter "_DSIVPAR,!
 ..D EDITPAR^XPAREDIT(DSIVPAR)
 ..S X=$$DIR
 ..Q
 .Q
 Q
 ;
LIST ; this will return a single Parameter Definition or a list of them.
 ; NAME - opt - if you want the parameter definition for a single
 ;              parameter then pass that parameter name here
 ; PREFIX - opt - retrieve a list of parameter definitions starting with
 ;                the text you pass here, eg., DSIV for all DSIV params
 ; Note: you must pass either NAME or PREFIX.  If name is passed then
 ;       prefix is ignored.
 ;----------  RETURN values for RPC Broker call  ----------
 ; DSIVL(n) = data   for n=1,2,3,4,
 ; DSIVL(i) is multi-lined for each parameter in the following format:
 ; DSIVL(a) = p1^p2^p3^p4  for PARAMETER DEFINITION
 ;            p1 = $START   p2 = ifn   p3 = name
 ;            p4 = Boolean multi-valued (1/0/"")
 ; DSIVL(b) = p1^p2^p3^p4 for INSTANCE
 ;            p1 = term    p2 = data type code   p3 = data type
 ;            p4 = domain
 ; DSIVL(c) = p1^p2^p3^p4 for VALUE
 ;            p1 = term    p2 = data type code   p3 = data type
 ;            p4 = domain
 ; DSIVL(d) = s1;s2;s3^s1;s2;s3^s1;s2;s3^...  [list of entities]
 ;            s1 = precedence order number
 ;            s2 = entity name         s3 = entity abbreviation
 ; DSIVL(e,f,g,h,...) = parameter description [WP field]
 ; DSIVL(x) = $END
 ; Each parameter definition will have a minimum of 5 lines or more
 ; depending upon whether or not the parameter definition has a
 ; description.
 ;----------  RETURN values if called from non-Broker process  ---------
 ; DSIVL(param name) = ifn ^ Boolean multi-valued (1/0/"")
 ; DSIVL(param name,"INST") = p1^p2^p3^p4 for INSTANCE [see above]
 ; DSIVL(param name,"VAL") = p1^p2^p3^p4 for VALUE [see above]
 ; DSIVL(param name,"DESC",i) = description text
 ; DSIVL(param name,"SEQ",precedence#) = entity ^ entity abbrev
 ;
 ; If no data or errors encountered, then return
 ; DSIVL(1) = -1^msg
 ; DSIVL(2,3,4,5,...) = additional messages if appropriate
 ;
 N I,X,Y,Z,DIERR,DSI,DSIB,DSIEN,DSIERR,DSIX,DSIY,TMP
 S NAME=$G(NAME),PREFIX=$G(PREFIX)
 I NAME="",PREFIX="" S DSIVL(1)="-1^No lookup value recevied" Q
 I NAME'="" S PREFIX="" D  Q:$D(DSIVL)
 .N PREFIX S DSI=NAME
 .I DSI=+DSI S DSI="`"_DSI ; assume param def ifn
 .S X=$$FIND1^DIC(8989.51,,"AQX",DSI,"B",,"DSIERR")
 .I $D(DIERR) D ERR(1) Q
 .I 'X D ERR(2) Q
 .S DSIX("DILIST",1,0)=X_U_DSI
 .Q
 I PREFIX'="" D  Q:$D(DSIVL)
 .S DSI=PREFIX
 .D FIND^DIC(8989.51,,"@;.01","PQ",PREFIX,,"B",,,"DSIX","DSIERR")
 .I $D(DIERR) D ERR(1) Q
 .I '$O(DSIX("DILIST",0)) D ERR(3) Q
 .Q
 ; now loop through all entries and get field values
 S DSIX=0,DSIB=$$BROKER^DSIVUTL
 F  S DSIX=$O(DSIX("DILIST",0)) Q:'DSIX  D  Q:+$G(DSIVL(1))=-1
 .S DSIEN=+DSIX("DILIST",DSIX,0)_"," K DSIX("DILIST",DSIX,0)
 .K DIERR,DSIERR,DSIY S Z=".01;.03;.04;.05;1.1;1.2;6.1;6.2;20;30*"
 .D GETS^DIQ(8989.51,DSIEN,Z,"EI","DSIY","DSIERR")
 .I $D(DIERR) K DSIVL D ERR(1),ERR(4) Q
 .K TMP M TMP=DSIY(8989.51,DSIEN)
 .I 'DSIB S Y=+DSIEN,NAME=TMP(.01,"E")
 .I DSIB D SETL("$START^"_(+DSIEN)_U_TMP(.01,"E")_U_TMP(.03,"I"))
 .I 'DSIB S DSIVL(NAME)=Y_U_TMP(.03,"I")
 .S X=TMP(.04,"E")_U_TMP(6.1,"I")_U_TMP(6.1,"E")_U_TMP(6.2,"E")
 .D:DSIB SETL(X) S:'DSIB DSIVL(NAME,"INST")=X
 .S X=TMP(.05,"E")_U_TMP(1.1,"I")_U_TMP(1.1,"E")_U_TMP(1.2,"E")
 .D:DSIB SETL(X) S:'DSIB DSIVL(NAME,"VAL")=X
 .S DSIEN=0,TMP=""
 .F  S DSIEN=$O(DSIY(8989.513,DSIEN)) Q:DSIEN=""  D
 ..N DIERR,DSIERR,SEQ,ENT
 ..S SEQ=DSIY(8989.513,DSIEN,.01,"I"),ENT=DSIY(8989.513,DSIEN,.02,"I")
 ..S X=$$GET1^DIQ(8989.513,DSIEN,".02:.02",,,"DSIERR")
 ..S Z="" I '$D(DIERR),X'="" S Z=X
 ..S:DSIB TMP=TMP_SEQ_";"_ENT_";"_Z_U
 ..S:'DSIB DSIVL(NAME,"SEQ",SEQ)=ENT_U_Z
 ..Q
 .D:DSIB SETL(TMP)
 .I $D(TMP(20)) F I=0:0 S I=$O(TMP(20,I)) Q:'I  S X=TMP(20,I) D
 ..D:DSIB SETL(X) S:'DSIB DSIVL(NAME,"DESC",I)=X
 ..Q
 .D:DSIB SETL("$END")
 .Q
 I '$D(DSIVL) D ERR(5)
 Q
 ;---------------  subroutines  ---------------
DIC(P) ; interactive DIC lookup to select a Parameter Definition
 ; P - req
 ; This can be the name or namespace of parameter to be used as a screen
 ; This can be an array of names (or namespaces) to be used as screen
 N X,Y,Z,DIERR,DSIERR
 I CNT=1 D  I $D(Z) Q Z
 .S X=$O(DSIVPAR(0))
 .S Y=$$FIND1^DIC(8989.51,,"QX",X,"B",,"DSIERR")
 .K Z Q:$D(DIERR)  S:Y>0 Z=+Y_U_^XTV(8989.51,+Y,0),CNT=0
 .Q
 S Z=8989.51,Z(0)="QAEMZ",Z("S")="D DICS^DSIVXPR3"
 S X=$$DIC^DSIVFM01(.Z),Y=+Z S:Y>0 Y=Y_U_Z(0)
 Q Y
 ;
DICS ; called from DIC("S")
 N A S A="" I 0
 F  S A=$O(DSIVPAR(A)) Q:A=""  I $E($P(^(0),U),1,$L(A))=A Q
 Q
 ;
DIR() ; continue?
 N X,Y,Z
 S Z("A")="Continuing editing more entries for "_DSIVPAR_"? "
 S Z(0)="YOA"
 Q +$$DIR^DSIVFM01(.Z)
 ;
ERR(A) ;
 I A=1 S X=$$MSG^DSIVFM01("VE",,,,"DSIERR")
 I A=2 S X="Lookup value not found: "_DSI
 I A=3 S X="No entry names found starting with "_DSI
 I A=4 S X="Problem with record # "_DSIEN
 I A=5 S X="No data found"
 S Y=1+$O(DSIVL("A"),-1) S:Y=1 X="-1^"_X
 S DSIVL(Y)=X
 Q
 ;
SETL(X) S Y=1+$O(DSIVL("A"),-1),DSIVL(Y)=X Q
 ;
ADDWP ;  add a new entity/parameter/instance
 ; for a word-processing type parameter
 ; INSTANCE is optional
 N I,X,Y,Z,ARR,DSIERR
 N ENT,PAR,ERR,INST,WPA
 S (ERR,DSIERR,RET)=""
 I DATA']"" S RET="-1^No Data String defined" Q
 S ENT=$S($P(DATA,"~",1)'="":$P(DATA,"~",1),1:"SYS")
 S PAR=$P(DATA,"~",2) I PAR="" S RET="-1^No parameter defined in Data string" Q
 S INST=$P(DATA,"~",3),INST=$G(INST,1)
 D INTERN^XPAR1 I ERR S RET="-1^Parameter not defined" Q
 D ADD^XPAR(ENT,PAR,INST,.DSIVLT,.WPA) I +WPA S RET="-1^"_$P(WPA,U,2) Q
 S RET="1^Parameter added successfully"
 Q
 ;
