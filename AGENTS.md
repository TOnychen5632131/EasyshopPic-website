# Repository Guidelines

## Project Structure & Assets
- Root subfolders are product categories: `戒指/`, `食物/`, `香薰/`, `帆布包/`, `穿戴甲/`.
- Each folder contains raw (`.HEIC`, `.jpeg`) and edited (`.png`, `.jpg`) images.
- Keep related variants together; prefer smaller, web-ready versions alongside originals.

## File Naming & Formats
- Use kebab-case, short, descriptive names: `ring-gold-oval-01.jpg`.
- Suffix for process/scale when needed: `image_upscayl_2x.png`, `-edited`, `-thumb`.
- Prefer `.jpg` for photos, `.png` for transparency, keep `.heic` only as source.

## Image Quality & Optimization
- Target long edge ≤ 2048px for web previews; keep a source copy if larger.
- Strip metadata from distributable images; retain EXIF only in raw sources.
- Recommended commands:
  - Strip + compress JPEGs: `magick mogrify -strip -quality 85 *.jpg`
  - Resize if larger than 2048px: `magick mogrify -resize "2048x2048>" *.jpg`
  - Remove EXIF: `exiftool -all= *.jpg`

## Validation Commands
- List oversized files: `find . -type f -size +15M -print`.
- Check image dimensions: `sips -g pixelWidth -g pixelHeight path/to/image.jpg`.
- Find duplicates by name: `rg -n "^(.+)-(\\d+)\\.(jpg|png)$"`.
- Optional LFS for large binaries: `git lfs track "*.jpg" "*.png" "*.heic"`.

## Contribution Workflow
- Add images to the correct category folder; avoid root-level files.
- Keep edits non-destructive: preserve the original, add an optimized copy.
- Include a brief README note in a folder if adding a new subcategory.

## Commit & Pull Request Guidelines
- Commit messages: type(scope): summary — e.g., `feat(戒指): add 2 gold ring shots`.
- PRs should include:
  - Summary of changes and counts (e.g., “+6 images, -2 oversized”).
  - Any processing steps used (resize, compression, upscaling).
  - Before/after size notes if optimization was performed.

## Security & Metadata
- Do not commit sensitive EXIF/GPS data in distributable images.
- Verify licenses for any third-party assets before inclusion.
