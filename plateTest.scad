module switchHole(holeSize, height)
{
    translate(-[holeSize[0], holeSize[1], 0] / 2)
    cube(holeSize[0], holeSize[1], height);
}

PADDING = 0.2;
SWITCH_SIZE = [14,14];
HOLE_SIZE = SWITCH_SIZE + [PADDING * 2, PADDING * 2];

PLATE_HEIGHT = 1.6;


MOUNT_LENGTH = 6;
MOUNT_WIDTH = 8;
MOUNT_HEIGHT = 5;

STABILIZER_DISTANCE = 15;

difference()
{
    cube([25,40,PLATE_HEIGHT]);
    translate([20/2,40/2,-1])
    {
        switchHole(HOLE_SIZE, 2 + 2);

        for(i = [-STABILIZER_DISTANCE, STABILIZER_DISTANCE])
        {
            translate([-MOUNT_WIDTH / 2 + 15/2,i - MOUNT_LENGTH / 2,0])
            cube([MOUNT_WIDTH + PADDING * 2, MOUNT_LENGTH + PADDING * 2, MOUNT_HEIGHT]);
        }
    }
}

