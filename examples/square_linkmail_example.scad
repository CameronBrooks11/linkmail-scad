use <../src/linkmail.scad>;

// radius of the extruded circular cross section of the link
example_link_circle_rad = 1;

// radius of the loop of the link
example_link_loop_rad = 3;

// skew of the loop of the link
example_loop_skew = 45; //  [15:75]

// offset to cut the faces of the link from the top +z and -z of the link
example_cut_offset = 1;

n = 3;
m = 3;

link_spacing = 0.5; // [0:0.01:1]

// module square_mail(loop_link_rad, circle_link_rad, loop_skew, cut_offset, n, m)

// link_loop_rad, link_circle_rad,
square_mail(link_loop_rad = example_link_loop_rad, link_circle_rad = example_link_circle_rad,
            loop_skew = example_loop_skew, cut_offset = example_cut_offset, n = n, m = m, link_spacing = link_spacing);