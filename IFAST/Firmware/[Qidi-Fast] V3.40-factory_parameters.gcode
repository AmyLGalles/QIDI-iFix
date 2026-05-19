M8513
;
; Power-loss recovery support
; I1 = enabled, I0 = disabled. Restart after changing for it to take effect.
M8000 I1
; ==================================
;
; Shutdown after print support
; I1 = enabled, I0 = disabled. Restart after changing for it to take effect.
M8001 I1
; ==================================
;
; Stepper motor direction control. I1 and I-1 are opposite directions.
; If a motor runs the wrong way, either rewire it or change this parameter.
; X stepper motor direction: I1 or I-1
M8002 I-1
; ==================================
;
; Y stepper motor direction
M8003 I-1
; ==================================
;
; Z stepper motor direction
M8004 I1
; ==================================
;
; E stepper motor direction
M8005 I1
; ==================================
;
; Second E stepper motor direction: I1 E2 or I-1 E2
; Ignore if you do not have a multi-nozzle setup.
M8005 I1 E2
; ==================================
;
; Third E stepper motor direction: I1 E3 or I-1 E3
; Ignore if you do not have multiple nozzles. Three-nozzle setups only support three-in-one-out.
M8005 I1 E3
; ==================================
; XYZ axis print head / platform movement configuration.
; Only affects manual button movement direction on the touchscreen.
; 0: X axis = print head movement    1: X axis = platform movement
; Most machines use print head movement on the X axis.
M8005 X0
; ==================================
;
; 0: Y axis = print head movement    1: Y axis = platform movement
; I3 structure printers use platform movement on Y; delta, Ultimaker, and Makerbot use print head movement.
M8005 Y0
; ==================================
;
; 0: Z axis = print head movement    1: Z axis = platform movement
; I3 and delta structure printers use print head movement on Z; Ultimaker and Makerbot use platform movement.
M8005 Z1
; ==================================
;
; Speed settings — speed in mm/s, acceleration in mm/s²
; Maximum start speed. When movement speed exceeds this value, this speed is used as the starting speed.
; Prevents loss of steps. If too low, causes corner bulging when printing cylinders.
M8006 I80           ;----GAM-----I80---I120
; ==================================
;
; Maximum cornering speed (equivalent to jerk speed in open-source firmware).
; If actual cornering speed exceeds this value, motion is forced to decelerate.
; High value = more noise and lost steps during infill.
; Low value = slower speed; print quality may suffer at high speeds.
M8007 I15           ;----GAM--------I25
; ==================================
;
; Acceleration. Higher value = faster average print speed but more noise. Lower value = slower actual speed.
M8008 I1000         ;----GAM-------I1100-I600
; ==================================
;
; Machine parameters. After setting, print a cube and measure it to confirm accuracy.
; XY steps per mm. Example: 20-tooth pulley, 2.032mm pitch, 1.8° motor, 16 microsteps = (20×2.032)/((360/1.8)×16)
M8009 S0.01061083
; ==================================
;
; To set X and Y stepper parameters independently, use this command:
;M8009 X0.010625 Y0.010625
; ==================================
;
; Z steps per mm. Formula: lead pitch / ((360/1.8)×16)
; Lead pitch = height the platform rises per full screw revolution.
M8010 S0.0025
; ==================================
;
; E steps per mm. Equal to the circumference of the extrusion gear divided by 3200.
; If a reduction drive is present, also divide by the reduction ratio.
; If extrusion is sparse or layers are missing, try setting this slightly lower than the calculated value.
M8011 S0.0073 P0.0073
; ==================================
;
; Maximum speeds. Adjust based on actual test results to ensure machine stability.
; Maximum XY speed (mm/s)
M8012 I200          ;----GAM--------
; ==================================
;
; Maximum Z speed (mm/s)
M8013 I10           ;----GAM------I5--I25
; ==================================
;
; Maximum extruder speed (mm/s)
M8014 I120          ;----GAM--------I120
; ==================================
;
; Z homing speed. MakerWare slicing software ignores this and uses its own homing speed from the G-code.
; First Z homing speed (faster pass)
M8015 I8
; ==================================
;
; First XY homing speed (faster pass)
M8015 S30
; ==================================
;
; Second Z homing speed (slower pass)
M8016 I4
; ==================================
;
; Second XY homing speed (slower pass)
M8016 S5
; ==================================
;
; Pre-extrusion before printing.
; Pre-extrusion length (mm). First-layer adhesion directly affects print quality.
; More pre-extrusion improves bed adhesion.
M8017 I1
; ==================================
;
; Maximum pre-extrusion speed (mm/s). For non-geared (direct drive) feeders, maximum speed is usually above 100.
M8018 I20           ;----GAM------I20--I80
; ==================================
; The following two parameters relate to Replicator/Makerware software compatibility.
; If you are not using that software, these can be left alone.
; Maximum retraction speed (mm/s).
; When 0, uses the same value as maximum E speed.
; Default Makerware dual-head slicing retracts very slowly with long pause times.
M8019 I50           ;----GAM-----I100--I50-I0
; ==================================
;
; Retraction length (mm). Too little = oozing. Too much = long pauses and still oozing.
; Set according to your feeder type and extruder type.
; If 0, retraction length follows the slicing software setting.
M8020 S0            ;----GAM--------S0
; ==================================
;
; Retraction length when Makerware switches extruders.
; Makerware specifies very long retractions which can cause jams on re-extrusion.
; If 0, follows slicing software settings.
M8033 S0
; ==================================
;
; Default filament diameter (mm)
M8021 S1.75
; ==================================
; Maximum extruder temperature.
; Set to prevent accidental overheating and damage to the extruder.
; Thermal resistance limit is ~260°C; PEEK tube begins softening at ~260°C.
M8022 I350
; ==================================
;
; Filament interface — minimum extrusion temperature.
; Minimum temperature required to extrude filament on the filament interface.
M8022 T230
; ==================================
;
; Maximum heated bed temperature.
; Excessive temperature may damage the heat bed.
M8023 I120
; ==================================
; It is strongly recommended NOT to disable this feature.
; Temperature error detection. Triggers a warning when the temperature sensor is not connected or heating power is too low.
; 0: Enable temperature detection    1: Disable error detection for extruder and bed    2: Disable bed error detection only
M8023 T0
; ==================================
;
; Maximum heated enclosure temperature.
; Excessive temperature may damage the heat bed.
M8023 C80
; ==================================
; Maximum travel for X, Y, Z axes (mm). Set according to actual print volume. THIS PARAMETER IS CRITICAL!!!!!!
; Too small = areas beyond the limit cannot be printed.
; Too large = no restriction if slice commands exceed machine travel, risking motor crash.
; X maximum travel. If LCD sound is enabled, movement beyond travel triggers a buzzer.
M8024 I372.5
M8024 T4
; ==================================
;
; Y maximum travel
M8025 I250
; ==================================
;
; Z maximum travel
M8026 I322
; ==================================
;
; Number of extruders. Minimum 1, maximum 3.
; Three-nozzle setups only support three-in-one-out.
M8027 I2
; ==================================
;
; Multi-in-one-out nozzle. These nozzles share a single temperature sensor and heating element.
; 0: Standard (not multi-in-one-out)    1: Multi-in-one-out
M8027 S0
; ==================================
; Multi-Y or multi-Z special function. Enable by ticking the box in front.
; 0: Dual Z, dual limit switches — second limit connected to X+
; 1: Dual Z, single limit switch — only one limit switch required
; 3: Triple Z — third Z axis connected to the EXT expansion port
M8027 Z0
; ==================================
;
; Use second extruder E2 as Y axis. Enable by ticking the box in front.
;M8027 Y0
; ==================================
;
; Use second extruder E2 as first extruder E1. Enable by ticking the box in front.
;M8027 E0
; ==================================
;
; Enable or disable the heated bed.
; 1: Enable    0: Disable
M8027 T1
; ==================================
;
; Advanced settings.
; Retraction compensation. After retraction and re-extrusion, elasticity causes a slight extra retraction.
; Leave at 0 if unsure.
M8028 S0.00
; ==================================
; XY limit switch position type.
; 0: Single-side zero limit (front left) — e.g. Mendel, i3
; 1: Single-side maximum limit (rear right) — e.g. Makerbot
; 2: Bilateral limit — e.g. Ultimaker (mini board has only 3 XYZ limits; do not use this option)
; 3: Rear left limit (rare)    4: Front right limit (rare)
M8029 I0
; ==================================
; XYZ limit switch wiring type. If configured incorrectly, the motor will be unable to move in one direction and the buzzer will sound.
; Simple check: buzzer sounds when limit is triggered; silent when released. If reversed, change this parameter.
; 0: Normally open (high when not triggered, low when triggered)
; 1: Normally closed (low when not triggered, high when triggered)
M8029 T0
; ==================================
; Z axis limit switch position.
; 0: Triggered when extruder is closest to the bed — limit connected to Z-
; 1: Triggered when extruder is farthest from the bed — limit connected to Z+
M8029 S1
; ==================================
; Whether XYZ axes return to (0,0,0) after homing. XYZ and H-bot machines only.
; 0: Return to (0,0,0) — print head moves to front-left of the bed
; 1: Stay at the limit position
M8029 C1
; ==================================
;
; Filament runout sensor. Limit connected to the corresponding extruder limit port (E1 or E2).
; 0: Disable    1: Enable
M8029 D1
; ==================================
;
; Filament runout sensor limit switch type for E1 and E2 ports.
; 1: Same type as XYZ limits    -1: Opposite type to XYZ limits
M8029 E-1
M8029 P-1
; ==================================
; Part cooling fan control. This fan cools the printed model.
; Recommended: let the slicer control fan on/off.
; >0: Fan turns on automatically when extruder exceeds this temperature.
;  0: Fan controlled by slicing software.
M8030 I0
; ==================================
; Hotend throat (heatsink) fan control. This fan cools the nozzle throat.
; Auto-start temperature must be set after the M8030 I0 command.
; Value after I = threshold temperature. At 0: fan does not respond to temperature.
; Otherwise: fan turns on when extruder reaches the specified temperature.
M8030 I50 T-1
; ==================================
;
; Second extruder (right extruder) offset (mm). Ignored for single-extruder setups.
; In Cura, set dual extruder offset to 0.
; X direction offset (left/right)
M8031 S-35
; ==================================
;
; Y direction offset (front/rear)
M8032 S0
; ==================================
;
; SD card folder support.
; 0: Not supported    1: Supported
M8034 I1
; ==================================
; Leveling test points. Up to 5 points. X and Y are floating-point numbers.
; If both X and Y are less than 1, values are treated as proportions of total travel.
; Otherwise treated as absolute coordinates in mm.
; Example: with 200×200 travel, M8036 X0.1 Y0.1 equals M8036 X20 Y20.
; Number of leveling points:
M8035 I3
; ==================================
;
; One M8036 command per leveling point for manual XYZ and delta leveling tests.
; For delta auto-leveling, only the first point is used — it represents the sensor offset
; from the nozzle center (positive = rear right). Other points are ignored.
M8036 X10 Y10
; ==================================
M8036 X320 Y10
; ==================================
M8036 X165 Y240
; ==================================
M8036 X0.2 Y0.8
; ==================================
; Temperature sensor type. Please set the correct type.
; Readings can differ by up to 40°C depending on sensor type.
; 0: Ideal NTC 100K 1% 3950 B thermistor
; 1: K-type thermocouple
; 2: EPCOS NTC 100K 1% 3950 B — equivalent to Marlin sensor type 1; most common on the market
M8081 I1
; ==================================
; Enable auto-leveling.
; 0: Disable (XYZ structure falls back to semi-automatic leveling mode)
; 1: Allow auto-leveling
; For XYZ structure: connect leveling switch directly to Z-, remove the original limit switch,
; and use in conjunction with the M8084 Z* command.
;M8083 I1
; ==================================
; Servo deployment/retraction angles for auto-leveling.
; Only valid when auto-leveling is enabled.
; D = servo retracted angle, P = servo deployed angle.
; If both angles are equal, no servo support is assumed.
; Achievable angles depend on the specific servo; for 180° rotation servos, measured range is approx. -85° to 105°.
M8083 D0 P0

