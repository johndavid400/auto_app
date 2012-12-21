class Image < ActiveRecord::Base
  attr_accessible :description, :link, :trim_id
  belongs_to :trim
end
