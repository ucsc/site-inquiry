# Inquiry @ UC Santa Cruz - AI Coding Instructions

## Project Overview

This is a Jekyll-based static site for UC Santa Cruz's annual research magazine "Inquiry," published since 2015. Content is organized by academic year (e.g., 2022-23) with articles, briefs, and contributor information.

## Architecture

### Content Organization

- **Source**: All editable content lives in `source/`
- **Build**: Generated HTML outputs to `build/` (do not edit directly)
- **Articles**: Stored as markdown in `source/_articles/{YEAR}/` with nested `sidebars/` subdirectories
- **Collections**: Jekyll collection `_articles` configured in `_config.yml` with `output: true`

### Year-Based Structure

Each academic year (2015-16, 2016-17, etc.) follows this pattern:

- Main article files: `source/_articles/{YEAR}/*.md`
- Sidebars: `source/_articles/{YEAR}/sidebars/*.html`
- Special pages: `welcome.md`, `briefs.md`, `books.md`, `contributors.md`

### Data Files (`source/_data/`)

- `contributors.yml`: Author profiles with fields: `first`, `last`, `program`, `year`, `file`, `url`
- `issues.yml`: List of all published issues with display names and URLs

## Development Workflow

### Local Development

```bash
docker-compose up
```

This starts Jekyll with live reload at:

- Site: http://localhost:4000
- LiveReload: port 35729

The Docker setup uses Jekyll 3.8.6 and auto-installs Bundler 2.4.22.

### Testing

```bash
rake test
```

Runs Jekyll build + HTMLProofer (internal links only) + scss-lint.

### Deployment

The site automatically deploys to Netlify when changes are pushed or merged into the `master` branch. No manual deployment steps required.

## Article Front Matter Structure

Articles must include this YAML front matter:

```yaml
layout: post
issue: "2022" # String, not number
category: feature # or "brief", "credits"
order: 1 # Controls display order within issue
title: Article Title
subhead: "Optional subtitle"
author-last: LastName # Matches contributors.yml
banner:
  file: 2022/image.jpg # Relative to assets
  position: left # or omit
further-inquiry: # Optional related links
  - title: "Link text"
    url: https://example.com
in-the-news: # Optional news links
  - title: "News title"
    url: https://example.com
```

**Critical**: `issue` must be a string (quoted), `category` determines article type.

## Asset Handling

Jekyll Assets plugin processes images with ImageMagick transforms:

```liquid
{% asset '2022/image.jpg' @magick:resize=600 alt:'Description' %}
{% asset "{{ page.banner.file }}" @magick:gravity=east @magick:crop=1400x500+0+0 %}
```

Assets go in `source/_assets/` with subdirectories `css/`, `images/`, `js/`.

## Liquid Template Patterns

### Including Sidebars

Articles use relative includes:

```liquid
{% include_relative sidebars/sidebar-file.html classes="right" bgcolor="#f1f1f1" %}
```

### Filtering Articles by Year

```liquid
{% assign sorted_articles = site.articles | where: 'issue','2022' | sort: 'order' %}
{% for post in sorted_articles %}
  {% if post.category == 'feature' %}
    <!-- render feature article -->
  {% endif %}
{% endfor %}
```

### Looking Up Contributors

```liquid
{% assign contrib = site.data.contributors | where:"last", post.author-last | first %}
{{ contrib.first }} {{ contrib.last }}
```

## Conventions

### File Naming

- Articles: lowercase with hyphens (`down-on-the-farm.md`)
- Sidebars: match article name + descriptive suffix (`down-on-the-farm-hero-caption.html`)
- Images: year prefix in path (`2022/down-on-the-farm-banner.jpg`)

### Layouts

- `post.html`: Individual articles (includes breadcrumbs, banner, related links)
- `brief.html`: Short research updates
- `page.html`: Static pages (contact, archives)
- `default.html`: Base template with header/footer

### URL Structure

Permalink pattern: `/:year/:title/` (set in `_config.yml`)
Example: `/2022-23/down-on-the-farm/`

## Common Tasks

### Adding a New Issue

1. Create `source/_articles/{YEAR}/` directory
2. Add entry to `source/_data/issues.yml`
3. Update `current:` in `source/index.html`
4. Add issue filter to index page: `where: 'issue','YYYY'`

### Adding a New Article

1. Create markdown file in `source/_articles/{YEAR}/`
2. Add front matter with correct `issue`, `category`, `order`
3. Add author to `contributors.yml` if new
4. Create sidebar HTML in `sidebars/` subdirectory if needed
5. Place banner image in assets

### Modifying Homepage Features

Edit `source/index.html` - update the `where: 'issue','YYYY'` filter to show the correct year's articles.

## Key Dependencies

- Jekyll 3.8.6 with plugins: jekyll-assets, jekyll-seo-tag, jekyll-sitemap
- Bourbon 4.2.7 and Neat 1.8.0 (Sass frameworks)
- jekyll-lunr-js-search for site search
- html-proofer for link validation
