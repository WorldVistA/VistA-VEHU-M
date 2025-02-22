TIUCCRHL7P6 ; CCRA/PB - TIU CCRA HL7 Msg Processing; January 6, 2006
 ;;1.0;TEXT INTEGRATION UTILITIES;**344,371**;Jun 20, 1997;Build 4
 ;
 ;PB - Patch 344 to modify how the note and addendum text is formatted
 ;PB - Patch 371 removes unused code
 ;
 Q
CCPN ;
 K T2 S T2("CCP Note Create Date:")=$C(160)_"CCP Note Create Date:"_$C(160) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("CCPN Number:")=$C(160)_"CCPN Number:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran Last Name:")=$C(160)_"Veteran Last Name:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran First Name:")=$C(160)_"Veteran First Name:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Date:")=$C(160)_"Date:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("CONSULT AND REFERRAL INFORMATION")=$C(160)_"CONSULT AND REFERRAL INFORMATION" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Name of Referring VA Provider: ")=$C(160)_"Name of Referring VA Provider: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Selected SEOC: ")=$C(160)_"Selected SEOC: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Referral Number: ")=$C(160)_"Referral Number: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Unique Consult ID: ")=$C(160)_"Unique Consult ID: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Patient Admitted (Yes/No): If yes, then please complete"_$C(160)_"the Discharge"_$C(160)_"Planning Addendum." I $G(T4)'="" D
 .S T2($G(T4))=$C(160)_"Patient Admitted (Yes/No): If yes, then please complete the Discharge Planning Addendum." S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Chief Complaint: ")=$C(160)_"Chief Complaint: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Risks (e.g. clinical or biophysical risks identified from S/T tool or brief chart review, such as dementia, homelessness, no family support, etc. If unknown, state ""Unknown""): " D
 . S T2($G(T4))=$C(160)_$G(T4) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Level of Care Coordination: ")=$C(160)_"Level of Care Coordination: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="BasicPlease review all notes, this note may have one or more of the following addenda associated: " I $G(T4)'="" D
 .S T2($G(T4))=$C(160)_"Basic Please review all notes, this note may have one or more of the following addenda associated: "_$C(160) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Care Coordination Follow Up: ")=$C(160)_"Care Coordination Follow Up: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Note for Appointment Management Addendum Appointment Management: ")=$C(160)_"Note for Appointment Management Addendum Appointment Management: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Case Management: ")=$C(160)_"Case Management: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Continued Stay Review: ")=$C(160)_"Continued Stay Review: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Disease Management: ")=$C(160)_"Disease Management: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Discharge Planning:")=$C(160)_"Discharge Planning:" S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Discharge Disposition: ")=$C(160)_"Discharge Disposition: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran Contact: ")=$C(160)_"Veteran Contact: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Provider Contact: ")=$C(160)_"Provider Contact: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Transfer: ")=$C(160)_"Transfer: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran Handoff: ")=$C(160)_"Veteran Handoff: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("FACILITY COMMUNITY CARE OFFICE CONTACT")=$C(160)_$C(160)_"FACILITY COMMUNITY CARE OFFICE CONTACT"_$C(160)_$C(160) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Care Coordination Point of Contact: "_$C(160))="Care Coordination Point of Contact: "_$C(160) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Phone Number:")="Phone Number: "_$C(160) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Is Veteran's caregiver same as next of kin listed in the demographic section of CPRS (Yes/No)?:  If no, provide the following: ",T2($G(T4))=$C(160)_$G(T4) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Veteran's Caregiver Point of Contact: ")=$C(160)_"Veteran's Caregiver Point of Contact: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Caregiver's Primary Phone Number:")=$C(160)_"Caregiver's Primary Phone Number: "_$C(160) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("Caregiver's Alternate Phone Number:")="Caregiver's Alternate Phone Number: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("PLAN:  ")=$C(13)_"PLAN:  "_$C(10) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="*** CC Plan may include specialty and associated appointment information, date of surgery, post-op needs, post d/c appointment, and any other care coordination plan ***" D
 . S T2=$G(T4)=$C(160)_$G(T4)_$C(160) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2 S T2("ADDITIONAL NOTES:")=$C(160)_$C(160)_"ADDITIONAL NOTES: " S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T4,T2,T5
 Q
