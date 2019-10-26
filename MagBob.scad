// All dimensions in mm
$fn = 64;
InnerRadius = 23;
OuterRadius = InnerRadius + 18;
Width = 46;
MagThickness = 2.5;
SlabThickness = 3;
SlugThickness = SlabThickness +  MagThickness;
SlugLength = 1.8 * (OuterRadius - InnerRadius);
SlugWidth = 40;
HoleDia = 2;

module BobSlot()
{
  intersection() {
    translate([-0.5 * Width,0,-1]) cube([Width, 100, 100]);  
    difference() {
      cylinder(r = OuterRadius, h = MagThickness);
      translate([0,0,-1]) cylinder(r = InnerRadius, h = 100);
    }
  }
}


module BobSlug() {
  cube([SlugWidth, SlugLength, SlugThickness]);
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

module BobBody() {
  union() {
    difference() {
      BobSlug();
      translate([0.5 * SlugWidth, -8, SlabThickness + 0.1]) BobSlot();
    }
    rotate([0,0,-90]) BumpTab();
    translate([SlugWidth - 25.4 * InnerWidth, 0, 0]) rotate([0,0,-90]) BumpTab();    
  }
}



BobBody();

