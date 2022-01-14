---
layout: default
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

Cool! Now let's define addition inductively:

```agda
_+_ : ℕ → ℕ → ℕ
zero + n = n
(suc m) + n = suc (m + n)
```

Note that `ℕ`, `zero` and `suc` are hyperlinked to their definition above.

As our last trick, let's import some tools for equational reasoning and check that `2 + 2` is indeed `4`.

```agda
import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; _∎)

{-# BUILTIN NATURAL ℕ #-}

_ : 2 + 2 ≡ 4
_ = begin
  2 + 2                                 ≡⟨⟩
  (suc (suc zero)) + (suc (suc zero))   ≡⟨⟩
  suc ((suc zero) + (suc (suc zero)))   ≡⟨⟩
  suc (suc (zero + (suc (suc zero))))   ≡⟨⟩
  suc (suc (suc (suc zero)))            ≡⟨⟩
  4                                     ∎
```

Note that all imported modules, keywords and operators are hyperlinked to their definition in the standard library.
Try jumping into the rabbit hole and navigate around it!

This concludes the demonstration.

I hope `jekyll-agda` can help you. ❤️
