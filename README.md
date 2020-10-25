This repository documents upgrades to a
[Makergear M2 printer](http://makergear.wikidot.com/m2). The printer
was one of the original M2 printer models - purchased in 2012 as a
kit, it came with a V3A extruder, two separate "power bricks" (one
19V, one 12V), RAMBo v1.0d electronics with 1/8th microstepping A4984
drivers, and a Z axis stepper with 30 Ohm coils.

# Upgrades

## Firmware

I use the [Klipper firmware](https://www.klipper3d.org/).

## Spool holder

I removed all the spool holder hardware from the M2 and use a separate
[spool holder in a ziplock bag](https://github.com/KevinOConnor/zipspool).

## Upgrade to 24V

There are four important steps to upgrade the printer to 24V:
* [Hotend and extruder upgrade](power_24v/extruder.md)
* [Power supply upgrade](power_24v/psu.md)
* [Heated bed upgrade](power_24v/bed.md)
* [Electronics upgrade](power_24v/maestro.md)

## Z Max endstop

Homing away from the bed is an important upgrade for the M2. The newer
[M2 endstop bracket](https://github.com/MakerGear/M2/blob/master/Printed%20Parts/STL/Hardware%20Revision%20E/Z%20Max%20Endstop%20Bracket.STL)
works well.

## Bed glass spacers

I use ["spacers"](bed_spacer/bed_spacer.md) to improve the rubber
contact of the glass bed.

## Tool holder

I use this [tool holder](https://www.thingiverse.com/thing:132171).

## Raspberry Pi holder

I [mount a Raspberry Pi and Raspberry Pi camera](rpi/rpi.md) to the M2
frame.

## LED case light

I added [LED lights](case_light/case_light.md) to the top of the M2
frame.

## Z Stepper

The printer came with a Z stepper that has 30 Ohm coils.  This high
resistance places a limit on the amount of current that can pass
through the stepper.  In order to compensate for this, I set the
tmc2208 `run_current=0.566` (RMS) and use a `hold_current=0.300`.
(Using a higher current setting would result in poor micro-stepping
precision.)
