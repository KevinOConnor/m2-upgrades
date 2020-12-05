This documents an upgrade of the Makergear M2 hotend and extruder.

## Extruder motor

Separate from the 24V upgrade, the extruder motor that came with my
original M2 broke.  It appears that movement of the X carriage
eventually caused one of the internal stepper motor wires to become
loose and short with other wires.

I replaced the stepper motor and gearbox with a "Usongshine Nema 17
with 5.18:1 Planetary Gearbox" ($27 from Amazon).

## Extruder mount

The original plastic part that mounts the extruder motor to the X
carriage was of low quality.  It broke while attempting to adjust the
hotend.  The plastic was very brittle (I could crumble it with my
fingers) and appears to have been printed with ~20% infill.

I printed a new motor mount from:
https://github.com/MakerGear/M2/blob/master/Printed%20Parts/STL/M2%20Extruder%20Motor%20Mount%20r3.STL

I printed it in ABS with 0.200mm layer height and 80% infill.

## Hotend upgrade to 24V

I purchased a 24V E3D v6 hotend ($55 from Printed Solid).  I printed
the "New_E3D_v6_Extruder_2.0_Plain_no_Support.stl" found at
https://www.thingiverse.com/thing:495756/files .  Printed in ABS
with 0.200mm layer height and 80% infill.  I also purchased some 2mm
files ($9 from Amazon) and filed down the filament path.

The E3D fan and heater wires are long enough to reach the M2
electronics, but I preferred having plugs by the hotend.  (In
contrast, the E3D thermistor came with a "microfit connector" that was
already compatible with the M2 wiring.)  For the new fan, I cut the
wires and used a crimping tool to connect a "dupont connector" that
was compatible with the existing wiring.  For the heater, I cut the
E3D heater wires, cut the M2 "microfit connector" from the existing
wires, and then soldered on an XT30 connector ($9 for 10-pairs from
Amazon).  I then used the existing heater wiring.

## Part cooling fan upgrade to 24V

I printed the "E3D_30_mm_Duct.stl" and "E3D_40_mm_Duct.stl" found at
https://www.thingiverse.com/thing:1165614/files .  Printed in ABS
with 0.200mm layer height.  To assemble, I purchased a "40mm WINSINN
24V fan" ($19 for 5-pack from Amazon) along with "1/4 inch x 1/16 inch
magnets" ($7 for 25-pack from Amazon).

The plug on the new fan was not compatible with the existing M2 fan
plug.  I cut the wires and used a crimping tool to connect a "dupont
connector" so that I could use the existing plug and wiring.
