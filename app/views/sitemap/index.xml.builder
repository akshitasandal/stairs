xml.instruct!
xml.urlset(
  'xmlns'.to_sym => "http://www.sitemaps.org/schemas/sitemap/0.9"
) do

# User profile pages  
  @users.each do |user|
    if user.username.present? && user.company.present?
      xml.url do
        xml.loc "#{root_url}#{user.company.slug}/#{user.username}"
        xml.changefreq("daily")
        xml.priority "0.8"
      end
    end
  end

   # Blog Post Pages
   @posts.each do |post|
    if post.company.present? && post.user.present?
      xml.url do
        xml.loc "#{root_url}#{post.company.slug}/#{post.user.username}/#{post.slug}"
        xml.changefreq("daily")
        xml.priority "0.8"
      end
    end
  end

  # Company pages
   @companies.each do |company|
    if company.present?
      xml.url do
        xml.loc "#{root_url}#{company.slug}"
        xml.changefreq("daily")
        xml.priority "0.8"
      end
    end
  end
 end