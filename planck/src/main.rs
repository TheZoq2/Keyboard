//"Import" the module along with the macros
#[macro_use]
extern crate scad_generator;
extern crate scad_util as su;

//Avoid having to write scad_generator:: everywhere
use scad_generator::*;
use su::electronics;

enum Side
{
    LEFT,
    RIGHT
}

fn get_usb_port_mount() -> ScadObject
{
    let breakout = electronics::PolouMicroUsbBreakout::new();

    let triangle_width = breakout.width;
    let triangle_length = breakout.hole_diameter + breakout.hole_distance_from_back;

    let triangle = {
        let cube = scad!(Cube(vec3(triangle_width, triangle_length, triangle_length)));

        let cutout = scad!(Rotate(45., vec3(1., 0., 0.));
        {
            scad!(Cube(vec3(triangle_width, triangle_length * 2., triangle_length * 2.))),
        });

        scad!(Translate(vec3(0.,triangle_length,0.));{
            scad!(Rotate(180., vec3(1., 0., 0.));
            {
                scad!(Difference;
                {
                    cube,
                    cutout
                })
            })
        })
    };


    scad!(Union;
    {
        scad!(Translate(vec3(-triangle_width / 2., 0., 0.));{
            triangle
        }),
        breakout.hole_shape()
    })
}

//1.5mm chamfer is added after generation in blender.
qstruct!(Keyboard(rows: i32, cols: i32)
{
    rows: i32 = rows,
    cols: i32 = cols,
    grid_spacing: f32 = 18.5,
    top_thickness: f32 = 1.5,
    side_thickness: f32 = 3.0,
    inner_height: f32 = 12.,
});


impl Keyboard 
{
    pub fn get_main(&self, side: Side) -> ScadObject
    {
        let grid = 
        {
            let height_offset =  self.total_height() - self.top_thickness;
            scad!(Translate(vec3(0., 0., height_offset));
            {
                self.get_grid(),
                self.get_screwholes()
            })
        };

        let (usb_port_hole, usb_port_mount) = match side
        {
            Side::LEFT =>
            {
                self.usb_mount(Side::LEFT)
            }
            Side::RIGHT =>
            {
                self.usb_mount(Side::RIGHT)
            }
        };


        scad!(Difference;{
            scad!(Union;
            {
                self.get_frame(),
                usb_port_mount
            }),
            grid,
            usb_port_hole,
            self.get_magnets(side)
        })
    }

    fn usb_mount(&self, position: Side) -> (ScadObject, ScadObject)
    {
        let bottom_offset = 2.;
        let usb_breakout = electronics::PolouMicroUsbBreakout::new();

        let usb_offset_x = match position
        {
            Side::RIGHT => self.rows as f32 - 1.,
            Side::LEFT => 1.
        };
        let usb_offset_y = 1.;

        let usb_port_hole = {
            scad!(Translate(vec3(self.grid_spacing * usb_offset_x, -usb_offset_y, bottom_offset)); usb_breakout.board(10.))
        };
        let usb_port_mount = {
            let mount = scad!(Translate(vec3(self.grid_spacing * usb_offset_x, -usb_offset_y, -bottom_offset));
                {
                    get_usb_port_mount()
                });

            let flipped = scad!(Mirror(vec3(0.,0.,1.));mount);

            scad!(Translate(vec3(0., 0., usb_breakout.height));flipped)
        };
        
        (usb_port_hole, usb_port_mount)
    }

    pub fn get_frame(&self) -> ScadObject 
    {
        let inner_length = self.grid_spacing * self.rows as f32;
        let inner_width = self.grid_spacing * self.cols as f32;
        let length = inner_length + self.side_thickness * 2.;
        let width = inner_width+ self.side_thickness * 2.;
        let thickness = self.total_height();

        let main_cube = 
        {
            let cube = scad!(Cube(vec3(length, width, thickness)));
            
            scad!(Translate(vec3(-self.side_thickness, -self.side_thickness, 0.));{cube})
        };


        let inner_height = self.total_height() - self.top_thickness;
        let cutout = scad!(Cube(vec3(inner_length, inner_width, inner_height)));
        
        scad!(Difference;{
            main_cube,
            cutout
        })
    }


