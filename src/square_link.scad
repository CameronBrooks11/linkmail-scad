use <link_utils.scad>;

module square_link(link_loop_rad, link_circle_rad, loop_skew, cut_offset, fn = 16)
{
    height = link_height(link_loop_rad, link_circle_rad, loop_skew);
    cut_link_faces(cut_offset = cut_offset, link_loop_rad = link_loop_rad, link_circle_rad = link_circle_rad,
                   height = height) union()
    {
        for (th = [0:90:270])
        {
            rotate([ 0, 0, th ]) translate([ link_loop_rad, 0, 0 ]) rotate([ loop_skew, 0, 0 ])
                rotate_extrude(convexity = 10, $fn = fn) translate([ link_loop_rad, 0, 0 ])
                    circle(r = link_circle_rad, $fn = fn);
        }

        cylinder(h = height * 2, r1 = link_circle_rad * 2, r2 = link_circle_rad * 2, $fn = fn, center = true);
    }
}

// TODO: octagonal like tri hex