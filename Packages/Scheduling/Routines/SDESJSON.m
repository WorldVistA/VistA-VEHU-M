SDESJSON ;ALB/MGD/ANU,TAW - VISTA SCHEDULING JSON UTILITIES ;Sep 30, 2021
 ;;5.3;Scheduling;**788,794,797,799,800,801**Aug 13, 1993;Build 6;Build 13
 ;;Per VHA Directive 6402, this routine should not be modified
 Q
 ; This routine documents the entry points for the new ??? GUI.
 ;
ENCODE(SDESINP,SDESOUT,SDESERR) ;
 ; Input: SDESINP = Required: Properly formatted input array to convert to JSON
 ;        SDESOUT = Required: Name of string to return to Broker
 ;        SDESERR = Optional: Name of string for error messages.
 ; Output:
 ;        SDESOUT = JSON formatted string
 ;        SDESERR = Still under development by Kernel
 ;
 ; Validate Input Parameters
 I '$D(SDESINP) D ERRLOG(.SDESINP,52,"Input Data Required.")
 D ENCODE^XLFJSON("SDESINP","SDESOUT","SDESERR")
 Q
 ;
ERRLOG(SDESIN,SDESERRNUM,SDESOPTMSG,SDESRINFO) ;
 ; Input:     SDESIN = Required: Array name with related data to be logged
 ;        SDESERRNUM = Required: Error # to return
 ;        SDESOPTMSG = Optional message string to append to existing error in table
 ;         SDESRINFO = Optional message string with Routine^Tag info to append to existing error in table
 N SDESCNT
 S SDESOPTMSG=$G(SDESOPTMSG),SDESRINFO=$G(SDESRINFO)
 I '$D(SDESIN) S SDESIN("Error",0)=""
 S SDESERRNUM=$G(SDESERRNUM,0)
 S SDESCNT=$O(SDESIN("Error",""),-1)+1
 S SDESIN("Error",SDESCNT)=$$ERRLKUP(SDESERRNUM,SDESOPTMSG,SDESRINFO)
 K SDESIN("Error",0)
 Q
 ;
ERRLKUP(SDNUM,SDESOPTMSG,SDESRINFO) ;
 N SDERRMSG
 S SDERRMSG=$T(ERRTXT+SDNUM+1)
 S SDERRMSG=$P(SDERRMSG,U,2)
 I SDERRMSG="" S SDERRMSG="Invalid Error Number."
 I $G(SDESOPTMSG)'="" D
 . ;Strip off $C(30) and $c(31) that are part of non JSON error text
 . S SDESOPTMSG=$$CTRL^XMXUTIL1(SDESOPTMSG)
 . I $E(SDERRMSG,$L(SDERRMSG))="." S SDERRMSG=$E(SDERRMSG,1,$L(SDERRMSG)-1)
 . S SDERRMSG=SDERRMSG_": "_SDESOPTMSG
 I $E(SDERRMSG,$L(SDERRMSG))'="." S SDERRMSG=SDERRMSG_"."
 ; Add optional Debug info
 I SDESRINFO'="" S SDERRMSG=SDERRMSG_" Debug: "_SDESRINFO
 Q SDERRMSG
 ;
 ; Standard Error Messages. Add additional errors as needed.
 ; Limit new error messages to 30 characters.
