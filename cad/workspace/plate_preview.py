"""Render a top view of the geometry and placements embedded in a core 3MF."""
from collections import Counter
from pathlib import Path
import xml.etree.ElementTree as ET
import zipfile

import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt
from matplotlib.collections import PolyCollection
from matplotlib.patches import Rectangle
import numpy as np

CORE = 'http://schemas.microsoft.com/3dmanufacturing/core/2015/02'
Q = lambda name: f'{{{CORE}}}{name}'


def render_preview(project_path, png_path, material):
    """Read the exported project (including its build transforms), render, and return counts."""
    if material not in ('PETG', 'TPU'):
        raise ValueError(f'unsupported preview material: {material}')
    with zipfile.ZipFile(project_path) as archive:
        root = ET.fromstring(archive.read('3D/3dmodel.model'))
    if root.tag != Q('model') or root.get('unit', 'millimeter') != 'millimeter':
        raise ValueError('preview requires a millimetre core 3MF model')
    resources = root.find(Q('resources'))
    build = root.find(Q('build'))
    if resources is None or build is None:
        raise ValueError('missing 3MF resources or build')
    objects = {}
    for obj in resources.findall(Q('object')):
        ident, name = obj.get('id'), obj.get('name')
        mesh = obj.find(Q('mesh'))
        if not ident or not name or ident in objects or mesh is None:
            raise ValueError('invalid or unsupported 3MF object')
        vertices = mesh.find(Q('vertices'))
        triangles = mesh.find(Q('triangles'))
        if vertices is None or triangles is None:
            raise ValueError('missing mesh geometry')
        verts = np.array([[float(v.attrib[a]) for a in ('x', 'y', 'z')]
                          for v in vertices.findall(Q('vertex'))], dtype=float)
        faces = np.array([[int(t.attrib[a]) for a in ('v1', 'v2', 'v3')]
                          for t in triangles.findall(Q('triangle'))], dtype=int)
        if (verts.ndim != 2 or verts.shape[1:] != (3,) or not np.isfinite(verts).all()
                or faces.ndim != 2 or faces.shape[1:] != (3,) or faces.min() < 0
                or faces.max() >= len(verts)):
            raise ValueError(f'invalid mesh for {name}')
        objects[ident] = (name, verts, faces)
    counts = Counter()
    polygons, heights, colors = [], [], []
    base = np.array((0.91, 0.39, 0.10) if material == 'PETG' else (0.05, 0.65, 0.72))
    for item in build.findall(Q('item')):
        ident = item.get('objectid')
        if ident not in objects:
            raise ValueError(f'unknown build object {ident}')
        transform = np.array([float(x) for x in item.get('transform', '1 0 0 0 1 0 0 0 1 0 0 0').split()])
        if transform.shape != (12,) or not np.isfinite(transform).all():
            raise ValueError('invalid 3MF build transform')
        name, verts, faces = objects[ident]
        # Core 3MF specifies row-vector order: first three rows are linear,
        # followed by the translation row.
        xyz = verts @ transform[:9].reshape(3, 3) + transform[9:]
        if not np.isfinite(xyz).all() or np.any(xyz[:, :2] < -0.001) or np.any(xyz[:, :2] > 180.001):
            raise ValueError(f'{name} outside preview bed')
        tris = xyz[faces]
        normals = np.cross(tris[:, 1] - tris[:, 0], tris[:, 2] - tris[:, 0])
        lengths = np.linalg.norm(normals, axis=1)
        keep = (np.abs(normals[:, 2]) > 1e-9) & (lengths > 1e-12)
        tris, normals, lengths = tris[keep], normals[keep], lengths[keep]
        light = np.array([-.35, -.45, .82]); light /= np.linalg.norm(light)
        intensity = .68 + .32 * np.abs((normals @ light) / lengths)
        polygons.append(tris[:, :, :2])
        heights.append(tris[:, :, 2].mean(axis=1))
        colors.append(np.clip(intensity[:, None] * base, 0, 1))
        counts[name] += 1
    if not counts:
        raise ValueError('empty 3MF build')
    polygons, heights, colors = np.concatenate(polygons), np.concatenate(heights), np.concatenate(colors)
    order = np.argsort(heights, kind='stable')
    fig = plt.figure(figsize=(10, 8), dpi=100, facecolor='white')
    ax = fig.add_axes([.15, .12, .70, .76])
    ax.add_patch(Rectangle((0, 0), 180, 180, facecolor='#f7f8f9', edgecolor='#7e8990', linewidth=1.4))
    ax.add_collection(PolyCollection(polygons[order], facecolors=colors[order], edgecolors='none', antialiaseds=False))
    ax.set(xlim=(-3, 183), ylim=(-3, 183), aspect='equal')
    ax.axis('off')
    fig.text(.15, .93, f'{material}  ·  {sum(counts.values())} pieces', fontsize=20, weight='bold', color='#26343c')
    fig.text(.15, .895, 'Top view of the exported 3MF  ·  180 × 180 mm bed', fontsize=11, color='#5f6b72')
    fig.text(.15, .055, 'Print orientation and placement shown; slice and inspect before printing.', fontsize=10, color='#5f6b72')
    fig.savefig(Path(png_path), dpi=100, facecolor='white', metadata={'Software': 'Too Much Trash'})
    plt.close(fig)
    return counts
