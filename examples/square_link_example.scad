use <../src/square_link.scad>;

// radius of the extruded circular cross section of the link
example_link_circle_rad = 2.0;

// radius of the loop of the link
example_link_loop_rad = example_link_circle_rad * 3;

// skew of the loop of the link
example_loop_skew = 45; //  [15:75]

// offset to cut the faces of the link from the top +z and -z of the link
example_cut_offset = 1.2;

square_link(link_loop_rad = example_link_loop_rad, link_circle_rad = example_link_circle_rad,
            loop_skew = example_loop_skew, cut_offset = example_cut_offset);