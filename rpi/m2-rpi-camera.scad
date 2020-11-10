// Holder for the rpi camera on the m2.
//
// Copyright (C) 2020  Kevin O'Connor <kevin@koconnor.net>
//
// This file may be distributed under the terms of the GNU GPLv3 license.

// Mounting screw hole is 13mm down from steel frame, 15mm in from front edge.
// Protruding screw is 5mm down from top of frame, 5-10mm in from side.

// dimensions: https://www.raspberrypi.org/documentation/hardware/camera/
// https://www.raspberrypi-spy.co.uk/2013/05/pi-camera-module-mechanical-dimensions/

camera_width = 25;
camera_length = 24;
camera_height = 3;
camera_angle = 22;
camera_lens = 9;
camera_lens_x = 5;
camera_lens_z = 8;
sleeve_thick = 1.5;
printer_screw_dia = 4.5;
printer_hex_dia = 8.4;
slack = 1;
CUT = 0.01;
$fs = .5;

//
// Camera mount
//

module camera_mount() {
    module pcb_cutout() {
        offset = sleeve_thick;
        width = camera_width + 99;
        height = camera_height + slack;
        length = camera_length + slack;
        translate([offset, offset, offset])
            cube(size=[length, height, width]);
    }
    module lens_cutout() {
        lens_x = camera_lens_x + sleeve_thick + slack/2;
        lens_z = camera_lens_z + sleeve_thick + slack/2;
        translate([lens_x, sleeve_height - sleeve_thick - CUT, lens_z])
            cube(size=[camera_lens, sleeve_thick + 2*CUT, 99]);
    }
    module cable_cutout() {
        cable_thick = 1;
        cable_y_offset = 3.5;
        cable_z_offset = sleeve_thick + (camera_width - 16 - slack) / 2;
        translate([-99, cable_y_offset, cable_z_offset])
            cube(size=[sleeve_thick+99+CUT, cable_thick, 99]);
    }
    sleeve_width = camera_width + slack + 2 * sleeve_thick;
    sleeve_length = camera_length + slack + 2 * sleeve_thick;
    sleeve_height = camera_height + slack + 2 * sleeve_thick;
    module camera_holder() {
        cube(size=[sleeve_length, sleeve_height, sleeve_width]);
    }
    base_width = 12;
    base_height = 10;
    screw_holder_width = 14;
    screw_holder_height = 21;
    screw_height = 15;
    screw_depth = 5;
    module frame() {
        cube(size=[base_height, base_width, sleeve_width]);
        cube(size=[screw_holder_height, screw_holder_width, sleeve_width]);
        translate([0, base_width, 0])
            rotate([0, 0, camera_angle])
                translate([0, -sleeve_height, 0])
                    camera_holder();
    }
    module screw() {
        rotate([0, 0, 30]) {
            // Screw shaft
            translate([0, 0, -CUT])
                cylinder(h=screw_holder_width, d=printer_screw_dia);
            // Hex nut
            height1 = screw_holder_width-screw_depth;
            translate([0, 0, screw_depth])
                cylinder(h=height1+CUT, d=printer_hex_dia, $fn=6);
        }
    }

    difference() {
        frame();
        // Remove space for camera board
        translate([0, base_width, 0])
            rotate([0, 0, camera_angle])
                translate([0, -sleeve_height, 0]) {
                    pcb_cutout();
                    lens_cutout();
                    cable_cutout();
                }
        // Remove space for mounting screw
        translate([screw_height, 0, sleeve_width/2])
            rotate([270, 0, 0])
                screw();
    }
}

//
// Object selection
//

camera_mount();
