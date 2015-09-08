module switchHole(holeSize, height)
{
    translate(-[holeSize[0], holeSize[1], 0] / 2)
    cube(holeSize[0], holeSize[1], height);
}

PADDING = 0.2;
SWITCH_SIZE = [14,14];
HOLE_SIZE = SWITCH_SIZE + [PADDING * 2, PADDING * 2];

PLATE_HEIGHT = 1.6;

difference()
{
    cube([20,20,PLATE_HEIGHT]);
    translate([20/2,20/2,-1])
    switchHole(HOLE_SIZE, 2 + 2);
}
