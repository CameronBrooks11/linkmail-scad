// A triangle link, and a ring of six of them.
use <../src/triangle_link.scad>;

/* [Link] */
// Radius of the round wire the loops are made of (mm)
example_link_circle_rad = 2.4; // [0.5:0.1:4]
// Radius of each loop (mm)
example_link_loop_rad = 7.2; // [2:0.5:20]
// How far each loop tilts out of the flat (degrees)
example_loop_skew = 45; // [15:75]
// How much to cut off the top and bottom so the link sits flat (mm); less than twice the wire radius
example_cut_offset = 1.6; // [0:0.1:4]

/* [Ring] */
// Which to draw
render_select = "both"; // [both, tri_link, hex_link]
// Spacing factor between the links in the ring
example_tri_hex_link_spacing = 0.5; // [0:0.01:1]

if (render_select == "both" || render_select == "tri_link")
    triangle_link(link_loop_rad = example_link_loop_rad, link_circle_rad = example_link_circle_rad,
                  loop_skew = example_loop_skew, cut_offset = example_cut_offset);

tri_hex_shift = (render_select == "both") ? example_link_loop_rad * 10 : 0;

if (render_select == "both" || render_select == "hex_link")
    translate([ tri_hex_shift, 0, 0 ])
        tri_hex_link(link_circle_rad = example_link_circle_rad, link_loop_rad = example_link_loop_rad,
                     link_spacing = example_tri_hex_link_spacing)
            triangle_link(link_loop_rad = example_link_loop_rad, link_circle_rad = example_link_circle_rad,
                          loop_skew = example_loop_skew, cut_offset = example_cut_offset);
