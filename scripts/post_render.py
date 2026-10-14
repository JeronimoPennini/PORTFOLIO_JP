from pathlib import Path
import re
from urllib.parse import urlsplit

# GitHub Pages debe servir los widgets y directorios tal como los genera Quarto.
root = Path(__file__).resolve().parents[1]


def normalize_local_url(match):
    prefix, quote, value = match.groups()
    if not urlsplit(value).scheme and not value.startswith('//'):
        value = value.replace('\\', '/')
    return f'{prefix}{quote}{value}{quote}'


# Quarto en Windows puede generar rutas locales con separadores de archivos.
# En el HTML publicado las URL deben usar barras, también al servir en Linux.
for path in (root / 'docs').rglob('*.html'):
    html = path.read_text(encoding='utf-8')
    normalized = re.sub(
        r'(\b(?:src|href)\s*=\s*)([\x22\x27])(.*?)\2',
        normalize_local_url,
        html,
        flags=re.IGNORECASE,
    )
    if normalized != html:
        path.write_text(normalized, encoding='utf-8')

(root / 'docs' / '.nojekyll').touch()
