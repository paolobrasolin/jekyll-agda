require "jekyll"

require "jekyll/agda/runner"
require "jekyll/agda/browsable_page"

module Jekyll
  module Agda
    class Weaver
      WORK_DIR = ".agda-html"
      OUTPUT_ROOT = "lagda"

      RE_AGDA_GENERATED_PRE = %r{<pre class="Agda">.*?</pre>}m
      RE_HREF_VALUE = /(?<=href=")(?<page>.*?.html)(?<anchor>#\d+)?(?=")/

      def self.normalize_hrefs(content, internal_page, external_root)
        content.gsub(RE_HREF_VALUE) do
          if Regexp.last_match[:page] == internal_page
            Regexp.last_match[:anchor].to_s
          else
            "#{external_root}/#{Regexp.last_match}"
          end
        end
      end

      def self.strip_frontmatter(input)
        # stolen from https://github.com/jekyll/jekyll/blob/e3cbe584f2a78141bf7f53cfef8cf237b3f4c201/lib/jekyll/document.rb#L483-L490
        input =~ Jekyll::Document::YAML_FRONT_MATTER_REGEXP
        Regexp.last_match&.post_match || input
      end

      def initialize(site)
        @site = site
        @resources = [*@site.pages, *@site.documents]
        @dependencies_list = []
        @dependencies_root = "#{@site.baseurl}/#{OUTPUT_ROOT}"
      end

      def execute
        elaborate_resources
        @dependencies_list.uniq!
        elaborate_dependencies
        elaborate_extra_dependency("Agda.css")
      end

      private

      def elaborate_resources
        @resources.each do |resource|
          next unless resource.path.match?(Jekyll::Agda::Runner::RE_LAGDA_MD_EXT)

          runner = Runner.new(resource, WORK_DIR)
          next unless runner.tap(&:execute).successful

          resource.content = elaborate_target(runner.target, @dependencies_root)
          @dependencies_list.concat(runner.dependencies)
        end
      end

      def elaborate_target(pathname, dependencies_root)
        content = pathname.read
        content = self.class.strip_frontmatter(content)
        itself = pathname.basename.sub_ext(".html").to_s
        content.gsub!(RE_AGDA_GENERATED_PRE) do |pre|
          self.class.normalize_hrefs(pre, itself, dependencies_root)
        end
      end

      def elaborate_dependencies
        @dependencies_list.each do |dependency|
          name = Pathname.new(dependency).basename.to_s
          page = BrowsablePage.new(@site, @site.source, WORK_DIR, name)
          @site.pages << page
        end
      end

      def elaborate_extra_dependency(name)
        return unless Pathname.new(WORK_DIR).join(name).exists?
        @site.pages << BrowsablePage.new(@site, @site.source, WORK_DIR, name)
      end
    end
  end
end
