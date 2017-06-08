VEJDRMO1 ;DSS/SGM - RPCS to MODIFY ROUTINES ;12/04/2002 14:04
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;  This routine will do the local modifications to VA VistA routines
 ;  Data is stored in file 19619.7
 ;  all RPC calls also called from VEJDRMOD routine
DSP(RET,ROU) ;  RPC to display changes to be made - no mods done
 ;  ROU - required - routine to be modified
 ;  Return:
 ;    RET(#) = formatted text to return for display purposes
 ;    RET(1) = -1^error msg if problem encountered
 ;  match routine to second line as it exists on the user's system
 ;  The 19619.7 entry with the highest ien is most recent version
 Q:$$PATCHCK<0
 I $G(ROU)="" S RET(1)="-1^No routine name received" Q
 N Y,Z,CNT,IEN,L2,PATCH,TAG,UL
 S TAG="",CNT=1,$P(UL,"=",80)=""
 S RET(1)=$$CJ^XLFSTR("  "_ROU_"  ",80,"*")
 S L2=$$L2(ROU),PATCH=$$PATCH(L2),TAG=""
 F  S TAG=$O(^VEJD(19619.7,"C",ROU,PATCH,TAG)) Q:TAG=""  D
 .S IEN=$O(^VEJD(19619.7,"C",ROU,PATCH,TAG,0)) Q:'IEN
 .F I=0:0 S I=$O(^VEJD(19619.7,IEN,9,I)) Q:'I  S X=^(I,0) D DSET
 .S X="" D DSET S X=UL D DSET
 .Q
 I CNT=1 D
 .S X="The patch list from the second line of your routine is" D DSET
 .S X="   "_PATCH D DSET S X="" D DSET
 .S X="That patch list does not exist my files" D DSET
 .S X="Changes WILL NOT be made to the routine "_ROU D DSET
 .S X="" D DSET S X=UL D DSET
 .Q
 Q
 ;
LIST(RET) ;  RPC to get list of all routines needing modifications
 ;  return RET(#) = name of VistA routine
 ;  if no routines found, return RET(1) = -1^error msg
 ;  Only return routines whose second lines match
 Q:$$PATCHCK<0
 N I,X,L2,L21,ROU S I=0
 F  S I=$O(^VEJD(19619.7,I)) Q:'I  S ROU=$P(^(I,0),U) I $$CK(ROU) D
 .S L2=$G(^VEJD(19619.7,I,1)) Q:L2=""  S L2=$$REPL(L2),L21=$$L2(ROU)
 .I L2=L21!$G(DSS) S X(ROU)=""
 .Q
 S X="" F I=1:1 S X=$O(X(X)) Q:X=""  S RET(I)=X
 I '$D(RET) S RET(1)="-1^No routines found matching second lines"
 Q
 ;
REST(RET,ROU) ;  RPC to restore unmodified routine
 ;  ROU - required - name of routine
 ;  The routine to be restored is the one matching the patch list of the
 ;  currently loaded routine.
 ;  Return 1^Routine restored,  on error return -1^error message
 N I,Y,Z,ASK,ERM,IENS,L2,PATCH,ST
 D UOUT I $G(ROU)="" S X=1 G R1
 I '$O(^VEJD(19619.7,"B",ROU,0)) S X=2 G R1
 I '$$KEY S X=3 G R1
 I '$$CK(ROU) S X=4 G R1
 S L2=$$L2(ROU),PATCH=$$PATCH(L2),IENS="",ASK=0
 I '$D(^VEJD(19619.7,"AC",ROU,PATCH)) S X=2 G R1
 F I=0:0 S I=$O(^VEJD(19619.7,"AC",ROU,PATCH,I)) Q:'I  D
 .I 'IENS,$O(^VEJD(19619.7,I,10,0)) S IENS=I,ASK=ASK+1
 .I '$P(IENS,U,2),$O(^VEJD(19619.7,I,11,0)) S $P(IENS,U,2)=I,ASK=ASK+2
 .Q
 I 'ASK S X=5 G R1
 K Z I ASK=1 D
 .S Z("A")="Restore "_ROU_" from backup? "
 .S Z(0)="YOA",Z("B")="NO"
 .Q
 I ASK#2 F I=2:1:5 S Z("A",I-1)=$TR($T(R0+I),";"," ")
 I ASK=2 D
 .S Z("A")="Restore original unmodified version for "_ROU_"? "
 .S Z(0)="YOA",Z("B")="NO"
 .Q
 I ASK>1 F I=6:1:9 S Z("A",I-1)=$TR($T(R0+I),";"," ")
 I ASK=3 D
 .S Z(0)="SOM^"_$P($T(R0+1),";",3,5)
 .S Z("A")="Restore Option for routine "_ROU
 .Q
 D DIR^VEJDRMOD S:Y="" Y=-1 I "1BO"'[Y S X=6 G R1
 I Y=1 S Y=$S(ASK=1:"B",1:"O")
 S IENS=$S(Y="B":+IENS,1:+$P(IENS,U,2))
 I Y="B" S ASK=" routine restored from backup"
 E  S ASK=" routine restored from original unmodified routine"
 K RET D SAVE
 I '$D(RET) S RET="1^Routine "_ROU_ASK_" from record# "_IENS
 Q
R0() ;
 ;;B:Restore from backup copy;O:Restore nationally released unmodified routine
 ;;If you have used this utility before, it may have saved the a copy of
 ;;the routine prior to making the modifications.  IF that copy exists,
 ;;you can restore the routine from that Backup.
 ;;
 ;;This file also contains a copy of the nationally released version of
 ;;this routine before any modifications were done.  IF that copy exists,
 ;;you can restore the routine from that copy.
 ;;
R1 ;
 S Z="-1^Routine "_ROU_" "
 I X=1 S RET="-1^No routine name received"
 I X=2 S RET=Z_"not found in file 19619.7"
 I X=3 S RET="-1^You are not authorized to execute this function"
 I X=4 S RET=Z_"not found on your system"
 I X=5 S RET=Z_"- no backup routine(s) found to be restored"
 I X=6 S RET="-1^Option aborted"
 Q
 ;
UPD(RET,ROU,DOIT) ;  RPC to check and/or make modifications
 ;  ROU - required - name of routine to be modified
 ; DOIT - optional - 1 or 0 - default=0
 ;        if 1 then make changes to routine, else 0 check
 ;  RET - 1^changes made to the routine
 ;       -1^error message
 Q:$$PATCHCK<0
 N I,X,Y,Z,CKSUM,CNT,ERM,FLD,IENS,L2,LAB,OFF,PATCH,RTN,TAG
 I $G(ROU)="" S X=1 G MSG
 I '$O(^VEJD(19619.7,"B",ROU,0)) S X=2 G MSG
 I '$$CK(ROU) S X=3 G MSG
 I '$$KEY S X=3.1 G MSG
 D UOUT,LOAD^VEJDRMOD(ROU,.RTN) K ^TMP("VEJD",$J) M ^TMP("VEJD",$J)=RTN
 I '$O(RTN(0)) S X=4 G MSG
 ;  get all line tag's absolute line number
 F I=1:1 Q:'$D(RTN(I,0))  S X=$P($P(RTN(I,0)," "),"(") S:X]"" TAG(X)=I
 S CKSUM=$$CKSUM(ROU),L2=$$L2(ROU),PATCH=$$PATCH(L2)
 I '$D(^VEJD(19619.7,"C",ROU,PATCH)) S X=5 G MSG
 S FLD=".02;.03;.04;.05;1;1.1;2;3;4;5;"
 S (CNT,IENS)=0,TAG=""
 F  S TAG=$O(^VEJD(19619.7,"C",ROU,PATCH,TAG)) Q:TAG=""  D
 .N DAT,DIERR,VEJDX,VEJDERR
 .S:'IENS IENS=$O(^VEJD(19619.7,"C",ROU,PATCH,TAG,0))_","
 .D GETS^DIQ(19619.7,IENS,FLD,,"VEJDX","VEJDERR")
 .K DAT I $D(VEJDX) M DAT=VEJDX(19619.7,IENS)
 .F I=.02,.03,.04,.05,1,2 I $G(DAT(I))="" S ERM(TAG,5.1)="" Q
 .Q:$D(ERM(TAG,5.1))  S X=DAT(.04),DAT(.04)=$S(X["insert":"I",1:"E")
 .I DAT(.04)="E",$G(DAT(4))="" S ERM(TAG,5.1)="" Q
 .I DAT(.04)="I",'$O(DAT(5,0)) S ERM(TAG,5.1)="" Q
 .F I=1,2,3,4 S X=$G(DAT(I)) I X]"" S DAT(I)=$$REPL(X)
 .F I=0:0 S I=$O(DAT(5,I)) Q:'I  S DAT(5,I)=$$REPL(DAT(5,I))
 .S LAB=$P(TAG,"+"),OFF=+$P(TAG,"+",2)
 .I '$D(TAG(LAB)) S ERM(TAG,6)="" Q  ;  check for label
 .I RTN(2,0)'=DAT(1) S ERM(TAG,7)="" Q  ;  check 2nd line
 .;  check for checksum okay
 .S Z=$S(CKSUM=DAT(.02):1,CKSUM=DAT(.03):2,1:0)
 .I 'Z S ERM(TAG,8)="" Q
 .I Z=2 D  ;  checksums match, check lines match also
 ..S Y=TAG(LAB)+OFF
 ..I DAT(.04)="E" S:$G(RTN(Y,0))'=DAT(4) ERM(TAG,9.1)=""
 ..E  F I=0:0 S I=$O(DAT(5,I)) Q:'I  D
 ...S Y=Y+1 I $G(RTN(Y,0))'=DAT(5,I) S ERM(TAG,9.2)=""
 ...Q
 ..I '$D(ERM(TAG,9.1)),'$D(ERM(TAG,9.2)) S ERM(TAG,9)=""
 ..Q
 .I Z=1 D  Q  ;  site cksum = released cksum, check for line match
 ..S Y=TAG(LAB)+OFF
 ..I $G(RTN(Y,0))'=DAT(2) S ERM(TAG,10)="" Q
 ..I DAT(3)]"",$G(RTN(Y+1,0))'=DAT(3) S ERM(LAB_"+"_(OFF+1),10)="" Q
 ..D SE:DAT(.04)="E",SI:DAT(.04)="I"
 ..Q
 .Q
 I $D(ERM) D  Q
 .K TMP S I=0,TAG="" F  S TAG=$O(ERM(TAG)) Q:TAG=""  D
 ..F X=0:0 S X=$O(ERM(TAG,X)) Q:'X  K RET D MSG S I=I+1,TMP(I)=RET
 ..K RET S RET=TMP(1)
 ..F I=2:1 Q:'$D(TMP(I))  S RET=RET_"/ "_$P(TMP(I),": ",2)
 ..Q
 .Q
 S RET="1^Routine "_ROU_": "
 I '$G(DOIT) S RET=RET_"No problems found, routine would be modified"
 E  D
 .L +^VEJD(19619.7,+IENS)
 .D WP^DIE(19619.7,IENS,10,,$NA(^TMP("VEJD",$J)),"VEJDERR")
 .L -^VEJD(19619.7,+IENS)
 .S IENS=+IENS,Y="U" K ^TMP("VEJD",$J) M ^TMP("VEJD",$J)=RTN D SAVE
 .S RET=RET_"Backed up, changes made, and ZSAVEd"
 .Q
 G UOUT
 ;
MSG ;  messages when checking or modifying routine
 I X=1 S Z="No routine name received"
 I X=2 S Z="Not found in file 19619.7"
 I X=3 S Z="Does not exist on your system"
 I X=3.1 S Z="Your are not authorized to execute this function"
 I X=4 S Z="Error encountered trying to load routine"
 I X=5 S Z="Your patch list <"_PATCH_"> was not found in file 19619.7"
 I X=5.1 S Z="Problem encountered retrieving data from file 19619.7"
 I X=6 S Z="Line <"_LAB_"> was not found in your routine"
 I X=7 S Z="Your second line does not match what was expected"
 I X=8 S Z="Your checksum ["_CKSUM_"] does not match any that I was expecting"
 I X\1=9 S Z="Your checksum and my post-modification checksum match, "
 I X=9 S Z=Z_"it appears that the modification is already installed"
 I X=9.1 S Z=Z_"however the edited line <"_TAG_"> does not match"
 I X=9.2 S Z=Z_"however the inserted lines do not match"
 I X=10 S Z="Your line <"_TAG_"> does not match what was expected"
 S Y="-1^Routine "_ROU_$S('$G(DOIT):" would not be",1:" not")_" modified"
 S RET=Y_": "_Z
UOUT K ^TMP($J),^TMP("VEJD",$J),^UTILITY("ROU",ROU)
 Q
 ;---------------------- subroutines ---------------------------
CK(X) ;  check for existence of routine X
 I $G(X)]"" X ^%ZOSF("TEST")
 Q $T
 ;
CKSUM(X) ;  return checksum value for routine X
 N %,%1,%2,%3,Y
 S Y="" I X]"",$$CK(X) X ^%ZOSF("RSUM")
 Q Y
 ;
