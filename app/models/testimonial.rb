class Testimonial < ActiveRecord::Base
  belongs_to :company
  
  #  ApplicationController.helpers.is_super_admin?
  def to_param
    [id, title.parameterize].join("-")
  end
end
