from pathlib import Path

# GitHub Pages debe servir los widgets y directorios tal como los genera Quarto.
root = Path(__file__).resolve().parents[1]
(root / 'docs' / '.nojekyll').touch()
