// Holder for the rpi camera on the m2.
//
// Copyright (C) 2020  Kevin O'Connor <kevin@koconnor.net>
//
// This file may be distributed under the terms of the GNU GPLv3 license.

// 10.37 / 13.07 / 3.33
// bolt is 2.85 dia

// 5mm clearance to rail

// sphere holder is 15 diameter

overlength = 18;
totlength = 50;
sphererad = 7.5;
boltrad = 1.8;

module sphereholder(rad) {
  rotate([0, 90, 0])
    difference() {
      union() {
        difference() {
          cylinder(2*rad+3, rad, rad, center=true);
          cylinder(2*rad-4, rad, rad, center=true);
        }
        translate([0, -rad, (2*rad-4)/2])
          cube([rad, 2*rad, 3.5]);
        translate([0, -rad, -(2*rad+3)/2])
          cube([rad, 2*rad, 3.5]);
        translate([rad, 0, 0])
          cube(size = [2,2*rad,2*rad+3], center = true);
      }
      sphere(rad);
    }
}

union() {
//  translate([overlength, -sphererad, 0])
//    cube(size = [2,13,4]);
  difference() {
    translate([0, -sphererad, 0])
      cube(size = [totlength-23, sphererad*2, 2]);
    translate([overlength-12, -3.5, 1.5])
      cylinder(3, boltrad, boltrad, center=true);
  }
  translate([totlength-16, 0, sphererad+1])
    sphereholder(sphererad);
}
