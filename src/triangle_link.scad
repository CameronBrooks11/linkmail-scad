use <link_utils.scad>;

module triangle_link(link_loop_rad, link_circle_rad, loop_skew, cut_offset, fn = 16)
{
    height = link_height(link_loop_rad, link_circle_rad, loop_skew);
    cut_link_faces(cut_offset = cut_offset, link_loop_rad = link_loop_rad, link_circle_rad = link_circle_rad,
                   height = height) union()
    {
        for (th = [0:120:240])
        {
            rotate([ 0, 0, th ]) translate([ link_loop_rad, 0, 0 ]) rotate([ loop_skew, 0, 0 ])
                rotate_extrude(convexity = 10, $fn = fn) translate([ link_loop_rad, 0, 0 ])
                    circle(r = link_circle_rad, $fn = fn);
        }

        cylinder(h = height * 2, r1 = link_circle_rad, r2 = link_circle_rad, $fn = fn, center = true);
    }
}

module tri_hex_link(link_circle_rad, link_loop_rad, link_spacing = 0.5)
{



    space = linkmail_spacing(link_loop_rad, link_circle_rad, link_spacing);


    for (i = [0:5])
    {
        rotate([ 0, 0, i * 60 ]) translate([ space, 0, 0 ]) children();
    }
}