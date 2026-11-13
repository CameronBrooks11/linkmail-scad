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
 * loop_centre, loop_axis, loop_point
 *
 * Loop k of a link with `loops` loops, centred at the origin, as built by
 * square_link() and triangle_link(): the centre and unit axis of the loop's
 * core circle, and the point at angle t on that circle.
 */
function loop_centre(link_loop_rad, k, loops) =
    let(th = k * 360 / loops) link_loop_rad * [ cos(th), sin(th), 0 ];

function loop_axis(loop_skew, k, loops) =
    let(th = k * 360 / loops) [ sin(loop_skew) * sin(th), -sin(loop_skew) * cos(th), cos(loop_skew) ];

function loop_point(link_loop_rad, loop_skew, k, loops, t) =
    let(th = k * 360 / loops, a = link_loop_rad * cos(t), b = link_loop_rad * sin(t) * cos(loop_skew))
        loop_centre(link_loop_rad, k, loops) +
    [ a * cos(th) - b * sin(th), a * sin(th) + b * cos(th), link_loop_rad * sin(t) * sin(loop_skew) ];

/*
 * point_circle_distance
 *
 * Distance from point p to the circle with centre c, unit axis n and radius r.
 */
function point_circle_distance(p, c, n, r) = let(q = p - c, z = q * n) norm([ norm(q - z * n) - r, z ]);

/*
 * point_cylinder_distance
 *
 * Distance from point p to a solid cylinder of radius r, centred at c with
 * its axis along z, reaching half_height above and below c. Zero inside.
 */
function point_cylinder_distance(p, c, r, half_height) =
    let(q = p - c) norm([ max(norm([ q.x, q.y ]) - r, 0), max(abs(q.z) - half_height, 0) ]);

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
