// All dimensions in mm
$fn = 64;
W = 15;
L = 25;
T = 4;
module Brace()
{
    cube([W, L, T]);
    rotate([90, 0, 0]) cube([W, L, T]);
    intersection() {
      translate([0, -0.01, 0]) cube([L, L, L]);
      translate([0.5 * (W - T), -0.75 * L, 0]) translate([0, 0, T]) rotate([-45, 0, 0]) cube([T, L, L]);
    }
}




Brace();


