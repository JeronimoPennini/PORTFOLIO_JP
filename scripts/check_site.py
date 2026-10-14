"""Comprobar referencias locales, idioma y cambios críticos del HTML publicado."""
from pathlib import Path
from html.parser import HTMLParser
from urllib.parse import urlsplit, unquote

ROOT = Path(__file__).resolve().parents[1] / 'docs'

class Page(HTMLParser):
    def __init__(self):
        super().__init__()
        self.refs = []
        self.lang = None
    def handle_starttag(self, tag, attrs):
        a = dict(attrs)
        if tag == 'html':
            self.lang = a.get('lang')
        if tag in ('a', 'link', 'img', 'script'):
            value = a.get('href' if tag in ('a', 'link') else 'src', '')
            if value and not urlsplit(value).scheme and not value.startswith(('#', '//')):
                self.refs.append(value)

errors = []
for path in ROOT.rglob('*.html'):
    page = Page()
    page.feed(path.read_text(encoding='utf-8'))
    if page.lang != 'es':
        errors.append(f'{path}: idioma {page.lang}')
    for ref in page.refs:
        rel = unquote(urlsplit(ref).path)
        if not rel:
            continue
        target = ROOT / rel.lstrip('/') if rel.startswith('/') else path.parent / rel
        if not target.exists():
            errors.append(f'{path}: referencia inexistente {ref}')
dih = (ROOT / 'posts/salud-mental-dih/index.html').read_text(encoding='utf-8')
if 'Hitos del primer DIH' in dih or 'p_tl &lt;-' in dih:
    errors.append('DIH: todavía está la sección de hitos')
if errors:
    raise SystemExit('\n'.join(errors))
print('HTML: referencias locales, idioma y eliminación de hitos correctos.')
