// a beam engine solid model exersize
//
// by David Powell  (aka AchiestDragon)
//
//	LGPL v2 or later
// 
//	notes:-
//  set prefrences>render> turn of rendering at 4000 elements 
// its just a mockup and not inteded for 3d printing 
//	as its would use all metal for a start
//	
// done partly to actualy draw a beam engine and also test out the functionaly of the scad editor
// its a long file almost 2000 lines long 
// 
// theres easier and more optimized ways in openscad to do CSG for the parts than used here 

// the single lib include file calling on other libs
// actual final locaton of this lib to be defined 
// at the moment i did make a start on adding and updating some of the Mcad libs but cant seem to get a responce about sumbissons  

//this includes MCAD/bearing.scad and others
// note it needs my updated sizes patch (13/6/13) version of bearing.scad with 604 ,bearing pending pullrequest
// sizes used   604,608
// 
// current lib fix is to put the contents of openscad/libraieies/SCAD from my openscad fork  into the folder opened by file>Show library folder

include <Generic-Lib-Main.scad>;

main();

module main()
{
	// not colored parts(using default color)
	translate([0,0,0])
	flywheel();
	translate([0,-76,0])
	flywheel();

	// moudules with color settings in them 
	crank_mounting_hw();
	beam_pivot_pin_hw();
	beam_support_bolts();
	cylinder_mounting_hw();
	beam_assembly(); 
	end_coupler_hw();
	crank_shafta_hw();
	cranka();
	crankb();
	crank_shaftb_hw();
	crank_main_bearings();
	valve_mounting_hw();
	//flywheel pushrod bearing
	translate([140,0,-28])
	rotate([90,90,0])
	bearing([0,0,-2],[0,0,0],model=604,outline=false);
	//center valve toggle bearing
	translate([0,0,0])
	rotate([90,90,0])
	bearing([0,0,-3.5],[0,0,0],model=608,outline=false);
	//outer valve toggle bearing
	translate([65,0,0])
	rotate([90,90,0])
	bearing([0,0,-2],[0,0,0],model=604,outline=false);

	//outer valve toggle end spring bearing
	translate([140,0,0])
	rotate([90,90,0])
	bearing([0,0,-2],[0,0,0],model=604,outline=false);

	color(METAL_Aluminium)//aluminium
		{
		main_beam_pivot_block();
		lower_beam_support_block();
		lower_cylinder_block();
		upper_cylinder_block();
		conrod_end();
		crank_shaft_bearing_carriers();
		piston();
		conrod_end_couplers();
		fly_push_rod();
		valve_block();
		valve_top_block();
		valve_conrod_end();
		toggle_bar();
		toggle_spring_end();
		}

	color(METAL_Copper)//copper
		{
		beam_support_tube();
		cylinder_tube();
		translate([-65,-2.5,0])
		rotate([-90,0,0])
		washer(4);
		translate([90,0,0])
		rotate([0,90,0])
		washer(6);
		translate([129.5,0,0])
		rotate([0,90,0])
		washer(6);
		pipes();
		}

	color(GRAY)//(dark gray)
		{
		base_plate();
		}
	
	color(METAL_Brass)//brass
		{
		piston_conrod();
		cylinder_pipe_hw();
		translate([0,10,0])
		valve_top_hw();
		translate([0,-10,0])
		valve_top_hw();
		translate([65,0,-40])
		//valve pushrod
		cylinder(h=50,r=3,center=true,$fn=90);
		//valve counter balcance bolt
		translate([-65,-6,0])
		rotate([-90,0,0])
		bolt(4,10);
		}

	color(METAL_Steel) //steel
		{
		valve_rods();
		toggle_counter_balance();
		spring();
		}
	}

//**************************************

module toggle_spring_end()
	{
	difference()
		{
		translate([140,0,0])
		cube([40,4,20],center=true);

		translate([140,0,0])
		rotate([90,90,0])
		cylinder(h=8,r=6,center=true,$fn=90);

		translate([120,0,10])
		cube([20,6,15],center=true);
		translate([120,0,-10])
		cube([20,6,15],center=true);
		}
	}
module spring() 
//FIXME;- bit thin find alternate method
	{
	translate([90,0,0])rotate([0,90,0])
	linear_extrude(height=40,twist=7200,$fn=20,convexity=5){translate([5,0,0])circle(r=0.5);}
	}

module cylinder_pipe_hw()
	{
	translate([140,35,-165])
	rotate([-90,0,0])
	pipe_fitting();
	translate([140,-35,-165])
	rotate([90,0,0])
	pipe_fitting();
	translate([140,35,-95])
	rotate([-90,0,0])
	pipe_fitting();
	translate([140,-35,-95])
	rotate([90,0,0])
	pipe_fitting();
	}
		
module pipe_fitting()
	{
	difference()
		{
		union()
			{
			cylinder(h=15,r=4,center=true,$fn=100);
			translate([0,0,5])
			cylinder(h=5,r=5,center=true,$fn=6);
			}
		cylinder(h=20,r=2.5,center=true,$fn=100);
		}
	}

module toggle_bar()
	{
	difference()
		{
		translate([0,0,0])
		cube([200,4,30],center=true);
		
		rotate([90,90,0])
		cylinder(h=10,r=11,center=true,$fn=90);
		// valve end slot
		translate([55,0,0])
		rotate([90,90,0])
		cylinder(h=10,r=7,center=true,$fn=90);	
		translate([75,0,0])
		rotate([90,90,0])
		cylinder(h=10,r=7,center=true,$fn=90);
		translate([65,0,0])
		cube([20,5,14],center=true);		
		//mill allong top/bottom valve end
		translate([50,0,15])
		cube([70,10,10],center=true);	
		translate([50,0,-15])
		cube([70,10,10],center=true);	

		translate([125,0,10])
		cube([70,10,15],center=true);	
		translate([125,0,-10])
		cube([70,10,15],center=true);	

		//counter balance end slot
		translate([-40,0,0])
		rotate([90,90,0])
		cylinder(h=10,r=2,center=true,$fn=90);	
		translate([-80,0,0])
		rotate([90,90,0])
		cylinder(h=10,r=2,center=true,$fn=90);
		translate([-60,0,0])
		cube([40,5,4],center=true);

		translate([-60,0,15])
		cube([90,10,10],center=true);	
		translate([-60,0,-15])
		cube([90,10,10],center=true);	

		//round ends to mills
		translate([-15,0,15])
		rotate([90,90,0])
		cylinder(h=10,r=5,center=true,$fn=90);
		translate([15,0,15])
		rotate([90,90,0])
		cylinder(h=10,r=5,center=true,$fn=90);
		translate([-15,0,-15])
		rotate([90,90,0])
		cylinder(h=10,r=5,center=true,$fn=90);
		translate([15,0,-15])
		rotate([90,90,0])
		cylinder(h=10,r=5,center=true,$fn=90);
		}
	}