ERRTXT ;
 ;;0^No Error Number Provided
 ;;1^Missing Patient ID
 ;;2^Invalid Patient ID
 ;;3^Missing Appointment Request ID
 ;;4^Invalid Appointment Request ID
 ;;5^Missing Consult Request ID
 ;;6^Invalid Consult Request ID
 ;;7^No Recalls for this patient
 ;;8^No Consults for patient
 ;;9^Missing begin date
 ;;10^Missing end date
 ;;11^Invalid begin date
 ;;12^Invalid end date
 ;;13^End date prior to begin date
 ;;14^Missing Appointment ID
 ;;15^Invalid Appointment ID
 ;;16^Missing Recall ID
 ;;17^Invalid Recall ID
 ;;18^Missing Clinic ID
 ;;19^Invalid Clinic ID
 ;;20^Clinic not defined
 ;;21^Missing Check In Date
 ;;22^Invalid Check In Date
 ;;23^Missing Check Out Date
 ;;24^Invalid Check Out Date
 ;;25^Missing begin date/time
 ;;26^Missing end date/time
 ;;27^Invalid begin date/time
 ;;28^Invalid end date/time
 ;;29^End date/time prior to begin date/time
 ;;30^No status match found
 ;;31^Appointment status is cancelled
 ;;32^Duplicate status entry
 ;;33^No statuses available
 ;;34^Status not created
 ;;35^Status not updated
 ;;36^Status not set
 ;;37^Status not found
 ;;38^No status sent
 ;;39^Status is less than 3 characters or greater than 30 characters
 ;;40^Missing check-in step ID
 ;;41^Status must contain characters
 ;;42^Missing Disposition
 ;;43^Invalid Disposition
 ;;44^Invalid user
 ;;45^Missing date
 ;;46^Invalid date
 ;;47^Failed create/update
 ;;48^Missing Origination date/time
 ;;49^Invalid Origination date/time
 ;;50^Missing Clinic name
 ;;51^Invalid Clinic Name
 ;;52^Error
 ;;53^Missing Provider ID
 ;;54^Invalid Provider ID
 ;;55^Invalid Disposition Date
 ;;56^Missing Disposition Date
 ;;57^Missing Desired Date Of Appointment
 ;;58^Invalid Desired Date Of Appointment
 ;;59^Desired Date of Appt can not be in the past
 ;;60^Missing Appointment Request Type
 ;;61^Invalid Appointment Request Type
 ;;62^Missing Requested By
 ;;63^Clinic Name or Clinic Stop is required
 ;;64^Search String length is less than 2 characters
 ;;65^No Providers found that match Search String
 ;;66^Patient IEN cannot be blank
 ;;67^Clinic IEN cannot be blank
 ;;68^No VVS information found
 ;;69^Missing Clinic Resource ID
 ;;70^Invalid Clinic Resource ID
 ;;71^Date can not be in the past
 ;;72^Date can not be in the future
 ;;73^Missing Clinic Resource
 ;;74^Current appt time span is greater than new appt time span
 ;;75^No available appointment slots
 ;;76^Missing Appointment date/time
 ;;77^Invalid Appointment date/time
 ;;78^Appointment must be in a scheduled state
 ;;79^Slots for Block & Move not identifiable
 ;;80^Clinic Name/Clinic IEN not found
 ;;81^Error in inactivating Clinic
 ;;82^Invalid Letter
 ;;83^Invalid Default appointment type
 ;;84^Missing Diagnosis code
 ;;85^Invalid Diagnosis code
 ;;86^Invalid Privileged user
 ;;87^Invalid Clinic meets at this facility
 ;;88^Missing Allow direct patient scheduling
 ;;89^Invalid Allow direct patient scheduling
 ;;90^Missing Display clinic appt to patient
 ;;91^Invalid Display clinic appt to patient
 ;;92^Missing Service
 ;;93^Invalid Service
 ;;94^Missing Non-count clinic
 ;;95^Invalid Non-count clinic
 ;;96^Missing Division
 ;;97^Invalid Division
 ;;98^Missing Stop Code
 ;;99^Invalid Stop Code
 ;;100^Invalid Require action profile
 ;;101^Invalid Ask for check in/out time
 ;;102^Invalid Default to PC practitioner
 ;;103^Invalid Workload validation at checkout
 ;;104^Missing Allowable consecutive no-shows
 ;;105^Invalid Allowable consecutive no-shows
 ;;106^Missing Max number days for future booking
 ;;107^Invalid Max number days for future booking
 ;;108^Missing Credit stop code
 ;;109^Invalid Credit stop code
 ;;110^Invalid Principal clinic
 ;;111^Missing Overbook/day max
 ;;112^Invalid Overbook/day max
 ;;113^Invalid E-Checkin
 ;;114^Invalid Pre-Checkin
 ;;115^Missing Length of appointment
 ;;116^Invalid Length of appointment
 ;;117^Missing Display increments per hour
 ;;118^Invalid Display increments per hour
 ;;119^Invalid Hour clinic display begins
 ;;120^Current default provider must be removed prior to setting new default
 ;;121^Current default diagnosis must be removed prior to setting new default
 ;;122^Invalid Administer inpatient meds
 ;;123^Invalid Require x-ray films
 ;;124^Can't Block & Move
 ;;125^Invalid number of Appointment slots
 ;;126^Availability is not defined for this clinic
 ;;127^Missing User
 ;;128^Missing Cancellation Reason
 ;;129^Invalid Cancellation Reason
 ;;130^Missing VPID
 Q
