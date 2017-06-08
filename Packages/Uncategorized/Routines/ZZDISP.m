ZZDISP ;ROUTINE TO DISPLAY KERNEL INFO [ 08/24/94  9:12 AM ]
 ;
 S IOP="HOME" D ^%ZIS
 W @IOF
 W !,?28," What is Kernel?"
 W !
 D READ W !,?22," Kernel is a Set of Services"
 W !,?17,"that provide the software support platform"
 W !,?17,"where our particular hospital application runs."
 D READ W @IOF,!!!!,?22," Database Management (VA FileMan)"
 D READ W @IOF,!!!!,?22," Electronic Mail (MailMan)"
 D READ W @IOF,!!!!,?22," Signon Security"
 D READ W @IOF,!!!!,?22," Device Management"
 D READ W @IOF,!!!!,?22," Background Processing (TaskManager)"
 D READ W @IOF,!!!!,?22," Programming Tools"
 D READ W @IOF,!!!!,?22," User Environment"
 D READ W @IOF,!!!!,?22," System Management Tools (Menu Manager)"
 W !,?22,"                         (Help Processing)"
 Q
READ ;
 R X
 Q