M8083 C-45.0 R372.0 ; C = left software limit position of X axis, R = right software limit position of X axis

; ==================================
; Z leveling limit offset — advanced parameter, do not change.
; Height difference of Z leveling limit = Z position at leveling trigger - Z zero position.
; 0: No offset. Z travel set by "Set Z to zero". G-code does not need auto-leveling commands. Recommended.
; Non-zero: Z position determined automatically when leveling limit triggers. For DELTA structure,
; G29 auto-leveling must follow G28 homing and precede all print commands.
; Positive value typical for optical sensors; negative if nozzle presses against the mainboard at trigger.
M8084 Z0.15
; ==================================
;
; Boot logo display duration. Minimum 100ms, maximum 6000ms.
M8085 I3000
; ==================================
;
; Screensaver timeout. Time before screensaver activates, in seconds (s).
; 0 = screensaver disabled.
M8085 T0
; ==================================
; Standby auto-shutdown. Requires shutdown-after-print hardware module.
; Time before machine shuts down, in seconds (s).
; 0 = standby shutdown disabled.
M8085 P0
; ==================================
; Software microstepping divisor — do not change.
; For users with 0.9° step angle motors or external 32-subdivision drivers
; who want to emulate 1.8° / 16-subdivision behavior: set to 2. Default = 1 (no division).
M8086 I1
; ==================================
;
; Motor current settings. S = driver current in mA. Recommended range: 200–1500mA (max 2000mA).
; Add a cooling fan if exceeding 1000mA.
; ------ X motor current — S = driver current in mA ------
M8091 I0 S650 P3 D3 C5 R6 F5 T0
; ==================================
;
; ------ Y motor current — S = driver current in mA ------
M8091 I1 S650 P3 D3 C5 R6 F5 T0
; ==================================
;
; ------ Z motor current — S = driver current in mA ------
M8091 I2 S325 P3 D3 C5 R6 F5 T0
; ==================================
;
; ------ E motor current — S = driver current in mA ------
M8091 I3 S650 P3 D3 C5 R6 F5 T0
; ==================================
;
; ------ E2 motor current — S = driver current in mA ------
M8091 I4 S650 P3 D3 C5 R6 F5 T0
; ==================================
;
; ------ EXT motor current — S = driver current in mA ------
M8091 I5 S800 P3 D3 C5 R6 F5 T0
; ==================================
;
; ------ Z2 motor current — S = driver current in mA ------
M8091 I6 S325 P3 D3 C5 R6 F5 T0
; ==================================

