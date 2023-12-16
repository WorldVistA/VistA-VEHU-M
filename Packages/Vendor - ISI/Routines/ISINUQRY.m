ISINUQRY ; ISI/NST - $Q function ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**99,110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 Q
 ;
Q(V,D) ; Function to return $QUERY for variable V and direction D.
 ; Replacement for Reverse $Q Function
 ; 1/8/08 MLP
 ;This function can be called for $Query -- either forward or reverse.
 ;In place of $Q(V,D), use $$Q^ZDQ($NA(V),D)
 ;Note: the 2nd argument is optional.
 ;
 S D=+$G(D,1)
 Q:D=1 $Q(@V)         ;Forward $Q
 IF D'=-1 Q           ;Will cause error due to no argument.
 N S
TOP IF $QL(V)=0 Q ""     ;done if unsubscripted
BKU S S=$O(@V,-1)        ;backup to previous node on current level
 S V=$NA(@V,$QL(V)-1) ;remove last subscript
 IF S="" G DAT        ;go chk for data if backed up all the way
 S V=$NA(@V@(S))      ;add the subscript found when backing up.
 IF $D(@V)>9 S V=$NA(@V@("")) G BKU  ;if downpointer, descend and repeat
DAT IF $D(@V)#2=1 Q V    ;if a data node, return with current name
 G TOP
 ;
