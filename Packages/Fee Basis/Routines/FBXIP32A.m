FBXIP32A ;WOIFO/SAB-PATCH INSTALL ROUTINE (CON'T) ;7/19/2001
 ;;3.5;FEE BASIS;**32**;JAN 30, 1995
 Q
 ;
SSFC ; Add/Update SIGNED STATEMENT FROM CLAIMANT entry in file 162.93
 N FBFDA,FBI,FBIEN,FBX
 D MES^XPDUTL("  Updating Signed Statement From Claimant in file 162.93...")
 ; find or add entry to file
 S FBFDA(162.93,"?+1,",.01)="SIGNED STATEMENT FROM CLAIMANT"
 S FBFDA(162.93,"?+1,",.02)=1
 D UPDATE^DIE("","FBFDA","FBIEN") D MSG^DIALOG()
 I FBIEN(1)'>0 D  Q
 . D MES^XPDUTL("    ERROR: Entry not added or found in file 162.93.")
 . D MES^XPDUTL("    Signed Statement From Claimant can not be updated.")
 ; I FBIEN(1,0)="?" ; entry already existed and was not added
 ;
 ; update Description wp field of entry (replaces current text)
 ;   load text in global array
 K ^TMP($J,"FB1")
 F FBI=1:1 S FBX=$P($T(DESTXT+FBI),";;",2) Q:FBX="***END***"  D
 . S ^TMP($J,"FB1",FBI,0)=FBX
 ;   replace existing text with content of array
 D WP^DIE(162.93,FBIEN(1)_",",1,"","^TMP($J,""FB1"")") D MSG^DIALOG()
 K ^TMP($J,"FB1")
 ;
 ; update postscript wp field of entry (replaces current text)
 ;   load text in array
 K ^TMP($J,"FB2")
 F FBI=1:1 S FBX=$P($T(PSTXT+FBI),";;",2) Q:FBX="***END***"  D
 . S ^TMP($J,"FB2",FBI,0)=FBX
 ;   replace existing text with content of array
 D WP^DIE(162.93,FBIEN(1)_",",2,"","^TMP($J,""FB2"")") D MSG^DIALOG()
 K ^TMP($J,"FB2")
 ;
 Q
 ;
DESTXT ; text for DESCRIPTION wp field
 ;;A statement must be signed by the claimant and submitted with the claim.
 ;;The text of the statement is printed with this letter.
 ;;***END***
 ;
PSTXT ; text for POSTSCRIPT wp field
 ;;I hereby certify that this claim meets all of the conditions for payment
 ;;by VA for emergency medical services under 38 CFR 17.1002 and 17.1003.
 ;;I am aware that 38 CFR U.S.C. 6102(b) provides that one who obtains
 ;;payment without being entitled to it and with intent to defraud the
 ;;United States shall be fined in accordance with Title 18, United States
 ;;Code, or imprisoned not more than one year, or both.
 ;; 
 ;; 
 ;; 
 ;;                             -----------------------------------
 ;;                                          Signature
 ;; 
 ;; 
 ;;38 CFR 17.1002  Substantive conditions for payment or reimbursement.
 ;;--------------------------------------------------------------------
 ;;    Payment or reimbursement under 38 U.S.C. 1725 for emergency 
 ;;services may be made only if all of the following conditions are met:
 ;;    (a) The emergency services were provided in a hospital emergency 
 ;;department or a similar facility held out as providing emergency care 
 ;;to the public;
 ;;    (b) The claim for payment or reimbursement for the initial 
 ;;evaluation and treatment is for a condition of such a nature that a 
 ;;prudent layperson would have reasonably expected that delay in seeking 
 ;;immediate medical attention would have been hazardous to life or health 
 ;;(this standard would be met if there were an emergency medical 
 ;;condition manifesting itself by acute symptoms of sufficient severity 
 ;;(including severe pain) that a prudent layperson who possesses an 
 ;;average knowledge of health and medicine could reasonably expect the 
 ;;absence of immediate medical attention to result in placing the health 
 ;;of the individual in serious jeopardy, serious impairment to bodily 
 ;;functions, or serious dysfunction of any bodily organ or part);
 ;;    (c) A VA or other Federal facility/provider was not feasibly 
 ;;available and an attempt to use them beforehand would not have been 
 ;;considered reasonable by a prudent layperson (as an example, these 
 ;;conditions would be met by evidence establishing that a veteran was 
 ;;brought to a hospital in an ambulance and the ambulance personnel 
 ;;determined that the nearest available appropriate level of care was at 
 ;;a non-VA medical center);
 ;;    (d) The claim for payment or reimbursement for any medical care 
 ;;beyond the initial emergency evaluation and treatment is for a 
 ;;continued medical emergency of such a nature that the veteran could not 
 ;;have been safely transferred to a VA or other Federal facility (the 
 ;;medical emergency lasts only until the time the veteran becomes 
 ;;stabilized);
 ;;    (e) At the time the emergency treatment was furnished, the veteran 
 ;;was enrolled in the VA health care system and had received medical 
 ;;services under authority of 38 U.S.C. chapter 17 within the 24-month 
 ;;period preceding the furnishing of such emergency treatment;
 ;;    (f) The veteran is financially liable to the provider of emergency 
 ;;treatment for that treatment;
 ;;    (g) The veteran has no coverage under a health-plan contract for 
 ;;payment or reimbursement, in whole or in part, for the emergency 
 ;;treatment (this condition cannot be met if the veteran has coverage 
 ;;under a health-plan contract but payment is barred because of a failure 
 ;;by the veteran or the provider to comply with the provisions of that 
 ;;health-plan contract, e.g., failure to submit a bill or medical records 
 ;;within specified time limits, or failure to exhaust appeals of the 
 ;;denial of payment);
 ;;    (h) If the condition for which the emergency treatment was 
 ;;furnished was caused by an accident or work-related injury, the 
 ;;claimant has exhausted without success all claims and remedies 
 ;;reasonably available to the veteran or provider against a third party 
 ;;for payment of such treatment; and the veteran has no contractual or 
 ;;legal recourse against a third party that could reasonably be pursued 
 ;;for the purpose of extinguishing, in whole or in part, the veteran's 
 ;;liability to the provider; and
 ;;    (i) The veteran is not eligible for reimbursement under 38 U.S.C. 
 ;;1728 for the emergency treatment provided (38 U.S.C. 1728 authorizes VA 
 ;;payment or reimbursement for emergency treatment to a limited group of 
 ;;veterans, primarily those who receive emergency treatment for a 
 ;;service-connected disability).
 ;; 
 ;;(Authority: 38 U.S.C. 1725)
 ;; 
 ;; 
 ;;38 CFR 17.1003  Emergency transportation.
 ;;-----------------------------------------
 ;;    Notwithstanding the provisions of Sec. 17.1002, payment or 
 ;;reimbursement under 38 U.S.C. 1725 for ambulance services, including 
 ;;air ambulance services, may be made for transporting a veteran to a 
 ;;facility only if the following conditions are met:
 ;;    (a) Payment or reimbursement is authorized under 38 U.S.C. 1725 for 
 ;;emergency treatment provided at such facility (or payment or 
 ;;reimbursement could have been authorized under 38 U.S.C. 1725 for 
 ;;emergency treatment if death had not occurred before emergency 
 ;;treatment could be provided);
 ;;    (b) The veteran is financially liable to the provider of the 
 ;;emergency transportation;
 ;;    (c) The veteran has no coverage under a health-plan contract for 
 ;;reimbursement or payment, in whole or in part, for the emergency 
 ;;transportation or any emergency treatment authorized under 38 U.S.C. 
 ;;1728 (this condition is not met if the veteran has coverage under a 
 ;;health-plan contract but payment is barred because of a failure by the 
 ;;veteran or the provider to comply with the provisions of that health-
 ;;plan contract); and
 ;;    (d) If the condition for which the emergency transportation was 
 ;;furnished was caused by an accident or work-related injury, the 
 ;;claimant has exhausted without success all claims and remedies 
 ;;reasonably available to the veteran or provider against a third party 
 ;;for payment of such transportation; and the veteran has no contractual 
 ;;or legal recourse against a third party that could reasonably be 
 ;;pursued for the purpose of extinguishing, in whole or in part, the 
 ;;veteran's liability to the provider.
 ;; 
 ;;(Authority: 38 U.S.C. 1725)
 ;;***END***