module toggle_counter_balance()
	{
	difference()
		{
		translate([-65,0,0])
		rotate([90,0,0])
		cylinder(h=12,r=20,center=true,$fn=200);
		translate([-65,-8,0])
		cube([50,20,22],center=true);
		translate([-65,0,0])
		rotate([90,0,0])
		cylinder(h=20,r=1.5,center=true,$fn=200);
		}
	}

module beam_pivot_pin_hw()
	{
	translate([0,32,0])
	rotate([90,90,0])
	color(METAL_Brass)
	bolt(8,64);

	translate([0,-33,0])
	rotate([90,90,0])
	mirror([0,0,1])
	color(METAL_Brass)
	flat_nut(8);

	rotate([90,90,0])
	color(METAL_Copper)
		{
		translate([0,0,-26.5])
		washer(8);
		translate([0,0,26.5])
		washer(8);
		translate([0,0,-14.5])
		washer(8);
		translate([0,0,14.])
		washer(8);
		//translate([0,0,-6])
		//washer(8);
		//translate([0,0,5.5])
		//washer(8);

		}
	color(METAL_Brass)
	translate([0,-5,0])
	spacer_tube();
		
	color(METAL_Brass)
	translate([0,5,0])
	spacer_tube();	
	}

module spacer_tube()
	{
	rotate([90,90,0])
	difference()
		{
		cylinder(h=3,r=8,center=true,$fn=100);
		cylinder(h=5,r=4.5,center=true,$fn=100);
		}
	}

module cranka()
	{
	translate([-140,8,-90])
	rotate([90,90,0])
	color(METAL_Aluminium)
		{	
		difference()
			{
			cylinder(h=5,r=50,center=true,$fn=200);
			cylinder(h=10,r=3.5,center=true,$fn=60);
			translate([40,40,0])
			cylinder(h=10,r=30,center=true,$fn=100);	
			translate([-40,40,0])
			cylinder(h=10,r=30,center=true,$fn=100);
			translate([0,40,0])
			cylinder(h=10,r=4,center=true,$fn=100);
			}
		}
	translate([-140,-8,-90])
	rotate([90,90,0])
	color(METAL_Aluminium)
		{	
		difference()
			{
			cylinder(h=5,r=50,center=true,$fn=200);
			cylinder(h=10,r=3.5,center=true,$fn=60);
			translate([40,40,0])
			cylinder(h=10,r=30,center=true,$fn=100);	
			translate([-40,40,0])
			cylinder(h=10,r=30,center=true,$fn=100);
			translate([0,40,0])
			cylinder(h=10,r=4,center=true,$fn=100);
			}
		}
	}

module crankb()
	{	
	translate([-100,0,-90])
	rotate([90,90,0])
		{
		bearing([0,0,-3.5],[0,0,0],model=608,outline=false);
		color(METAL_Brass)
		cylinder(h=20,r=4,center=true,$fn=60);	
		translate([0,0,4])
		color(METAL_Copper)
		washer(8);	// copper
		translate([0,0,-4.5])
		color(METAL_Copper)
		washer(8);	// copper
		}
	}	

module fly_push_rod()
	{
	translate([-120,0,-45])
	rotate([0,-24,0],center=true)
	difference() 
		{
		translate([0,0,-4])
		cube([30,5,120],center=true);

		//bearing holes		
		translate([0,0,-49.244])
		rotate([90,0,0])
		cylinder(h=10,r=11,center=true,$fn=60);
		translate([0,0,49.244])
		rotate([90,0,0])
		cylinder(h=10,r=2,center=true,$fn=60);

		//side mill
		translate([-14,0,15])
		cube([10,10,98],center=true);
		translate([14,0,15])
		cube([10,10,98],center=true);
		translate([-14,0,-35])
		rotate([90,0,0])
		cylinder(h=10,r=5,center=true,$fn=60);
		translate([14,0,-35])
		rotate([90,0,0])
		cylinder(h=10,r=5,center=true,$fn=60);
		translate([-14,0,-63])
		rotate([90,0,0])
		cylinder(h=10,r=5,center=true,$fn=60);
		translate([14,0,-63])
		rotate([90,0,0])
		cylinder(h=10,r=5,center=true,$fn=60);

		translate([-10,0,56])
		rotate([90,0,0])
		cylinder(h=10,r=5,center=true,$fn=60);
		translate([10,0,56])
		rotate([90,0,0])
		cylinder(h=10,r=5,center=true,$fn=60);
		}
	}

module crank_shaft_bearing_carriers()
	{
	translate([0,20,0])
	crank_shaft_bearing_carrier();
	translate([0,-20,0])
	crank_shaft_bearing_carrier();
	}

module crank_shafta_hw()
	{
	translate([-140,50,-90])
	rotate([90,90,0])
	//mirror([0,0,1])
		{
		color(METAL_Brass)
		bolt(8,45); // brass
		translate([0,0,6])
		color(METAL_Copper)
		washer(8);	// copper
		translate([0,0,17])
		color(METAL_Copper)
		washer(8);	// copper
		translate([0,0,16.5])
		color(METAL_Brass)
		flat_nut(8,45); // brass
		translate([0,0,23])
		color(METAL_Copper)
		washer(8);	// copper
		translate([0,0,36])
		color(METAL_Copper)
		washer(8);	// copper
		}
	}

module crank_shaftb_hw()
	{
	translate([-140,-50,-90])
	rotate([90,90,0])
	mirror([0,0,1])
		{
		color(METAL_Brass)
		bolt(8,45); // brass
		translate([0,0,6])
		color(METAL_Copper)
		washer(8);	// copper
		translate([0,0,17])
		color(METAL_Copper)
		washer(8);	// copper
		translate([0,0,16.5])
		color(METAL_Brass)
		flat_nut(8,45); // brass
		translate([0,0,23])
		color(METAL_Copper)
		washer(8);	// copper
		translate([0,0,36])
		color(METAL_Copper)
		washer(8);	// copper
		}
	}

module crank_main_bearings()
	{
	translate([-140,20,-90])
	rotate([90,90,0])
	bearing([0,0,-1],[0,0,0],model=608,outline=false);
	translate([-140,-20,-90])
	rotate([90,90,0])
	bearing([0,0,1],[0,0,],model=608,outline=false);
	translate([-140,20,-90])
	rotate([90,90,0])
	bearing([0,0,-6],[0,0,0],model=608,outline=false);
	translate([-140,-20,-90])
	rotate([90,90,0])
	bearing([0,0,-6],[0,0,0],model=608,outline=false);
	}

