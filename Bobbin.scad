// All dimensions in mm
$fn = 64;
OuterDia = 55;
InnerDia = 6;
Height = 10;
SpindleLength = Height * 2;
Plate = 3.0;
StudHeight = 10;
WireDia = 3.0;

// Built in two parts -- Chuck Body and Cap
// Cap has the spindle on it.  Chuck Body has a hole.

module BobbinCap()
{
  difference() {
    union() {
      cylinder(d = OuterDia, h = 0.25 * Plate);
      translate([0, 0, Plate - 0.01]) cylinder(d = InnerDia, h = SpindleLength);
      cylinder(d1 = InnerDia * 2, d2 = InnerDia * 0.95, h = InnerDia * 0.6);
    }
    translate([OuterDia * 0.5 - WireDia, 0, 0]) cylinder(d = WireDia, h = 100, center = true);
  }
}

module ChuckBody()
{
  difference() {
    union() {	
      cylinder(d = OuterDia, h = Plate);
      translate([0,0,Plate - 0.001]) cylinder(d = OuterDia * 0.8, h = StudHeight);
    }
    union() {
      cylinder(d = InnerDia + 0.45, h = SpindleLength * 10, center = true);
      for(ang = [0, 30, 90, 120]) {
        rotate([0, 0, ang]) translate([OuterDia * 0.5 - WireDia, 0, 0]) cylinder(d = WireDia, h = 100, center = true);
      }
    }
  }
}

module BobbinBody()
{
  difference() {
    cylinder(d = OuterDia, h = Height, center = true);
    difference() {
     cylinder(d = OuterDia * 1.1, h = Height - 2 * Plate, center = true);
     cylinder(d = InnerDia, h = Height - 2 * Plate, center = true);
   }
 }
}

CenterDia = 4.5;
module Dimple() {
      translate([0,0,0.455*Height]) cylinder(d2 =  CenterDia, d1 = 0.1 * CenterDia, h = 2.5, center = true);
}

module ChuckStud() {
 // This is to provide something for the chuck to hold
 // while we're winding the coil
 translate([0, 0, -(StudHeight + 0.5 * Height)]) cylinder(d = OuterDia * 0.8, h = StudHeight, center = false);
}

module Bobbin() {
  difference() {
    union() {
      BobbinBody();
      ChuckStud();
    }
    union() {
//      cylinder(d = WireDia, h = Height * 10, center = true);
      Dimple();
      translate([OuterDia * 0.4, 0, 0]) cylinder(d = WireDia, h = Height * 10, center = true);
    }
  }
}

// Bobbin();
BobbinCap();

translate([OuterDia * 1.1, 0, 0]) ChuckBody();

