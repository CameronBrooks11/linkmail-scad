default:
    @just --list

# Run the function checks, render every example, and check the sheet's links are separate
test:
    @out=$(openscad --hardwarnings -o - --export-format echo tests/test_linkmail.scad 2>/dev/null); echo "$out" | grep -q 'all checks passed' || { echo "$out" | grep -E 'ERROR|WARNING'; exit 1; }; echo "function checks passed"
    @for f in examples/*.scad; do log=$(openscad --hardwarnings -o - --export-format binstl "$f" 2>&1 >/dev/null) || { echo "$f:"; echo "$log"; exit 1; }; echo "rendered $f"; done
    @log=$(openscad -D example_cut_offset=4.1 -o - --export-format binstl examples/square_link_example.scad 2>&1 >/dev/null) && { echo "a 4.1 mm cut on a 2 mm tube rendered"; exit 1; }; echo "$log" | grep -q 'severs the loops' && echo "a cut that severs the loops is refused"
    @stl=$(mktemp --suffix .stl) && openscad --hardwarnings --export-format binstl -o "$stl" examples/square_linkmail_example.scad 2>/dev/null && python3 tests/count_solids.py "$stl" 9; rc=$?; rm -f "$stl"; exit $rc

# Regenerate the README pictures in assets/
images:
    @mkdir -p assets
    @openscad --render --camera=0,0,0,50,0,30,0 --viewall --autocenter --imgsize=800,600 -o assets/square_link.png examples/square_link_example.scad 2>/dev/null && echo "assets/square_link.png"
    @openscad --render --camera=0,0,0,40,0,30,0 --viewall --autocenter --imgsize=800,600 -o assets/square_mail.png examples/square_linkmail_example.scad 2>/dev/null && echo "assets/square_mail.png"
    @openscad --render --camera=0,0,0,40,0,20,0 --viewall --autocenter --imgsize=800,500 -o assets/triangle_links.png examples/triangle_link_example.scad 2>/dev/null && echo "assets/triangle_links.png"