module crank_shaft_bearing_carrier()
	{
	translate([-140,0,-90])
		{
		difference()
			{
			cube([60,10,30],center=true);
	
			translate([0,0,0])
			rotate([90,90,0])
			cylinder(h=20,r=11,center=true,$fn=90);

			translate([20,0,0])
			cylinder(h=50,r=3,center=true,$fn=60);
			translate([-20,0,0])
			cylinder(h=50,r=3,center=true,$fn=60);
			}
		}
	}

module conrod_end_couplers()
	{
	difference()
		{
		translate([140,5,-14.5])
		cube([10,5,38],center=true);

		translate([140,5,0])
		rotate([90,90,0])
		cylinder(h=10,r=2,center=true,$fn=60);
		translate([140,5,-28])
		rotate([90,90,0])
		cylinder(h=30,r=2,center=true,$fn=60);
		}
	difference()
		{
		translate([140,-5,-14.5])
		cube([10,5,38],center=true);

		translate([140,-5,0])
		rotate([90,90,0])
		cylinder(h=10,r=2,center=true,$fn=60);
		translate([140,-5,-28])
		rotate([90,90,0])
		cylinder(h=30,r=2,center=true,$fn=60);
		}
	}

module end_coupler_hw()
	{
	translate([140,5,-28])
	rotate([90,90,0])
		{
		translate([0,0,-6])
		color(METAL_Brass)
		bolt(4,25);
		translate([0,0,-3])
		color([0.9,0.6,0.5,1])
		washer(4);//copper
		translate([0,0,2.5])
		color([0.9,0.6,0.5,1])
		washer(4);//copper
		translate([0,0,7])
		color([0.9,0.6,0.5,1])
		washer(4);//copper
		translate([0,0,12.5])
		color([0.9,0.6,0.5,1])
		washer(4);//copper
		translate([0,0,16])
		mirror([0,0,1])
		color(METAL_Brass)
		flat_nut(4,25);//brass
		}
	}

module beam_assembly()
	{
	translate([0,10,0])
	color([0.77,0.77,0.8,1])
	main_beam();//aluminium
	translate([0,-10,0])
	color([0.77,0.77,0.8,1])
	main_beam();//aluminium
	translate([0,10,0])
	color([0.65,0.67,0.72,1])
	beam_bearings();//steel
	translate([0,-10,0])
	color([0.65,0.67,0.72,1])
	beam_bearings();//steel

	//beam end bolts and h/w
		{
		translate([140,-15.5,0])
		mirror([0,1,0])
		rotate([90,90,0])
			{
			color(METAL_Brass)
			bolt(4,32);//brass
			translate([0,0,3])
			color([0.9,0.6,0.5,1])
			washer(4);//copper
			translate([0,0,7.5])
			color([0.9,0.6,0.5,1])
			washer(4);//copper

			translate([0,0,23])
			color([0.9,0.6,0.5,1])
			washer(4);//copper
			translate([0,0,27.5])
			color([0.9,0.6,0.5,1])
			washer(4);//copper
			translate([0,0,27.5])
			mirror([0,1,0])
			color(METAL_Brass)
			flat_nut(4);//brass
			}
		translate([-140,-15.5,0])
		mirror([0,1,0])
		rotate([90,90,0])
			{
			color(METAL_Brass)
			bolt(4,32);//brass
			translate([0,0,3])
			color([0.9,0.6,0.5,1])
			washer(4);//copper
			translate([0,0,7.5])
			color([0.9,0.6,0.5,1])
			washer(4);//copper	

			translate([0,0,23])
			color([0.9,0.6,0.5,1])
			washer(4);//copper
			translate([0,0,27.5])
			color([0.9,0.6,0.5,1])
			washer(4);//copper	
			translate([0,0,27.5])
			mirror([0,1,0])
			color(METAL_Brass)
			flat_nut(4);//brass
			}
		}
	}

module beam_bearings()
	{
	//main pivot bearing
	translate([0,0,0])
	rotate([90,90,0])
	bearing([0,0,-3.5],[0,0,0],model=608,outline=false);
	//end pivot bearings
	translate([140,0,0])
	rotate([90,90,0])
	bearing([0,0,-2],[0,0,0],model=604,outline=false);
	translate([-140,0,0])
	rotate([90,90,0])
	bearing([0,0,-2],[0,0,0],model=604,outline=false);
	}

module main_beam()
	{
	difference()
		{
		cube ([300,4,30],center=true);

		//main pivot hole
		rotate([90,90,0])
		cylinder(h=10,r=11,center=true,$fn=100);
		
		//end pivot holes
		translate([140,0,0])
		rotate([90,90,0])
		cylinder(h=10,r=6,center=true,$fn=100);
		translate([-140,0,0])
		rotate([90,90,0])
		cylinder(h=10,r=6,center=true,$fn=100);

		//decoration holes along length
		for (k=[1:7])
			{
			translate([15+(k*15),0,0])
			rotate([90,90,0])
			cylinder(h=10,r=7-(k/2),center=true,$fn=100);
			translate([-15-(k*15),0,0])
			rotate([90,90,0])
			cylinder(h=10,r=7-(k/2),center=true,$fn=100);		
			}

		//mill surface flats with rounded ends
		translate([75,0,13])
		rotate([0,2,0])
		mill_flats();

		mirror([1,0,0])
		translate([75,0,13])
		rotate([0,2,0])
		mill_flats();

		mirror([0,0,1])
		translate([75,0,13])
		rotate([0,2,0])
		mill_flats();

		mirror([0,0,1])
		mirror([1,0,0])
		translate([75,0,13])
		rotate([0,2,0])
		mill_flats();

		//mill rounded ends
		translate([150,0,10])
		rotate([90,90,0])
		cylinder(h=10,r=5,center=true,$fn=60);
		translate([-150,0,10])
		rotate([90,90,0])
		cylinder(h=10,r=5,center=true,$fn=60);
		translate([150,0,-10])
		rotate([90,90,0])
		cylinder(h=10,r=5,center=true,$fn=60);
		translate([-150,0,-10])
		rotate([90,90,0])
		cylinder(h=10,r=5,center=true,$fn=60);
		// mill flats on top&bottom of beam ends
		translate([140,0,15])
		rotate([90,90,0])
		cube([10,30,10],center=true);
		translate([-140,0,15])
		rotate([90,90,0])
		cube([10,30,10],center=true);
		translate([140,0,-15])
		rotate([90,90,0])
		cube([10,30,10],center=true);
		translate([-140,0,-15])
		rotate([90,90,0])
		cube([10,30,10],center=true);
		}
	}

