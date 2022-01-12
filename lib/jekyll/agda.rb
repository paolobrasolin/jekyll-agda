require "jekyll/agda/version"
require "jekyll/agda/weaver"

Jekyll::Hooks.register :site, :post_read do |site|
  Jekyll::Agda::Weaver.new(site).execute
end
