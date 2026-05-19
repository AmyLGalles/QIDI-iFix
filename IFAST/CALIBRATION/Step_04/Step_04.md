# Step 04: Determining the Flow Rate % Based on Filament Diameter

## Prerequisites before continuing
You must have completed the following steps for the QIDI IFAST:
- [Step 00: Dual nozzle alignment / XY calibration](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2000/Etape_00.md)
- [Step 01: Calibrating the two extruder motors Z1 / Z2](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2001/Etape_01.md)
- [Step 03: Filament diameter calibration](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2003/Etape_03.md)

_Note 05/10/2024: A new method for determining flow rate % no longer requires IdeaMaker. A Python script is used to generate a custom G-code file for characterizing filaments on the Z2 nozzle._

## Overview
This tutorial details step by step the method for determining and bracketing the optimal flow rate percentage for a filament, in order to achieve prints with greater dimensional accuracy. The process includes all source files needed to generate calibration cubes at variable flow rates, precise wall thickness measurements, and data analysis to determine the optimal flow rate for a given filament.

Example in IdeaMaker slicer:

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/527fa37f381f61b011b10b9d9b2914b11b05b939/QIDI/IFAST/CALIBRATION/Etape%2004/media/IDEAMAKER_profil_petg_01.png)

To determine the exact flow rate percentage for a given filament (highlighted in red), the filament diameter (for example 1.724mm, highlighted in orange) must have been defined before continuing this tutorial. If not, refer to [Step 03: Filament diameter calibration](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2003/Etape_03.md).

_Note: All methods used in this tutorial involve printing bed items layer by layer, without sequential printing. This approach is necessary because sequential printing cannot print 11 cubes side by side with a 5mm inter-cube spacing without risking collisions._

## Objective
The main objective of this tutorial is to explain step by step how the flow rate percentage of a Sunlu PETG filament is characterized on the Z2 nozzle (left nozzle) of a QIDI IFAST, using a series of test cubes at decreasing variable flow rates. The goal is to find the optimal flow rate percentage that produces cube walls as close as possible to the theoretical thickness of 1.6mm (0.4mm × 4). Regardless of the slicer used (IdeaMaker in my case), it is always necessary to define this value precisely — along with the nominal diameter — to get the most out of your printer. Every filament is unique and must be characterized before use. From experience, I recommend writing these two values on the spool, which will save you a great deal of effort later.

