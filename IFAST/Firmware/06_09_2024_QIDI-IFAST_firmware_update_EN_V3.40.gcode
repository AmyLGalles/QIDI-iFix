; 06_05_2024
;
; QIDI-IFAST firmware update V3.40 for ChituSystems mainboard based on Marlin (but not 100% Marlin)
; Firmware update provided by QIDI
; Translation, adaptation and comments by YS
; Note: this is not 100% Marlin firmware — some commands are specific to this board!
;
; ==================================
; [ Power-loss recovery / backup support ]
;
M8513 ; Power-loss recovery support
;
; I1 = backup enabled (DEFAULT VALUE)
; I0 = backup disabled
;
M8000 I1
;
; ==================================
;
; [ Printer shutdown support ]
;
; I1 = printer shutdown support enabled (DEFAULT VALUE)
; I0 = not supported — change takes effect after restart
;
M8001 I1
;
; ==================================
;
; [ Stepper motor direction control ]
;
; I1 and I-1 are opposite directions. If a motor runs the wrong way, change this parameter (not the wiring).
; Configures stepper motor directions for X, Y, Z axes and extruders E, E2, E3.
; X stepper motor direction: I1 or I-1
; I-1 (DEFAULT VALUE)
;
M8002 I-1
;
; ==================================
;
; [ Y stepper motor direction ]
;
; I-1 (DEFAULT VALUE)
;
M8003 I-1
;
; ==================================
;
; [ Z stepper motor direction ]
;
; I1 (DEFAULT VALUE)
;
M8004 I1
;
; ==================================
;
; [ E stepper motor direction ]
;
; I1 (DEFAULT VALUE)
;
M8005 I1
;
; ==================================
; [ Second E stepper motor direction: I1 E2 or I-1 E2 ]
;
; Ignore if you do not have a multi-nozzle setup.
; I1 E2 (DEFAULT VALUE)
;
M8005 I1 E2
;
; ==================================
;
; [ Third E stepper motor direction: I1 E3 or I-1 E3 ]
;
; Ignore if you do not have multiple nozzles. Three-nozzle setups only support three-in-one-out.
; I1 E3 (DEFAULT VALUE)
;
M8005 I1 E3
;
; ==================================
;
; [ XYZ axis print head / platform movement configuration ]
;
; Note: only affects manual button movement on the touchscreen.
; Note: most machines use print head movement on the X axis.
; 0: X axis = print head movement (DEFAULT VALUE)
; 1: X axis = platform movement
;
M8005 X0
;
; ----------------------------------
; 0: Y axis = print head movement (DEFAULT VALUE)
; 1: Y axis = platform movement
; I3 structure printers use platform movement on Y; delta, Ultimaker, and Makerbot use print head movement.
;
M8005 Y0
;
; ----------------------------------
; 0: Z axis = print head movement
; 1: Z axis = platform movement (DEFAULT VALUE)
; I3 and delta structure printers use print head movement on Z; Ultimaker and Makerbot use platform movement.
;
M8005 Z1
;
; ==================================
;
; [ Speed settings in mm/s ]
;
; Maximum start speed. When movement speed exceeds this value, this speed is used as the starting speed.
; Prevents loss of steps. If too low, causes corner bulging when printing cylinders.
; Range: [80 mm/s² .. 120 mm/s²] -> [I80 .. I120]
; Default: [80 mm/s²] -> [I80]
;
M8006 I80
;
; ==================================
;
; [ Maximum cornering acceleration in mm/s² ]
;
; Equivalent to jerk speed in open-source firmware.
; If actual cornering speed exceeds this value, motion is forced to decelerate.
; High value = more noise and lost steps during infill.
; Low value = slower speed; print quality may suffer at high speeds.
; Default: [25 mm/s²] -> [I25]
;
M8007 I15
;
; ==================================
;
; [ Acceleration mm/s² ]
;
; Higher value = faster average print speed but more noise. Lower value = slower actual speed.
; Range: [600 mm/s² .. 1100 mm/s²] -> [I600 .. I1100]
; Default: [1000 mm/s²] -> [I1000]
;
M8008 I1000
;
; ==================================
;
; [ Machine parameters ]
;
; After setting parameters, print a cube and measure it to confirm accuracy.
; XY steps per mm. Example: 20-tooth pulley, 2.032mm pitch, 1.8° motor, 16 microsteps = (20×2.032)/((360/1.8)×16)
; Default: S0.01061083
;
M8009 S0.01061083
;
; ----------------------------------
; To set X and Y stepper parameters independently, use this command:
;
; Default: X0.010625 Y0.010625
;
; M8009 X0.010625 Y0.010625
;
; ----------------------------------
; Z steps per mm. Formula: lead pitch / ((360/1.8)×16)
; Lead pitch = height the platform rises per full screw revolution.
;
; Default: S0.0025
;
M8010 S0.0025
;
; ==================================
;
; [ E extruder calibration — Z1 Z2 ]
;
; E steps per mm. Equal to the circumference of the extrusion gear divided by 3200.
; If a reduction drive is present, also divide by the reduction ratio.
; If extrusion is sparse or layers are missing, try setting this slightly lower than the calculated value.
;
; YS note: This corresponds to the over/under-extrusion calibration step for extruders.
; You must calculate your own value — see the tutorial:
; https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2001/Etape_01.md
;
; Default: M8011 S0.0073 P0.0073
;
; YS note 06_09_2024 — my values after Step 01:
;
M8011 S0.0069 P0.0069
;
; ==================================
;
; [ Maximum speed values ]
;
; Adjust based on actual test results to ensure machine stability.
; Maximum XY speed in mm/s
; Default: 200 mm/s -> I200
;
M8012 I200
;
; ----------------------------------
; Maximum Z speed in mm/s
; Default range: [5 mm/s .. 25 mm/s] -> I5 .. I25
;
M8013 I10
;
; ----------------------------------
; Maximum extruder speed in mm/s
; Default: [120 mm/s] -> I120
;
M8014 I120
;
; ----------------------------------
; Z homing speed. MakerWare slicing software ignores this and uses its own homing speed from the G-code.
; First Z homing speed (faster pass)
;
M8015 I8
;
; ----------------------------------
; First XY homing speed (faster pass)
;
M8015 S30
;
; ----------------------------------
; Second Z homing speed (slower pass)
;
M8016 I4
;
; ----------------------------------
; Second XY homing speed (slower pass)
;
M8016 S5
;
; ==================================
;
; [ Pre-extrusion before printing ]
;
; Pre-extrusion length in mm. First-layer adhesion directly affects print quality.
; More pre-extrusion improves bed adhesion.
; DEFAULT VALUE = 1mm = I1
;
M8017 I1
;
; ==================================
;
; [ Maximum pre-extrusion speed in mm/s ]
;
; For non-geared (direct drive) feeders, maximum speed is usually above 100 mm/s.
; Default range: [20 mm/s .. 80 mm/s] -> [I20 .. I80]
; DEFAULT VALUE = 20 mm/s = I20
;
M8018 I20
;
; ==================================
;
; [ Special — Replicator/Makerware compatibility ]
;
; The following two parameters relate to Replicator/Makerware software compatibility.
; If you are not using that software, these can be left alone.
; Maximum retraction speed in mm/s.
; When 0, uses the same value as maximum E speed.
; Default Makerware dual-head slicing retracts very slowly with long pause times.
; Default range: [50 mm/s .. 100 mm/s] -> [I50 .. I100] or I0
; DEFAULT VALUE = 50 mm/s = I50
;
M8019 I50
;
; ==================================
;
; [ Retraction length / retraction distance in mm ]
;
; Too little retraction = oozing/stringing.
; Too much retraction = long pauses and still oozing.
; Set according to your extruder type.
; If 0, retraction length follows the slicing software setting.
; DEFAULT VALUE = 0 = S0
;
M8020 S0
;
; ==================================
;
; [ Retraction length when switching extruders ]
;
; Makerware specifies very long retractions which can cause jams on re-extrusion.
; If 0, follows slicing software settings.
; DEFAULT VALUE = 0 = S0
;
M8033 S0
;
; ==================================
;
; [ Default filament diameter ]
; Filament diameter in mm
; DEFAULT VALUE = 1.75mm = S1.75
;
M8021 S1.75
;
; ==================================
;
; [ Maximum extruder temperature ]
;
; Set to prevent accidental overheating and damage to the extruder.
; The extruder temperature can never exceed this value.
; Note: the heating element must not exceed 260°C — the PEEK tube begins softening at 260°C!
; DEFAULT VALUE = 350°C = I350
;
M8022 I350
;
; ==================================
;
; [ Filament interface — minimum extrusion temperature ]
;
; Minimum temperature required to extrude filament on the filament interface.
; DEFAULT VALUE = 230°C = T230
;
M8022 T230
;
; ==================================
;
; [ Maximum heated bed temperature ]
;
; Note: excessive temperature may damage the heat bed.
; DEFAULT VALUE = 120°C = I120
;
M8023 I120
;
; ==================================
;
; [ Temperature error detection ]
;
; Note: it is strongly recommended NOT to disable this feature!
; Triggers a warning when the temperature sensor is not connected or heating power is too low.
; 0: Enable temperature detection (DEFAULT VALUE)
; 1: Disable error detection for both extruder and bed
; 2: Disable error detection for bed only
;
M8023 T0
;
; ==================================
; [ Maximum heated enclosure temperature ]
;
; Note: excessive temperature may damage the heat bed!
; DEFAULT VALUE = 80°C = C80
;
M8023 C80
;
; ==================================
;
; [ X, Y, Z maximum travel in mm ]
;
; Set according to actual print volume. THIS PARAMETER IS CRITICAL!!!!!!
; Too small = areas beyond the limit cannot be printed.
; Too large = no restriction if slice commands exceed machine travel, risking motor crash!
;
; [ X maximum travel ]
;
; Note: if LCD sound is enabled, movement beyond travel triggers a buzzer.
; Default Xmax = 372.5mm -> I372.5
;
M8024 I372.5
;
M8024 T4
; ==================================
; [ Y maximum travel ]
;
; Default Ymax = 250mm -> I250
;
M8025 I250
;
; ==================================
; [ Z maximum travel ]
;
; Default Zmax = 322mm -> I322
;
M8026 I322
;
; ==================================
;
; [ Number of extruders ]
;
; Minimum 1, maximum 3. Three-nozzle setups only support three-in-one-out.
; Values: [1, 2, 3] — DEFAULT VALUE = 2 -> I2
;
M8027 I2
;
; ----------------------------------
; [ Multi-in-one-out nozzle? ]
;
; Multi-in-one-out nozzles share a single temperature sensor and heating element.
; 0: Standard — not multi-in-one-out (DEFAULT VALUE)
; 1: Multi-in-one-out
;
M8027 S0
;
; ----------------------------------
; [ Multi-Y or multi-Z special function ]
;
; Enable by uncommenting.
; 0: Dual Z, dual limit switches — second limit connected to X+ (DEFAULT VALUE)
; 1: Dual Z, single limit switch — only one limit switch required
; 3: Triple Z — third Z axis connected to the EXT expansion port
;
M8027 Z0
;
; ==================================
;
; [ Use second extruder E2 as Y axis ]
;
; Uncomment to enable (DEFAULT VALUE)
; M8027 Y0
; ----------------------------------
;
; [ Use second extruder E2 as first extruder E1 ]
;
; Uncomment to enable (DEFAULT VALUE)
; M8027 E0
; ==================================
;
; [ Disable heated bed ]
;
; 1: Enable heated bed (DEFAULT VALUE)
; 0: Disable heated bed
;
M8027 T1
;
; ==================================
;
; [ Advanced settings ]
;
; Retraction compensation. After retraction and re-extrusion, elasticity causes a slight extra retraction.
; Note: inertia / backlash compensation between two extrusions?
; Leave at 0 if unsure.
;
M8028 S0.00
;
; ==================================
;
; [ XY limit switch position type ]
;
; 0: Single-side zero limit (front left) — e.g. Mendel, i3 (DEFAULT VALUE)
; 1: Single-side maximum limit (rear right) — e.g. Makerbot
; 2: Bilateral limit — e.g. Ultimaker (mini board has only 3 XYZ limits; do not use this option)
; 3: Rear left limit (very rare)
; 4: Front right limit (very rare)
;
M8029 I0
;
; ==================================
;
; [ XYZ limit switch wiring type ]
;
; If configured incorrectly, the motor will be unable to move in one direction and the buzzer will sound.
; Simple check: if configured correctly, the buzzer sounds when the limit is triggered and is silent when released.
; If behavior is reversed, change this parameter.
; 0: Normally open (high when not triggered, low when triggered) (DEFAULT VALUE)
; 1: Normally closed (low when not triggered, high when triggered)
;
M8029 T0
;
; ==================================
;
; [ Z axis limit switch position ]
;
; 0: Triggered when extruder is closest to the bed — limit connected to Z-
; 1: Triggered when extruder is farthest from the bed — limit connected to Z+ (DEFAULT VALUE)
;
M8029 S1
;
; ==================================
; [ Return to (0,0,0) after homing — XYZ and H-bot machines only ]
;
; 0: Return to (0,0,0) — print head moves to front-left of the bed
; 1: Stay at the limit position (DEFAULT VALUE)
;
M8029 C1
;
; ==================================
;
; [ Filament runout sensor ]
;
; Runout sensor limit connected to the corresponding extruder limit port (E1 or E2).
; 0: Disable filament runout detection
; 1: Enable filament runout detection (DEFAULT VALUE)
;
M8029 D1
; ----------------------------------
; [ Filament runout sensor limit switch type for E1 and E2 ports ]
; 1: Same type as XYZ limits
; -1: Opposite type to XYZ limits (DEFAULT VALUE)
;
M8029 E-1
M8029 P-1
; ==================================
;
; [ Part cooling fan control ]
;
; This fan cools the printed model. Recommended: let the slicer control fan on/off.
; >0: Fan turns on automatically when extruder exceeds this temperature.
;  0: Fan controlled by slicing software (DEFAULT VALUE)
;
M8030 I0
;
; ----------------------------------
;
; [ Hotend throat (heatsink) fan control ]
;
; This fan cools the nozzle throat. Auto-start temperature must be set after the M8030 I0 command.
; The value after I is the threshold temperature.
; At 0: fan does not respond to temperature changes.
; Otherwise: fan turns on when extruder reaches the specified temperature.
; 50°C = I50 (DEFAULT VALUE)
;
M8030 I50 T-1
;
; ==================================
;
; [ Second extruder (right extruder) offset in mm ]
;
; For single-extruder setups, the following two parameters are ignored — set dual offset to 0 in Cura or other slicers.
; X axis offset (left/right): 35mm -> S-35 (DEFAULT VALUE)
;
M8031 S-35
;
; ------ 
;
; [ Y axis offset (front/rear) ]
;
; 0mm -> S0 (DEFAULT VALUE)
;
M8032 S0
;
; ==================================
;
; [ SD card folder support ]
;
; 0: Not supported
; 1: Supported (DEFAULT VALUE)
;
M8034 I1
;
; ==================================
;
; [ Leveling test points ]
;
; Minimum 3, maximum 5 points. X and Y are floating-point numbers.
; If both X and Y are less than 1, values are treated as proportions of total travel.
; Otherwise treated as absolute coordinates in mm.
; Example: with 200×200 travel, M8036 X0.1 Y0.1 equals M8036 X20 Y20.
; Number of leveling points: 3 = I3 (DEFAULT VALUE)
;
M8035 I3
;
; One M8036 command per leveling point for manual XYZ and delta leveling tests.
; For delta auto-leveling, only the first point is used — it represents the sensor offset
; from the nozzle center (positive = rear right). Other points are ignored.
;
M8036 X10 Y10
M8036 X320 Y10
M8036 X165 Y240
M8036 X0.2 Y0.8 ; YS note: why 4 points when M8035 defines 3? -> 5 points would make more sense!
; ==================================
;
; [ Temperature sensor type ]
;
; Please set the correct thermistor type.
; Temperature readings can differ by up to 40°C depending on sensor type:
; 0: Ideal NTC 100K 1% 3950 B thermistor
; 1: K-type thermocouple (DEFAULT VALUE)
; 2: EPCOS NTC 100K 1% 3950 B — equivalent to Marlin sensor type 1; most common on the market
;
M8081 I1
;
; ==================================
;
; [ Enable auto-leveling ]
;
; 0: Disable auto-leveling (XYZ structure falls back to semi-automatic leveling mode)
; 1: Allow auto-leveling (DEFAULT VALUE)
; Note: for XYZ structure, connect the leveling switch directly to Z-, remove the original limit switch,
; and use in conjunction with the M8084 Z* command.
;
; M8083 I1
;
; ==================================
; [ Servo deployment/retraction angles for auto-leveling ]
;
; Note: only valid when auto-leveling is enabled!
; YS note 06_09_2024: QIDI is unclear here — can the bed be adjusted / tilted on the QIDI IFAST?
; D = servo retracted angle, P = servo deployed angle.
; If both angles are equal, no servo support is assumed.
; Achievable angles depend on the specific servo; for 180° rotation servos, measured range is approx. -85° to 105°.
M8083 D0 P0
M8083 C-45.0 R372.0 ; C = left software limit position of X axis, R = right software limit position of X axis
;
; ==================================
; [ Z leveling limit offset — advanced parameter, do not change ]
;
; Height difference of Z leveling limit on XYZ auto-leveling machines = Z position at leveling trigger - Z zero position.
;
; 0: No offset. Z travel is set by "Set Z to zero". G-code does not need auto-leveling commands. Recommended.
; Non-zero: Z position determined automatically when leveling limit triggers. For DELTA structure,
; G29 auto-leveling must follow G28 homing and precede all print commands.
; Positive value typical for optical sensors.
; !!!! WARNING (translation issue in original below!)
; Negative value if the extruder presses against the mainboard at trigger.
; vs.
; Negative value if the extruder presses against the bed at trigger?
;
M8084 Z0.15
;
; ==================================
; [ Boot logo display duration ]
;
; Minimum 100ms, maximum 6000ms -> 3 seconds = I3000 (DEFAULT VALUE)
;
M8085 I3000
;
; ==================================
; [ Screensaver timeout ]
;
; Time before screensaver activates, in seconds (s).
; 0 = screensaver disabled (DEFAULT VALUE)
;
M8085 T0
; ==================================
;
; [ Standby auto-shutdown (requires shutdown-after-print hardware module) ]
;
; Time before the machine shuts down, in seconds (s).
; This function only works if the shutdown-after-print module is installed.
; 0 = standby shutdown disabled (DEFAULT VALUE)
;
M8085 P0
;
; ==================================
;
; [ Software microstepping divisor ] (Do not change this parameter!)
;
; For users with 0.9° step angle motors or external 32-subdivision drivers
; who want to emulate 1.8° / 16-subdivision behavior: set to 2.
; Default = 1 (no division) (DEFAULT VALUE)
;
M8086 I1
;
; ==================================
; [ Motor current settings in mA ]
;
; S = driver current. Recommended range: 200–1500mA (max 2000mA).
; Add a cooling fan if exceeding 1000mA.
;
; ------ X motor current — S = driver current in mA ------
M8091 I0 S650 P3 D3 C5 R6 F5 T0
; ==================================
; ------ Y motor current — S = driver current in mA ------
M8091 I1 S650 P3 D3 C5 R6 F5 T0
; ==================================
; ------ Z motor current — S = driver current in mA ------
M8091 I2 S325 P3 D3 C5 R6 F5 T0
; ==================================
; ------ E motor current — S = driver current in mA ------
M8091 I3 S650 P3 D3 C5 R6 F5 T0
; ==================================
; ------ E2 motor current — S = driver current in mA ------
M8091 I4 S650 P3 D3 C5 R6 F5 T0
; ==================================
; ------ EXT motor current — S = driver current in mA ------
M8091 I5 S800 P3 D3 C5 R6 F5 T0
; ==================================
; ------ Z2 motor current — S = driver current in mA ------
M8091 I6 S325 P3 D3 C5 R6 F5 T0
; ==================================
;
; ==================================
; [ ?????????????????? ]
;
; YS note: this command appears to be used for pin remapping.
; Parameter I0 may indicate that pin remapping is disabled.
; This appears to be a firmware- or mainboard-specific configuration command.
;
M8092 I0
;
; ==================================

