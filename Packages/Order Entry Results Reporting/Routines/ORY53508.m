ORY53508 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*535) ;FEB 15,2024 at 09:13
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**535**;Dec 17,1997;Build 20
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^ORY535ES
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 ;
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"860.2:","860.22:2",6,"E"
 ;;D^Metformin - no eGFR calculated within past |RECENT METFORMIN EGFR DAYS| days.
 ;;EOR^
 ;;EOF^OCXS(860.2)^1
 ;1;
 ;
