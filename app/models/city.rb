class City < ActiveRecord::Base
  has_many :companies,:dependent => :destroy
  belongs_to :company
end
