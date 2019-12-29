# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.devol.io"

SitemapGenerator::Sitemap.create do
  add "/discuss", :priority => 0.8
end
