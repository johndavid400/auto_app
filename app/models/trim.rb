class Trim < ActiveRecord::Base
  attr_accessible :name, :style_id, :submodel_id

  belongs_to :model
  has_many :images

end
