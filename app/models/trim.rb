class Trim < ActiveRecord::Base
  attr_accessible :name

  belongs_to :model

end
