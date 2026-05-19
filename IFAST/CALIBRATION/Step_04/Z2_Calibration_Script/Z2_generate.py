#!/usr/bin/env python3
#
# 31/10/2024 (DD/MM/YYYY)
# Script name: Z2_generate.py
# Version: V01
# Python interpreter version: 3.7.0 64-bit
#
# Description: Interactive script that generates a custom .gcode file for characterizing
# the flow rate % of a filament on Z2 (left nozzle) of a QIDI IFAST dual 3D printer.
# It generates 11 hollow 20x20x20mm cubes in a row, labeled A to K, with decreasing
# flow rates from left to right in constant steps of -0.1% or -1%.
# This allows characterizing a new filament without having to edit the source file
# in IdeaMaker and regenerate the G-code.
# The read-only template file "26_10_2024_Z2_Calibration_[X%..Y%]_Step_N%_TEMPLATE_01.gcode"
# must be in the same directory as this script.
#
# Yannick SUDRIE

import os
import platform
from datetime import datetime

def cls():
    if platform.system() == "Windows":
        os.system('cls')
    else:
        os.system('clear')

def resume():
        while True:
            keyPressed = input(f"\n Press (C) to continue or (X) to quit! ")
            if (keyPressed.upper() == "C"):
                break
            if (keyPressed.upper() == "X"):
                exit(1)


# TEMPLATE file variable — used to search and replace values
TEMPLATE_FILE = "26_10_2024_Z2_Calibration_[X%..Y%]_Step_N%_TEMPLATE_01.gcode"
# Check if the template file exists in the current directory
if not os.path.isfile(TEMPLATE_FILE):
    print(f"Template file '{TEMPLATE_FILE}' was not found or is missing!")
    exit(1)

# 3D PRINTER INFO VARIABLES
PRINTER3D_BRAND = "QIDI"
PRINTER3D_MODEL = "IFAST"
PRINTER3D_SPEC = "Dual extrusion type (not IDEX)"

# INFO / PRESENTATION / USAGE / USER VARIABLES
PRESENTATION = "\n This interactive script uses 16 questions to generate a custom .gcode file for characterizing your filament on the " + PRINTER3D_BRAND + " " + PRINTER3D_MODEL + " " + PRINTER3D_SPEC + " 3D printer."
INFORMATION = " \n It is only usable for characterizing the filament on the left nozzle Z2. \n The reference wall thickness for the cubes is 1.6mm (0.4mm x 4 shells)."
USAGE = " \n Refer to the usage tutorial at: https://github.com/sudtek/IMPRIMANTES_3D/tree/35fbb7b4d120f7a413834af2183f85b400363702/QIDI/IFAST/CALIBRATION/Etape%2004"

cls()  # Clear the terminal / console

print(PRESENTATION + INFORMATION + USAGE)

# VARIABLES
DEFAULT_GLOBAL_FLOW_RATE = 100.00  # 100.00%
DEFAULT_GLOBAL_FLOW_MAX = 200.00   # 200.00%
DEFAULT_GLOBAL_FLOW_MIN = 20.00    # 20.00%

# Z1 & Z2 nozzle info
DEFAULT_FILAMENT_DIAMETER = 1.750  # 1.750mm
DEFAULT_FILAMENT_DIAMETER_MAX = 2.5  # 2.5mm
DEFAULT_FILAMENT_DIAMETER_MIN = 1.0  # 1.0mm
DEFAULT_NOZZLE_TEMP_MAX = 300  # 300°C — note: standard PTFE tubes melt around 280°C
DEFAULT_NOZZLE_TEMP_MIN = 180  # 180°C — below 180°C materials cannot be extruded; head damage risk

# Right nozzle Z1 filament
FILAMENT_Z1_RIGHT_DIAMETER = DEFAULT_FILAMENT_DIAMETER  # 1.75mm
FILAMENT_Z1_RIGHT_TEMPERATURE = 205  # 205°C
FILAMENT_Z1_RIGHT_FLOW_RATE = 100.00  # !!!! Always 100% by default — do not change !!!!
FILAMENT_Z1_RIGHT_TYPE = "PLA"
FILAMENT_Z1_RIGHT_COLOR = "Purple"
FILAMENT_Z1_RIGHT_NAME = PRINTER3D_BRAND + "-" + PRINTER3D_MODEL + " " + FILAMENT_Z1_RIGHT_TYPE + " " + FILAMENT_Z1_RIGHT_COLOR  # e.g. QIDI-IFAST PLA Purple
FILAMENT_Z1_RIGHT_DENSITY = 1240.00   # density? or Young's modulus? — may need a question
FILAMENT_Z1_RIGHT_BRAND = "SUNLU"     # your default brand

