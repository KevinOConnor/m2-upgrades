// Holder for Duet2 Maestro board on side of M2 printer
//
// Copyright (C) 2020  Kevin O'Connor <kevin@koconnor.net>
//
// This file may be distributed under the terms of the GNU GPLv3 license.

// M2 side screw locations:
//  z=11.5mm: +0mm, +145mm; z=41: +10mm, +67.5mm; z=70mm: +96mm, +145mm
// screw hole is 4.6mm wide; m4 screw is 3.86mm wide; head is 6.96mm dia
// m3 hex nut is 5.4mm across; m3 screw is 2.88mm wide; head is 5.38mm dia

// Duet board is 123x100mm. Screws at:
//  4,4 ; 4,119 ; 96,119 ; 96,4

$fs = .5;
plate_height = 3;
plate_offset_x = 1;
plate_offset_y = 12;
plate_width = 100 + 2 * plate_offset_x;
plate_length = 123 + plate_offset_y + 1;
plate_border = 10;
standoff_height = 10;
standoff_top_width = 7.5;
standoff_bot_width = 9;
standoff_screw_dia = 3.5;
standoff_screw_hex = 6.235 + .1;
standoff_screw_positions = [ [4, 4], [4, 119], [96, 119], [96, 4] ];
printer_screw_dia = 4.5;
printer_screw_positions = [ [13, 5], [13 + 70 - 11.5, 5],
                            [13 + 41 - 11.5, 5 + 145 - 67.5] ];
CUT = 0.01;

//
// Back Plate
//

module back_plate() {
    module plate() {
        difference() {
            cube(size=[plate_width, plate_length, plate_height]);
            translate([plate_border, plate_border, -CUT])
                cube(size=[plate_width - 2*plate_border,
                           plate_length - 2*plate_border, plate_height + 2*CUT]);
        }
    }

    module screw_standoff(pos) {
        translate(pos)
            translate([plate_offset_x, plate_offset_y])
                cylinder(h=standoff_height, d1=standoff_bot_width,
                         d2=standoff_top_width);
    }

    module screwcut_standoff(pos) {
        module hex() {
            rotate([0, 0, 90])
                cylinder(h=standoff_height - 2 + CUT, d1=standoff_screw_hex + 1,
                         d2=standoff_screw_hex, $fn=6);
        }
        translate(pos)
            translate([plate_offset_x, plate_offset_y, -CUT]) {
                cylinder(h=standoff_height + 2*CUT, d=standoff_screw_dia);
                hex();
            }
    }

    module screwcut_printer(pos) {
        translate(pos)
            translate([0, 0, -CUT])
                cylinder(h=plate_height + 2*CUT, d=printer_screw_dia);
    }

    module full_plate() {
        plate();
        for (pos=standoff_screw_positions)
             screw_standoff(pos);
    }

    difference() {
        full_plate();
        for (pos=standoff_screw_positions)
             screwcut_standoff(pos);
        for (pos=printer_screw_positions)
             screwcut_printer(pos);
    }
}

//
// Object selection
//

back_plate();
