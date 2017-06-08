RJTPR ;
 S BT=$P($H,",",2)
 S DD=0,EE=0,FF=0
 F I=0:0 S DD=$O(^PRCA(433,DD)) Q:DD="ACE"  W "." I $D(^PRCA(433,DD,1)) D CT
 W !,"Total records processed "_FF
 W !,EE_" 4TH qtrrecords processed in"
 W !,$P($H,",",2)-BT_" seconds"
 Q
CT ;
 I $P(^PRCA(433,DD,1),"^",1)>2941001 S EE=EE+1
 S FF=FF+1
 Q
