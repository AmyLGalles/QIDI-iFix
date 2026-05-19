**Step 01: Calibrating the two extruder motors Z1 and Z2**

Prerequisite before continuing: You must have completed [Step 00 — Dual nozzle alignment / XY calibration](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2000/Etape_00.md)

### Overview

This step involves verifying whether the QIDI I-Fast extruders consume the precise filament length specified by the G-code, typically 100mm. This check requires at minimum a caliper or a precision metal ruler.

If, after running the G-code, each of your extruders consumes exactly 100mm of filament, you are lucky and have nothing to calibrate. You can move on to the next step: [Calibration — Bed leveling](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2002/Etape_02.md).

Otherwise, if one or both extruders show over-extrusion or under-extrusion, you will need to calculate and set the steps/mm for each extruder motor E. Over-extrusion and under-extrusion are defined as follows:
- **Over-extrusion**: 111mm of filament extruded for a target of 100mm → more filament consumed than expected.
- **Under-extrusion**: 97mm of filament extruded for a target of 100mm → less filament consumed than expected.

This procedure must be performed every time you replace or change the print head on your QIDI I-Fast. If you always keep the same head, these settings should not change over time unless there is excessive wear or other issues. If in doubt, you can re-verify at any time by running the appropriate calibration G-code with temperatures adjusted for your filament material.

In principle, extruder motor steps can be calibrated with any type of filament, regardless of material — PLA, PETG, etc.

In my case, I use PETG on the left head (Z2) and PLA on the right head (Z1). PETG is used to print the part bodies, while PLA is used for supports, which makes support removal easier after printing.

### Important

My choice of assigning PETG to Z2 and PLA to Z1 is not arbitrary: this decision is "imposed" by my slicer IdeaMaker, which uses a particular head/nozzle referencing convention. As a result, the dominant filament profile for printing a part body is the leftmost head in IdeaMaker, which corresponds to Z2. If you are not using IdeaMaker and instead use QIDI's own slicer (or another), this may not apply to you — however I cannot be certain of this since I do not use other slicing software. It is therefore your responsibility to verify and adapt the G-code to your own setup.

Note: If you plan to use IdeaMaker in the future, I recommend making the same choices as me so that you can use my IdeaMaker profiles directly.

Summary of parameters for the extruder stepper motor calibration procedure on my QIDI IFAST:

```markdown
| Extruder location    | Left   | Right  |
|----------------------|--------|--------|
| QIDI I-Fast ID       | Z2     | Z1     |
| Material             | PETG   | PLA    |
| Nozzle temperature   | 235°C  | 205°C  |
| Filament color       | White  | Purple |
| Flow rate            | 100%   | 100%   |
| Calibration length   | 100mm  | 100mm  |
```

My calibration G-code file [03_09_2024_RAZ_extrude_100mm.gcode](https://github.com/AmyLGalles/IMPRIMANTES_3D/blob/main/ENGLISH_TRANSLATIONS/IFAST/CALIBRATION/Step_01/gcode/03_09_2024_RAZ_extrude_100mm.gcode) will extrude 100mm of filament from each head in sequence at the appropriate temperatures for PETG and PLA.

If you want to calibrate your printer with other filaments or combinations (PLA/PLA, PETG/ABS, etc.), **you will need to download the G-code file and adapt the temperatures to match the material you have chosen to extrude**. Example modification for PLA on both Z1 and Z2 at 205°C:

```gcode
; ----------------------------------------------------
; Set the temperature of both nozzles

; Left nozzle Z2 alias T1 for PLA at 205°C
M109 T1 S205

; Right nozzle Z1 alias T0 for PLA at 205°C
M109 T0 S205

; Note: M109 waits for the target temperature to be reached before continuing → do not replace with M104
; ----------------------------------------------------
```

Note: For this procedure, the bed should remain lowered — there is no need to heat it, nor the enclosure.

P1) Load two well-dried and dehydrated spools (allow 24 hours of drying time). In my case: white PETG on the left, purple PLA on the right.

P2) Do not install the blue PTFE guide tubes — remove them if necessary, as they will prevent you from marking and measuring filament lengths.

P3) Using the QIDI IFAST menu, move the head to the center of the XY bed. (WARNING: never move the head by hand.)

P4) Using a ruler or caliper, precisely measure 100mm on each filament and mark a clear line with a marker — be as precise as possible, as it will affect the result. Make a second mark at 200mm from the head. WARNING: when resting the ruler or caliper against something, this may introduce a few millimeters of error. These millimeters matter, so take care and be as precise as possible.

P5) Manually set the preheat temperatures for the filaments — in my case Z2 to 235°C and Z1 to 205°C. Although my G-code handles this and waits for the target temperatures to be reached before proceeding, developing this habit will one day prevent you from accidentally extruding at too low a temperature and damaging a nozzle.

