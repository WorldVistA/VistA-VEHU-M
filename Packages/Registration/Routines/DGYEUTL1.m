DGYEUTL1 ;ALB/MTC - UTILITY ROUTINES FOR EPRP CONT ; 10 Mar 95 / 8:13 AM
 ;;1.0; DGYE ;**3,5,7,13,15**;28 Apr 92
REVIEW(TASK) ;-- This function will return the number of records to be
 ; displayed for each task.
 ;  INPUT  : TASK - task to find how many items to print
 ;  OUTPUT : Number of items to print
 ;         : 0 - ALL
 ;         : N - number to print
 ;         : "" - none or error
 N RESULT,X
 S RESULT=""
 I TASK="5A" S RESULT=4 G REVQ
 I TASK="3C" S RESULT=2 G REVQ
 I TASK="4I" S RESULT=0 G REVQ
 I TASK="4Z" S RESULT=3 G REVQ
 I TASK="4W" S RESULT=2 G REVQ
 I TASK="4B" S RESULT=2 G REVQ
 I TASK="4F" S RESULT=0 G REVQ
 I TASK="4Y" S RESULT=2 G REVQ
 I TASK="4A" S RESULT=5 G REVQ
 I TASK="4E" S RESULT=2 G REVQ
 I TASK="3D" S RESULT=4 G REVQ
 I TASK="4J" S RESULT=2 G REVQ
 I TASK="3E" S RESULT=5 G REVQ
 I TASK="3G" S RESULT=2 G REVQ
 I TASK="3N" S RESULT=3 G REVQ
 I TASK="3I" S RESULT=0 G REVQ
 I TASK="3L" S RESULT=4 G REVQ
 I TASK="3J" S RESULT=2 G REVQ
 I TASK="3K" S RESULT=0 G REVQ
 I TASK="5C" S RESULT=2 G REVQ
 I TASK="6A" S RESULT=4 G REVQ
 I TASK="6B" S RESULT=4 G REVQ
 I TASK="7A" S RESULT=4 G REVQ
 I TASK="7B" S RESULT=2 G REVQ
REVQ Q RESULT
 ;
ROUND(X) ;-- This function will round the number X up to the 
 ; next whole number.
 ;  Ex:   3.4 -> 4, 3.5-> 4,3.9->4
 ;    INPUT  : X - Number to round
 ;    OUTPUT : Rounded number
 N RESULT,Y,Z
 S Y=$P(X,"."),Z=$P(X,".",2)
 S RESULT=Y+1
 Q RESULT
 ;
