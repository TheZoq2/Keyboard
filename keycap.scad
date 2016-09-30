$fn = 100;

module mountingCross(width, length, barWidth, height, useSupport = false)
{
    diameter = 6;
    barLength = 4.7;
    
    rotate(90)
    difference()
    {
        //cylinder(d = diameter, h = height);
        union()
        {
            //cylinder(d = diameter, h = height);
            translate(- [width / 2, length / 2, 0])
            cube([width, length, height], centered=true);

            if(useSupport)
            {
                translate([0,-50,0])
                cube([0.5, 100, 2 * height / 3]);
            }
        }

        translate([-barWidth / 2, -barLength / 2, 0])
        cube([barWidth, barLength, height]);
        
        
        rotate(90)
        {
            translate([-barWidth / 2, -barLength, 0])
            cube([barWidth, barLength * 2, height]);
        }
    }
}
module stabilizerMounts(size, holeSize, interDistance, startHeight)
{
    for(i = [-1, 1])
    {
        translate([-size[0] / 2, interDistance * i - size[1] / 2, startHeight])
        difference()
        {
            cube(size);
            translate([size[0] / 2 - holeSize[0] / 2, size[1] / 2 - holeSize[1] / 2, 0])
            cube([holeSize[0], holeSize[1], size[2]]);
            //rotate(90)
            //children(0);
        }
    }
}

module keycapShape(width, length, height, topWidth, topLength, roundTop = true)
{
    //Parameters
    //width = 18;
    //length = 18;
    //height = 12;
    roundoffRadius = 25;

    //Calculating the angles of the "cutters"

    sideDifference = (width - topWidth) / 2;
    sideCutAngle = atan(height / sideDifference);
    frontDifference = (length - topLength);
    frontCutAngle = atan(length / frontDifference);
    
    roundoffHeight = sqrt(pow(roundoffRadius, 2) - pow(topLength / 2, 2));

    difference()
    {
        cube([width, length, height]);

        translate([-1,0,0])
        for(i = [0 , 1])
        {
            translate([0,i * length,0])
            mirror([0,i,0])
            rotate(sideCutAngle, [1,0,0])
            cube([width * 2, length * 2, height * 2]);
        }
        
        //Cutting of the front face
        translate([-1,0,0]);
        rotate(-frontCutAngle, [0,1,0])
        cube([width * 2, length * 2, height * 2]);

        if(roundTop)
        {
            //Rounding off the top
            translate([0, length / 2, height + roundoffHeight])
            rotate(90, [0,1,0])
            cylinder(r = roundoffRadius, h = length * 2);
        }
    }
    
}

module supportV(width, length, height)
{
    cubeWidth = sqrt(pow(width / 2, 2) + pow(height, 2));
    angle = atan(height / (width / 2));

    translate([0, -length / 2, -height])
    for(i = [0,1])
    {
        mirror([i,0,0])
        rotate(-angle, [0,1,0])
        cube([cubeWidth, length, height]);
    }
}

module supportTriangle(width, length, height)
{
    intersection()
    {
        supportV(width, length, height);
        rotate(90)
        supportV(width, length, height);
    }
}

module keycap(outerSize, topSize, roundTop = true, useSupport = true)
{
    width = outerSize[0];
    length = outerSize[1];
    //height = 12;
    height = 10;
    topWidth = topSize[0];
    topLength = topSize[1];

    thickness = 1;
    supportHeight = 4;

    crossStartHeight = 0;

    intersection()
    {
        keycapShape(width, length, height, topWidth, topLength, roundTop = roundTop);
        union()
        {
            difference()
            {
                keycapShape(width, length, height, topWidth, topLength, roundTop = roundTop);
                translate([thickness, thickness, 0])
                keycapShape(width - thickness * 2, length - thickness * 2, height - thickness * 2, topWidth - thickness * 2, topLength - thickness * 2, roundTop = roundTop);
            }

            if(useSupport)
            {
                //Support structure
                translate([width - topWidth / 2 - thickness, length / 2, height - thickness * 2])
                supportTriangle(topWidth, topLength, supportHeight);
            }

            //translate([width / 2 - 2, length / 2 - 2, 0])
            //cube([4, 4, height]);
            translate([width / 2, length / 2, crossStartHeight])
            {
                rotate(90)
                children(0);
            }

            
            translate([width/2 -2.5, length / 2-2.5,0])
            difference()
            {
                cube([5,5,crossStartHeight]);
                translate([1,0,0])
                cube([3,6,crossStartHeight]);
            }
        }
    }
}


crossWidth = 1.5;

STD_OUTER_SIZE = [18, 18];
STD_INNER_SIZE = [12, 12];

STD_OUTER_SIZE = [18, 18];
STD_INNER_SIZE = [12, 12];

R_SHIFT_OUTER = [STD_OUTER_SIZE[0], STD_OUTER_SIZE[1]];
R_SHIFT_INNER = [STD_INNER_SIZE[0], STD_INNER_SIZE[1]];

MOUNT_OUTER_SIZE = [4.3, 5.8, 8]; //Does not affect the keycaps for now
MOUNT_CAP_SIZE = [4.3, 5.8, 3];

ST_MOUNT_OUTERSIZE = [10,5,100];
ST_MOUNT_HOLE_SIZE = [7,1];
ST_INTER_DISTANCE = 14;
ST_START_HEIGHT = 3;

keycap(STD_OUTER_SIZE, STD_INNER_SIZE, roundTop = true, useSupport = true)
mountingCross(MOUNT_OUTER_SIZE[0], MOUNT_OUTER_SIZE[1], 1.6, MOUNT_OUTER_SIZE[2], useSupport = false)
cube([0,0,0]);

//keycap(R_SHIFT_OUTER, R_SHIFT_INNER, roundTop = false, useSupport = true)
//union()
//{
//    rotate(90)
//    mountingCross(4, 5.5, crossWidth, 10, useSupport = false)
//    stabilizerMounts(ST_MOUNT_OUTERSIZE, ST_MOUNT_HOLE_SIZE, ST_INTER_DISTANCE, ST_START_HEIGHT);
//    //mountingCross(4, 5.5, crossWidth, 10, useSupport = false);
//}


//mountingCross(MOUNT_OUTER_SIZE[0], MOUNT_OUTER_SIZE[1], 1.6, MOUNT_OUTER_SIZE[2], useSupport = false);
//rotate(-90)
//translate([-MOUNT_CAP_SIZE[0] / 2, -MOUNT_CAP_SIZE[1] / 2, MOUNT_OUTER_SIZE[2] - MOUNT_CAP_SIZE[2]])
//{
//    cube(MOUNT_CAP_SIZE);
//}
