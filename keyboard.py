import scadGenerator as SCAD


SW = 18; #The width of a standard key
TAB_WIDTH = 22 + 6; #Meassure accuratley
CAPS_WIDTH = 28 + 6;
L_SHIFT_WIDTH = 17 + 6;
CTRL_WIDTH = 22 + 6;
ALT_WIDTH = 22+6;
R_SHIFT_WIDTH = 46+6;
SPACE_WDITH = 118 + 6;
ENTER_WIDTH = 36 + 6;
BACKSPACE_WIDTH = 31 + 6;
BACKSLASH_WIDTH = 22 + 6;


KEY_PADDING = 1; #Padding per key on each side. Total padding on one key is 2 mm
KEY_ROWS = [
        [SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW], #F row
        [SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, BACKSPACE_WIDTH], #Number keys
        [TAB_WIDTH, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, TAB_WIDTH], #TAB row
        [CAPS_WIDTH, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, ENTER_WIDTH], #Caps row
        [L_SHIFT_WIDTH, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, R_SHIFT_WIDTH], #Shift row
        [], #Ctrl row TODO: ADD
    ];


module = SCAD.Module("switchHoles", []);

currentX = 0
currentY = 0

for row in KEY_ROWS:
    for key in row:
        #Add a child with a transform here
        transform = SCAD.Translate((currentX + key / 2, currentY + SW / 2, 0));
        transform.addChild(SCAD.Call("children", [0]))
        module.addChild(transform)

        currentX += key
    currentX = 0;
    currentY += SW

print(module.generateCode());
