GMTSPAT7 ;SLC/SBW - Fixes "DEL" node for patch 7 ;8-may-96
 ;;2.7;Health Summary;**7**;Oct 20, 1995
MAIN ;Will check that file 141.1 exist. If it does, 
 ; ^DD(142.1,.01,"DEL",1,0) and ^DD(142.1,.01,"DEL,2,0) will
 ; be changed.
 I $$VERSION^XPDUTL("GMTS")'>0 W !!,"The Health Summary package is not installed.",!! Q
 W !!,"This routine will update the ""DEL"" nodes on file 142.1 appropriately."
 S ^DD(142.1,.01,"DEL",1,0)="I $S(+$G(DUZ(2))'>0:1,DUZ(2)=5000:0,(DA'<100001)&(DA'>9999999):0,1:1) N GMZ S GMZ=$S(+$G(DUZ(2)):""ONLY Components Created at your site can be deleted"",1:""DUZ(2) MUST equal your DIVISION"") D EN^DDIOL(GMZ)"
 S ^DD(142.1,.01,"DEL",2,0)="I '$D(GMCMP) D EN^DDIOL(""You may only delete COMPONENTS using the GMTS IRM/ADPAC COMP EDIT option."","""",""!!"")"
 W !!,"Finished updating the ""DEL"" nodes on file 142.1."
 Q
