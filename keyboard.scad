include <layout.scad>

module switchHole()
{
    innerHeight = 1.5;
    outerHeight = 100;

    padding = 0.3;
    innerWidth = 14 + padding * 2;
    outerWidth = 16 + padding * 2;
    innerSize = [innerWidth, innerWidth, innerHeight];
    outerSize = [outerWidth, outerWidth, outerHeight];

    
    union()
    {
        translate(-[innerWidth / 2, innerWidth / 2, 0])
        cube(innerSize);

        translate([-outerWidth / 2, -outerWidth / 2, innerHeight])
        cube(outerSize);
    }
}

difference()
{
    translate([-2, -2, 0])
    cube([60, 113, 4]);
    switchHoles()
    switchHole();
}

