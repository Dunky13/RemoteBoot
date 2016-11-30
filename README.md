# Remote boot with NodeMCU
## Necessities
### Hardware
- 1x NodeMCU
- 2x Optocouplers (EL817)
- ∞x Patience

### Software
- [NodeMCU Flasher](https://codeload.github.com/nodemcu/nodemcu-flasher/zip/master)
- [NodeMCU Firmware](https://github.com/nodemcu/nodemcu-firmware/releases/download/0.9.6-dev_20150704/nodemcu_float_0.9.6-dev_20150704.bin)
- [ESPlorer](https://esp8266.ru/esplorer-latest/?f=ESPlorer.zip)

## Steps
 - 1) Flash the NodeMCU Firmware using the NodeMCU Flasher
 - 2) Edit init.lua script - include your WiFi credentials @ line 2
 - 3) Set up NodeMCU according to the following schematic. The dot on EL817 correspondents to Pin 1 ![Schematic](https://raw.githubusercontent.com/Dunky13/RemoteBoot/master/RemoteBoot.png)
 - 4) Write init.lua to NodeMCU
 - 5) Connect properly to PC - Watch out! Polarity IS IMPORTANT!
