// One square link: four tilted loops around a hub, cut flat top and bottom.
use <../src/square_link.scad>;

/* [Link] */
// Radius of the round wire the loops are made of (mm)
example_link_circle_rad = 2.0; // [0.5:0.1:4]
// Radius of each loop (mm)
example_link_loop_rad = 6; // [2:0.5:15]
// How far each loop tilts out of the flat (degrees)
example_loop_skew = 45; // [15:75]
// How much to cut off the top and bottom so the link sits flat (mm); less than twice the wire radius
example_cut_offset = 1.2; // [0:0.1:4]

square_link(link_loop_rad = example_link_loop_rad, link_circle_rad = example_link_circle_rad,
            loop_skew = example_loop_skew, cut_offset = example_cut_offset);
