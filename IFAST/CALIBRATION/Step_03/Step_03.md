# Step 03: Filament Diameter Calibration

## Prerequisites before continuing
- This tutorial must be carried out with perfectly dehydrated spools.
- A precision measuring instrument such as a caliper or micrometer is required to correctly measure the diameter — refer to the [About measuring instruments](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2003/Etape_03.md#a-propos-des-instruments-de-mesures) section for more details.
- A ruler of at least 20cm or a tape measure of 2m maximum to position 10 measurement points.
- A permanent marker whose color contrasts with the filament.

## Overview
The most common standard diameter for FDM 3D printer filament spools is 1.75mm*, however for an equivalent material (PETG, PLA, ABS, etc.), each filament spool is different — even unique. If you buy several batches of spools from the same supplier, there will very likely be differences between their respective filament diameters. The worst case is when the diameter varies enormously from the beginning to the end of a single spool. If you are printing decorative objects this is generally not critical, but if you are making mechanical parts and need a minimum of dimensional precision, this can become a very serious problem. Variations in the "average diameter" of each filament systematically affect the flow rate factor of the nozzle (expressed as a percentage in slicer software). So if you are printing objects over 1kg that necessarily require a filament change mid-print, or if you are printing with uncharacterized spools, you will inevitably notice:

- A change in density affecting the layers, visible as layers that appear more translucent or opaque than the layers printed before the spool change.

- Significant dimensional variations in the structure, creating a risk of failure.

These layer changes are not purely aesthetic — they are linked to a variation in the diameter of the new filament and a flow rate factor that is no longer appropriate for the new spool's diameter. Example: if the new spool's filament diameter is larger than the previous one with an unchanged flow rate, you will inevitably get thicker walls and therefore an object with larger overall dimensions. Conversely, if the new spool's filament diameter is smaller than the one you just finished, the walls will be thinner and the object will have smaller dimensions.

_* Spools with 3mm diameter filament also exist but are less common on consumer printers._

Note that in the case of the QIDI IFAST or any other printer with multiple extruder motors, if you characterize and calibrate a filament for use on Z2 you cannot expect to use it directly on Z1 and get the expected dimensions. The average filament diameter is the same, but the flow rate factor is specific to each extrusion head — it would be like putting it on a different uncalibrated printer and expecting the correct dimensions.

In summary, **every new dehydrated spool must be characterized for a given extruder before use, in order to define at minimum three factors that are specific and unique to that spool**:
1) The extruder ID — Z1 or Z2 — on which it will be used.
2) The average filament diameter over 1 meter of length → this is the goal of this tutorial.
3) Calculate the flow rate percentage for the spool based on the average diameter for extruder Z1 and/or Z2 — the calculation method will be detailed in a dedicated tutorial.

I recommend sticking a label showing these 3 parameters clearly on the spool holder before vacuum-sealing the spool for storage, so you can update your slicer settings when loading the spool.

## Method for calculating the average diameter

The procedure for calculating the average diameter is straightforward:

E1) Unroll 1.1 meters of filament.

E2) Secure the filament with a pin to prevent the spool from unwinding and tangling.

E3) If the beginning of the filament is pinched or damaged, remove the damaged section. Then using a 20cm ruler or tape measure, make a first mark 5cm from the start of the spool with a permanent marker, followed by 9 more marks. The marks should be clearly visible and contrasting against the filament. Precision between points is not critical — ±5mm is acceptable.

E4) Using your caliper or micrometer, measure the diameter at each of the 10 points in succession and record the values.

E5) Calculate a simple arithmetic mean to find the average diameter. If needed, you can use this spreadsheet which will calculate the average for you after you enter your values: [Average_Filament_Diameters_Z1&Z2](https://github.com/sudtek/IMPRIMANTES_3D/blob/0d3eb917c344bd84f99bd5797aadb5fb99b3cbc7/QIDI/IFAST/CALIBRATION/Etape%2003/Calcul_Diam%C3%A8tres_Moyens_Filaments_Z1%26Z2.ods)

Example:

Sunlu PETG with a theoretical diameter of 1.75mm ±0.2mm — measured with the flat jaw gives an average diameter of 1.724mm
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/1949d0320007ef1ac88599cf782de5bff678bacf/QIDI/IFAST/CALIBRATION/Etape%2003/media/Exemple_Mes_mesures_Diametre_filament_PETG_Z2_bec_large_OK.png)

