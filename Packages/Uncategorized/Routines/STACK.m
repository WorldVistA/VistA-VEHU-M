STACK(job,stack) ;BFH;GET STACK TRACE-BACK [ 02/06/96  5:49 PM ]
 ;Copyright Micronetics Design Corp. @1995
 ;
 ; {1} APC 02/06/96 Handle View command restriction
 ; How to use (note call by reference on second parameter):
 ;
 ; I $$^STACK(job,.stack)=2 ; not running MSM Version 4.0
 ; I $$^STACK(job,.stack)=1^$ZE ; unexpected error occurred
 ; I $$^STACK(job,.stack)=-1 ; job is not active
 ; I $$^STACK(job,.stack)=0 ; job is active,
 ;                            and the following is returned
 ;     stack=last_level (first is 0)
 ;     stack("$ZR")=$ZREFERENCE
 ;     stack("STACK")=stack_size_(bytes)^free_stack_(bytes)
 ;     stack("STAP")=stap_size_(bytes)^free_stap_(bytes)
 ;     stack(LEVEL)=line executed at that execution level
 ;
 
 
 
 
 
 
 
 
 
 
 
 
 
 ;
 ;
ERR ;
 
 
 ;
FMTLEVEL(esp) ;format level
 
 
 
RLEVEL ;format routine level
 
 ;search routine for label + offset
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ;
 ;
XLEVEL ;format execute level
 
 
 
 