CCFUA ;
 D COMMON^TIUCCRHL7P4
 K T2 S T2("************ CARE COORDINATION FOLLOW UP ADDENDUM ************")=$C(10)_"************ CARE COORDINATION FOLLOW UP ADDENDUM ************"_$C(10) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Chart Review" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Contact to/from Veteran/Family/Caregiver" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Contact to/from Hospital or Case Manager" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Edit Facility Contact Information:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Facility Community Care Office Contact:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Phone Number:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Enter/Edit Caregiver Information:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Who is providing care for the Veteran? (Select One)" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Individual Veteran's Point of Contact:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Relationship to Veteran:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Alternative Phone Number:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Agency Agency Point of Contact:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Email Address:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Appointment n  Clinic:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="(Cardiology, Gastroenterology, Mental Health, Neurology, Primary Care, Pulmonary, Radiology, Surgical Subspecialties, Other:______)" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Appointment Location" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="VA Community Provider" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="DoD Appointment Date:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="To be scheduled:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Reason for appointment:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Provider Name:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Address:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="City:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="State:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Zip:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Phone:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Enter/Edit Admission Information:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Veteran Admitted?" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Same Facility" S T2(T4)=$C(10)_$C(9)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Other Facility" S T2(T4)=$C(10)_$C(9)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Transfer to other Community Medical Facility" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Reason for Transfer (Select one)" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Higher Level of Care" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Specialty Care Not Available" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Facility Name:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Facility POC:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="POC Phone:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4=$C(160)_" Transfer to VA" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="VAMC Name:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Services:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Navigation Scheduling Post-Appointment Follow-Up E-Communications to referring provider Plan:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="CC Plan may include specialty and associated appt information, date of surgery post op needs, post d/c appointment and any other care coordination plan" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Additional Notes (Optional):" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Moderate" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Care coordination was determined from:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Edit Facility Contact Information:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Facility Community Care Office Contact:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Alternative Phone Number:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Enter/Edit Admission Information" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Veteran Admitted?" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Street Address:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="No  Services:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Basic Care Coordination Services Monitoring and coordination of Rehab/PT Services Direct communication to referring provider Care management, if appropriate Plan: " S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="CC Plan may include specialty and associated appt information, date of surgery post op needs, post d/c appointment and any other care coordination plan" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Additional Notes (Optional):" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Complex/Chronic" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Care coordination was determined from:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Individual Veteran's Point of Contact:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="VA Community Provider" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="DoD" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Appointment Date:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Enter/Edit Admission Information" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Veteran Admitted?" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Same Facility" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Other Facility" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Moderate Care Coordination Services Case Management, if appropriate Direct communications with interdisciplinary team Plan:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Immediate facilitation of requested services and direct communication with the Veteran's providers Plan:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Facility POC:" S T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T4,T2,T5
 Q
CMA ;
 D COMMON^TIUCCRHL7P4
 K T2,T4 S T4="VA Facility Community Care Office HSRM Care Coordination Plan Note - Case Management Addendum",T2($G(T4))=$C(160)_$G(T4)_$C(160) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4=$C(160)_" Please review all notes, this note may have one or more of the following addenda associated: ",T2($G(T4))=$C(10)_$G(T4) S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Care Coordination Follow Up: ",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Case Management:",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T2,T4 S T4="Warm handoff (if clinically indicated) to lead care coordinator on",T2(T4)=$C(10)_T4 S WORDS=$$REPLACE^XLFSTR(WORDS,.T2)
 K T4,T2,T5
 Q
