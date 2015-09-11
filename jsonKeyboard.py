import scadGenerator as SCAD
import json

STD_SIZE = 18;

jsonFile = open("layout.json", "r");

layout = jsonFile.read()
jsonLayout = json.loads(layout, strict=False);

STD_SIZE = 18.5

module = SCAD.Module("switchHoles", []);

currentX = 0;
currentY = 0;

nextWidth = STD_SIZE;

for row in jsonLayout:
    if(isinstance(row, dict)):
        continue;

    for key in row:

        if(isinstance(key, str)):
            transform = SCAD.Translate((currentX + nextWidth / 2, currentY + STD_SIZE / 2, 0));
            transform.addChild(SCAD.Call("children", [0]))
            module.addChild(transform)

            currentX += nextWidth;
            nextWidth = STD_SIZE
        else:
            if("x" in key):
                currentX += key["x"] * STD_SIZE;

            if("w" in key):
                nextWidth = key["w"] * STD_SIZE;

    currentX = 0;
    currentY += STD_SIZE
            

print(module.generateCode());
print("switchHoles()\ncube([14,14,1]);");