module mill_flats()
	{
	union()
		{
		cube([110,10,10],center=true);
		translate([55,0,0])
		rotate([90,90,0])
		cylinder(h=10,r=5,center=true,$fn=100);
		translate([-55,0,0])
		rotate([90,90,0])
		cylinder(h=10,r=5,center=true,$fn=100);
		}
	}

module main_beam_pivot_block()
	{
	difference()
		{
		translate([0,0,-15])
		cube([50,50,50],center=true);

		rotate([90,90,0])
		translate([0,,0])
		cylinder(h=60,r=4,center=true,$fn=100);
		// center slot
		cube([60,30,50],center=true);

		// side mills
		translate([20,0,0])
		cube([20,60,40],center=true);
		translate([-20,0,0])
		cube([20,60,40],center=true);
		translate([-20,0,0])
		cube([10.1,60,50],center=true);
		translate([20,0,0])
		cube([10.1,60,50],center=true);
		rotate([90,90,0])
		translate([20,15,0])
		cylinder(h=60,r=5,center=true,$fn=100);
		rotate([90,90,0])
		translate([20,-15,0])
		cylinder(h=60,r=5,center=true,$fn=100);
		//fancy top
		rotate([90,90,0])
		translate([-10,10,0])
		cylinder(h=60,r=5,center=true,$fn=100);
		rotate([90,90,0])
		translate([-10,-10,0])
		cylinder(h=60,r=5,center=true,$fn=100);

		//mounting holes
		translate([20,20,-30])
		cylinder(h=30,r=3,center=true,$fn=60);
		translate([-20,20,-30])
		cylinder(h=30,r=3,center=true,$fn=60);
		translate([20,-20,-30])
		cylinder(h=30,r=3,center=true,$fn=60);
		translate([-20,-20,-30])
		cylinder(h=30,r=3,center=true,$fn=60);	

		// support tube hole
		translate([0,0,-35])
		cylinder(h=10.1,r=12.8,center=true,$fn=60);

		//toggle limit setting bolt holes
		translate([20,0,-30])
		cylinder(h=30,r=3,center=true,$fn=60);
		translate([-20,0,-30])
		cylinder(h=30,r=3,center=true,$fn=60);
		}
	}

module beam_support_tube()
	{
	translate([0,0,-100])
	difference()
		{
		cylinder(h=140,r=12.7,center=true,$fn=100);
		cylinder(h=141,r=11,center=true,$fn=100);
		}
	}

module beam_support_bolts()
	{
	translate([20,20,-100])
	beem_support_single_bolt_hw();
	translate([-20,20,-100])
	beem_support_single_bolt_hw();
	translate([20,-20,-100])
	beem_support_single_bolt_hw();
	translate([-20,-20,-100])
	beem_support_single_bolt_hw();
	//toggle limit mounting bolts
	translate([20,0,-12])
	mirror([0,0,1])
	color(METAL_Brass)
	bolt(6,40);
	translate([-20,0,-12])
	mirror([0,0,1])
	color(METAL_Brass)
	bolt(6,40);
	translate([20,0,-20])
	mirror([0,0,1])
	color(METAL_Brass)
	flat_nut(6);
	translate([-20,0,-20])
	mirror([0,0,1])
	color(METAL_Brass)
	flat_nut(6);

	translate([20,0,-45])
	color(METAL_Brass)
	flat_nut(6);
	translate([-20,0,-45])
	color(METAL_Brass)
	flat_nut(6);
	}

module beem_support_single_bolt_hw()
	{
	//threaded brass bar
	translate([0,0,0])
	color(METAL_Brass)
	cylinder(h=160,r=3,center=true,$fn=100);
	//hardware from top down
	translate([0,0,80.5])
	mirror([0,0,1])
	color(METAL_Brass)
	flat_nut(6);//brass

	translate([0,0,75])
	color(METAL_Copper)
	washer(6);//copper

	translate([0,0,59.5])
	color(METAL_Copper)
	washer(6);//copper

	translate([0,0,55])
	color(METAL_Brass)
	flat_nut(6);//brass

	translate([0,0,-54.5])
	mirror([0,0,1])
	color(METAL_Brass)
	flat_nut(6);//brass
	translate([0,0,-60])
	color(METAL_Copper)
	washer(6);//copper
	}

module lower_beam_support_block()
	{
	difference()
		{
		translate([0,0,-165])
		cube([60,60,10],center=true);

		// hole for support tube
		translate([0,0,-165])
		cylinder(h=20,r=12.8,center=true,$fn=90);

		//holes for support bolts
		translate([20,20,-165])
		cylinder(h=20,r=3,center=true,$fn=30);
		translate([-20,20,-165])
		cylinder(h=20,r=3,center=true,$fn=30);
		translate([20,-20,-165])
		cylinder(h=20,r=3,center=true,$fn=30);
		translate([-20,-20,-165])
		cylinder(h=20,r=3,center=true,$fn=30);	

		//mill fancy edges
		translate([0,30,-160])
		cube([40,8,8],center=true);
		translate([20,30,-160])
		cylinder(h=8,r=4,center=true,$fn=60);
		translate([-20,30,-160])
		cylinder(h=8,r=4,center=true,$fn=60);

		translate([0,-30,-160])
		cube([40,8,8],center=true);
		translate([20,-30,-160])
		cylinder(h=8,r=4,center=true,$fn=60);
		translate([-20,-30,-160])
		cylinder(h=8,r=4,center=true,$fn=60);

		translate([-30,0,-160])
		cube([8,40,8],center=true);
		translate([-30,20,-160])
		cylinder(h=8,r=4,center=true,$fn=60);
		translate([-30,-20,-160])
		cylinder(h=8,r=4,center=true,$fn=60);

		translate([30,0,-160])
		cube([8,40,8],center=true);
		translate([30,20,-160])
		cylinder(h=8,r=4,center=true,$fn=60);
		translate([30,-20,-160])
		cylinder(h=8,r=4,center=true,$fn=60);
		}
	}