# Left nozzle Z2 filament (the filament to characterize)
FILAMENT_Z2_LEFT_DIAMETER = DEFAULT_FILAMENT_DIAMETER  # 1.75mm
FILAMENT_Z2_LEFT_TEMPERATURE = 235  # 235°C
FILAMENT_Z2_LEFT_FLOW_RATE = 100.00  # !!!! Always 100% by default — do not change !!!!
FILAMENT_Z2_LEFT_TYPE = "PETG"
FILAMENT_Z2_LEFT_COLOR = "White"
FILAMENT_Z2_LEFT_NAME = PRINTER3D_BRAND + "-" + PRINTER3D_MODEL + " " + FILAMENT_Z2_LEFT_TYPE + " " + FILAMENT_Z2_LEFT_COLOR  # e.g. QIDI-IFAST PETG White
FILAMENT_Z2_LEFT_DENSITY = 1240.00   # density? or Young's modulus? — may need a question
FILAMENT_Z2_LEFT_BRAND = "SUNLU"     # your default brand

# Bed
DEFAULT_BED_TEMPERATURE = 65  # 65°C
BED_TEMPERATURE = DEFAULT_BED_TEMPERATURE  # Note: bed temperature depends on the filament being characterized — 65°C is the default for PETG
DEFAULT_BED_TEMPERATURE_MAX = 130  # 130°C
DEFAULT_BED_TEMPERATURE_MIN = 0    # 0°C — heated bed disabled

# Enclosure
DEFAULT_ENCLOSURE_TEMPERATURE = 40  # 40°C
ENCLOSURE_TEMPERATURE = DEFAULT_ENCLOSURE_TEMPERATURE  # Note: enclosure temperature depends on the filament — 40°C is the default for PETG
DEFAULT_ENCLOSURE_TEMPERATURE_MAX = 100  # 100°C
DEFAULT_ENCLOSURE_TEMPERATURE_MIN = 0    # 0°C — enclosure disabled

# Bed legend letters A to K in front of each cube
DEFAULT_LEGEND_FLOW_RATE = 100.0  # %
LEGEND_FLOW_RATE = DEFAULT_LEGEND_FLOW_RATE
DEFAULT_LEGEND_FLOW_MAX = 120.0  # %
DEFAULT_LEGEND_FLOW_MIN = 80.0   # %

# Purge tower before printing cubes A to K
DEFAULT_TOWER_FLOW_RATE = 100.0  # %
TOWER_FLOW_RATE = DEFAULT_TOWER_FLOW_RATE
DEFAULT_TOWER_FLOW_MAX = 120.0  # %
DEFAULT_TOWER_FLOW_MIN = 80.0   # %

# Cube series
DEFAULT_CUBES_FLOW_RATE = 100.0
CUBE_A_FLOW_RATE = DEFAULT_CUBES_FLOW_RATE  # Flow rate of the leftmost cube, label A
CUBE_K_FLOW_RATE = 0  # Flow rate of the rightmost cube, label K (do not change — initialized to 0)
DEFAULT_CUBES_FLOW_MAX = 120.0  # %
DEFAULT_CUBES_FLOW_MIN = 80.0   # %
CUBES_STEP_LIST = ["0.1", "1"]  # Step can only take two values from this list: 0.1 or 1

CUBE_LABELS = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"]  # Labels for the 11 cubes (do not change)

# We assume there are always exactly 11 hollow 20x20x20 cubes with no internal infill,
# arranged in a single row along the X axis (11C x 1L format, seen from the front).
# Cubes are ordered left to right in descending flow rate order.
# Since the legend labels may vary, it is more practical to use fixed letters
# rather than numbers. Examples:
# A series of 11 cubes from 91 to 90 in 0.1% steps: BOX_A=91.0; BOX_B=90.9; BOX_C=90.8 ... BOX_K=90.0
# A series of 11 cubes from 100 to 90 in 1% steps:  BOX_A=100.0; BOX_B=99.0; BOX_C=98.0 ... BOX_K=90.0


resume()  # Continue or quit?


# -------------------- START QUESTIONNAIRE ----------------------

# Ask the user to specify the STEP value
while True:
    step = input(f"\n Q1 / 16 -> Please specify the STEP value {CUBES_STEP_LIST[0]} or {CUBES_STEP_LIST[1]} (default 1%): ")
    if (step == ""):  # Load default value of 1%
        STEP = 1.0
        break

    if step in CUBES_STEP_LIST:
        STEP = float(step)
        break
    else:
        print(f"Invalid value. Please enter {CUBES_STEP_LIST[0]} or {CUBES_STEP_LIST[1]}!")
