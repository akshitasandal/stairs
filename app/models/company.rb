require 'uri'
class Company < ActiveRecord::Base
  has_attached_file :logo, styles: { medium: "235x200>", thumb: "130x120>", small: "50X45>"}, default_url: "missing.png"
  has_attached_file :cover_photo, styles: { medium: "1280x960>", thumb: "828x315>", small: "235x200>"}, default_url: "cover_dummy.jpg"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
  has_many :albums , :dependent => :destroy
  has_many :testimonials, -> {where deleted: 0}, :dependent => :destroy
  before_create :default_values
  has_many :users
  before_create :make_slug
  belongs_to :company_size_group
  belongs_to :city
  belongs_to :functional_area
  has_many :blog_posts
  has_many :company_followers
  has_many :user_followers
  has_many :views, :foreign_key => :object_id,:dependent => :destroy
  validates :website, presence: true,  :uniqueness => true
  # validates :primary_email, :uniqueness => true
  
  #add By default value
  def default_values
    self.status ||= '1'
    self.verified ||= "1"
  end

  # Helper method to generate slugs for companies
  def strip_url(target_url)
    target_url.to_s.downcase.gsub("http://", "")
    .to_s.downcase.gsub("https://", "")
    .to_s.downcase.gsub("www.", "")
  end

  # method to generate slugs for companies
  def make_slug
    self.slug = strip_url(self.website).split(".").first
  end

  # Method to use slug instead of id
  def to_param
    slug
  end

  #  search company
  def self.search_company( args )
    keys = []
    values = []
    params = args[:params]
    order = args[:order]

    params.each do |k , v|
      if v.present?
        key = (k == "name") ? "#{k} like (?)" : "#{k} IN (?)"
        keys.push(key)
        value = (v == "name") ? "%#{v}%" : v
        values.push(value)
      end
    end
    conditions = values
    conditions.unshift(keys.join(" and "))
    if order == "new_added"
      self.where(conditions).order("created_at DESC").where("status" => 1)
    else
      sql = self.joins(:views).select("companies.*, count(views.id) as view_count").where(conditions).where("views.view_type_id" => 2, "status" => 1).group('views.object_id').order("count(views.id) desc")
#      abort(sql.length.inspect)
    end
  end

   #Recent add Company
   def self.recent_add
     self.all.order("created_at DESC LIMIT 6").where("status" => 1)
   end

   #show most viewd company
   def self.most_view
      self.joins(:views).select("companies.*, count(views.id) as view_count").where("views.view_type_id" => 2, "status" => 1).group("views.object_id").order("count(views.id) desc LIMIT 6")
   end

   def self.search(params)
    scope = all
    scope.where!(functional_area_id: params[:category]) if params[:category]
    scope.where!(city_id: params[:location]) if params[:location]
    scope.recent_add
    scope.most_view
    scope.all

    # ...
  end

end
