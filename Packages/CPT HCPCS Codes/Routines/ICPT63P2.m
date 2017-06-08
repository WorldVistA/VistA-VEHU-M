ICPT63P2 ;ALB/ESD - CPT Modifier file (#81.3) Post-Init; 2/2/98
 ;;6.0;CPT/HCPCS;**3**;May 19, 1997
 ;
 ;
EN ;- Entry point to update CPT Modifier file (#81.3)
 ;  (called from ICPT63PT)
 ;
 D BMES^XPDUTL(">>> Updating CPT Modifier file (#81.3)......")
 ;
 ;- CPT modifiers
 D CPTMOD
 ;
 ;- HCPCS modifiers
 D HCPCSM
 ;
 D BMES^XPDUTL("...... completed.")
ENQ Q
 ;
 ;
CPTMOD ;- CPT Modifier(s) revisions (revisions to code range)
 ;
 N CPTREC,DA,DA1,MOD,MODI,NEWBR,NUMM,SUBNDE
 F MODI=1:1 S CPTREC=$P($T(CPTREV+MODI),";;",2) Q:CPTREC="QUIT"  D
 . ;
 . ;- Get all modifiers for code range
 . S NUMM=+$$CODM^ICPTCOD($P(CPTREC,"^")) Q:NUMM<1!('$D(^TMP("ICPTM",$J)))
 . S MOD="" F  S MOD=$O(^TMP("ICPTM",$J,MOD)) Q:MOD=""  D
 .. ;
 .. ;- Find beginning code range subentry ien
 .. I +$P($G(^TMP("ICPTM",$J,MOD)),"^",2) S DA=$$FNDSUB($P(CPTREC,"^"),+$P($G(^TMP("ICPTM",$J,MOD)),"^",2),$P(CPTREC,"^",3))
 .. ;
 .. ;- Set beginning code range to new range for those entries that match
 .. I DA,+$$EDITBR($P(CPTREC,"^"),+$P($G(^TMP("ICPTM",$J,MOD)),"^",2),$P(CPTREC,"^",3),DA,$P(CPTREC,"^",2)) D
 ... ;
 ... ;- Display message to screen
 ... D BMES^XPDUTL("CPT modifier "_MOD_"with range "_$P(CPTREC,"^")_" changed to "_$P(CPTREC,"^",2)_".")
 Q
 ;
 ;
FNDSUB(CPT,DA1,SUBNDE) ;- Find existing sub-entry ien
 ;
 ;  Input:     CPT = .01 field of sub-entry
 ;             DA1 = entry ien
 ;          SUBNDE = sub node
 ;
 ; Output:  Sub-entry ien or 0 if lookup unsuccessful
 ;
 Q:'$G(CPT)
 N DIC,NODE,X
 S DA(1)=+$G(DA1)
 S SUBNDE=$G(SUBNDE)
 S NODE=$S(SUBNDE="D":",""D"",",1:","_SUBNDE_",")
 S DIC="^DIC(81.3,"_DA(1)_NODE
 S DIC(0)="MSX",X=CPT
 D ^DIC K DA(1)
 Q $S(+$G(Y)>0:+Y,1:0)
 ;
 ;
EDITBR(CPT,DA1,SUBNDE,DA,NEWBR) ;- Edit BEGIN RANGE sub-field of RANGE multiple
 ;
 ;  Input:     CPT = .01 field of sub-entry
 ;             DA1 = entry ien
 ;          SUBNDE = sub node
 ;             DA  = sub-entry ien
 ;          NEWBR  = new beginning code range
 ;
 ; Output:  BEGIN RANGE sub-field edited
 ;
 N DIE,DTOUT,ERR,NODE,SNODE
 S ERR=0
 S DA(1)=DA1
 S DA=+$G(DA)
 S SUBNDE=$G(SUBNDE)
 S NODE=$G(^DIC(81.3,DA(1),SUBNDE,DA,0))
 I $P(NODE,"^")'=CPT S ERR=1 G EDITBRQ
 L +^DIC(81.3,DA(1)):5 I ('$T) S ERR=1 G EDITBRQ
 S SNODE=$S(SUBNDE="D":",""D"",",1:","_SUBNDE_",")
 S DIE="^DIC(81.3,"_DA(1)_SNODE
 S DR=".01///"_NEWBR
 D ^DIE
 L -^DIC(81.3,DA(1))
EDITBRQ Q $S(($G(DTOUT)!(ERR)):0,1:1)
 ;
 ;
HCPCSM ;- Add, modify, or inactivate HCPCS modifiers in file #81.3
 ;
 N DA,DA1,DIE,DR,HCPI,HCPREC
 ;
 ;- Get record
 F HCPI=1:1 S HCPREC=$P($T(HCPCS+HCPI),";;",2) Q:HCPREC="QUIT"  D
 . ;
 . ;- Get entry if existing; otherwise add entry
 . S DA1=$$ADDREC Q:'DA1
 . ;
 . ;- Exit if record doesn't exist
 . Q:'$D(^DIC(81.3,DA1,0))
 . ;
 . ;- Lock node
 . L +^DIC(81.3,DA1):5 Q:'$T
 . S DIE="^DIC(81.3,"
 . S DA=DA1
 . ;
 . ;- Edit fields on zero node
 . I $P(HCPREC,"^")="A"!($P(HCPREC,"^")="M") S DR=".02///"_$P(HCPREC,"^",3)_";.04///"_$P(HCPREC,"^",5)
 . I $P(HCPREC,"^")="I" S DR="5///"_$P(HCPREC,"^",3)
 . D ^DIE
 . K DA,DIE,DR
 . ;
 . ;- Edit Range, Description, and/or Effective Date multiple(s) based on
 . ;  whether record is an Add, Modify, or Inactivate
 . D EDITMUL($P(HCPREC,"^"),DA1)
 . ;
 . ;- Unlock node
 . L -^DIC(81.3,DA1)
 Q
 ;
 ;
EDITMUL(IND,DA1) ;- Edit multiple(s) based on record type (Add, Modify, Inactivate)
 ;
 Q:IND=""!('DA1)
 N DA,PRT,SUBNDE
 ;
 ;- 'M'odify record  (Description multiple)
 I IND="M" F SUBNDE="D" D
 . ;
 . ;- Edit Description
 . I '$$EDDESC(DA1) D  Q
 .. D BMES^XPDUTL("Could not edit Description multiple for modifier "_$P(HCPREC,"^",2))
 . ;
 . ;- Display info message to screen when done
 . D EDITMSG(IND,.PRT)
 ;
 ;- 'A'dd record  (Description multiple)
 I IND="A" F SUBNDE="D" D
 . ;
 . ;- Edit Description
 . I '$$EDDESC(DA1) D
 .. D BMES^XPDUTL("Could not add Description multiple for modifier "_$P(HCPREC,"^",2))
 . ;
 . ;- 'A'dd record  (Effective Date and Range multiples)
 . F SUBNDE=10,60 D
 .. ;
 .. ;- Exit if no .01 field value
 .. I SUBNDE=10 Q:$P(HCPREC,"^",6)=""
 .. I SUBNDE=60 Q:$P(HCPREC,"^",9)=""
 .. ;
 .. ;- Add new subentry
 .. S DA=$$ADDSUB(DA1,SUBNDE) I 'DA D  Q
 ... D BMES^XPDUTL("Could not add "_$S(SUBNDE=10:"Range",1:"Effective Date")_" multiple for modifier "_$P(HCPREC,"^",2))
 .. ;
 .. ;- Display info message to screen when done
 .. D EDITMSG(IND,.PRT)
 ;
 ;- 'I'nactivate record (Effective Date multiple)
 I IND="I" F SUBNDE=60 D
 . ;
 . ;- Add new subentry
 . S DA=$$ADDSUB(DA1,SUBNDE) I 'DA D  Q
 .. D BMES^XPDUTL("Could not edit Effective Date multiple for modifier "_$P(HCPREC,"^",2))
 . ;
 . ;- Display info message to screen when done
 . D EDITMSG(IND,.PRT)
 Q
 ;
ADDREC() ;- Add new modifier record entry or find existing entry
 ;
 ;  Input:  None
 ;
 ; Output:  Ien of record
 ;
 ;- Look up to see if entry exists
 N DIC,DLAYGO,X,Y
 S DIC="^DIC(81.3,"
 S DIC(0)="MSX"
 S X=$P(HCPREC,"^",2)
 D ^DIC
 I +Y>0 G ADDRECQ
 ;
 ;- Add new entry
 S DIC(0)="L",DLAYGO=81.3,X=$P(HCPREC,"^",2)
 K DD,DO D FILE^DICN
 I +Y=-1 D ADDERR
 ;
ADDRECQ Q $S(+Y>0:+Y,1:0)
 ;
 ;
ADDSUB(DA1,SUBNDE) ;- Add sub-entry
 ;
 ;  Input:     DA1 = entry ien
 ;          SUBNDE = sub node
 ;
 ; Output:  Sub-entry ien
 ;
 N DIC,DLAYGO,NODE,X,Y
 S DA(1)=+$G(DA1) Q:'DA(1)
 S SUBNDE=$G(SUBNDE) Q:SUBNDE=""
 S NODE=","_SUBNDE_","
 S DIC="^DIC(81.3,"_DA(1)_NODE
 S DIC(0)="LOX"
 S DLAYGO=81.3
 S X=$S(SUBNDE=10:$P(HCPREC,"^",6),1:$P(HCPREC,"^",9))
 S DIC("DR")=".02///"_$S(SUBNDE=10:$P(HCPREC,"^",7),1:$P(HCPREC,"^",10))
 ;
 ;- Need this variable because it's a multiple
 S DIC("P")=$P(^DD(81.3,SUBNDE,0),"^",2)
 D ^DIC
 Q $S(+Y>0:+Y,1:0)
 ;
 ;
EDDESC(DA1) ;- Edit Description
 ;
 ;  Input:     DA1 = entry ien
 ;
 ; Output:  1 if successful, 0 otherwise
 ;
 N DA,DIE,DR,NOERR
 S NOERR=1
 S:'$G(DA1) NOERR=0
 I 'NOERR G EDDESCQ
 S DIE="^DIC(81.3,",DA=DA1,DR="50///"_$P(HCPREC,"^",8)
 D ^DIE
EDDESCQ Q NOERR
 ;
 ;
ADDERR ;- Display error message to screen
 ;
 D BMES^XPDUTL("Modifier "_$P(HCPREC,"^",2)_" could not be added.")
 Q
 ;
EDITMSG(IND,ONCE) ;- Display info message to screen
 ;
 N MSG
 ;
 ;- Only display Added record message once
 I IND="A",+$G(ONCE) Q
 S MSG="the CPT Modifier file (#81.3)."
 D BMES^XPDUTL("Modifier "_$P(HCPREC,"^",2)_" was "_$S(IND="M":"updated in ",IND="A":"added to ",IND="I":"inactivated from ")_MSG)
 S ONCE=1
 Q
 ;
 ;
CPTREV ;- CPT Modifiers
 ;;90701^90700^10
 ;;QUIT
 ;
 ;
HCPCS ;- Modifiers:  type^mod^name^code^src^beg rng^end rng^desc^eff dt^status
 ;;M^AT^ACUTE TREATMENT^^^^^ACUTE TREATMENT (THIS MODIFIER SHOULD BE USED WHEN REPORTING SERVICE 98940, 98941, 98942)
 ;;M^G1^URR READING OF LESS THAN 60^^^^^MOST RECENT URR READING OF LESS THAN 60
 ;;M^G2^URR READING OF 60 TO 64.9^^^^^MOST RECENT URR READING OF 60 TO 64.9
 ;;M^G3^URR  READING OF 65 TO 69.9^^^^^MOST RECENT URR READING OF 65 TO 69.9
 ;;M^G4^URR READING OF 70 TO 74.9^^^^^MOST RECENT URR READING OF 70 TO 74.9
 ;;M^G5^URR READING OF 75 OR GREATER^^^^^MOST RECENT URR READING OF 75 OR GREATER
 ;;A^KO^SINGLE DRUG UNIT DOSE FORM^^H^^^SINGLE DRUG UNIT DOSE FORMULATION^2980101^1
 ;;A^KP^FIRST DRUG OF MULTI DRUG U D^^H^^^FIRST DRUG OF A MULTIPLE DRUG UNIT DOSE FORMULATION^2980101^1
 ;;A^KQ^2ND/SUBSQNT DRG MULTI DRG UD^^H^^^SECOND OR SUBSEQUENT DRUG OF A MULTIPLE DRUG UNIT DOSE FORMULATION^2980101^1
 ;;A^QR^REPEAT DX LAB TST SAME DAY^^H^^^REPEAT CLINICAL DIAGNOSTIC LABORATORY TEST PERFORMED ON THE SAME DAY TO OBTAIN SUSEQUENT REPORTABLE TEST VALUE(S) (SEPARATE SPECIMENS TAKEN IN SEPARATE ENCOUNTERS)^2980101^1
 ;;I^Q1^1^^^^^^2980101^0
 ;;QUIT
