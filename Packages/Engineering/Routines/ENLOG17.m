ENLOG17 ;(WASH ISC)/DH-Intro to Merger ;2-11-92
 ;;;;
 ;CLASS 3 SOFTWARE - Not officially supported by the ISC's
 W @IOF,!,"   **  You are now in the LOG1 to AEMS/MERS Merger Utility.  **"
 W !!,"You will have the option of automatically creating new AEMS/MERS Equipment",!,"Records for LOG1 entries that are not presently in AEMS/MERS."
 W !!,"As a general rule, the Washington ISC recommends that you NOT use this",!,"feature.  Our concern is that you may automatically create inappropriate"
 W !,"AEMS/MERS records which will subsequently need to be deleted."
 W !!,"We believe that it is safer to:",!,?10,"1. Use FileMan to print information on LOG1 records that"
 W !,?13,"are not in AEMS/MERS (print from File 6914.5 where the DHCP",!,?13,"EQUIPMENT POINTER is null),"
 W !,?10,"2. Manually add to AEMS/MERS those records that should be added,"
 W !,?10,"3. Re-run this Merger Utility to capture data on new entries."
 W !,"When adding these new AEMS/MERS records, it is only necessary to enter",!,"MANUFACTURER, MODEL (if available), SERIAL NUMBER (if available), and VA PM #.",!,"Other data will be picked up when you re-run this Merger Utility."
 W !!,"NOTE: This utility may be re-run at any time in order to pick up records or",!,"      data elements that were skipped over on the first pass."
 R !!,"Press <RETURN> to continue...",X:DTIME
 Q
 ;ENLOG17
