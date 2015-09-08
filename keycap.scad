$fn = 100;

module mountingCross(barWidth, height)
{
    diameter = 6;
    barLength = 4.2;
    
    difference()
    {
        cylinder(d = diameter, h = height);

        translate([-barWidth / 2, -barLength / 2, 0])
        cube([barWidth, barLength, height]);
        
        rotate(90)
        {
            translate([-barWidth / 2, -barLength, 0])
            cube([barWidth, barLength * 2, height]);
        }
    }
}

module keycapShape(width, length, height, topWidth, topLength)
{
    //Parameters
    //width = 18;
    //length = 18;
    //height = 12;
    roundoffRadius = 25;

    //Calculating the angles of the "cutters"

    sideDifference = (width - topWidth) / 2;
    sideCutAngle = atan(height / sideDifference);
    frontDifference = (length - topWidth);
    frontCutAngle = atan(length / frontDifference);
    
    roundoffHeight = sqrt(pow(roundoffRadius, 2) - pow(topLength / 2, 2));

    difference()
    {
        cube([width, length, height]);

        translate([-1,0,0])
        for(i = [0 , 1])
        {
            translate([0,i * width,0])
            mirror([0,i,0])
            rotate(sideCutAngle, [1,0,0])
            cube([width * 2, length * 2, height * 2]);
        }
        
        //Cutting of the front face
        translate([-1,0,0]);
        rotate(-frontCutAngle, [0,1,0])
        cube([width * 2, length * 2, height * 2]);

        //Rounding off the top
        translate([0, length / 2, height + roundoffHeight])
        rotate(90, [0,1,0])
        cylinder(r = roundoffRadius, h = length * 2);
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

module keycap()
{
    width = 18;
    length = 18;
    height = 12;
    topWidth = 12;
    topLength = 12;

    thickness = 1;
    supportHeight = 4;

    crossStartHeight = 1.0;

    intersection()
    {
        keycapShape(width, length, height, topWidth, topLength);
        union()
        {
            difference()
            {
                keycapShape(width, length, height, topWidth, topLength);
                translate([thickness, thickness, 0])
                keycapShape(width - thickness * 2, length - thickness * 2, height - thickness * 2, topWidth - thickness * 2, topLength - thickness * 2);
            }

            //Support structure
            translate([width - topWidth / 2 - thickness, length / 2, height - thickness * 2])
            supportTriangle(topWidth, topLength, supportHeight);

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


crossWidth = 1.4;

keycap()
mountingCross(crossWidth, 10);
