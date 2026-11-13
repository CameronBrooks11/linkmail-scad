use <link_utils.scad>;

// Radius of the hub at the centre of a square link.
function square_link_hub_rad(link_circle_rad) = link_circle_rad * 2;

module square_link(link_loop_rad, link_circle_rad, loop_skew, cut_offset, fn = 16)
{
    height = link_height(link_loop_rad, link_circle_rad, loop_skew);
    hub_rad = square_link_hub_rad(link_circle_rad);
    cut_link_faces(cut_offset = cut_offset, link_loop_rad = link_loop_rad, link_circle_rad = link_circle_rad,
                   height = height) union()
    {
        for (th = [0:90:270])
        {
            rotate([ 0, 0, th ]) translate([ link_loop_rad, 0, 0 ]) rotate([ loop_skew, 0, 0 ])
                rotate_extrude(convexity = 10, $fn = fn) translate([ link_loop_rad, 0, 0 ])
                    circle(r = link_circle_rad, $fn = fn);
        }

        cylinder(h = height * 2, r1 = hub_rad, r2 = hub_rad, $fn = fn, center = true);
    }
}

/*
 * square_link_gap
 *
 * The smallest gap between two square links placed `spacing` apart along x,
 * measured on the true surfaces: loop against loop, and loop against hub.
 * Negative when they overlap. Links one step apart diagonally, or two steps
 * apart, are further away than this for any spacing that leaves a gap.
 *
 * samples: points taken on each loop's core circle. Sampling can only
 * overestimate the gap; 180 samples came within 0.0005 mm of 1440 for
 * loop radii of 3.5 and 6 mm. The rendered links are polygons inside the
 * true surfaces, so their gap is at least this one.
 */
function square_link_gap(link_loop_rad, link_circle_rad, loop_skew, cut_offset, spacing, samples = 180) =
    let(L = link_loop_rad, r = link_circle_rad, s = loop_skew, offset = [ spacing, 0, 0 ],
        half_height = link_height(L, r, s) - cut_offset, ts = [for (i = [0:samples - 1]) i * 360 / samples],
        loop_loop = min([for (j = [0:3], t = ts) let(p = loop_point(L, s, j, 4, t) + offset) for (k = [0:3])
                point_circle_distance(p, loop_centre(L, k, 4), loop_axis(s, k, 4), L)]) -
                    2 * r,
        loop_hub = min([for (k = [0:3], t = ts)
                point_cylinder_distance(loop_point(L, s, k, 4, t), offset, square_link_hub_rad(r), half_height)]) -
                   r) min(loop_loop, loop_hub);

/*
 * square_mail_spacing
 *
 * The distance between neighbouring square links in square_mail(): the
 * smallest that leaves at least `clearance` mm between them. Stops with a
 * message when no spacing leaves that much, giving the most there can be.
 */
function square_mail_spacing(link_loop_rad, link_circle_rad, loop_skew, cut_offset, clearance) =
    let(gap = function(d) square_link_gap(link_loop_rad, link_circle_rad, loop_skew, cut_offset, d),
        // Links interlock only between 2 and 4 loop radii apart, and the gap
        // rises to one peak in between.
        widest = _peak(gap, 2 * link_loop_rad, 4 * link_loop_rad, 30), most = gap(widest))
        assert(most >= clearance, str("square_mail: these links leave at most ", most,
                                      " mm between them at any spacing, less than the clearance of ", clearance,
                                      " mm. Use a larger link_loop_rad or a smaller link_circle_rad."))
            _first_reaching(gap, clearance, 2 * link_loop_rad, widest, 25);

// Ternary search for the maximum of f on [lo, hi].
function _peak(f, lo, hi, steps) = steps == 0 ? (lo + hi) / 2
                                   : let(a = lo + (hi - lo) / 3, b = hi - (hi - lo) / 3)
                                         f(a) < f(b) ? _peak(f, a, hi, steps - 1) : _peak(f, lo, b, steps - 1);

// Bisection for the smallest x in [lo, hi] with f(x) >= target, where f
// rises on the interval and f(hi) >= target. Returns the upper bound.
function _first_reaching(f, target, lo, hi, steps) = steps == 0 ? hi
                                                     : let(mid = (lo + hi) / 2)
                                                           f(mid) >= target
                                                         ? _first_reaching(f, target, lo, mid, steps - 1)
                                                         : _first_reaching(f, target, mid, hi, steps - 1);