module base_plate()
	{
	difference()
		{
		translate([0,0,-175])
		cube([400,100,10],center=true);

		// holes for beam support bolts
		translate([20,20,-175])
		cylinder(h=20,r=2.5,center=true,$fn=30);
		translate([-20,20,-175])
		cylinder(h=20,r=2.5,center=true,$fn=30);
		translate([20,-20,-175])
		cylinder(h=20,r=2.5,center=true,$fn=30);
		translate([-20,-20,-175])
		cylinder(h=20,r=2.5,center=true,$fn=30);	
		// holes for cylinder mounting hw
		translate([140,0,-175])
			{
			translate([30,30,0])
			cylinder(h=20,r=2.5,center=true,$fn=30);
			translate([-30,30,0])
			cylinder(h=20,r=2.5,center=true,$fn=30);
			translate([30,-30,0])
			cylinder(h=20,r=2.5,center=true,$fn=30);
			translate([-30,-30,0])
			cylinder(h=20,r=2.5,center=true,$fn=30);
			}
		// holes for big end mounting hw
		translate([-140,0,-175])
			{
			translate([20,20,0])
			cylinder(h=20,r=2.5,center=true,$fn=30);
			translate([-20,20,0])
			cylinder(h=20,r=2.5,center=true,$fn=30);
			translate([20,-20,0])
			cylinder(h=20,r=2.5,center=true,$fn=30);
			translate([-20,-20,0])
			cylinder(h=20,r=2.5,center=true,$fn=30);
			}
		// holes for valve block mounting
		translate([65,0,-175])
			{
			translate([12.5,22.5,0])
			cylinder(h=20,r=2.5,center=true,$fn=30);
			translate([-12.5,22.5,0])
			cylinder(h=20,r=2.5,center=true,$fn=30);
			translate([12.5,-22.5,0])
			cylinder(h=20,r=2.5,center=true,$fn=30);
			translate([-12.5,-22.5,0])
			cylinder(h=20,r=2.5,center=true,$fn=30);
			}
		//mill fancy edges
		translate([0,50,-170])
		cube([380,8,8],center=true);
		translate([190,50,-170])
		cylinder(h=8,r=4,center=true,$fn=60);
		translate([-190,50,-170])
		cylinder(h=8,r=4,center=true,$fn=60);

		translate([0,-50,-170])
		cube([380,8,8],center=true);
		translate([190,-50,-170])
		cylinder(h=8,r=4,center=true,$fn=60);
		translate([-190,-50,-170])
		cylinder(h=8,r=4,center=true,$fn=60);

		translate([-200,0,-170])
		cube([8,80,8],center=true);
		translate([-200,40,-170])
		cylinder(h=8,r=4,center=true,$fn=60);
		translate([-200,-40,-170])
		cylinder(h=8,r=4,center=true,$fn=60);

		translate([200,0,-170])
		cube([8,80,8],center=true);
		translate([200,40,-170])
		cylinder(h=8,r=4,center=true,$fn=60);
		translate([200,-40,-170])
		cylinder(h=8,r=4,center=true,$fn=60);
		}
	}

module lower_cylinder_block()
	{
	translate([140,0,0])
		{
		difference()
			{
			translate([0,0,-165])
			cube([80,80,15],center=true);

			// hole for cylinder tube
			translate([0,0,-159.5])
			cylinder(h=5,r=25.4,center=true,$fn=90);

			//holes for support bolts
			translate([30,30,-165])
			cylinder(h=20,r=3,center=true,$fn=30);
			translate([-30,30,-165])
			cylinder(h=20,r=3,center=true,$fn=30);	
			translate([30,-30,-165])
			cylinder(h=20,r=3,center=true,$fn=30);
			translate([-30,-30,-165])
			cylinder(h=20,r=3,center=true,$fn=30);	

			//mill fancy edges
			translate([0,40,-160])
			cube([40,8,28],center=true);
			translate([20,40,-160])
			cylinder(h=28,r=4,center=true,$fn=60);
			translate([-20,40,-160])
			cylinder(h=28,r=4,center=true,$fn=60);

			translate([0,-40,-160])
			cube([40,8,28],center=true);
			translate([20,-40,-160])
			cylinder(h=28,r=4,center=true,$fn=60);
			translate([-20,-40,-160])
			cylinder(h=28,r=4,center=true,$fn=60);

			translate([-40,0,-160])
			cube([8,40,28],center=true);
			translate([-40,20,-160])
			cylinder(h=28,r=4,center=true,$fn=60);
			translate([-40,-20,-160])
			cylinder(h=28,r=4,center=true,$fn=60);

			translate([40,0,-160])
			cube([8,40,28],center=true);
			translate([40,20,-160])
			cylinder(h=28,r=4,center=true,$fn=60);
			translate([40,-20,-160])
			cylinder(h=28,r=4,center=true,$fn=60);

			//holes for ports
			translate([0,35,-165])
			rotate([90,0,0])
			cylinder(h=10,r=4,center=true,$fn=100);
			translate([0,30,-165])
			rotate([90,0,0])
			cylinder(h=30,r=2,center=true,$fn=100);
			translate([0,20,-165])
			cylinder(h=10,r=4,center=true,$fn=100);

			translate([0,-35,-165])
			rotate([90,0,0])
			cylinder(h=10,r=4,center=true,$fn=100);
			translate([0,-30,-165])
			rotate([90,0,0])
			cylinder(h=30,r=2,center=true,$fn=100);
			translate([0,-20,-165])
			cylinder(h=10,r=4,center=true,$fn=100);
			}
		}
	}

module piston_conrod()
	{
	translate([140,0,-90])
	cylinder(h=90,r=4,center=true,$fn=60);
	}

module conrod_end()
	{
	translate([0,0,-15])
		{
		difference()
			{
			translate([140,0,-20])
			cube([20,12,30],center=true);

			//side mills
			translate([140,-4.5,-15])
			cube([21,5,21],center=true);
			translate([140,4.5,-15])
			cube([21,5,21],center=true);
		
			//bearing hole 
			translate([140,0,-13])
			rotate([90,90,0])
			cylinder(h=6,r=6,center=true,$fn=90);

			//end fancy mill
			translate([130,0,-5])
			rotate([90,90,0])
			cylinder(h=6,r=4,center=true,$fn=90);
			translate([150,0,-5])
			rotate([90,90,0])
			cylinder(h=6,r=4,center=true,$fn=90);
	
			//side fancy mill
			translate([130,6,-15])
			cylinder(h=60,r=4,center=true,$fn=90);
			translate([130,-6,-15])
			cylinder(h=60,r=4,center=true,$fn=90);
			translate([150,6,-15])
			cylinder(h=60,r=4,center=true,$fn=90);
			translate([150,-6,-15])
			cylinder(h=60,r=4,center=true,$fn=90);
			}
		}
	}

