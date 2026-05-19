# QIDI-iFix

## 2026 05 19

A friend recently gave me her QIDI I-Fast 3D printer, which she believed to be broken. I dabbled in 3D printing back in 2013 and hadn't done much with it since, but since I like to tinker I took her up on her offer for a project.  

On first examination, the printer seemed operational and it wasn't immediately clear what was wrong with it. In the end, it turned out that her USB drive had gone bad and caused a "burning" smell, but the printer was otherwise functioning relatively normally.

While it technically works, the resulting prints were inconsistent and prone to causing clumps and clogs.  After calibrating, my first priority was improving the user experience.  Since this is not a popular model and is relatively old and also discontinued by the brand, I've collected the information I've come across in order to centralize resources.

All copied information should contain appropriate attribution but if your work is featured here and you would like it removed, let me know!

## Initial Condition

When I got the printer, it came with the original standard extruder carriage, a spare of the same type of carriage with a slightly different fan design, and a high-temperature extruder carriage. 

## Early Work

Since then, some of the parts have been damaged by disassembly and I've added several spare heating elements, heat sinks, and different types of heatbreaks and nozzles. 

One of the first improvements I implemented was bypassing the QIDI software with a Beaglebone Black with OctoPrint installed.  The Beaglebone is pretty old and has limited capabilities as far as software versions, so it will likely get replaced. 

I replaced the original filament detectors with BigTreeTech Smart Filament Sensors implemented with a python script that monitors filament movement and breakage. 

next step is to get leveling set up with a probe, but there is limited space to attach it. 

I had to replace one of the extruder cables immediately and I also sourced replacement connectors that I'll add a link to.

## Recurring Issues

There's a gap that exists between the dual-gear extruder and the top of the heatsink where with or without heat creep, filament tends to accumulate and block the filament path to the point that the extruder carriage needs significant disassembly to clear. 

The ribbon cable that connects the extruders to the main board are delicate FFC foil with a 1.27 pitch and a proprietary connector.  The cable frequently breaks because changing the extruders requires removing and reattaching the cable as well as being moved constantly during X and Y axis travel. 

## Future Improvements

I'd like to replace the cable with a rainbow stranded-copper ribbon cable or a more standard connector. 

I'll probably replace the main board and LCD at some point but I want to do as much as possible with original hardware before going with full replacement. 

Accessing the boards and cables requires significant disassembly of the unit that alters airflow to the cabinet.  I'd like to replace the friction/screw fit panels with hinged acrylic panels for easy access and viewing.

## Pie in the Sky

I'm dying to put together a took changer system that is a hybrid between automatic magnetic tool changers, the MUTANT from Whambam, and a Dewalt cordless battery system. I'd like to be able to exchange the extruders individually without a screwdriver and also remove the whole carriage from the top rail. 

# TODO: 
- ~~Integrate resources from @sudtek~~
- Add links to support related groups and document resources and files
- Add links to resources from MelioratewithNate and Juro Leho
- Document G-code differences specific to i-fast
- Document Beagleboard Setup
- ~~Implement version control on local settings~~
- Upload Slicer profiles
- Add material sources for replacement parts and upgrades
