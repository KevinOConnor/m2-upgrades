This documents an upgrade of the Makergear M2 so that one can mount a
Raspberry Pi and Raspberry Pi camera module to it.

I printed the Raspberry Pi case at:
https://www.thingiverse.com/thing:2342050 along with brackets from:
https://www.thingiverse.com/thing:2342080 .  Printed in PETG
with 0.200mm layer height and 20% infill.  I mounted the case
vertically along the right side of the M2 frame (just under the X
stepper motor).

For the Raspberry Pi camera module, I printed just the camera case and
ball joint from https://www.thingiverse.com/thing:256960 .  I designed
a separate [ball joint holder](m2-rpi-camera.stl).  I printed in PLA.
The holder attaches to the screw holding the M2 X axis carriage stop
(on the upper right part of the M2 frame).

Caveats:

* The camera mount is not very good.  The ball joint can come loose
  causing the camera to point away from the print.  If the X axis
  carriage moves all the way to its maximum position, it can collide
  with the camera.
