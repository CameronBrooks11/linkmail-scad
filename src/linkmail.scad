use <link_utils.scad>;
use <square_link.scad>;
use <triangle_link.scad>;

module triangle_mail()
{
}

module square_mail(link_loop_rad, link_circle_rad, loop_skew, cut_offset, n, m, link_spacing = 0.5)
{

    space = linkmail_spacing(link_loop_rad, link_circle_rad, link_spacing);

    for (x = [0:space:space * (n - 1)])
    {
        for (y = [0:space:space * (m - 1)])
        {
            translate([ x, y, 0 ]) square_link(link_loop_rad = link_loop_rad, link_circle_rad = link_circle_rad,
                                               loop_skew = loop_skew, cut_offset = cut_offset);
        }
    }
}

module triangle_hex_mail()
{

    external_space = internal_radius * 3;

    for (x = [0:external_space:external_space * (n - 1)])
    {
        for (y = [0:external_space:external_space * (m - 1)])
        {
            translate([ x, y * sqrt(3), 0 ]) hex_links();
        }
    }
}