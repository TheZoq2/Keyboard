use <ergo.scad>

$fn=30;

module switchHole()
{
    innerHeight = 1.5;
    outerHeight = 100;

    padding = 0.3;
    innerWidth = 14 + padding * 2;
    outerWidth = 16 + padding * 2;
    innerSize = [innerWidth, innerWidth, innerHeight];
    outerSize = [outerWidth, outerWidth, outerHeight];

    
    translate([outerWidth / 2, outerWidth / 2, 0])
    union()
    {
        translate(-[innerWidth / 2, innerWidth / 2, 0])
        cube(innerSize);

        translate([-outerWidth / 2, -outerWidth / 2, innerHeight])
        cube(outerSize);
    }
}

STD_SIZE = 18.5;
FRAME_PADDING = 3;

module part1()
{
    difference()
    {
        //translate([-2, -2, 0])
        //cube([60, 113, 4]);
        translate([-FRAME_PADDING, 0, 0])
        union()
        {
            translate([0,-FRAME_PADDING, 0])
            cube([STD_SIZE * 4 +STD_SIZE*0.25 + FRAME_PADDING, STD_SIZE + FRAME_PADDING, 4]);
            translate([0,STD_SIZE])
            cube([STD_SIZE * 4 + FRAME_PADDING, STD_SIZE, 4]);
            translate([0,STD_SIZE * 2])
            cube([1.5 * STD_SIZE + STD_SIZE * 3 + FRAME_PADDING, STD_SIZE, 4]);
            translate([0,STD_SIZE * 3])
            cube([1.75 * STD_SIZE + STD_SIZE * 3 + FRAME_PADDING, STD_SIZE, 4]);
            translate([0,STD_SIZE * 4])
            cube([1.25 * STD_SIZE + STD_SIZE * 3 + FRAME_PADDING, STD_SIZE, 4]);
            translate([0,STD_SIZE * 5])
            cube([1.25 * STD_SIZE + STD_SIZE * 3 + FRAME_PADDING, STD_SIZE + FRAME_PADDING, 4]);
        }
        switchHoles()
        //cube([14,14,1]);
        switchHole();
    }

    SCREWBLOCK_WIDTH = 6;
    translate([1.75 * STD_SIZE + STD_SIZE * 3 - 2, STD_SIZE * 3.5 - SCREWBLOCK_WIDTH / 2, 1.5])
    {
        difference()
        {
            cube([2,SCREWBLOCK_WIDTH, 6.5+ 4 - 1.5]);
            translate([0,SCREWBLOCK_WIDTH / 2,4 - 1.5 + 4])
            rotate(90, [0,1,0])
            cylinder(d = 3.5, h = 10);
        }
    }
}

module part2()
{
    difference()
    {
        //translate([-2, -2, 0])
        //cube([60, 113, 4]);
        //translate([-FRAME_PADDING, 0, 0])
        union()
        {
            translate([STD_SIZE * 4 +STD_SIZE*0.25,-FRAME_PADDING, 0])
            cube([STD_SIZE * 5 +STD_SIZE*0.25 + FRAME_PADDING, STD_SIZE + FRAME_PADDING, 4]);
            translate([STD_SIZE * 4,STD_SIZE])
            cube([STD_SIZE * 5, STD_SIZE, 4]);
            translate([1.5 * STD_SIZE + STD_SIZE * 3,STD_SIZE * 2])
            cube([STD_SIZE * 5, STD_SIZE, 4]);
            translate([1.75 * STD_SIZE + STD_SIZE * 3,STD_SIZE * 3])
            cube([STD_SIZE * 5, STD_SIZE, 4]);
            translate([1.25 * STD_SIZE + STD_SIZE * 3,STD_SIZE * 4])
            cube([STD_SIZE * 5, STD_SIZE, 4]);
            translate([1.25 * STD_SIZE + STD_SIZE * 3,STD_SIZE * 5])
            cube([STD_SIZE * 5, STD_SIZE + FRAME_PADDING, 4]);
        }
        switchHoles()
        //cube([14,14,1]);
        switchHole();
    }

    SCREWBLOCK_WIDTH = 6;
    translate([1.75 * STD_SIZE + STD_SIZE * 3, STD_SIZE * 3.5 - SCREWBLOCK_WIDTH / 2, 1.5])
    {
        difference()
        {
            cube([2,SCREWBLOCK_WIDTH, 6.5+ 4 - 1.5]);
            translate([0,SCREWBLOCK_WIDTH / 2,4 - 1.5 + 4])
            rotate(90, [0,1,0])
            cylinder(d = 3.5, h = 10);
        }
    }
    SCREWBLOCK_WIDTH = 6;
    translate([1.75 * STD_SIZE + STD_SIZE * 8 - 2, STD_SIZE * 3.5 - SCREWBLOCK_WIDTH / 2, 1.5])
    {
        difference()
        {
            cube([2,SCREWBLOCK_WIDTH, 6.5+ 4 - 1.5]);
            translate([0,SCREWBLOCK_WIDTH / 2,4 - 1.5 + 4])
            rotate(90, [0,1,0])
            cylinder(d = 3.5, h = 10);
        }
    }
}
module part3()
{
    difference()
    {
        //translate([-2, -2, 0])
        //cube([60, 113, 4]);
        //translate([-FRAME_PADDING, 0, 0])
        union()
        {
            translate([STD_SIZE * 9 + STD_SIZE * 0.66,-FRAME_PADDING, 0])
            cube([STD_SIZE * 5 + STD_SIZE*0.5 , STD_SIZE + FRAME_PADDING, 4]);

            translate([STD_SIZE * 9,STD_SIZE, 0])
            cube([STD_SIZE * 4 + STD_SIZE * 2 + FRAME_PADDING, STD_SIZE, 4]);

            translate([1.5 * STD_SIZE + STD_SIZE * 8,STD_SIZE * 2])
            cube([STD_SIZE * 4 + STD_SIZE * 1.5 + FRAME_PADDING, STD_SIZE, 4]);

            translate([1.75 * STD_SIZE + STD_SIZE * 8,STD_SIZE * 3])
            cube([STD_SIZE * 3 + STD_SIZE * 2.25 + FRAME_PADDING, STD_SIZE, 4]);

            translate([1.25 * STD_SIZE + STD_SIZE * 8,STD_SIZE * 4])
            cube([STD_SIZE * 4 + STD_SIZE * 1.75 + FRAME_PADDING, STD_SIZE, 4]);

            translate([1.25 * STD_SIZE + STD_SIZE * 8,STD_SIZE * 5])
            cube([STD_SIZE * 4 + STD_SIZE * 1.75 + FRAME_PADDING, STD_SIZE + FRAME_PADDING, 4]);
        }
        switchHoles()
        //cube([14,14,1]);
        switchHole();
    }

    SCREWBLOCK_WIDTH = 6;
    translate([1.75 * STD_SIZE + STD_SIZE * 8, STD_SIZE * 3.5 - SCREWBLOCK_WIDTH / 2, 1.5])
    {
        difference()
        {
            cube([2,SCREWBLOCK_WIDTH, 6.5+ 4 - 1.5]);
            translate([0,SCREWBLOCK_WIDTH / 2,4 - 1.5 + 4])
            rotate(90, [0,1,0])
            cylinder(d = 3.5, h = 10);
        }
    }
}

//part1();
//part2();
//part3();

HEIGHT = 4;

difference()
{
    cube([130,130, HEIGHT]);
    switchHoles()
    switchHole();
}

