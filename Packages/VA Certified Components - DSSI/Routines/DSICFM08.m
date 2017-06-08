DSICFM08 ;DSS/LM - FILE TO MULTIPLE FILES/IENS ;03/18/2005 19:37
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;Common description of input parameters
 ;---------------------------------------------------------
 ;  FILE - req - file (or subfile) number or full file name
 ;   FUN - opt - if $G(FUN) then extrinsic function
 ; FIELD - req - field number or full field name
 ;
 Q
MFILE(DSICRSLT,DSICNPUT) ; RPC: DSIC FM MFILE
 ; Generalizes FILE^DSICFM (RPC: DSIC FM FILER)
 ; Files data to existing entries in files or subfiles
 ; 
 ; DSICRSLT -   return array where
 ;              DSICRSLT(1) = 1^FILE^IENS  if everything was successfully filed
 ;                                         for this FILE x IENS combination.
 ;                          = -1^error message if any problems encountered
 ;              DSICRSLT(2...n) = additional messages in above format
 ; 
 ; DSICNPUT - required - list where
 ;         LIST[#] = p1^p2^p3^p4^p5^p6 where
 ;
 ;         p1 - required when file or subfile changes
 ;              First record of each group relating to the same
 ;              file or subfile must specify the file or subfile
 ;              number in the first piece.  This value can be
 ;              omitted for subsequent records that pertain to
 ;              the same file or subfile.
 ;         p2 - required when IENS or file/subfile changes
 ;              First record of each group to be filed to the same
 ;              entry or subentry must specify the IENS.
 ;              This value can be omitted for subsequent
 ;              records that pertain to other fields in the same
 ;              entry.
 ;         p3 - FLAG - optional - only acceptable value is "T" -
 ;              transaction processing, that is, all the fields must
 ;              be successfully updated or none are.  Applies to
 ;              the entire group of records for one file or subfile
 ;              number and IENS.  May be specified in any record of
 ;              the same group.
 ;         p4 - required - field # (Same as p1 in FILE^DSICFM)
 ;         p5 - optional - default value I (Same as p2 in FILE^DSICFM)
 ;              if p5="" then field value in internal format
 ;                   ="E" then field value in external format
 ;                   ="I" then field value in internal format
 ;                   ="W" then field is a word processing
 ;                                  see notes for FILE^DSICFM
 ;         p6 - value for field# - if value is <null> or "@"
 ;                        then field value will be deleted.
 ;                        (Same as p3 in FILE^DSICFM)
 ;
 N DSIC,DSICDATA,DSICFILE,DSICIENS,DSICFLAG,DSICI,DSICJ,DSICK
 N DSICNEXT,DSICQUIT,DSICRECI,DSICX,I,X
 S DSICRSLT(1)="-1^No valid input",(DSICI,DSICJ,DSICK,DSICQUIT)=0
 S (DSICFILE,DSICIENS,DSICFLAG)=""
 F DSICRECI=1:1 S DSICX=$G(DSICNPUT(DSICRECI)) Q:'$L(DSICX)!DSICQUIT  D
 .S X=$P(DSICX,U) S:X DSICFILE=X I 'DSICFILE D  Q
 ..S DSICK=DSICK+1,DSICRSLT(DSICK)="-1^Invalid FILE in input record "_DSICRECI_". RPC aborted"
 ..S DSICQUIT=1
 ..Q
 .S X=$P(DSICX,U,2) S:X DSICIENS=X I 'DSICIENS D  Q
 ..S DSICK=DSICK+1,DSICRSLT(DSICK)="-1^Invalid IENS in input record "_DSICRECI_". RPC aborted"
 ..S DSICQUIT=1
 ..Q
 .S X=$P(X,U,3) S:X DSICFLAG=X
 .S DSICI=DSICI+1,DSICDATA(DSICI)=$P(DSICX,U,4,99)
 .; Determine if last record of group pertaining to same (sub)file x IENS
 .S DSICNEXT=$G(DSICNPUT(DSICRECI+1))
 .I $L(DSICNEXT),$P(DSICNEXT,U)=""!($P(DSICNEXT,U)=DSICFILE)
 .I  Q:$P(DSICNEXT,U,2)=""!($P(DSICNEXT,U,2)=DSICIENS)
 .; Fall through here if end-of-input or next record is a new (sub)file or new IENS
 .K DSIC D FILE^DSICFM04(.DSIC,DSICFILE,DSICIENS,DSICFLAG,.DSICDATA)
 .F I=1:1 Q:'$D(DSIC(I))  S DSICK=DSICK+1,DSICRSLT(DSICK)=DSIC(I) D
 ..S:$P(DSIC(I),U)=1 $P(DSICRSLT(DSICK),U,2,3)=DSICFILE_U_DSICIENS
 ..Q
 .K DSICDATA S DSICIENS="",DSICI=0
 .Q
 Q
