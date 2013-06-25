//first quick attempt at a cyclic gear , using CSG method 
//by david powell
//GPLv2
/*
probabaly not the best way to do it 
as its got rather crude surface setps 
use of minkowski () may resolve that ? 
needs some tweeking for fully parametic values 
and for value ranges 
actual sizes may be out also atm but profile shape seems ok
 
its still work in progress may dich in favour of quicker method 

performance 

Total rendering time: 0 hours, 25 minutes, 0 seconds 
result is a 3d valid object
using one core on a dell 470 3ghz dual xeon 64 bit opensuse 12.3

*/ 

PCD = 40; // pich diameter of gear(needs verification)
N= 16;	 // number of teeth on gear
T= 5;		 // thickness 
X = 2.5; //tooth profile hight range(needs verification)
fT= 10;   // face steps 
//premath
PA = 360/N;



Cyclic_Gear(PCD, PA , N ,X, T ,fT);


module Cyclic_Gear(PCD, PA , N ,X, T ,fT, outside)

	difference()
	{
	cylinder(h=T, r=(PCD+X)/2,center=true,$fn=360);
		{
		for (c = [0 : 360/N :360])
			{
			for (i = [0:fT:360])
				{
				rotate([0,0,( c + ( (PA/360)*i ) )])
				translate([( (PCD/2)-(X/2) + (cos(i)*X/2)),0,0])
					{
					cylinder(h=T+.001,r=.5,center=true,$fn=20);
					translate([X,0,0])
					cube([X*2 ,1,T+.001],center=true);
					}
				}
			}
		}
	}
