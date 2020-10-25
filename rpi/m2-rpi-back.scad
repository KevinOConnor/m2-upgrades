// Modified rpi b+ case holder with screw holes for mounting to m2
//
// Copyright (C) 2020  Kevin O'Connor <kevin@koconnor.net>
//
// This file may be distributed under the terms of the GNU GPLv3 license.

// Notes:
// -- distance between screw holes was larger than measured
// -- pads are too small to accomodate washers

// m4 screw is 3.86mm wide
// top is 2mm thick
// case is 60mm x 88.82
// case side is 1.88mm wide
// min distance on m4 screws is 44.5
// screw hole is 4.6mm wide

module screwpad(width, depth, height, screwrad) {
  translate([0, 0, height/2])
    difference() {
      cube(size = [width,depth,height], center = true);
      cylinder(height+2, screwrad, screwrad, center = true);
    }
}

union() {
  rotate([90, 0, 0])
    import("boite_raspberry.stl");
  translate([-34, -35, 0])
    screwpad(10, 10, 2, 2);
  translate([-34, 47-35, 0])
    screwpad(10, 10, 2, 2);
}