print(f"STEP value: {STEP}" + " %")

# Ask the user to specify the maximum flow rate for cube A (leftmost)
while True:
    cube_A_flow = input(f"\n Q2 / 16 -> Please specify a Maximum flow rate [{DEFAULT_CUBES_FLOW_MIN} .. {DEFAULT_CUBES_FLOW_MAX}]% for cube A (leftmost) (default {DEFAULT_CUBES_FLOW_RATE}%): ")
    if (cube_A_flow == ""):
        break  # Load default value
    if ((float(cube_A_flow) >= DEFAULT_CUBES_FLOW_MIN) and (float(cube_A_flow) <= DEFAULT_CUBES_FLOW_MAX)):
        CUBE_A_FLOW_RATE = round(float(cube_A_flow), 1)  # Use rounded values only, e.g. 100.0%, 99.1%, 89.5%
        break
    else:
        print(f"Invalid value. Please enter a flow rate [{DEFAULT_CUBES_FLOW_MIN} .. {DEFAULT_CUBES_FLOW_MAX}]%!")
print(f"\n Maximum flow rate for cube A (leftmost): {CUBE_A_FLOW_RATE}%")

# The minimum flow rate for cube K (rightmost) is calculated automatically!
# Example: for CUBE_A_FLOW_RATE of 100%, CUBE_K_FLOW_RATE = 90% if step = 1%, or 99% if step = 0.1%
CUBE_K_FLOW_RATE = CUBE_A_FLOW_RATE - (10.0 * STEP)
print(f"\n Minimum flow rate for cube K (rightmost): {CUBE_K_FLOW_RATE}%")

# ------------------------------------------------------------------------------------------------------------------------

# ----- Z1 filament -----

# Ask the user to specify the Z1 filament diameter
while True:
    FZ1_diameter = input(f"\n Q3 / 16 -> Nozzle Z1 (RIGHT) Please specify the filament diameter (default {DEFAULT_FILAMENT_DIAMETER} mm): ")
    if (FZ1_diameter == ""):
        break  # Load default value
    if (float(FZ1_diameter) >= DEFAULT_FILAMENT_DIAMETER_MIN) and (float(FZ1_diameter) <= DEFAULT_FILAMENT_DIAMETER_MAX):
        FILAMENT_Z1_RIGHT_DIAMETER = float(FZ1_diameter)
        break
    else:
        print(f"Invalid value. Please enter a diameter between [{DEFAULT_FILAMENT_DIAMETER_MIN} .. {DEFAULT_FILAMENT_DIAMETER_MAX}] mm!")
print(f"Z1 filament diameter: {FILAMENT_Z1_RIGHT_DIAMETER} mm")


# Ask the user to specify the Z1 filament temperature
while True:
    FZ1_temperature = input(f"\n Q4 / 16 -> Nozzle Z1 (RIGHT) Please specify the filament temperature [{DEFAULT_NOZZLE_TEMP_MIN} .. {DEFAULT_NOZZLE_TEMP_MAX}]°C (default {FILAMENT_Z1_RIGHT_TEMPERATURE}°C): ")
    if (FZ1_temperature == ""):
        break  # Load default value
    if (int(FZ1_temperature) >= int(DEFAULT_NOZZLE_TEMP_MIN)) and (int(FZ1_temperature) <= int(DEFAULT_NOZZLE_TEMP_MAX)):
        FILAMENT_Z1_RIGHT_TEMPERATURE = int(FZ1_temperature)
        break
    else:
        print(f"Invalid value. Please enter a temperature between [{DEFAULT_NOZZLE_TEMP_MIN} .. {DEFAULT_NOZZLE_TEMP_MAX}]°C!")
print(f"Z1 filament temperature: {FILAMENT_Z1_RIGHT_TEMPERATURE}°C")


# Ask the user to specify the Z1 filament material type
while True:
    FZ1_type = input("\n Q5 / 16 -> Nozzle Z1 (RIGHT) Please specify the filament material, e.g. PLA, ...: ")
    if (FZ1_type == ""):
        break  # Load default value -> PLA
    if not (FZ1_type == ""):
        FILAMENT_Z1_RIGHT_TYPE = FZ1_type
        break
    else:
        print("Invalid value. Please specify the filament material, e.g. PLA, PETG, ...!")
print(f"Z1 filament material: {FILAMENT_Z1_RIGHT_TYPE}")


