//"Import" the module along with the macros
#[macro_use]
extern crate scad_generator;

//Avoid having to write scad_generator:: everywhere
use scad_generator::*;

qstruct!(Keyboard(rows: i32, cols: i32)
{
    rows: i32 = rows,
    cols: i32 = cols,
    grid_spacing: f32 = 18.5,
    top_thickness: f32 = 1.5,
    side_thickness: f32 = 3.0,
});

impl Keyboard 
{
    pub fn get_main(&self) -> ScadObject
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

        scad!(Difference;{
            self.get_frame(),
            grid
        })
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
        let x_positions = vec!(1, self.rows - 1);
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
        self.top_thickness + 10.
    }
}


fn get_switch_hole() -> ScadObject 
{
    let inner_height = 1.5;
    let padding = 0.1;
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
    sfile.add_object(Keyboard::new(4, 6).get_main());
    //Save the scad code to a file
    sfile.write_to_file(String::from("out.scad"));
}