; [ Mainboard fan auto-start PWM ratio ]
;
; Sets the PWM ratio of the mainboard fan at auto-start. Maximum is 256.
; Some mainboard fans are loud at full power — reduce this value to lower fan speed and noise.
; DEFAULT VALUE = 230 -> I230
;
M8489 I230
;
; ==================================
;
; [ Filament interface extrusion speed ]
;
; Filament loading speed on the filament interface, in mm/s.
; If too fast, the feeder cannot keep up, causing under-extrusion and lost steps.
;
M8489 T2
;
; ==================================
;
; [ Action after print completes ]
;
; 0: Turn off all motors and heaters (DEFAULT VALUE)
; 1: No action — follow G-code instructions entirely
; 2: Home all axes after printing, keep motors powered
; 3: Drop to maximum Z travel after printing, keep motors powered
; 4: Wait until nozzle 1 cools to 50°C before signaling print complete
;
M8489 P0
;
; ==================================
; [ Temperature PID parameters ]
;
; Default: [M301 P18 I1.08 D98]
; If your temperature control is stable and you are not an expert, leave this alone.
; Tick the box in front before configuring.
;M301 P10.9 I0.22 D180 ; (reference — DEFAULT VALUE)
;M302 P10.9 I0.22 D180 ; (reference — DEFAULT VALUE)
;
M301 P10.9 I0.22 D180
M302 P10.9 I0.22 D180
;
; ==================================
;
; [ Laser support ]
;
; 1: Enable laser engraving configuration
; 0: Disable — laser speed is set via the "More" button (DEFAULT VALUE)
;
M8520 I0
;
; ==================================
;
; [ Initial heated enclosure temperature ]
; DEFAULT VALUE = 80°C
;
M8525 I80
;
; ==================================
;
; [ Popup warning for insufficient heating power or non-functional temperature sensor ]
;
; 1: Enable warning (DEFAULT VALUE)
; 0: Disable warning
;
M8525 T1
;
; ==================================
; [ Enable filament runout detection display ]
;
; 1: Enable filament runout detection display (DEFAULT VALUE)
; 0: Disable filament runout detection display
;
M8528 I1
;
; ==================================
; [ X and Y coordinates after homing ]
;
;M8100 D-9.5  ; X coordinate after homing (reference — DEFAULT VALUE)
;M8100 P0     ; Y coordinate after homing (reference — DEFAULT VALUE)
;
M8100 D-9.5  ; X coordinate after homing
M8100 P0     ; Y coordinate after homing
;
; ==================================
; [ MB_FAN PWM frequency for extruder 1 and 2 ]
;
; I = MB_FAN PWM for extruder 1, 1-byte range [0..255] -> DEFAULT VALUE = 255 = I255
; T = MB_FAN PWM for extruder 2, 1-byte range [0..255] -> DEFAULT VALUE = 255 = T255
M8529 I255 T255
;
; ==================================
; [ Temperature change detection interval (seconds) ]
;
; D = temperature change detection interval (checks every 3 seconds) (DEFAULT VALUE)
; P = total duration of temperature warning (25 seconds without heating to 40°C for bed, 140°C for extruder 1)
M8101 D3 P25
;
; ==================================
; [ Heated bed temperature PID parameters ]
;
M304 P71.039 I2.223 D567.421 ; Heated bed PID parameters
;
; 0: Disable bed PID
; 1: Enable bed PID (DEFAULT VALUE)
;
M8600 I1
;
; ==================================
; [ Extruder temperature during pause ]
;
; 0: Do not lower extruder temperature during pause
; 1: Lower extruder temperature during pause (DEFAULT VALUE)
;
M8530 I1
;
; ==================================
;
; [ Save parameters ]
;
; Mandatory — without this, no settings are saved to the device.
;
M8500
;
; ==================================
; [ Reset printer to factory defaults ]
;
M7507 I1 T0
;
; Original author: @sudtek