# Ask the user to specify the Z1 filament color
while True:
    FZ1_color = input("\n Q6 / 16 -> Nozzle Z1 (RIGHT) Please specify the filament color, e.g. White, Purple, ...: ")
    if (FZ1_color == ""):
        break  # Load default value -> Purple
    if not (FZ1_color == ""):
        FILAMENT_Z1_RIGHT_COLOR = FZ1_color
        break
    else:
        print("Invalid value. Please specify the filament color, e.g. White, Purple, ...!")
print(f"Z1 filament color: {FILAMENT_Z1_RIGHT_COLOR}")


# Ask the user to specify the Z1 filament brand
while True:
    FZ1_brand = input("\n Q7 / 16 -> Nozzle Z1 (RIGHT) Please specify the filament brand, e.g. Sunlu, ...: ")
    if (FZ1_brand == ""):
        break  # Load default value -> Sunlu
    if not (FZ1_brand == ""):
        FILAMENT_Z1_RIGHT_BRAND = FZ1_brand
        break
    else:
        print("Invalid value. Please specify the filament brand, e.g. Noname, Sunlu, ...!")
print(f"Z1 filament brand: {FILAMENT_Z1_RIGHT_BRAND}")


# ------------------------------------------------------------------------------------------------------------------------

# ----- Z2 filament -----

# Ask the user to specify the Z2 filament diameter
while True:
    FZ2_diameter = input(f"\n Q8 / 16 -> Nozzle Z2 (LEFT) Please specify the filament diameter (default {DEFAULT_FILAMENT_DIAMETER} mm) (REQUIRED): ")
    # if (FZ2_diameter == ""): break  # Load default value
    # WARNING: The actual diameter of the filament to characterize MUST be specified! (kept for reference)
    if (FZ2_diameter == ""):
        FZ2_diameter = 0.0
    if (float(FZ2_diameter) >= DEFAULT_FILAMENT_DIAMETER_MIN) and (float(FZ2_diameter) <= DEFAULT_FILAMENT_DIAMETER_MAX):
        FILAMENT_Z2_LEFT_DIAMETER = float(FZ2_diameter)
        break
    else:
        print(f"Invalid value. Please enter a diameter [{DEFAULT_FILAMENT_DIAMETER_MIN} .. {DEFAULT_FILAMENT_DIAMETER_MAX}] mm!")
print(f"Z2 filament diameter: {FILAMENT_Z2_LEFT_DIAMETER} mm")


# Ask the user to specify the Z2 filament temperature
while True:
    FZ2_temperature = input(f"\n Q9 / 16 -> Nozzle Z2 (LEFT) Please specify the filament temperature [{DEFAULT_NOZZLE_TEMP_MIN} .. {DEFAULT_NOZZLE_TEMP_MAX}]°C (default {FILAMENT_Z2_LEFT_TEMPERATURE}°C) (REQUIRED): ")
    if (FZ2_temperature == ""):
        break  # Load default value
    if (int(FZ2_temperature) >= DEFAULT_NOZZLE_TEMP_MIN) and (int(FZ2_temperature) <= DEFAULT_NOZZLE_TEMP_MAX):
        FILAMENT_Z2_LEFT_TEMPERATURE = int(FZ2_temperature)
        break
    else:
        print(f"Invalid value. Please enter a filament temperature between [{DEFAULT_NOZZLE_TEMP_MIN} .. {DEFAULT_NOZZLE_TEMP_MAX}]°C!")
print(f"Z2 filament temperature: {FILAMENT_Z2_LEFT_TEMPERATURE}°C")


# Ask the user to specify the Z2 filament material type
while True:
    FZ2_type = input("\n Q10 / 16 -> Nozzle Z2 (LEFT) Please specify the filament material, e.g. PETG, ABS, ... (REQUIRED): ")
    if (FZ2_type == ""):
        break  # Load default value -> PETG
    if not (FZ2_type == ""):
        FILAMENT_Z2_LEFT_TYPE = FZ2_type
        break
    else:
        print("Invalid value. Please specify the filament material, e.g. PLA, PETG, ...:")
print(f"Z2 filament material: {FILAMENT_Z2_LEFT_TYPE}")


# Ask the user to specify the Z2 filament color
while True:
    FZ2_color = input("\n Q11 / 16 -> Nozzle Z2 (LEFT) Please specify the filament color, e.g. White, Purple (REQUIRED): ")
    if (FZ2_color == ""):
        break  # Load default value -> White
    if not (FZ2_color == ""):
        FILAMENT_Z2_LEFT_COLOR = FZ2_color
        break
    else:
        print("Invalid value. Please specify the filament color, e.g. White, Purple, ...!")
print(f"Z2 filament color: {FILAMENT_Z2_LEFT_COLOR}")