module upper_cylinder_block()
	{
	translate([140,0,-120])
	mirror([0,0,1])
	translate([0,0,140])
		{
		difference()
			{
			translate([0,0,-165])
			cube([80,80,15],center=true);

			// hole for piston conrod
			translate([0,0,-165])
			cylinder(h=61,r=4.1,center=true,$fn=200);
			// hole for cylinder tube
			translate([0,0,-159.5])
			cylinder(h=5,r=25.4,center=true,$fn=90);

			//holes for support bolts
			translate([30,30,-165])
			cylinder(h=20,r=3,center=true,$fn=30);
			translate([-30,30,-165])
			cylinder(h=20,r=3,center=true,$fn=30);
			translate([30,-30,-165])
			cylinder(h=20,r=3,center=true,$fn=30);
			translate([-30,-30,-165])
			cylinder(h=20,r=3,center=true,$fn=30);	
	
			//mill fancy edges
			translate([0,40,-160])
			cube([40,8,28],center=true);
			translate([20,40,-160])
			cylinder(h=28,r=4,center=true,$fn=60);
			translate([-20,40,-160])
			cylinder(h=28,r=4,center=true,$fn=60);
	
			translate([0,-40,-160])
			cube([40,8,28],center=true);
			translate([20,-40,-160])
			cylinder(h=28,r=4,center=true,$fn=60);
			translate([-20,-40,-160])
			cylinder(h=28,r=4,center=true,$fn=60);
	
			translate([-40,0,-160])
			cube([8,40,28],center=true);
			translate([-40,20,-160])
			cylinder(h=28,r=4,center=true,$fn=60);
			translate([-40,-20,-160])
			cylinder(h=28,r=4,center=true,$fn=60);
	
			translate([40,0,-160])
			cube([8,40,28],center=true);
			translate([40,20,-160])
			cylinder(h=28,r=4,center=true,$fn=60);
			translate([40,-20,-160])
			cylinder(h=28,r=4,center=true,$fn=60);

			//holes for ports
			translate([0,35,-165])
			rotate([90,0,0])
			cylinder(h=10,r=4,center=true,$fn=100);
			translate([0,30,-165])
			rotate([90,0,0])
			cylinder(h=30,r=2,center=true,$fn=100);
			translate([0,20,-165])
			cylinder(h=10,r=4,center=true,$fn=100);

			translate([0,-35,-165])
			rotate([90,0,0])
			cylinder(h=10,r=4,center=true,$fn=100);
			translate([0,-30,-165])
			rotate([90,0,0])
			cylinder(h=30,r=2,center=true,$fn=100);
			translate([0,-20,-165])
			cylinder(h=10,r=4,center=true,$fn=100);
			}
		}
	}

module cylinder_tube()
	{
	translate([140,0,-130])
		{
		difference()
			{
			cylinder(h=60,r=25.4,center=true,$fn=200);
			cylinder(h=61,r=23,center=true,$fn=200);
			}
		}
	}

module cylinder_mounting_hw()
	{
	translate([140,0,-62])union()
		{
		translate([30,30,-100.5])
		cylinder_single_bolt_hw();
		translate([-30,30,-100.5])
		cylinder_single_bolt_hw();
		translate([30,-30,-100.5])
		cylinder_single_bolt_hw();
		translate([-30,-30,-100.5])
		cylinder_single_bolt_hw();
		}
	}

module cylinder_single_bolt_hw()
	{
	//threaded brass bar
	translate([0,0,33])
	color(METAL_Brass)
	cylinder(h=100,r=3,center=true,$fn=100);
	//hardware from top down
	translate([0,0,80.5])
	mirror([0,0,1])
	color(METAL_Brass)
	flat_nut(6);//brass

	translate([0,0,75])
	color(METAL_Copper)
	washer(6);//copper

	translate([0,0,59.])
	color(METAL_Copper)
	washer(6);//copper

	translate([0,0,54])
	color(METAL_Copper)
	flat_nut(6);//brass

	translate([0,0,10.5])
	mirror([0,0,1])
	color(METAL_Brass)
	flat_nut(6);//brass
	translate([0,0,5])
	color(METAL_Copper)
	washer(6);//copper
	}

module piston()
	{
	difference()
		{
		translate([140,0,-130])
		cylinder(h=10,r=23,center=true,$fn=200);
		translate([140,0,-130])
		cylinder(h=40,r=3.5,center=true,$fn=200);
		}
	}

module crank_mounting_hw()
	{
	translate([-120,20,-150])
	crank_single_bolt_hw();
	translate([-160,20,-150])
	crank_single_bolt_hw();
	translate([-120,-20,-150])
	crank_single_bolt_hw();
	translate([-160,-20,-150])
	crank_single_bolt_hw();
	}

module crank_single_bolt_hw()
	{
	//threaded brass bar
	translate([0,0,25])
	color(METAL_Brass)
	cylinder(h=110,r=3,center=true,$fn=100);
	//hardware from top down
	translate([0,0,80.5])
	mirror([0,0,1])
	color(METAL_Brass)
	flat_nut(6);//brass

	translate([0,0,75])
	color(METAL_Copper)
	washer(6);//copper

	translate([0,0,44.5])
	color(METAL_Copper)
	washer(6);//copper

	translate([0,0,40])
	color(METAL_Brass)
	flat_nut(6);//brass

	translate([0,0,-14.5])
	mirror([0,0,1])
	color(METAL_Brass)
	flat_nut(6);//brass
	translate([0,0,-20])
	color(METAL_Copper)
	washer(6);//copper
	}

module flywheel()
	{
	translate([-140,38,-90])
	rotate([90,90,0])
		{
		difference()
			{
			union()
				{	
				difference()
					{
					translate([0,0,0])
					cylinder(h=10,r=75,center=true,$fn=300);	
					translate([0,0,5])
					cylinder(h=7,r=65,center=true,$fn=300);
					translate([0,0,-5])
					cylinder(h=7,r=65,center=true,$fn=300);
					for(k=[1:3])
						{
						rotate([0,0,120*k])
						translate([0,37,0])
						cylinder(h=20,r=24,center=true,$fn=200);
						}
					}
				cylinder(h=10,r=12,center=true,$fn=90);
				}
				cylinder(h=30,r=4,center=true,$fn=90);
			}
		}
	}
module valve_rods()
	{
	translate([65,10,-100])
		{
		difference()
			{
			cylinder(h=100,r=6,center=true,$fn=100);

			translate([0,0,-22])
			cube([4,16,15],center=true);
			translate([0,0,-15])
			rotate([90,90,0])
			cylinder(h=16,r=2,center=true,$fn=60);
			translate([0,0,-30])
			rotate([90,90,0])		
			cylinder(h=16,r=2,center=true,$fn=60);

			translate([0,0,40])
			valve_top_cut();
			}
		}
	translate([65,-10,-100])
		{
		difference()
			{
			cylinder(h=100,r=6,center=true,$fn=100);

			translate([0,0,-34])
			cube([4,16,15],center=true);
			translate([0,0,-26])
			rotate([90,90,0])
			cylinder(h=16,r=2,center=true,$fn=60);
			translate([0,0,-41.5])
			rotate([90,90,0])		
			cylinder(h=16,r=2,center=true,$fn=60);

			translate([0,0,-10])
			cube([4,16,15],center=true);
			translate([0,0,-17.5])
			rotate([90,90,0])
			cylinder(h=16,r=2,center=true,$fn=60);
			translate([0,0,-2])
			rotate([90,90,0])		
			cylinder(h=16,r=2,center=true,$fn=60);

			translate([0,0,40])
			valve_top_cut();

			}
		}
	}
