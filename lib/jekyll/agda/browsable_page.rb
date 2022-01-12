require "jekyll"

module Jekyll
  module Agda
    class BrowsablePage < Jekyll::Page
      def url_placeholders
        {
          path: Jekyll::Agda::Weaver::OUTPUT_ROOT, # instead of @dir
          basename: basename,
          output_ext: output_ext,
        }
      end

      def render_with_liquid?
        false
      end
    end
  end
end
