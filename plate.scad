$fn = 30;

module switchHole()
{
    cube([14,14,100]);
}

module plate(rows, width, length, height, keyPadding, standardKeySize)
{
    currentX = keyPadding;
    currentY = keyPadding;

    difference()
    {
        cube([width, length, height]);

        
        for(row = rows)
        {
            for(key = row)
            {
                !translate([currentX, currentY, -1])
                children(0);

                currentX = currentX + key + 2 * keyPadding;
            }

            currentY = currentY + standardKeySize + 2 * keyPadding;
            //currentX = keyPadding;
        }
    }
}

SW = 18; //The width of a standard key
TAB_WIDTH = 22 + 6; //Meassure accuratley
CAPS_WIDTH = 28 + 6;
L_SHIFT_WIDTH = 17 + 6;
CTRL_WIDTH = 22 + 6;
ALT_WIDTH = 22+6;
R_SHIFT_WIDTH = 46+6;
SPACE_WDITH = 118 + 6;
ENTER_WIDTH = 36 + 6;
BACKSPACE_WIDTH = 31 + 6;
BACKSLASH_WIDTH = 22 + 6;


KEY_PADDING = 1; //Padding per key on each side. Total padding on one key is 2 mm
KEY_ROWS = [
        [SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, BACKSPACE_WIDTH], //F keys
        [TAB_WIDTH, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, SW, TAB_WIDTH], //Number row
        [], //TAB row
        [], //Caps row
        [], //shift row
        [] //Ctrl row
    ];

KEY_OFFSETS = [];

for(rowIndex = [0 : len(KEY_ROWS) - 1])
{
    row = KEY_ROWS[rowIndex];
    
    offsetRow = [0];

    for(keyIndex = [1 : len(KEY_ROWS[rowIndex]) - 1])
    {
        //KEY_OFFSETS[rowIndex][keyIndex] = KEY_OFFSETS[rowIndex][keyIndex - 1] + KEY_ROWS[rowIndex][keyIndex];
        //offsetRow[keyIndex] = offsetRow[keyIndex-1] + row[keyIndex];
        offsetRow[0] = 0;
    }
}

plate(KEY_ROWS, 300, 1000, 3, KEY_PADDING, SW)
switchHole();
