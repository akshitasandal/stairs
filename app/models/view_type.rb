class ViewType < ActiveRecord::Base
  has_many :views , :dependent => :destroy
end
