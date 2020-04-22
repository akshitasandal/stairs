require 'uri'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :invite_for => 2.weeks
  before_create :create_username
  before_create :default_values
  attr_accessor :current_password
  has_attached_file :avatar, styles: { medium: "235x200>", thumb: "130x120>", small: "50X45>"}, default_url: "missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  belongs_to :company
  has_many :albums , :dependent => :destroy
  has_many :views ,  :dependent => :destroy
  has_many :company_followers , :dependent => :destroy
  has_many :user_followers
  has_many :blog_posts 
  has_many :user_notification_preferences 
  validates :email, presence: true,  :uniqueness => true
  # has_many :roles
  #add default values
  def default_values
    self.status ||= '1'
    self.verified ||='1'
    self.role_id ||= '4'
  end
  
  # Method to use username instead of id in url
  def to_param
    username
  end

  # Method to create username via email
  def create_username
    user = self.email.split("@").first.gsub(/[^0-9A-Za-z]/, '-')
    user_count = User.where(:username => user).count
    if user_count > 0
      max_id = User.maximum("id")+1
      self.username = user+ max_id.to_s
    else
      self.username = user
    end
  end

  #Create a user by Provider i.e Facebook ,Twitter, Linkedin etc.
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      if auth.info.email.present?
        user.email = auth.info.email
      else
        user.email = auth.info.name + "@"+ auth.provider+ ".com"
      end
      user.first_name = auth.info.name
      user.last_name = auth.info.name
    end
  end

  #create session of Provider @Github
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  #create session of Provider @LinkedIn
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.linkedin_data"] && session["devise.linkedin_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
