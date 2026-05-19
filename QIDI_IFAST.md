**08/24/2024**

I recently acquired a QIDI brand printer, model IFAST, with a dual head in order to print my parts in PETG and the supports in a different material (PLA / PVA) that does not adhere to PETG.

A so-called "dual" printer is different from an "IDEX" which has two fully independent heads capable of working simultaneously — in mirror mode, clone mode, etc.

The two extruders on the QIDI IFAST are mounted on a single head and are alternately lowered/retracted as needed via a cam mechanism when the head reaches the left/right end stop.

Example: If the head reaches the left end stop, the Z2 head on the left side is lowered close to the bed for printing, while the right head Z1 is retracted.

I use only the Ideamaker slicer to convert my STL files. It identifies heads from left to right as T0, T1 — which creates some issues with QIDI's own numbering convention.


**QIDI IFAST running Marlin firmware modified by QIDI; some G-code functions differ — see the [QIDI IFAST Firmware](https://github.com/sudtek/IMPRIMANTES_3D/tree/235f8ea74b5f1439434741d732e151d05a6209f9/QIDI/IFAST/Firmware) section**

| Extruder Location        | Left   | Right    |
|--------------------------|--------|----------|
| QIDI ID                  | Z2     | Z1       |
| Ideamaker ID             | T0     | T1       |
| Location                 | Left   | Right    |
| Role                     | Body   | Supports |
| Material                 | PETG   | PLA      |
| Extruder temp (°C)       | 235    | 205      |
| Bed temp (°C)            | 70     | 70       |
| Enclosure temp (°C)      | 55     | 55       |

- Location: By convention, when facing the printer.
- Extruder temp (°C): These temperatures will give good results by default, but you should always calibrate for your specific spools.
- Bed temp (°C): Always apply a layer of white glue stick to ensure adhesion, limit warping, and make removal easier with a spatula.
- Enclosure temp (°C): Do not exceed 55°C — otherwise PLA supports/rafts/skirts will melt and deform. Ideally use PLA+.
- Note 1: No part cooling fan during printing, as it causes PETG to warp.
- Note 2: At the end of a print it is recommended to use a G-code sequence to gradually lower the temperature in steps to avoid PETG warping.

**My observations:** I quickly noticed that objects printed on my QIDI IFAST at €1,500 were significantly less precise than those from my old calibrated X1 at €300. The QIDI IFAST is a technical printer that absolutely requires thorough end-to-end calibration — it is impossible to get by with the factory default settings. I therefore decided to document my wanderings, methods, information, G-code, Ideamaker profiles, and other struggles — to help other QIDI IFAST users get the most out of their machine. I contacted QIDI support, which is responsive and friendly, but in my opinion remains too superficial on certain points — lacking documentation and software polish.

**WARNING:** The G-codes in this section are very specific to the QIDI IFAST printer! You may use them as inspiration, but if you have a different model you will absolutely need to adapt them. I make a habit of documenting things so they are explicit — nonetheless I recommend always reading through and verifying them before you proceed.