; 03_09_2024
; QIDI IFAST
; Extruder stepper motor calibration procedure

; Left extruder Z2 T1 on QIDI IFAST
; - PLA 205°C
; - 100% flow rate
; - Calibration length 100mm

; Right extruder Z1 T0 on QIDI IFAST
; - PLA 205°C
; - 100% flow rate
; - Calibration length 100mm

; Firmware: Marlin-based (not pure Marlin)
; Custom Toolhead: T1 T0

; ----------------------------------------------------
; ----------------------------------------------------
; ----------------------------------------------------
; ----------------------------------------------------

; ----------------------------------------------------
; Set flow rate to 100% for both nozzles
M221 T1 S100.00
M221 T0 S100.00
; ----------------------------------------------------

; ----------------------------------------------------
; Begin homing sequence
G28
; Move to home position (0,0) at speed 3600
G0 X0 Y0 F3600
; ----------------------------------------------------

; ----------------------------------------------------
; Set temperature for both nozzles

; Left nozzle Z2 alias T1 for PLA at 205°C
M109 T1 S205

; Right nozzle Z1 alias T0 for PLA at 205°C
M109 T0 S205

; Note: M109 waits for the target temperature to be reached before continuing → do not replace with M104
; ----------------------------------------------------

; ----------------------------------------------------
; Extruder Z2 (left) alias T1 — PLA filament
T1

; No nozzle fan
M107

; Set extruder E position — E0 = initialization
G92 E0
G1 X330 E0 F2400

; Extrude 100mm of filament at constant speed — max feed rate between start and end of extrusion: 125
G1 E100 F125
; ------------------------------------------------

; ------------------------------------------------
; Extruder Z1 (right) alias T0
T0

; No nozzle fan
M107

; Set extruder E position — E0 = initialization
G92 E0
G1 X330 E0 F2400

; Extrude 100mm of filament at constant speed — max feed rate between start and end of extrusion: 125
G1 E100 F125
; ------------------------------------------------

; ------------------------------------------------
; ------------------------------------------------
; ------------------------------------------------
; ------------------------------------------------
; Notes:
; Run a calibration test with a filament length of 100mm minimum to 1000mm maximum.
; Measure the over(-) or under(+) extrusion on both filaments to calculate the compensation for each extruder.
; Apply the following formula to calculate the new E steps/mm value:
;
; Example: If the target extrusion length is 100mm but only 93mm was extruded, 7mm remains — this is under-extrusion.
; The correct E value should be: 93 * 0.0073 / 100 = 0.006789
;
; ------------------------------------------------
; ------------------------------------------------
; ------------------------------------------------
; ------------------------------------------------

; Original author: @sudtek
