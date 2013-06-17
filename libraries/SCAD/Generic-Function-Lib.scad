
// Generic module functions Library 
// filename "SCAD/Generic-Function-Lib.scad" version 0.01a
//
// see openscad/libraries/SCAD/Generic-Lib-Main.scad for guidelines 

//	generic extended functions 
// other relivant functions should be added here also but some additions of :-  
//
// proposed modules to be included 	
//Clearance(*gap*) 	draws object scailed to %tolarance bigger for correct clearance using difference()
//	ie      
//    difference() {
//	cube([20,20,5],center=true)
//	Clearance(*gap*)bolt(4,20);  
// *gap* should be based on using a local system value for a printer clearance value 
// would produce a hole that would be a clearance fit within the tolarance defined by *gap*
//
//Cubic_Array(spacing, nos_on_each axis){childobject}
//      produces a cubic grid of child objects   spaced at [x,y,z] repeated [x,y,z]
//      ie Cubic_Array([10,10,10],[5,5,5]) would produce a array of 5*5*5 child objects spaced at 10,10,10mm 
//
//Linear_Array(spacing , number of items ){child object}
//Radial_Array(angle ,number of items  ){ child object}
//
// open to ideas for others 
//