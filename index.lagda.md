---
permalink: /
---

**Welcome!**

`jekyll-agda` is a [Jekyll][jekyll-url] plugin to write websites using [literate Agda][lagda-url].

This is a demo page; for more information please refer to the [documentation][jekyll-agda-doc-url].

[jekyll-url]: https://jekyllrb.com/
[lagda-url]: https://agda.readthedocs.io/en/latest/tools/literate-programming.html#literate-markdown
[jekyll-agda-doc-url]: https://github.com/paolobrasolin/jekyll-agda#readme

Let's define Peano's natural numbers:

```agda
data ℕ : Set where
  zero : ℕ
  suc : ℕ → ℕ
```

Is `Set` clickable? Yes it is.
And the other keywords too!