![image](https://github.com/user-attachments/assets/1195653a-5a88-4350-ae09-b2b6b5d9bc97)

# Step 04: Calibrating the Z1/Z2 Nozzle Flow Rate Percentage Based on Filament Diameter

## Core methodology: Process steps using cubes from [100% .. 90%] in 1% increments

**Loading Files**

**Case 1**: You have the same configuration as me on your QIDI IFAST — PETG on Z2 and PLA on Z1 → you can go directly to [Printing the Cubes](https://github.com/sudtek/IMPRIMANTES_3D/edit/main/QIDI/IFAST/CALIBRATION/Etape%2004/Etape_04.md#pr%C3%A9paration-de-limprimante-avant-dimprimer-le-gcode) using the 11-cube series G-code file [17_10_2024_Calibration_[100%..90%]_V2.gcode](https://github.com/sudtek/IMPRIMANTES_3D/blob/7b1b4db4feb8aaa148066c3f2ab6458e4ebc0bf5/QIDI/IFAST/CALIBRATION/Etape%2004/Z2_Calibration_PETG_235%C2%B0c/17_10_2024_Calibration_%5B100%25..90%25%5D_V2.gcode).
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/6f4cdd068f3487245cee3358175c3eef3447ab7e/QIDI/IFAST/CALIBRATION/Etape%2004/Z2_Calibration_PETG_235%C2%B0c/Vue_01.png)


**Case 2**: You do not have the same configuration as me and/or you wish to edit/modify/adapt the source file [17_10_2024_Calibration_[100%..90%]_V2.idea](https://github.com/sudtek/IMPRIMANTES_3D/blob/b954e0fb5198141b21f86ee10baec49635fdae2a/QIDI/IFAST/CALIBRATION/Etape%2004/Z2_Calibration_PETG_235%C2%B0c/17_10_2024_Calibration_%5B100%25..90%25%5D_V2.idea) to suit your needs. All files can be downloaded at this link: [Step 04 / Z2_Calibration_PETG_235°c](https://github.com/sudtek/IMPRIMANTES_3D/tree/7b1b4db4feb8aaa148066c3f2ab6458e4ebc0bf5/QIDI/IFAST/CALIBRATION/Etape%2004/Z2_Calibration_PETG_235%C2%B0c)

- Launch IdeaMaker (version >= 5.0.6).

- Load the file [17_10_2024_Calibration_[100%..90%]_V2.idea](https://github.com/sudtek/IMPRIMANTES_3D/blob/b954e0fb5198141b21f86ee10baec49635fdae2a/QIDI/IFAST/CALIBRATION/Etape%2004/Z2_Calibration_PETG_235%C2%B0c/17_10_2024_Calibration_%5B100%25..90%25%5D_V2.idea)
  ![](https://github.com/sudtek/IMPRIMANTES_3D/blob/dd77a2579ed883ef5e8eff893bc009ba6bb62ccd/QIDI/IFAST/CALIBRATION/Etape%2004/media/IDEAMAKER_Chargement_Fichier_11cubes%5B100%25...90%25%5D1%25.png)

- From the simplified slicing menu, click the red pen icon ![](https://github.com/sudtek/IMPRIMANTES_3D/blob/0894b3a91323984d481de2000f3e4227fd0351bc/QIDI/IFAST/CALIBRATION/Etape%2004/media/IDEAMAKER_menu_tranchage_niveau_0.png) to access the detailed slicing menu, which should be blank:
  ![](https://github.com/sudtek/IMPRIMANTES_3D/blob/5e340b0a7590bee1af5fe61316c21f14138fffa1/QIDI/IFAST/CALIBRATION/Etape%2004/media/IDEAMAKER_menu_tranchage_Vierge_niveau_1.png)

- Import the profiles from top to bottom — printer, left filament, right filament, template — using the "Plus" buttons.

Top to bottom:

**#1** Import the printer profile
[17_10_2024_IFAST-export.printer](https://github.com/sudtek/IMPRIMANTES_3D/blob/667637b22536c230eb82010f8e05996019708a51/QIDI/IFAST/CALIBRATION/Etape%2004/Z2_Calibration_PETG_235%C2%B0c/17_10_2024_IFAST-export.printer)
in the first row by clicking Plus:
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/4566f302fe43216aef2d1f766e220cac8bce1b17/QIDI/IFAST/CALIBRATION/Etape%2004/media/IDEAMAKER_menu_tranchage_Ligne1_IMPRIMANTE.png)

**#2** Import the material profile for the Z2 nozzle on the left (L for LEFT)
[17_10_2024_QIDI_IFAT_PETG White_export_Gauche.filament](https://github.com/sudtek/IMPRIMANTES_3D/blob/4566f302fe43216aef2d1f766e220cac8bce1b17/QIDI/IFAST/CALIBRATION/Etape%2004/Z2_Calibration_PETG_235%C2%B0c/17_10_2024_QIDI_IFAT_PETG%20White_export_Gauche.filament)
in the second row by clicking Plus:
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/4566f302fe43216aef2d1f766e220cac8bce1b17/QIDI/IFAST/CALIBRATION/Etape%2004/media/IDEAMAKER_menu_tranchage_Ligne2_PETG.png)

**#3** Import the material profile for the Z1 nozzle on the right (R for RIGHT)
[17_10_2024_QIDI_IFAT_PLA_Red_export_Droite.filament](https://github.com/sudtek/IMPRIMANTES_3D/blob/3f0e0337d4df9fc1193c668eef40fb1c53a33e74/QIDI/IFAST/CALIBRATION/Etape%2004/Z2_Calibration_PETG_235%C2%B0c/17_10_2024_QIDI_IFAT_PLA_Red_export_Droite.filament)
in the third row by clicking Plus:
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/4566f302fe43216aef2d1f766e220cac8bce1b17/QIDI/IFAST/CALIBRATION/Etape%2004/media/IDEAMAKER_menu_tranchage_Ligne3_PLA.png)

**#4** Import the material template* profile
[Step 04/Z2_Calibration_PETG_235°c/17_10_2024_Template PETG Principal GAUCHE_QIDI_Z2T0 VS PLA supports DROITE_QIDI_Z1_T1 SAVE_17_octobre_2024_nonPOST_Tout-Support_OK_export.bin](https://github.com/sudtek/IMPRIMANTES_3D/tree/4566f302fe43216aef2d1f766e220cac8bce1b17/QIDI/IFAST/CALIBRATION/Etape%2004/Z2_Calibration_PETG_235%C2%B0c)
in the fourth row by clicking Plus:
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/4566f302fe43216aef2d1f766e220cac8bce1b17/QIDI/IFAST/CALIBRATION/Etape%2004/media/IDEAMAKER_menu_tranchage_Ligne4_TEMPLATEMATERIAUX.png)

_*(Note: WARNING — risk of confusion: the script tutorial also uses the term "template" but the two have nothing in common!)_

You should now see this layout:
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/0894b3a91323984d481de2000f3e4227fd0351bc/QIDI/IFAST/CALIBRATION/Etape%2004/media/IDEAMAKER_menu_tranchage_niveau_1.png)

Import the 11-cube settings file via **"Layer and Group Settings"** → **"Import and Export"** → **"Import from Local Disk"**:
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/3f0e0337d4df9fc1193c668eef40fb1c53a33e74/QIDI/IFAST/CALIBRATION/Etape%2004/media/IDEAMAKER__menu_ParametresGroupesCouches_Vierge.png)

Select the file [17_10_2024_Calibration_[100%..90%]_V2_export.settinggroup](https://github.com/sudtek/IMPRIMANTES_3D/blob/7cd00734a7899714554ef4374b111f3f644160e2/QIDI/IFAST/CALIBRATION/Etape%2004/Z2_Calibration_PETG_235%C2%B0c/17_10_2024_Calibration_%5B100%25..90%25%5D_V2_export.settinggroup). This file contains all the parameters that **OVERRIDE** the PETG material profile on Z2, in order to create groups each with their own unique flow rate percentage that is independent of the Z2 left nozzle material profile. This way, in IdeaMaker each item on the bed can be customized with its own properties per group and/or layer.

_Note: Files with the **.settinggroup** extension generally only make sense in conjunction with the **.idea** file they are associated with, and by nature are not easily transposed to other items — except for extracting specific configurations._

If the settings import was successful, you should see a list of groups corresponding to the elements of the 11 cubes, the legend, and the purge tower:
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/c1b234019d060fd0832e5eb9d003cb621b1c3000/QIDI/IFAST/CALIBRATION/Etape%2004/media/IDEAMAKER__menu_ParametresGroupesCouches_Final.png)

Example: details of the unique parameters for each group — here group B:
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/c1b234019d060fd0832e5eb9d003cb621b1c3000/QIDI/IFAST/CALIBRATION/Etape%2004/media/IDEAMAKER__menu_ParametresGroupesCouches_CUBE_B.png)

Custom parameters for the 99.0% flow rate cube:

**Print order***: Different from the other items on the bed. Group B's cube has its walls printed in a specific order: #1 the outer perimeter shell, #2 the inner perimeter shell, and finally #3 the infill between the two shells. This choice ensures more precise positioning and more accurate final wall thickness by limiting the effects of lateral pressure.
_Note: The term "print order" in this option has nothing to do with sequential printing, which consists of printing one complete cube from layer z=0mm to the final layer z=20mm before moving on to the next cube._

**Infill density**: Applies only to the interior of the cube. This parameter is set to 0% so the cube is hollow, allowing wall thickness measurement to 1/100mm with a micrometer.

**Solid fill layers**: The number of layers in contact with the bed. The default value in the PETG (Z2) material profile could have been used, but I wanted a uniform number of shells across all test pieces to limit deformation and also to allow them to be reused as small containers.

**Left material flow rate (overrides material settings)**: Each cube has a unique custom flow rate specific to its group. Group B's cube is printed at 99%; the next cube in group C at 98%, and so on — overriding the material settings.

**Enable wipe wall**: Included but disabled. By default this option is always enabled in my PETG material profile because I print with two filaments, but for calibration purposes — in order to print all cubes in a single row — I have chosen to disable this option at the group level. This avoids having to modify my material profile, prevents collisions between wipe walls given the 5mm inter-cube spacing, and also speeds up bed printing. The 10×10×20mm purge tower does not include this option and therefore retains its wipe wall.

**Layer parameters**: Also customized with options relating solely to extruder temperatures, in order to make it easier to reuse and modify this bed for characterizing other filament types requiring different temperatures. These values must therefore be modified in each group, and a thorough check of the thermal values applied to the nozzle must be made before exporting and printing a G-code. My parameters:
- Z2 nozzle on the left (L): 235°C for PETG
- Z1 nozzle on the right (R): 205°C for PLA → Note: even though this bed prints PETG, at the start of each print the QIDI IFAST performs a 100mm purge line. If Z1's temperature is not appropriate for the filament loaded, there is a risk of breaking/damaging the head and/or clogging the nozzle.

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/9b1b6daf2745e975ca76cbf3927c7ab1c6f96028/QIDI/IFAST/CALIBRATION/Etape%2004/media/IDEAMAKER_Visualisation_temperature.png)

The enclosure temperature is set by default to 40°C. It can be changed in IdeaMaker by editing the main material on Z2 → **"IFAST PETG WHITE SUNLU"** → **"Edit Selected Material Settings"** → **"Custom G-code"** and modifying **"M141 S40"**. This temperature choice is deliberate — it allows any type of filament to be printed while keeping the printer's thermal expansion fully controlled. Since my QIDI is located in a workshop, it experiences a temperature swing of approximately 35°C between winter and summer. Working in a chamber at a constant controlled temperature ensures better print repeatability and consistent settings year-round, independent of the season. Drive mechanisms are sensitive to thermal expansion, which is why I always work at a constant temperature of 40°C.

The bed temperature is set to 65°C because I print the part body in PETG and the supports in PLA [on a thin layer of soluble glue](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2002/Etape_02.md#pr%C3%A9requis), so a compromise temperature compatible with both filaments must be found.
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/7696ddd079a5c97c509103294c85bcd0db28b6b0/QIDI/IFAST/CALIBRATION/Etape%2004/media/IDEAMAKER_MATERIEL_GAUCHE_Z2_PETG_White_SUNLU_Temperature.png)

Preview of the calibration cube series from 100% to 90% at decreasing flow rates in 1.0% steps, to confirm everything looks correct:
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/6f4cdd068f3487245cee3358175c3eef3447ab7e/QIDI/IFAST/CALIBRATION/Etape%2004/Z2_Calibration_PETG_235%C2%B0c/Vue_02.png)

Export the .gcode file [17_10_2024_Calibration_[100%..90%]_V2.gcode](https://github.com/sudtek/IMPRIMANTES_3D/blob/8bae97a4e72fbc0f8e1de0a924a69d353455d964/QIDI/IFAST/CALIBRATION/Etape%2004/Z2_Calibration_PETG_235%C2%B0c/17_10_2024_Calibration_%5B100%25..90%25%5D_V2.gcode) to a USB stick.

### Preparing the printer before printing the G-code
Manually set the material, bed, and enclosure temperatures via the printer menu and allow the printer to thermally stabilize for at least 15 minutes before starting your print. Refer to the detailed explanations in [Step 02 — Bed Leveling Calibration](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2002/Etape_02.md#pr%C3%A9requis) for more information on this point.

Perform a hot fast leveling of the printer. If needed refer to [Step 02: Bed Leveling Calibration](https://github.com/sudtek/IMPRIMANTES_3D/blob/8bae97a4e72fbc0f8e1de0a924a69d353455d964/QIDI/IFAST/CALIBRATION/Etape%2002/Etape_02.md#pr%C3%A9requis).

### Printing the Cubes
The print will take approximately 4 hours 15 minutes and consume 37g of filament.

Each cube layer is printed with a unique decreasing flow rate: 100.0%, 99.0%, ... 90.0%. However, the QIDI IFAST has a display bug* — the printer screen is never updated with the current flow rate value, and you must manually force a refresh by toggling between screen 1/2 and 2/2 to verify that the correct flow rate parameters are being applied to each cube.
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/590ed48f2fef80f08a1cb919f9494207e8ea42d6/QIDI/IFAST/CALIBRATION/Etape%2004/media/QIDI_IFAST_ECRAN_BUG_MAJ_DEBIT.jpg)

_*Note: I reported this display update bug to QIDI support but as of today there is no fix._

Allow the cubes to cool on the bed until they return to room temperature to minimize the risk of deformation.
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/0c5fa474c00300508d8980d77553aec96af0cd91/QIDI/IFAST/CALIBRATION/Etape%2004/media/PRINTCUBE_01.png)

Carry out a visual inspection of the printed cubes to ensure they are correctly printed and meet expectations.
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/5a3fb5728029d8960e37ff5dc597c570d68dc350/QIDI/IFAST/CALIBRATION/Etape%2004/media/PRINTCUBE_02.png)

### Measuring Cube Walls

Precisely measure walls X1, X2, Y1, and Y2 of each cube using a 1/100mm precision micrometer.

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/f1941dd6f5dbcfc983f447e04092b3a1cd396673/QIDI/IFAST/CALIBRATION/Etape%2004/media/MESURE_00.png)

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/f1941dd6f5dbcfc983f447e04092b3a1cd396673/QIDI/IFAST/CALIBRATION/Etape%2004/media/MESURE_02.png)