module valve_top_cut()
	{
	difference()
		{
		cylinder(h=22,r=10,center=true,$fn=90);
		cylinder(h=23,r=3,center=true,$fn=90);
		}
	}

module valve_top_hw()
	{
	translate([65,0,-67])
	flat_nut(6);
	translate([65,0,-52])
	mirror([0,0,1])
	flat_nut(6);	

	}

module valve_top_block()
	{
	difference()
		{
		translate([65,0,-60])
		cube([15,40,5],center=true);
		
		translate([65,-10,-60])
		cylinder(h=10,r=3,center=true,$fn=60);
		translate([65,0,-60])
		cylinder(h=10,r=3,center=true,$fn=60);
		translate([65,10,-60])
		cylinder(h=10,r=2.5,center=true,$fn=60);
		}
	}


module valve_block()
	{
	translate([65,0,-120])
	difference()
		{
		translate([0,0,0])
		cube([40,60,60],center=true);
		
		// valve shaft holes 
		translate([0,10,0])
		cylinder(h=61,r=6.1,center=true,$fn=90);
		translate([0,-10,0])
		cylinder(h=61,r=6.1,center=true,$fn=90);

		//mounting holes
		translate([12.5,22.5,0])
		cylinder(h=61,r=3,center=true,$fn=60);
		translate([-12.5,22.5,0])
		cylinder(h=61,r=3,center=true,$fn=60);	
		translate([12.5,-22.5,0])
		cylinder(h=61,r=3,center=true,$fn=60);
		translate([-12.5,-22.5,0])
		cylinder(h=61,r=3,center=true,$fn=60);	

		// side mills
		translate([25,0,0])
		cube([20,30,70],center=true);
		translate([-25,0,0])
		cube([20,30,70],center=true);

		//manifold holes
		translate([0,28,0])
		rotate([90,0,0])
		cylinder(h=10,r=4,center=true,$fn=100);
		translate([0,22,0])
		rotate([90,0,0])
		cylinder(h=20,r=2,center=true,$fn=100);

		translate([0,28,12])
		rotate([90,0,0])
		cylinder(h=10,r=4,center=true,$fn=100);
		translate([0,22,12])
		rotate([90,0,0])
		cylinder(h=20,r=2,center=true,$fn=100);

		translate([0,28,-12])
		rotate([90,0,0])
		cylinder(h=10,r=4,center=true,$fn=100);
		translate([0,22,-12])
		rotate([90,0,0])
		cylinder(h=20,r=2,center=true,$fn=100);


		translate([0,-28,0])
		rotate([90,0,0])
		cylinder(h=10,r=4,center=true,$fn=100);
		translate([0,-22,0])
		rotate([90,0,0])
		cylinder(h=20,r=2,center=true,$fn=100);

		translate([0,-28,12])
		rotate([90,0,0])
		cylinder(h=10,r=4,center=true,$fn=100);
		translate([0,-22,12])
		rotate([90,0,0])
		cylinder(h=20,r=2,center=true,$fn=100);

		translate([0,-28,-12])
		rotate([90,0,0])
		cylinder(h=10,r=4,center=true,$fn=100);
		translate([0,-22,-12])
		rotate([90,0,0])
		cylinder(h=20,r=2,center=true,$fn=100);

		}
	}
module valve_conrod_end()
	{
	translate([65,0,10])
		{
		difference()
			{
			translate([0,0,-20])
			cube([12,12,30],center=true);

			// slot mill
			translate([0,-5,-15])
			cube([21,15,21],center=true);

			translate([0,-6,-10])
			rotate([90,90,0])
			cylinder(h=10,r=2,center=true,$fn=60);
			translate([0,6,-10])
			rotate([90,90,0])
			cylinder(h=10,r=1.5,center=true,$fn=60);
			}
		}
	}

module valve_mounting_hw()
	{
	translate([65,-5,0])
	rotate([-90,90,0])
	color(METAL_Brass)
	bolt(4,10);
	translate([65,2,0])
	rotate([-90,90,0])
	color(METAL_Copper)
	washer(4,10);

	translate([65,0,-130])
		{
		//mounting threaded bar
		translate([12.5,22.5,0])
		color(METAL_Brass)
		cylinder(h=100,r=3,center=true,$fn=60);
		translate([-12.5,22.5,0])
		color(METAL_Brass)
		cylinder(h=100,r=3,center=true,$fn=60);	
		translate([12.5,-22.5,0])
		color(METAL_Brass)
		cylinder(h=100,r=3,center=true,$fn=60);
		translate([-12.5,-22.5,0])
		color(METAL_Brass)
		cylinder(h=100,r=3,center=true,$fn=60);	
		
		translate([12.5,22.5,45.5])
		mirror([0,0,1])
		color(METAL_Brass)
		flat_nut(6);
		translate([-12.5,22.5,45.5])
		mirror([0,0,1])
		color(METAL_Brass)
		flat_nut(6);
		translate([12.5,-22.5,45.5])
		mirror([0,0,1])
		color(METAL_Brass)
		flat_nut(6);
		translate([-12.5,-22.5,45.5])
		mirror([0,0,1])
		color(METAL_Brass)
		flat_nut(6);

		translate([12.5,22.5,40])
		color(METAL_Copper)
		washer(6);
		translate([-12.5,22.5,40])
		color(METAL_Copper)
		washer(6);
		translate([12.5,-22.5,40])
		color(METAL_Copper)
		washer(6);
		translate([-12.5,-22.5,40])
		color(METAL_Copper)
		washer(6);

		translate([12.5,22.5,-20.5])
		color(METAL_Copper)
		washer(6);
		translate([-12.5,22.5,-20.5])
		color(METAL_Copper)
		washer(6);
		translate([12.5,-22.5,-20.5])
		color(METAL_Copper)
		washer(6);
		translate([-12.5,-22.5,-20.5])
		color(METAL_Copper)
		washer(6);

		translate([12.5,22.5,-25.5])
		color(METAL_Brass)
		flat_nut(6);
		translate([-12.5,22.5,-25.5])
		color(METAL_Brass)
		flat_nut(6);
		translate([12.5,-22.5,-25.5])
		color(METAL_Brass)
		flat_nut(6);
		translate([-12.5,-22.5,-25.5])
		color(METAL_Brass)
		flat_nut(6);

		translate([12.5,22.5,-40])
		color(METAL_Copper)
		washer(6);
		translate([-12.5,22.5,-40])
		color(METAL_Copper)
		washer(6);
		translate([12.5,-22.5,-40])
		color(METAL_Copper)
		washer(6);
		translate([-12.5,-22.5,-40])
		color(METAL_Copper)
		washer(6);

		translate([12.5,22.5,-35])
		mirror([0,0,1])
		color(METAL_Brass)
		flat_nut(6);
		translate([-12.5,22.5,-35])
		mirror([0,0,1])
		color(METAL_Brass)
		flat_nut(6);
		translate([12.5,-22.5,-35])
		mirror([0,0,1])
		color(METAL_Brass)
		flat_nut(6);
		translate([-12.5,-22.5,-35])
		mirror([0,0,1])
		color(METAL_Brass)
		flat_nut(6);
		
		translate([0,30,10])
		rotate([90,90,0])
		mirror([0,0,1])
		color(METAL_Brass)
		pipe_fitting();	
		translate([0,30,22])
		rotate([90,90,0])
		mirror([0,0,1])
		color(METAL_Brass)
		pipe_fitting();
		translate([0,30,-2])
		rotate([90,90,0])
		mirror([0,0,1])
		color(METAL_Brass)
		pipe_fitting();

		translate([0,-30,10])
		rotate([90,90,0])
		color(METAL_Brass)
		pipe_fitting();	
		translate([0,-30,22])
		rotate([90,90,0])
		color(METAL_Brass)
		pipe_fitting();
		translate([0,-30,-2])
		rotate([90,90,0])
		color(METAL_Brass)
		pipe_fitting();
		}
	}

