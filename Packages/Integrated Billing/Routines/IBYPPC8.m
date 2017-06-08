IBYPPC8 ;ALB/ARH - IB*2*52 POST INIT:  TYPE OF PLAN 355.1 UPDATES ; 22-MAY-1996
 ;;Version 2.0 ; INTEGRATED BILLING ;**52**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
TPAF ;; New Types of Plans (355.1)
 ;;AUTOMOBILE^AUTO^MAJOR MEDICAL^AUTO
 ;;CARVE-OUT^COUT^MAJOR MEDICAL^COUT
 ;;CHAMPVA^CVA^MAJOR MEDICAL^CVA
 ;;MEDICARE SECONDARY^MS^MAJOR MEDICAL^MEDIS
 ;;POINT OF SERVICE^POS^HMO^POS
 ;;TORT FEASOR^TORT^ALL OTHER^TORT
 ;;
TPEF ;;
 ;;HEALTH MAINTENANCE ORGANIZ^^^HMO
 ;;HOSPITAL EXPENSE INSURANCE^^^HEI
 ;;INDEMNITY^^^INDM
 ;;MEDI-CAL^^^MEDIC
 ;;MEDIGAP INSURANCE^^^MEDIG
 ;;MENTAL HEALTH ONLY^^^MHO
 ;;SENIOR CITIZEN POLICIES^^^RETIREE
 ;;
TPNF ;;
 ;;HOSPITAL EXPENSE INSURANCE^INPATIENT (BASIC HOSPITAL)^IBH
 ;;INDEMNITY^INCOME PROTECTION (INDEMNITY)^
 ;;MEDICAL EXPENSE INSURANCE^MEDICAL EXPENSE (OPT/PROF)^
 ;;MEDIGAP INSURANCE^MEDIGAP (SUPPLEMENTAL)^
 ;;MENTAL HEALTH ONLY^MENTAL HEALTH^
 ;;PRESCRIPTION ONLY^PRESCRIPTION^
 ;;SENIOR CITIZEN POLICIES^RETIREE^RETIREE
 ;;
AUTO ;;
 ;;A comprehensive medical coverage plan purchased under a policy holder's
 ;;automobile policy which provides medical benefits when an individual is
 ;;involved in an auto accident.
 ;;
COUT ;;
 ;;Employer provided benefits that deduct the amount that any other
 ;;insurance pays for a service from the plan's allowed charge for the same
 ;;service and pays the difference after the patient pays the annual
 ;;deductible.
 ;;
CVA ;;
 ;;The Civilian Health and Medical Program for the Veterans Administration
 ;;is a health benefit plan for the families of veterans with 100% service
 ;;connected disabilities and the surviving spouse and/or children of a
 ;;veteran who dies from a service connected disability.
 ;;
POS ;;
 ;;This plan requires the selection of primary care physician and/or a
 ;;primary care facility.  Benefits will be paid to out of network
 ;;providers/facilities at a reduced rate.  However, if authorization is
 ;;received from the primary care physician, the plan will pay the reasonable
 ;;and customary rate for the treatment.
 ;;
MEDIS ;;
 ;;This is a plan for a group of retirees, purchased separately after they
 ;;become Medicare eligible.  All members in this plan are retired and
 ;;Medicare eligible and the benefits are not supplemental to Medicare.
 ;;It usually pays a percentage of the Medicare co-insurance and normally has
 ;;a deductible.  For example: policy will pay 80% of the 20% not paid by
 ;;Medicare.
 ;;
RETIRE ;;
 ;;Pays secondary to Medicare and covers co-insurance and deductibles not
 ;;paid by Medicare at the time of retirement.
 ;;
TORT ;;
 ;;Another individual or organization may be at fault and responsible for
 ;;payment (i.e. a health insurance company, a casualty insurance company,
 ;;or another person in the case of an accident, etc.)
 ;;
HMO ;;
 ;;An organization that provides for a wide range of comprehensive
 ;;health care services for a specified group at a fixed periodic
 ;;payment.  An HMO can be sponsored by the government, medical schools,
 ;;hospitals, employers, labor unions, consumer groups, insurance
 ;;companies, or hospital-medical plans.  This plan may not cover medical
 ;;expenses incurred outside of the HMO physician network except on an
 ;;emergency or referral basis.
 ;;
HEI ;;
 ;;This plan con cover x-rays and labs performed in a hospital setting in
 ;;addition to all other inpatient treatment.  Does not cover professional
 ;;fees.
 ;;
INDM ;;
 ;;A plan that is designed to protect against loss of income resulting
 ;;from disability and/or major illness.
 ;;
MEDIC ;;
 ;;California's state governmental Medicaid policy.  Pays secondary to Medicare.
 ;;
MEDIG ;;
 ;;This is a plan purchased individually as a supplemental policy and is
 ;;designed to cover Medicare deductibles and coinsurance amounts.  These
 ;;policies are not available to any individuals not covered by Medicare 
 ;;and would usually be purchased directly by the individual.  Benefits
 ;;not covered by Medicare are not covered by a supplemental.
 ;;
MHO ;;
 ;;Plan which covers mental health care and substance abuse care.
 ;;
RETIREE ;;
 ;;Plan pays secondary to Medicare and covers co-insurance and deductibles
 ;;not paid by Medicare at the time of retirement.
 ;;
