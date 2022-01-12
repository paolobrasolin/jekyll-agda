require 'jekyll/agda'
require 'jekyll/agda/weaver'

describe Jekyll::Agda::Weaver do
  describe '.strip_frontmatter' do
    it 'removes front matter' do
      expect(Jekyll::Agda::Weaver.strip_frontmatter(<<~INPUT)).to eq(<<~OUTPUT)
        ---
        title: foobar
        ---

        Document contents.
      INPUT
        Document contents.
      OUTPUT
    end

    it 'does nothing if there is no frontmatter' do
      expect(Jekyll::Agda::Weaver.strip_frontmatter(<<~INPUT)).to eq(<<~OUTPUT)
        Document contents.
      INPUT
        Document contents.
      OUTPUT
    end
  end

  describe '.normalize_hrefs' do
    it 'strips page from internal hrefs' do
      expect(Jekyll::Agda::Weaver.normalize_hrefs(<<~INPUT, "this.html", "root")).to eq(<<~OUTPUT)
        <a id="123" href="this.html" class="Baz">ϕ</a>
        <a id="123" href="this.html#456" class="Baz">ϕ</a>
      INPUT
        <a id="123" href="" class="Baz">ϕ</a>
        <a id="123" href="#456" class="Baz">ϕ</a>
      OUTPUT
    end

    it 'adds root to external hrefs' do
      expect(Jekyll::Agda::Weaver.normalize_hrefs(<<~INPUT, "this.html", "root")).to eq(<<~OUTPUT)
        <a id="123" href="Foo.Bar.html" class="Baz">ϕ</a>
        <a id="123" href="Foo.Bar.html#456" class="Baz">ϕ</a>
      INPUT
        <a id="123" href="root/Foo.Bar.html" class="Baz">ϕ</a>
        <a id="123" href="root/Foo.Bar.html#456" class="Baz">ϕ</a>
      OUTPUT
    end
  end
end
