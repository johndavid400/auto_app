class Image < ActiveRecord::Base
  attr_accessible :description, :link, :trim_id, :model_id
  belongs_to :trim
  belongs_to :model
end
