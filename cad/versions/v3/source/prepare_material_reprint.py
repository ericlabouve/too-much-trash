"""Preserve a reviewed layout and reslice with a fully resolved official filament preset."""
import argparse
import hashlib
import json
import shutil
from pathlib import Path

def main():
    p = argparse.ArgumentParser()
    p.add_argument('source', type=Path)
    p.add_argument('destination', type=Path)
    p.add_argument('--preset', required=True)
    p.add_argument('--colour', required=True)
    a = p.parse_args()
    root = Path('/Applications/BambuStudio.app/Contents/Resources/profiles/BBL')
    index = {}
    for path in root.rglob('*.json'):
        data = json.loads(path.read_text())
        if 'name' in data:
            index[data['name']] = (data, path)
    provenance = []
    def resolve(name):
        data, path = index[name]
        data = data.copy()
        parent = data.pop('inherits', None)
        result = resolve(parent) if parent else {}
        result.update(data)
        provenance.append({'name': name, 'source': str(path),
                           'sha256': hashlib.sha256(path.read_bytes()).hexdigest()})
        return result
    filament = resolve(a.preset)
    filament['filament_colour'] = [a.colour]
    a.destination.mkdir(parents=True, exist_ok=False)
    for name in ('actuator-input.3mf', 'machine.json', 'process.json'):
        shutil.copy2(a.source / name, a.destination / name)
    inputs = json.loads((a.source / 'inputs.json').read_text())
    inputs.update(material_status=a.preset, profile_source=provenance,
                  reprint_source=str(a.source),
                  unchanged_layout_sha256=hashlib.sha256((a.source / 'actuator-input.3mf').read_bytes()).hexdigest())
    for name, data in [('filament.json', filament), ('inputs.json', inputs)]:
        (a.destination / name).write_text(json.dumps(data, indent=2) + '\n')
    print(a.destination)

if __name__ == '__main__':
    main()
