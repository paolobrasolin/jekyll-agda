# jekyll-agda

[![CI tests status badge][build-shield]][build-url]
[![Latest release badge][rubygems-shield]][rubygems-url]
[![License badge][license-shield]][license-url]
[![Maintainability badge][cc-maintainability-shield]][cc-maintainability-url]
[![Test coverage badge][cc-coverage-shield]][cc-coverage-url]

[build-shield]: https://img.shields.io/github/workflow/status/paolobrasolin/jekyll-agda/CI/main?label=tests&logo=github
[build-url]: https://github.com/paolobrasolin/jekyll-agda/actions/workflows/main.yml "CI tests status"
[rubygems-shield]: https://img.shields.io/gem/v/jekyll-agda?logo=ruby
[rubygems-url]: https://rubygems.org/gems/jekyll-agda "Latest release"
[license-shield]: https://img.shields.io/github/license/paolobrasolin/jekyll-agda
[license-url]: https://github.com/paolobrasolin/jekyll-agda/blob/main/LICENSE "License"
[cc-maintainability-shield]: https://img.shields.io/codeclimate/maintainability/paolobrasolin/jekyll-agda?logo=codeclimate
[cc-maintainability-url]: https://codeclimate.com/github/paolobrasolin/jekyll-agda "Maintainability"
[cc-coverage-shield]: https://img.shields.io/codeclimate/coverage/paolobrasolin/jekyll-agda?logo=codeclimate&label=test%20coverage
[cc-coverage-url]: https://codeclimate.com/github/paolobrasolin/jekyll-agda/coverage "Test coverage"

`jekyll-agda` is a [Jekyll][jekyll-url] plugin which allows you to use [literate Agda][lagda-url] for your website and take full advantage of its highlighting and hyperlinking features.

## Getting started

Assuming you have a working [Agda][agda-url] installation and a [Jekyll][jekyll-url] website already set up, you need to do just four things.

1.  Add the `jekyll-agda` gem to your plugins in the `Gemfile` and run `bundle` to install it:

    ```ruby
    # Gemfile
    group :jekyll_plugins do
        gem "jekyll-agda"
    end
    ```

2.  Add Agda interface files to Jekyll's list of exclusions in `_config.yml`:

    ```yaml
    # _config.yml
    exclude:
      - "*.agdai"
    ```

3.  Add Agda interface files and `jekyll-agda`'s work dir to your `.gitignore`:

    ```ini
    # .gitignore
    *.agdai
    .agda-html/
    ```

4.  Add Agda's default stylesheet (which `jekyll-agda` will produce) to the `<head>` of your layout:

    ```html
    <link rel="stylesheet" href="{{ '/lagda/Agda.css' | relative_url }}" />
    ```

That's it!
You can now write your posts and pages using [literate Agda][lagda-url].

Here is a sample post you can save as `_posts/2021-01-13-foobar.lagda.md` to get started:

````
---
title: My first literate Agda post
---

Let's define Peano's natural numbers:

```agda
data ℕ : Set where
  zero : ℕ
  suc : ℕ → ℕ
```

Is `Set` clickable? Yes it is.
And the other keywords too!
````

## Usage

Right now this plugin is an [MVP][mvp-url] and accepts no configuration, so [Getting started](#getting-started) covers pretty much everything about its usage.

The only caveat is: **write your code in unnamed independent modules** to be totally safe.
Otherwise, Agda and Jekyll naming conventions _might_ be at odds.
You can definitely try do more complex stuff though!
I simply haven't given this enough thought yet to clearly spell out the details (see last point of the [Roadmap](#roadmap)).

## Roadmap

Here is a roadmap of features I think would be useful.

- Custom output path/url instead of hardcoded `/lagda`
- Custom stylesheet instead of Agda's default `Agda.css`
- Custom layout for `/lagda/*` pages (leveraging `--html-highlight=code` instead of `--html-highlight=auto`)
- Find some convenient way to knit Agda and Jekyll naming conventions:
  - Currently all pages are compiled as independent "root" files, so Agda is not affected by Jekyll's conventions as long as you don't define a `module` in your files
  - Structuring code in multiple files/modules is doable but will require some clever dependency management to avoid redundant compilations
  - Ideally, we'd like complete freedom in structuring code to do stuff like multiple pages corresponding to modules, or a series of posts in which later ones import the previous ones

Of course any feedback is welcome!

## Acknowledgements

- Thanks to [@conal](https://github.com/conal) for [prompting me with the idea](https://twitter.com/conal/status/1479884896864591874).

[jekyll-url]: https://jekyllrb.com/
[agda-url]: https://github.com/agda/agda
[lagda-url]: https://agda.readthedocs.io/en/latest/tools/literate-programming.html#literate-markdown
[mvp-url]: https://en.wikipedia.org/wiki/Minimum_viable_product
