; 09_September_2024
; QIDI IFAST
; Procedure to save new E steps/mm values for each extruder stepper motor Z1 & Z2
; See https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2001/Etape_01.md
;
; QIDI IFAST: T0 = right nozzle = Z1 = S
; QIDI IFAST: T1 = left nozzle  = Z2 = P
;
; To complete calibration step 01:
; #1 Replace the S and P values below with your own calculated values
; #2 Print this G-code on the QIDI IFAST to save the values
; #3 Reboot the QIDI IFAST
;
; Factory default values: S0.0073 and P0.0073
; P -> Z2 -> T1
; S -> Z1 -> T0
;
; Enter new values below:
;
M8011 S0.00678 P0.00678
;
; [ Save parameters ]
; Mandatory — without this, no settings are saved to the device.
M8500
;
; Reboot the printer!

; Original author: @sudtek
