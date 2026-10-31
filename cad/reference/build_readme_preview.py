"""Render the repository README's headings, paragraphs, links and images for local review."""
from pathlib import Path
import re,html
root=Path(__file__).resolve().parents[2]
s=(root/'README.md').read_text()
def inline(t):
 t=html.escape(t)
 t=re.sub(r'!\[([^]]*)\]\(cad/([^)]*)\)',r'<img alt="\1" src="\2">',t)
 t=re.sub(r'\[([^]]*)\]\(cad/([^)]*)\)',r'<a href="\2">\1</a>',t)
 return re.sub(r'\*\*(.*?)\*\*',r'<strong>\1</strong>',t)
blocks=[]
for b in s.split('\n\n'):
 if b.startswith('## '):blocks.append('<h2>'+inline(b[3:])+'</h2>')
 elif b.startswith('# '):blocks.append('<h1>'+inline(b[2:])+'</h1>')
 else:blocks.append('<p>'+inline(b)+'</p>')
(root/'cad/readme-review.html').write_text('<!doctype html><meta charset="utf-8"><title>README.md · V3 review</title><style>body{max-width:1100px;margin:40px auto;padding:0 32px;font:17px/1.65 system-ui;color:#243138;background:white}h1{font-size:36px}h2{margin-top:40px}img{width:100%;display:block;border-radius:8px}a{color:#007a88}</style><article>'+''.join(blocks)+'</article>')
