"""Maintain the generated plate-preview section of a GitHub release body."""

import json
import os
import subprocess
from urllib.parse import quote

START = '<!-- cad-plate-previews:start -->'
END = '<!-- cad-plate-previews:end -->'


def update_body(body: str, repository: str, tag: str) -> str:
    """Replace our section or append it, preserving all other release notes."""
    if body.count(START) != body.count(END) or body.count(START) > 1:
        raise ValueError('Malformed or repeated CAD plate preview markers')
    base = f'https://github.com/{repository}/releases/download/{quote(tag, safe="")}'
    block = '\n'.join((
        START,
        '<details>',
        '<summary>CAD print plate previews</summary>',
        '',
        f'![PETG plate preview]({base}/PETG.png)',
        '',
        f'![TPU plate preview]({base}/TPU.png)',
        '',
        '</details>',
        END,
    ))
    if START in body:
        start = body.index(START)
        end = body.index(END)
        if end < start:
            raise ValueError('CAD plate preview markers are out of order')
        return body[:start] + block + body[end + len(END):]
    separator = '' if not body else ('\n' if body.endswith('\n') else '\n\n')
    return body + separator + block + '\n'


def main() -> None:
    repository = os.environ['GH_REPO']
    tag = os.environ['RELEASE_TAG']
    endpoint = f'repos/{repository}/releases/tags/{quote(tag, safe="")}'
    result = subprocess.run(['gh', 'api', endpoint], check=True, capture_output=True, text=True)
    release = json.loads(result.stdout)
    body = update_body(release.get('body') or '', repository, tag)
    if body != (release.get('body') or ''):
        subprocess.run(
            ['gh', 'api', '--method', 'PATCH', f'repos/{repository}/releases/{release["id"]}', '--input', '-'],
            input=json.dumps({'body': body}), text=True, check=True,
        )


if __name__ == '__main__':
    main()
