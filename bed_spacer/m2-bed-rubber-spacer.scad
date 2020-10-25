// M2 bed spacers for rubber pads
//
// Copyright (C) 2020  Kevin O'Connor <kevin@koconnor.net>
//
// This file may be distributed under the terms of the GNU GPLv3 license.

// Rubber dimentions
bigx=22;
bigy=22;
cutx=15;
cuty=15;
cornershort=4.2;
height = 3.6;

// Screw location and size
screwx=14.75;
screwy=4.75;
screwr=2.3;

module lrubber() {
polygon( [
  [0, cornershort],
  [cornershort, 0],

  [bigx-cornershort, 0],
  [bigx, cornershort],

  [bigx, bigy-cuty],
  [bigx-cutx, bigy-cuty],
  [bigx-cutx, bigy],

  [cornershort, bigy],
  [0, bigy-cornershort] ]);
}

module lrubberwithholes() {
  difference() {
    lrubber();
    translate([screwx, screwy]) circle(screwr);
    translate([screwy, screwx]) circle(screwr);
  }
}

linear_extrude(height = height) lrubberwithholes();
