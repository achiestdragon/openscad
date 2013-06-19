// file  to test out the usabilaty of the Generic_Lib
// by david powell 
// LGPL V2 or later 

include <Generic-Lib-Main.scad>;

// an inital file created just to see if the main lib script works 
// and test some of the functions  
// Cubic_Array , Radial_Array 
//
//edit >preferences >advanced turn off rendering needs to be set to 4000 for it to render correctly 
//
main();

module main ()
	{
	Cubic_Array(130,200,0,3,2,1,center=true)
	rotate([90,0,0])
	wheel();

	difference()
		{
		Cubic_Array(130,0,0,3,1,1,center=true)
		color(ABS_Red)
		rotate([90,0,0])
		cylinder_tube(height=210, radius=20, wall=5, center = true,$fn=360);

		translate([0,0,30])
		rotate([0,90,0])
		cylinder(h=360, r=60,center = true,$fn=360);
		}
	color(ABS_Red)
	translate([0,0,30])
	rotate([0,90,0])
	cylinder_tube(height=365, radius=60,wall=8,center = true,$fn=360);

	color(ABS_Red)
	translate([-2.5,0,30])
	rotate([90,0,0])
	Cubic_Array(40,0,0,10,1,1,center=true)
		{
		rotate([0,90,0])
		hexagon_tube(height=5,radius=60,wall=10);//no center=true option on this function
		}
	}

module wheel()
	{
	difference()
		{
		color(METAL_Brass)
		cylinder(h=15,r=45,center=true,$fn=360);

		color(METAL_Brass)
		cylinder(h=18,r=40,center=true,$fn=360);
		}
	
	Radial_Array(51.42857,7,50)
	bearing_assembly();

	color(METAL_Stainless)
	torus2(r1=57, r2=6,$fn=360);

	color(METAL_Steel)
	rotate(25.7143,0,0)
	Radial_Array(51.42857,7,50)
	rotate([90,0,0])
	translate([0,0,2])
	bolt(4,30);

	}

module bearing_assembly ()
	{
	translate([0,0,-10])
	rotate([-45,0,0])
		{
		bearing([0,0,0],[90,0,0],model=604,center=true);
		color(METAL_Steel)rotate([90,0,0])translate([0,0,-3])bolt(4,12);
		color(METAL_Copper)rotate([90,0,0])translate([0,0,-0.5])washer(4);
		color(METAL_Copper)rotate([90,0,0])translate([0,0,4.25])washer(4);
		}
	translate([0,0,10])
	rotate([45,0,0])
		{
		bearing([0,0,0],[90,0,0],model=604,center=true);
		color(METAL_Steel)rotate([90,0,0])translate([0,0,-3])bolt(4,12);
		color(METAL_Copper)rotate([90,0,0])translate([0,0,-0.5])washer(4);
		color(METAL_Copper)rotate([90,0,0])translate([0,0,4.25])washer(4);
		}
	}
