class BlogPost < ActiveRecord::Base
	belongs_to :company
  has_many :blog_posts_post_categories
	has_many :post_categories, :through => :blog_posts_post_categories
	has_many :blog_post_images
  belongs_to :blog
  belongs_to :user
  has_many :views
	has_attached_file :featured_image, styles: { medium: "235x157>", thumb: "130x120>", small: "50X45>"}, default_url: '/assets/missing_:style.png'
	validates_attachment_content_type :featured_image, content_type: /\Aimage\/.*\z/
  before_validation :strip_whitespace
  before_create :create_slug
  # after_save :schedule
  # before_create :schedule
	scope :all_posts, -> {where(deleted: 0, publish: 1)}
	scope :published_posts, -> {where(deleted: 0, publish: 1)}
  scope :private_posts , -> { where(deleted: 0 ,private: 1)}
  # scope :subscribed, ->(company_followers) { where(user_id: company_followers) }
  # validates :slug, :presence => true,  :uniqueness => true

  # after_save :update_slug
  def to_param
    slug
  end

  # method to remove white space between tags
  def strip_whitespace
    self.tags = tags.gsub(/\s+/, '')
    # self.tags = tags.strip
    self.title =  title.strip
    self.description = description.strip
    # self.keywords = keywords.strip
    self.body = body.strip
  end

  # method to create unique slug recursively
  def create_slug
    var_slug = [title.parameterize].join("-")
    self.slug = BlogPost.generate_slug(var_slug)
  end

  #recursive method for generating slug
  def self.generate_slug(var_slug, count = 0)
    created_slug = (count == 0) ? var_slug : var_slug+ "-" +"#{count}"
    new_slug = BlogPost.where(:slug => created_slug).count()
    if (new_slug > 0)
      count =count + 1
      generate_slug(var_slug, count)
    else
      return created_slug
    end
  end

  # def schedule
  #   debugger
  #   if self.publish == false
  #     debugger
  #     SchedulePostJob.perform_later(self)
  #   end
  # end


  #  def publish
  #   unless self.publish == "0"
  #     self.update_attributes(publish: "1")
  #   end
  # end

  
   def self.search(params)
    # scope = all
    # scope.where!(functional_area_id: params[:category]) if params[:category]
    # scope.where!(city_id: params[:location]) if params[:location]
    # scope.recent_add
    # scope.most_view
    # scope.all

    # ...
  end
end