module pipes()
	{
	translate([0,0,0])
	pipe_side();

	translate([0,0,0])
	mirror([0,1,0])
	pipe_side();
	}

module pipe_side()
	{
	translate([65,0,-130])
		{
		translate([0,35,10])
		pipe_a();	
		translate([0,65,10])
		pipe_a();
		translate([0,35,22])
		pipe_a();
		translate([0,35,-2])
		pipe_a();
		}
	translate([140,40,-165])
	pipe_b();
	translate([140,40,-95])
	pipe_b();
	
	translate([140,40,-165])
	pipe_c(bend_r=10);
	translate([140,40,-95])
	pipe_c(bend_r=10);
		
	translate([65,40,-108])	
	pipe_d(bend_r=10);
	translate([65,40,-132])	
	pipe_d(bend_r=10);

	translate([75,60,-140.25])
	pipe_e();

	translate([123,60,-165])
	rotate([0,0,90])
	pipe_f();

	translate([79,60,-132])
	rotate([0,0,90])
	pipe_g();
	
	translate([85,60,-101.5])
	pipe_h();

	translate([90,60,-101.5])
	pipe_i();

	translate([94,60,-101])
	rotate([0,45,0])
	cylinder(h=9.1,r=2.5,center=true,$fn=90);

	translate([118,60,-95])
	rotate([0,0,90])
	pipe_j();

	translate([79,60,-108])
	rotate([0,0,90])
	pipe_g();
	}


module pipe_g()
	{
	difference()
		{
		rotate([90,90,0])
		cylinder(h=10,r=2.5,center=true,$fn=60);
		rotate([90,90,0])
		cylinder(h=11,r=1.5,center=true,$fn=60);
		}
	}
module pipe_j()
	{
	difference()
		{
		rotate([90,90,0])
		cylinder(h=28,r=2.5,center=true,$fn=60);
		rotate([90,90,0])
		cylinder(h=29,r=1.5,center=true,$fn=60);
		}
	}
module pipe_f()
	{
	difference()
		{
		rotate([90,90,0])
		cylinder(h=14,r=2.5,center=true,$fn=60);
		rotate([90,90,0])
		cylinder(h=11,r=1.5,center=true,$fn=60);
		}
	}
module pipe_a()
	{
	difference()
		{
		rotate([90,90,0])
		cylinder(h=30,r=2.5,center=true,$fn=60);
		rotate([90,90,0])
		cylinder(h=31,r=1.5,center=true,$fn=60);
		}
	}

module pipe_b()
	{
	difference()
		{
		rotate([90,90,0])
		cylinder(h=20,r=2.5,center=true,$fn=60);
		rotate([90,90,0])
		cylinder(h=21,r=1.5,center=true,$fn=60);
		}
	}

module pipe_c(bend_r) 
	{
	translate([-bend_r,bend_r,0])
		{
		difference()
			{
			translate([0,0,0])
			rotate_extrude($fn=90,center=true)
				{
				translate([bend_r,0,0])circle(2.5);
				}
			translate([-20,-20,0])
			cube([80,40,20],center=true);
			translate([-20,20,0])
			cube([40,41,20],center=true);	
			}
		}
	}

module pipe_d(bend_r) 
	{
	translate([bend_r,bend_r,0])
		{
		difference()
			{
			translate([0,0,0])
			rotate_extrude($fn=90,center=true)
				{
				translate([bend_r,0,0])circle(2.5);
				}
			translate([-20,-20,0])
			cube([80,40,20],center=true);
			translate([20,20,0])
			cube([40,41,20],center=true);	
			}
		}
	}
module pipe_e() 
	{
	translate([8.25,0,-8.25])
		{
		difference()
			{
			translate([0,0,0])rotate([90,0,0])
			rotate_extrude($fn=90,center=true)
				{
				translate([16.5,0,0])circle(2.5);
				}
			translate([10,0,-10])
			cube([21,20,20],center=true);
			translate([-10,0,0])
			cube([20,20,40],center=true);	
			}
		}
	translate([8.25+(16.5*2),0,-8.25])
		{
		difference()
			{
			translate([0,0,0])rotate([90,0,0])
			rotate_extrude($fn=90,center=true)
				{
				translate([16.5,0,0])circle(2.5);
				}
			translate([-10,0,10])
			cube([21,20,20],center=true);
			translate([10,0,0])
			cube([20,20,40],center=true);	
			}
		}
	}
module pipe_h() 
	{
	translate([-3.25,0,6.5])
		{
		difference()
			{
			translate([0,0,0])rotate([90,0,0])
			rotate_extrude($fn=90,center=true)
				{
				translate([13,0,0])circle(2.5);
				}
			translate([10,0,10])
			cube([21,20,20],center=true);
			rotate([0,45,0])translate([10,0,10])
			cube([21,20,20],center=true);
			translate([-10,0,0])
			cube([20,20,40],center=true);	
			}
		}
	}


module pipe_i()
	{
	translate([15.5,0,-6.5])
		{
		difference()
			{
			translate([0,0,0])rotate([90,0,0])
			rotate_extrude($fn=90,center=true)
				{
				translate([13,0,0])circle(2.5);
				}
			translate([-10,0,-10])
			cube([21,20,20],center=true);
			rotate([0,45,0])translate([-10,0,-10])
			cube([21,20,20],center=true);
			translate([10,0,0])
			cube([20,20,40],center=true);	
			}
		}
	}
//end
