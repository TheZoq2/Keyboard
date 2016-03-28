# 60%+ Mechanical Keyboard

This repo contains all the openSCAD and python scripts that I used to create a 3d printed keyboard. 
Other than the components here, you need around 70 cherry style mechanical switches, 70 diodes and 
a teensy or other microcntroller that can act as a USB keyboard. You also need a frame which I 
chose to make out of wood. You can find lots of pictures of the build process and the final result
[here](https://imgur.com/a/YUzv4).



## Generating a layout
If you want a custom layout on your keyboard, you will need to generate it from a layout file exported from 
http://www.keyboard-layout-editor.com/. Click raw data and hit download JSON, save it as layout.json in
the same folder as these scripts.

Next you will need to download my pyScad python script for generating openSCAD models aswell as the
jsonKeyboard.py script in this repository. Run jsonKeyboard and it will print the openSCAD code
for the layout to stdout. Save that code to a file, on unix you can use
```
  python3 keyboard.py > outputFile.scad
```

Finally, open keyboard.scad in openSCAD and replace the include statement at the top with the filename of 
of your output file, then generate the STL.

## Creating keycaps
At the moment, the keycap scad file is a bit of a mess but there should be some commented code at the bottom
for generating a standard keycap. If you want it rounded, you need to open the exported .stl file in any 
modelling program and round the corners yourself because it's tricky to do in scad. For a standard keycap,
you can use the keycapRounded.stl file in this repo. 

I was able to print all the keycaps facing up and I printed it with a 0.35mm nozzle using a velleman k8400.

##Firmware
In order to use the keyboard you will need some sort of controller that talks to the PC. I decided 
to use a teensy 3.1 which I programmed to act as a keyboard. The code for the firmware that I wrote
can be found [here](https://github.com/TheZoq2/KeyboardFirmware). However, you should be able to use any 
microcontroller you like, assuming it can function as a HID device. 


## Other repos
[PyScad](https://github.com/TheZoq2/py-scad) -- My own script for generating openSCAD models in python.
Required because variables arn't actually variables in scad.  
[KeyboardFirmware](https://github.com/TheZoq2/KeyboardFirmware) -- My code for the teensy microctontroller
inside the keyboard. 
