class Album < ActiveRecord::Base
  
  belongs_to :user 
  belongs_to :company 
  has_many :images , :dependent => :destroy
  has_many :views
  before_create  :default_values  
  validates_uniqueness_of :name
  validates :name, :uniqueness => true
  
  # For deleted field the default is false
  def default_values
    self.deleted ||= '0'
  end
  
  # For slug generation
  def to_param
    [name.parameterize].join("-")
  end
  
  # Method to find by name instead id
  def self.find_by_param(name)
    name = name.gsub("-", " ")
    where("lower(name) = ?", name).first
  end
  
end