DSET S CNT=CNT+1,RET(CNT)=X Q
 ;
KEY() Q $D(^XUSEC("XUPROGMODE",DUZ))
 ;
L2(X) Q $T(@("+2^"_X)) ;  2nd line of routine
 ;
PATCH(X) ;  return patch list from second line or " NONE"
 S X=$P($P(X,";",5),"**",2) S:X="" X=" NONE"
 Q X
 ;
PATCHCK() ;  check to see if patch installed
 ;  return 1 if NOT installed, else return -1
 N X D PATCH^DSICXPDU(.X,"VEJD PCE RECORD MANAGER*7.0*1")
 I X=1 Q 1
 S RET(1)="-1^DSS modifications to IB routines no longer needed since patch IB*2.0*182"
 Q -1
 ;
REPL(X) ;  replace the characters <ls> with a space where X=line from file
 I $G(X)'["<ls>" Q X
 Q $P(X,"<ls>")_" "_$P(X,"<ls>",2,99)
 ;
SAVE ;  save routine
 ;  Y="B" restore from backup;  Y="O" restore from original
 ;  Y="U" save modified routine in RTN
 ;  ROU = name of routine to be saved
 N %,X,DIE,XCS,XCM,XCN K ^TMP($J)
 S Y=$G(Y," ")
 I "BOU"'[Y S:Y'="U" RET="-1^Backup source not specified" Q
 I '$D(^VEJD(19619.7,+IENS,0)) S:Y'="U" RET="-1^Record# "_(+IENS)_" not found" Q
 S XCN=0,X=ROU
 I "BO"[Y S %=$S(Y="B":10,1:11),DIE="^VEJD(19619.7,+IENS,"_%_","
 E  S DIE="^TMP(""VEJD"",$J,"
 X ^%ZOSF("SAVE") D UOUT
 Q
 ;
SE ;  replace line with edited line
 S Y=TAG(LAB)+OFF,RTN(Y,0)=DAT(4) Q
 ;
SI ;  insert lines
 S Y=TAG(LAB)+OFF
 F I=0:0 S I=$O(DAT(5,I)) Q:'I  S Y=Y+.01,RTN(Y,0)=DAT(5,I)
 Q
