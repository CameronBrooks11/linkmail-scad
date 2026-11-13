"""Count the separate solids in a binary STL, and fail unless there are N.

usage: python3 tests/count_solids.py file.stl N

Triangles that share a vertex belong to the same solid. OpenSCAD merges
touching or overlapping parts into one mesh, so links that fused count
as one solid.
"""

import struct
import sys


def count_solids(path):
    data = open(path, "rb").read()
    (n,) = struct.unpack_from("<I", data, 80)
    parent = {}

    def find(v):
        while parent[v] != v:
            parent[v] = parent[parent[v]]
            v = parent[v]
        return v

    for i in range(n):
        v = struct.unpack_from("<9f", data, 84 + i * 50 + 12)
        corners = [v[0:3], v[3:6], v[6:9]]
        for c in corners:
            parent.setdefault(c, c)
        root = find(corners[0])
        for c in corners[1:]:
            parent[find(c)] = root
    return len({find(v) for v in parent})


path, expected = sys.argv[1], int(sys.argv[2])
found = count_solids(path)
print(f"{path}: {found} solids, expected {expected}")
sys.exit(0 if found == expected else 1)
