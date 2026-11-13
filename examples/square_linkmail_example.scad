use <../src/linkmail.scad>;

// radius of the extruded circular cross section of the link
example_link_circle_rad = 1;

// radius of the loop of the link
example_link_loop_rad = 3.5;

// skew of the loop of the link
example_loop_skew = 45; //  [15:75]

// offset to cut the faces of the link from the top +z and -z of the link
example_cut_offset = 1;

n = 3;
m = 3;

// minimum gap between neighbouring links, in mm
clearance = 0.4; // [0.2:0.05:0.8]

square_mail(link_loop_rad = example_link_loop_rad, link_circle_rad = example_link_circle_rad,
            loop_skew = example_loop_skew, cut_offset = example_cut_offset, n = n, m = m, clearance = clearance);