# Ask the user to specify the Z2 filament brand
while True:
    FZ2_brand = input("\n Q12 / 16 -> Nozzle Z2 (LEFT) Please specify the filament brand, e.g. Sunlu, ...: ")
    if (FZ2_brand == ""):
        break  # Load default value -> Sunlu
    if not (FZ2_brand == ""):
        FILAMENT_Z2_LEFT_BRAND = FZ2_brand
        break
    else:
        print("Invalid value. Please specify the filament brand, e.g. Noname, Sunlu, ...!")
print(f"Z2 filament brand: {FILAMENT_Z2_LEFT_BRAND}")
# ------------------------------------------------------------------------------------------------------------------------


# Ask the user to specify the bed temperature for printing via Z2
while True:
    bed_temperature = input(f"\n Q13 / 16 -> Please specify the bed temperature [{DEFAULT_BED_TEMPERATURE_MIN} .. {DEFAULT_BED_TEMPERATURE_MAX}]°C — NOTE: depends on the filament being characterized (default {BED_TEMPERATURE}°C) (REQUIRED): ")
    if (bed_temperature == ""):
        break  # Load default value of 65°C
    if (int(bed_temperature) >= DEFAULT_BED_TEMPERATURE_MIN) and (int(bed_temperature) <= DEFAULT_BED_TEMPERATURE_MAX):
        BED_TEMPERATURE = int(bed_temperature)
        break
    else:
        print(f"Invalid value. Please enter a temperature between [{DEFAULT_BED_TEMPERATURE_MIN}°C .. {DEFAULT_BED_TEMPERATURE_MAX}°C]!")
print(f"Bed temperature: {BED_TEMPERATURE}°C for printing {FILAMENT_Z2_LEFT_TYPE} {FILAMENT_Z2_LEFT_COLOR} at {FILAMENT_Z2_LEFT_TEMPERATURE}°C!")
# -------------------------------------------------------------------------------------------------------------------------


# Ask the user to specify the enclosure temperature for printing via Z2
# Note: To guard against winter/summer ambient temperature fluctuations,
# it is preferable to always print at a minimum enclosure temperature of 40°C.
while True:
    enclosure_temperature = input(f"\n Q14 / 16 -> Please specify the enclosure (chamber) temperature [{DEFAULT_ENCLOSURE_TEMPERATURE_MIN} .. {DEFAULT_ENCLOSURE_TEMPERATURE_MAX}]°C — NOTE: depends on the filament being characterized (default {ENCLOSURE_TEMPERATURE}°C) (REQUIRED): ")
    if (enclosure_temperature == ""):
        break  # Load default value of 40°C
    if (int(enclosure_temperature) >= 0) and (int(enclosure_temperature) <= 130):
        ENCLOSURE_TEMPERATURE = int(enclosure_temperature)
        break
    else:
        print(f"Invalid value. Please enter a temperature between [{DEFAULT_ENCLOSURE_TEMPERATURE_MIN} .. {DEFAULT_ENCLOSURE_TEMPERATURE_MAX}]°C!")
print(f"Enclosure temperature: {ENCLOSURE_TEMPERATURE}°C for printing {FILAMENT_Z2_LEFT_TYPE} {FILAMENT_Z2_LEFT_COLOR} at {FILAMENT_Z2_LEFT_TEMPERATURE}°C!")
# -------------------------------------------------------------------------------------------------------------------------


# Ask the user to specify the flow rate for printing the bed legend (letters A to K) via Z2
while True:
    legend_flow = input(f"\n Q15 / 16 -> Please specify a flow rate [{DEFAULT_LEGEND_FLOW_MIN} .. {DEFAULT_LEGEND_FLOW_MAX}]% for the cube legend on the bed (default {DEFAULT_LEGEND_FLOW_RATE}%): ")
    if (legend_flow == ""):
        break  # Load default value
    if ((float(legend_flow) >= DEFAULT_LEGEND_FLOW_MIN) and (float(legend_flow) <= DEFAULT_LEGEND_FLOW_MAX)):
        LEGEND_FLOW_RATE = round(float(legend_flow), 1)  # Use rounded values only
        break
    else:
        print(f"Invalid value. Please enter a flow rate [{DEFAULT_LEGEND_FLOW_MIN}% .. {DEFAULT_LEGEND_FLOW_MAX}%]!")
print(f"Flow rate for bed legend: {LEGEND_FLOW_RATE}%")
# -------------------------------------------------------------------------------------------------------------------------


