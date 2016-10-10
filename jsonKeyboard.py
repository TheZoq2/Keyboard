import scadGenerator as SCAD
import json


jsonFile = open("layout.json", "r");

layout = jsonFile.read()
jsonLayout = json.loads(layout, strict=False);

STD_SIZE = 18.5

module = SCAD.Module("switchHoles", []);

currentX = 0;
currentY = 0;
currentRowY = 0;

nextWidth = STD_SIZE;
nextRotation = 0;

for row in jsonLayout:
    if(isinstance(row, dict)):
        continue;

    for key in row:
        #The amount of X/Y added on this key
        addX = 0
        addY = 0

        if(isinstance(key, str)):
            rotation = SCAD.Rotate(nextRotation, (0,0,1));
            transform = SCAD.Translate((currentX + nextWidth / 2, currentRowY + currentY + STD_SIZE / 2, 0));
            transform.addChild(SCAD.Call("children", [0]))

            rotation.addChild(transform);
            module.addChild(rotation);

            currentX += nextWidth;
            nextWidth = STD_SIZE
        else:
            if("x" in key):
                addX = key["x"] * STD_SIZE
                currentX += addX;
            if("y" in key):
                addY = key["y"] * STD_SIZE
                currentY += addY;

            if("w" in key):
                nextWidth = key["w"] * STD_SIZE;
            
            #Rotation seems to reset the row locations
            if("r" in key):
                nextRotation = key["r"]
                currentRowY = 0
                currentX = addX
                currentY = addY

    currentX = 0;
    currentRowY += STD_SIZE
            

print(module.generateCode());
print("switchHoles()\ncube([14,14,1]);");