Download the spreadsheet file [17_10_2024_Filament_Flow_Rate_Calibration.ods](https://github.com/sudtek/IMPRIMANTES_3D/blob/e164b41cd4a32ed06201bcb55994184bbe3e5474/QIDI/IFAST/CALIBRATION/Etape%2004/17_10_2024_Calibration_filament_D%C3%A9bit_Ecoulement.ods).

Duplicate the tab **PROFORMAT_Debit_Filament_Matrice_Cubes_10C_x_1L_Y%..Z%_Pas_N%** and enter the X1, X2, Y1, Y2 wall values for each of your cubes.

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/69b40453d07beb1fe1b0a7f14bf69deeda3c96fa/QIDI/IFAST/CALIBRATION/Etape%2004/media/PROFORMAT_Vierge.png)

### Data Analysis

The spreadsheet will calculate the arithmetic mean (X1+X2+Y1+Y2)/4 for each cube and automatically draw a graph consisting of a polyline. This graph is intended to help you locate a solution interval where you can find at least one solution. A solution interval is a line segment between two points Mmean and Nmean that crosses the 1.6mm wall thickness value. This value corresponds to shell thickness × number of shells making up a wall (0.4mm × 4 = 1.6mm). In the spreadsheet you will find a tab titled "Exemple_Test_Debit_Filament_Matrice_Cubes_10C_x_1L_100%..90%_Pas_1%", which corresponds to a series I carried out when characterizing one of my PETG spools — this will serve as a reference for the rest of my explanations.

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/3bf69e476241725de97882081f60ca12b5b21d91/QIDI/IFAST/CALIBRATION/Etape%2004/media/TABLEUR_Exemple_Moyenne_01.png)

