/*
 * link_height
 *
 * Calculate the height of a link in a chainmail pattern.
 *
 * link_loop_rad: The radius of the loop of the link.
 * link_circle_rad: The radius of the circle of the link.
 * loop_skew: The skew of the loop of the link.
 *
 * Returns: The height of the link.
 */
function link_height(link_loop_rad, link_circle_rad, loop_skew) = (link_loop_rad)*sin(loop_skew) + link_circle_rad;

/*
 * linkmail_spacing
 *
 * Calculate the spacing between links in a chainmail pattern.
 *
 * link_loop_rad: The radius of the loop of the link.
 * link_circle_rad: The radius of the circle of the link.
 * link_spacing: The spacing between links.
 *
 * Returns: The spacing between links.
 * @details:
 *      0 - 1 ; 2 - 4 ; +1 - -1
 *      space_min = link_loop_rad * 2 + link_circle_rad;
 *      space_max = link_loop_rad * 4 - link_circle_rad;
 */
function linkmail_spacing(link_loop_rad, link_circle_rad,
                          link_spacing) = link_loop_rad * (2 + 2 * link_spacing) + link_circle_rad * 2 *
                                                                                       (1 - 2 * link_spacing);

/*
 * cut_link_faces
 *
 * Cut the faces of a link to make it easier to print.
 *
 * cut_offset: The offset to cut the faces.
 * link_loop_rad: The radius of the loop of the link.
 * link_circle_rad: The radius of the circle of the link.
 * height: The height of the link.
 */
module cut_link_faces(cut_offset, link_loop_rad, link_circle_rad, height)
{
    zFite = $preview ? 0.1 : 0.0;

    difference()
    {
        // link to cut
        children();

        // cut faces
        for (i = [0:1])
            mirror([ 0, 0, i ]) translate([ 0, 0, -cut_offset / 2 + height + zFite / 2 ]) color("red") cube(
                [
                    link_loop_rad * 4 + link_circle_rad * 2, link_loop_rad * 4 + link_circle_rad * 2, cut_offset + zFite
                ],
                center = true);
    }
}

module link_gen()
{
}