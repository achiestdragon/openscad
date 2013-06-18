//test file for Generic-Lib-Main.scad functions 
//
// filename Generic-Function-Test.scad  ver 0.01a
//
include <Generic-Function-Lib.scad>;
//

//center referance point 
 	translate([0,0,0])
	#cube([5,5,5],center=true);

//cubic array  of  5*5*5 objects spaced 10*10*10 center relative
 	Cubic_Array(10,10,10,5,5,5,center=true)
		{
		sphere(2.5,center=true,$fn=60);
		}

//a linear array allong x can be derived from the cubic array simply 
	translate([60,0,0])
   Cubic_Array(10,0,0,5,1,1,center=false)
		{
		cube([5,5,5],center=true);
		} 
//a linear array allong y can be derived from the cubic array simply 
	translate([0,60,0])
   Cubic_Array(0,10,0,1,5,1,center=false)
		{
		cube([5,5,5],center=true);
		} 

//a linear array allong z can be derived from the cubic array simply 
	translate([0,0,60])
   Cubic_Array(0,0,10,1,1,5,center=false)
		{
		cube([5,5,5],center=true);
		} 

//a grid  array allong x,y can be derived from the cubic array simply 
	translate([0,0,-60])
   Cubic_Array(10,10,0,5,5,1,center=true)
		{
		cube([5,5,5],center=true);
		} 

//radial array of 32 objects rotated though 10 degrees 
 	translate([0,0,0])
 	Radial_Array(10,32,40)
		{
		cube([2,4,6],center=true);
		}

// a radial array of linear arrays 

 	rotate([45,45,45])
  	Radial_Array(10,36,40)
		{
		translate([0,10,0])
   	Cubic_Array(0,10,0,1,5,1,center=false)
			{
			cube([2,3,4],center=true);
			}
		}

// end of file 
