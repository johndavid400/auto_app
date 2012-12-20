class Model < ActiveRecord::Base
  attr_accessible :name

  belongs_to :make
  has_many :trims
end
