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

plate_height = 3;
plate_offset_x = 1;
plate_offset_y = 11;
plate_width = 100 + 2 * plate_offset_x;
plate_length = 133 + plate_offset_y + 1;
plate_border = 10;
standoff_height = 10;
standoff_top_width = 7.5;
standoff_bot_width = 9;
standoff_screw_dia = 3.5;
standoff_screw_hex = 6.235 + .1;
standoff_screw_positions = [ [4, 4], [4, 119], [96, 119], [96, 4] ];
printer_screw_dia = 4.5;
printer_screw_xoffset = 10 - 11.5;
printer_screw_yoffset = 5;
printer_screw_positions = [ [11.5, 0], [70, 0], [41.5, 135] ];
notch_length = 4;
notch_radius = 2.5;
cover_height = 55;
cover_thick = 2;
cover_extra_width = 15;
slack = 1;
CUT = 0.01;
$fs = .5;

//
// Back Plate
//

module back_plate() {
    // Simple hollow rectangular plate to mount to M2 steel frame
    module plate() {
        difference() {
            cube(size=[plate_width, plate_length, plate_height]);
            translate([plate_border, plate_border, -CUT])
                cube(size=[plate_width - 2*plate_border,
                           plate_length - 2*plate_border, plate_height + 2*CUT]);
        }
    }

    // Notches to hold cover
    module notch() {
        difference() {
            translate([0, 0, plate_height-CUT])
                cube(size=[notch_length + 1, 2*notch_radius,
                           2.5*notch_radius+CUT]);
            translate([-CUT, 0, plate_height + notch_radius])
                rotate([0, 90, 0])
                    cylinder(h=notch_length + 2*CUT, r=notch_radius);
        }
    }

    // Pillars to hold duet2 to plate
    module screw_standoff(pos) {
        translate(pos)
            translate([plate_offset_x, plate_offset_y])
                cylinder(h=standoff_height, d1=standoff_bot_width,
                         d2=standoff_top_width);
    }

    // Cutout space for duet2 screw
    module screwcut_standoff(pos) {
        module hex() {
            d1 = standoff_screw_hex + .2;
            d2 = standoff_screw_hex;
            d3 = 0;
            cylinder(h=standoff_height - 2.5 + CUT, d1=d1, d2=d2, $fn=6);
            translate([0, 0, standoff_height - 2.5])
                cylinder(h=1 + CUT, d1=d2, d2=d3, $fn=6);
        }
        translate(pos)
            translate([plate_offset_x, plate_offset_y, -CUT]) {
                cylinder(h=standoff_height + 2*CUT, d=standoff_screw_dia);
                rotate([0, 0, 90])
                    hex();
            }
    }

    // Cutout space for M2 mounting screw
    module screwcut_printer(pos) {
        translate(pos)
            translate([printer_screw_xoffset, printer_screw_yoffset, -CUT])
                cylinder(h=plate_height + 2*CUT, d=printer_screw_dia);
    }

    module full_plate() {
        plate();
        for (pos=standoff_screw_positions)
            screw_standoff(pos);
        // Cover notches
        notch();
        translate([plate_width, 0, 0])
            mirror([1, 0, 0])
                notch();
        translate([0, plate_length, 0])
            mirror([0, 1, 0])
                notch();
        translate([plate_width, plate_length, 0])
            mirror([0, 1, 0])
                mirror([1, 0, 0])
                    notch();
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
// Cover
//

module cover() {
    cover_width = plate_width + 2*cover_thick + cover_extra_width + slack;
    cover_length = plate_length + 2*cover_thick + slack;
    module box() {
        inner_width = cover_width - 2*cover_thick;
        inner_length = cover_length - 2*cover_thick;
        difference() {
            cube(size=[cover_width, cover_length, cover_height]);
            translate([cover_thick, cover_thick, cover_thick])
                cube(size=[inner_width, inner_length, cover_height]);
        }
    }
    module board_guide(pos) {
        guide_height = plate_height + notch_radius;
        guide_width = notch_radius;
        guide_length = notch_radius;
        translate(pos)
            translate([0, -guide_length, cover_height - guide_height]) {
                cube(size=[guide_width, 2*guide_length, guide_height]);
                translate([0, notch_radius, 0])
                    rotate([0, 90, 0])
                        cylinder(h=guide_length, r=notch_radius);
            }
    }
    module notch(pos) {
        h = cover_height - plate_height - notch_radius;
        translate(pos)
            translate([0, -CUT, h])
                rotate([0, 90, 0])
                    cylinder(h=notch_length + CUT, r=notch_radius);
    }
    module box_with_notches() {
        box();

