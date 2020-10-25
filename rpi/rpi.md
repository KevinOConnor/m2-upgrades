This documents an upgrade of the Makergear M2 so that one can mount a
Raspberry Pi and Raspberry Pi camera module to it.

For the Raspberry Pi case, I started with the object at
https://www.thingiverse.com/thing:559858 .  With those object files, I
used an [openscad file](m2-rpi-back.scad) to add screw holes to the
bottom side of the case.  I printed the modified bottom and original
top (in PLA) and then mounted it vertically on the right side of the
M2 frame.

For the Raspberry Pi camera module, I printed just the camera case and
ball joint from https://www.thingiverse.com/thing:256960 .  I designed
a separate [ball joint holder](m2-rpi-camera.stl).  I printed in PLA.
The holder attaches to the screw holding the M2 X axis carriage stop
(on the upper right part of the M2 frame).

Caveats:

* Due to the way the RPi case is mounted vertically, it often doesn't
  sit perfectly vertical.  This also tends to cause the RPi lid to
  come loose.

* The camera mount is not very good.  The ball joint can come loose
  causing the camera to point away from the print.  If the X axis
  carriage moves all the way to its maximum position, it can collide
  with the camera.