P6) Run the G-code [03_09_2024_RAZ_extrude_100mm.gcode](https://github.com/AmyLGalles/IMPRIMANTES_3D/blob/main/ENGLISH_TRANSLATIONS/IFAST/CALIBRATION/Step_01/gcode/03_09_2024_RAZ_extrude_100mm.gcode). Z2 and Z1 will heat up and each extrude approximately 100mm in turn.

P7) Measure the distance between the reference zero (the uninserted collar) on the head and the first mark for Z2, then repeat for Z1.

**// Note: Add a photo!**
![Simplon.co](http://blabla/maPhoto.png)

Example test results on my IFAST at 100% flow rate for 100mm:

- Left Z2 PETG 235°C — under-extrusion: +4mm of filament remaining.
- Right Z1 PLA 205°C — under-extrusion: +6.2mm of filament remaining.

If there are only a few mm left between the collar and the mark but you cannot measure it easily, here is a tip: measure the distance between the reference zero (the uninserted collar) and the second mark for Z2 (same for Z1).
Example:

- Left extruder Z2 PETG 235°C — under-extrusion: remaining filament length to the second mark is +101.5mm, so (200 - 101.5) = 98.5mm extruded. This will save you the trouble of contorting yourself to get a reading.

P8) Apply the following formula to calculate the new E steps/mm for Z2 and Z1:
- Left extruder Z2 PETG 235°C — under-extrusion, +4mm remaining → (200 - 104) = 96mm → 96 × 0.0073 / 100 = 0.0070
- Right extruder Z1 PLA 205°C — under-extrusion, +6.2mm remaining → (200 - 106.2) = 93.8mm → 93.8 × 0.0073 / 100 = 0.0068

### Special case — over-extrusion

If the first 100mm mark is below the collar, the simplest fix is to reset to factory default values, which will put you back into under-extrusion.

```gcode
; QIDI IFAST: T0 = right nozzle = Z1 = S
; QIDI IFAST: T1 = left nozzle = Z2 = P

M8011 S0.0073 P0.0073
```
Download the file [09_09_2024_RESTORE_DEFAUT_E_Z1Z2.gcode](https://github.com/AmyLGalles/IMPRIMANTES_3D/blob/main/ENGLISH_TRANSLATIONS/IFAST/CALIBRATION/Step_01/gcode/09_09_2024_RESTORE_DEFAUT_E_Z1Z2.gcode)

Run the G-code, reboot the printer, and return to step P04.

-----------------

### Saving the new values to the QIDI IFAST firmware

To replace and save the new steps/mm values for E on your Z1 and Z2, copy the following code snippet, replace the values with your own, save it under a descriptive filename such as "DD_MM_YYYY_SAVNEW_Steps_E_Z1Z2.gcode", and run it by printing it on the QIDI IFAST — it will complete in about 1 second.

```gcode
; QIDI IFAST: T0 = right nozzle = Z1 = S
; QIDI IFAST: T1 = left nozzle = Z2 = P

M8011 S0.0068 P0.0070
```
Download the file [09_09_2024_SAV_NEW_E_Z1Z2.gcode](https://github.com/AmyLGalles/IMPRIMANTES_3D/blob/main/ENGLISH_TRANSLATIONS/IFAST/CALIBRATION/Step_01/gcode/09_09_2024_SAV_NEW_E_Z1Z2.gcode)

-----------------

### Verifying that the new firmware values have been applied correctly

After updating:

- Restart / reboot your IFAST.

- Verify that the new S & P values result in correct 100mm extrusion from both nozzles using: [09_09_2024_VERIF_Z1Z2_extruder_100mm.gcode](https://github.com/AmyLGalles/IMPRIMANTES_3D/blob/main/ENGLISH_TRANSLATIONS/IFAST/CALIBRATION/Step_01/gcode/09_09_2024_VERIF_Z1Z2_extruder_100mm.gcode)
- If after extrusion the first 100mm mark lines up with the collar, your machine's extrusion is perfectly calibrated for both nozzles and this step is fully complete.

-----------------

All E calibration G-code files are available [here](https://github.com/AmyLGalles/IMPRIMANTES_3D/blob/main/ENGLISH_TRANSLATIONS/IFAST/CALIBRATION/Step_01/gcode).

_Note #1: Important for IdeaMaker users — the IdeaMaker printer profile includes a variable named **step E / mm = 0.00**. By default it is set to 0.00. If you change this value, IdeaMaker will override your calibration and apply that value to both extruder motors — so make sure this variable is set to 0.00 in your IdeaMaker printer profile: **step E / mm = 0.00**. This variable is only acceptable if you have a single extruder motor E._

---
*Original author: @sudtek*
