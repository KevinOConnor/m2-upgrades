// M2 bed spacers for rubber pads
//
// Copyright (C) 2020  Kevin O'Connor <kevin@koconnor.net>
//
// This file may be distributed under the terms of the GNU GPLv3 license.

// Misc measurements:
//   - Glass plate is 4mm thick.
//   - Aluminum heat spreader is 3mm thick.
//   - Cork board is 2mm thick.
//   - L-shaped rubber is 4mm thick.
//   - Bottom rubber is 3mm thick.

// Spacer external dimensions
bigx=22;
bigy=22;
cutx=14.5;
cuty=14.5;
cornershort=3.5;
height = 5.0;

// Screw location and size
screwx=14.75;
screwy=4.75;
screwr=1.8;

$fs = .5;

module spacer() {
    module lrubber() {
        polygon([[0, cornershort], [cornershort, 0],
                 [bigx-cornershort, 0], [bigx, cornershort],

                 [bigx, bigy-cuty], [bigx-cutx, bigy-cuty], [bigx-cutx, bigy],

                 [cornershort, bigy], [0, bigy-cornershort] ]);
    }

    module lrubberwithholes() {
        difference() {
            lrubber();
            translate([screwx, screwy])
                circle(r=screwr);
            translate([screwy, screwx])
                circle(r=screwr);
        }
    }

    linear_extrude(height = height)
        lrubberwithholes();
}

spacer();