    pub fn get_grid(&self) -> ScadObject
    {
        let mut result  = scad!(Union);

        for x in 0..self.rows
        {
            for y in 0..self.cols
            {
                let x_pos = x as f32 * self.grid_spacing + self.grid_spacing / 2.;
                let y_pos = y as f32 * self.grid_spacing + self.grid_spacing / 2.;

                //let cube = scad!(Cube(vec3(15.0, 15.0, 5.0)));
                let translated = scad!(
                    Translate(vec3(x_pos, y_pos, 0.0));{
                        get_switch_hole()
                    });

                result.add_child(translated);
            }
        }
        
        result
    }


    pub fn get_screwholes(&self) -> ScadObject 
    {
        let x_positions = vec!(1, self.rows / 2, self.rows - 1);
        let y_positions = vec!(1, self.cols - 1);

        let screwhole_radius = 3.0;

        let mut result = scad!(Union);

        let screwhole = scad!(Cylinder(self.top_thickness, Diameter(screwhole_radius)));

        for x in x_positions.clone()
        {
            for y in y_positions.clone()
            {
                let x_pos = x as f32 * self.grid_spacing;
                let y_pos = y as f32 * self.grid_spacing;

                let translated = scad!(Translate(vec3(x_pos, y_pos, 0.));
                {
                    screwhole.clone()
                });

                result.add_child(translated);
            }
        }
        return result;
    }

    fn total_height(&self) -> f32
    {
        self.top_thickness + self.inner_height
    }

    fn get_magnets(&self, side: Side) -> ScadObject
    {
        let diameter = 5.8;
        let height = 2.2;
        let bottom_offset = diameter;
        
        let magnet = 
        {
            let cylinder = scad!(Cylinder(height, Diameter(diameter)));

            let rotated = scad!(Rotate(90., vec3(0., 1., 0.)); cylinder);

            scad!(Translate(vec3(0., 0., bottom_offset)); rotated)
        };

        let duplicated = 
        {
            let first = scad!(Translate(vec3(0., self.grid_spacing / 2., 0.)); magnet.clone());
            let second = scad!(Translate(vec3(0., self.grid_spacing * (self.cols as f32 - 0.5), 0.)); magnet.clone());

            scad!(Union;
            {
                first,
                second
            })
        };


        let mut result = match side
        {
            Side::RIGHT => {
                scad!(Translate(vec3(self.rows as f32 * self.grid_spacing, 0., 0.)); duplicated)
            },
            Side::LEFT => {
                scad!(Translate(vec3(-height, 0., 0.)); duplicated)
            }
        };


        result
    }
}


fn get_switch_hole() -> ScadObject 
{
    let inner_height = 1.5;
    let padding = 0.2;
    let inner_width = 14. + padding * 2.;

    let cube = scad!(Cube(vec3(inner_width, inner_width, inner_height)));

    scad!(Translate(vec3(-inner_width / 2., -inner_width / 2., 0.));
    {
        cube
    })
}


pub fn main()
{
    //Create an scad file object for storing the scad objects. This
    //allows us to set things like the detail level ($fn) for the models.
    let mut sfile = ScadFile::new();

    //Sets the $fn variable in scad which controls the detail level of things
    //like spheres. Look at the scad wiki for details
    sfile.set_detail(50);

    //Add the cube object to the file
    sfile.add_object(Keyboard::new(6, 4).get_main(Side::RIGHT));
    //sfile.add_object(Keyboard::new(3, 3).get_main(Side::LEFT));
    //sfile.add_object(get_usb_port_mount());
    //sfile.add_object(electronics.teensy_lc());
    //Save the scad code to a file
    sfile.write_to_file(String::from("out.scad"));
}