# Ask the user to specify the flow rate for printing the purge tower
while True:
    tower_flow = input(f"\n Q16 / 16 -> Please specify a flow rate [{DEFAULT_TOWER_FLOW_MIN} .. {DEFAULT_TOWER_FLOW_MAX}]% for the purge tower on the bed (default {DEFAULT_TOWER_FLOW_RATE}%): ")
    if (tower_flow == ""):
        break  # Load default value
    if ((float(tower_flow) >= DEFAULT_TOWER_FLOW_MIN) and (float(tower_flow) <= DEFAULT_TOWER_FLOW_MAX)):
        TOWER_FLOW_RATE = round(float(tower_flow), 1)  # Use rounded values only
        break
    else:
        print(f"Invalid value. Please enter a flow rate [{DEFAULT_TOWER_FLOW_MIN} .. {DEFAULT_TOWER_FLOW_MAX}]%!")
print(f"Flow rate for purge tower: {TOWER_FLOW_RATE}%")
# -------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------

# ------ Output summary ------

cls()  # Clear the terminal / console

# Summarize data for the user before generating the output file
print(f"Z1 (RIGHT): No objects will be printed with filament {FILAMENT_Z1_RIGHT_BRAND} {FILAMENT_Z1_RIGHT_TYPE} {FILAMENT_Z1_RIGHT_COLOR}, nominal diameter {FILAMENT_Z1_RIGHT_DIAMETER} mm at {FILAMENT_Z1_RIGHT_TEMPERATURE}°C\n")
print(f"Z2 (LEFT): Objects to print with filament {FILAMENT_Z2_LEFT_BRAND} {FILAMENT_Z2_LEFT_TYPE} {FILAMENT_Z2_LEFT_COLOR}, nominal diameter {FILAMENT_Z2_LEFT_DIAMETER} mm at {FILAMENT_Z2_LEFT_TEMPERATURE}°C:")
print(f"- 11 cubes labeled A (flow rate: {CUBE_A_FLOW_RATE}%) to K (flow rate: {CUBE_K_FLOW_RATE}%) in decreasing steps of -{STEP}%.")
print(f"- Bed legend A to K flow rate: {LEGEND_FLOW_RATE}%")
print(f"- Purge tower flow rate: {TOWER_FLOW_RATE}%")
print(f"- Bed temperature: {BED_TEMPERATURE}°C")
print(f"- Enclosure temperature: {ENCLOSURE_TEMPERATURE}°C")

resume()  # Continue or quit?


# ------ Output file ------

# Ask the user to use an automatic filename OR specify a custom one

# Generate an automatic output filename
# Example format: 31_10_2024_Z2_Calibration_[100%..90%]_Step_1%_PETG_White_SUNLU_235°c_1.724mm
NOW = datetime.now()
DATE_TODAY = NOW.strftime("%d_%m_%Y_")
AUTO_FILENAME = DATE_TODAY + "Z2_Calibration_[" + str(CUBE_A_FLOW_RATE) + "%.." + str(CUBE_K_FLOW_RATE) + "%]_Step_-" + str(STEP) + "%_" + str(FILAMENT_Z2_LEFT_TYPE) + "_" + str(FILAMENT_Z2_LEFT_COLOR) + "_" + str(FILAMENT_Z2_LEFT_BRAND) + "_" + str(FILAMENT_Z2_LEFT_TEMPERATURE) + "°c_" + str(FILAMENT_Z2_LEFT_DIAMETER) + "mm"
print(f"\n Suggested output filename: {AUTO_FILENAME}")

NEW_FILENAME = AUTO_FILENAME

while True:
    keyPressed = input(f"\n Press (C) to continue and use the filename {NEW_FILENAME} \n OR \n Press (S) to enter a custom filename (without the .gcode extension)! ")
    if (keyPressed.upper() == "C"):
        break
    if (keyPressed.upper() == "S"):
        while True:
            custom_filename = input("\n Please specify the output filename (without extension): ")
            if (not(custom_filename == "") or ("{custom_filename}" + ".gcode" == TEMPLATE_FILE)):
                NEW_FILENAME = custom_filename
                break
            else:
                ("Invalid or missing filename!")

print(f"\n New file will be named: {NEW_FILENAME}")

# ------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------

# -------------------- END QUESTIONNAIRE ----------------------


# -------------------- START TEXT BLOCK REPLACEMENTS --------------------

