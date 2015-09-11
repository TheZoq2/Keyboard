
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

module stabilizerKeyPart()
{
    wireMountSize = [13, 3, 2];
    wireHoleSize = [12, 1.5, 2];
    mountWidth = 6;
    mountHeight = 0.7;
    mountLength = 4;

    translate([-mountWidth / 2, 0, 0])
    cube([mountWidth, mountLength, mountHeight]);
    
    translate([-wireMountSize[0] / 2, mountLength, 0])
    difference()
    {
        cube(wireMountSize);
        translate([wireMountSize[0] / 2 - wireHoleSize[0] / 2, wireMountSize[1] / 2 - wireHoleSize[1] / 2, 0])
        cube(wireHoleSize);
    }
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

!stabilizerKeyPart();
