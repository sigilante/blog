# %blog

%blog lets you create and serve a simple html website from your ship.

## Features

- Markdown support
- Custom CSS themes
- Drafts
- Serve your %blog from the same domain as your ship with zero config

## Installation

Install %blog with

```
|install ~hanrut-sillet-dachus-tiprel blog
```

## Export

You can export your %blog with `:blog|export` in the dojo. This will create a folder inside your blog desk called `/export`.

To see it, ensure you have mounted the blog desk with `|mount %blog`.

## To-Do

- document generator for %publish `:blog|publish /i/am/a/path 'I am a microblog.'
- fix RSS poke
- fix RSS endpoint (unregistered in Eyre)
