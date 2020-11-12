// Holder for the rpi camera on the m2.
//
// Copyright (C) 2020  Kevin O'Connor <kevin@koconnor.net>
//
// This file may be distributed under the terms of the GNU GPLv3 license.

// Mounting screw hole is 13mm down from steel frame, 15mm in from front edge.
// Protruding screw is 5mm down from top of frame, 5-10mm in from side.

// dimensions: https://www.raspberrypi.org/documentation/hardware/camera/
// https://www.raspberrypi-spy.co.uk/2013/05/pi-camera-module-mechanical-dimensions/

camera_length = 25;
camera_height = 24;
camera_width = 3;
camera_angle = [0, -22, -10];
camera_lens = 9;
camera_lens_z = 5;
camera_lens_length = 8;
arm_height = 10;
arm_width = 5;
arm_length = 50;
screw_y = 15;
screw_z = 17;
screw_holder_height = screw_z + 16;
screw_holder_length = 30;
sleeve_thick = 1.5;
printer_screw_dia = 4.5;
slack = 1;
CUT = 0.01;
$fs = .5;

//
// Camera mount
//

module camera_mount() {
    module pcb_cutout() {
        offset = sleeve_thick;
        width = camera_width + slack;
        length = camera_length + slack;
        height = camera_height + 99;
        translate([offset, offset, offset])
            cube(size=[width, length, height]);
    }
    module lens_cutout() {
        lens_z = camera_lens_z + sleeve_thick + slack/2;
        lens_length = camera_lens_length + sleeve_thick + slack/2;
        translate([-99, lens_length, lens_z])
            cube(size=[sleeve_thick + 99 + CUT, camera_lens, 99]);
    }
    module cable_cutout() {
        cable_thick = 1;
        cable_x_offset = (sleeve_width - cable_thick)/2;
        cable_y_offset = 4.5;
        cable_length = sleeve_length - cable_y_offset + slack;
        translate([cable_x_offset, -99, -99])
            cube(size=[cable_thick, cable_length + 99, 2*99]);
    }
    sleeve_width = camera_width + slack + 2 * sleeve_thick;
    sleeve_length = camera_length + slack + 2 * sleeve_thick;
    sleeve_height = camera_height;
    module camera_holder() {
        cube(size=[sleeve_width, sleeve_length, sleeve_height]);
    }
    base_x_offset = -5;
    base_y_offset = -.5;
    base_width = 15;
    base_length = sleeve_length + 1;
    base_height = 12;
    arm_y = arm_length + sleeve_length;
    module frame() {
        cube(size=[arm_width, screw_holder_length, screw_holder_height]);
        translate([0, -arm_y, 0]) {
            cube(size=[arm_width, arm_y + CUT, arm_height]);
            translate([base_x_offset, base_y_offset, 0])
                cube(size=[base_width, base_length, base_height]);
            rotate(camera_angle)
                translate([0, 0, arm_height])
                    camera_holder();
        }
    }

    difference() {
        frame();

        // Remove space for camera board
        translate([0, -arm_y, 0])
            rotate(camera_angle)
                translate([0, 0, arm_height]) {
                    pcb_cutout();
                    lens_cutout();
                    cable_cutout();
                }

        // Remove space for mounting screw
        translate([0, screw_y, screw_z])
            rotate([0, 90, 0])
                translate([0, 0, -CUT])
                    cylinder(h=arm_width + 2*CUT, d=printer_screw_dia);
    }
}

//
// Object selection
//

camera_mount();
