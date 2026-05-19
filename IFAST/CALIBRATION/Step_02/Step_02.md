# Step 02: Bed Leveling Calibration

## Prerequisites before continuing:
- You must have completed [Step 00 — Dual nozzle alignment / XY calibration](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2000/Etape_00.md)
- You must have completed [Step 01 — Calibrating the two extruder motors Z1 and Z2](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2001/Etape_01.md)

## Overview

Bed leveling on the IFAST is not automatic and must be performed manually. Although QIDI explains how to carry out this leveling in its manual, the information provided is minimal. I will therefore expand on it with a detailed tutorial of my method* for leveling the QIDI IFAST bed.

*I apply a method very similar to the one I use on my Artillery X1.

Beds can suffer from insufficient adhesion but can also adhere too strongly (known as being "in love" in machining jargon). This behavior varies depending on working temperatures, bed surfaces, and the materials being extruded. Finding the right balance is therefore difficult and requires a lot of practice, empirical testing, and experience. If your printed 3D object:
- Adheres too much: Your bed coating will deteriorate prematurely and will mark the underside of your print, requiring post-processing such as sanding. I once had a glass bed that held a part so firmly that the glass ended up chipping, requiring a wood chisel to separate the part from it.
- Does not adhere enough: The part detaches during printing — the result being a magnificent "plate of spaghetti," a waste of material and time.

The ideal is therefore to find the right balance. For my part, in FDM 3D printing I systematically use a simple and inexpensive technique: an interface layer. This technique consists of diluting "school glue stick" in water, spreading the liquid onto the bed with a silicone brush, then rolling several crossed strokes to smooth and even out the thickness over the print area. This creates an interface layer that, when hot, will firmly hold your part in place on the bed, and that, after printing, as the temperature drops, will make separation easy without damaging either the bed or the underside of the part. The only post-processing required is a wipe with a damp microfibre cloth to remove glue residue from the underside of the parts. It is not even necessary to clean the bed — simply dissolve the remaining glue with water and apply another roller pass. The advantages of this method are its low cost, non-toxicity, and infinite reusability.

[Video example: 3D Printing Tip — Improving bed adhesion](https://www.youtube.com/watch?v=7C0QPmg6328)

## Two types of leveling on the QIDI IFAST:

To access the QIDI IFAST leveling menus → Gear icon → Leveling menu icon.
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/1b44282f20c2ab513edb47a70c626f3488f8c479/QIDI/IFAST/CALIBRATION/Etape%2002/media/menu_leveling.jpg)

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/349c9b5b93062e623338f2681f15292e31eb9a76/QIDI/IFAST/CALIBRATION/Etape%2002/media/Menu_Fast_normal_levelling.jpg)

**"Normal Leveling"** is essential and must be performed at least once upon receiving the printer before any test prints. It allows you to correctly set the distance between the nozzles and the bed to avoid being:
- Too far from the bed, as the extruded material will not adhere to the bed and will not be pressed firmly enough against it. (With the molten material being viscous during extrusion, an analogy can be made with mortar that is pressed onto a surface to improve adhesion.)
- Too close to the bed, risking damage to the bed (less serious), the print heads (serious), or even damage to the lead screw drive system and/or burning out a motor or driver (a disaster).

At the start of each new print, you should also systematically verify and recalibrate the distance using a **"fast leveling"** on the QIDI IFAST, as I have found that with each new Z homing, when the bed drops to its end stop and rises again, there is a small Z offset of a few thousandths of a millimeter related to the technical design of the Z axis (this will be discussed in a dedicated file).

## Prerequisites

Regardless of the leveling type — **"Normal Leveling"** or **"Fast Leveling"** — both must be performed hot, under printing temperature conditions, with clean nozzles. To clean the nozzles I use a very thick linen cloth, which protects my fingers and withstands temperatures up to 250°C. If you perform your leveling cold as manufacturers recommend, the machine will not be at its correct thermal expansion state and you will lose a great deal of precision in the fine-tuning steps that follow. This must become a habit — always level hot!

When printing on the QIDI IFAST, I systematically set my temperatures in advance to preheat before calibrating, for example:
- Nozzle Z1 at 205°C for printing PLA supports.
- Nozzle Z2 at 235°C for printing part bodies in PETG.
- Bed temperature between 60°C / 70°C max if PLA supports are in contact with the bed. 80°C max if only PETG is in contact with the bed.
  Note: The glue interface layer allows the bed temperature to be lowered by 10°C without loss of adhesion or risk of warping on the first layers.
- Heated enclosure at 50°C max, as PLA supports cannot withstand higher temperatures, and the goal here is to limit PETG warping during printing.
  Note: At the end of the print, remember to gradually lower the enclosure temperature using a G-code snippet in your slicer to limit warping.

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/349c9b5b93062e623338f2681f15292e31eb9a76/QIDI/IFAST/CALIBRATION/Etape%2002/media/Temperature_%20pr%C3%A9chauffages.jpg)

_Note 1: These temperatures are given as guidance for my own needs and must be adapted to yours depending on the materials you intend to print._

_Note 2: QIDI recommends opening the transparent top cover when printing certain materials. If like me you are printing part bodies in PETG, I strongly advise keeping the cover closed to limit warping. Additionally, if the enclosure is open at the top, the chimney effect skews the overall calibration._

