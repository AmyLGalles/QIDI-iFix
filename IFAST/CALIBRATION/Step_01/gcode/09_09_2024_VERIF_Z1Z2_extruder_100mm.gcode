; 09_09_2024
; QIDI IFAST
; Verification procedure for the E steps/mm values of the extruder stepper motors

; Left extruder Z2 T1 on QIDI IFAST
; - PETG 235°C
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

; Left nozzle Z2 alias T1 for PETG at 235°C
M109 T1 S235

; Right nozzle Z1 alias T0 for PLA at 205°C
M109 T0 S205

; Note: M109 waits for the target temperature to be reached before continuing → do not replace with M104
; ----------------------------------------------------

; ----------------------------------------------------
; Extruder Z2 (left) alias T1 — PETG filament
T1

; No nozzle fan
M107

; Set extruder E position — E0 = initialization
;G92 E0
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
;G92 E0
G1 X330 E0 F2400

; Extrude 100mm of filament at constant speed — max feed rate between start and end of extrusion: 125
G1 E100 F125
; ------------------------------------------------

; Original author: @sudtek
