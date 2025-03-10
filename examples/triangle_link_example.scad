use <../src/triangle_link.scad>;

/* [Link Parameters] */

// radius of the extruded circular cross section of the link
example_link_circle_rad = 2.4;

// radius of the loop of the link
example_link_loop_rad = example_link_circle_rad * 3;

// skew of the loop of the link
example_loop_skew = 45; //  [15:75]

// offset to cut the faces of the link from the top +z and -z of the link
example_cut_offset = 1.6;

// select which links to render
render_select = "both"; // [both, tri_link, hex_link]

if (render_select == "both" || render_select == "tri_link")
    triangle_link(link_loop_rad = example_link_loop_rad, link_circle_rad = example_link_circle_rad,
                  loop_skew = example_loop_skew, cut_offset = example_cut_offset);

// factor to adjust the spacing between the links
example_tri_hex_link_spacing = 0.5; // [0:0.01:1]

tri_hex_shift = (render_select == "both") ? example_link_loop_rad * 10 : 0;

if (render_select == "both" || render_select == "hex_link")
    translate([ tri_hex_shift, 0, 0 ])
        tri_hex_link(link_circle_rad = example_link_circle_rad, link_loop_rad = example_link_loop_rad,
                     link_spacing = example_tri_hex_link_spacing)
            triangle_link(link_loop_rad = example_link_loop_rad, link_circle_rad = example_link_circle_rad,
                          loop_skew = example_loop_skew, cut_offset = example_cut_offset);