use <link_utils.scad>;
use <square_link.scad>;

/*
 * square_mail
 *
 * An n by m sheet of interlocking square links that prints in place: each
 * link sits as close to its neighbours as leaves `clearance` mm between
 * them (see square_mail_spacing()).
 */
module square_mail(link_loop_rad, link_circle_rad, loop_skew, cut_offset, n, m, clearance = 0.4)
{
    space = square_mail_spacing(link_loop_rad, link_circle_rad, loop_skew, cut_offset, clearance);

    for (i = [0:n - 1])
    {
        for (j = [0:m - 1])
        {
            translate([ i * space, j * space, 0 ]) square_link(link_loop_rad = link_loop_rad, link_circle_rad = link_circle_rad,
                                                               loop_skew = loop_skew, cut_offset = cut_offset);
        }
    }
}