VS

Sunlu PETG with a theoretical diameter of 1.75mm ±0.2mm — measured with the narrow jaw gives an average diameter of 1.744mm
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/1949d0320007ef1ac88599cf782de5bff678bacf/QIDI/IFAST/CALIBRATION/Etape%2003/media/Exemple_Mes_mesures_Diametre_filament_PETG_Z2_bec_END_NOK.png)

We will use the first series with Daverage = 1.724mm. In order to calculate the flow rate factor percentage, this value must be set in the slicer.

## IdeaMaker Configuration

In IdeaMaker you must modify the material parameters for L (Z2 left) "PETG white Sunlu main material" _(personal note: add link to my profiles)_:

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/9c71bebcd73ebe26cbfa5ed9e6e1c0c3ab731e08/QIDI/IFAST/CALIBRATION/Etape%2003/media/IDEAMAKER_configurer_extrudeur_gauche.png)

It is essential to override the slicing parameters in the material-linked profiles. Checking this box allows you to configure and calibrate each nozzle independently according to the material, overriding the "printer parameters" → set the filament diameter to 1.724mm.

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/9c71bebcd73ebe26cbfa5ed9e6e1c0c3ab731e08/QIDI/IFAST/CALIBRATION/Etape%2003/media/IDEAMAKER_Fixer_Diametre_moyen_filament.png)

You can download the summary of [IDEAMAKER_Filament_Calibration_Prerequisites_Z2.ods](https://github.com/sudtek/IMPRIMANTES_3D/blob/76d8e661b3302f08bcbbb2e3dc6a70d64314f03e/QIDI/IFAST/CALIBRATION/Etape%2003/media/IDEAMAKER_Pr%C3%A9requis_Calibration_Filament_Z2.ods) at this link.

Note: If necessary I will make an explanatory video of the procedure.

---------

## About measuring instruments
The ideal tool for measuring filament diameter is an appropriate precision instrument such as a 1/50mm caliper using the "flat jaw" section (in green), or a 1/100 micrometer.

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/e99904c9acdcf9f56b102b82c60a71e22e481a74/QIDI/IFAST/CALIBRATION/Etape%2003/media/pied_coulisse_manuel_bec_etroit.png)

The "flat jaw" (in green) is a ground surface of a few mm² on the caliper located after the narrow jaw (in red). The flat jaw, formed by two ground flat faces, provides a better average measurement than the narrow jaw, because pressing too hard on the wheel (yellow) tends to deform the filament and skew your measurement. Of course, using a manual caliper requires a minimum of practice to read values correctly. A digital caliper is an alternative, but in my opinion it is a false good idea — to get a quality digital caliper you need to invest several hundred euros (between €500 and €1000), otherwise they are too imprecise to be useful, or even counterproductive.

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/427b35bd2aba677db02372aaf2093f94eb496b77/QIDI/IFAST/CALIBRATION/Etape%2003/media/pied_coulisse_numerique.png)

My personal favorite by far is the micrometer, which allows precise average measurements to 1/100mm. All micrometers are equipped with a thimble-limiting screw that controls the clamping torque, so when measuring filament you always apply a constant force — no risk of skewing your measurements by crushing the filament. The one shown below has flat cylindrical anvils (other anvil shapes exist). The manual version is slightly more expensive than a good caliper but much more practical. A quality digital version costs a small fortune — not essential, but very convenient when aging eyesight starts to be a factor.

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/427b35bd2aba677db02372aaf2093f94eb496b77/QIDI/IFAST/CALIBRATION/Etape%2003/media/palper.png)

_Note: Like all precision tools, they do not respond well to misuse or mishandling. If they are properly maintained, used correctly, and stored with care, they will last for generations._


---
*Original author: @sudtek*
