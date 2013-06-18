
// Generic module functions Library 
// filename "SCAD/Generic-Function-Lib.scad" version 0.01a
//
// see openscad/libraries/SCAD/Generic-Lib-Main.scad for guidelines 

//	generic extended functions 
// other relivant functions should be added here also but some additions of :-  
//
// proposed modules to be included 
//
//Clearance(*gap*) 	draws object scailed to %tolarance bigger for correct clearance using difference()
//	ie      
//    difference() {
//	cube([20,20,5],center=true)
//	Clearance(*gap*)bolt(4,20);  
// *gap* should be based on using a local system value for a printer clearance value 
// would produce a hole that would be a clearance fit within the tolarance defined by *gap*
//
//
//

//
//Cubic_Array(sx,sy,sz,nx,ny,nz,center){childobject}
//  produces a cubic grid of child objects 
//  sx,sy,sz = spacing for each axis 
//  nx,ny,nz and number of objects on each axis 
//  center = true/false on if geometory is centered or not 
//
module Cubic_Array(sx,sy,sz,nx,ny,nz,center)
	{
	if (center==true)
		{
		translate([-(((nx+1)*sx)/2),-(((ny+1)*sy)/2),-(((nz+1)*sz)/2)])
			{
			for(x=[1:nx])
				{
				for(y=[1:ny])
					{
					for(z=[1:nz])
						{
						translate([x*sx,y*sy,z*sz])
						child(center=true);
						}
					}
				}
			}
		}
	else
		{
		translate([0,0,0])
			{
			for(x=[1:nx])
				{
				for(y=[1:ny])
					{
					for(z=[1:nz])
						{
						translate([x*sx,y*sy,z*sz])
						child();
						}
					}
				}
			}
		}
	}

//
//Radial_Array(a,n,r){child object}
// produces a clockwise radial array of child objects rotated around the local z axis   
// a= interval angle 
// n= number of objects 
// r= radius distance 
//
module Radial_Array(a,n,r)
{
 for (k=[0:n-1])
 {
 rotate([0,0,-(a*k)])
 translate([0,r,0])
 child();
 }
}
