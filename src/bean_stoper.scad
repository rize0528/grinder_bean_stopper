/*
color("gray")
    linear_extrude(height = 40)
    square([20,20], center=true);
*/
slot_type = "Round"; // or "Square"
diameter = 30;  // value of diameter for rounded slot
bottom_thick = 2.5;
bottom_height = 10;

module createBottom(slot_type, diameter, thick=2, h=20){
    if (slot_type=="Round"){
        linear_extrude(height=h)
        difference(){
          circle(d=diameter, center=true);
          circle(d=diameter-thick*2, center=true);
        }
    }else if(slot_type=="Square"){
        width = diameter * cos(45);
        inner_width = (diameter - thick*2) * cos(45);
        linear_extrude(height=h)
        difference(){
          square([width,width], center=true);
          square([inner_width,inner_width], center=true);
        }
    }
}
//
module createMiddle(body=[40,40], funnel=[30,27]){
    
    h_body = body[0];
    d_body = body[1];
    
    
    #hull(){
        cylinder(h=h_body,d=d_body,center=false);
        
        
        translate([0,0,h_body/2])
        rotate([90,0,0]) 
        linear_extrude(height=30, scale=[0.7,1])
            square(size=[d_body,d_body],center=true);
    }
    
}
//
module createStopPlate(){

    
}

translate([0,0,-bottom_height])
  createBottom(slot_type,diameter, bottom_thick, bottom_height);
createMiddle();
//createStopPlate();
