
module stabilizer(wireDiameter, cubeSize)
{
    wireDiameter = 1;
    cubeSize = 2;

    cube([cubeSize, cubeSize, cubeSize + wireDiameter]);
    translate([wireDiameter * 2 + cubeSize, 0, 0])
    cube([cubeSize, cubeSize, cubeSize + wireDiameter]);
    translate([wireDiameter + cubeSize, 0, wireDiameter])
    cube([cubeSize, cubeSize, cubeSize]);
    
}

module fullStabilizer(width, length, height)
{
    translate(-[width / 2, length / 2, height])
    cube([width, length, height]);

    children(0);
}

WIRE_DIAMETER = 1.1;
CUBE_SIZE = 2;

MOUNT_LENGTH = 6;
MOUNT_WIDTH = 8;
MOUNT_HEIGHT = 5;

fullStabilizer(MOUNT_WIDTH, MOUNT_LENGTH, MOUNT_HEIGHT)
translate(-[(CUBE_SIZE * 2 + WIRE_DIAMETER * 2) / 2, CUBE_SIZE / 2, 0])
stabilizer(WIRE_DIAMETER, CUBE_SIZE);
    
