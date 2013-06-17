/* OpenSCAD Proposed Extended Generic Base Library Functions
filename "Generic_lib_Main.scad" version 0.1a

 still work in progress so some functions may not be in there final form,
 compleate ,implimented and/or functional in its current state
 i suggest that this lib is not used other than for testing at the moment  

licencing see openscad/COPYING

discription 
	the lib is split into 4 main sub libs for easy managment 
 
	generic parts/materials h/w
		parts and materials and std size fittings and hardware
		
	extended shapes 
		extended shapes and objects 

	extended functions 
		extended trasformation and other related functions 

	generic global extended constants 
		constants and named varible values 

codeing guide 
when calling a module  the following var naming of the following native types are to be used  where applicable
 [x,y,z] 
 h = height
 r , r1 , r2  = radius
 d = diameter 
 center = true draws part centered on local [xyz]
      false draws part relative to its native refrance [xyz]
      on cylindrical parts this would be central on xy with z at one end  
 outline = true is draw as outline for "cutout" no clearnce!!
      false draws part as rendered

contant naming conventions 
	GROUP_Sub_Type

lib function naming convention to be used is Aaa_Aaa functions are also grouped M_metric_std_objects  I_imperal_std_opjects , C_custom_objects 


notes to remeber for modifying this lib 
remember to keep backwards compatabilaty when changing the Generic lib modules  

also remember the function module is no use without including appropriate documentation so that others may understand how to use it 
this means adding to the associated  lib documentation text file , as well as the quick lib referance text file 
*/

//proposed Default loaded Generic libs 
 
//include<Generic-Parts-Lib.scad>;     //TODO :in progress


//include<Generic-Shapes-Lib.scad>;    //TODO :in progress


//include<Generic-Function-Lib.scad>;  //TODO :in progress


include<Generic-Constants-Lib.scad>;  //v0.01a done
//test file Ggeneric-Constant_Test.scad v0.01a done 
//documentation file  TODO


//end of file