M8092 I0
; Mainboard fan auto-start PWM ratio. Maximum is 256.
; Some mainboard fans are loud at full power — reduce this value to lower fan speed and noise.
M8489 I230
; ==================================
; Filament interface extrusion speed (mm/s).
; If too fast, the feeder cannot keep up, causing under-extrusion and lost steps.
M8489 T2
; ==================================
; Action after print completes.
; 0: Turn off all motors and heaters
; 1: No action — follow G-code instructions entirely
; 2: Home all axes after printing, keep motors powered
; 3: Drop to maximum Z travel after printing, keep motors powered
; 4: Wait until nozzle 1 cools to 50°C before signaling print complete
M8489 P0
; ==================================
; Temperature PID parameters. [Reference: M301 P18 I1.08 D98]
; If your temperature control is stable and you are not an expert, leave this alone.
; Tick the box in front before configuring.
M301 P10.9 I0.22 D180
M302 P10.9 I0.22 D180
; ==================================
;
; 1: Enable laser engraving configuration
; 0: Disable — laser speed is set via the "More" button
M8520 I0
; ==================================
; Initial heated enclosure temperature setting.
M8525 I80
;
; Popup warning for insufficient heating power or non-functional temperature sensor.
; 1: Enable warning    0: Disable warning
M8525 T1

; ==================================

; 1: Enable filament runout detection display
; 0: Disable filament runout detection display
M8528 I1

M8100 D-9.5  ; X coordinate after homing
M8100 P0     ; Y coordinate after homing

M8529 I255 T255
; I = MB_FAN PWM frequency for extruder 1
; T = MB_FAN PWM frequency for extruder 2

M8101 D3 P25
; D = temperature change detection interval (checks every 3 seconds)
; P = total temperature warning duration (alarm if bed doesn't reach 40°C or nozzle 140°C within 25 seconds)

M304 P71.039 I2.223 D567.421  ; Heated bed temperature PID parameters
M8600 I1  ; 1 = enable bed PID, 0 = disable bed PID

M8530 I1  ; Extruder temperature during pause: 1 = lower temp on pause, 0 = keep temp on pause

; SAVE PARAMETERS — mandatory. Without this, no settings are saved to the device.
M8500

M7507 I1 T0
; Original author: @sudtek
