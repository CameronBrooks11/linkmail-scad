// Checks for the geometry functions. Prints "linkmail: all checks passed"
// as its last line only if every assert held: an echo export reports a
// failed assert in its output and still exits 0.
// Run: openscad --hardwarnings -o - --export-format echo tests/test_linkmail.scad

use <../src/link_utils.scad>
use <../src/square_link.scad>

eps = 1e-9;

// loop_point() follows the transforms square_link() applies to each loop:
// rotate th about z, move out by the loop radius, tilt by the skew about x.
L = 3.5;
skew = 45;
for (k = [0:3], t = [0:30:330])
{
    th = k * 90;
    built = [ [ cos(th), -sin(th), 0 ], [ sin(th), cos(th), 0 ], [ 0, 0, 1 ] ] *
            ([ L, 0, 0 ] + [ [ 1, 0, 0 ], [ 0, cos(skew), -sin(skew) ], [ 0, sin(skew), cos(skew) ] ] *
                               [ L * cos(t), L * sin(t), 0 ]);
    p = loop_point(L, skew, k, 4, t);
    assert(norm(p - built) < eps, str("loop ", k, " at ", t, ": ", p, " is not ", built));
    assert(point_circle_distance(p, loop_centre(L, k, 4), loop_axis(skew, k, 4), L) < eps,
           str("loop ", k, " at ", t, " is on its own circle"));
}

// Distances to simple shapes.
assert(abs(point_circle_distance([ 0, 0, 4 ], [ 0, 0, 0 ], [ 0, 0, 1 ], 3) - 5) < eps, "point on the axis");
assert(abs(point_circle_distance([ 5, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 1 ], 3) - 2) < eps, "point in the plane");
assert(point_cylinder_distance([ 1, 0, 0 ], [ 0, 0, 0 ], 2, 1) == 0, "point inside the cylinder");
assert(abs(point_cylinder_distance([ 5, 0, 4 ], [ 0, 0, 0 ], 2, 1) - norm([ 3, 3 ])) < eps, "point off the rim");

// Links on top of each other overlap by a full tube diameter.
assert(abs(square_link_gap(L, 1, skew, 1, 2 * L) + 2) < eps, "links one loop apart overlap");

// With steep loops the neighbour's hub is closest: the loop's outermost
// point, 2 * L out along x, faces a hub of radius 2r at the spacing d, so
// the gap is d - 2L - 2r - r.
for (d = [ 9.0, 9.2, 9.3 ])
    assert(abs(square_link_gap(3, 1, 60, 1, d) - (d - 6 - 3)) < eps, str("hub sets the gap at spacing ", d));

// The spacing leaves the clearance, and is the closest that does.
for (c = [ 0.3, 0.4, 0.6 ])
{
    d = square_mail_spacing(L, 1, skew, 1, c);
    assert(square_link_gap(L, 1, skew, 1, d) >= c, str("spacing ", d, " leaves ", c, " mm"));
    assert(square_link_gap(L, 1, skew, 1, d - 0.01) < c, str("spacing ", d, " is the closest for ", c, " mm"));
}

echo("linkmail: all checks passed");
