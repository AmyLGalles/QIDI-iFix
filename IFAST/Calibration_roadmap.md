What needs to be done....

<s>
;//DONE
; To do: Set before the nozzle temperature and wait X minutes
; example : ideal extruding length is 100mm, but actually it flew out 93mm.
; So the correct e step should be 93*0.0073/100, it is 0.006789
;//DONE
</s>
;
;Block 1: To independently adjust the stepper motor parameters for XY, use this command (check the box in the frame above).
M8009 X0.010625 Y0.010625

;Block 2: The mm value of each step is calculated using the following formula: step (360/18)*16. The step is the distance the platform rises when the screw turns one full revolution.
M8010 S0.0025

**
;
;Block 3: The mm value of each step equals the circumference of the extrusion drive wheel divided by 3200.
;         If you have a reduction device, also divide by the reduction ratio. If you find that the filament is being extruded too loosely, or...
          A new suggestion is to make this value slightly lower than the actual value — extrusion will be better.
;M8011 S0.0073 P0.0073
;M8011 S0.0067 P0.0067
;**

;Block 4: Maximum speed for XY movements in mm/s. To ensure machine stability, please adjust this value based on your test results.
M8012 1200

Block 5: Maximum speed for Z movements in mm/s.
M8013 110

;Block 6: Maximum extruder speed in mm/s.
M8014 1120

;Block 7: The first homing speed of the Z axis. The speed is relatively fast. The MakerWare slicing software will ignore this homing speed because the G-code it generates specifies its own homing speed.

Additional notes (based on comments)
* Stepper motor parameters: The M8009 and M8010 commands adjust the movement precision of the X and Y axes based on the motor and lead screw characteristics.
* Step calculation: The comment explains how to calculate the Z axis step based on the lead screw pitch. This value is essential for accurate filament extrusion.
* Extrusion speed: The M8011 command and its associated comment relate to the maximum speed at which filament can be extruded. Too high a value can cause adhesion issues or under-extrusion.
* Maximum speeds: The M8012, M8013, and M8014 commands define the maximum speeds for X, Y, and Z axis movements as well as extrusion. These values should be adjusted based on the machine's capabilities and the material being used.
* Z axis homing: The last comment notes that the Z axis homing speed may be ignored by some slicing software, as they specify their own speed in the generated G-code.

---
*Original author: @sudtek*
