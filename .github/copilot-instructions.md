# Inquiry @ UC Santa Cruz - AI Agent Instructions

## Project Overview

This is a Jekyll-based static site for UC Santa Cruz's annual research magazine (Inquiry), organized by academic year (2015-16, 2016-17, etc.). Built with Ruby/Jekyll 3.8, served via Netlify, with Docker for local development.

## Architecture

### Directory Structure

- `source/` - All source content (Jekyll processes this → `build/`)
  - `_articles/YYYY-YY/` - Markdown articles organized by academic year
  - `_layouts/` - Templates: `default.html`, `post.html`, `brief.html`, `page.html`
  - `_includes/` - Reusable components (header, footer, breadcrumbs, social-sharing, etc.)
  - `_data/` - YAML data: `issues.yml`, `contributors.yml`
  - `_assets/` - Stylesheets, images, JavaScript (processed by jekyll-assets)
  - `YYYY-YY/` - Year-specific index pages
- `build/` - Generated output (gitignored, deployed to Netlify)

### Content Types

Articles use 3 layouts based on frontmatter:

- **`layout: post`** - Full feature articles with author, banner, subhead, related links
- **`layout: brief`** - Short research briefs with color tags
- **`layout: page`** - Static pages (welcome, contributors, books)

## Key Conventions

### Article Frontmatter Pattern

```yaml
---
layout: post # or brief, page
issue: 2021 # Year (not academic year string)
category: feature # or brief, welcome, books
order: 5 # Display order within issue
title: "Article Title"
subhead: "Optional subtitle"
author:
  name: "Author Name"
  file: "2021/author-photo.jpg"
banner:
  file: 2021/banner-image.jpg
  position: left # or right, center
related:
  - title: "Link text"
    url: https://example.com
---
```

### Jekyll Liquid Patterns

**Asset inclusion** (uses jekyll-assets plugin with ImageMagick):

```liquid
{% asset 2021/photo.jpg @magick:resize=400 alt:'Description' %}
```

**Sidebar inclusion** (relative to article directory):

```liquid
{% include_relative sidebars/sidebar-name.html classes="right" bgcolor="#f1f1f1" %}
```

**Article filtering** in index pages:

```liquid
{% assign sorted_articles = site.articles | where: 'issue','2021' | sort: 'order' %}
```

### Sidebar Files

Sidebars live in `source/_articles/YYYY-YY/sidebars/*.html` as Liquid templates. They're included via `include_relative` from their parent article. Common pattern:

```html
<aside
  class="{{ include.classes }}"
  style="background-color:{{ include.bgcolor }};"
>
  <figcaption markdown="span">Caption text with [links](url).</figcaption>
</aside>
```

## Development Workflow

### Local Development (Docker - PREFERRED)

```bash
docker-compose up
# Serves on http://localhost:4000 with live reload
# Automatically installs dependencies and runs Jekyll
```

### Manual Build/Test

```bash
bundle install
bundle exec jekyll serve --livereload --incremental  # Dev server
bundle exec jekyll build                             # Production build
bundle exec rake test                                # Run tests (HTMLProofer + scss-lint)
```

### Adding New Content

1. **New article**: Create `source/_articles/YYYY-YY/article-slug.md` with proper frontmatter
2. **New year**:
   - Add entry to `source/_data/issues.yml`
   - Create `source/YYYY-YY/index.html` (copy from previous year, update `current` var)
   - Create `source/_articles/YYYY-YY/` directory
3. **Assets**: Place in `source/_assets/images/YYYY/filename.ext`
4. **Sidebars**: Create in `source/_articles/YYYY-YY/sidebars/name.html`

## Important Details

- **File associations**: VS Code treats `.html` as Liquid (see `.vscode/settings.json`)
- **Indentation**: 2 spaces (enforced by `.editorconfig`)
- **Permalinks**: Format is `/:year/:title/` (from `_config.yml`)
- **Collections**: Articles use `_articles` collection with `output: true`
- **Markdown**: Kramdown with `auto_ids: false`, `parse_block_html: false`
- **CI/CD**: Travis CI runs tests on master branch, deploys to Netlify
- **Image processing**: Uses ImageMagick via `@magick:` directives in asset tags

## Common Tasks

**Find articles by year**: `source/_articles/YYYY-YY/*.md`

**Update contributors**: Edit `source/_data/contributors.yml`

**Change site metadata**: Edit `_config.yml` (requires restart)

**Asset caching**: Delete `.asset-cache/` if images aren't updating

## Testing

```bash
bundle exec rake test  # Runs HTMLProofer (internal links only) + scss-lint
```