# BLOCK_FILAMENT_INFO — to replace in the template
# NBoccurrences = 1
block_filament_info = f"""
;Filament Diameter #1: {FILAMENT_Z1_RIGHT_DIAMETER}
;Filament Diameter #2: {FILAMENT_Z2_LEFT_DIAMETER}
;Filament Compensation #1: {FILAMENT_Z1_RIGHT_FLOW_RATE}
;Filament Compensation #2: {FILAMENT_Z2_LEFT_FLOW_RATE}
;Filament Type #1: {FILAMENT_Z2_LEFT_TYPE}
;Filament Type #2: {FILAMENT_Z1_RIGHT_TYPE}
;Filament Density #1: {FILAMENT_Z2_LEFT_DENSITY}
;Filament Density #2: {FILAMENT_Z1_RIGHT_DENSITY}
;Filament Name #1: {FILAMENT_Z2_LEFT_NAME}
;Filament Name #2: {FILAMENT_Z1_RIGHT_NAME}
"""
# --------------------

# BLOCK_BED_TEMPERATURE — to replace in the template
# NBoccurrences = 1
block_bed_temperature = f"""
M190 S{BED_TEMPERATURE}
"""
# --------------------

# BLOCK_FILAMENT_TEMPERATURES — to replace in the template
# NBoccurrences = 1
block_filament_temperatures = f"""
M104 T0 S205
M109 T1 S{FILAMENT_Z2_LEFT_TEMPERATURE}
M109 T0 S205
"""
# --------------------

# BLOCK_ENCLOSURE_TEMPERATURE
# NBoccurrences = 1
block_enclosure_temperature = f"""
;The temperature of the chamber is set to {ENCLOSURE_TEMPERATURE} degrees celsius
M141 S{ENCLOSURE_TEMPERATURE}
"""
# --------------------

# BLOCK_LEFT_FILAMENT_TEMPERATURE
# NBoccurrences = 13
block_left_filament_temperature = f"""
M104 T1 S{FILAMENT_Z2_LEFT_TEMPERATURE}
"""
# --------------------

# BLOCK_FLOW_RATE_CUBE_A_to_K_LEFT_FILAMENT
flow_temp = CUBE_A_FLOW_RATE
# Dictionary to store flow rate blocks
flow_blocks = {}
for cube in CUBE_LABELS:
    # print(f"Generating G-code commands for cube {cube} {round(flow_temp,1)}%")  # DEBUG
    # print(f"Generating G-code commands for cube {cube} {flow_temp}%")  # DEBUG
    # Example G-code command for each cube
    flow_blocks[f"BLOCK_FLOW_RATE_CUBE_{cube}_LEFT_FILAMENT"] = f"""M221 T1 S{flow_temp}"""
    flow_temp = round((flow_temp - STEP), 1)  # round() prevents cumulative floating-point mantissa drift with 0.1% step

    # Without round(VAR,1), the mantissa degrades with successive 0.1% subtractions:
    """
    BLOCK_LEFT_FILAMENT_TEMPERATURE: M104 T1 S235
    BLOCK_FLOW_RATE_CUBE_A_LEFT_FILAMENT: M221 T1 S92.0
    BLOCK_FLOW_RATE_CUBE_B_LEFT_FILAMENT: M221 T1 S91.9
    BLOCK_FLOW_RATE_CUBE_C_LEFT_FILAMENT: M221 T1 S91.80000000000001
    BLOCK_FLOW_RATE_CUBE_D_LEFT_FILAMENT: M221 T1 S91.70000000000002
    BLOCK_FLOW_RATE_CUBE_E_LEFT_FILAMENT: M221 T1 S91.60000000000002
    BLOCK_FLOW_RATE_CUBE_F_LEFT_FILAMENT: M221 T1 S91.50000000000003
    BLOCK_FLOW_RATE_CUBE_G_LEFT_FILAMENT: M221 T1 S91.40000000000003
    BLOCK_FLOW_RATE_CUBE_H_LEFT_FILAMENT: M221 T1 S91.30000000000004
    BLOCK_FLOW_RATE_CUBE_I_LEFT_FILAMENT: M221 T1 S91.20000000000005
    BLOCK_FLOW_RATE_CUBE_J_LEFT_FILAMENT: M221 T1 S91.10000000000005
    """
    # With round(VAR,1), mantissa stays clean:
    """
    BLOCK_LEFT_FILAMENT_TEMPERATURE: M104 T1 S235
    BLOCK_FLOW_RATE_CUBE_A_LEFT_FILAMENT: M221 T1 S92.0
    BLOCK_FLOW_RATE_CUBE_B_LEFT_FILAMENT: M221 T1 S91.9
    BLOCK_FLOW_RATE_CUBE_C_LEFT_FILAMENT: M221 T1 S91.8
    BLOCK_FLOW_RATE_CUBE_D_LEFT_FILAMENT: M221 T1 S91.7
    BLOCK_FLOW_RATE_CUBE_E_LEFT_FILAMENT: M221 T1 S91.6
    BLOCK_FLOW_RATE_CUBE_F_LEFT_FILAMENT: M221 T1 S91.5
    BLOCK_FLOW_RATE_CUBE_G_LEFT_FILAMENT: M221 T1 S91.4
    BLOCK_FLOW_RATE_CUBE_H_LEFT_FILAMENT: M221 T1 S91.3
    BLOCK_FLOW_RATE_CUBE_I_LEFT_FILAMENT: M221 T1 S91.2
    BLOCK_FLOW_RATE_CUBE_J_LEFT_FILAMENT: M221 T1 S91.1
    """
