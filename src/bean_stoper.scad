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
module createMiddle(body=[40,40], funnel=[30,27,5], tunnel=25){
    
    h_body = body[0];
    d_body = body[1];
    od_funnel = funnel[0];
    id_funnel = funnel[1];
    dp_funnel = funnel[2];
    
    difference(){
        hull(){
            cylinder(h=h_body,d=d_body,center=false);
            
            translate([0,0,h_body/2])
            rotate([90,0,0]) 
            linear_extrude(height=30, scale=[0.7,1])
                square(size=[d_body,d_body],center=true);
        }
        translate([0,0,h_body])
        difference(){
            cylinder(h=dp_funnel,d=od_funnel,center=true);
            cylinder(h=dp_funnel,d=id_funnel,center=true);
        }

        translate([0,0,h_body])
        rotate([180,0,0])
        linear_extrude(height=h_body, scale=0.6)
        circle(d=tunnel,center=true);

    }
}
//
module createStopPlate(){
    //translate([0,0,10])
    linear_extrude(height=2)
    hull(){
        circle(d=20,center=true);
        translate([0,-20])
        square([20,40],center=true);
    }
}

translate([0,0,-bottom_height])
  createBottom(slot_type,diameter, bottom_thick, bottom_height);
difference(){
    createMiddle(body=[40,40], funnel=[30,27,5], tunnel=25);
    #scale([1.05,1.05,1.05])
    translate([0,0,5])
        createStopPlate();
    #scale([1.1,1.05,1.05])
    translate([0,0,30])
        createStopPlate();
}

