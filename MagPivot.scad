// All dimensions in mm
$fn = 64;
InnerRadius = 23;
OuterRadius = InnerRadius + 18;
Width = 46;
BushingDia = 23;
BushingLift = 2.5; 
BoxThickness = 0.5 * BushingDia + BushingLift;
BushingLength = 35;

SlugLength = 1.8 * (OuterRadius - InnerRadius);
HoleDia = 2;

module PivotBlock()
{
  RadialOffset = 0.5 * BushingDia + BushingLift; 
  difference() {
    cube([BushingLength, 2 * BushingLift + BushingDia, BoxThickness]);
    union() {
      translate([0.1, RadialOffset, RadialOffset])
        rotate([0, 90, 0]) cylinder(d = BushingDia, h = BushingLength * 2, center=true);
      translate([0, BushingDia + BushingLift, -0.005])	 
         cylinder(d = BushingDia, h = BushingDia * 2, center = true);
      translate([BushingLength, BushingDia + BushingLift, -0.005])	 
         cylinder(d = BushingDia, h = BushingDia * 2, center = true);
//      translate([-0.005, RadialOffset, -0.005])	 
         //cube([0.3 * BushingLength, BushingDia, BushingDia * 2]);
//      translate([0.7 * BushingLength + 0.005, RadialOffset, -0.005]) cube([0.3 * BushingLength, BushingDia, BushingDia * 2]);      
    }
  }
}



InnerWidth = 0.6;
InnerThickness = 0.1;
TabLength = 1.0;
DimpleDia = 0.4;
BumpOffset = TabLength - 0.22;

module RoundedDimplePlate() {
  difference() {
    union() {       
      cube([TabLength, InnerWidth, InnerThickness], false);
    }
    union() {
      translate([BumpOffset, InnerWidth * 0.5, 0.6 * DimpleDia]) sphere(d=DimpleDia);
   }
 }
}

BumpDia = 0.2;

module BumpedPlate() {
  union() {       
    cube([TabLength, InnerWidth, InnerThickness], false);
    intersection() {
      translate([BumpOffset, InnerWidth * 0.5, 0.85 * InnerThickness]) sphere(d=BumpDia);
      cube([TabLength, InnerWidth, InnerThickness * 10], false);
    }
  }
}


BallDia = 2.0 * InnerThickness; 
module BumpTab() {
  scale([25.4,25.4,25.4]) BumpedPlate();
}

module PivotBody() {
  union() {
    PivotBlock();
    rotate([0,0,-90]) BumpTab();
    translate([BushingLength - 25.4 * InnerWidth, 0, 0]) rotate([0,0,-90]) BumpTab();    
  }
}



PivotBody();
// translate([BushingLength, 0, BoxThickness * 2]) rotate([0, 180, 0]) PivotBody();
