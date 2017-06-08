EDRBOUNC ; EDR inactivity bouncer , removes inactive jobs [ 10/22/93  11:54 AM ]
 W !,"Called by entry point only!..."
 W !,"D BACKG^EDRBOUNC is for background checking every 3 minutes."
 W !,"D CHECK^EDRBOUNC is for interactive one-time checking."
 QUIT
 ;
BACKG ; go off in the background and check every 3 minutes
 N devjobs,idevlist,jobstoKI
 FOR  D  H 180 ; Only way to stop it is by ^KILLJOB
 . S idevlist=$$IDEVLIST() ; get a list of the interesting devices
 . S devjobs=$$ODEVLIST(idevlist) ; Get a job (if OPEN) for each device
 . S jobstoKI=$$INACTIVE(devjobs)
 . S X=$$KILLJOBS(jobstoKI)
 QUIT  ; probab;y will never get here
 ;
CHECK ; Check for INACTIVE processes
 N I,devjobs,idevlist,jobstoKI
 S idevlist=$$IDEVLIST() ; get a list of the interesting devices
 W !,"Devices to watch: ",$TR(idevlist,"^"," ")
 S devjobs=$$ODEVLIST(idevlist) ; Get a job (if OPEN) for each device
 W !,"Devices owned by someone: " F I=1:1:$L(devjobs,"^") DO  ;
 . I $P(devjobs,"^",I)[";" W !,$TR($P(devjobs,"^",I),";","-")
 S jobstoKI=$$INACTIVE(devjobs)
 W !,"Jobs which are inactive: " F I=1:1:$L(jobstoKI,"^") DO  ;
 . I $P(jobstoKI,"^",I)[";" W !,$P($P(jobstoKI,"^",I),";",2)
 S X=$$KILLJOBS(jobstoKI)
 W !,"Done..."
 QUIT
 ;
IDEVLIST() ; quit a list of interesting devices in format {dev}^{dev}^{dev}
 Q "102^3^4^5^6^7^8"
 ;
ODEVLIST(list)     ; return list with jobs in format {dev};{job}^{dev};{job}
 N dev,devtab,devmax,I,job,jobinfo
 S devtab=$V(5,-5),devmax=$V(devtab,-3,2)
 F I=1:1:$L(list,"^") S dev=$P(list,"^",I) DO
 . I dev>devmax QUIT  ; quit if device out of range
 . S jobinfo=$V(devtab+(dev*2),-3,2) Q:(jobinfo=0)!(jobinfo#4)
 . S job=jobinfo/4,$P(list,"^",I)=$P(list,"^",I)_";"_job
 Q list
INACTIVE(list)     ; check for inactivity on 'list' which is in format:
 ;  {dev};{job}^{dev};{job}
 N d,inact,I,job,check
 ; Get starting values for each 'job' into 'inact'
 F I=1:1:$L(list,"^") S job=$P($P(list,"^",I),";",2) I +job DO  ;
 . S inact(job)=$V(96,job,4)_$V(100,job,4)
 ; 5 checks with 5 seconds between
 FOR check=1:1:5 H 5 DO  I list'[";" QUIT  ; ran out of jobs to check 
 . F I=1:1:$L(list,"^") S job=$P($P(list,"^",I),";",2) I +job DO  ;
 . . I inact(job)'=($V(96,job,4)_$V(100,job,4)) DO  
 . . . S $P(list,"^",I)=$P($P(list,"^",I),";")
 Q list 
 ;
KILLJOBS(list)     ; kill the jobs in 'list'
 N I
 F I=1:1:$L(list,"^") S job=$P($P(list,"^",I),";",2) I +job DO  ;
 . V $V(44)+84:-3:job*4:2
 . F  H 1 D ^%ACTJOB Q:'(+($E(%ACTIVE0,job)))
 . S dev=$P($P(list,"^",I),";")
 . I ((dev#100)>7)&((dev#100)<11) DO  ;
 . . S JOBWAIT=$$JOBWAIT^%HOSTCMD("LATCLOSE "_(dev#100+6))
 . S ^EDRUTIL("EDRBOUNC",$H)=job_" "_dev
 Q list
