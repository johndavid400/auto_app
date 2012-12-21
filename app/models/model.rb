class Model < ActiveRecord::Base
  attr_accessible :name, :edmunds_id

  belongs_to :make
  has_many :trims
end