# --------------------

# BLOCK_FLOW_RATE_LEGEND_LEFT_FILAMENT
# Block_letter_series_A_to_K.stl
# NBoccurrences = 10
block_flow_rate_legend_left = f"""
M221 T1 S{LEGEND_FLOW_RATE}
"""
# --------------------

# BLOCK_FLOW_RATE_PURGE_TOWER_LEFT_FILAMENT
# Block_PURGE_TOWER.3mf
# NBoccurrences = 10
block_flow_rate_purge_tower_left = f"""
M221 T1 S{TOWER_FLOW_RATE}
"""
# --------------------

# -----------------------------------------------------------------------------------------------------
# -----------------------------------------------------------------------------------------------------


# -------------------- START SEARCH AND REPLACE IN FILE -------------------
# Read the template file
with open(TEMPLATE_FILE, 'r') as aFile:
    content = aFile.read()

# Replace BLOCK_FILAMENT_INFO with the text block
print(f"BLOCK_FILAMENT_INFO: \n {block_filament_info.strip()}")  # DEBUG
content = content.replace("BLOCK_FILAMENT_INFO", block_filament_info.strip())

# Replace BLOCK_BED_TEMPERATURE with the text block
print(f"\n BLOCK_BED_TEMPERATURE: {block_bed_temperature.strip()}")  # DEBUG
content = content.replace("BLOCK_BED_TEMPERATURE", block_bed_temperature.strip())

# Replace BLOCK_FILAMENT_TEMPERATURES with the text block
print(f"\n BLOCK_FILAMENT_TEMPERATURES: \n {block_filament_temperatures.strip()}")  # DEBUG
content = content.replace("BLOCK_FILAMENT_TEMPERATURES", block_filament_temperatures.strip())

# Replace BLOCK_ENCLOSURE_TEMPERATURE with the text block
print(f"\n BLOCK_ENCLOSURE_TEMPERATURE: \n {block_enclosure_temperature.strip()}")  # DEBUG
content = content.replace("BLOCK_ENCLOSURE_TEMPERATURE", block_enclosure_temperature.strip())

# Replace BLOCK_LEFT_FILAMENT_TEMPERATURE with the text block
print(f"\n BLOCK_LEFT_FILAMENT_TEMPERATURE: {block_left_filament_temperature.strip()}")  # DEBUG
content = content.replace("BLOCK_LEFT_FILAMENT_TEMPERATURE", block_left_filament_temperature.strip())

# Replace each BLOCK_FLOW_RATE_CUBE_?_LEFT_FILAMENT with the corresponding text block
for cube, block in flow_blocks.items():
    print(f"\n {cube}: {block}")  # Display flow rate blocks for verification
    content = content.replace(cube, block.strip())

# Replace BLOCK_FLOW_RATE_LEGEND_LEFT_FILAMENT with the text block
print(f"\n BLOCK_FLOW_RATE_LEGEND_LEFT_FILAMENT: {block_flow_rate_legend_left.strip()}")  # DEBUG
content = content.replace("BLOCK_FLOW_RATE_LEGEND_LEFT_FILAMENT", block_flow_rate_legend_left.strip())

# Replace BLOCK_FLOW_RATE_PURGE_TOWER_LEFT_FILAMENT with the text block
print(f"\n BLOCK_FLOW_RATE_PURGE_TOWER_LEFT_FILAMENT: {block_flow_rate_purge_tower_left.strip()}")  # DEBUG
content = content.replace("BLOCK_FLOW_RATE_PURGE_TOWER_LEFT_FILAMENT", block_flow_rate_purge_tower_left.strip())

# -----------------------------------------------------------------------------------------------------
# -----------------------------------------------------------------------------------------------------


# -------------------- SAVE OUTPUT FILE --------------------

# Create the new file
new_file = f"{NEW_FILENAME}.gcode"
with open(new_file, 'w') as f:
    print("DONE!")
    f.write(content)


print(f"\n New file '{new_file}' created successfully!")

# -----------------------------------------------------------------------------------------------------
# -----------------------------------------------------------------------------------------------------

# Original author: @sudtek
