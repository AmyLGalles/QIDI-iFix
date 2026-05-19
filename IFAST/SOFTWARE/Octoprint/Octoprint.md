**Instructions for Using OctoPrint with the Qidi I-Fast Printer**

**Date: August 25, 2024**

Qidi I-Fast Printer Specifications:
- **Model**: QIDI TECHNOLOGY I-Fast 3D Printer
- **Extruders**: Dual
- **Print Volume**: 360×250×320mm

These instructions will allow you to configure OctoPrint with your Qidi I-Fast printer.
Make sure to follow each step carefully with the printer powered off to avoid any damage to the printer's internal components.

To use OctoPrint with the Qidi I-Fast printer, it is necessary to add a USB-to-serial dongle (VCC; RX; TX; GND), as the printer does not come equipped with a USB port from the factory. Here are the steps to follow:

1. **Remove the Right Panel**:
   - Disassemble the right panel of the printer to access the internal components.

2. **Locate the Serial Connector**:
   - Identify the serial connector inside the printer. There are two serial ports — note that QIDI recommends connecting the USB dongle to the port located immediately adjacent to the Wi-Fi module.
![The PCB in question is the one visible in the photo on the right:](https://github.com/sudtek/IMPRIMANTES_3D/blob/main/QIDI/IFAST/LOGICIELS/Octoprint/PCB_serial.png)

3. **Connect the USB Dongle**:
   - Plug the USB dongle into the identified serial connector.
   - Use a USB extension cable to make the connection easier and more accessible.

4. **Install OctoPrint**:
   I won't go into detail here about how to install OctoPrint — that's not the purpose of this document, and there are many videos that cover the topic in depth. However, if you have multiple 3D printers, I recommend installing OctoPrint in "multi-instance" mode, which lets you control several printers independently without risk of interference and without needing a dedicated machine per printer.

5. **Note on the OctoPrint / QIDI I-Fast Interface**: It appears that the QIDI I-Fast firmware is not fully supported by OctoPrint. This means you can control the QIDI I-Fast using basic commands from the OctoPrint web interface — for example: setting a nozzle or bed temperature, moving the print head, starting a print — but certain printer-specific functions will be disabled and/or unusable, some without any feedback loop. I find it a shame that QIDI doesn't show more interest in a product like OctoPrint, which unifies 3D printer control interfaces. I believe this is a serious commercial mistake that will cost all manufacturers who pursue this kind of customer lock-in strategy dearly in the long run.

---
*Original author: @sudtek*