QIDI supplies a 0.2mm thick plastic card, 10cm × 15cm, black/brown in color, intended as a gauge for "Normal Leveling" or "Fast Leveling." However, there are several problems with this thickness gauge:
- It is not a thermoplastic, so when calibrating hot, it will melt on contact with the nozzle, stick to it, and contaminate both the nozzle and the bed → it can therefore only be used for cold calibration, which in my opinion should only be performed during the very first setup in case the head shifted during shipping.
- If like me you work in a closed enclosure without opening the top cover (or your printer is positioned up high), it is impossible to use this plastic gauge to calibrate, as it is not long enough and is genuinely impractical — you end up contorting yourself.

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/CALIBRATION/Etape%2002/media/Gauge_plastique_livr%C3%A9e_par_QIDI.jpg)

I recommend replacing this gauge with an A4 Bristol card sheet with 5mm grid squares, 0.2mm thick. It is the simplest, least expensive, and most practical option.

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/4367d96d8e8fbc38b2ab900d8a624da749ba79bd/QIDI/IFAST/CALIBRATION/Etape%2002/media/Feuille_A4_Bristol_0%2C02mm.jpg)

To access the **Normal leveling** menu:

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/5e3d47b0d32ce0c8ed1cd933c6c03586c30d1f84/QIDI/IFAST/CALIBRATION/Etape%2002/media/menu_leveling.jpg)

The **Normal leveling** menu:
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/338277bc2f0e9f8761f7f410eed4766f0eccd72d/QIDI/IFAST/CALIBRATION/Etape%2002/media/Menu_Ajustement_normal_levelling.jpg)

The bed distance must be adjusted by loosening the wing nuts and turning the 3 knobs to adjust:
![](https://github.com/sudtek/IMPRIMANTES_3D/blob/e1d85f24cb858a651019100818edc7928fb74bdb/QIDI/IFAST/CALIBRATION/Etape%2002/media/Les_3_noix.jpg)

...with the A4 sheet positioned between the bed and the nozzle at all times, to protect both from a potential crash (direct contact between bed and nozzle), and also to protect the bed from direct thermal contact with the nozzle tip during successive adjustments. Remaining in one position for too long while adjusting will inevitably cause thermal damage to your bed surface. Bristol card is an excellent insulator — it will thermally protect the work area without any risk of damage or crash.

Hot calibration requires a minimum of practice and can cause problems (crashes, thermal damage to the bed, etc.) if the user makes a mistake. This is precisely why manufacturers do not have users calibrate at working temperatures — they favor cold leveling instead.

![](https://github.com/sudtek/IMPRIMANTES_3D/blob/e1d85f24cb858a651019100818edc7928fb74bdb/QIDI/IFAST/CALIBRATION/Etape%2002/media/Positionement_Buse.jpg)

Reminder: On the QIDI IFAST, the position of the head and nozzles is fixed on the Z axis — it is only the bed that is adjusted; it moves up or down.

The adjustment is made successively for each knob to set the distance between the nozzle and the bed. The goal is to correctly adjust the pressure on the sheet without jamming it or leaving it too loose, in order to achieve the correct distance. This requires practice and a light touch, but it is not insurmountable with a little experience:

- The pressure on the sheet is **too high** when:
  - You push on the Bristol card and it buckles, deforms, and does not slide back.
  - You pull on the Bristol card and it does not move.
→ Turn the knob counter-clockwise (to the right) to increase the distance between the nozzle and the bed by lowering the bed, releasing the pressure on the A4 Bristol sheet.

- The pressure on the sheet is **insufficient** when you push / pull / slide the A4 Bristol sheet side to side and feel no resistance from friction — your nozzle is far too high and is not in contact with the Bristol card.
→ Turn the knob clockwise (to the left) to reduce the distance between the nozzle and the bed by raising the bed, just enough to lightly pinch the sheet.

- The pressure on the sheet is **correct** when:
  - You can push, pull, and slide the Bristol sheet side to side while feeling a slight resistance. The resistance should feel identical at all control points.
  - You can pull the sheet out and reinsert it between the nozzle and the bed without damaging it.
→ Firmly tighten the wing nut to lock the knob in position.

Tip: To find the right balance without spending too long on it, I keep the Bristol card moving in circles while simultaneously adjusting and turning the knob.

Note: I have noticed that after tightening the wing nut, you may end up too close to the bed and be unable to reinsert the sheet between the nozzle and the bed, even though you had found an optimal position. This problem is related to thread play in the tightening/locking system. If you encounter this, do not panic — loosen the wing nut, turn the knob counter-clockwise (to the right) by less than 1/8 of a turn, then firmly retighten the wing nut to lock in position. Try reinserting the A4 Bristol sheet between the nozzle and the bed again. Sometimes this takes a few attempts — 2 or 3 iterations maximum. What you must absolutely avoid in this case is going back and forth by loosening too much and then retightening, as with this type of thread and locking mechanism you will introduce play and misalignment, and your bed will no longer sit parallel to the head's movement plane — in other words, the nozzle-to-bed distance will no longer be consistent across all control points.

Of course this technique must be repeated for each of the knobs! Once you have completed your very first hot "Normal Leveling," do not hesitate to re-check it after leaving the printer at working temperature for 30 minutes — but **you must remember to keep the bed at a minimum distance of 50mm from the heads to avoid creating a heat-affected zone**. If necessary, run another "Normal Leveling" to readjust — this will guarantee a perfect starting baseline for all your future "Fast Leveling" sessions.

[Video tutorial: My hot "Normal Leveling" technique for the QIDI IFAST](https://youtu.be/BVSv9q84bSc)

[Video tutorial: My hot "Fast Leveling" technique for the QIDI IFAST](https://youtu.be/96jHqoTtK9o)


---
*Original author: @sudtek*