_Note: If you do not find a solution interval within the initial range [100% .. 90%], it should be located immediately outside the lower or upper boundary. If this is not the case, it is very likely that you have incorrectly characterized your filament's main diameter — refer back to [Step 03: Filament diameter calibration](https://github.com/sudtek/IMPRIMANTES_3D/blob/8ec18aae8171912256d8da4de497ad06e5ea1aaa/QIDI/IFAST/CALIBRATION/Etape%2003/Etape_03.md) and restart this tutorial from the beginning._

This polyline crosses the 1.6mm wall thickness value between the 92.0% and 91.0% flow rate cubes — there is indeed a solution in this interval, as graphically neither boundary is itself a solution. The solution flow rate therefore lies in the interval ]92% .. 91%[ (between the 92% and 91% cubes, exclusive). Given that IdeaMaker allows flow rate precision to 1/10 (0.1%):

You can either:

- Stop here and "split the difference" by choosing an intermediate value. By carefully observing the graph, one can intuitively see that the solution lies in the left half of the interval ]92% .. 91.5%[, giving candidates {91.6%; 91.7%; 91.8%} with a maximum error of ±0.2% — all three are acceptable.

- Search for the exact value to 0.1%, which requires printing a new series of cubes in the interval [92.0% .. 91.0%].

### Determining the Optimal Flow Rate
Before developing this tutorial, I had used a pure bisection method, consisting of printing several series of two cubes representing the upper and lower bounds of an interval. However, this method requires printing approximately six recursive cube series to converge and determine the flow rate value to 0.1% precision. This approach is time-consuming and tedious — each series must return to room temperature before measurements can be taken, and it is critical not to make errors in the bisection logic (interval selection).

The only advantage of this approach is that it reveals the existence of multiple solution candidates within the global flow rate interval, some better than others due to the dispersion/clustering phenomenon around the 1.6mm target value. For the same filament I was able to find two good candidates: 91.7% and 92.3%.

For those who want more detail, refer to this video covering the full methodology for finding the flow rate percentage for the 100% to 90% interval described above: [![Details, explanations and calibration method for flow rate % with a series of 11 calibration cubes from 100% to 90%](https://i9.ytimg.com/vi_webp/gn3A1lFX0vc/mq2.webp?sqp=COirprkG-oaymwEmCMACELQB8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGD0gVChlMA8=&rs=AOn4CLAkej0COVnXFqI_hiDXwUg99ymBUw)](https://www.youtube.com/watch?v=gn3A1lFX0vc?si=RjfHDFoegoFpW7tH)

## Conclusion
The process of characterizing a filament's flow rate percentage is crucial for achieving dimensionally accurate 3D prints. It requires one or two cube series, several precise measurements, and rigorous data analysis to determine the optimal flow rate value. Since every new filament must be characterized and this work is tedious, thankless, and time-consuming, I developed an interactive Python script. This script generates a G-code file directly for a given working interval [Xmax% .. Ymin%] with a step of 1% or 0.1%, without requiring a slicer. For now, this script only works for the Z2 nozzle. To avoid making this tutorial too long, I have separated the explanations and invite you to refer to: [Generator for variable flow rate cube series with constant decreasing steps of 1% / 0.1% for calibration and bracketing of Z2 (left nozzle) flow rate on the QIDI IFAST 3D printer](https://github.com/sudtek/IMPRIMANTES_3D/tree/787a158a1ccf9bd3e518755a8b3c06576e8295ef/QIDI/IFAST/CALIBRATION/Etape%2004/Z2_Calibration_Script).

-------------------------


---
*Original author: @sudtek*