        board_end_x = plate_width + cover_thick + slack;
        board_end_y = plate_length + cover_thick + slack;
        board_guide([board_end_x, cover_thick, 0]);
        board_guide([board_end_x, board_end_y, 0]);

        notch([cover_thick, cover_thick, 0]);
        notch([board_end_x - notch_length, cover_thick, 0]);
        notch([cover_thick, board_end_y, 0]);
        notch([board_end_x - notch_length, board_end_y, 0]);
    }

    vent_dia = 3;
    vent_offset = 6.5 + cover_thick;
    vent_space = 6;
    module vent_hole(pos1, pos2, rot) {
        hull() {
            translate(pos1)
                rotate(rot)
                    translate([0, 0, -CUT])
                        cylinder(h=cover_thick + 2*CUT, d=vent_dia);
            translate(pos2)
                rotate(rot)
                    translate([0, 0, -CUT])
                        cylinder(h=cover_thick + 2*CUT, d=vent_dia);
        }
    }

    module lid_holes() {
        // Vent holes
        min_x = vent_offset;
        max_x = cover_width - vent_offset;
        min_y = vent_offset;
        max_y = cover_length - vent_offset;
        for (y=[min_y:vent_space:max_y])
            vent_hole([min_x, y], [max_x, y], [0, 0, 0]);
    }
    module top_holes() {
        // Vent holes
        min_z = vent_offset;
        max_z = cover_height - (plate_height + vent_dia/2);
        min_y = vent_offset;
        max_y = cover_length - vent_offset;
        rot = [0, 270, 0];
        for (y=[min_y:vent_space:max_y])
            vent_hole([cover_width, y, min_z], [cover_width, y, max_z], rot);
    }
    module bottom_holes() {
        // Large air hole at bottom of case
        min_y = 15;
        hole_length = cover_length - 2*min_y;
        hole_height = cover_thick + standoff_height + 5;
        translate([-CUT, min_y, cover_height - hole_height])
            cube(size=[cover_thick+2*CUT, hole_length, hole_height+CUT]);
    }
    module front_holes() {
        // USB plug
        usb_center_x = 100 - 47.250 + plate_offset_x + cover_thick;
        usb_plug_width = 15;
        usb_plug_height = 10;
        hole_x = usb_center_x - usb_plug_width/2;
        hole_z = cover_height - standoff_height - usb_plug_height;
        hole_height = cover_height - hole_z;
        translate([hole_x, -CUT, hole_z])
            cube(size=[usb_plug_width, cover_thick + 2*CUT, hole_height + CUT]);
    }
    module back_holes() {
        // Wiring block
        wiring_max_x = 100 - 41.7 + plate_offset_x + cover_thick;
        wiring_min_x = 15;
        hole_y = cover_length - cover_thick;
        hole_width = wiring_max_x - wiring_min_x;
        hole_height = standoff_height + 30;
        translate([wiring_min_x, hole_y - CUT, cover_height-hole_height])
            cube(size=[hole_width, cover_thick + 2*CUT, hole_height + CUT]);
    }

    difference() {
        box_with_notches();

        lid_holes();
        top_holes();
        bottom_holes();
        front_holes();
        back_holes();
    }

    //translate([cover_thick + slack/2, cover_thick + slack/2, 35])
    //    back_plate();
}

//
// Object selection
//

back_plate();
//cover();
