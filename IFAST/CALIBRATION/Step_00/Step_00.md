**Step 00 — Dual nozzle alignment / XY calibration**

## Context

This step is documented by QIDI (in various booklets and languages), however it has gaps. When you acquire a QIDI IFAST with a dual extruder, it is generally for technical printing purposes. In my case, among other things, I want to print prototype part bodies in PETG with supports in a different material (PLA) to make them easier to remove in hard-to-reach areas, and also to provide physical support for certain overhangs, bridges, etc. If you use the same material for both the body and the supports without a separation layer, they fuse together and the supports cannot be removed. Additionally, when printing PETG you cannot run part cooling because PETG cools quickly and warps, making vertical bridges impossible — a lot more supports are therefore required.

## Calibrating the Z2/Z1 nozzle offset on the XY axes

P1) Both nozzles must extrude the same material — PLA! You cannot mix spools, for example putting a PETG spool on Z2 and a PLA spool on Z1 or vice versa.
Note: The G-code built into the printer interface will automatically set the bed and nozzle temperatures to 198°C for PLA, which is far below the requirements of a material like PETG (235°C). Extruding at a temperature far too low for your filament's melting point can damage the print head.

P2) Load two well-dried and dehydrated spools (PLA absorbs moisture) — allow 24 hours of drying time.

P3) The spool colors must contrast strongly — for example one red and one white. Do not use black or dark colors as they will have no contrast against the bed and the result will be difficult to read → use only bright colors.

P4) Clean the bed thoroughly with a microfibre cloth and a neutral soap / budget shampoo.

P5) Degrease the bed with isopropyl alcohol and a microfibre cloth.

P7) Preheat by manually setting the bed to 60°C.

P8) Preheat by manually setting the nozzles to 200°C.

P9) Manually extrude approximately 100mm of filament from both Z1 and Z2 heads to verify consistent extrusion and the absence of bubbles caused by inadequately dehydrated filament.

P10) Run a "standard bed leveling"* and use an A4 sheet of paper to adjust the bed-to-nozzle distance via the 3 knobs at 120° under the bed. Never use the 0.20mm plastic card when hot — it is made of plastic and will melt on contact with the hot nozzles. It is also technically impractical as it is not long enough.

P11) Still at working temperature (nozzles >200°C / bed 60°C), run 3 successive fast levelings with the A4 sheet. From experience I recommend waiting at least 5 minutes between each fast bed leveling to allow the mechanics to thermally expand and settle.

*Note: This step is critical. Leveling must always be done hot, under operating conditions, and never cold — due to thermal expansion. The sheet should be able to move but you should feel slight resistance when pushing and pulling the A4 sheet. If the A4 sheet buckles and does not move when pushed, you need to lower the bed to release the pressure the nozzle is exerting on the sheet. (I will make an explanatory video as this is not trivial for beginners.)

P10) Apply a thin layer of budget UHU glue stick to the center of the bed over a 150mm square area without creating any uneven buildup. I use a budget noname glue stick (from Action, Lidl, etc.) diluted in water, applied with a silicone brush and smoothed with a small paint roller to create a uniform layer.
[Technique for applying water-soluble glue stick with a roller](https://youtu.be/7C0QPmg6328?si=Unesij_6ZGf4jkct)

P11) Remove the transparent top cover during PLA printing.
_Note: This is recommended by QIDI for PLA, however in practice I prefer to keep my enclosure at a constant temperature — but this is not a critical point for step 00._

P12) QIDI has integrated an XY calibration menu accessible from the interface, but to use it you must use the USB stick* supplied with the printer, connect it to the printer, and run the G-code file [PLA_E_CALIBRATION.gcode](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2000/3.Test%20file/PLA_E_Calibration.gcode)...
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2000/IMG_20240718_164933.jpg)

_*Not particularly practical — poorly thought through, to say the least. Why not integrate everything directly into the QIDI menu?_

The printer will then print an XY calibration template:
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2000/1721313001933.jpg)

Each interval on X or Y equals 0.05mm.

P13) Remove the plate and use a magnifying glass to examine the print (yes, it really is necessary).

Count along the X axis the number of teeth separating you from the center to reach the two best-aligned teeth — unless you are lucky and everything is already aligned, in which case the value is 0.0. In my example the aligned teeth are to the right of X, which is positive: +4 × 0.05mm = +0.20mm — we must set a compensation of +0.20mm. If the aligned teeth had been to the left of X, the number would be negative, e.g. -0.20mm. The same principle applies to the Y axis, but top is positive and bottom is negative (in a standard coordinate system).

Set the X and Y values and reprint [E_calibration.gcode](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2000/3.Test%20file/E_Calibration.gcode) to verify the entered values.

**In theory:** The teeth should be aligned in the X and Y boxes:
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2000/perfect1721314999577.jpg)

**In practice:** In my case this never happens for the X axis. You will need to find the correct value by bisection, bracketing it in ±0.05mm steps through a series of trial-and-error tests. Expect at least 5 attempts to find the right value.

_Note: I have reported this issue to QIDI._

P14) To complete step 00 XY calibration, print the calibration verification file from the USB stick or run the G-code [E_calibration.gcode](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2000/3.Test%20file/E_Calibration.gcode). If you have correctly compensated X and Y, you should obtain a clean two-color print with distinct colors and no color mixing, like this:

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2000/IMG_20240718_191917.jpg)
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2000/IMG_20240718_192141.jpg)

As you can see, the overlapping and side-by-side layering of adjacent walls without color mixing requires compatible materials — which is why you cannot mix, for example, PETG and PLA for this calibration procedure. The PETG nozzle temperature melts the PLA, the two materials do not adhere to each other, part cooling causes the PETG to warp, temperatures that are too low cause it to detach from the bed, the PETG is too cold at extrusion — in short, the PLA/PETG mix does not allow X/Y axis calibration to be validated.

---
*Original author: @sudtek*
