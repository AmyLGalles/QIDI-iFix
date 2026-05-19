; 09_September_2024
; QIDI IFAST
; Restore factory default E steps/mm values for each extruder stepper motor Z1 & Z2
; Default values: S = P = 0.0073
;
; QIDI IFAST: T0 = right nozzle = Z1 = S
; QIDI IFAST: T1 = left nozzle  = Z2 = P
;
; Factory default values: S0.0073 and P0.0073
M8011 S0.0073 P0.0073
;
; [ Save parameters ]
; Mandatory — without this, no settings are saved to the device.
M8500
;
; Reboot the printer.

; Original author: @sudtek
